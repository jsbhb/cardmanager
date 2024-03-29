package com.card.manager.factory.user.model;

public class Rebate {

	private Integer id;
	private Integer gradeId;
	private String gradeName;
	private Double canBePresented;//可提现
	private Double alreadyCheck;//已对账
	private Double alreadyPresented;//已提现
	private Double stayToAccount;//待到账
	private Double refilling;//已反充
	private String remark;
	private String createTime;
	private String updateTime;
	private String opt;
	private Double orderConsume;//订单消费金额
	private Double frozenRebate;//订单冻结金额（没支付）

	public Double getAlreadyCheck() {
		return alreadyCheck;
	}
	public void setAlreadyCheck(Double alreadyCheck) {
		if (alreadyCheck != null && alreadyCheck > 0.01) {
			alreadyCheck = alreadyCheck - 0.01;
		} else {
			alreadyCheck = 0.00;
		}
		this.alreadyCheck = alreadyCheck;
	}
	public Integer getGradeId() {
		return gradeId;
	}
	public String getGradeName() {
		return gradeName;
	}
	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}
	public void setGradeId(Integer gradeId) {
		this.gradeId = gradeId;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Double getCanBePresented() {
		return canBePresented;
	}
	public void setCanBePresented(Double canBePresented) {
		this.canBePresented = canBePresented;
	}
	public Double getAlreadyPresented() {
		return alreadyPresented;
	}
	public void setAlreadyPresented(Double alreadyPresented) {
		this.alreadyPresented = alreadyPresented;
	}
	public Double getStayToAccount() {
		return stayToAccount;
	}
	public void setStayToAccount(Double stayToAccount) {
		this.stayToAccount = stayToAccount;
	}
	public Double getRefilling() {
		return refilling;
	}
	public void setRefilling(Double refilling) {
		this.refilling = refilling;
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
	public Double getOrderConsume() {
		return orderConsume;
	}
	public void setOrderConsume(Double orderConsume) {
		this.orderConsume = orderConsume;
	}
	public Double getFrozenRebate() {
		return frozenRebate;
	}
	public void setFrozenRebate(Double frozenRebate) {
		this.frozenRebate = frozenRebate;
	}
}
