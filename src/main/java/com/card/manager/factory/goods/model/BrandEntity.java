/**  
 * Project Name:cardmanager  
 * File Name:BrandEntity.java  
 * Package Name:com.card.manager.factory.goods.model  
 * Date:Nov 9, 20177:37:40 PM  
 *  
 */
package com.card.manager.factory.goods.model;

import net.sf.json.JSONObject;

/**
 * ClassName: BrandEntity <br/>
 * Function: 品牌. <br/>
 * date: Nov 9, 2017 7:37:40 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class BrandEntity {

	private int id;
	private String brandId;
	private String brand;
	private String attr;
	private String createTime;
	private String updateTime;
	private String opt;

	public BrandEntity() {
	}

	public BrandEntity(JSONObject obj) {
		this.id = obj.getInt("id");
		this.brandId = obj.getString("brandId");
		this.brand = obj.getString("brand");
		this.opt = obj.getString("opt");
		this.attr = obj.getString("attr");
		this.createTime = obj.getString("createTime");
		this.updateTime = obj.getString("updateTime");
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getBrandId() {
		return brandId;
	}

	public void setBrandId(String brandId) {
		this.brandId = brandId;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getAttr() {
		return attr;
	}

	public void setAttr(String attr) {
		this.attr = attr;
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

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BrandEntity other = (BrandEntity) obj;
		if (id != other.id)
			return false;
		return true;
	}
	
	
}
