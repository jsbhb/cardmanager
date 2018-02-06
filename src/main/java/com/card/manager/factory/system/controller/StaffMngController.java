package com.card.manager.factory.system.controller;

import java.util.HashMap;
import java.util.List;
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

import com.card.manager.factory.auth.model.AuthInfo;
import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.base.PageCallBack;
import com.card.manager.factory.base.Pagination;
import com.card.manager.factory.common.AuthCommon;
import com.card.manager.factory.constants.LoggerConstants;
import com.card.manager.factory.log.SysLogger;
import com.card.manager.factory.system.exception.OperatorSaveException;
import com.card.manager.factory.system.exception.SyncUserCenterException;
import com.card.manager.factory.system.model.RoleEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.service.RoleMngService;
import com.card.manager.factory.system.service.StaffMngService;
import com.card.manager.factory.util.SessionUtils;
import com.github.pagehelper.Page;

@Controller
@RequestMapping("/admin/system/staffMng")
public class StaffMngController extends BaseController {

	@Resource
	RoleMngService roleMngService;

	@Resource
	StaffMngService staffMngService;

	@Resource
	SysLogger sysLogger;

	private final String OPERATOR = "opt";
	private final String OPT_ID = "optid";
	private final String PHONE = "phone";

	@RequestMapping(value = "/mng")
	public ModelAndView mng(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPERATOR, opt);
		return forword("system/staff/staffMng", context);
	}

	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPERATOR, opt);
		return forword("system/staff/list", context);
	}

	@RequestMapping(value = "/dataList")
	@ResponseBody
	public PageCallBack dataList(Pagination pagination, HttpServletRequest req, HttpServletResponse resp) {
		PageCallBack pcb = new PageCallBack();

		try {
			String id = req.getParameter("gradeId");
			StaffEntity entity = SessionUtils.getOperator(req);
			Page<StaffEntity> page = null;
			Map<String, Object> params = new HashMap<String, Object>();

			//暂时不做数据拦截，只要能进入员工管理就能查看所有用户记录
//			if (id != null && !"".equals(id)) {
//				params.put("gradeId", Integer.parseInt(id));
//			} else if (entity.getRoleId() != AuthCommon.SUPER_ADMIN) {
//				params.put("gradeId", entity.getGradeId());
//			}

			page = staffMngService.dataList(pagination, params);

			pcb.setObj(page);
			pcb.setSuccess(true);
			pcb.setPagination(webPageConverter(page));
		} catch (Exception e) {
			pcb.setErrTrace(e.getMessage());
			pcb.setSuccess(false);
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return pcb;
		}

		return pcb;
	}

	@RequestMapping(value = "/toAdd")
	public ModelAndView add(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPERATOR, opt);

		List<RoleEntity> roleList = roleMngService.queryAll();
		context.put("roles", roleList);

		return forword("system/staff/add", context);
	}

	@RequestMapping(value = "/addStaff", method = RequestMethod.POST)
	public void addStaff(HttpServletRequest req, HttpServletResponse resp, @RequestBody StaffEntity staffEntity) {
		StaffEntity opt = SessionUtils.getOperator(req);
		try {
			staffEntity.setGradeLevel(opt.getGradeLevel());
			staffMngService.addStaff(staffEntity);
		} catch (OperatorSaveException e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		} catch (SyncUserCenterException e) {
			sendSuccessMessage(resp, null);
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/sync", method = RequestMethod.POST)
	public void sync(HttpServletRequest req, HttpServletResponse resp) {
		try {
			int optId = Integer.parseInt(req.getParameter(OPT_ID));
			String phone = req.getParameter(PHONE);

			staffMngService.sync(optId, phone);

		} catch (Exception e) {
			sysLogger.error(LoggerConstants.LOGIN_LOGGER, e.getMessage() + "同步失败.");
			sendFailureMessage(resp, "同步失败，请重试.");
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		return forword("system/staff/edit", context);
	}

	@RequestMapping(value = "/editStaff", method = RequestMethod.POST)
	public void editStaff(HttpServletRequest req, HttpServletResponse resp, @RequestBody AuthInfo authInfo) {

		try {
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/deleteStaff", method = RequestMethod.POST)
	public void deleteStaff(HttpServletRequest req, HttpServletResponse resp, String id) {

		if (id == null || "".equals(id)) {
			sendFailureMessage(resp, "删除失败，没有选择对应模块或者节点！");
			return;
		}
		try {
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/sync2B", method = RequestMethod.POST)
	public void sync2B(HttpServletRequest req, HttpServletResponse resp) {
		try {
			StaffEntity opt = SessionUtils.getOperator(req);
			int optId = Integer.parseInt(req.getParameter(OPT_ID));

			staffMngService.sync2B(opt,optId);

		} catch (Exception e) {
			sysLogger.error(LoggerConstants.LOGIN_LOGGER, e.getMessage() + "同步失败.");
			sendFailureMessage(resp, "同步失败，请重试.");
			return;
		}

		sendSuccessMessage(resp, null);
	}

}
