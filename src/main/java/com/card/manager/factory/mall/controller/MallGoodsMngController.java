package com.card.manager.factory.mall.controller;

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
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.goods.GoodsUtil;
import com.card.manager.factory.goods.model.GoodsEntity;
import com.card.manager.factory.goods.model.GoodsItemEntity;
import com.card.manager.factory.goods.model.GoodsTagBindEntity;
import com.card.manager.factory.goods.model.GoodsTagEntity;
import com.card.manager.factory.goods.service.GoodsItemService;
import com.card.manager.factory.goods.service.GoodsService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

@Controller
@RequestMapping("/admin/mall/goodsMng")
public class MallGoodsMngController extends BaseController {

	@Resource
	GoodsItemService goodsItemService;

	@Resource
	GoodsService goodsService;

	// @RequestMapping(value = "/mng")
	// public ModelAndView toFuncList(HttpServletRequest req,
	// HttpServletResponse resp) {
	// Map<String, Object> context = getRootMap();
	// StaffEntity opt = SessionUtils.getOperator(req);
	// context.put("opt", opt);
	// return forword("mall/goods/mng", context);
	// }

	@RequestMapping(value = "/mng")
	// @RequestMapping(value = "/list")
	public ModelAndView goodsItemList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		// 分级类型不是海外购时，提示无法使用功能
		// if (opt.getGradeType() != 1) {
		// return forword("mall/goods/notice", context);
		// }
		if (opt.getGradeId() == 0) {
			return forword("mall/goods/notice", context);
		}
		try {
			// set page privilege
			if (opt.getRoleId() == 1) {
				context.put("prilvl", "1");
			} else {
				context.put("prilvl", req.getParameter("privilege"));
			}
			context.put("suppliers", CachePoolComponent.getSupplier(opt.getToken()));
			List<GoodsTagEntity> tags = goodsService.queryGoodsTags(opt.getToken());
			context.put("tags", tags);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
		return forword("mall/goods/list", context);
	}

	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack goodsItemdataList(HttpServletRequest req, HttpServletResponse resp, GoodsItemEntity item) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			String supplierId = req.getParameter("supplierId");
			if (!StringUtil.isEmpty(supplierId)) {
				item.setSupplierId(supplierId);
			}
			String tagId = req.getParameter("tagId");
			if (!StringUtil.isEmpty(tagId)) {
				GoodsTagBindEntity tagBindEntity = new GoodsTagBindEntity();
				tagBindEntity.setTagId(Integer.parseInt(tagId));
				item.setTagBindEntity(tagBindEntity);
			}

			// String status = req.getParameter("status");
			// if (!StringUtil.isEmpty(status)) {
			// item.setStatus(status);
			// }
			String tabId = req.getParameter("hidTabId");
			if ("first".equals(tabId)) {
				item.setStatus("1");
			} else if ("second".equals(tabId)) {
				item.setStatus("0");
			}

			String itemId = req.getParameter("itemId");
			if (!StringUtil.isEmpty(itemId)) {
				item.setItemId(itemId);
			}
			String itemCode = req.getParameter("itemCode");
			if (!StringUtil.isEmpty(itemCode)) {
				item.setItemCode(itemCode);
			}
			String goodsName = req.getParameter("goodsName");
			if (!StringUtil.isEmpty(goodsName)) {
				item.setGoodsName(goodsName);
			}
			String hidGoodsName = req.getParameter("hidGoodsName");
			if (!StringUtil.isEmpty(hidGoodsName)) {
				item.setGoodsName(hidGoodsName);
			}
			String goodsType = req.getParameter("goodsType");
			if (!StringUtil.isEmpty(goodsType)) {
				GoodsEntity goodsEntity = new GoodsEntity();
				goodsEntity.setType(Integer.parseInt(goodsType));
				item.setGoodsEntity(goodsEntity);
			}
			String encode = req.getParameter("encode");
			if (!StringUtil.isEmpty(encode)) {
				item.setEncode(encode);
			}

			params.put("centerId", staffEntity.getGradeId());
			params.put("shopId", staffEntity.getShopId());
			params.put("gradeLevel", staffEntity.getGradeLevel());

			pcb = goodsItemService.dataList(item, params, staffEntity.getToken(),
					ServerCenterContants.GOODS_CENTER_ITEM_QUERY_FOR_PAGE, GoodsItemEntity.class);

			List<GoodsItemEntity> list = (List<GoodsItemEntity>) pcb.getObj();
			for (GoodsItemEntity entity : list) {
				GoodsUtil.changeSpecsInfo(entity);
			}

		} catch (ServerCenterNullDataException e) {
			if (pcb == null) {
				pcb = new PageCallBack();
			}
			pcb.setPagination(item);
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

	@RequestMapping(value = "/puton", method = RequestMethod.POST)
	public void puton(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String itemId = req.getParameter("itemId");
			if (StringUtil.isEmpty(itemId)) {
				sendFailureMessage(resp, "操作失败：没有商品编号");
				return;
			}
			goodsItemService.puton(itemId, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/putoff", method = RequestMethod.POST)
	public void putoff(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String itemId = req.getParameter("itemId");
			if (StringUtil.isEmpty(itemId)) {
				sendFailureMessage(resp, "操作失败：没有商品编号");
				return;
			}
			goodsItemService.putoff(itemId, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/publishList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack publishList(HttpServletRequest req, HttpServletResponse resp, GoodsEntity item) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			String tabId = req.getParameter("hidTabId");
			if ("first".equals(tabId)) {
				params.put("type", 1);
			} else if ("second".equals(tabId)) {
				params.put("type", 2);
			}

			params.put("centerId", staffEntity.getGradeId());

			pcb = goodsItemService.dataList(item, params, staffEntity.getToken(),
					ServerCenterContants.GOODS_CENTER_PUBLISH_ERROR_LIST, GoodsEntity.class);

			List<GoodsEntity> list = (List<GoodsEntity>) pcb.getObj();

		} catch (ServerCenterNullDataException e) {
			if (pcb == null) {
				pcb = new PageCallBack();
			}
			pcb.setPagination(item);
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
	
	@RequestMapping(value = "/publish", method = RequestMethod.POST)
	public void publish(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String goodsIds = req.getParameter("goodsIds");
			if (StringUtil.isEmpty(goodsIds)) {
				sendFailureMessage(resp, "操作失败：没有商品ID");
				return;
			}
			goodsItemService.publish(goodsIds, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}
	
	@RequestMapping(value = "/unPublish", method = RequestMethod.POST)
	public void unPublish(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String goodsIds = req.getParameter("goodsIds");
			if (StringUtil.isEmpty(goodsIds)) {
				sendFailureMessage(resp, "操作失败：没有商品ID");
				return;
			}
			goodsItemService.unPublish(goodsIds, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}
	
	@RequestMapping(value = "/list")
	public ModelAndView goodsPublishList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		if (opt.getGradeId() == 0) {
			return forword("mall/goods/notice", context);
		}
		try {
			// set page privilege
			if (opt.getRoleId() == 1) {
				context.put("prilvl", "1");
			} else {
				context.put("prilvl", req.getParameter("privilege"));
			}
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
		return forword("mall/goods/publishExceptionList", context);
	}

}
