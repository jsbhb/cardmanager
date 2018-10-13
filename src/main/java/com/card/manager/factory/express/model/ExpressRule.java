package com.card.manager.factory.express.model;

public class ExpressRule {

	private Integer id;
	private String description;
	private String param;
	public void trimParam(){
		this.param = this.param.substring(1, param.length() - 1);
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getParam() {
		return param;
	}
	public void setParam(String param) {
		this.param = param;
	}
}
