/**  
 * Project Name:cardmanager  
 * File Name:GoodsItem.java  
 * Package Name:com.card.manager.factory.goods.model  
 * Date:Nov 12, 201710:35:27 PM  
 *  
 */
package com.card.manager.factory.goods.model;

import com.card.manager.factory.base.Pagination;

/**
 * ClassName: GoodsItemEntity <br/>
 * Function: 商品明细实体. <br/>
 * date: Nov 12, 2017 10:35:27 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class GoodsItemEntity extends Pagination {
	private int id;//
	private String goodsId;// 商品ID
	private String itemId;// itemID
	private String itemCode;// 商家自有编码
	private String sku;// sku信息
	private String encode;// sku信息
	private double weight;// 商品重量（克）
	private double exciseTax;// 消费税
	private int isPromotion;// 是否促销0：否；1：是
	private String status;// 商品状态0：停售，1：在售
	private double discount;// 促销折扣
	private String info;// 规格信息
	private String createTime;// 创建时间
	private String updateTime;// 更新时间
	private String opt;// 操作人
	private String simpleInfo;
	private GoodsPrice goodsPrice;
	private String goodsName;
	private String supplierId;
	private String supplierName;
	private GoodsStockEntity stock;
	private int centerItemId;
	private int centerStatus;
	private GoodsEntity goodsEntity;
	private GoodsBaseEntity baseEntity;
	private GoodsTagBindEntity tagBindEntity;
	private String typeId;
	private String categoryId;
	private String tabId;
	private int conversion;
	private double rebate;
	private String shelfLife;
	private String carTon;

	public boolean check() {
		return goodsId != null && !"".equals(goodsId) && itemCode != null && !"".equals(itemCode) && sku != null
				&& !"".equals(sku) && encode != null && !"".equals(encode);
	}

	public double getRebate() {
		return rebate;
	}

	public void setRebate(double rebate) {
		this.rebate = rebate;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
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

	public String getSku() {
		return sku;
	}

	public void setSku(String sku) {
		this.sku = sku;
	}

	public double getWeight() {
		return weight;
	}

	public void setWeight(double weight) {
		this.weight = weight;
	}

	public double getExciseTax() {
		return exciseTax;
	}

	public void setExciseTax(double exciseTax) {
		this.exciseTax = exciseTax;
	}

	public int getIsPromotion() {
		return isPromotion;
	}

	public void setIsPromotion(int isPromotion) {
		this.isPromotion = isPromotion;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public double getDiscount() {
		return discount;
	}

	public void setDiscount(double discount) {
		this.discount = discount;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
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

	public String getSimpleInfo() {
		return simpleInfo;
	}

	public void setSimpleInfo(String simpleInfo) {
		this.simpleInfo = simpleInfo;
	}

	public GoodsPrice getGoodsPrice() {
		return goodsPrice;
	}

	public void setGoodsPrice(GoodsPrice goodsPrice) {
		this.goodsPrice = goodsPrice;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public String getSupplierId() {
		return supplierId;
	}

	public void setSupplierId(String supplierId) {
		this.supplierId = supplierId;
	}

	public String getSupplierName() {
		return supplierName;
	}

	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}

	public GoodsStockEntity getStock() {
		return stock;
	}

	public void setStock(GoodsStockEntity stock) {
		this.stock = stock;
	}

	public int getCenterItemId() {
		return centerItemId;
	}

	public void setCenterItemId(int centerItemId) {
		this.centerItemId = centerItemId;
	}

	public int getCenterStatus() {
		return centerStatus;
	}

	public void setCenterStatus(int centerStatus) {
		this.centerStatus = centerStatus;
	}

	public GoodsEntity getGoodsEntity() {
		return goodsEntity;
	}

	public void setGoodsEntity(GoodsEntity goodsEntity) {
		this.goodsEntity = goodsEntity;
	}

	public GoodsBaseEntity getBaseEntity() {
		return baseEntity;
	}

	public void setBaseEntity(GoodsBaseEntity baseEntity) {
		this.baseEntity = baseEntity;
	}

	public GoodsTagBindEntity getTagBindEntity() {
		return tagBindEntity;
	}

	public void setTagBindEntity(GoodsTagBindEntity tagBindEntity) {
		this.tagBindEntity = tagBindEntity;
	}

	public String getTypeId() {
		return typeId;
	}

	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}

	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	public String getTabId() {
		return tabId;
	}

	public void setTabId(String tabId) {
		this.tabId = tabId;
	}

	public int getConversion() {
		return conversion;
	}

	public void setConversion(int conversion) {
		this.conversion = conversion;
	}

	public String getEncode() {
		return encode;
	}

	public void setEncode(String encode) {
		this.encode = encode;
	}

	public String getShelfLife() {
		return shelfLife;
	}

	public void setShelfLife(String shelfLife) {
		this.shelfLife = shelfLife;
	}

	public String getCarTon() {
		return carTon;
	}

	public void setCarTon(String carTon) {
		this.carTon = carTon;
	}

}
