/**  
 * Project Name:cardmanager  
 * File Name:BrandEntity.java  
 * Package Name:com.card.manager.factory.goods.model  
 * Date:Nov 9, 20177:37:40 PM  
 *  
 */
package com.card.manager.factory.goods.model;

import com.card.manager.factory.base.Pagination;

/**
 * ClassName: BrandEntity <br/>
 * Function: 品牌. <br/>
 * date: Nov 9, 2017 7:37:40 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class BrandEntity extends Pagination {

	private int id;
	private String brandId;
	private String brand;
	private String attr;
	private String createTime;
	private String updateTime;
	private String opt;
	
	//商品库改造新增字段
	private String brandLogo;
	private String brandSynopsis;
	private String brandNameCn;
	private String brandNameEn;
	private String country;

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

	public String getBrandLogo() {
		return brandLogo;
	}

	public void setBrandLogo(String brandLogo) {
		this.brandLogo = brandLogo;
	}

	public String getBrandSynopsis() {
		return brandSynopsis;
	}

	public void setBrandSynopsis(String brandSynopsis) {
		this.brandSynopsis = brandSynopsis;
	}

	public String getBrandNameCn() {
		return brandNameCn;
	}

	public void setBrandNameCn(String brandNameCn) {
		this.brandNameCn = brandNameCn;
	}

	public String getBrandNameEn() {
		return brandNameEn;
	}

	public void setBrandNameEn(String brandNameEn) {
		this.brandNameEn = brandNameEn;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}
}
