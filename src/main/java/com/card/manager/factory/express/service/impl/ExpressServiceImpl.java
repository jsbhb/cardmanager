package com.card.manager.factory.express.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.express.model.ExpressFee;
import com.card.manager.factory.express.model.ExpressRule;
import com.card.manager.factory.express.model.ExpressRuleBind;
import com.card.manager.factory.express.model.ExpressTemplateBO;
import com.card.manager.factory.express.model.RuleParameter;
import com.card.manager.factory.express.service.ExpressService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONArray;
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
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_POST_TEMPLATE_GET, token, true, null,
				HttpMethod.GET, params);

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
		if (template.getId() != null) {
			if (template.getExpressList() != null && template.getExpressList().size() > 0) {
				for (ExpressFee express : template.getExpressList()) {
					express.setTemplateId(template.getId());
				}
			}
			if (template.getRuleBindList() != null && template.getRuleBindList().size() > 0) {
				for (ExpressRuleBind bind : template.getRuleBindList()) {
					bind.setTemplateId(template.getId());
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

	@Override
	public void del(StaffEntity staffEntity, Integer id) {
		RestCommonHelper helper = new RestCommonHelper();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		ResponseEntity<String> resultString = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_POST_EXPRESS_DELETE, staffEntity.getToken(),
				true, null, HttpMethod.DELETE, params);

		JSONObject json = JSONObject.fromObject(resultString.getBody());

		if (!json.getBoolean("success")) {
			throw new RuntimeException("删除失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public void delRule(StaffEntity staffEntity, Integer id) {
		RestCommonHelper helper = new RestCommonHelper();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		ResponseEntity<String> resultString = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_POST_EXPRESS_DELETE_RULEBIND,
				staffEntity.getToken(), true, null, HttpMethod.DELETE, params);

		JSONObject json = JSONObject.fromObject(resultString.getBody());

		if (!json.getBoolean("success")) {
			throw new RuntimeException("删除失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	public List<ExpressRule> listRule(StaffEntity staffEntity) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> resultString = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_POST_EXPRESS_RULE, staffEntity.getToken(),
				true, null, HttpMethod.GET);

		JSONObject json = JSONObject.fromObject(resultString.getBody());

		if (!json.getBoolean("success")) {
			throw new RuntimeException("查询信息失败:" + json.getString("errorMsg"));
		}
		List<ExpressRule> list = new ArrayList<ExpressRule>();
		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();
		if (index == 0) {
			return list;
		}
		ExpressRule rule = null;
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			rule = JSONUtilNew.parse(jObj.toString(), ExpressRule.class);
			rule.trimParam();
			list.add(rule);
		}

		return list;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<RuleParameter> listRuleParam(StaffEntity staffEntity, Integer id, String param) {
		RestCommonHelper helper = new RestCommonHelper();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		ResponseEntity<String> resultString = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_POST_EXPRESS_RULE_PARAM,
				staffEntity.getToken(), true, null, HttpMethod.GET, params);

		JSONObject json = JSONObject.fromObject(resultString.getBody());

		if (!json.getBoolean("success")) {
			throw new RuntimeException("查询信息失败:" + json.getString("errorMsg"));
		}
		List<RuleParameter> list = new ArrayList<RuleParameter>();
		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();
		if (index == 0) {
			return list;
		}
		RuleParameter temp = null;
		Map<String, String> paramKeyMap = null;
		Map<String, String> paramValueMap = null;
		StringBuilder sb = null;
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			temp = JSONUtilNew.parse(jObj.toString(), RuleParameter.class);
			sb = new StringBuilder();
			paramKeyMap = JSONUtilNew.parse(param, Map.class);
			paramValueMap = JSONUtilNew.parse(temp.getParam().substring(1, temp.getParam().length() - 1), Map.class);
			for (Map.Entry<String, String> entry : paramKeyMap.entrySet()) {
				for (Map.Entry<String, String> entryTmp : paramValueMap.entrySet()) {
					if (entry.getValue().equals(entryTmp.getKey())) {
						sb.append(entry.getKey() + ":" + entryTmp.getValue() + ";");
					}
				}
			}
			temp.setParam(sb.substring(0, sb.length() - 1));
			list.add(temp);
		}
		return list;
	}

	@Override
	public void addRuleParam(StaffEntity staffEntity, RuleParameter ruleParameter) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> resultString;
			resultString = helper.request(
					URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_POST_EXPRESS_RULE_PARAM_SAVE,
					staffEntity.getToken(), true, ruleParameter, HttpMethod.POST);
			
		JSONObject json = JSONObject.fromObject(resultString.getBody());

		if (!json.getBoolean("success")) {
			throw new RuntimeException("操作失败:" + json.getString("errorMsg"));
		}
	}

}
