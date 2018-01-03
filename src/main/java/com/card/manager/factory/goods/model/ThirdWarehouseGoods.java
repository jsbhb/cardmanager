package com.card.manager.factory.goods.model;

public class ThirdWarehouseGoods {

	private String id;
	private Integer supplierId;
	private String supplierName;
	private String sku;
	private String itemCode;
	private String goodsName;
	private String brand;
	private Integer weight;
	private String origin;
	private String quantity;
	private Integer stock;
	private String roughWeight;
	private String min;
	private String max;
	private Integer status;
	private String createTime;// 创建时间
	private String updateTime;// 更新时间
	private String opt;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public Integer getWeight() {
		return weight;
	}

	public void setWeight(Integer weight) {
		this.weight = weight;
	}

	public Integer getStock() {
		return stock;
	}

	public void setStock(Integer stock) {
		this.stock = stock;
	}

	public String getRoughWeight() {
		return roughWeight;
	}

	public void setRoughWeight(String roughWeight) {
		this.roughWeight = roughWeight;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	public String getMin() {
		return min;
	}

	public void setMin(String min) {
		this.min = min;
	}

	public String getMax() {
		return max;
	}

	public void setMax(String max) {
		this.max = max;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
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

	@Override
	public String toString() {
		return "ThirdWarehouseGoods [id=" + id + ", supplierId=" + supplierId + ", supplierName="
				+ supplierName + ", sku=" + sku + ", itemCode=" + itemCode + ", goodsName=" + goodsName + ", brand="
				+ brand + ", weight=" + weight + ", origin=" + origin + ", quantity=" + quantity + ", stock=" + stock
				+ ", roughWeight=" + roughWeight + ", min=" + min + ", max=" + max + ", status=" + status + "]";
	}

}
