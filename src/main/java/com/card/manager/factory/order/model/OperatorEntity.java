package com.card.manager.factory.order.model;

/**
 * 
 * ClassName: Operator <br/>
 * Function: 操作者. <br/>
 * date: Oct 24, 2017 4:43:39 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class OperatorEntity {

	private String optid;
	private String badge;
	private String optName;
	private String password;
	private String status;
	private int gradeId;
	private int shopId;
	private int gradeLevel;
	private int userCenterId;
	private String gradeName;
	private int parentGradeId;
	public String getOptid() {
		return optid;
	}
	public void setOptid(String optid) {
		this.optid = optid;
	}
	public String getBadge() {
		return badge;
	}
	public void setBadge(String badge) {
		this.badge = badge;
	}
	public String getOptName() {
		return optName;
	}
	public void setOptName(String optName) {
		this.optName = optName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getGradeId() {
		return gradeId;
	}
	public void setGradeId(int gradeId) {
		this.gradeId = gradeId;
	}
	public int getShopId() {
		return shopId;
	}
	public void setShopId(int shopId) {
		this.shopId = shopId;
	}
	public int getGradeLevel() {
		return gradeLevel;
	}
	public void setGradeLevel(int gradeLevel) {
		this.gradeLevel = gradeLevel;
	}
	public int getUserCenterId() {
		return userCenterId;
	}
	public void setUserCenterId(int userCenterId) {
		this.userCenterId = userCenterId;
	}
	public String getGradeName() {
		return gradeName;
	}
	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}
	public int getParentGradeId() {
		return parentGradeId;
	}
	public void setParentGradeId(int parentGradeId) {
		this.parentGradeId = parentGradeId;
	}

}
