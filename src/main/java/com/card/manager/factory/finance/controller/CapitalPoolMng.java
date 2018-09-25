package com.card.manager.factory.finance.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import com.card.manager.factory.constants.Constants;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.finance.model.AddCapitalPoolInfoEntity;
import com.card.manager.factory.finance.model.CapitalManagement;
import com.card.manager.factory.finance.model.CapitalManagementBusinessItem;
import com.card.manager.factory.finance.model.CapitalManagementDetail;
import com.card.manager.factory.finance.model.CapitalManagementDownLoadEntity;
import com.card.manager.factory.finance.model.CapitalOverviewModel;
import com.card.manager.factory.finance.model.CapitalPool;
import com.card.manager.factory.finance.model.CapitalPoolDetail;
import com.card.manager.factory.finance.model.CapitalSearchParam;
import com.card.manager.factory.supplier.model.SupplierEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.user.service.FinanceMngService;
import com.card.manager.factory.util.DateUtil;
import com.card.manager.factory.util.ExcelUtil;
import com.card.manager.factory.util.FileDownloadUtil;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;
import com.card.manager.factory.util.TreePackUtil;
import com.github.pagehelper.Page;

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
		CapitalOverviewModel model = financeMngService.getCapitalOverviewModel(opt.getToken(), result);
		Collections.sort(result);
		context.put("list", result);
		context.put("overview", model);
		if (opt.getRoleId() == 1) {
			context.put("prilvl", "1");
		} else {
			context.put("prilvl", req.getParameter("privilege"));
		}
		return forword("finance/poolcharge/list", context);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, CapitalSearchParam entity) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {

			String centerId = req.getParameter("gradeId");
			if (!StringUtil.isEmpty(centerId) && !centerId.equals("2")) {
				entity.setIds(centerId);
			}
			Map<String, Object> params = new HashMap<String, Object>();
			pcb = financeMngService.dataList(entity, params, staffEntity.getToken(),
					ServerCenterContants.FINANCE_CENTER_QUERY_CAPITALPOOL, CapitalPool.class);

			Map<Integer, GradeBO> map = CachePoolComponent.getGrade(staffEntity.getToken());
			if (pcb.getObj() != null) {
				List<CapitalPool> pooList = (List<CapitalPool>) pcb.getObj();
				Iterator<CapitalPool> it = pooList.iterator();
				while(it.hasNext()) {
					CapitalPool pool = it.next();
					GradeBO grade = map.get(pool.getCenterId());
					if(grade == null){
						it.remove();
						continue;
					}
					pool.setCenterName(grade.getName());
					pool.setGradeTypeName(grade.getGradeTypeName());
					pool.setCompany(grade.getCompany());
				}
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

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/showCapitalDetail")
	public ModelAndView toShow(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		PageCallBack pcb = null;
		try {
			String gradeId = req.getParameter("gradeId");
			CapitalSearchParam search = new CapitalSearchParam();
			search.setCurrentPage(1);
			search.setNumPerPage(10);
			if (!StringUtil.isEmpty(gradeId)) {
				search.setIds(gradeId);
			}
			Map<String, Object> params = new HashMap<String, Object>();
			pcb = financeMngService.dataList(search, params, opt.getToken(),
					ServerCenterContants.FINANCE_CENTER_QUERY_CAPITALPOOL, CapitalPool.class);
			CapitalPool pool = ((List<CapitalPool>) pcb.getObj()).get(0);
			context.put("pool", pool);
			context.put("gradeId", gradeId);
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
			if (!StringUtil.isEmpty(centerId) && !StringUtil.isEmpty(money) && !StringUtil.isEmpty(payNo)) {
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
			for (StaffEntity cen : center) {
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
			if (!StringUtil.isEmpty(centerId) && !StringUtil.isEmpty(money)) {
				financeMngService.poolLiquidation(centerId, money, staffEntity);
			}
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/supplierList")
	public ModelAndView supplierList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		context.put("supplierId", CachePoolComponent.getSupplier(opt.getToken()));
		context.put("customerType", Constants.CUSTOMER_TYPE_SUPPLIER);

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("customerType", Constants.CUSTOMER_TYPE_SUPPLIER);
		params.put("money", Constants.CUSTOMER_WARNING_MONEY);
		CapitalManagement totalInfo = financeMngService.totalCustomerByType(params);
		context.put("totalInfo", totalInfo);
		// set page privilege
		if (opt.getRoleId() == 1) {
			context.put("prilvl", "1");
		} else {
			context.put("prilvl", req.getParameter("privilege"));
		}
		return forword("finance/capitalPool/list", context);
	}

	@RequestMapping(value = "/dataListByType", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataListByType(HttpServletRequest req, HttpServletResponse resp, Pagination pagination) {
		PageCallBack pcb = new PageCallBack();
		try {
			String customerType = req.getParameter("customerType");
			String supplierId = req.getParameter("supplierId");
			String customerCode = req.getParameter("customerCode");
			String centerId = req.getParameter("centerId");
			String customerStatus = req.getParameter("customerStatus");
			String customerName = req.getParameter("customerName");
			Page<CapitalManagement> page = null;
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("customerType", customerType);
			if (!StringUtil.isEmpty(customerName)) {
				params.put("customerName", customerName);
			}
			if (!StringUtil.isEmpty(supplierId)) {
				params.put("supplierId", supplierId);
			}
			if (!StringUtil.isEmpty(customerCode)) {
				params.put("customerCode", customerCode);
			}
			if (!StringUtil.isEmpty(centerId)) {
				params.put("centerId", centerId);
			}
			if (!StringUtil.isEmpty(customerStatus)) {
				if ("2".equals(customerStatus)) {
					params.put("customerStatus", Constants.CUSTOMER_WARNING_MONEY);
				} else {
					params.put("customerStatus2", Constants.CUSTOMER_WARNING_MONEY);
				}
			}

			page = financeMngService.dataListByType(pagination, params);

			pcb.setObj(page);
			pcb.setSuccess(true);
			pcb.setPagination(webPageConverter(page));
		} catch (Exception e) {
			pcb.setErrTrace(e.getMessage());
			pcb.setSuccess(false);
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return pcb;
		}
		return pcb;
	}

	@RequestMapping(value = "/toSupplierAdd")
	public ModelAndView toSupplierAdd(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		context.put("supplierId", CachePoolComponent.getSupplier(opt.getToken()));
		context.put("customerType", Constants.CUSTOMER_TYPE_SUPPLIER);
		return forword("finance/capitalPool/add", context);
	}

	@RequestMapping(value = "/addCapitalPoolInfo", method = RequestMethod.POST)
	public void addCapitalPoolInfo(HttpServletRequest req, HttpServletResponse resp,
			@RequestBody AddCapitalPoolInfoEntity entity) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		entity.setOpt(staffEntity.getOptName());
		try {
			if ("1".equals(entity.getPayType().toString())) {
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("customerId", entity.getCustomerId().toString());
				param.put("customerType", entity.getCustomerType().toString());
				CapitalManagement capitalManagement = financeMngService.queryCapitalManagementByCustomerId(param);
				if (capitalManagement == null) {
					sendFailureMessage(resp, "操作失败：客户：" + entity.getCustomerName() + "可用金额(0)小于本次消费金额(" + entity.getMoney() + ")");
					return;
				} else if (capitalManagement.getMoney() - entity.getMoney() < 0) {
					sendFailureMessage(resp, "操作失败：客户：" + entity.getCustomerName() + "可用金额("
							+ capitalManagement.getMoney() + ")小于本次消费金额(" + entity.getMoney() + ")");
					return;
				}
			}
			// 自动产生业务流水号：ZJC+账号+时间+4位随机数
			// 随机产生规定范围内数字[1000,9999]
			// 规律:num=(int)(Math.random()*(y-x+1))+x;
			Integer num = (int) (Math.random() * 9000) + 1000;
			String businessNo = "ZJC" + staffEntity.getBadge() + DateUtil.getNowPlusTimeMill() + num;
			entity.setBusinessNo(businessNo);
			if (Constants.CUSTOMER_TYPE_SUPPLIER.equals(entity.getCustomerType().toString())) {
				List<SupplierEntity> suppliers = CachePoolComponent.getSupplier(staffEntity.getToken());
				for (SupplierEntity sup : suppliers) {
					if (sup.getId() == entity.getCustomerId()) {
						entity.setCustomerCode(sup.getSupplierCode());
						break;
					}
				}
			} else if (Constants.CUSTOMER_TYPE_CENTER.equals(entity.getCustomerType().toString())) {
				Map<Integer, GradeBO> maps = CachePoolComponent.getGrade(staffEntity.getToken());
				GradeBO grade = maps.get(entity.getCustomerId());
				entity.setCustomerCode(grade.getCompany());
			}
			financeMngService.insertCapitalPoolInfo(entity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/showCapitalManagementDetail")
	public ModelAndView showCapitalManagementDetail(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		String customerId = req.getParameter("customerId");
		String customerType = req.getParameter("customerType");
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("customerId", customerId);
		param.put("customerType", customerType);
		context.put(OPT, opt);
		CapitalManagement capitalManagement = financeMngService.queryCapitalManagementByCustomerId(param);
		context.put("CapitalManagement", capitalManagement);
		return forword("finance/capitalPool/show", context);
	}

	@RequestMapping(value = "/dataListByCustomerId", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataListByCustomerId(HttpServletRequest req, HttpServletResponse resp, Pagination pagination) {
		PageCallBack pcb = new PageCallBack();
		try {
			String customerId = req.getParameter("customerId");
			String customerType = req.getParameter("customerType");
			String payType = req.getParameter("payType");
			String payNo = req.getParameter("payNo");
			Page<CapitalManagementDetail> page = null;
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("customerId", customerId);
			params.put("customerType", customerType);
			params.put("payType", payType);
			params.put("payNo", payNo);

			page = financeMngService.dataListByCustomerId(pagination, params);

			pcb.setObj(page);
			pcb.setSuccess(true);
			pcb.setPagination(webPageConverter(page));
		} catch (Exception e) {
			pcb.setErrTrace(e.getMessage());
			pcb.setSuccess(false);
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return pcb;
		}
		return pcb;
	}

	@RequestMapping(value = "/centerList")
	public ModelAndView centerList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		context.put("centerId", CachePoolComponent.getCenter(opt.getToken()));
		context.put("customerType", Constants.CUSTOMER_TYPE_CENTER);

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("customerType", Constants.CUSTOMER_TYPE_CENTER);
		params.put("money", Constants.CUSTOMER_WARNING_MONEY);
		CapitalManagement totalInfo = financeMngService.totalCustomerByType(params);
		context.put("totalInfo", totalInfo);
		// set page privilege
		if (opt.getRoleId() == 1) {
			context.put("prilvl", "1");
		} else {
			context.put("prilvl", req.getParameter("privilege"));
		}
		return forword("finance/capitalPool/list", context);
	}

	@RequestMapping(value = "/toCenterAdd")
	public ModelAndView toCenterAdd(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		context.put("centerId", CachePoolComponent.getCenter(opt.getToken()));
		context.put("customerType", Constants.CUSTOMER_TYPE_CENTER);
		return forword("finance/capitalPool/add", context);
	}

	@RequestMapping(value = "/showCapitalManagementBusinessItem")
	public ModelAndView showCapitalManagementBusinessItem(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		String businessNo = req.getParameter("businessNo");
		context.put(OPT, opt);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("businessNo", businessNo);
		CapitalManagementDetail capitalManagementDetail = financeMngService.queryCapitalManagementDetailByParam(params);
		context.put("capitalManagementDetail", capitalManagementDetail);
		return forword("finance/capitalPool/businessItem", context);
	}

	@RequestMapping(value = "/dataListByBusinessNo", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataListByBusinessNo(HttpServletRequest req, HttpServletResponse resp, Pagination pagination) {
		PageCallBack pcb = new PageCallBack();
		try {
			String businessNo = req.getParameter("businessNo");
			Page<CapitalManagementBusinessItem> page = null;
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("businessNo", businessNo);

			page = financeMngService.dataListByBusinessNo(pagination, params);

			pcb.setObj(page);
			pcb.setSuccess(true);
			pcb.setPagination(webPageConverter(page));
		} catch (Exception e) {
			pcb.setErrTrace(e.getMessage());
			pcb.setSuccess(false);
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return pcb;
		}
		return pcb;
	}

	@RequestMapping(value = "/downLoadCapitalPoolRecordExcel")
	public void downLoadCapitalPoolRecordExcel(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String customerType = req.getParameter("customerType");
			String customerId = req.getParameter("customerId");
			Map<String, Object> param = new HashMap<String, Object>();
			if (!StringUtil.isEmpty(customerType)) {
				param.put("customerType", customerType);
			}
			if (!StringUtil.isEmpty(customerId)) {
				param.put("customerId", customerId);
			}

			List<CapitalManagementDownLoadEntity> ReportList = new ArrayList<CapitalManagementDownLoadEntity>();
			ReportList = financeMngService.queryCapitalPoolInfoListForDownload(param);

			for (CapitalManagementDownLoadEntity pool : ReportList) {
				switch (pool.getCustomerType()) {
				case 0:
					pool.setCustomerTypeName("供应商");
					break;
				case 1:
					pool.setCustomerTypeName("区域中心");
					break;
				}

				switch (pool.getPayType()) {
				case 0:
					pool.setPayTypeName("充值");
					break;
				case 1:
					pool.setPayTypeName("消费");
					break;
				}
				if (pool.getMoney() - Integer.parseInt(Constants.CUSTOMER_WARNING_MONEY) >= 0) {
					pool.setStatusName("正常");
				} else {
					pool.setStatusName("预警");
				}
			}

			WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
			ServletContext servletContext = webApplicationContext.getServletContext();

			String fileName = "capitalPool_" + DateUtil.getNowLongTime() + ".xlsx";
			String filePath = servletContext.getRealPath("/") + "EXCEL/" + staffEntity.getBadge() + "/" + fileName;

			String[] nameArray = new String[] { "客户类型", "客户名称", "客户代码", "可用金额", "已用金额", "累计金额", "状态", "支付类型", "支付流水号",
					"金额", "备注", "创建时间", "操作人", "业务流水号", "订单号", "商品名称", "商品编号", "商家编码", "商品数量", "商品价格", "商品条形码" };
			String[] colArray = new String[] { "CustomerTypeName", "CustomerName", "CustomerCode", "Money", "UseMoney",
					"CountMoney", "StatusName", "PayTypeName", "PayNo", "DetailMoney", "Remark", "CreateTime", "Opt",
					"BusinessNo", "OrderId", "GoodsName", "ItemId", "ItemCode", "ItemQuantity", "ItemPrice",
					"ItemEncode" };

			SXSSFWorkbook swb = new SXSSFWorkbook(100);
			ExcelUtil.createExcel(ReportList, nameArray, colArray, filePath, 0, "sheet1", swb);
			ExcelUtil.writeToExcel(swb, filePath);

			FileDownloadUtil.downloadFileByBrower(req, resp, filePath, fileName);
		} catch (Exception e) {
			resp.setContentType("text/html;charset=utf-8");
			resp.getWriter().println("下载失败，请重试!");
			resp.getWriter().println(e.getMessage());
			return;
		}
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/dataCapitalDetailList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataCapitalDetailList(HttpServletRequest req, HttpServletResponse resp,
			CapitalPoolDetail entity) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String gradeId = req.getParameter("gradeId");
			entity.setCenterId(Integer.valueOf(gradeId));
			Map<String, Object> params = new HashMap<String, Object>();

			pcb = financeMngService.dataList(entity, params, staffEntity.getToken(),
					ServerCenterContants.FINANCE_CENTER_QUERY_CAPITALPOOL_DETAIL, CapitalPoolDetail.class);

			Map<Integer, GradeBO> map = CachePoolComponent.getGrade(staffEntity.getToken());
			if (pcb.getObj() != null) {
				List<CapitalPoolDetail> pooDetailList = (List<CapitalPoolDetail>) pcb.getObj();
				for (CapitalPoolDetail detail : pooDetailList) {
					GradeBO grade = map.get(detail.getCenterId());
					detail.setCenterName(grade.getName());
				}
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
		context.put(OPT, opt);
		List<StaffEntity> list = CachePoolComponent.getAllCenter(opt.getToken());
		Set<StaffEntity> set = new HashSet<StaffEntity>();
		for(StaffEntity staff : list){
			if(staff.getGradeId() == 0){
				continue;
			}
			set.add(staff);
		}
		context.put("centerId", set);
		return forword("finance/poolcharge/add", context);
	}

	@RequestMapping(value = "/addCapitalPool", method = RequestMethod.POST)
	public void addCapitalPool(HttpServletRequest req, HttpServletResponse resp,
			@RequestBody CapitalPoolDetail entity) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		entity.setOpt(staffEntity.getOptName());
		try {
			financeMngService.addCapitalPool(entity, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}
}
