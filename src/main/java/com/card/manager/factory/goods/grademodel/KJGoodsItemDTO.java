package com.card.manager.factory.goods.grademodel;

public class KJGoodsItemDTO {

	private String specsTpId;// 唯一规格商品ID
	private String itemId;// itemID
	private Integer supplierId;// 商家ID
	private String supplierName;// 商家名称
	private String sku;// 海关备案号
	private String unit;// 海关备案单位
	private String itemCode;// 商家编码
	private String shelfLife;// 效期
	private Double costPrice;// 成本价
	private Double internalPrice;// 供货价
	private int stockQty;// 库存
	private String createTime;// 创建时间
	private String updateTime;// 更新时间
	private String opt;// 操作人
	
	public String getSpecsTpId() {
		return specsTpId;
	}
	public void setSpecsTpId(String specsTpId) {
		this.specsTpId = specsTpId;
	}
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public Integer getSupplierId() {
		return supplierId;
	}
	public void setSupplierId(Integer supplierId) {
		this.supplierId = supplierId;
	}
	public String getSupplierName() {
		return supplierName;
	}
	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}
	public String getSku() {
		return sku;
	}
	public void setSku(String sku) {
		this.sku = sku;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getItemCode() {
		return itemCode;
	}
	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}
	public String getShelfLife() {
		return shelfLife;
	}
	public void setShelfLife(String shelfLife) {
		this.shelfLife = shelfLife;
	}
	public Double getCostPrice() {
		return costPrice;
	}
	public void setCostPrice(Double costPrice) {
		this.costPrice = costPrice;
	}
	public Double getInternalPrice() {
		return internalPrice;
	}
	public void setInternalPrice(Double internalPrice) {
		this.internalPrice = internalPrice;
	}
	public int getStockQty() {
		return stockQty;
	}
	public void setStockQty(int stockQty) {
		this.stockQty = stockQty;
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
}
