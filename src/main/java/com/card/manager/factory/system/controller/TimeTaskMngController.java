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
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.model.TimeTaskModel;
import com.card.manager.factory.system.service.TimeTaskMngService;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

@Controller
@RequestMapping("/admin/system/timetaskMng")
public class TimeTaskMngController extends BaseController {
	
	@Resource
	TimeTaskMngService timeTaskMngService;

	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("system/timetask/list", context);
	}

	@RequestMapping(value = "/dataList")
	@ResponseBody
	public PageCallBack dataList(TimeTaskModel pagination, HttpServletRequest req, HttpServletResponse resp) {
		PageCallBack pcb = new PageCallBack();
		StaffEntity staff = SessionUtils.getOperator(req);

		try {
			Map<String, Object> params = new HashMap<String, Object>();

			String jobId = req.getParameter("jobId");
			if (!StringUtil.isEmpty(jobId)) {
				pagination.setId(Integer.parseInt(jobId));
			}
			String jobName = req.getParameter("jobName");
			if (!StringUtil.isEmpty(jobName)) {
				pagination.setJobName(jobName);
			}
			pcb = timeTaskMngService.dataList(pagination, params, staff.getToken(),
					ServerCenterContants.TIMETASK_CENTER_QUERY_ALL_TIMETASK, TimeTaskModel.class);

		}  catch (ServerCenterNullDataException e) {
			pcb = new PageCallBack();
			pcb.setPagination(pagination);
			pcb.setSuccess(true);
			return pcb;
		} catch (Exception e) {
			if (pcb == null) {
				pcb = new PageCallBack();
			}
			pcb.setErrTrace(e.getMessage());
			pcb.setSuccess(false);
			return pcb;
		}

		return pcb;
	}

	@RequestMapping(value = "/startTimeTask", method = RequestMethod.POST)
	public void startTimeTask(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String id = req.getParameter("id");
			if (StringUtil.isEmpty(id)) {
				sendFailureMessage(resp, "操作失败：没有获取到调度器编码");
				return;
			}
			timeTaskMngService.startTimeTaskById(Integer.valueOf(id), staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/stopTimeTask", method = RequestMethod.POST)
	public void stopTimeTask(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String id = req.getParameter("id");
			if (StringUtil.isEmpty(id)) {
				sendFailureMessage(resp, "操作失败：没有获取到调度器编码");
				return;
			}
			timeTaskMngService.stopTimeTaskById(Integer.valueOf(id), staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);

		String id = req.getParameter("id");
		if (StringUtil.isEmpty(id)) {
			sendFailureMessage(resp, "操作失败：没有获取到调度器编码");
			return forword("error", context);
		}
		try {
			TimeTaskModel task = timeTaskMngService.queryTimeTaskById(Integer.valueOf(id), opt);
			context.put("task", task);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword("error", context);
		}

		return forword("system/timetask/edit", context);
	}
	
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public void edit(HttpServletRequest req, HttpServletResponse resp, @RequestBody TimeTaskModel entity) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			timeTaskMngService.updateTimeTask(entity, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}
}
