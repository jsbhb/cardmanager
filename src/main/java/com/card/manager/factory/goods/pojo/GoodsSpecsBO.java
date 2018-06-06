package com.card.manager.factory.goods.pojo;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.card.manager.factory.annotation.FieldDescribe;
import com.card.manager.factory.util.Utils;

public class GoodsSpecsBO {
	
	@FieldDescribe(describe="没有规格项")
	private String specsName;
	private Integer specsNameId;
	@FieldDescribe(describe="没有规格值")
	private String specsValue;
	private Integer specsValueId;
	public void init(Map<String, Integer> specsNameMap, Map<Integer, Map<String, Integer>> specsValueMap) {
		specsNameId = specsNameMap.get(Utils.removePoint(specsName));
		if(specsNameId != null){
			specsValueId = specsValueMap.get(specsNameId).get(specsValue);
		}
	}
	
	public boolean hasValue(){
		return specsName != null && specsValue != null && !"".equals(specsValue) && !"".equals(specsName);
	}
	
	public List<String> getUnCheckFieldName(){
		List<String> list = new ArrayList<String>();
		list.add("specsNameId");
		list.add("specsValueId");
		return list;
	}
	
	public Integer getSpecsNameId() {
		return specsNameId;
	}
	public void setSpecsNameId(Integer specsNameId) {
		this.specsNameId = specsNameId;
	}
	public Integer getSpecsValueId() {
		return specsValueId;
	}
	public void setSpecsValueId(Integer specsValueId) {
		this.specsValueId = specsValueId;
	}
	public String getSpecsName() {
		return specsName;
	}
	public void setSpecsName(String specsName) {
		this.specsName = specsName;
	}
	public String getSpecsValue() {
		return specsValue;
	}
	public void setSpecsValue(String specsValue) {
		this.specsValue = specsValue;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((specsNameId == null) ? 0 : specsNameId.hashCode());
		result = prime * result + ((specsValueId == null) ? 0 : specsValueId.hashCode());
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
		GoodsSpecsBO other = (GoodsSpecsBO) obj;
		if (specsNameId == null) {
			if (other.specsNameId != null)
				return false;
		} else if (!specsNameId.equals(other.specsNameId))
			return false;
		if (specsValueId == null) {
			if (other.specsValueId != null)
				return false;
		} else if (!specsValueId.equals(other.specsValueId))
			return false;
		return true;
	}
	
}
