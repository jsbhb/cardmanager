package com.card.manager.factory.finance.controller;

import java.util.ArrayList;
import java.util.Collections;
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

import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.base.PageCallBack;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.component.model.GradeBO;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.finance.model.AuditModel;
import com.card.manager.factory.finance.model.Withdrawals;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.user.service.FinanceMngService;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;
import com.card.manager.factory.util.TreePackUtil;

@Controller
@RequestMapping("/admin/finance/withdrawalsMng")
public class WithdrawalsMngMng extends BaseController {

	@Resource
	FinanceMngService financeMngService;

	@RequestMapping(value = "/mng")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		Map<Integer, GradeBO> map = CachePoolComponent.getGrade(opt.getToken());
		List<GradeBO> list = new ArrayList<GradeBO>();
		List<GradeBO> result = new ArrayList<>();
		for (Map.Entry<Integer, GradeBO> entry : map.entrySet()) {
			list.add(entry.getValue());
		}
		result = TreePackUtil.packGradeChildren(list, opt.getGradeId());
		Collections.sort(result);
		context.put("list", result);
		return forword("finance/withdrawals/list", context);
	}
	
	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, Withdrawals entity) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {

			String gradeId = req.getParameter("gradeId");
			if (!StringUtil.isEmpty(gradeId)) {
				entity.setOperatorId(Integer.parseInt(gradeId));
			}

			pcb = financeMngService.dataList(entity, params, staffEntity.getToken(),
					ServerCenterContants.FINANCE_CENTER_WITHDRAWALS_QUERY, Withdrawals.class);
			
			if (pcb != null) {
				Map<Integer, GradeBO> map = CachePoolComponent.getGrade(staffEntity.getToken());
				GradeBO gradeBO = null;
				List<Object> list = (ArrayList<Object>)pcb.getObj();
				Withdrawals withdrawals = null;
				for(Object info : list){
					withdrawals = (Withdrawals) info;
					gradeBO = map.get(withdrawals.getOperatorId());
					if (gradeBO != null) {
						withdrawals.setOperatorName(gradeBO.getName());
					}
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
			return pcb;
		}

		return pcb;
	}

	@RequestMapping(value = "/toShow")
	public ModelAndView toShow(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {
			String id = req.getParameter("id");
			Withdrawals Detail = null;
			if (!StringUtil.isEmpty(id)) {
				Detail = financeMngService.checkWithdrawalsById(id,opt);
			}
			context.put("Detail", Detail);
			return forword("finance/withdrawals/show", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
	}

	@RequestMapping(value = "/audit", method = RequestMethod.POST)
	public void audit(HttpServletRequest req, HttpServletResponse resp, @RequestBody AuditModel entity) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			financeMngService.auditWithdrawals(entity,staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}
}
