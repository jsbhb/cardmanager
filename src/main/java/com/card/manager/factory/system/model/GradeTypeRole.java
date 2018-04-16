/**  
 * Project Name:cardmanager  
 * File Name:GradeTypeRole.java  
 * Package Name:com.card.manager.factory.system.model  
 * Date:Apr 16, 20187:36:52 PM  
 *  
 */
package com.card.manager.factory.system.model;

import java.util.Date;

/**
 * ClassName: GradeTypeRole <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: Apr 16, 2018 7:36:52 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class GradeTypeRole {

	private Integer gradeTypeId;
	private Integer roleId;
	private Date createTime;
	private Date updateTime;
	private String opt;

	public GradeTypeRole(Integer gradeTypeId, Integer roleId) {
		super();
		this.gradeTypeId = gradeTypeId;
		this.roleId = roleId;
	}

	public Integer getGradeTypeId() {
		return gradeTypeId;
	}

	public void setGradeTypeId(Integer gradeTypeId) {
		this.gradeTypeId = gradeTypeId;
	}

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getOpt() {
		return opt;
	}

	public void setOpt(String opt) {
		this.opt = opt;
	}

}
