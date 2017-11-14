/**  
 * Project Name:cardmanager  
 * File Name:FirstCatalogEntity.java  
 * Package Name:com.card.manager.factory.goods.model  
 * Date:Nov 10, 201711:38:07 AM  
 *  
 */
package com.card.manager.factory.goods.model;

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * ClassName: FirstCatalogEntity <br/>
 * Function: 一级分类. <br/>
 * date: Nov 10, 2017 11:38:07 AM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class FirstCatalogEntity {
	private int id;
	private String firstId;
	private String name;
	private String createTime;
	private String updateTime;
	private String opt;
	private List<SecondCatalogEntity> seconds;

	public FirstCatalogEntity() {

	}

	public FirstCatalogEntity(JSONObject obj) {
		this.id = obj.getInt("id");
		this.firstId = obj.getString("firstId");
		this.name = obj.getString("name");
		this.updateTime = obj.getString("updateTime");
		this.createTime = obj.getString("createTime");
		this.opt = obj.getString("opt");

		List<SecondCatalogEntity> seconds = new ArrayList<SecondCatalogEntity>();

		try {
			JSONArray array = obj.getJSONArray("seconds");
			if (array == null || array.size() == 0) {
				return;
			}

			for (int i = 0; i < array.size(); i++) {
				SecondCatalogEntity entity = new SecondCatalogEntity(array.getJSONObject(i));
				if (entity.getId() == 0)
					continue;
				seconds.add(entity);
			}
			this.seconds = seconds;
		} catch (Exception e) {

		}
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFirstId() {
		return firstId;
	}

	public void setFirstId(String firstId) {
		this.firstId = firstId;
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

	public List<SecondCatalogEntity> getSeconds() {
		return seconds;
	}

	public void setSeconds(List<SecondCatalogEntity> seconds) {
		this.seconds = seconds;
	}

}
