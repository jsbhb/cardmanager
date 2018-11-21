package com.card.manager.factory.applet.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.card.manager.factory.applet.model.AppletCodeParameter;
import com.card.manager.factory.applet.service.WxAppletCodeService;
import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.exception.WxCodeException;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.SessionUtils;

@Controller
public class WxAppletCodeController extends BaseController {

	@Resource
	WxAppletCodeService wxAppletCodeService;

	@RequestMapping(value = "/admin/applet/code", method=RequestMethod.POST)
	public void getAppletCode(@RequestParam("needToCoverLogo") boolean needToCoverLogo,
			@RequestBody AppletCodeParameter param, HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity opt = SessionUtils.getOperator(req);
		try {
			String url = wxAppletCodeService.getWxAppletCode(param, needToCoverLogo, opt);
			sendSuccessObject(resp, url);
		} catch (WxCodeException e) {
			String errorMsg = e.getMessage();
			sendFailureMessage(resp, errorMsg);
		}
	}
}
