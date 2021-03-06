package com.card.manager.factory.user.controller;

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
import com.card.manager.factory.user.model.CardEntity;
import com.card.manager.factory.user.service.FinanceMngService;
import com.card.manager.factory.util.SessionUtils;

@Controller
@RequestMapping("/admin/user/userCardMng")
public class UserCardMngController extends BaseController {
	
	@Resource
	FinanceMngService financeMngService;

	@RequestMapping(value = "/mng")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("user/card/list", context);
	}

	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, CardEntity pagination) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			Integer operId = staffEntity.getGradeId();
			Integer operType = staffEntity.getGradeType();
			pagination.setTypeId(operId);
			pagination.setType(operType);
			pcb = financeMngService.dataList(pagination, params, staffEntity.getToken(),
					ServerCenterContants.FINANCE_CENTER_QUERY_CARDINFO, CardEntity.class);
		} catch (ServerCenterNullDataException e) {
			if (pcb == null) {
				pcb = new PageCallBack();
			}
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
	
	@RequestMapping(value = "/checkCard", method = RequestMethod.POST)
	public void checkCard(HttpServletRequest req, HttpServletResponse resp) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		String cardBank = "";
		try {
			String cardNo = req.getParameter("cardNo");
			cardBank = financeMngService.checkCardNo(cardNo, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "查询失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, cardBank);
	}

	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("user/card/add", context);
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public void insert(HttpServletRequest req, HttpServletResponse resp, @RequestBody CardEntity cardInfo) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			Integer operId = staffEntity.getGradeId();
			Integer operType = staffEntity.getGradeType();
			cardInfo.setTypeId(operId);
			cardInfo.setType(operType);
			financeMngService.insertCard(cardInfo, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "绑卡失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		try {
			String cardId = req.getParameter("cardId");
			CardEntity cardEntity = new CardEntity();
			cardEntity.setId(Integer.parseInt(cardId));
			CardEntity card = financeMngService.queryInfoByCardId(cardEntity, opt);
			context.put("card", card);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
		return forword("user/card/edit", context);
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public void update(HttpServletRequest req, HttpServletResponse resp, @RequestBody CardEntity cardInfo) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			financeMngService.updateCard(cardInfo, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/toDelete")
	public ModelAndView toDelete(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		try {
			String cardId = req.getParameter("cardId");
			CardEntity cardEntity = new CardEntity();
			cardEntity.setId(Integer.parseInt(cardId));
			CardEntity card = financeMngService.queryInfoByCardId(cardEntity, opt);
			context.put("card", card);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
		return forword("user/card/delete", context);
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public void delete(HttpServletRequest req, HttpServletResponse resp, @RequestBody CardEntity cardInfo) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			financeMngService.deleteCard(cardInfo, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		sendSuccessMessage(resp, null);
	}
}
