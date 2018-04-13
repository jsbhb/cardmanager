package com.card.manager.factory.auth.model;

/**
 * 功能实体
 * 
 * @author 贺斌
 * @datetime 2016年12月20日
 * @func
 */
public class FuncEntity {
	private String funcId;
	private String name;
	private String url;
	private String funcGroupId;
	private String parentId;
	private String tag;
	private String createTime;
	private String updateTime;
	private String opt;
	private Integer sort;
	private String parentName;

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

	public String getFuncGroupId() {
		return funcGroupId;
	}

	public void setFuncGroupId(String funcGroupId) {
		this.funcGroupId = funcGroupId;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
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

	public String getOpt() {
		return opt;
	}

	public void setOpt(String opt) {
		this.opt = opt;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getParentName() {
		return parentName;
	}

	public void setParentName(String parentName) {
		this.parentName = parentName;
	}

}
