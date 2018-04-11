/**  
 * Project Name:cardmanager  
 * File Name:SpecsTemplate.java  
 * Package Name:com.card.manager.factory.goods.model  
 * Date:Dec 4, 20173:48:50 PM  
 *  
 */
package com.card.manager.factory.goods.model;

import java.util.ArrayList;
import java.util.List;

import com.card.manager.factory.base.Pagination;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * ClassName: SpecsTemplateEntity <br/>
 * Function: 规格模板. <br/>
 * date: Dec 4, 2017 3:48:50 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class SpecsTemplateEntity extends Pagination {
	private int id;
	private String name;
	private String createTime;
	private String updateTime;
	private String opt;
	private List<SpecsEntity> specs;
	private int status;

	public SpecsTemplateEntity(){}

	public SpecsTemplateEntity(JSONObject jsonObject) {
		this.id = jsonObject.getInt("id");
		this.status = jsonObject.getInt("status");
		this.name = jsonObject.getString("name");
		this.createTime = jsonObject.getString("createTime");
		this.updateTime = jsonObject.getString("updateTime");
		this.opt = jsonObject.getString("opt");
		
		List<SpecsEntity> temp = new ArrayList<SpecsEntity>();

		try {
			JSONArray array = jsonObject.getJSONArray("specs");
			if (array == null || array.size() == 0) {
				return;
			}

			for (int i = 0; i < array.size(); i++) {
				SpecsEntity entity = new SpecsEntity(array.getJSONObject(i));
				if (entity.getId() == 0)
					continue;
				temp.add(entity);
			}
			this.specs = temp;
		} catch (Exception e) {

		}
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

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public List<SpecsEntity> getSpecs() {
		return specs;
	}

	public void setSpecses(List<SpecsEntity> specs) {
		this.specs = specs;
	}

}
