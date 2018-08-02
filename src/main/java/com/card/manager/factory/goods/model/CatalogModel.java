/**  
 * Project Name:cardmanager  
 * File Name:CatalogModel.java  
 * Package Name:com.card.manager.factory.goods.model  
 * Date:Nov 12, 20175:19:19 PM  
 *  
 */
package com.card.manager.factory.goods.model;

/**
 * ClassName: CatalogModel <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: Nov 12, 2017 5:19:19 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class CatalogModel {

	private String parentId;
	private String id;
	private String name;
	private String type;
	private String category;
	private String accessPath;
	private String tagPath;
	private Integer sort;
	private Integer status;
	private Integer isPopular;

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getAccessPath() {
		return accessPath;
	}

	public void setAccessPath(String accessPath) {
		this.accessPath = accessPath;
	}

	public String getTagPath() {
		return tagPath;
	}

	public void setTagPath(String tagPath) {
		this.tagPath = tagPath;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getIsPopular() {
		return isPopular;
	}

	public void setIsPopular(Integer isPopular) {
		this.isPopular = isPopular;
	}

}
