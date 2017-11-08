/**  
 * Project Name:cardmanager  
 * File Name:SupplierEntity.java  
 * Package Name:com.card.manager.factory.supplier.model  
 * Date:Nov 7, 20172:29:59 PM  
 *  
 */
package com.card.manager.factory.supplier.model;

import net.sf.json.JSONObject;

/**
 * ClassName: SupplierEntity <br/>
 * Function: 供应商对象. <br/>
 * date: Nov 7, 2017 2:29:59 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class SupplierEntity {
	private int id;
	private String type;
	private String supplierName;
	private String country;// 国家
	private String province;// 省
	private String city;// 市
	private String area;// 区
	private String address;// 地址
	private String operator;
	private String phone;
	private String mobile;
	private String fax;
	private String email;
	private String qq;
	private String enterTime;
	private String updateTime;
	private String opt;
	private boolean isDelete;

	public SupplierEntity() {
	}

	/**
	 * Creates a new instance of SupplierEntity.
	 * 
	 * @param jObj
	 */
	public SupplierEntity(JSONObject jObj) {
		this.id = jObj.getInt("id");
		this.type = jObj.getString("type");
		this.supplierName = jObj.getString("supplierName");
		this.country = jObj.getString("country");
		this.province = jObj.getString("province");
		this.city = jObj.getString("city");
		this.area = jObj.getString("area");
		this.address = jObj.getString("address");
		this.operator = jObj.getString("operator");
		this.phone = jObj.getString("phone");
		this.mobile = jObj.getString("mobile");
		this.fax = jObj.getString("fax");
		this.email = jObj.getString("email");
		this.qq = jObj.getString("qq");
		this.enterTime = jObj.getString("enterTime");
		this.updateTime = jObj.getString("updateTime");
		this.opt = jObj.getString("opt");
		this.isDelete = jObj.getBoolean("delete");
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSupplierName() {
		return supplierName;
	}

	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
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

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getEnterTime() {
		return enterTime;
	}

	public void setEnterTime(String enterTime) {
		this.enterTime = enterTime;
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

	public boolean isDelete() {
		return isDelete;
	}

	public void setDelete(boolean isDelete) {
		this.isDelete = isDelete;
	}

}
