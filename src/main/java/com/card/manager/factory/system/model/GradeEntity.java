/**  
 * Project Name:cardmanager  
 * File Name:GradeInfo.java  
 * Package Name:com.card.manager.factory.auth.model  
 * Date:Sep 20, 20179:53:31 AM  
 *  
 */
package com.card.manager.factory.system.model;

import com.card.manager.factory.base.Pagination;

import net.sf.json.JSONObject;

/**
 * ClassName: GradeInfo <br/>
 * Function: 级别模型. <br/>
 * date: Sep 20, 2017 9:53:31 AM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class GradeEntity extends Pagination{

	private Integer id;

	private String account;

	private Integer parentId;

	private String parentGradeName;

	private Integer gradeType;

	private String gradeName;

	private String personInCharge;

	private int personInChargeId;

	private String phone;

	private String attribute;

	private Integer gradePersonInCharge;// 负责该区域中心的人

	private String createTime;

	private String updateTime;

	private String opt;

	private String company;
	
	private Integer gradeLevel;
	
	//新添加审核资料字段

	private String storeName;

	private String contacts;

	private String contactsPhone;

	private String province;

	private String city;

	private String district;

	private String address;

	private String storeOperator;

	private String operatorIDNum;

	private String picPath1;

	private String picPath2;

	private String picPath3;

	private String picPath4;
	
	
	public Integer getGradeLevel() {
		return gradeLevel;
	}

	public void setGradeLevel(Integer gradeLevel) {
		this.gradeLevel = gradeLevel;
	}

	public GradeEntity() {
	}

	public GradeEntity(JSONObject jObj) {
		this.id = jObj.getInt("id");
		try {
			this.parentId = jObj.getInt("parentId");
			this.parentGradeName = jObj.getString("parentGradeName");
			} catch (Exception e) {
		}
		this.gradeName = jObj.getString("gradeName");
		this.company = jObj.getString("company");
		this.updateTime = jObj.getString("updateTime");
		this.createTime = jObj.getString("createTime");
		this.personInCharge = jObj.getString("personInCharge");
		this.gradePersonInCharge = jObj.getInt("gradePersonInCharge");
		this.phone = jObj.getString("phone");
		this.gradeType = jObj.getInt("gradeType");
		this.personInChargeId = jObj.getInt("personInChargeId");
		//添加注册资料
		this.storeName = jObj.getString("storeName");
		this.contacts = jObj.getString("contacts");
		this.contactsPhone = jObj.getString("contactsPhone");
		this.province = jObj.getString("province");
		this.city = jObj.getString("city");
		this.district = jObj.getString("district");
		this.address = jObj.getString("address");
		this.storeOperator = jObj.getString("storeOperator");
		this.operatorIDNum = jObj.getString("operatorIDNum");
		this.picPath1 = jObj.getString("picPath1");
		this.picPath2 = jObj.getString("picPath2");
		this.picPath3 = jObj.getString("picPath3");
		this.picPath4 = jObj.getString("picPath4");
	}

	public String getParentGradeName() {
		return parentGradeName;
	}

	public void setParentGradeName(String parentGradeName) {
		this.parentGradeName = parentGradeName;
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

	public int getPersonInChargeId() {
		return personInChargeId;
	}

	public void setPersonInChargeId(int personInChargeId) {
		this.personInChargeId = personInChargeId;
	}

	public Integer getGradeType() {
		return gradeType;
	}

	public void setGradeType(Integer gradeType) {
		this.gradeType = gradeType;
	}

	public String getGradeName() {
		return gradeName;
	}

	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}

	public String getPersonInCharge() {
		return personInCharge;
	}

	public void setPersonInCharge(String personInCharge) {
		this.personInCharge = personInCharge;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAttribute() {
		return attribute;
	}

	public void setAttribute(String attribute) {
		this.attribute = attribute;
	}

	public Integer getGradePersonInCharge() {
		return gradePersonInCharge;
	}

	public void setGradePersonInCharge(Integer gradePersonInCharge) {
		this.gradePersonInCharge = gradePersonInCharge;
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

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getContacts() {
		return contacts;
	}

	public void setContacts(String contacts) {
		this.contacts = contacts;
	}

	public String getContactsPhone() {
		return contactsPhone;
	}

	public void setContactsPhone(String contactsPhone) {
		this.contactsPhone = contactsPhone;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getStoreOperator() {
		return storeOperator;
	}

	public void setStoreOperator(String storeOperator) {
		this.storeOperator = storeOperator;
	}

	public String getOperatorIDNum() {
		return operatorIDNum;
	}

	public void setOperatorIDNum(String operatorIDNum) {
		this.operatorIDNum = operatorIDNum;
	}

	public String getPicPath1() {
		return picPath1;
	}

	public void setPicPath1(String picPath1) {
		this.picPath1 = picPath1;
	}

	public String getPicPath2() {
		return picPath2;
	}

	public void setPicPath2(String picPath2) {
		this.picPath2 = picPath2;
	}

	public String getPicPath3() {
		return picPath3;
	}

	public void setPicPath3(String picPath3) {
		this.picPath3 = picPath3;
	}

	public String getPicPath4() {
		return picPath4;
	}

	public void setPicPath4(String picPath4) {
		this.picPath4 = picPath4;
	}

}
