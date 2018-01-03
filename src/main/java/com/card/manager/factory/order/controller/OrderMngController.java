package com.card.manager.factory.order.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.base.PageCallBack;
import com.card.manager.factory.base.Pagination;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.order.model.OrderGoods;
import com.card.manager.factory.order.model.OrderInfo;
import com.card.manager.factory.order.service.OrderService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

@Controller
@RequestMapping("/admin/order/stockOutMng")
public class OrderMngController extends BaseController {

	@Resource
	OrderService orderService;

	@RequestMapping(value = "/mng")
	public ModelAndView toFuncList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("mall/index/mng", context);
	}

	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		return forword("order/stockout/list", context);
	}

	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, Pagination pagination) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {

			String orderId = req.getParameter("orderId");
			if (StringUtil.isEmpty(orderId)) {
				params.put("orderId", "");
			} else {
				params.put("orderId", orderId);
			}
			String status = req.getParameter("status");
			if (StringUtil.isEmpty(status)) {
				params.put("status", "");
			} else {
				params.put("status", status);
			}
			String supplierId = req.getParameter("supplierId");
			if (StringUtil.isEmpty(supplierId)) {
				params.put("supplierId", "");
			} else {
				params.put("supplierId", supplierId);
			}

			pcb = orderService.dataList(pagination, params, staffEntity.getToken(),
					ServerCenterContants.ORDER_CENTER_QUERY_FOR_PAGE, OrderInfo.class);
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
	
	@RequestMapping(value = "/dataListForOrderGoods", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataListForOrderGoods(HttpServletRequest req, HttpServletResponse resp, Pagination pagination) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			
			String orderId = req.getParameter("orderId");
			if (StringUtil.isEmpty(orderId)) {
				params.put("orderId", "");
			} else {
				params.put("orderId", orderId);
			}
			
			pcb = orderService.dataList(pagination, params, staffEntity.getToken(),
					ServerCenterContants.ORDER_CENTER_QUERY_GOODS_FOR_PAGE, OrderGoods.class);
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
			String orderId = req.getParameter("orderId");
			OrderInfo entity = orderService.queryByOrderId(orderId, opt.getToken());
			context.put("order", entity);
			return forword("order/stockout/show", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
	}
}
