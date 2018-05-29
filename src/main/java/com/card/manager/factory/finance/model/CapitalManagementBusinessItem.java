package com.card.manager.factory.finance.model;

public class CapitalManagementBusinessItem {

	private Integer id;
	private String businessNo;//业务流水号
	private String orderId;//订单号
	private String itemId;//商品编号
	private String itemCode;//商家编码
	private Integer itemQuantity;//商品数量
	private Double itemPrice;//商品价格
	private String itemEncode;//商品条形码
	private String createTime;
	private String opt;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getBusinessNo() {
		return businessNo;
	}
	public void setBusinessNo(String businessNo) {
		this.businessNo = businessNo;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public String getItemCode() {
		return itemCode;
	}
	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}
	public Integer getItemQuantity() {
		return itemQuantity;
	}
	public void setItemQuantity(Integer itemQuantity) {
		this.itemQuantity = itemQuantity;
	}
	public Double getItemPrice() {
		return itemPrice;
	}
	public void setItemPrice(Double itemPrice) {
		this.itemPrice = itemPrice;
	}
	public String getItemEncode() {
		return itemEncode;
	}
	public void setItemEncode(String itemEncode) {
		this.itemEncode = itemEncode;
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
	public boolean check() {
		if ( "".equals(orderId) && "".equals(itemId) && "".equals(itemCode) 
				&& itemQuantity == null && itemPrice == null && "".equals(itemEncode)) {
			return false;
		}
		return true;
	}
}
