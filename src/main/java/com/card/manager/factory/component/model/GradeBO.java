package com.card.manager.factory.component.model;

import java.util.List;

public class GradeBO implements Comparable<GradeBO>{

	private Integer id;
	private Integer parentId;
	private Integer gradeType;
	private String name;
	private List<GradeBO> children;
	public List<GradeBO> getChildren() {
		return children;
	}
	public void setChildren(List<GradeBO> children) {
		this.children = children;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getParentId() {
		return parentId;
	}
	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	public Integer getGradeType() {
		return gradeType;
	}
	public void setGradeType(Integer gradeType) {
		this.gradeType = gradeType;
	}
	@Override
	public int compareTo(GradeBO o) {
		if(id > o.id){
			return 1;
		}
		return -1;
	}
	@Override
	public String toString() {
		return "GradeBO [id=" + id + ", parentId=" + parentId + ", gradeType=" + gradeType + ", name=" + name
				+ ", children=" + children + "]";
	}
	
}
