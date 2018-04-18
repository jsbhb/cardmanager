package com.card.manager.factory.user.controller;

import java.util.ArrayList;
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
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.finance.model.Withdrawals;
import com.card.manager.factory.system.model.GradeEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.service.GradeMngService;
import com.card.manager.factory.user.model.CardEntity;
import com.card.manager.factory.user.model.ShopRebate;
import com.card.manager.factory.user.service.FinanceMngService;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

@Controller
@RequestMapping("/admin/user/userWithdrawalsMng")
public class UserWithdrawalsMngController extends BaseController {
	
	@Resource
	FinanceMngService financeMngService;
	
	@Resource
	GradeMngService gradeMngService;

	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("user/withdrawals/list", context);
	}

	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, Withdrawals entity) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			String hidPayNo = req.getParameter("hidPayNo");
			if (!StringUtil.isEmpty(hidPayNo)) {
				entity.setPayNo(hidPayNo);
			}
			entity.setOperatorId(staffEntity.getGradeId());

			pcb = financeMngService.dataList(entity, params, staffEntity.getToken(),
					ServerCenterContants.FINANCE_CENTER_WITHDRAWALS_QUERY, Withdrawals.class);
			
			GradeEntity grade = gradeMngService.queryById(staffEntity.getGradeId()+"", staffEntity.getToken());
			
			if (pcb != null) {
				List<Object> list = (ArrayList<Object>)pcb.getObj();
				Withdrawals withdrawals = null;
				for(Object info : list){
					withdrawals = (Withdrawals) info;
					withdrawals.setOperatorName(grade.getGradeName());
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

	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);

		List<CardEntity> cards = financeMngService.queryInfoByUser(opt);
		if (cards.size() <= 0) {
			return forword("user/withdrawals/notice2", context);
		}
		context.put("card", cards.get(0));
		context.put("cards", cards);
		
		String typeId = "";
		String type = "";
		if (opt.getGradeLevel() == 1) {
			return forword("user/withdrawals/notice", context);
		} else {
			typeId = opt.getGradeId()+"";
			ShopRebate shopRebate = financeMngService.queryShopRebate(typeId, type, opt.getToken());
			context.put("info", shopRebate);
			context.put("typeId", typeId);
			context.put("type", type);
			return forword("user/withdrawals/show", context);
		}
	}
	
	@RequestMapping(value = "/apply", method = RequestMethod.POST)
	public void apply(HttpServletRequest req, HttpServletResponse resp, @RequestBody Withdrawals entity) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			financeMngService.applyWithdrawals(entity, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "新增提现申请失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}
}
