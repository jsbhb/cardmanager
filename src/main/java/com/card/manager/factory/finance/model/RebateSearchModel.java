package com.card.manager.factory.finance.model;

import java.util.List;

import com.card.manager.factory.base.Pagination;

public class RebateSearchModel extends Pagination{

	private Integer type;
	private List<String> list;
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public List<String> getList() {
		return list;
	}
	public void setList(List<String> list) {
		this.list = list;
	}
	
	
}
