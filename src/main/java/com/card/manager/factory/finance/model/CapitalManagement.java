package com.card.manager.factory.finance.model;

import java.util.List;

import com.card.manager.factory.base.Pagination;

/**
 * @fun 资金池实体类(PO持久层)
 * @author user
 *
 */
public class CapitalManagement extends Pagination{

	private Integer id;
	private Integer customerId;//客户ID
	private String customerName;//客户名称
	private Integer customerType;//客户类型0:供应商,1:区域中心
	private Double money;//可用金额
	private Double useMoney;//使用金额
	private Double countMoney;//累计金额
	private Integer status;//状态0停用，1启用
	private String remark;
	private String createTime;
	private String updateTime;
	private String opt;
	private List<CapitalManagementDetail> managementDetailList;
	
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
	public Double getMoney() {
		return money;
	}
	public void setMoney(Double money) {
		this.money = money;
	}
	public Double getUseMoney() {
		return useMoney;
	}
	public void setUseMoney(Double useMoney) {
		this.useMoney = useMoney;
	}
	public Double getCountMoney() {
		return countMoney;
	}
	public void setCountMoney(Double countMoney) {
		this.countMoney = countMoney;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
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
	public List<CapitalManagementDetail> getManagementDetailList() {
		return managementDetailList;
	}
	public void setManagementDetailList(List<CapitalManagementDetail> managementDetailList) {
		this.managementDetailList = managementDetailList;
	}
	
}
