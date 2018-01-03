package com.card.manager.factory.goods.controller;

import java.util.HashMap;
import java.util.List;
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
import com.card.manager.factory.goods.GoodsUtil;
import com.card.manager.factory.goods.model.GoodsItemEntity;
import com.card.manager.factory.goods.pojo.GoodsPojo;
import com.card.manager.factory.goods.service.GoodsItemService;
import com.card.manager.factory.goods.service.SpecsService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

@Controller
@RequestMapping("/admin/goods/itemMng")
public class GoodsItemMngController extends BaseController {

	@Resource
	GoodsItemService goodsItemService;

	@Resource
	SpecsService specsService;

	@RequestMapping(value = "/mng")
	public ModelAndView toFuncList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("goods/item/mng", context);
	}

	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		context.put("suppliers", CachePoolComponent.getSupplier(opt.getToken()));
		return forword("goods/item/list", context);
	}

	@RequestMapping(value = "/dataListForGoods", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataListForGoods(HttpServletRequest req, HttpServletResponse resp, Pagination pagination) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			String goodsId = req.getParameter("goodsId");
			if (StringUtil.isEmpty(goodsId)) {
				pcb = new PageCallBack();
				pcb.setErrTrace("没有商品编码信息！");
				pcb.setSuccess(false);
				return pcb;
			}
			params.put("goodsId", goodsId);
			params.put("itemCode", "");
			params.put("sku", "");
			params.put("supplierId", "");
			params.put("status", "");
			params.put("goodsName", "");
			params.put("itemId", "");
			pcb = goodsItemService.dataList(pagination, params, staffEntity.getToken(),
					ServerCenterContants.GOODS_CENTER_ITEM_QUERY_FOR_PAGE, GoodsItemEntity.class);

			List<GoodsItemEntity> list = (List<GoodsItemEntity>) pcb.getObj();
			for (GoodsItemEntity entity : list) {
				GoodsUtil.changeSpecsInfo(entity);
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

	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, Pagination pagination) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			String status = req.getParameter("status");
			if (!StringUtil.isEmpty(status)) {
				params.put("status", status);
			} else {
				params.put("status", "");
			}
			String itemCode = req.getParameter("itemCode");
			if (!StringUtil.isEmpty(itemCode)) {
				params.put("itemCode", itemCode);
			} else {
				params.put("itemCode", "");
			}
			String supplierId = req.getParameter("supplierId");
			if (!StringUtil.isEmpty(supplierId)) {
				params.put("supplierId", supplierId);
			} else {
				params.put("supplierId", "");
			}
			String goodsName = req.getParameter("goodsName");
			if (!StringUtil.isEmpty(goodsName)) {
				params.put("goodsName", goodsName);
			} else {
				params.put("goodsName", "");
			}
			String sku = req.getParameter("sku");
			if (!StringUtil.isEmpty(sku)) {
				params.put("sku", sku);
			} else {
				params.put("sku", "");
			}
			String goodsId = req.getParameter("goodsId");
			if (!StringUtil.isEmpty(goodsId)) {
				params.put("goodsId", goodsId);
			} else {
				params.put("goodsId", "");
			}
			String itemId = req.getParameter("itemId");
			if (!StringUtil.isEmpty(itemId)) {
				params.put("itemId", itemId);
			} else {
				params.put("itemId", "");
			}
			pcb = goodsItemService.dataList(pagination, params, staffEntity.getToken(),
					ServerCenterContants.GOODS_CENTER_ITEM_QUERY_FOR_PAGE, GoodsItemEntity.class);

			List<GoodsItemEntity> list = (List<GoodsItemEntity>) pcb.getObj();
			for (GoodsItemEntity entity : list) {
				GoodsUtil.changeSpecsInfo(entity);
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

	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		String goodsId = req.getParameter("goodsId");
		String templateId = req.getParameter("templateId");

		try {
			context.put("goodsId", goodsId);
			context.put("template", specsService.queryById(templateId, opt.getToken()));
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword("error", context);
		}

		return forword("goods/item/add", context);
	}

	@RequestMapping(value = "/beUse", method = RequestMethod.POST)
	public void beUse(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String itemId = req.getParameter("itemId");
			if (StringUtil.isEmpty(itemId)) {
				sendFailureMessage(resp, "操作失败：没有明细编号");
				return;
			}
			goodsItemService.beUse(itemId, staffEntity.getToken(), staffEntity.getOptid());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/beFx", method = RequestMethod.POST)
	public void beFx(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String itemId = req.getParameter("itemId");
			if (StringUtil.isEmpty(itemId)) {
				sendFailureMessage(resp, "操作失败：没有明细编号");
				return;
			}
			goodsItemService.beFx(itemId, staffEntity.getToken(), staffEntity.getOptid());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/fx", method = RequestMethod.POST)
	public void fx(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String itemId = req.getParameter("itemId");
			if (StringUtil.isEmpty(itemId)) {
				sendFailureMessage(resp, "操作失败：没有明细编号");
				return;
			}
			goodsItemService.fx(itemId, staffEntity.getToken(), staffEntity.getOptid(), staffEntity.getGradeId());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/noBeFx", method = RequestMethod.POST)
	public void noBeFx(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String itemId = req.getParameter("itemId");
			if (StringUtil.isEmpty(itemId)) {
				sendFailureMessage(resp, "操作失败：没有明细编号");
				return;
			}
			goodsItemService.noBeFx(itemId, staffEntity.getToken(), staffEntity.getOptid());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void save(HttpServletRequest req, HttpServletResponse resp, @RequestBody GoodsPojo pojo) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		pojo.setOpt(staffEntity.getOptid());
		try {
			goodsItemService.addEntity(pojo, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		String id = req.getParameter("id");

		try {
			// GoodsEntity goodsItem = goodsService.queryById(id,
			// opt.getToken());
			// context.put("goodsItem", goodsItem);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword("error", context);
		}

		return forword("goods/item/edit", context);
	}
}
