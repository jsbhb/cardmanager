/**  
 * Project Name:cardmanager  
 * File Name:FirstCatalogEntity.java  
 * Package Name:com.card.manager.factory.goods.model  
 * Date:Nov 10, 201711:38:07 AM  
 *  
 */
package com.card.manager.factory.goods.model;

import net.sf.json.JSONObject;

/**
 * ClassName: ThirdCatalogEntity <br/>
 * Function: 三级分类. <br/>
 * date: Nov 10, 2017 11:38:07 AM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class ThirdCatalogEntity {
	private int id;
	private String thirdId;
	private String secondId;
	private String name;
	private String createTime;
	private String updateTime;
	private String opt;

	public ThirdCatalogEntity() {

	}

	public ThirdCatalogEntity(JSONObject obj) {
		this.id = obj.getInt("id");
		this.secondId = obj.getString("secondId");
		this.thirdId = obj.getString("thirdId");
		this.name = obj.getString("name");
		this.updateTime = obj.getString("updateTime");
		this.createTime = obj.getString("createTime");
		this.opt = obj.getString("opt");
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getThirdId() {
		return thirdId;
	}

	public void setThirdId(String thirdId) {
		this.thirdId = thirdId;
	}

	public String getSecondId() {
		return secondId;
	}

	public void setSecondId(String secondId) {
		this.secondId = secondId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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
