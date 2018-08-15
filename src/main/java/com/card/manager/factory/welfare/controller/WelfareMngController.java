package com.card.manager.factory.welfare.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.base.PageCallBack;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.component.model.GradeBO;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.FileDownloadUtil;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;
import com.card.manager.factory.welfare.model.InviterEntity;
import com.card.manager.factory.welfare.service.WelfareService;

@Controller
@RequestMapping("/admin/welfare/welfareMng")
public class WelfareMngController extends BaseController {
	
	@Resource
	WelfareService welfareService;

	@RequestMapping(value = "/toBatchAddInviter")
	public ModelAndView toBatchAddInviter(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		GradeBO grade = CachePoolComponent.getGrade(opt.getToken()).get(opt.getGradeId());
		if (grade != null) {
			if (grade.getType() != 3) {
				return forword("welfare/notice", context);
			}
		} else {
			context.put(ERROR, "没有分级信息");
			return forword("error", context);
		}
		return forword("welfare/inviterImport", context);
	}
	
	@RequestMapping(value = "/exportInviterInfoTemplate", method = RequestMethod.GET)
	public void exportInviterInfoTemplate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		try {
			WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
			ServletContext servletContext = webApplicationContext.getServletContext();

			String fileName = "inviter_model.xlsx";
			String filePath = servletContext.getRealPath("/") + "WEB-INF/classes/" + fileName;

			FileDownloadUtil.downloadFileByBrower(req, resp, filePath, fileName);
		} catch (Exception e) {
			resp.setContentType("text/html;charset=utf-8");
			resp.getWriter().println("下载失败，请重试!");
			resp.getWriter().println(e.getMessage());
			return;
		}
	}

	@RequestMapping(value = "/importInviterInfo", method = RequestMethod.POST)
	public void importInviterInfo(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String filePath = java.net.URLDecoder.decode(req.getParameter("filePath"), "UTF-8");
			if (StringUtil.isEmpty(filePath)) {
				sendFailureMessage(resp, "操作失败：文件路径不正确");
				return;
			}
			Map<String, Object> result = welfareService.importInviterInfo(filePath, staffEntity);
			if ((boolean) result.get("success")) {
				sendSuccessMessage(resp, null);
			} else {
				sendFailureMessage(resp, result.get("msg") + "");
			}
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
	}

	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		// set page privilege
		if (opt.getRoleId() == 1) {
			context.put("prilvl", "1");
		} else {
			context.put("prilvl", req.getParameter("privilege"));
		}
		GradeBO grade = CachePoolComponent.getGrade(opt.getToken()).get(opt.getGradeId());
		if (grade != null) {
			if (grade.getType() != 3) {
				return forword("welfare/notice", context);
			}
		} else {
			context.put(ERROR, "没有分级信息");
			return forword("error", context);
		}
		return forword("welfare/list", context);
	}

	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, InviterEntity entity) {
		PageCallBack pcb = null;
		StaffEntity opt = SessionUtils.getOperator(req);
		
		Map<String, Object> params = new HashMap<String, Object>();
		String quickQueryPhone = req.getParameter("quickQueryPhone");
		if (!StringUtil.isEmpty(quickQueryPhone)) {
			entity.setPhone(quickQueryPhone);
		}
		entity.setGradeId(opt.getGradeId());
		String name = req.getParameter("name");
		if (!StringUtil.isEmpty(name)) {
			entity.setName(name);
		}
		String phone = req.getParameter("phone");
		if (!StringUtil.isEmpty(phone)) {
			entity.setPhone(phone);
		}
		String invitationCode = req.getParameter("invitationCode");
		if (!StringUtil.isEmpty(invitationCode)) {
			entity.setInvitationCode(invitationCode);
		}
		String status = req.getParameter("status");
		if (!StringUtil.isEmpty(phone)) {
			entity.setStatus(Integer.parseInt(status));
		}
		String bindName = req.getParameter("bindName");
		if (!StringUtil.isEmpty(bindName)) {
			entity.setBindName(bindName);
		}
		String bindPhone = req.getParameter("bindPhone");
		if (!StringUtil.isEmpty(bindPhone)) {
			entity.setBindPhone(bindPhone);
		}
		try {
			pcb = welfareService.dataList(entity, params, opt.getToken(),
					ServerCenterContants.USER_CENTER_INVITER_QUERY_FOR_PAGE, InviterEntity.class);
			if (pcb != null) {
				List<InviterEntity> list = (List<InviterEntity>) pcb.getObj();
				Map<Integer, GradeBO> allGrade = CachePoolComponent.getGrade(opt.getToken());
				GradeBO tmpGrade = null;
				for (InviterEntity ie:list) {
					tmpGrade = allGrade.get(ie.getGradeId());
					ie.setGradeName(tmpGrade.getName());
				}
				pcb.setObj(list);
			}
		} catch (ServerCenterNullDataException e) {
			if (pcb == null) {
				pcb = new PageCallBack();
			}
			pcb.setPagination(entity);
			pcb.setSuccess(true);
			return pcb;
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

	@RequestMapping(value = "/toAddInviter")
	public ModelAndView toAddInviter(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		context.put("gradeId", opt.getGradeId());
		GradeBO grade = CachePoolComponent.getGrade(opt.getToken()).get(opt.getGradeId());
		if (grade != null) {
			if (grade.getType() != 3) {
				return forword("welfare/notice", context);
			}
		} else {
			context.put(ERROR, "没有分级信息");
			return forword("error", context);
		}
		return forword("welfare/add", context);
	}

	@RequestMapping(value = "/addInviterInfo", method = RequestMethod.POST)
	public void addInviterInfo(HttpServletRequest req, HttpServletResponse resp,@RequestBody InviterEntity entity) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			Map<String, Object> result = welfareService.addInviterInfo(entity, staffEntity);
			if ((boolean) result.get("success")) {
				sendSuccessMessage(resp, result.get("msg") + "");
			} else {
				sendFailureMessage(resp, result.get("msg") + "");
			}
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
	}

	@RequestMapping(value = "/toEditInviter")
	public ModelAndView toEditInviter(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		try {
			String id = java.net.URLDecoder.decode(req.getParameter("id"), "UTF-8");
			String name = java.net.URLDecoder.decode(req.getParameter("name"), "UTF-8");
			String phone = java.net.URLDecoder.decode(req.getParameter("phone"), "UTF-8");
			context.put("id", id);
			context.put("name", name);
			context.put("phone", phone);
		} catch (UnsupportedEncodingException e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
		GradeBO grade = CachePoolComponent.getGrade(opt.getToken()).get(opt.getGradeId());
		if (grade != null) {
			if (grade.getType() != 3) {
				return forword("welfare/notice", context);
			}
		} else {
			context.put(ERROR, "没有分级信息");
			return forword("error", context);
		}
		return forword("welfare/edit", context);
	}

	@RequestMapping(value = "/editInviterInfo", method = RequestMethod.POST)
	public void editInviterInfo(HttpServletRequest req, HttpServletResponse resp,@RequestBody InviterEntity entity) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			Map<String, Object> result = welfareService.updateInviterInfo(entity, staffEntity);
			if ((boolean) result.get("success")) {
				sendSuccessMessage(resp, result.get("msg") + "");
			} else {
				sendFailureMessage(resp, result.get("msg") + "");
			}
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
	}

	@RequestMapping(value = "/delInviterInfo", method = RequestMethod.POST)
	public void delInviterInfo(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			InviterEntity entity = new InviterEntity();
			String id = req.getParameter("id");
			if (!StringUtil.isEmpty(id)) {
				entity.setId(Integer.parseInt(id));
			} else {
				sendFailureMessage(resp, "缺少参数");
				return;
			}
			entity.setStatus(4);
			entity.setOpt(staffEntity.getOptName());
			Map<String, Object> result = welfareService.updateInviterInfo(entity, staffEntity);
			if ((boolean) result.get("success")) {
				sendSuccessMessage(resp, null);
			} else {
				sendFailureMessage(resp, result.get("msg") + "");
			}
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
	}

	@RequestMapping(value = "/produceCode", method = RequestMethod.POST)
	public void produceCode(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			InviterEntity entity = new InviterEntity();
			String ids = req.getParameter("ids");
			if (!StringUtil.isEmpty(ids)) {
				entity.setIds(ids);
			}
			entity.setGradeId(staffEntity.getGradeId());
			entity.setStatus(0);
			entity.setOpt(staffEntity.getOptName());
			Map<String, Object> result = welfareService.produceCode(entity, staffEntity);
			if ((boolean) result.get("success")) {
				sendSuccessMessage(resp, result.get("msg") + "");
			} else {
				sendFailureMessage(resp, result.get("msg") + "");
			}
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
	}

	@RequestMapping(value = "/sendProduceCode", method = RequestMethod.POST)
	public void sendProduceCode(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			InviterEntity entity = new InviterEntity();
			String ids = req.getParameter("ids");
			if (!StringUtil.isEmpty(ids)) {
				entity.setIds(ids);
				entity.setStatus(-1);
			} else {
				entity.setStatus(1);
			}
			entity.setGradeId(staffEntity.getGradeId());
			entity.setOpt(staffEntity.getOptName());
			Map<String, Object> result = welfareService.sendProduceCode(entity, staffEntity);
			if ((boolean) result.get("success")) {
				sendSuccessMessage(resp, result.get("msg") + "");
			} else {
				sendFailureMessage(resp, result.get("msg") + "");
			}
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
	}
}
