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
 * ClassName: SecondCatalogEntity <br/>
 * Function: 二级分类. <br/>
 * date: Nov 10, 2017 11:38:07 AM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class SecondCatalogEntity {
	private int id;
	private String firstId;
	private String secondId;
	private String name;
	private String createTime;
	private String updateTime;
	private String opt;
	private Integer sort;
	private Integer status;
	private List<ThirdCatalogEntity> thirds;
	private String accessPath;

	public SecondCatalogEntity() {

	}

	public SecondCatalogEntity(JSONObject obj) {
		this.id = obj.getInt("id");
		this.secondId = obj.getString("secondId");
		this.firstId = obj.getString("firstId");
		this.name = obj.getString("name");
		this.updateTime = obj.getString("updateTime");
		this.createTime = obj.getString("createTime");
		this.opt = obj.getString("opt");
		this.sort = obj.getInt("sort");
		this.status = obj.getInt("status");
		this.accessPath = obj.getString("accessPath");

		List<ThirdCatalogEntity> thirds = new ArrayList<ThirdCatalogEntity>();

		try {
			JSONArray array = obj.getJSONArray("thirds");
			if (array == null || array.size() == 0) {
				return;
			}

			for (int i = 0; i < array.size(); i++) {
				ThirdCatalogEntity entity = new ThirdCatalogEntity(array.getJSONObject(i));

				if (entity.getId() == 0)
					continue;
				thirds.add(entity);
			}
			this.thirds = thirds;
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

	public List<ThirdCatalogEntity> getThirds() {
		return thirds;
	}

	public void setThirds(List<ThirdCatalogEntity> thirds) {
		this.thirds = thirds;
	}

	public String getAccessPath() {
		return accessPath;
	}

	public void setAccessPath(String accessPath) {
		this.accessPath = accessPath;
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
}
