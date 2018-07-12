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
import com.card.manager.factory.goods.model.GoodsRatioPlatformEntity;
import com.card.manager.factory.goods.service.GoodsPriceRatioService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

@Controller
@RequestMapping("/admin/goods/goodsPriceRatioMng")
public class GoodsPriceRatioMngController extends BaseController {

	@Resource
	GoodsPriceRatioService goodsPriceRatioService;

	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("goods/goodsRatio/add", context);
	}

	@RequestMapping(value = "/addRatioPlatform", method = RequestMethod.POST)
	public void addRatioPlatform(HttpServletRequest req, HttpServletResponse resp, @RequestBody GoodsRatioPlatformEntity entity) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		entity.setIsUse(0);
		entity.setOpt(staffEntity.getOptid());
		try {
			goodsPriceRatioService.addRatioPlatformInfo(entity, staffEntity.getToken());
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
		return forword("goods/goodsRatio/list", context);
	}

	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, GoodsRatioPlatformEntity pagination) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			String name = req.getParameter("name");
			if (!StringUtil.isEmpty(name)) {
				pagination.setRatioPlatformName(name);;
			}
			String hidName = req.getParameter("hidName");
			if (!StringUtil.isEmpty(hidName)) {
				pagination.setRatioPlatformName(hidName);
			}
			pcb = goodsPriceRatioService.dataList(pagination, params, staffEntity.getToken(),
					ServerCenterContants.GOODS_CENTER_QUERY_GOODS_RATIO_PLATFORM_PAGE_INFO, GoodsRatioPlatformEntity.class);
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
		String id = req.getParameter("id");

		try {
			GoodsRatioPlatformEntity entity = new GoodsRatioPlatformEntity();
			entity.setId(Integer.parseInt(id));
			GoodsRatioPlatformEntity ratioPlatformInfo = goodsPriceRatioService.queryInfoByParam(entity, opt.getToken());
			context.put("ratioPlatformInfo", ratioPlatformInfo);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword("error", context);
		}

		return forword("goods/goodsRatio/edit", context);
	}

	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public void modify(HttpServletRequest req, HttpServletResponse resp, @RequestBody GoodsRatioPlatformEntity entity) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			entity.setIsUse(0);
			entity.setOpt(staffEntity.getOpt());
			goodsPriceRatioService.modify(entity, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}
}
