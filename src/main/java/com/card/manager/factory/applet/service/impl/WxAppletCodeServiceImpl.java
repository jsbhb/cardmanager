package com.card.manager.factory.applet.service.impl;

import java.io.ByteArrayInputStream;

import org.apache.commons.codec.binary.Base64;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.card.manager.factory.applet.model.AppletCodeParameter;
import com.card.manager.factory.applet.service.WxAppletCodeService;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.exception.WxCodeException;
import com.card.manager.factory.util.ImageUtil;

import net.sf.json.JSONObject;

@Service
public class WxAppletCodeServiceImpl implements WxAppletCodeService {

	@Override
	public String getWxAppletCode(AppletCodeParameter param, boolean needToCoverLogo, String token)
			throws WxCodeException {
		// 如果二维码已经存在，直接返回url
		if (codeExist(param)) {
			return null;
		}
		// 不存在获取二维码
		String filePath = getCode(param, token);
		// 如果需要替换logo
		if (needToCoverLogo) {
			replaceLogo(filePath, param);
		}
		// 上传到静态服务器
		uploadToStaticServer();

		return null;
	}

	private final String GOODS_DETAIL_PATH = "/web/orderDetail/orderDetail?goodsId=";// 商详路径
	private final String TEMPORARY_PATH = "";// 临时路径

	private void replaceLogo(String filePath, AppletCodeParameter param) {
		String page = param.getPage();
		String logoPath;
		if (page.contains(GOODS_DETAIL_PATH)) {// 路径是商详，默认第一张主图作为logo
			page = page.substring(page.indexOf("goodsId="));
			String goodsId;
			if (page.contains("&")) {//如果还有其他参数
				goodsId = page.substring(page.indexOf("goodsId=") + 8, page.indexOf("&"));
			} else {
				goodsId = page.substring(page.indexOf("goodsId=") + 8);
			}
			//获取需要替换的logo（商品主图）
			logoPath = 
		} else {//不是商详路径
			//获取微店配置的头像信息
			logoPath = 
		}
		//替换logo默认替换原来的filePath，后缀png
		ImageUtil.replaceCodeLogo(filePath, logoPath, true, TEMPORARY_PATH);
	}

	private String getCode(AppletCodeParameter param, String token) throws WxCodeException {
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
		// 生成二维码
		ImageUtil.saveToImgByInputStream(new ByteArrayInputStream(base.decode(obj)), imgPath, imgName);

		return imgPath + "/" + imgName;
	}

}
