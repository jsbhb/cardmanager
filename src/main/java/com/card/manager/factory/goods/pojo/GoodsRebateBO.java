package com.card.manager.factory.goods.pojo;

import java.util.Map;

import com.card.manager.factory.annotation.FieldDescribe;
import com.card.manager.factory.util.Utils;

public class GoodsRebateBO {

	@FieldDescribe(describe="没有分级名称")
	private String gradeName;
	@FieldDescribe(describe="匹配不到分级编号,请核对和对照表中是否一致")
	private Integer gradeNameId;
	@FieldDescribe(describe="没有返佣比例")
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
