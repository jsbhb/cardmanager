package com.card.manager.factory.applet.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import com.card.manager.factory.applet.model.AppletCodeParameter;
import com.card.manager.factory.applet.service.WxAppletCodeService;
import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.exception.WxCodeException;

@Controller
public class WxAppletCodeController extends BaseController {

	@Resource
	WxAppletCodeService wxAppletCodeService;

	public void getAppletCode(@RequestParam("needToCoverLogo") boolean needToCoverLogo,
			@RequestBody AppletCodeParameter param) {
		String token = "";
		try {
			String url = wxAppletCodeService.getWxAppletCode(param, needToCoverLogo, token);
		} catch (WxCodeException e) {
			String errorCode = e.getCode();
			String errorMsg = e.getMessage();
		}
	}
}
