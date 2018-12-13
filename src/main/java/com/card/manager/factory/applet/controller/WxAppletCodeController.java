package com.card.manager.factory.applet.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.card.manager.factory.applet.model.AppletCodeParameter;
import com.card.manager.factory.applet.service.WxAppletCodeService;
import com.card.manager.factory.auth.model.PlatUserType;
import com.card.manager.factory.auth.model.UserInfo;
import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.component.model.GradeBO;
import com.card.manager.factory.exception.WxCodeException;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.service.StaffMngService;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONObject;

@Controller
public class WxAppletCodeController extends BaseController {

	@Resource
	WxAppletCodeService wxAppletCodeService;
	
	@Resource
	StaffMngService staffMngService;

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

	@RequestMapping(value = "/wechat/applet/getCodeUrlByWechat", method=RequestMethod.GET)
	public void getCodeUrlByWechat(@RequestParam("gradeId") String gradeId, HttpServletRequest req, HttpServletResponse resp) {
		try {
			resp.setHeader("Access-Control-Allow-Origin", "*");
			resp.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTION");
			resp.setHeader("Access-Control-Max-Age", "3628800");
			resp.setHeader("Access-Control-Allow-Headers", "Authorization, Content-Type, Depth, User-Agent, X-File-Size, X-Requested-With, X-Requested-By, If-Modified-Since, X-File-Name, X-File-Type, Cache-Control, Origin");
			StaffEntity operator = staffMngService.queryStaffInfoByGradeId(gradeId);
			if (operator == null){
				operator = staffMngService.queryStaffInfoByGradeId("2");
			}

			// 调用权限中心 验证是否可以登录并获取token
			String authUrl = URLUtils.get("gateway");
			RestTemplate restTemplate = new RestTemplate();
			UserInfo userInfo = new UserInfo(PlatUserType.CROSS_BORDER.getIndex(), 4, operator.getPlatId());
			HttpEntity<UserInfo> entity = new HttpEntity<UserInfo>(userInfo, null);
			ResponseEntity<String> result = restTemplate.exchange(authUrl + ServerCenterContants.AUTH_CENTER_LOGIN,
					HttpMethod.POST, entity, String.class);
			JSONObject json = JSONObject.fromObject(result.getBody());
			JSONObject obj = (JSONObject) json.getJSONObject("obj");
			operator.setToken(obj.getString("token"));
			
			AppletCodeParameter param = new AppletCodeParameter();
			param.setScene("shopId="+gradeId);
			param.setPage("web/index/index");
			param.setWidth("400");
			String url = wxAppletCodeService.getWxAppletCode(param, true, operator);
			sendSuccessObject(resp, url);
		} catch (WxCodeException e) {
			String errorMsg = e.getMessage();
			sendFailureMessage(resp, errorMsg);
		}
	}
	
	@RequestMapping(value = "/admin/applet/createAllCode", method=RequestMethod.POST)
	public void createAllCode(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity opt = SessionUtils.getOperator(req);
		int tmpGradeId = opt.getGradeId();
		try {
			Map<Integer, GradeBO> gradeMap = CachePoolComponent.getGrade(opt.getToken());
			for (Map.Entry<Integer, GradeBO> entry : gradeMap.entrySet()) {
				AppletCodeParameter param = new AppletCodeParameter();
				param.setScene("shopId="+entry.getKey());
				param.setPage("web/index/index");
				param.setWidth("400");
				opt.setGradeId(entry.getKey());
				wxAppletCodeService.getWxAppletCode(param, true, opt);
			}
			opt.setGradeId(tmpGradeId);
			sendSuccessMessage(resp, "全部重新生成");
		} catch (WxCodeException e) {
			String errorMsg = e.getMessage();
			sendFailureMessage(resp, errorMsg);
		}
	}
}
