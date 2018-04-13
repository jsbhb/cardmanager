package com.card.manager.factory.util;

import java.util.List;

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

}
