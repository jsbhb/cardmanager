package com.card.manager.factory.applet.service.impl;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import org.apache.commons.codec.binary.Base64;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.card.manager.factory.applet.model.AppletCodeParameter;
import com.card.manager.factory.applet.service.WxAppletCodeService;
import com.card.manager.factory.common.ResourceContants;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.exception.WxCodeException;
import com.card.manager.factory.goods.service.GoodsService;
import com.card.manager.factory.shop.model.ShopEntity;
import com.card.manager.factory.socket.task.SocketClient;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.service.GradeMngService;
import com.card.manager.factory.util.HttpClientUtil;
import com.card.manager.factory.util.ImageUtil;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONObject;

@Service
public class WxAppletCodeServiceImpl implements WxAppletCodeService {

	@Resource
	GradeMngService gradeMngService;

	@Resource
	GoodsService GoodsService;

	@Override
	public String getWxAppletCode(AppletCodeParameter param, boolean needToCoverLogo, StaffEntity opt)
			throws WxCodeException {
		// 拼装url
		String url = assemblingUrl(param);
		// 如果二维码已经存在，直接返回url
		if (codeExist(url)) {
			return url;
		}
		// 获取绝对路径
		WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
		ServletContext servletContext = webApplicationContext.getServletContext();
		String absolutelyPath = servletContext.getRealPath("/");
		// 不存在获取二维码
		String filePath = getCode(param, opt.getToken(), absolutelyPath);
		// 如果需要替换logo
		if (needToCoverLogo) {
			replaceLogo(filePath, param, absolutelyPath, opt);
		}
		// 上传到静态服务器
		uploadToStaticServer(filePath, param);

		return url;
	}

	private void uploadToStaticServer(String filePath, AppletCodeParameter param) {
		SocketClient client = null;
		String remotePath;
		String shopId = getShopIdFromScene(param.getScene());
		if (param.getPage().contains(GOODS_DETAIL_PATH)) {
			remotePath = ResourceContants.RESOURCE_BASE_PATH + "/wechat/appletcode/" + shopId + "/goods";
		} else {
			remotePath = ResourceContants.RESOURCE_BASE_PATH + "/wechat/appletcode/" + shopId;
		}
		try {
			client = new SocketClient();
			client.sendFile(filePath, remotePath);
			client.quit();
			client.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (client != null) {
				try {
					client.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			// 将临时文件删除
			File del = new File(filePath);
			del.delete();
		}
	}

	private String assemblingUrl(AppletCodeParameter param) {
		String page = param.getPage();
		String shopId = getShopIdFromScene(param.getScene());
		if (page.contains(GOODS_DETAIL_PATH)) {
			String goodsId = getGoodsIdFromScene(param.getScene());// 获取goodsId
			return URLUtils.get("static") + "/wechat/appletcode/" + shopId + "/goods/" + goodsId + ".png";
		} else {
			return URLUtils.get("static") + "/wechat/appletcode/" + shopId + "/" + shopId + ".png";
		}
	}

	private boolean codeExist(String url) {
		byte[] result = HttpClientUtil.getByteArr(url);
		if (result == null) {
			return false;
		} else {
			return true;
		}
	}

	private final String GOODS_DETAIL_PATH = "web/goodsDetail/goodsDetail";// 商详路径
	private final String TEMPORARY_PATH = "temporary";// 临时路径

	private void replaceLogo(String filePath, AppletCodeParameter param, String absolutelyPath, StaffEntity opt)
			throws WxCodeException {
		String scene = param.getScene();
		String page = param.getPage();
		boolean netPath = true;
		String logoPath = null;
		if (page.contains(GOODS_DETAIL_PATH)) {// 路径是商详，默认第一张主图作为logo
			String goodsId = getGoodsIdFromScene(scene);
			// 获取需要替换的logo（商品主图）
			List<String> picList = GoodsService.queryGoodsPic(goodsId, opt.getToken());
			if (picList == null) {
				logoPath = absolutelyPath + "img/goodsExtensionLogo.png";
				netPath = false;
//				throw new WxCodeException("1", "没有替换的图片");
			} else {
				logoPath = picList.get(0);
			}
		} else {// 不是商详路径
			// 获取微店配置的头像信息
			ShopEntity shop = gradeMngService.queryByGradeId(opt.getGradeId() + "", opt.getToken());
			if (shop != null) {
				logoPath = shop.getQrcodeLogo();
			}
			if (logoPath == null) {
				logoPath = absolutelyPath + "img/goodsExtensionLogo.png";
				netPath = false;
//				throw new WxCodeException("1", "没有替换的图片");
			}
		}
		// 替换logo默认替换原来的filePath，后缀png
		try {
			ImageUtil.replaceCodeLogo(filePath, logoPath, netPath, absolutelyPath + TEMPORARY_PATH);
		} catch (IOException e) {
			e.printStackTrace();
			throw new WxCodeException("1", "没有替换的图片");
		}
	}

	private String getGoodsIdFromScene(String scene) {
		scene = scene.substring(scene.indexOf("goodsId="));
		String goodsId;
		if (scene.contains("&")) {// 如果还有其他参数
			goodsId = scene.substring(scene.indexOf("goodsId=") + 8, scene.indexOf("&"));
		} else {
			goodsId = scene.substring(scene.indexOf("goodsId=") + 8);
		}
		return goodsId;
	}

	private String getCode(AppletCodeParameter param, String token, String absolutelyPath) throws WxCodeException {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = helper.request(URLUtils.get("gateway") + "/3rdcenter/1.0/getwxacodeunlimit",
				token, true, param, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(result.getBody());

		if (!json.getBoolean("success")) {
			throw new WxCodeException(json.getString("errorCode"), json.getString("errorMsg"));
		}
		String obj = json.getString("obj");
		// 图片字符串需base64解码
		Base64 base = new Base64();
		String imgPath = absolutelyPath + "APPLET_CODE";
		String imgName;
		if(param.getPage().contains(GOODS_DETAIL_PATH)){
			String goodsId = getGoodsIdFromScene(param.getScene());
			imgName = goodsId + ".png";
		} else {
			String shopId = getShopIdFromScene(param.getScene());
			imgName = shopId + ".png";
		}
		// 生成二维码
		ImageUtil.saveToImgByInputStream(new ByteArrayInputStream(base.decode(obj)), imgPath, imgName);

		return imgPath + "/" + imgName;
	}
	
	private String getShopIdFromScene(String scene){
		scene = scene.substring(scene.indexOf("shopId="));
		String shopId;
		if (scene.contains("&")) {// 如果还有其他参数
			shopId = scene.substring(scene.indexOf("shopId=") + 7, scene.indexOf("&"));
		} else {
			shopId = scene.substring(scene.indexOf("shopId=") + 7);
		}
		return shopId;
	}

}
