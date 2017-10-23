/**  
 * Project Name:cardmanager  
 * File Name:GradeInfo.java  
 * Package Name:com.card.manager.factory.auth.model  
 * Date:Sep 20, 20179:53:31 AM  
 *  
 */
package com.card.manager.factory.system.model;

import java.sql.Date;

/**
 * ClassName: GradeInfo <br/>
 * Function: 级别模型. <br/>
 * date: Sep 20, 2017 9:53:31 AM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class GradeEntity {
	private int id;
	private String name;
	private String email;
	private String phone;
	private String post;
	private String fax;
	private String address;
	private int chief;
	private int gradeCenterId;
	private String company;
	private String userName;
	private int staffId;
	private int userCenterId;
	private Date createTime;
	private Date lastUpdateTime;
	private int opt;

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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPost() {
		return post;
	}

	public void setPost(String post) {
		this.post = post;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getChief() {
		return chief;
	}

	public void setChief(int chief) {
		this.chief = chief;
	}

	public int getGradeCenterId() {
		return gradeCenterId;
	}

	public void setGradeCenterId(int gradeCenterId) {
		this.gradeCenterId = gradeCenterId;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getStaffId() {
		return staffId;
	}

	public void setStaffId(int staffId) {
		this.staffId = staffId;
	}

	public int getUserCenterId() {
		return userCenterId;
	}

	public void setUserCenterId(int userCenterId) {
		this.userCenterId = userCenterId;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getLastUpdateTime() {
		return lastUpdateTime;
	}

	public void setLastUpdateTime(Date lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
	}

	public int getOpt() {
		return opt;
	}

	public void setOpt(int opt) {
		this.opt = opt;
	}

}
