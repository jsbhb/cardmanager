package com.card.manager.factory.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.card.manager.factory.component.model.GradeBO;

public class TreePackUtil {

	/**
	 * @fun 获取指定ID下的所有子节点 ,层级过多无限递归可能造成OOM
	 * @param list
	 * @param gradeId
	 * @return
	 */
	public static void packGradeChildren(List<GradeBO> list, List<GradeBO> result, Integer gradeId) {
		if (list != null && list.size() > 0) {
			for (GradeBO model : list) {
				if (gradeId.equals(model.getParentId())) {
					packGradeChildren(list, result, model.getId());
					result.add(model);
				}
			}
		}
	}

	public static List<GradeBO> packGradeChildren(List<GradeBO> list, Integer gradeId) {
		List<GradeBO> rootList = new ArrayList<GradeBO>();
		if (list != null && list.size() > 0) {
			Map<Integer, GradeBO> tempMap = new HashMap<Integer, GradeBO>();
			List<GradeBO> tempList = new ArrayList<GradeBO>();
			List<GradeBO> children = null;
			for (GradeBO grade : list) {
				grade.setChildren(null);
				if (gradeId != 0) {
					if (grade.getId() == gradeId) {
						rootList.add(grade);
					}
					if (grade.getId() >= gradeId) {
						tempMap.put(grade.getId(), grade);
						tempList.add(grade);
					}
				} else {
					if (grade.getParentId() == null || grade.getParentId() == 0) {
						rootList.add(grade);
					}
					tempList.add(grade);
					tempMap.put(grade.getId(), grade);
				}
			}
			for(GradeBO grade : tempList){
				GradeBO temp = tempMap.get(grade.getParentId());
				if(temp != null){
					if (temp.getChildren() == null) {
						children = new ArrayList<GradeBO>();
						children.add(grade);
						temp.setChildren(children);
					} else {
						temp.getChildren().add(grade);
					}
				}
			}
		}
		return rootList;
	}

}
