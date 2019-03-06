/**  
 * Project Name:cardmanager  
 * File Name:GoodsEntity.java  
 * Package Name:com.card.manager.factory.goods.model  
 * Date:Nov 12, 201710:28:15 PM  
 *  
 */
package com.card.manager.factory.goods.grademodel;

import java.util.List;

import com.card.manager.factory.base.Pagination;

/**
 * 
 * ClassName: KJGoodsDTO <br/>  
 * Function: 商品库改造商品检索条件DTO. <br/>   
 * date: 2019年2月25日 下午1:39:12 <br/>  
 *  
 * @author why  
 * @version   
 * @since JDK 1.7
 */
public class KJGoodsDTO extends Pagination {
	private String goodsId;// 商品ID
	private int type;// 商品分类0：大贸；1：跨境;2：一般贸易
	private String goodsName;// 商品名称
	private String subtitle;// 商品副标题
	private String description;// 描述
	private String brand;// 品牌名
	private String brandId;// 品牌
	private String origin;// 产地
	private String detailPath;// 商详路径
	private String accessPath;// 静态路径
	private String firstCatalogId;// 一级分类
	private String secondCatalogId;// 一级分类
	private String thirdCatalogId;// 一级分类
	private String hscode;// 海关hscode
	private String picPath;// 商品主图
	private String specsId;// 商品规格ID
	private String specsTpId;// 唯一规格商品ID
	private String encode;// 条形码
	private String encodeExist;// 条形码查询存在
	private int weight;// 重量/克
	private String carton;// 箱规
	private String info;// 规格
	private int conversion;// 换算比例
	private String specsDescription;// 每个规格的商品描述
	private String specsGoodsName;// 每个规格的商品名称
	private String itemId;// itemID
	private Integer supplierId;// 商家ID
	private String supplierName;// 商家名称
	private String reason;// 审核失败原因
	private String remark;// 备注
	private int isDel;// 0未删除;1已删除
	private String createTime;// 创建时间
	private String updateTime;// 更新时间
	private String opt;// 操作人
	private String sku;// 海关备案号
	private String unit;// 海关备案单位
	private String hsunit;// 海关备案单位
	private String itemCode;// 商家编码
	private String shelfLife;// 效期
	private Double costPrice;// 成本价
	private Double internalPrice;// 供货价
	private int stockQty;// 库存
	private List<KJSpecsGoodsDTO> specsList;// 多规格商品新增
	private List<KJGoodsSpecsTradePatternDTO> goodsSpecsTpList;
	private List<KJGoodsItemDTO> itemList;// 多规格商品关联供应商
	public String getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getSubtitle() {
		return subtitle;
	}
	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getBrandId() {
		return brandId;
	}
	public void setBrandId(String brandId) {
		this.brandId = brandId;
	}
	public String getOrigin() {
		return origin;
	}
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	public String getDetailPath() {
		return detailPath;
	}
	public void setDetailPath(String detailPath) {
		this.detailPath = detailPath;
	}
	public String getAccessPath() {
		return accessPath;
	}
	public void setAccessPath(String accessPath) {
		this.accessPath = accessPath;
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
	public String getHscode() {
		return hscode;
	}
	public void setHscode(String hscode) {
		this.hscode = hscode;
	}
	public String getPicPath() {
		return picPath;
	}
	public void setPicPath(String picPath) {
		this.picPath = picPath;
	}
	public String getSpecsId() {
		return specsId;
	}
	public void setSpecsId(String specsId) {
		this.specsId = specsId;
	}
	public String getSpecsTpId() {
		return specsTpId;
	}
	public void setSpecsTpId(String specsTpId) {
		this.specsTpId = specsTpId;
	}
	public String getEncode() {
		return encode;
	}
	public void setEncode(String encode) {
		this.encode = encode;
	}
	public String getEncodeExist() {
		return encodeExist;
	}
	public void setEncodeExist(String encodeExist) {
		this.encodeExist = encodeExist;
	}
	public int getWeight() {
		return weight;
	}
	public void setWeight(int weight) {
		this.weight = weight;
	}
	public String getCarton() {
		return carton;
	}
	public void setCarton(String carton) {
		this.carton = carton;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public int getConversion() {
		return conversion;
	}
	public void setConversion(int conversion) {
		this.conversion = conversion;
	}
	public String getSpecsDescription() {
		return specsDescription;
	}
	public void setSpecsDescription(String specsDescription) {
		this.specsDescription = specsDescription;
	}
	public String getSpecsGoodsName() {
		return specsGoodsName;
	}
	public void setSpecsGoodsName(String specsGoodsName) {
		this.specsGoodsName = specsGoodsName;
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
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public int getIsDel() {
		return isDel;
	}
	public void setIsDel(int isDel) {
		this.isDel = isDel;
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
	public String getHsunit() {
		return hsunit;
	}
	public void setHsunit(String hsunit) {
		this.hsunit = hsunit;
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
	public List<KJSpecsGoodsDTO> getSpecsList() {
		return specsList;
	}
	public void setSpecsList(List<KJSpecsGoodsDTO> specsList) {
		this.specsList = specsList;
	}
	public List<KJGoodsSpecsTradePatternDTO> getGoodsSpecsTpList() {
		return goodsSpecsTpList;
	}
	public void setGoodsSpecsTpList(List<KJGoodsSpecsTradePatternDTO> goodsSpecsTpList) {
		this.goodsSpecsTpList = goodsSpecsTpList;
	}
	public List<KJGoodsItemDTO> getItemList() {
		return itemList;
	}
	public void setItemList(List<KJGoodsItemDTO> itemList) {
		this.itemList = itemList;
	}
}
