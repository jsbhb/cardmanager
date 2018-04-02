package com.card.manager.factory.order.model;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

@JsonInclude(Include.NON_NULL)
public class PushUser {

	private Integer id;
	
	private Integer userId;
	
	private String phone;
	
	private String gradeName;
	
	private String name;
	
	private Integer gradeId;
	
	private String inviter;
	
	private String specialtyChannel;
	
	private Integer status;
	
	private Integer type;
	
	private Integer centerId;
	
	private int orderCount;

	public boolean check(){
		return phone != null && name != null && gradeId != null && inviter != null && specialtyChannel != null;
	}
	
	public Integer getOrderCount() {
		return orderCount;
	}

	public void setOrderCount(Integer orderCount) {
		this.orderCount = orderCount;
	}

	public Integer getCenterId() {
		return centerId;
	}

	public void setCenterId(Integer centerId) {
		this.centerId = centerId;
	}

	public String getGradeName() {
		return gradeName;
	}

	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getGradeId() {
		return gradeId;
	}

	public void setGradeId(Integer gradeId) {
		this.gradeId = gradeId;
	}

	public String getInviter() {
		return inviter;
	}

	public void setInviter(String inviter) {
		this.inviter = inviter;
	}

	public String getSpecialtyChannel() {
		return specialtyChannel;
	}

	public void setSpecialtyChannel(String specialtyChannel) {
		this.specialtyChannel = specialtyChannel;
	}

	@Override
	public String toString() {
		return "PushUser [name=" + name + "]";
	}
	
}
