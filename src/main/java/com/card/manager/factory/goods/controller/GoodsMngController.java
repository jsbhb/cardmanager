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
import com.card.manager.factory.base.Pagination;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.goods.model.GoodsEntity;
import com.card.manager.factory.goods.model.ThirdWarehouseGoods;
import com.card.manager.factory.goods.pojo.GoodsPojo;
import com.card.manager.factory.goods.service.GoodsService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

@Controller
@RequestMapping("/admin/goods/goodsMng")
public class GoodsMngController extends BaseController {

	private final String SYNC = "sync";
	private final String NORMAL = "normal";

	@Resource
	GoodsService goodsService;

	@RequestMapping(value = "/mng")
	public ModelAndView toFuncList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("goods/goods/mng", context);
	}

	@RequestMapping(value = "/syncGoods")
	public ModelAndView syncGoods(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("goods/goods/sync", context);
	}

	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		context.put("suppliers", CachePoolComponent.getSupplier(opt.getToken()));
		return forword("goods/goods/list", context);
	}

	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, Pagination pagination) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			pcb = goodsService.dataList(pagination, params, staffEntity.getToken(),
					ServerCenterContants.GOODS_CENTER_QUERY_FOR_PAGE, GoodsEntity.class);
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

	@RequestMapping(value = "/syncDataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack syncDataList(HttpServletRequest req, HttpServletResponse resp, Pagination pagination) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();

		params.put("sku", req.getParameter("sku"));
		params.put("itemCode", req.getParameter("itemCode"));
		params.put("supplierId", req.getParameter("supplierId"));
		params.put("status", req.getParameter("status"));
		try {
			pcb = goodsService.dataList(pagination, params, staffEntity.getToken(),
					ServerCenterContants.GOODS_CENTER_QUERY_THIRD_GOODS, ThirdWarehouseGoods.class);
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

	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {

			String type = req.getParameter("type");
			if (SYNC.equals(type)) {
				String id = req.getParameter("id");
				if (StringUtil.isEmpty(id)) {
					context.put(ERROR, "没有同步商品编码！");
					return forword(ERROR, context);
				}
				ThirdWarehouseGoods thirdGoods = goodsService.queryThirdById(id, opt.getToken());
				context.put("third", thirdGoods);

			} else if (NORMAL.equals(type)) {
				// List<BrandEntity> brands =
				// CachePoolComponent.getBrands(opt.getToken());
				// if(brands.size() == 0){
				// context.put(ERROR,"没有品牌信息,无法查看基础商品！");
				// context.put(ERROR_CODE,"405！");
				// return forword("error", context);
				// }
				//
				// context.put("brands", brands);
				//
				// List<FirstCatalogEntity> catalogs =
				// catalogService.queryFirstCatalogs(opt.getToken());
				// context.put("firsts", catalogs);
			} else {
				context.put(ERROR, "没有新增类型，请联系管理员！");
				return forword(ERROR, context);
			}

			return forword("goods/goods/add", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
	}

	@RequestMapping(value = "/toShow")
	public ModelAndView toShow(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {
			String id = req.getParameter("id");
			GoodsEntity entity = goodsService.queryById(id, opt.getToken());
			context.put("goods", entity);
			return forword("goods/goods/show", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}

	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void save(HttpServletRequest req, HttpServletResponse resp, @RequestBody GoodsPojo pojo) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		pojo.setOpt(staffEntity.getOptid());
		try {

			if (pojo.getBaseId() == 0) {
				sendFailureMessage(resp, "没有基础商品信息！");
				return;
			}

			if (StringUtil.isEmpty(pojo.getType())) {
				sendFailureMessage(resp, "没有新增类型，请联系管理处理！");
				return;
			}

			goodsService.addEntity(pojo, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}
}
