package com.card.manager.factory.auth.model;

import java.io.Serializable;
import java.util.List;

/**
 * 
 * @author 贺斌
 * @datetime 2016年7月27日
 * @func 权限信息
 */
public class AuthInfo implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String funcId;
	private String name;
	private String url;
	private String tag;
	private String parentId;
	private String privilege;
	private List<AuthInfo> children;

	public String getFuncId() {
		return funcId;
	}

	public void setFuncId(String funcId) {
		this.funcId = funcId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getPrivilege() {
		return privilege;
	}

	public void setPrivilege(String privilege) {
		this.privilege = privilege;
	}

	public List<AuthInfo> getChildren() {
		return children;
	}

	public void setChildren(List<AuthInfo> children) {
		this.children = children;
	}

}
