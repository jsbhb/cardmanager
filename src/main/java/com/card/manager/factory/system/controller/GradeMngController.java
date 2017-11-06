package com.card.manager.factory.system.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.base.PageCallBack;
import com.card.manager.factory.base.Pagination;
import com.card.manager.factory.common.AuthCommon;
import com.card.manager.factory.system.model.GradeEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.service.GradeMngService;
import com.card.manager.factory.system.service.StaffMngService;
import com.card.manager.factory.util.SessionUtils;

@Controller
@RequestMapping("/admin/system/gradeMng")
public class GradeMngController extends BaseController {

	@Resource
	GradeMngService gradeMngService;
	
	@Resource
	StaffMngService staffMngService;

	@RequestMapping(value = "/mng")
	public ModelAndView toFuncList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("system/grade/gradeMng", context);
	}

	@RequestMapping(value = "/toAdd")
	public ModelAndView add(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("system/grade/add", context);
	}

	@RequestMapping(value = "/addGrade", method = RequestMethod.POST)
	public void addGrade(HttpServletRequest req, HttpServletResponse resp, @RequestBody GradeEntity gradeInfo) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			gradeMngService.saveGrade(gradeInfo, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("system/grade/list", context);
	}

	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, Pagination pagination) {
		PageCallBack pcb = null;

		Map<String, Object> params = new HashMap<String, Object>();
		String gradeName = req.getParameter("gradeName");
		if (gradeName != null && "".equals(gradeName)) {
			params.put("gradeName", gradeName);
		}

		StaffEntity opt = SessionUtils.getOperator(req);

		if (opt.getRoleId() != AuthCommon.SUPER_ADMIN) {
			int id = opt.getGradeId();
			params.put("id", id);
		}

		try {
			pcb = gradeMngService.dataList(pagination, params, opt.getToken());
		} catch (Exception e) {
			if (pcb == null) {
				pcb = new PageCallBack();
			}
			pcb.setErrTrace(e.getMessage());
			pcb.setSuccess(false);
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return pcb;
		}

		return pcb;
	}
	
	
	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		String gradeId = req.getParameter("gradeId");
		
		try{
			GradeEntity entity = gradeMngService.queryById(gradeId,opt.getToken());
			context.put("grade", entity);
		}catch(Exception e){
			return forword("system/error", context);
		}
		
		return forword("system/grade/edit", context);
	}

	@RequestMapping(value = "/editGrade", method = RequestMethod.POST)
	public void editGrade(HttpServletRequest req, HttpServletResponse resp, @RequestBody GradeEntity gradeInfo) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			gradeMngService.saveGrade(gradeInfo, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}
	
	@RequestMapping(value = "/syncStaff", method = RequestMethod.POST)
	public void syncStaff(HttpServletRequest req, HttpServletResponse resp) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String gradeId = req.getParameter("gradeId");
			GradeEntity grade = gradeMngService.queryById(gradeId, staffEntity.getToken());
			staffEntity = new StaffEntity();
			staffEntity.setGradeName(grade.getGradeName());
			staffEntity.setParentGradeId(grade.getParentId());
			staffEntity.setOptName(grade.getPersonInCharge());
			staffEntity.setGradeId(grade.getId());
			staffEntity.setUserCenterId(grade.getPersonInChargeId());
			gradeMngService.registerAuthCenter(staffEntity,false);;
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

}
