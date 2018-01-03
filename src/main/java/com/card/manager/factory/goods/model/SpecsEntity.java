/**  
 * Project Name:cardmanager  
 * File Name:SpecsEntity.java  
 * Package Name:com.card.manager.factory.goods.model  
 * Date:Dec 4, 20173:48:17 PM  
 *  
 */
package com.card.manager.factory.goods.model;

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * ClassName: SpecsEntity <br/>
 * Function: 规格实体. <br/>
 * date: Dec 4, 2017 3:48:17 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class SpecsEntity {
	private int templateId;
	private int id;
	private String name;
	private List<SpecsValueEntity> values;

	public SpecsEntity(String name, List<SpecsValueEntity> values) {
		this.name = name;
		this.values = values;
	}

	public SpecsEntity() {
	}

	public SpecsEntity(JSONObject jsonObject) {
		this.id = jsonObject.getInt("id");
		this.name = jsonObject.getString("name");
		this.createTime = jsonObject.getString("createTime");
		this.updateTime = jsonObject.getString("updateTime");
		this.opt = jsonObject.getString("opt");

		List<SpecsValueEntity> temp = new ArrayList<SpecsValueEntity>();

		try {
			JSONArray array = jsonObject.getJSONArray("specs");
			if (array == null || array.size() == 0) {
				return;
			}

			for (int i = 0; i < array.size(); i++) {
				SpecsValueEntity entity = new SpecsValueEntity(array.getJSONObject(i));
				if (entity.getId() == 0)
					continue;
				temp.add(entity);
			}
			this.values = temp;
		} catch (Exception e) {

		}
	}

	public int getTemplateId() {
		return templateId;
	}

	public void setTemplateId(int templateId) {
		this.templateId = templateId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<SpecsValueEntity> getValues() {
		return values;
	}

	public void setValues(List<SpecsValueEntity> values) {
		this.values = values;
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

	private String createTime;
	private String updateTime;
	private String opt;

}
