package com.card.manager.factory.finance.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
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
import com.card.manager.factory.component.model.GradeBO;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.finance.model.CapitalPool;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.user.service.FinanceMngService;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;
import com.card.manager.factory.util.TreePackUtil;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/admin/finance/capitalPoolMng")
public class CapitalPoolMng extends BaseController {

	@Resource
	FinanceMngService financeMngService;

	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		Integer gradeId = opt.getGradeId();
		List<GradeBO> list = new ArrayList<GradeBO>();
		List<GradeBO> result = new ArrayList<>();
		Map<Integer, GradeBO> map = CachePoolComponent.getGrade(opt.getToken());
		for (Map.Entry<Integer, GradeBO> entry : map.entrySet()) {
			list.add(entry.getValue());
		}
		result = TreePackUtil.packGradeChildren(list, gradeId);
		Collections.sort(result);
		context.put("list", result);
		return forword("finance/poolcharge/list", context);
	}
	
	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, CapitalPool entity) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {

			String centerId = req.getParameter("gradeId");
			if (!StringUtil.isEmpty(centerId)) {
				entity.setCenterId(Integer.parseInt(centerId));
			}
			
			// 调用权限中心 验证是否可以登录
			Pagination pagination = new Pagination();
			RestCommonHelper helper = new RestCommonHelper(pagination);

			ResponseEntity<String> result = helper.request(URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_QUERY_CAPITALPOOL, staffEntity.getToken(), true, entity,
					HttpMethod.POST);

			JSONObject json = JSONObject.fromObject(result.getBody());

			JSONArray obj = json.getJSONArray("obj");
			int index = obj.size();
			if (index == 0) {
				throw new ServerCenterNullDataException("没有查询到相关数据！");
			}

			List<Object> list = new ArrayList<Object>();
			for (int i = 0; i < index; i++) {
				JSONObject jObj = obj.getJSONObject(i);
				list.add(JSONUtilNew.parse(jObj.toString(), CapitalPool.class));
			}
			pcb = new PageCallBack();
			pcb.setObj(list);
			pcb.setPagination(pagination);
			pcb.setSuccess(true);
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
			String centerId = req.getParameter("centerId");
			context.put("centerId", centerId);
			List<StaffEntity> center = CachePoolComponent.getCenter(opt.getToken());
			for(StaffEntity cen : center) {
				if (cen.getGradeId() == Integer.parseInt(centerId)) {
					context.put("centerName", cen.getGradeName());
					break;
				}
			}
			return forword("finance/poolcharge/show", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
	}

	@RequestMapping(value = "/charge", method = RequestMethod.POST)
	public void charge(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String centerId = req.getParameter("centerId");
			String money = req.getParameter("money");
			String payNo = req.getParameter("payNo");
			if (!StringUtil.isEmpty(centerId)&&!StringUtil.isEmpty(money)&&!StringUtil.isEmpty(payNo)) {
				financeMngService.poolCharge(centerId, money, payNo, staffEntity);
			}
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
		context.put(OPT, opt);
		try {
			String centerId = req.getParameter("centerId");
			context.put("centerId", centerId);
			List<StaffEntity> center = CachePoolComponent.getCenter(opt.getToken());
			for(StaffEntity cen : center) {
				if (cen.getGradeId() == Integer.parseInt(centerId)) {
					context.put("centerName", cen.getGradeName());
					break;
				}
			}
			return forword("finance/poolcharge/delete", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
	}

	@RequestMapping(value = "/liquidation", method = RequestMethod.POST)
	public void liquidation(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String centerId = req.getParameter("centerId");
			String money = req.getParameter("money");
			if (!StringUtil.isEmpty(centerId)&&!StringUtil.isEmpty(money)) {
				financeMngService.poolLiquidation(centerId, money, staffEntity);
			}
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		sendSuccessMessage(resp, null);
	}
}
