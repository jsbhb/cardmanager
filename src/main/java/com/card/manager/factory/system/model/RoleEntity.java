/**  
 * Project Name:cardmanager  
 * File Name:RoleEntity.java  
 * Package Name:com.card.manager.factory.system.model  
 * Date:Sep 20, 201710:31:10 AM  
 *  
 */
package com.card.manager.factory.system.model;

import java.util.List;

import com.card.manager.factory.auth.model.AuthInfo;

/**
 * ClassName: RoleEntity <br/>
 * Function: 角色实例. <br/>
 * date: Sep 20, 2017 10:31:10 AM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class RoleEntity {

	private int roleId;
	private String roleName;
	private String funcId;
	private String roleState;
	private String createTime;
	private String updateTime;
	private int opt;
	private int type;// 级别
	private List<AuthInfo> authList;
	private List<RoleEntity> children;
	private int parentId;
	private String parentName;
	private String privilege;

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getRoleState() {
		return roleState;
	}

	public void setRoleState(String roleState) {
		this.roleState = roleState;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public int getOpt() {
		return opt;
	}

	public void setOpt(int opt) {
		this.opt = opt;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public List<AuthInfo> getAuthList() {
		return authList;
	}

	public void setAuthList(List<AuthInfo> authList) {
		this.authList = authList;
	}

	public String getFuncId() {
		return funcId;
	}

	public void setFuncId(String funcId) {
		this.funcId = funcId;
	}

	public int getParentId() {
		return parentId;
	}

	public void setParentId(int parentId) {
		this.parentId = parentId;
	}

	public List<RoleEntity> getChildren() {
		return children;
	}

	public void setChildren(List<RoleEntity> children) {
		this.children = children;
	}

	public String getParentName() {
		return parentName;
	}

	public void setParentName(String parentName) {
		this.parentName = parentName;
	}

	public String getPrivilege() {
		return privilege;
	}

	public void setPrivilege(String privilege) {
		this.privilege = privilege;
	}

}
