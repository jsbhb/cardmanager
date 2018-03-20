package com.card.manager.factory.finance.controller;

import java.util.ArrayList;
import java.util.HashMap;
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
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.finance.model.CapitalPool;
import com.card.manager.factory.order.model.UserDetail;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.user.service.FinanceMngService;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;
import com.card.manager.factory.util.URLUtils;

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
		context.put("centers", CachePoolComponent.getCenter(opt.getToken()));
		return forword("finance/poolcharge/list", context);
	}
	
	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, CapitalPool entity) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {

			String centerId = req.getParameter("centerId");
			if (!StringUtil.isEmpty(centerId)) {
				entity.setCenterId(Integer.parseInt(centerId));
			}

			pcb = financeMngService.dataList(entity, params, staffEntity.getToken(),
					ServerCenterContants.FINANCE_CENTER_QUERY_CAPITALPOOL, CapitalPool.class);
			
			if (pcb != null) {
				List<UserDetail> user = CachePoolComponent.getCustomers(staffEntity.getToken());
				List<Object> list = (ArrayList<Object>)pcb.getObj();
				CapitalPool capitalPool = null;
				for(Object info : list){
					capitalPool = (CapitalPool) info;
					for(UserDetail ud : user) {
						if (capitalPool.getOpt().equals(ud.getUserId().toString())) {
							capitalPool.setOpt(ud.getName());
							break;
						}
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
				RestCommonHelper helper = new RestCommonHelper();
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("centerId", centerId);
				ResponseEntity<String> result = helper.requestWithParams(
						URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_CENTER_CHARGE+"?money="+money+"&payNo"+payNo, staffEntity.getToken(), true,
						null, HttpMethod.POST,params);
				JSONObject json = JSONObject.fromObject(result.getBody());

				if (!json.getBoolean("success")) {
					throw new Exception("资金池充值失败，请联系技术人员！");
				}
			}
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}
}
