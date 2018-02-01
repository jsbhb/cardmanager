package com.card.manager.factory.order.controller;

import java.util.HashMap;
import java.util.List;
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
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.order.model.OperatorEntity;
import com.card.manager.factory.order.model.OrderGoods;
import com.card.manager.factory.order.model.OrderInfo;
import com.card.manager.factory.order.model.PurchaseOrderInfo;
import com.card.manager.factory.order.service.OrderService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

@Controller
@RequestMapping("/admin/order/purchaseMng")
public class PurchaseOrderMngController extends BaseController {

	@Resource
	OrderService orderService;

	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
//		Map<String, Object> context = getRootMap();
//		StaffEntity opt = SessionUtils.getOperator(req);
//		List<OperatorEntity> operators= orderService.queryOperatorInfoByOpt(opt);
//		//除门店外都要添加一条全部查询的空记录
//		if (opt.getGradeLevel() != 3) {
//			OperatorEntity oper = new OperatorEntity();
//			oper.setGradeName("未选择");
//			operators.add(0, oper);
//		}
//		context.put(OPT, opt);
//		context.put("operators", operators);
//		return forword("order/purchase/list", context);
		
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		context.put("supplierId", CachePoolComponent.getSupplier(opt.getToken()));
		return forword("order/purchase/list2", context);
	}
	
	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, OrderInfo pagination) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {

			String userIds = "";
			if (staffEntity.getParentGradeId() != 0) {
				//根据用户登录信息进行判断需要拼接的人员ID
				List<OperatorEntity> operators= orderService.queryOperatorInfoByOpt(staffEntity);
				for(OperatorEntity oe : operators) {
					userIds = userIds + "'" + oe.getUserCenterId() + "',";
				}
				//去除最后一个“,”号
				if (!"".equals(userIds)) {
					userIds = userIds.substring(0, userIds.length() -1);
				}
			}
			pagination.setRemark(userIds);
			
			pagination.setOrderId(req.getParameter("orderId"));

			// String orderId = req.getParameter("orderId");
			// if (StringUtil.isEmpty(orderId)) {
			// params.put("orderId", "");
			// } else {
			// params.put("orderId", orderId);
			// }
			String status = req.getParameter("status");
			if (!StringUtil.isEmpty(status)) {
				pagination.setStatus(Integer.parseInt(status));
			}
			String supplierId = req.getParameter("supplierId");
			if (!StringUtil.isEmpty(supplierId)) {
				pagination.setSupplierId(Integer.parseInt(supplierId));
			}

			int gradeLevel = staffEntity.getGradeLevel();
			if (ServerCenterContants.FIRST_GRADE == gradeLevel) {
			} else if (ServerCenterContants.SECOND_GRADE == gradeLevel) {
				pagination.setCenterId(staffEntity.getGradeId());
				pagination.setShopId(staffEntity.getShopId());
			} else if (ServerCenterContants.THIRD_GRADE == gradeLevel) {
				pagination.setCenterId(staffEntity.getParentGradeId());
				pagination.setShopId(staffEntity.getShopId());
			} else {
				if (pcb == null) {
					pcb = new PageCallBack();
				}
				pcb.setPagination(pagination);
				pcb.setSuccess(true);
				return pcb;
			}

			pcb = orderService.dataList(pagination, params, staffEntity.getToken(),
					ServerCenterContants.ORDER_CENTER_QUERY_PURCHASE_FOR_PAGE, OrderInfo.class);
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

//	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
//	@ResponseBody
//	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, PurchaseOrderInfo pagination) {
//		PageCallBack pcb = null;
//		StaffEntity staffEntity = SessionUtils.getOperator(req);
//		Map<String, Object> params = new HashMap<String, Object>();
//		try {
//			//添加检索条件
//			String startTime = req.getParameter("startTime");
//			if (!StringUtil.isEmpty(startTime)) {
//				pagination.setStartTime(startTime);
//			}
//			String endTime = req.getParameter("endTime");
//			if (!StringUtil.isEmpty(endTime)) {
//				pagination.setEndTime(endTime);
//			}
//			String orderId = req.getParameter("orderId");
//			if (!StringUtil.isEmpty(orderId)) {
//				pagination.setOrderId(orderId);
//			}
////			String userCenterId = req.getParameter("userCenterId");
////			if (!StringUtil.isEmpty(userCenterId)) {
////				pagination.setCenterId(Integer.parseInt(userCenterId));
////			}
////			String goodsId = req.getParameter("goodsId");
////			if (!StringUtil.isEmpty(goodsId)) {
////				pagination.setGoodsId(goodsId);
////			}
////			String goodsName = req.getParameter("goodsName");
////			if (!StringUtil.isEmpty(goodsName)) {
////				pagination.setGoodsName(goodsName);
////			}
//			pcb = orderService.dataList(pagination, params, staffEntity.getToken(),
//					ServerCenterContants.ORDER_CENTER_QUERY_PURCHASE_FOR_PAGE, PurchaseOrderInfo.class);
//		} catch (ServerCenterNullDataException e) {
//			if (pcb == null) {
//				pcb = new PageCallBack();
//			}
//			pcb.setPagination(pagination);
//			pcb.setSuccess(true);
//			return pcb;
//		} catch (Exception e) {
//			if (pcb == null) {
//				pcb = new PageCallBack();
//			}
//			pcb.setErrTrace(e.getMessage());
//			pcb.setSuccess(false);
//			return pcb;
//		}
//
//		return pcb;
//	}

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
