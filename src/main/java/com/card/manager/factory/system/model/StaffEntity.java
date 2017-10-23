/**  
 * Project Name:cardmanager  
 * File Name:StaffEntity.java  
 * Package Name:com.card.manager.factory.system.model  
 * Date:Sep 20, 201710:31:20 AM  
 *  
 */
package com.card.manager.factory.system.model;

import java.util.Date;

/**
 * ClassName: StaffEntity <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: Sep 20, 2017 10:31:20 AM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class StaffEntity {

	private int id;
	private int userCenterId;
	private String name;
	private String phone;
	private String email;
	private String wechat;
	private RoleEntity roleEntity;
	private Date createTime;
	private Date lastUpdateTime;
	private int opt;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserCenterId() {
		return userCenterId;
	}

	public void setUserCenterId(int userCenterId) {
		this.userCenterId = userCenterId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getWechat() {
		return wechat;
	}

	public void setWechat(String wechat) {
		this.wechat = wechat;
	}

	public RoleEntity getRoleEntity() {
		return roleEntity;
	}

	public void setRoleEntity(RoleEntity roleEntity) {
		this.roleEntity = roleEntity;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getLastUpdateTime() {
		return lastUpdateTime;
	}

	public void setLastUpdateTime(Date lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
	}

	public int getOpt() {
		return opt;
	}

	public void setOpt(int opt) {
		this.opt = opt;
	}

}
