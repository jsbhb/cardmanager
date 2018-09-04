package com.card.manager.factory.order.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;
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
import com.card.manager.factory.base.Pagination;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.component.model.GradeBO;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.order.model.OrderGoods;
import com.card.manager.factory.order.model.OrderInfo;
import com.card.manager.factory.order.model.PushUser;
import com.card.manager.factory.order.model.ThirdOrderInfo;
import com.card.manager.factory.order.model.UserDetail;
import com.card.manager.factory.order.pojo.ExpressMaintenanceBO;
import com.card.manager.factory.order.pojo.OrderInfoListForDownload;
import com.card.manager.factory.order.pojo.OrderMaintenanceBO;
import com.card.manager.factory.order.service.OrderService;
import com.card.manager.factory.supplier.model.SupplierEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.DateUtil;
import com.card.manager.factory.util.ExcelUtil;
import com.card.manager.factory.util.FileDownloadUtil;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;
import com.card.manager.factory.util.TreePackUtil;

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
		Map<Integer, GradeBO> map = CachePoolComponent.getGrade(opt.getToken());
		List<GradeBO> list = new ArrayList<GradeBO>();
		List<GradeBO> result = new ArrayList<>();
		for (Map.Entry<Integer, GradeBO> entry : map.entrySet()) {
			list.add(entry.getValue());
		}
		result = TreePackUtil.packGradeChildren(list, opt.getGradeId());
		Collections.sort(result);
		context.put("list", result);

		// set page privilege
		if (opt.getRoleId() == 1) {
			context.put("prilvl", "1");
		} else {
			context.put("prilvl", req.getParameter("privilege"));
		}
		return forword("order/stockout/list", context);
	}

	@SuppressWarnings("unchecked")
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
			String itemName = req.getParameter("itemName");
			if (!StringUtil.isEmpty(itemName)) {
				if (orderGoods != null) {
					orderGoods.setItemName(itemName);
				} else {
					orderGoods = new OrderGoods();
					orderGoods.setItemName(itemName);
				}
			}
			if (orderGoods != null) {
				orderGoodsList = new ArrayList<OrderGoods>();
				orderGoodsList.add(orderGoods);
				pagination.setOrderGoodsList(orderGoodsList);
			}
			
			List<ThirdOrderInfo> orderExpressList = null;
			ThirdOrderInfo thirdOrderInfo = null;
			String expressId = req.getParameter("expressId");
			if (!StringUtil.isEmpty(expressId)) {
				thirdOrderInfo = new ThirdOrderInfo();
				thirdOrderInfo.setExpressId(expressId);
			}
			if (thirdOrderInfo != null) {
				orderExpressList = new ArrayList<ThirdOrderInfo>();
				orderExpressList.add(thirdOrderInfo);
				pagination.setOrderExpressList(orderExpressList);
			}
			
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

			Integer gradeId = staffEntity.getGradeId();
			if (gradeId != 0 && gradeId != null) {
				pagination.setShopId(gradeId);
			}
			String gradeIdStr = req.getParameter("gradeId");
			if (gradeIdStr != null) {
				pagination.setShopId(Integer.valueOf(gradeIdStr));
			}

			pcb = orderService.dataList(pagination, params, staffEntity.getToken(),
					ServerCenterContants.ORDER_CENTER_QUERY_FOR_PAGE, OrderInfo.class);

			if (pcb != null) {
				List<UserDetail> user = CachePoolComponent.getCustomers(staffEntity.getToken());
				List<PushUser> push = CachePoolComponent.getPushUsers(staffEntity.getToken());
				List<Object> list = (ArrayList<Object>) pcb.getObj();
				OrderInfo orderInfo = null;
				for (Object info : list) {
					orderInfo = (OrderInfo) info;
					for (UserDetail ud : user) {
						if (orderInfo.getUserId().toString().equals(ud.getUserId().toString())) {
							orderInfo.setCustomerName(ud.getName());
							break;
						}
					}
					if (orderInfo.getPushUserId() != null) {
						for (PushUser pu : push) {
							if (orderInfo.getShopId().toString().equals(pu.getGradeId().toString())
									&& orderInfo.getPushUserId().toString().equals(pu.getUserId().toString())) {
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
			

			List<OrderGoods> list = (List<OrderGoods>) pcb.getObj();
			if (pcb != null) {
				for (OrderGoods info : list) {
					String infoStr = info.getItemInfo();
					if (infoStr != null && !"".equals(infoStr)) {
						String tmpStr = "";
						infoStr = infoStr.replace("{", "").replace("}", "");
						String[] infoArr = infoStr.split(",");
						for (int i = 0; i < infoArr.length; i++) {
							tmpStr = tmpStr + infoArr[i].replace("\"", "") + "|";
						}
						
						info.setItemInfo(tmpStr.substring(0, tmpStr.length()-1));
					}
				}
				pcb.setObj(list);
			}
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
			for (SupplierEntity sup : supplier) {
				if (entity.getSupplierId() == null) {
					break;
				}
				if (sup.getId() == entity.getSupplierId()) {
					entity.setSupplierName(sup.getSupplierName());
					break;
				}
			}
			List<StaffEntity> center = CachePoolComponent.getCenter(opt.getToken());
			for (StaffEntity cen : center) {
				if (entity.getCenterId() == null) {
					break;
				}
				if (cen.getGradeId() == entity.getCenterId()) {
					entity.setCenterName(cen.getGradeName());
					break;
				}
			}
			if (entity.getShopId() != null) {
				GradeBO grade = CachePoolComponent.getGrade(opt.getToken()).get(entity.getShopId());
				if (grade != null) {
					entity.setShopName(grade.getName());
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

	@RequestMapping(value = "/excelExport")
	public ModelAndView excelExport(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity opt = SessionUtils.getOperator(req);
		Map<String, Object> context = getRootMap();
		context.put("supplierId", CachePoolComponent.getSupplier(opt.getToken()));
		//分级信息
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
		return forword("order/stockout/excelExport", context);
	}

	@RequestMapping(value = "/downLoadExcel")
	public void downLoadFile(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String dateType = req.getParameter("dateType");
			String startTime = req.getParameter("startTime");
			String endTime = req.getParameter("endTime");
			String supplierId = req.getParameter("supplierId");
			String gradeId = req.getParameter("gradeId");
			Date date = new Date();
			// 当选择了指定日期时
			if ("1".equals(dateType)) {
				startTime = DateUtil.getDateBetween_String(date, -7, "yyyy-MM-dd");
				endTime = DateUtil.getNowFormateDate();
			} else if ("2".equals(dateType)) {
				startTime = DateUtil.getNowYear()+"-"+DateUtil.getNowMonth()+"-01";
				endTime = DateUtil.getNowFormateDate();
			}
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("startTime", startTime);
			param.put("endTime", endTime);
			param.put("gradeId", gradeId);
			param.put("supplierId", supplierId);

			List<OrderInfoListForDownload> ReportList = new ArrayList<OrderInfoListForDownload>();
			ReportList = orderService.queryOrderInfoListForDownload(param, staffEntity.getToken());

			String tmpOrderId = "";
			String tmpExpressInfo = "";
			String tmpItemInfo = "";
			String tmpReceiveProvince = "";
			for (OrderInfoListForDownload oi : ReportList) {
				switch (oi.getStatus()) {
				case 0:	oi.setStatusName("待支付");break;
				case 1:	oi.setStatusName("已付款");break;
				case 2:	oi.setStatusName("支付单报关");break;
				case 3:	oi.setStatusName("已发仓库");	break;
				case 4:	oi.setStatusName("已报海关");	break;
				case 5:	oi.setStatusName("单证放行");	break;
				case 6:	oi.setStatusName("已发货");break;
				case 7:	oi.setStatusName("已收货");break;
				case 8:	oi.setStatusName("退单");break;
				case 9:	oi.setStatusName("超时取消");	break;
				case 11:oi.setStatusName("资金池不足");break;
				case 12:oi.setStatusName("待发货");break;
				case 21:oi.setStatusName("退款中");break;
				case 99:oi.setStatusName("异常状态");	break;
				}
				
				switch (oi.getPayType()) {
				case 1:	oi.setPayTypeName("微信");break;
				case 2:	oi.setPayTypeName("支付宝");break;
				case 3:	oi.setPayTypeName("银联");break;
				case 4:	oi.setPayTypeName("转账");break;
				case 5:	oi.setPayTypeName("其他");break;
				case 6:	oi.setPayTypeName("月结");break;
				}
				
				switch (oi.getOrderSource()) {
				case 0:	oi.setOrderSourceName("PC商城");break;
				case 1:	oi.setOrderSourceName("手机商城");break;
				case 2:	oi.setOrderSourceName("订货平台");break;
				case 3:	oi.setOrderSourceName("有赞");break;
				case 4:	oi.setOrderSourceName("线下");break;
				case 5:	oi.setOrderSourceName("展厅");break;
				case 6:	oi.setOrderSourceName("大客户");break;
				case 7:	oi.setOrderSourceName("福利商城");break;
				}
				
				switch (oi.getOrderFlg()) {
				case 0:	oi.setOrderFlgName("跨境");break;
				case 1:	oi.setOrderFlgName("大贸");break;
				case 2:	oi.setOrderFlgName("一般贸易");break;
				}

				if (!tmpOrderId.equals(oi.getOrderId())) {
					tmpOrderId = oi.getOrderId();
					tmpExpressInfo = "";
					Map<String, Object> express = new HashMap<String, Object>();
					for (ThirdOrderInfo toi : oi.getOrderExpressList()) {
						if (toi.getExpressName() == null || toi.getExpressName() == ""
								|| toi.getExpressId() == null || toi.getExpressId() == "") {
							continue;
						}
						if (express.containsKey(toi.getExpressName())) {
							express.put(toi.getExpressName(),
									express.get(toi.getExpressName()) + "," + toi.getExpressId());
						} else {
							express.put(toi.getExpressName(), toi.getExpressId());
						}
					}
					for (Map.Entry<String, Object> entry : express.entrySet()) {
						tmpExpressInfo += entry.getKey() + ":" + entry.getValue() + "|";
					}
					if (tmpExpressInfo.length() > 0) {
						tmpExpressInfo = tmpExpressInfo.substring(0, tmpExpressInfo.length() - 1);
					}
				}
				oi.setExpressInfo(tmpExpressInfo);
				
				if (oi.getItemInfo() != null) {
					tmpItemInfo = oi.getItemInfo();
					tmpItemInfo = tmpItemInfo.replace("\"", "");
					tmpItemInfo = tmpItemInfo.replace("{", "");
					tmpItemInfo = tmpItemInfo.replace("}", "");
					oi.setItemInfo(tmpItemInfo);
				}
				
				//收件信息省市区拼起来，中间用空格隔开
				tmpReceiveProvince = oi.getReceiveProvince() + " " + oi.getReceiveCity() + " " + oi.getReceiveArea();
				oi.setReceiveProvince(tmpReceiveProvince);
			}

			WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
			ServletContext servletContext = webApplicationContext.getServletContext();

			String fileName = "order_" + DateUtil.getNowLongTime() + ".xlsx";
			String filePath = servletContext.getRealPath("/") + "EXCEL/" + staffEntity.getBadge() + "/" + fileName;

			String[] nameArray = null;
			String[] colArray = null;
			//广州仓
			if ("5".equals(supplierId)) {
				nameArray = new String[] { "订单号", "状态", "区域中心", "供应商", "自有编码", "品名","零售价", "商品规格", "订单数量", "商品数量", "一级类目", "二级类目", "三级类目",
						"订单来源", "订单类型", "支付金额", "邮费金额", "税费金额", "支付方式", "支付流水号", "支付时间", "收件人", "收件电话", "省市区", "收件信息", "下单时间", "物流信息", 
						"收货时间", "订购人", "订购人身份证", "包装数", "商品购买价格"};
				colArray = new String[] { "OrderId", "StatusName", "GradeName", "SupplierName", "Sku", "ItemName",
						"ActualPrice", "ItemInfo", "ItemQuantity", "Packing", "FirstName", "SecondName", "ThirdName", "OrderSourceName", "OrderFlgName", "Payment",
						"PostFee", "TaxFee", "PayTypeName", "PayNo", "PayTime", "ReceiveName", "ReceivePhone", "ReceiveProvince",
						"ReceiveAddress", "CreateTime", "ExpressInfo", "DeliveryTime", "OrderName", "Idnum", "Packing", "ActualPrice" };
			} else {
				nameArray = new String[] { "订单号", "状态", "区域中心", "供应商", "自有编码", "品名","零售价", "商品规格", "订单数量", "商品数量", "一级类目", "二级类目", "三级类目",
						"订单来源", "订单类型", "支付金额", "邮费金额", "税费金额", "支付方式", "支付流水号", "支付时间", "收件人", "收件电话", "省市区", "收件信息", "下单时间", "物流信息", "收货时间"};
				colArray = new String[] { "OrderId", "StatusName", "GradeName", "SupplierName", "Sku", "ItemName",
						"ActualPrice", "ItemInfo", "ItemQuantity", "Packing", "FirstName", "SecondName", "ThirdName", "OrderSourceName", "OrderFlgName", "Payment", "PostFee", "TaxFee",
						"PayTypeName", "PayNo", "PayTime", "ReceiveName", "ReceivePhone", "ReceiveProvince", "ReceiveAddress", "CreateTime", "ExpressInfo", "DeliveryTime" };
			}
			SXSSFWorkbook swb = new SXSSFWorkbook(100);
			ExcelUtil.createExcel(ReportList, nameArray, colArray, filePath, 0, startTime+"~"+endTime, swb);
			ExcelUtil.writeToExcel(swb, filePath);

			FileDownloadUtil.downloadFileByBrower(req, resp, filePath, fileName);
		} catch (Exception e) {
			resp.setContentType("text/html;charset=utf-8");
			resp.getWriter().println("下载失败，请重试!");
			resp.getWriter().println(e.getMessage());
			return;
		}
	}

	@RequestMapping(value = "/logistics")
	public ModelAndView logistics(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {
			String orderId = req.getParameter("orderId");
			OrderInfo entity = orderService.queryByOrderId(orderId, opt.getToken());
			context.put("order", entity);
			List<SupplierEntity> supplier = CachePoolComponent.getSupplier(opt.getToken());
			for (SupplierEntity sup : supplier) {
				if (entity.getSupplierId() == null) {
					break;
				}
				if (sup.getId() == entity.getSupplierId()) {
					entity.setSupplierName(sup.getSupplierName());
					break;
				}
			}
			List<ThirdOrderInfo> orderExpressList = orderService.queryThirdOrderInfoByOrderId(orderId, opt.getToken());
			context.put("orderExpressList", orderExpressList);
			return forword("order/stockout/logistics", context);
		}catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
	}

	@RequestMapping(value = "/updateLogistics")
	public void updateLogistics(HttpServletRequest req, HttpServletResponse resp, @RequestBody List<ExpressMaintenanceBO> list) {
		StaffEntity opt = SessionUtils.getOperator(req);
		try {
			if (list.size() <= 0) {
				sendFailureMessage(resp, "操作失败：物流信息为空");
				return;
			}
			List<OrderMaintenanceBO> orderMaintenanceBO = new ArrayList<OrderMaintenanceBO>();
			OrderMaintenanceBO orderMaintenance = new OrderMaintenanceBO();
			ExpressMaintenanceBO expressMaintenance = list.get(0);
			orderMaintenance.setOrderId(expressMaintenance.getOrderId());
			orderMaintenance.setSupplierId(expressMaintenance.getSupplierId());
			orderMaintenance.setExpressList(list);
			orderMaintenanceBO.add(orderMaintenance);
			orderService.maintenanceExpress(orderMaintenanceBO, opt);
		} catch (Exception e) {
			sendFailureMessage(resp, e.getMessage());
			return;
		}
		sendSuccessMessage(resp, "保存成功");
	}

	@RequestMapping(value = "/readExcelForMaintain", method = RequestMethod.POST)
	public void readExcelForMaintain(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String filePath = req.getParameter("filePath");
			if (StringUtil.isEmpty(filePath)) {
				sendFailureMessage(resp, "操作失败：文件路径不正确");
				return;
			}
			List<Object> list = ExcelUtil.getCache(filePath,"order");
			if (list.size()<= 0) {
				sendFailureMessage(resp, "操作失败：无订单需维护物流信息");
				return;
			}
			List<OrderMaintenanceBO> orderList = new ArrayList<OrderMaintenanceBO>();
			List<ExpressMaintenanceBO> expressList = new ArrayList<ExpressMaintenanceBO>();
			OrderMaintenanceBO order = new OrderMaintenanceBO();
			ExpressMaintenanceBO exp = null;
			for (Object info : list) {
				exp = (ExpressMaintenanceBO) info;
				if (!exp.getOrderId().equals(order.getOrderId())) {
					order.setExpressList(expressList);
					orderList.add(order);
					
					order = new OrderMaintenanceBO();
					order.setOrderId(exp.getOrderId());
					expressList = new ArrayList<ExpressMaintenanceBO>();
				}
				expressList.add(exp);
			}
			order.setExpressList(expressList);
			orderList.add(order);
			//删除第一位空白数据
			orderList.remove(0);

			orderService.maintenanceExpress(orderList, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/downLoadOrderModelExcel")
	public void downLoadOrderModelExcel(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		try {
			WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
			ServletContext servletContext = webApplicationContext.getServletContext();

			String fileName = "order_model.xlsx";
			String filePath = servletContext.getRealPath("/") + "WEB-INF/classes/" + fileName;

			FileDownloadUtil.downloadFileByBrower(req, resp, filePath, fileName);
		} catch (Exception e) {
			resp.setContentType("text/html;charset=utf-8");
			resp.getWriter().println("下载失败，请重试!");
			resp.getWriter().println(e.getMessage());
			return;
		}
	}
	
	@RequestMapping(value = "/downLoadOrderImportExcel")
	public void downLoadOrderImportExcel(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		try {
			StaffEntity staffEntity = SessionUtils.getOperator(req);
			orderService.downLoadOrderImportExcel(req, resp, staffEntity);
		} catch (Exception e) {
			e.printStackTrace();
			resp.setContentType("text/html;charset=utf-8");
			resp.getWriter().println("下载失败，请重试!");
			resp.getWriter().println(e.getMessage());
			return;
		}
	}
	
	@RequestMapping(value = "/orderMaintain")
	public ModelAndView orderMaintain(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("order/stockout/maintain_choose", context);
	}
	
	@RequestMapping(value = "/toAddBatch")
	public ModelAndView toAddBatch(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		return forword("order/stockout/orderImport", context);
	}

	
	@RequestMapping(value = "/importOrder")
	public void importOrder(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String filePath = req.getParameter("filePath");
			if (StringUtil.isEmpty(filePath)) {
				sendFailureMessage(resp, "操作失败：文件路径不正确");
				return;
			}
			Map<String, Object> result = orderService.importOrder(filePath, staffEntity);
			if ((boolean) result.get("success")) {
				sendSuccessMessage(resp, result.get("msg") + "");
			} else {
				sendFailureMessage(resp, result.get("msg") + "");
			}
		} catch (Exception e) {
			e.printStackTrace();
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
	}
	
	@RequestMapping(value = "/toLogisticsBatch")
	public ModelAndView toLogisticsBatch(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		return forword("order/stockout/logisticsImport", context);
	}

	@RequestMapping(value = "/sendStockInGoodsInfoToMJY", method = RequestMethod.POST)
	public void sendStockInGoodsInfoToMJY(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String orderId = req.getParameter("orderId");
			if (StringUtil.isEmpty(orderId)) {
				sendFailureMessage(resp, "操作失败：订单号获取失败");
				return;
			}
			orderService.sendStockInGoodsInfoToMJYByOrderId(orderId, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/sendStockOutGoodsInfoToMJY", method = RequestMethod.POST)
	public void sendStockOutGoodsInfoToMJY(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String orderId = req.getParameter("orderId");
			if (StringUtil.isEmpty(orderId)) {
				sendFailureMessage(resp, "操作失败：订单号获取失败");
				return;
			}
			orderService.sendStockOutGoodsInfoToMJYByOrderId(orderId, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

}
