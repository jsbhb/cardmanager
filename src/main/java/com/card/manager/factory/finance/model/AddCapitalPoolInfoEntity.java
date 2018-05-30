package com.card.manager.factory.finance.model;

import java.util.List;

public class AddCapitalPoolInfoEntity {

	private Integer id;
	private Integer customerId;//客户ID
	private String customerName;//客户名称
	private Integer customerType;//客户类型0:供应商,1:区域中心
	private Integer payType;//支付类型0:充值,1:消费
	private Double money;//金额
	private String payNo;//支付流水号
	private String businessNo;//业务流水号
	private String remark;
	private String opt;
	private List<CapitalManagementBusinessItem> itemList;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getCustomerId() {
		return customerId;
	}
	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public Integer getCustomerType() {
		return customerType;
	}
	public void setCustomerType(Integer customerType) {
		this.customerType = customerType;
	}
	public Integer getPayType() {
		return payType;
	}
	public void setPayType(Integer payType) {
		this.payType = payType;
	}
	public Double getMoney() {
		return money;
	}
	public void setMoney(Double money) {
		this.money = money;
	}
	public String getPayNo() {
		return payNo;
	}
	public void setPayNo(String payNo) {
		this.payNo = payNo;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getOpt() {
		return opt;
	}
	public void setOpt(String opt) {
		this.opt = opt;
	}
	public List<CapitalManagementBusinessItem> getItemList() {
		return itemList;
	}
	public void setItemList(List<CapitalManagementBusinessItem> itemList) {
		this.itemList = itemList;
	}
	public String getBusinessNo() {
		return businessNo;
	}
	public void setBusinessNo(String businessNo) {
		this.businessNo = businessNo;
	}
	
}
