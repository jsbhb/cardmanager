package com.card.manager.factory.system.model;

public class CustomerTypeEntity {

	private Integer typeId; //1:普通客户 2:对接客户 3:福利客户
	private String typeName;

	public Integer getTypeId() {
		return typeId;
	}

	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	
}
