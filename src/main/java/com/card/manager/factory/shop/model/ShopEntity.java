/**  
 * Project Name:cardmanager  
 * File Name:BrandEntity.java  
 * Package Name:com.card.manager.factory.goods.model  
 * Date:Nov 9, 20177:37:40 PM  
 *  
 */
package com.card.manager.factory.shop.model;

import net.sf.json.JSONObject;

public class ShopEntity {

	private int id;
	private int gradeId;
	private String headImg;
	private String aboutUs;
	private String name;
	private String attribute;
	private String createTime;
	private String updateTime;
	private String opt;
	
	public ShopEntity() {
	}
	
	public ShopEntity(JSONObject jObj) {
		this.id = jObj.getInt("id");
		this.gradeId = jObj.getInt("gradeId");
		this.headImg = jObj.getString("headImg");
		this.aboutUs = jObj.getString("aboutUs");
		this.name = jObj.getString("name");
		this.attribute = jObj.getString("attribute");
		this.updateTime = jObj.getString("updateTime");
		this.createTime = jObj.getString("createTime");
		this.opt = jObj.getString("opt");
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getGradeId() {
		return gradeId;
	}
	public void setGradeId(int gradeId) {
		this.gradeId = gradeId;
	}
	public String getHeadImg() {
		return headImg;
	}
	public void setHeadImg(String headImg) {
		this.headImg = headImg;
	}
	public String getAboutUs() {
		return aboutUs;
	}
	public void setAboutUs(String aboutUs) {
		this.aboutUs = aboutUs;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAttribute() {
		return attribute;
	}
	public void setAttribute(String attribute) {
		this.attribute = attribute;
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
	
}
