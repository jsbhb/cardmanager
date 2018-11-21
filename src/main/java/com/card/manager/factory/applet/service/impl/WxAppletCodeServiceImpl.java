package com.card.manager.factory.applet.service.impl;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;

import javax.servlet.ServletContext;

import org.apache.commons.codec.binary.Base64;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.card.manager.factory.applet.model.AppletCodeParameter;
import com.card.manager.factory.applet.service.WxAppletCodeService;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.exception.WxCodeException;
import com.card.manager.factory.util.HttpClientUtil;
import com.card.manager.factory.util.ImageUtil;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONObject;

@Service
public class WxAppletCodeServiceImpl implements WxAppletCodeService {

	@Override
	public String getWxAppletCode(AppletCodeParameter param, boolean needToCoverLogo, String token)
			throws WxCodeException {
		// 拼装url
		String url = assemblingUrl(param);
		// 如果二维码已经存在，直接返回url
		if (codeExist(url)) {
			return url;
		}
		//获取绝对路径
		WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
		ServletContext servletContext = webApplicationContext.getServletContext();
		String absolutelyPath = servletContext.getRealPath("/");
		// 不存在获取二维码
		String filePath = getCode(param, token, absolutelyPath);
		// 如果需要替换logo
		if (needToCoverLogo) {
			replaceLogo(filePath, param, absolutelyPath);
		}
		// 上传到静态服务器
		uploadToStaticServer();

		return null;
	}

	private String assemblingUrl(AppletCodeParameter param) {
		String page = param.getPage();
		if (page.contains(GOODS_DETAIL_PATH)) {
			String goodsId = getGoodsIdFromPage(page);// 获取goodsId
			return URLUtils.get("static") + "/appletcode/" + param.getScene() + "/goods/" + goodsId + ".png";
		} else {
			return URLUtils.get("static") + "/appletcode/" + param.getScene() + ".png";
		}
	}

	private boolean codeExist(String url) {
		InputStream in = HttpClientUtil.getInputStream(url);
		if (in == null) {
			return false;
		} else {
			return true;
		}
	}

	private final String GOODS_DETAIL_PATH = "/web/orderDetail/orderDetail?goodsId=";// 商详路径
	private final String TEMPORARY_PATH = "temporary";// 临时路径

	private void replaceLogo(String filePath, AppletCodeParameter param,String absolutelyPath) {
		String page = param.getPage();
		String logoPath;
		if (page.contains(GOODS_DETAIL_PATH)) {// 路径是商详，默认第一张主图作为logo
			String goodsId = getGoodsIdFromPage(page);
			//获取需要替换的logo（商品主图）
			logoPath = 
		} else {//不是商详路径
			//获取微店配置的头像信息
			logoPath = 
		}
		//替换logo默认替换原来的filePath，后缀png
		ImageUtil.replaceCodeLogo(filePath, logoPath, true, absolutelyPath+TEMPORARY_PATH);
	}

	private String getGoodsIdFromPage(String page) {
		page = page.substring(page.indexOf("goodsId="));
		String goodsId;
		if (page.contains("&")) {// 如果还有其他参数
			goodsId = page.substring(page.indexOf("goodsId=") + 8, page.indexOf("&"));
		} else {
			goodsId = page.substring(page.indexOf("goodsId=") + 8);
		}
		return goodsId;
	}

	private String getCode(AppletCodeParameter param, String token, String absolutelyPath) throws WxCodeException {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = helper.request("https://testapi.cncoopbuy.com/3rdcenter/1.0/getwxacodeunlimit",
				token, true, param, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(result.getBody());

		if (!json.getBoolean("success")) {
			throw new WxCodeException(json.getString("errorCode"), json.getString("errorMsg"));
		}
		String obj = json.getString("obj");
		// 图片字符串需base64解码
		Base64 base = new Base64();
		String imgPath = "APPLET_CODE";
		String imgName = param.getScene() + ".png";
		// 生成二维码
		ImageUtil.saveToImgByInputStream(new ByteArrayInputStream(base.decode(obj)), imgPath, imgName);

		return imgPath + "/" + imgName;
	}

	public static void main(String[] args) {
		InputStream in = HttpClientUtil
				.getInputStream("https://teststatic.cncoopbuy.com:8080/PC/11-11-PC/NBNF8809505541047.jpg");

	}

}
