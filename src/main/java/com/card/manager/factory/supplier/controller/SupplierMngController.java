package com.card.manager.factory.supplier.controller;

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
import com.card.manager.factory.base.Pagination;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.supplier.model.SupplierEntity;
import com.card.manager.factory.supplier.service.SupplierService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.SessionUtils;

@Controller
@RequestMapping("/admin/supplier/supplierMng")
public class SupplierMngController extends BaseController {

	@Resource
	SupplierService supplierService;

	@RequestMapping(value = "/mng")
	public ModelAndView toFuncList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("supplier/mng", context);
	}

	@RequestMapping(value = "/toAdd")
	public ModelAndView add(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("supplier/add", context);
	}

	@RequestMapping(value = "/addSupplier", method = RequestMethod.POST)
	public void addSupplier(HttpServletRequest req, HttpServletResponse resp, @RequestBody SupplierEntity entity) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			supplierService.addSupplier(entity, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("supplier/list", context);
	}

	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, Pagination pagination) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			pcb = supplierService.dataList(pagination, params, staffEntity.getToken(),
					ServerCenterContants.SUPPLIER_CENTER_QUERY_FOR_PAGE, SupplierEntity.class);
		} catch (Exception e) {
			if (pcb == null) {
				pcb = new PageCallBack();
			}
			pcb.setErrTrace(e.getMessage());
			pcb.setSuccess(false);
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return pcb;
		}

		return pcb;
	}

	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		String id = req.getParameter("supplierId");

		try {
			SupplierEntity supplier = supplierService.queryById(id, opt.getToken());
			context.put("supplier", supplier);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword("error", context);
		}

		return forword("supplier/edit", context);
	}

	@RequestMapping(value = "/editSupplier", method = RequestMethod.POST)
	public void editSupplier(HttpServletRequest req, HttpServletResponse resp, @RequestBody SupplierEntity entity) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			supplierService.updSupplier(entity, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}
}
