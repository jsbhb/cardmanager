package com.card.manager.factory.goods.controller;

import java.util.ArrayList;
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
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.goods.model.SpecsEntity;
import com.card.manager.factory.goods.model.SpecsTemplateEntity;
import com.card.manager.factory.goods.model.SpecsValueEntity;
import com.card.manager.factory.goods.pojo.SpecsPojo;
import com.card.manager.factory.goods.service.SpecsService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

@Controller
@RequestMapping("/admin/goods/specsMng")
public class SpecsMngController extends BaseController {

	@Resource
	SpecsService specsService;

	@RequestMapping(value = "/mng")
	public ModelAndView toFuncList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("goods/specs/mng", context);
	}

	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {

			return forword("goods/specs/add", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword("error", context);
		}

	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void save(HttpServletRequest req, HttpServletResponse resp, @RequestBody SpecsPojo pojo) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		SpecsTemplateEntity entity = new SpecsTemplateEntity();
		entity.setOpt(staffEntity.getOptid());
		try {
			entity.setName(pojo.getTemplateName());

			String[] specsNames = pojo.getSpecsName().split(",");
			String[] specsValues = pojo.getSpecsValue().split(",");

			List<SpecsValueEntity> specsValueEntities;
			List<SpecsEntity> specsEntitis = new ArrayList<SpecsEntity>();
			for (int i = 0; i < specsNames.length; i++) {
				String[] values = specsValues[i].split(";");
				specsValueEntities = new ArrayList<SpecsValueEntity>();
				for (int j = 0; j < values.length; j++) {
					if (!StringUtil.isEmpty(values[j].trim())) {
						specsValueEntities.add(new SpecsValueEntity(values[j]));
					}
				}

				specsEntitis.add(new SpecsEntity(specsNames[i], specsValueEntities));
			}

			entity.setSpecses(specsEntitis);

			specsService.add(entity, staffEntity.getToken());
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
		context.put(OPT, opt);
		return forword("goods/specs/list", context);
	}

	@RequestMapping(value = "/listForAdd")
	public ModelAndView listForAdd(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		return forword("goods/specs/listForAdd", context);
	}

	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, Pagination pagination) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			pcb = specsService.dataList(pagination, params, staffEntity.getToken(),
					ServerCenterContants.GOODS_CENTER_SPECS_QUERY_FOR_PAGE, SpecsTemplateEntity.class);
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

	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		String id = req.getParameter("id");

		try {
			SpecsTemplateEntity entity = specsService.queryById(id, opt.getToken());
			context.put("entity", entity);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword("error", context);
		}

		return forword("goods/specs/edit", context);
	}

	@RequestMapping(value = "/toShow")
	public ModelAndView toShow(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		String id = req.getParameter("id");

		try {
			SpecsTemplateEntity entity = specsService.queryById(id, opt.getToken());
			context.put("entity", entity);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword("error", context);
		}

		return forword("goods/specs/edit", context);
	}

	@RequestMapping(value = "/queryById")
	@ResponseBody
	public SpecsTemplateEntity queryById(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity opt = SessionUtils.getOperator(req);
		String id = req.getParameter("id");

		try {
			SpecsTemplateEntity entity = specsService.queryById(id, opt.getToken());
			return entity;
		} catch (Exception e) {
			sendFailureMessage(resp, e.getMessage());
			return null;
		}
	}

}
