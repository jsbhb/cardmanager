package com.card.manager.factory.system.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.auth.model.Operator;
import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.util.SessionUtils;

@Controller
@RequestMapping("/admin/system/staffMng")
public class StaffMngController extends BaseController {

	
	@RequestMapping(value = "/mng")
	public ModelAndView toFuncList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		Operator opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("system/staff/staffMng", context);
	}
	
	@RequestMapping(value = "/add")
	public ModelAndView add(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		Operator opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("system/staff/add", context);
	}
	
	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		Operator opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("system/staff/list", context);
	}
	
	


}
