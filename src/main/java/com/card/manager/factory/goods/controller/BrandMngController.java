package com.card.manager.factory.goods.controller;

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
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.goods.model.BrandEntity;
import com.card.manager.factory.goods.service.BrandService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

@Controller
@RequestMapping("/admin/goods/brandMng")
public class BrandMngController extends BaseController {

	@Resource
	BrandService brandService;

	@RequestMapping(value = "/mng")
	public ModelAndView mng(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("goods/brand/mng", context);
	}

	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("goods/brand/add", context);
	}

	@RequestMapping(value = "/addBrand", method = RequestMethod.POST)
	public void addBrand(HttpServletRequest req, HttpServletResponse resp, @RequestBody BrandEntity entity) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		entity.setOpt(staffEntity.getOptid());
		try {
			entity.setBrand(entity.getBrand().trim());
			brandService.addBrand(entity, staffEntity.getToken());
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
		return forword("goods/brand/list", context);
	}

	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, BrandEntity pagination) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			String brand = req.getParameter("brand");
			if (!StringUtil.isEmpty(brand)) {
				pagination.setBrand(brand);
			}
			String hidBrand = req.getParameter("hidBrand");
			if (!StringUtil.isEmpty(hidBrand)) {
				pagination.setBrand(hidBrand);
			}
			pcb = brandService.dataList(pagination, params, staffEntity.getToken(),
					ServerCenterContants.GOODS_CENTER_BRAND_QUERY_FOR_PAGE, BrandEntity.class);
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
		String id = req.getParameter("brandId");

		try {
			BrandEntity brand = brandService.queryById(id, opt.getToken());
			context.put("brand", brand);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword("error", context);
		}

		return forword("goods/brand/edit", context);
	}

	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public void editBrand(HttpServletRequest req, HttpServletResponse resp, @RequestBody BrandEntity entity) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			entity.setBrand(entity.getBrand().trim());
			brandService.modify(entity, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public void delete(HttpServletRequest req, HttpServletResponse resp) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String brandId = req.getParameter("brandId");
			if (StringUtil.isEmpty(brandId)) {
				sendFailureMessage(resp, "信息不全");
				return;
			}

			brandService.delete(brandId, staffEntity);

		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}
}
