package com.card.manager.factory.label.controller;

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
import com.card.manager.factory.goods.model.GoodsTagEntity;
import com.card.manager.factory.goods.service.GoodsService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.SessionUtils;

@Controller
@RequestMapping("/admin/label/goodsTagMng")
public class GoodsTagMngController extends BaseController {

	@Resource
	GoodsService goodsService;

//	@RequestMapping(value = "/mng")
//	public ModelAndView mngList(HttpServletRequest req, HttpServletResponse resp) {
//		Map<String, Object> context = getRootMap();
//		StaffEntity opt = SessionUtils.getOperator(req);
//		context.put("opt", opt);
//		return forword("label/goodsTag/mng", context);
//	}

	@RequestMapping(value = "/mng")
//	@RequestMapping(value = "/list")
	public ModelAndView goodsItemList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {
			//context.put("suppliers", CachePoolComponent.getSupplier(opt.getToken()));
		} catch (Exception e) {
		}
		return forword("label/goodsTag/list_1", context);
	}

	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack goodsTagDataList(HttpServletRequest req, HttpServletResponse resp) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		GoodsTagEntity entity = new GoodsTagEntity();
		entity.setCurrentPage(1);
		entity.setNumPerPage(20);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			pcb = goodsService.dataList(entity, params, staffEntity.getToken(),
					ServerCenterContants.GOODS_CENTER_TAG_QUERY_FOR_PAGE, GoodsTagEntity.class);
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

	@RequestMapping(value = "/toEditTag")
	public ModelAndView toEditTag(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {
			String tagId = req.getParameter("tagId");
			GoodsTagEntity goodsTagEntity = goodsService.queryGoodsTag(tagId, opt.getToken());
			context.put("tagEntity", goodsTagEntity);
			return forword("goods/goods/editTag", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
	}
	
	@RequestMapping(value = "/updateTag", method = RequestMethod.POST)
	public void updateTag(HttpServletRequest req, HttpServletResponse resp, @RequestBody GoodsTagEntity entity) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			entity.setPriority(1);
			goodsService.updateGoodsTagEntity(entity, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/toDeleteTag", method = RequestMethod.POST)
	public void toDeleteTag(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String tagId = req.getParameter("tagId");
			GoodsTagEntity entity = new GoodsTagEntity();
			entity.setId(Integer.parseInt(tagId));
			goodsService.deleteGoodsTagEntity(entity, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}
}
