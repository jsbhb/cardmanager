package com.card.manager.factory.finance.model;

import java.util.List;

import com.card.manager.factory.base.Pagination;

public class CapitalManagementDetail extends Pagination {

	private Integer id;
	private Integer customerId;//客户ID
	private Integer payType;//支付类型0:收入,1:支出
	private Double money;//金额
	private String payNo;//支付流水号
	private String businessNo;//业务流水号
	private String remark;
	private String createTime;
	private String opt;
	private List<CapitalManagementBusinessItem> managementBusinessItemList;
	
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
	public String getBusinessNo() {
		return businessNo;
	}
	public void setBusinessNo(String businessNo) {
		this.businessNo = businessNo;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getOpt() {
		return opt;
	}
	public void setOpt(String opt) {
		this.opt = opt;
	}
	public List<CapitalManagementBusinessItem> getManagementBusinessItemList() {
		return managementBusinessItemList;
	}
	public void setManagementBusinessItemList(List<CapitalManagementBusinessItem> managementBusinessItemList) {
		this.managementBusinessItemList = managementBusinessItemList;
	}
	
}
