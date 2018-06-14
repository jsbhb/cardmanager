package com.card.manager.factory.express.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.base.PageCallBack;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.express.model.ExpressTemplateBO;
import com.card.manager.factory.express.service.ExpressService;
import com.card.manager.factory.supplier.model.SupplierEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.SessionUtils;

@Controller
@RequestMapping("/admin/expressMng")
public class ExpressMngController extends BaseController{

	@Resource
	ExpressService expressService;
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse res){
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String,Object> context = getRootMap();
		context.put("supplier", CachePoolComponent.getSupplier(staffEntity.getToken()));
		return forword("express/list", context);
	}
	
	@RequestMapping("/toEdit")
	public ModelAndView toEdit(HttpServletRequest req, HttpServletResponse res){
		Map<String,Object> context = getRootMap();
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		String id = req.getParameter("id");
		if(id != null){
			ExpressTemplateBO template = expressService.getExpressTemplate(staffEntity.getToken(),id);
			List<SupplierEntity> list = CachePoolComponent.getSupplier(staffEntity.getToken());
			Map<Integer,String> tempMap = new HashMap<Integer,String>();
			for(SupplierEntity entity : list){
				tempMap.put(entity.getId(), entity.getSupplierName());
			}
			template.setSupplierName(tempMap.get(template.getSupplierId()));
			context.put("template",template);
		} else {
			context.put("supplier", CachePoolComponent.getSupplier(staffEntity.getToken()));
		}
		
		return forword("express/add", context);
	}
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/dataList")
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse res,ExpressTemplateBO template){
		PageCallBack pcb = null;
		try {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String,Object> params = new HashMap<String,Object>();
		pcb = expressService.dataList(template, params, staffEntity.getToken(),
				ServerCenterContants.ORDER_CENTER_POST_TEMPLATE_QUERY, ExpressTemplateBO.class);
		List<SupplierEntity> list = CachePoolComponent.getSupplier(staffEntity.getToken());
		Map<Integer,String> tempMap = new HashMap<Integer,String>();
		for(SupplierEntity entity : list){
			tempMap.put(entity.getId(), entity.getSupplierName());
		}
		List<ExpressTemplateBO> tempList = (List<ExpressTemplateBO>) pcb.getObj();
		if(tempList != null && tempList.size() > 0){
			for(ExpressTemplateBO tpl : tempList){
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
	public void enable(HttpServletRequest req, HttpServletResponse res){
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
	public void save(HttpServletRequest req, HttpServletResponse res, @RequestBody ExpressTemplateBO template){
		try {
			StaffEntity staffEntity = SessionUtils.getOperator(req);
			expressService.save(staffEntity, template);
			sendSuccessMessage(res, null);
		} catch (Exception e) {
			e.printStackTrace();
			sendFailureMessage(res, "系统出现异常，请联系技术");
		}
	}
}
