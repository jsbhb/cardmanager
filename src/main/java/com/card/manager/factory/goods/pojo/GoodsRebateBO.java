package com.card.manager.factory.goods.pojo;

import java.util.Map;

import com.card.manager.factory.util.Utils;

public class GoodsRebateBO {

	private String gradeName;
	private Integer gradeNameId;
	private String proportion;
	
	public boolean hasValue(){
		return gradeName != null && proportion != null && !"".equals(gradeName) && !"".equals(proportion);
	}
	
	public void init(Map<String, Integer> gradeMapTemp) {
		gradeNameId = gradeMapTemp.get(Utils.removePoint(gradeName));
		
	}
	
	public Integer getGradeNameId() {
		return gradeNameId;
	}
	public void setGradeNameId(Integer gradeNameId) {
		this.gradeNameId = gradeNameId;
	}
	public String getGradeName() {
		return gradeName;
	}
	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}
	public String getProportion() {
		return proportion;
	}
	public void setProportion(String proportion) {
		this.proportion = proportion;
	}
	
	
}
