package com.card.manager.factory.util;

import com.card.manager.factory.component.model.GradeBO;
import com.card.manager.factory.system.model.GradeEntity;
import com.card.manager.factory.system.model.RebateFormula;
import com.card.manager.factory.system.model.RebateFormulaBO;

public class ConvertUtil {

	public static GradeBO converToGradeBO(GradeEntity gradeInfo){
		GradeBO grade = new GradeBO();
		grade.setId(gradeInfo.getId());
		grade.setCompany(gradeInfo.getCompany());
		grade.setGradeType(gradeInfo.getGradeType());
		grade.setGradeTypeName(gradeInfo.getGradeTypeName());
		grade.setName(gradeInfo.getGradeName());
		grade.setType(gradeInfo.getType());
		grade.setParentId(gradeInfo.getParentId());
		grade.setWelfareType(gradeInfo.getWelfareType());
		grade.setWelfareRebate(gradeInfo.getWelfareRebate());
		return grade;
	}
	
	public static RebateFormulaBO converToRebateFormulaBO(RebateFormula temp) {
		RebateFormulaBO bo = new RebateFormulaBO();
		bo.setFormula(temp.getFormula());
		bo.setGradeTypeId(temp.getGradeTypeId());
		return bo;
	}
}