package com.card.manager.factory.user.controller;

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
import com.card.manager.factory.finance.model.RebateSearchModel;
import com.card.manager.factory.goods.service.GoodsService;
import com.card.manager.factory.order.model.OrderGoods;
import com.card.manager.factory.order.model.OrderInfo;
import com.card.manager.factory.order.model.ThirdOrderInfo;
import com.card.manager.factory.order.model.UserInfo;
import com.card.manager.factory.order.pojo.OrderInfoListForDownload;
import com.card.manager.factory.order.service.OrderService;
import com.card.manager.factory.supplier.model.SupplierEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.service.StaffMngService;
import com.card.manager.factory.user.model.CenterRebate;
import com.card.manager.factory.user.model.Rebate;
import com.card.manager.factory.user.model.RebateDetail;
import com.card.manager.factory.user.model.ShopRebate;
import com.card.manager.factory.user.service.FinanceMngService;
import com.card.manager.factory.util.CalculationUtils;
import com.card.manager.factory.util.DateUtil;
import com.card.manager.factory.util.ExcelUtil;
import com.card.manager.factory.util.FileDownloadUtil;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;
import com.card.manager.factory.util.TreePackUtil;

@Controller
@RequestMapping("/admin/user/rebateMng")
public class RebateMngController extends BaseController {

	@Resource
	FinanceMngService financeMngService;

	@Resource
	StaffMngService staffMngService;
	
	@Resource
	OrderService orderService;
	
	@Resource
	GoodsService goodsService;

