/**  
 * Project Name:cardmanager  
 * File Name:GoodsPojo.java  
 * Package Name:com.card.manager.factory.goods.pojo  
 * Date:Dec 20, 20174:36:34 PM  
 *  
 */
package com.card.manager.factory.goods.pojo;

import java.util.List;

import com.card.manager.factory.goods.model.GoodsItemEntity;

/**
 * ClassName: CreateGoodsInfoEntity <br/>
 * Function: 商品对象. <br/>
 * date: Dec 20, 2017 4:36:34 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class CreateGoodsInfoEntity {

	private int baseId;
	private String brandId;
	private String brand;
	private String firstCatalogId;
	private String secondCatalogId;
	private String thirdCatalogId;
	private double incrementTax;
	private double tariff;
	private String unit;
	private String hscode;
	private int goodsId;
	private int itemId;
	private String itemStatus;
	private int supplierId;
	private String supplierName;
	private int type;
	private String goodsName;
	private String itemCode;
	private String sku;
	private String encode;
	private double exciseTax;
	private String origin;
	private double weight;
	private int conversion;
	private double proxyPrice;
	private double fxPrice;
	private double retailPrice;
	private double linePrice;
	private int min;
	private int max;
	private String tagId;
	private String picPath;
	private String detailInfo;
	private String opt;
	private String goodsDetailPath;
	private String specsId;
	private String keys;
	private String values;
	private String shelfLife;
	private String carTon;
	private List<GoodsItemEntity> items;
	private String createKey;
	private int goodsTagRatio;
	
	
	public int getBaseId() {
		return baseId;
	}
	public void setBaseId(int baseId) {
		this.baseId = baseId;
	}
	public String getBrandId() {
		return brandId;
	}
	public void setBrandId(String brandId) {
		this.brandId = brandId;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getFirstCatalogId() {
		return firstCatalogId;
	}
	public void setFirstCatalogId(String firstCatalogId) {
		this.firstCatalogId = firstCatalogId;
	}
	public String getSecondCatalogId() {
		return secondCatalogId;
	}
	public void setSecondCatalogId(String secondCatalogId) {
		this.secondCatalogId = secondCatalogId;
	}
	public String getThirdCatalogId() {
		return thirdCatalogId;
	}
	public void setThirdCatalogId(String thirdCatalogId) {
		this.thirdCatalogId = thirdCatalogId;
	}
	public double getIncrementTax() {
		return incrementTax;
	}
	public void setIncrementTax(double incrementTax) {
		this.incrementTax = incrementTax;
	}
	public double getTariff() {
		return tariff;
	}
	public void setTariff(double tariff) {
		this.tariff = tariff;
	}
	public int getSupplierId() {
		return supplierId;
	}
	public void setSupplierId(int supplierId) {
		this.supplierId = supplierId;
	}
	public String getSupplierName() {
		return supplierName;
	}
	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
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
	public double getExciseTax() {
		return exciseTax;
	}
	public void setExciseTax(double exciseTax) {
		this.exciseTax = exciseTax;
	}
	public String getOrigin() {
		return origin;
	}
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	public double getWeight() {
		return weight;
	}
	public void setWeight(double weight) {
		this.weight = weight;
	}
	public double getProxyPrice() {
		return proxyPrice;
	}
	public void setProxyPrice(double proxyPrice) {
		this.proxyPrice = proxyPrice;
	}
	public double getFxPrice() {
		return fxPrice;
	}
	public void setFxPrice(double fxPrice) {
		this.fxPrice = fxPrice;
	}
	public double getRetailPrice() {
		return retailPrice;
	}
	public void setRetailPrice(double retailPrice) {
		this.retailPrice = retailPrice;
	}
	public int getMin() {
		return min;
	}
	public void setMin(int min) {
		this.min = min;
	}
	public int getMax() {
		return max;
	}
	public void setMax(int max) {
		this.max = max;
	}
	public String getTagId() {
		return tagId;
	}
	public void setTagId(String tagId) {
		this.tagId = tagId;
	}
	public String getPicPath() {
		return picPath;
	}
	public void setPicPath(String picPath) {
		this.picPath = picPath;
	}
	public String getDetailInfo() {
		return detailInfo;
	}
	public void setDetailInfo(String detailInfo) {
		this.detailInfo = detailInfo;
	}
	public String getOpt() {
		return opt;
	}
	public void setOpt(String opt) {
		this.opt = opt;
	}
	public int getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(int goodsId) {
		this.goodsId = goodsId;
	}
	public int getItemId() {
		return itemId;
	}
	public void setItemId(int itemId) {
		this.itemId = itemId;
	}
	public String getItemStatus() {
		return itemStatus;
	}
	public void setItemStatus(String itemStatus) {
		this.itemStatus = itemStatus;
	}
	public String getGoodsDetailPath() {
		return goodsDetailPath;
	}
	public void setGoodsDetailPath(String goodsDetailPath) {
		this.goodsDetailPath = goodsDetailPath;
	}
	public int getConversion() {
		return conversion;
	}
	public void setConversion(int conversion) {
		this.conversion = conversion;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getHscode() {
		return hscode;
	}
	public void setHscode(String hscode) {
		this.hscode = hscode;
	}
	public String getEncode() {
		return encode;
	}
	public void setEncode(String encode) {
		this.encode = encode;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getKeys() {
		return keys;
	}
	public void setKeys(String keys) {
		this.keys = keys;
	}
	public String getValues() {
		return values;
	}
	public void setValues(String values) {
		this.values = values;
	}
	public String getSpecsId() {
		return specsId;
	}
	public void setSpecsId(String specsId) {
		this.specsId = specsId;
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
	public List<GoodsItemEntity> getItems() {
		return items;
	}
	public void setItems(List<GoodsItemEntity> items) {
		this.items = items;
	}
	public String getCreateKey() {
		return createKey;
	}
	public void setCreateKey(String createKey) {
		this.createKey = createKey;
	}
	public double getLinePrice() {
		return linePrice;
	}
	public void setLinePrice(double linePrice) {
		this.linePrice = linePrice;
	}
	public int getGoodsTagRatio() {
		return goodsTagRatio;
	}
	public void setGoodsTagRatio(int goodsTagRatio) {
		this.goodsTagRatio = goodsTagRatio;
	}

}
