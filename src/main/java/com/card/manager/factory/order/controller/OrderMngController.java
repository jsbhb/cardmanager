package com.card.manager.factory.order.controller;

import java.util.ArrayList;
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
import com.card.manager.factory.order.model.OrderGoods;
import com.card.manager.factory.order.model.OrderInfo;
import com.card.manager.factory.order.model.PushUser;
import com.card.manager.factory.order.model.ThirdOrderInfo;
import com.card.manager.factory.order.model.UserDetail;
import com.card.manager.factory.order.service.OrderService;
import com.card.manager.factory.supplier.model.SupplierEntity;
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
		context.put("supplierId", CachePoolComponent.getSupplier(opt.getToken()));
		context.put("centerId", CachePoolComponent.getCenter(opt.getToken()));
		context.put("shopId", CachePoolComponent.getShop(opt.getToken()));
		return forword("order/stockout/list", context);
	}

	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, OrderInfo pagination) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			pagination.setOrderId(req.getParameter("orderId"));

			List<OrderGoods> orderGoodsList = null;
			OrderGoods orderGoods = null;
			String itemId = req.getParameter("itemId");
			if (!StringUtil.isEmpty(itemId)) {
				orderGoods = new OrderGoods();
				orderGoods.setItemId(itemId);
			}
			String itemCode = req.getParameter("itemCode");
			if (!StringUtil.isEmpty(itemCode)) {
				if (orderGoods != null) {
					orderGoods.setItemCode(itemCode);
				} else {
					orderGoods = new OrderGoods();
					orderGoods.setItemCode(itemCode);
				}
			}
			if (orderGoods != null) {
				orderGoodsList = new ArrayList<OrderGoods>();
				orderGoodsList.add(orderGoods);
				pagination.setOrderGoodsList(orderGoodsList);
			}
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
			String centerId = req.getParameter("centerId");
			if (!StringUtil.isEmpty(centerId)) {
				pagination.setCenterId(Integer.parseInt(centerId));
			}
			String shopId = req.getParameter("shopId");
			if (!StringUtil.isEmpty(shopId)) {
				pagination.setShopId(Integer.parseInt(shopId));
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
					ServerCenterContants.ORDER_CENTER_QUERY_FOR_PAGE, OrderInfo.class);
			
			if (pcb != null) {
				List<UserDetail> user = CachePoolComponent.getCustomers(staffEntity.getToken());
				List<PushUser> push = CachePoolComponent.getPushUsers(staffEntity.getToken());
				List<Object> list = (ArrayList<Object>)pcb.getObj();
				OrderInfo orderInfo = null;
				for(Object info : list){
					orderInfo = (OrderInfo) info;
					for(UserDetail ud : user) {
						if (orderInfo.getUserId().toString().equals(ud.getUserId().toString())) {
							orderInfo.setCustomerName(ud.getName());
							break;
						}
					}
					if (orderInfo.getPushUserId() != null) {
						for(PushUser pu : push) {
							if (orderInfo.getShopId().toString().equals(pu.getGradeId().toString()) && orderInfo.getPushUserId().toString().equals(pu.getUserId().toString())) {
								orderInfo.setPushUserName(pu.getName());
								break;
							}
						}
					}
				}
				pcb.setObj(list);
			}
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
			List<SupplierEntity> supplier = CachePoolComponent.getSupplier(opt.getToken());
			for(SupplierEntity sup : supplier) {
				if (entity.getSupplierId() == null) {
					break;
				}
				if (sup.getId() == entity.getSupplierId()) {
					entity.setSupplierName(sup.getSupplierName());
					break;
				}
			}
			List<StaffEntity> center = CachePoolComponent.getCenter(opt.getToken());
			for(StaffEntity cen : center) {
				if (entity.getCenterId() == null) {
					break;
				}
				if (cen.getGradeId() == entity.getCenterId()) {
					entity.setCenterName(cen.getGradeName());
					break;
				}
			}
			List<StaffEntity> shop = CachePoolComponent.getShop(opt.getToken());
			for(StaffEntity sh : shop) {
				if (entity.getShopId() == null) {
					break;
				}
				if (sh.getShopId() == entity.getShopId()) {
					entity.setShopName(sh.getGradeName());
					break;
				}
			}
			List<ThirdOrderInfo> orderExpressList = orderService.queryThirdOrderInfoByOrderId(orderId, opt.getToken());
			context.put("orderExpressList", orderExpressList);
			return forword("order/stockout/show", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
	}
}
