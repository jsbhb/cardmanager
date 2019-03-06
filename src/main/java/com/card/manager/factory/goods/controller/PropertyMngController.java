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
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.goods.model.GuidePropertyEntity;
import com.card.manager.factory.goods.model.PropertyEntity;
import com.card.manager.factory.goods.model.PropertyValueEntity;
import com.card.manager.factory.goods.service.GoodsPropertyService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

@Controller
@RequestMapping("/admin/goods/propertyMng")
public class PropertyMngController extends BaseController {

	@Resource
	GoodsPropertyService goodsPropertyService;

	@RequestMapping(value = "/mng")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		return forword("goods/property/list", context);
	}

	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, PropertyEntity pagination) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			String name = req.getParameter("name");
			if (!StringUtil.isEmpty(name)) {
				pagination.setName(name);
			}
			String val = req.getParameter("val");
			if (!StringUtil.isEmpty(val)) {
				pagination.setVal(val);
			}
			String hidTableId = req.getParameter("hidTabId");
			params.put("hidTableId", hidTableId);
			if (hidTableId.equals("property")) {
				pcb = goodsPropertyService.dataList(pagination, params, staffEntity.getToken(),
						ServerCenterContants.GOODS_CENTER_PROPERTY_QUERY_FOR_PAGE, PropertyEntity.class);
			} else {
				pcb = goodsPropertyService.dataList(pagination, params, staffEntity.getToken(),
						ServerCenterContants.GOODS_CENTER_PROPERTY_QUERY_FOR_PAGE, GuidePropertyEntity.class);
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
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return pcb;
		}
		return pcb;
	}

	@RequestMapping(value = "/toAddName")
	public ModelAndView toAddName(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		String hidTabId = req.getParameter("hidTabId");
		if (hidTabId.equals("property")) {
			context.put("propertyType", "系列属性");
		} else {
			context.put("propertyType", "导购属性");
		}
		context.put("hidTabId", hidTabId);
		return forword("goods/property/addName", context);
	}

	@RequestMapping(value = "/addName", method = RequestMethod.POST)
	public void addName(HttpServletRequest req, HttpServletResponse resp, @RequestBody PropertyEntity entity) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		entity.setOpt(staffEntity.getOptid());
		entity.setType(1);
		try {
			goodsPropertyService.addPropertyName(entity, req.getParameter("hidTabId"), staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/toEditName")
	public ModelAndView toEditName(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		String hidTabId = req.getParameter("hidTabId");
		if (hidTabId.equals("property")) {
			context.put("propertyType", "系列属性");
			context.put("propertyName",
					goodsPropertyService.queryPropertyNameById(req.getParameter("id"), opt.getToken()));
		} else {
			context.put("propertyType", "导购属性");
			context.put("propertyName",
					goodsPropertyService.queryGuidePropertyNameById(req.getParameter("id"), opt.getToken()));
		}
		context.put("hidTabId", hidTabId);
		return forword("goods/property/editName", context);
	}

	@RequestMapping(value = "/editName", method = RequestMethod.POST)
	public void editName(HttpServletRequest req, HttpServletResponse resp, @RequestBody PropertyEntity entity) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		entity.setOpt(staffEntity.getOptid());
		entity.setType(1);
		try {
			goodsPropertyService.editPropertyName(entity, req.getParameter("hidTabId"), staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/deleteName", method = RequestMethod.POST)
	public void deleteName(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			goodsPropertyService.deletePropertyName(req.getParameter("id"), req.getParameter("hidTabId"),
					staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/toAddValue")
	public ModelAndView toAddValue(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		String hidTabId = req.getParameter("hidTabId");
		if (hidTabId.equals("property")) {
			context.put("propertyType", "系列属性");
			context.put("propertyName",
					goodsPropertyService.queryPropertyNameById(req.getParameter("id"), opt.getToken()));
		} else {
			context.put("propertyType", "导购属性");
			context.put("propertyName",
					goodsPropertyService.queryGuidePropertyNameById(req.getParameter("id"), opt.getToken()));
		}
		context.put("hidTabId", hidTabId);
		return forword("goods/property/addVal", context);
	}

	@RequestMapping(value = "/addValue", method = RequestMethod.POST)
	public void addValue(HttpServletRequest req, HttpServletResponse resp, @RequestBody PropertyValueEntity entity) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		entity.setOpt(staffEntity.getOptid());
		try {
			goodsPropertyService.addPropertyValue(entity, req.getParameter("hidTabId"), staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/toEditValue")
	public ModelAndView toEditValue(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		String hidTabId = req.getParameter("hidTabId");
		if (hidTabId.equals("property")) {
			context.put("propertyType", "系列属性");
			context.put("propertyValue",
					goodsPropertyService.queryPropertyValueById(req.getParameter("id"), opt.getToken()));
		} else {
			context.put("propertyType", "导购属性");
			context.put("propertyValue",
					goodsPropertyService.queryGuidePropertyValueById(req.getParameter("id"), opt.getToken()));
		}
		context.put("hidTabId", hidTabId);
		return forword("goods/property/editValue", context);
	}

	@RequestMapping(value = "/editValue", method = RequestMethod.POST)
	public void editValue(HttpServletRequest req, HttpServletResponse resp, @RequestBody PropertyValueEntity entity) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		entity.setOpt(staffEntity.getOptid());
		try {
			goodsPropertyService.editPropertyValue(entity, req.getParameter("hidTabId"), staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/deleteValue", method = RequestMethod.POST)
	public void deleteValue(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			goodsPropertyService.deletePropertyName(req.getParameter("id"), req.getParameter("hidTabId"),
					staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/queryPropertyByCategory")
	@ResponseBody
	public List<PropertyEntity> queryPropertyByCategory(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity opt = SessionUtils.getOperator(req);
		try {
			String catalogId = req.getParameter("catalogId");
			String catalogType = req.getParameter("catalogType");
			List<PropertyEntity> propertyList = goodsPropertyService.queryPropertyListByCategory(catalogId,catalogType,opt.getToken());
			return propertyList;
		} catch (Exception e) {
			sendFailureMessage(resp, e.getMessage());
			return null;
		}
	}

	@RequestMapping(value = "/queryPropertyValueById")
	@ResponseBody
	public List<PropertyValueEntity> queryPropertyValueById(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity opt = SessionUtils.getOperator(req);
		String id = req.getParameter("id");
		
		try {
			List<PropertyValueEntity> propertyValueList = goodsPropertyService.queryPropertyValueListById(id,opt.getToken());
			return propertyValueList;
		} catch (Exception e) {
			sendFailureMessage(resp, e.getMessage());
			return null;
		}
	}
}
