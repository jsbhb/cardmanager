package com.card.manager.factory.system.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.auth.model.Operator;
import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.system.model.GradeEntity;
import com.card.manager.factory.system.service.GradeMngService;
import com.card.manager.factory.util.SessionUtils;

@Controller
@RequestMapping("/admin/system/gradeMng")
public class GradeMngController extends BaseController {

	GradeMngService gradeMngService;
	
	@RequestMapping(value = "/mng")
	public ModelAndView toFuncList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		Operator opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("system/grade/gradeMng", context);
	}
	
	@RequestMapping(value = "/add")
	public ModelAndView add(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		Operator opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("system/grade/add", context);
	}
	
	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		Operator opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("system/grade/list", context);
	}
	
	@RequestMapping(value = "/createGrade", method = RequestMethod.POST)
	public void createGrade(HttpServletRequest req, HttpServletResponse resp, @RequestBody GradeEntity gradeInfo) {

		try {
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}
	


}
