package com.card.manager.factory.express.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.express.model.ExpressFee;
import com.card.manager.factory.express.model.ExpressTemplateBO;
import com.card.manager.factory.express.service.ExpressService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONObject;

@Service
public class ExpressServiceImpl extends AbstractServcerCenterBaseService implements ExpressService {

	@Override
	public void enable(StaffEntity staffEntity, Integer id) {
		RestCommonHelper helper = new RestCommonHelper();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		ResponseEntity<String> resultString = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_POST_TEMPLATE_ENABLE,
				staffEntity.getToken(), true, null, HttpMethod.POST, params);
		
		JSONObject json = JSONObject.fromObject(resultString.getBody());
		if (!json.getBoolean("success")) {
			throw new RuntimeException("启用模板失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public ExpressTemplateBO getExpressTemplate(String token, String id) {
		RestCommonHelper helper = new RestCommonHelper();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		ResponseEntity<String> resultString = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_POST_TEMPLATE_GET,
				token, true, null, HttpMethod.GET, params);
		
		JSONObject json = JSONObject.fromObject(resultString.getBody());
		
		if (!json.getBoolean("success")) {
			throw new RuntimeException("查询信息失败:" + json.getString("errorMsg"));
		}
		
		return JSONUtilNew.parse(json.get("obj").toString(), ExpressTemplateBO.class);
	}

	@Override
	public void save(StaffEntity staffEntity, ExpressTemplateBO template) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> resultString;
		template.setOpt(staffEntity.getOptName());
		if(template.getId() != null){
			if(template.getExpressList() != null && template.getExpressList().size() > 0){
				for(ExpressFee express : template.getExpressList()){
					express.setTemplateId(template.getId());
				}
			}
			resultString = helper.request(
					URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_POST_TEMPLATE_UPDATE,
					staffEntity.getToken(), true, template, HttpMethod.POST);
		} else {
			resultString = helper.request(
					URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_POST_TEMPLATE_SAVE,
					staffEntity.getToken(), true, template, HttpMethod.POST);
		}
		JSONObject json = JSONObject.fromObject(resultString.getBody());
		
		if (!json.getBoolean("success")) {
			throw new RuntimeException("操作失败:" + json.getString("errorMsg"));
		}
	}

}
