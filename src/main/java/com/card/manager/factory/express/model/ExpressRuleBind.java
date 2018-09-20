package com.card.manager.factory.express.model;

import com.card.manager.factory.util.JSONUtilNew;

public class ExpressRuleBind {

	private Integer id;
	private Integer templateId;//模板ID
	private Integer ruleId;//规则ID
	private Integer paramId;//参数ID
	private String param;//参数值
	private String description;
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getParam() {
		return param;
	}
	public void setParam(String param) {
		this.param = param;
	}
	public Integer getTemplateId() {
		return templateId;
	}
	public void setTemplateId(Integer templateId) {
		this.templateId = templateId;
	}
	public Integer getParamId() {
		return paramId;
	}
	public void setParamId(Integer paramId) {
		this.paramId = paramId;
	}
	public Integer getRuleId() {
		return ruleId;
	}
	public void setRuleId(Integer ruleId) {
		this.ruleId = ruleId;
	}
	
	@Override
	public String toString() {
		return JSONUtilNew.toJson(this);
	}
	
}