	@RequestMapping(value = "/mng")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		Integer gradeId = opt.getGradeId();
		List<GradeBO> list = new ArrayList<GradeBO>();
		List<GradeBO> result = new ArrayList<>();
		Map<Integer, GradeBO> map = CachePoolComponent.getGrade(opt.getToken());
		for (Map.Entry<Integer, GradeBO> entry : map.entrySet()) {
			list.add(entry.getValue());
		}
//		if (gradeId != 0) {
//			TreePackUtil.packGradeChildren(list, result, gradeId);
//			GradeBO grade = map.get(gradeId);
//			result.add(grade);
//		} else {
//			result.addAll(list);
//		}
		result = TreePackUtil.packGradeChildren(list, gradeId);
		Collections.sort(result);
		context.put("list", result);
		// set page privilege
		if (opt.getRoleId() == 1) {
			context.put("prilvl", "1");
		} else {
			context.put("prilvl", req.getParameter("privilege"));
		}
		return forword("/user/rebate/list", context);
	}

	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, RebateDetail pagination) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		Integer gradeId = pagination.getGradeId();
		Rebate rebate = financeMngService.queryRebate(gradeId, staffEntity.getToken());
		if (rebate.getCanBePresented() != null) {
			rebate.setCanBePresented(CalculationUtils.round(2, Double.valueOf(rebate.getCanBePresented())));
		}
		if (rebate.getAlreadyPresented() != null) {
			rebate.setAlreadyPresented(CalculationUtils.round(2, Double.valueOf(rebate.getAlreadyPresented())));
		}
		if (rebate.getStayToAccount() != null) {
			rebate.setStayToAccount(CalculationUtils.round(2, Double.valueOf(rebate.getStayToAccount())));
		}
		try {
			pcb = financeMngService.dataList(pagination, params, staffEntity.getToken(),
					ServerCenterContants.FINANCE_CENTER_REBATE_DETAIL_QUERY, RebateDetail.class);
			pcb.setObject(rebate);
		} catch (ServerCenterNullDataException e) {
			if (pcb == null) {
				pcb = new PageCallBack();
			}
			pcb.setPagination(pagination);
			pcb.setSuccess(true);
			pcb.setObject(rebate);
			return pcb;
		} catch (Exception e) {
			if (pcb == null) {
				pcb = new PageCallBack();
			}
			pcb.setErrTrace(e.getMessage());
			pcb.setSuccess(false);
			pcb.setObject(rebate);
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
			String gradeId = req.getParameter("gradeId");
			OrderInfo entity = orderService.queryByOrderId(orderId, opt.getToken());
			context.put("order", entity);
			UserInfo user = orderService.queryUserInfoByUserId(entity.getUserId()+"", opt.getToken());
			context.put("user", user);
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
			if (entity.getShopId() != null) {
				GradeBO grade = CachePoolComponent.getGrade(opt.getToken()).get(entity.getShopId());
				if (grade != null) {
					entity.setShopName(grade.getName());
				}
			}
			List<ThirdOrderInfo> orderExpressList = orderService.queryThirdOrderInfoByOrderId(orderId, opt.getToken());
			context.put("orderExpressList", orderExpressList);
			context.put("gradeId", gradeId);
			return forword("user/rebate/show", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
	}

	@RequestMapping(value = "/dataListForOrderGoods", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataListForOrderGoods(HttpServletRequest req, HttpServletResponse resp, Pagination pagination) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {

			String orderId = req.getParameter("orderId");
			String shopId = req.getParameter("shopId");
			String gradeId = req.getParameter("gradeId");
			if (StringUtil.isEmpty(orderId)) {
				params.put("orderId", "");
			} else {
				params.put("orderId", orderId);
			}

			pcb = orderService.dataList(pagination, params, staffEntity.getToken(),
					ServerCenterContants.ORDER_CENTER_QUERY_GOODS_FOR_PAGE, OrderGoods.class);
			
			if (pcb != null) {
				List<OrderGoods> list = (ArrayList<OrderGoods>) pcb.getObj();
				OrderGoods orderGoods = null;
				Map<String, String> rebateMap = null;
				Map<Integer, GradeBO> map = CachePoolComponent.getGrade(staffEntity.getToken());
				for(OrderGoods goods : list){
					if(goods.getRebate() != null){
						try {
							rebateMap = JSONUtilNew.parse(goods.getRebate(), Map.class);
							goods.setRebate(rebateMap.get(gradeId) == null ? "0" : rebateMap.get(gradeId));
						} catch (Exception e) {
							goods.setRebate("0");
						}
					} else {
						goods.setRebate("0");
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

	@RequestMapping(value = "/querySecondCatalogByFirstId")
	public void querySecondCatalogByFirstId(HttpServletRequest req, HttpServletResponse resp) {
		String firstId = req.getParameter("firstId");
		Map<String, String> params = new HashMap<String, String>();
		params.put("parentGradeId", firstId);
		List<StaffEntity> shopId = staffMngService.queryByParam(params);
		sendSuccessObject(resp, shopId);
	}

	@RequestMapping(value = "/adminCheckDataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack adminCheckDataList(HttpServletRequest req, HttpServletResponse resp,
			RebateSearchModel pagination) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			String firstCatalogId = req.getParameter("firstCatalogId");
			String secondCatalogId = req.getParameter("secondCatalogId");
			List<String> ids = new ArrayList<String>();
			// 查询所有区域中心
			if ("".equals(firstCatalogId)) {
				List<StaffEntity> centerId = CachePoolComponent.getCenter(staffEntity.getToken());
				for (StaffEntity center : centerId) {
					ids.add(center.getGradeId() + "");
				}
				pagination.setType(0);
				pagination.setList(ids);

				pcb = financeMngService.dataList(pagination, params, staffEntity.getToken(),
						ServerCenterContants.FINANCE_CENTER_WITHDRAWALS_ADMIN_CHECK, CenterRebate.class);
				if (pcb != null) {
					List<Object> list = (ArrayList<Object>) pcb.getObj();
					CenterRebate centerRebate = null;
					for (Object info : list) {
						centerRebate = (CenterRebate) info;
						for (StaffEntity center : centerId) {
							if (centerRebate.getCenterId() == center.getGradeId()) {
								centerRebate.setCenterName(center.getGradeName());
								break;
							}
						}
					}
					pcb.setObj(list);
				}
//				pcb.setType("0");
			} else if (!"".equals(firstCatalogId) && "-1".equals(secondCatalogId)) {
				List<StaffEntity> centerId = CachePoolComponent.getCenter(staffEntity.getToken());
				ids.add(firstCatalogId);
				pagination.setType(0);
				pagination.setList(ids);

				pcb = financeMngService.dataList(pagination, params, staffEntity.getToken(),
						ServerCenterContants.FINANCE_CENTER_WITHDRAWALS_ADMIN_CHECK, CenterRebate.class);
				if (pcb != null) {
					List<Object> list = (ArrayList<Object>) pcb.getObj();
					CenterRebate centerRebate = null;
					for (Object info : list) {
						centerRebate = (CenterRebate) info;
						for (StaffEntity center : centerId) {
							if (centerRebate.getCenterId() == center.getGradeId()) {
								centerRebate.setCenterName(center.getGradeName());
								break;
							}
						}
					}
					pcb.setObj(list);
				}
//				pcb.setType("0");
			} else if (!"".equals(firstCatalogId) && "".equals(secondCatalogId)) {
				Map<String, String> searchParams = new HashMap<String, String>();
				searchParams.put("parentGradeId", firstCatalogId);
				List<StaffEntity> shopId = staffMngService.queryByParam(searchParams);
				for (StaffEntity shop : shopId) {
					ids.add(shop.getShopId() + "");
				}
				pagination.setType(1);
				pagination.setList(ids);
				pcb = financeMngService.dataList(pagination, params, staffEntity.getToken(),
						ServerCenterContants.FINANCE_CENTER_WITHDRAWALS_ADMIN_CHECK, ShopRebate.class);
				if (pcb != null) {
					List<Object> list = (ArrayList<Object>) pcb.getObj();
					ShopRebate shopRebate = null;
					for (Object info : list) {
						shopRebate = (ShopRebate) info;
						for (StaffEntity shop : shopId) {
							if (shopRebate.getShopId() == shop.getShopId()) {
								shopRebate.setShopName(shop.getGradeName());
								;
								break;
							}
						}
					}
					pcb.setObj(list);
				}
//				pcb.setType("1");
			} else if (!"".equals(firstCatalogId) && !"".equals(secondCatalogId) && !"-1".equals(secondCatalogId)) {
				Map<String, String> searchParams = new HashMap<String, String>();
				searchParams.put("parentGradeId", firstCatalogId);
				List<StaffEntity> shopId = staffMngService.queryByParam(searchParams);
				ids.add(secondCatalogId);
				pagination.setType(1);
				pagination.setList(ids);
				pcb = financeMngService.dataList(pagination, params, staffEntity.getToken(),
						ServerCenterContants.FINANCE_CENTER_WITHDRAWALS_ADMIN_CHECK, ShopRebate.class);
				if (pcb != null) {
					List<Object> list = (ArrayList<Object>) pcb.getObj();
					ShopRebate shopRebate = null;
					for (Object info : list) {
						shopRebate = (ShopRebate) info;
						for (StaffEntity shop : shopId) {
							if (shopRebate.getShopId() == shop.getShopId()) {
								shopRebate.setShopName(shop.getGradeName());
								;
								break;
							}
						}
					}
					pcb.setObj(list);
				}
//				pcb.setType("1");
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
	
	@RequestMapping(value = "/excelExport")
	public ModelAndView excelExport(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity opt = SessionUtils.getOperator(req);
		Map<String, Object> context = getRootMap();
		context.put("supplierId", CachePoolComponent.getSupplier(opt.getToken()));
		return forword("user/rebate/excelExport", context);
	}

	@RequestMapping(value = "/downLoadExcel")
	public void downLoadFile(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String dateType = req.getParameter("dateType");
			String startTime = req.getParameter("startTime");
			String endTime = req.getParameter("endTime");
			String supplierId = req.getParameter("supplierId");
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
			param.put("gradeId", staffEntity.getGradeId());
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

			String[] nameArray = new String[] { "订单号", "状态", "区域中心", "供应商", "自有编码", "品名", "成本价", "零售价", "商品规格", "订单数量", "商品数量", "一级类目",
					"二级类目", "三级类目", "订单来源", "支付金额", "支付方式", "支付流水号", "支付时间", "收件人", "收件电话", "省市区", "收件信息", "下单时间", "物流信息" };
			String[] colArray = new String[] { "OrderId", "StatusName", "GradeName", "SupplierName", "Sku", "ItemName",
					"ProxyPrice", "ActualPrice", "ItemInfo", "ItemQuantity", "Packing", "FirstName", "SecondName", "ThirdName", "OrderSourceName", "Payment",
					"PayTypeName", "PayNo", "PayTime", "ReceiveName", "ReceivePhone", "ReceiveProvince", "ReceiveAddress", "CreateTime", "ExpressInfo" };
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
}
