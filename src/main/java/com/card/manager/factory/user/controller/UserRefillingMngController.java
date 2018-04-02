package com.card.manager.factory.user.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.base.PageCallBack;
import com.card.manager.factory.base.Pagination;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.finance.model.CapitalPool;
import com.card.manager.factory.finance.model.Refilling;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.user.model.CenterRebate;
import com.card.manager.factory.user.service.FinanceMngService;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/admin/user/userRefillingMng")
public class UserRefillingMngController extends BaseController {
	
	@Resource
	FinanceMngService financeMngService;

	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		context.put("centerId", CachePoolComponent.getCenter(opt.getToken()));
		if (opt.getGradeLevel() != 2) {
			return forword("user/refilling/notice", context);
		}
		return forword("user/refilling/list", context);
	}

	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, Refilling entity) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			entity.setCenterId(staffEntity.getGradeId());
			pcb = financeMngService.dataList(entity, params, staffEntity.getToken(),
					ServerCenterContants.FINANCE_CENTER_REFILLING_QUERY, Refilling.class);
			
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
		
		//获取资金池信息
		CapitalPool entity = new CapitalPool();
		entity.setCenterId(opt.getGradeId());
		// 调用权限中心 验证是否可以登录
		Pagination pagination = new Pagination();
		RestCommonHelper helper = new RestCommonHelper(pagination);
		ResponseEntity<String> result = helper.request(URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_QUERY_CAPITALPOOL, opt.getToken(), true, entity,
				HttpMethod.POST);
		JSONObject json = JSONObject.fromObject(result.getBody());
		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();
		if (index == 0) {
			return forword("error", context);
		}
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			entity = JSONUtilNew.parse(jObj.toString(), CapitalPool.class);
			if (entity.getCenterId() == opt.getGradeId()) {
				break;
			} else {
				entity = new CapitalPool();
			}
		}
		if (entity.getCenterId() != opt.getGradeId()) {
			return forword("error", context);
		}
		context.put("entity", entity);
		
		String typeId = "";
		String type = "";
		typeId = opt.getGradeId()+"";
		type = "0";
		CenterRebate centerRebate = financeMngService.queryCenterRebate(typeId, type, opt.getToken());
		context.put("info", centerRebate);
		context.put("typeId", typeId);
		context.put("type", type);
		return forword("user/refilling/show", context);
	}
	
	@RequestMapping(value = "/apply", method = RequestMethod.POST)
	public void apply(HttpServletRequest req, HttpServletResponse resp, @RequestBody Refilling entity) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			financeMngService.applyRefilling(entity, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "新增返充申请失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}
}
