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

	// @RequestMapping(value = "/mng")
	// public ModelAndView toFuncList(HttpServletRequest req,
	// HttpServletResponse resp) {
	// Map<String, Object> context = getRootMap();
	// StaffEntity opt = SessionUtils.getOperator(req);
	// context.put("opt", opt);
	// return forword("goods/specs/mng", context);
	// }

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

	@RequestMapping(value = "/toAddValue")
	public ModelAndView toAddValue(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {
			String specsId = req.getParameter("specsId");
			if (StringUtil.isEmpty(specsId)) {
				context.put(ERROR, "没有规格信息");
				return forword("error", context);
			}
			context.put("specsId", specsId);
			return forword("goods/specs/addValue", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword("error", context);
		}

	}

	@RequestMapping(value = "/toAddSpec")
	public ModelAndView toAddSpec(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {
			String templateId = req.getParameter("templateId");
			if (StringUtil.isEmpty(templateId)) {
				context.put(ERROR, "没有模板信息");
				return forword("error", context);
			}
			context.put("templateId", templateId);
			return forword("goods/specs/addSpec", context);
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

	@RequestMapping(value = "/saveSpecsValue", method = RequestMethod.POST)
	public void saveSpecsValue(HttpServletRequest req, HttpServletResponse resp, @RequestBody SpecsPojo pojo) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		SpecsValueEntity entity = new SpecsValueEntity();
		entity.setOpt(staffEntity.getOptid());
		try {

			if (pojo.getSpecsId() <= 0 || StringUtil.isEmpty(pojo.getSpecsValue())) {
				sendFailureMessage(resp, "保存参数有误！");
				return;
			}

			entity.setSpecsId(pojo.getSpecsId());
			entity.setValue(pojo.getSpecsValue());
			specsService.addSpecsValue(entity, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/saveSpecs", method = RequestMethod.POST)
	public void saveSpecs(HttpServletRequest req, HttpServletResponse resp, @RequestBody SpecsPojo pojo) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			SpecsEntity specsEntity = new SpecsEntity();

			if (pojo.getTemplateId() <= 0 || StringUtil.isEmpty(pojo.getSpecsName())) {
				sendFailureMessage(resp, "保存参数有误！");
				return;
			}

			specsEntity.setTemplateId(pojo.getTemplateId());
			specsEntity.setName(pojo.getSpecsName());
			specsEntity.setOpt(staffEntity.getOptid());

			List<SpecsValueEntity> specsValueEntities = new ArrayList<SpecsValueEntity>();
			String[] values = pojo.getSpecsValue().split(";");
			for (int j = 0; j < values.length; j++) {
				if (!StringUtil.isEmpty(values[j].trim())) {
					specsValueEntities.add(new SpecsValueEntity(values[j]));
				}
			}
			specsEntity.setValues(specsValueEntities);

			specsService.addSpecs(specsEntity, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/mng")
	// @RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		return forword("goods/specs/list_1", context);
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
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, SpecsTemplateEntity pagination) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			String specsId = req.getParameter("specsId");
			if (!StringUtil.isEmpty(specsId)) {
				pagination.setId(Integer.parseInt(specsId));
			}
			String specsName = req.getParameter("specsName");
			if (!StringUtil.isEmpty(specsName)) {
				pagination.setName(specsName);
			}
			String hidSpecsName = req.getParameter("hidSpecsName");
			if (!StringUtil.isEmpty(hidSpecsName)) {
				pagination.setName(hidSpecsName);
			}
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

	@RequestMapping(value = "/queryAllSpecsCategoryExceptParam")
	@ResponseBody
	public List<SpecsEntity> queryAllSpecsCategoryExceptParam(HttpServletRequest req, HttpServletResponse resp,
			@RequestBody List<String> ids) {
		StaffEntity opt = SessionUtils.getOperator(req);

		try {
			List<SpecsEntity> specs = specsService.queryAllSpecs(opt.getToken());
			for (String id : ids) {
				for (SpecsEntity sp : specs) {
					if (id.equals(sp.getId() + "")) {
						specs.remove(sp);
						break;
					}
				}
			}

			return specs;
		} catch (Exception e) {
			sendFailureMessage(resp, e.getMessage());
			return null;
		}
	}

	@RequestMapping(value = "/queryAllSpecs")
	@ResponseBody
	public List<SpecsEntity> queryAllSpecs(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity opt = SessionUtils.getOperator(req);

		try {
			List<SpecsEntity> specs = specsService.queryAllSpecs(opt.getToken());
			return specs;
		} catch (Exception e) {
			sendFailureMessage(resp, e.getMessage());
			return null;
		}
	}

	@RequestMapping(value = "/queryAllSpecsValueExceptParam")
	@ResponseBody
	public List<SpecsValueEntity> queryAllSpecsValueExceptParam(HttpServletRequest req, HttpServletResponse resp,
			@RequestBody List<String> ids) {
		StaffEntity opt = SessionUtils.getOperator(req);
		String id = req.getParameter("id");

		try {
			List<SpecsValueEntity> specsValue = specsService.queryAllSpecsValue(opt.getToken());
			List<SpecsValueEntity> retList = new ArrayList<SpecsValueEntity>();
			for (SpecsValueEntity sv : specsValue) {
				if (id.equals(sv.getSpecsId() + "")) {
					retList.add(sv);
				}
			}
			for (String tmpId : ids) {
				for (SpecsValueEntity sv : retList) {
					if (tmpId.equals(sv.getId() + "")) {
						retList.remove(sv);
						break;
					}
				}
			}

			return retList;
		} catch (Exception e) {
			sendFailureMessage(resp, e.getMessage());
			return null;
		}
	}
	@RequestMapping(value = "/queryAllSpecsValue")
	@ResponseBody
	public List<SpecsValueEntity> queryAllSpecsValueE(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity opt = SessionUtils.getOperator(req);
		String id = req.getParameter("id");
		
		try {
			List<SpecsValueEntity> specsValue = specsService.queryAllSpecsValue(opt.getToken());
			List<SpecsValueEntity> retList = new ArrayList<SpecsValueEntity>();
			for (SpecsValueEntity sv : specsValue) {
				if (id.equals(sv.getSpecsId() + "")) {
					retList.add(sv);
				}
			}
			
			return retList;
		} catch (Exception e) {
			sendFailureMessage(resp, e.getMessage());
			return null;
		}
	}
	
	

}
