package com.card.manager.factory.express.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.base.PageCallBack;
import com.card.manager.factory.base.Pagination;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.express.model.DeliveryEntity;
import com.card.manager.factory.express.model.ExpressRule;
import com.card.manager.factory.express.model.ExpressTemplateBO;
import com.card.manager.factory.express.model.RuleParameter;
import com.card.manager.factory.express.service.ExpressService;
import com.card.manager.factory.supplier.model.SupplierEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.FileDownloadUtil;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;
import com.github.pagehelper.Page;

@Controller
@RequestMapping("/admin/expressMng")
public class ExpressMngController extends BaseController {

	@Resource
	ExpressService expressService;

	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse res) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> context = getRootMap();
		context.put("supplier", CachePoolComponent.getSupplier(staffEntity.getToken()));
		return forword("express/list", context);
	}

	@RequestMapping("/toEdit")
	public ModelAndView toEdit(HttpServletRequest req, HttpServletResponse res) {
		Map<String, Object> context = getRootMap();
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		String id = req.getParameter("id");
		if (id != null) {
			ExpressTemplateBO template = expressService.getExpressTemplate(staffEntity.getToken(), id);
			List<SupplierEntity> list = CachePoolComponent.getSupplier(staffEntity.getToken());
			Map<Integer, String> tempMap = new HashMap<Integer, String>();
			for (SupplierEntity entity : list) {
				tempMap.put(entity.getId(), entity.getSupplierName());
			}
			template.setSupplierName(tempMap.get(template.getSupplierId()));
			context.put("template", template);
		} else {
			context.put("supplier", CachePoolComponent.getSupplier(staffEntity.getToken()));
		}

		return forword("express/add", context);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/dataList")
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse res, ExpressTemplateBO template) {
		PageCallBack pcb = null;
		try {
			StaffEntity staffEntity = SessionUtils.getOperator(req);
			Map<String, Object> params = new HashMap<String, Object>();
			pcb = expressService.dataList(template, params, staffEntity.getToken(),
					ServerCenterContants.ORDER_CENTER_POST_TEMPLATE_QUERY, ExpressTemplateBO.class);
			List<SupplierEntity> list = CachePoolComponent.getSupplier(staffEntity.getToken());
			Map<Integer, String> tempMap = new HashMap<Integer, String>();
			for (SupplierEntity entity : list) {
				tempMap.put(entity.getId(), entity.getSupplierName());
			}
			List<ExpressTemplateBO> tempList = (List<ExpressTemplateBO>) pcb.getObj();
			if (tempList != null && tempList.size() > 0) {
				for (ExpressTemplateBO tpl : tempList) {
					tpl.setSupplierName(tempMap.get(tpl.getSupplierId()));
				}
			}
		} catch (ServerCenterNullDataException e) {
			if (pcb == null) {
				pcb = new PageCallBack();
			}
			pcb.setPagination(template);
			pcb.setSuccess(true);
			return pcb;
		} catch (Exception e) {
			e.printStackTrace();
			if (pcb == null) {
				pcb = new PageCallBack();
			}
			pcb.setErrTrace(e.getMessage());
			pcb.setSuccess(false);
			sendFailureMessage(res, "操作失败：" + e.getMessage());
			return pcb;
		}

		return pcb;
	}

	@RequestMapping("/enable")
	public void enable(HttpServletRequest req, HttpServletResponse res) {
		try {
			StaffEntity staffEntity = SessionUtils.getOperator(req);
			Integer id = Integer.valueOf(req.getParameter("id"));
			expressService.enable(staffEntity, id);
			sendSuccessMessage(res, null);
		} catch (NumberFormatException e) {
			sendFailureMessage(res, "id信息有误，请联系技术");
		} catch (Exception e) {
			e.printStackTrace();
			sendFailureMessage(res, "系统出现异常，请联系技术");
		}
	}

	@RequestMapping("/save")
	public void save(HttpServletRequest req, HttpServletResponse res, @RequestBody ExpressTemplateBO template) {
		try {
			StaffEntity staffEntity = SessionUtils.getOperator(req);
			expressService.save(staffEntity, template);
			sendSuccessMessage(res, null);
		} catch (Exception e) {
			e.printStackTrace();
			sendFailureMessage(res, "系统出现异常，请联系技术");
		}
	}

	@RequestMapping("/del")
	public void del(HttpServletRequest req, HttpServletResponse res) {
		try {
			StaffEntity staffEntity = SessionUtils.getOperator(req);
			Integer id = Integer.valueOf(req.getParameter("id"));
			expressService.del(staffEntity, id);
			sendSuccessMessage(res, null);
		} catch (NumberFormatException e) {
			sendFailureMessage(res, "id有误，请联系技术");
			return;
		} catch (Exception e) {
			e.printStackTrace();
			sendFailureMessage(res, "系统出现异常，请联系技术");
		}
	}

	@RequestMapping("/delRule")
	public void delRule(HttpServletRequest req, HttpServletResponse res) {
		try {
			StaffEntity staffEntity = SessionUtils.getOperator(req);
			Integer id = Integer.valueOf(req.getParameter("id"));
			expressService.delRule(staffEntity, id);
			sendSuccessMessage(res, null);
		} catch (NumberFormatException e) {
			sendFailureMessage(res, "id有误，请联系技术");
			return;
		} catch (Exception e) {
			e.printStackTrace();
			sendFailureMessage(res, "系统出现异常，请联系技术");
		}
	}

	@RequestMapping("/bindRule")
	public ModelAndView bindRule(HttpServletRequest req, HttpServletResponse res) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> context = getRootMap();
		String ids = req.getParameter("id");
		List<ExpressRule> list = expressService.listRule(staffEntity);
		if (ids != null && list != null) {
			String[] idArr = ids.split(",");
			Iterator<ExpressRule> it = list.iterator();
			while (it.hasNext()) {
				ExpressRule rule = it.next();
				for (String id : idArr) {
					if (rule.getId().toString().equals(id)) {
						it.remove();
					}
				}
			}
		}
		context.put("ruleList", list);
		return forword("express/bindRule", context);
	}

	@RequestMapping("/listRuleParam")
	@ResponseBody
	public PageCallBack listRuleParam(HttpServletRequest req, HttpServletResponse res) {
		PageCallBack pcb = new PageCallBack();
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Integer id = Integer.valueOf(req.getParameter("id"));
		String param = req.getParameter("param");
		List<RuleParameter> list = expressService.listRuleParam(staffEntity, id, param);
		pcb.setObj(list);
		pcb.setSuccess(true);
		return pcb;
	}

	@RequestMapping("/toAddRuleParam")
	public ModelAndView toAddRuleParam(HttpServletRequest req, HttpServletResponse res) {
		Map<String, Object> context = getRootMap();
		Integer id = Integer.valueOf(req.getParameter("id"));
		String param = req.getParameter("param");
		context.put("id", id);
		context.put("paramKey", param);
		return forword("express/addRuleParam", context);
	}

	@RequestMapping("/addRuleParam")
	public void addRuleParam(HttpServletRequest req, HttpServletResponse res,
			@RequestBody RuleParameter ruleParameter) {
		try {
			StaffEntity staffEntity = SessionUtils.getOperator(req);
			expressService.addRuleParam(staffEntity, ruleParameter);
			sendSuccessMessage(res, null);
		} catch (Exception e) {
			e.printStackTrace();
			sendFailureMessage(res, e.getMessage());
		}
	}
	
	@RequestMapping("/deliveryList")
	public ModelAndView deliveryList(HttpServletRequest req, HttpServletResponse res) {
		Map<String, Object> context = getRootMap();
		return forword("express/delivery/list", context);
	}

	@RequestMapping("/deliveryDataList")
	@ResponseBody
	public PageCallBack deliveryDataList(HttpServletRequest req, HttpServletResponse res, Pagination pagination) {
		PageCallBack pcb = null;
		try {
			Page<DeliveryEntity> page = null;
			Map<String, Object> params = new HashMap<String, Object>();
			String deliveryName = req.getParameter("deliveryName");
			String hidDeliveryName = req.getParameter("hidDeliveryName");
			String deliveryCode = req.getParameter("deliveryCode");
			String status = req.getParameter("status");
			if (!StringUtil.isEmpty(deliveryName)) {
				params.put("deliveryName", deliveryName);
			}
			if (!StringUtil.isEmpty(hidDeliveryName)) {
				params.put("deliveryName", hidDeliveryName);
			}
			if (!StringUtil.isEmpty(deliveryCode)) {
				params.put("deliveryCode", deliveryCode);
			}
			if (!StringUtil.isEmpty(status)) {
				params.put("status", status);
			}
			page = expressService.deliveryDataList(pagination, params);
			if (pcb == null) {
				pcb = new PageCallBack();
			}
			pcb.setObj(page);
			pcb.setSuccess(true);
			pcb.setPagination(webPageConverter(page));
		} catch (Exception e) {
			if (pcb == null) {
				pcb = new PageCallBack();
			}
			pcb.setErrTrace(e.getMessage());
			pcb.setSuccess(false);
			sendFailureMessage(res, "操作失败：" + e.getMessage());
			return pcb;
		}

		return pcb;
	}

	@RequestMapping("/toEditDelivery")
	public ModelAndView toEditDelivery(HttpServletRequest req, HttpServletResponse res) {
		Map<String, Object> context = getRootMap();
		String id = req.getParameter("id");
		if (id != null) {
			DeliveryEntity info = expressService.queryDeliveryInfoById(id);
			context.put("info", info);
			return forword("express/delivery/edit", context);
		}

		return forword("express/delivery/add", context);
	}

	@RequestMapping("/toSaveDelivery")
	public void toSaveDelivery(HttpServletRequest req, HttpServletResponse res, @RequestBody DeliveryEntity entity) {
		try {
			StaffEntity staffEntity = SessionUtils.getOperator(req);
			entity.setOpt(staffEntity.getOptName());
			expressService.saveDelivery(entity);
			sendSuccessMessage(res, null);
		} catch (Exception e) {
			e.printStackTrace();
			sendFailureMessage(res, "系统出现异常，请联系技术");
		}
	}

	@RequestMapping("/toUpdateDelivery")
	public void toUpdateDelivery(HttpServletRequest req, HttpServletResponse res, @RequestBody DeliveryEntity entity) {
		try {
			StaffEntity staffEntity = SessionUtils.getOperator(req);
			entity.setOpt(staffEntity.getOptName());
			expressService.updateDelivery(entity);
			sendSuccessMessage(res, null);
		} catch (Exception e) {
			e.printStackTrace();
			sendFailureMessage(res, "系统出现异常，请联系技术");
		}
	}
	
	@RequestMapping(value = "/downLoadExcel", method = RequestMethod.GET)
	public void downLoadExcel(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		try {
			WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
			ServletContext servletContext = webApplicationContext.getServletContext();

			String fileName = "expressModel.xlsx";
			String filePath = servletContext.getRealPath("/") + "WEB-INF/classes/" + fileName;

			FileDownloadUtil.downloadFileByBrower(req, resp, filePath, fileName);
		} catch (Exception e) {
			resp.setContentType("text/html;charset=utf-8");
			resp.getWriter().println("下载失败，请重试!");
			resp.getWriter().println(e.getMessage());
			return;
		}
	}
}
