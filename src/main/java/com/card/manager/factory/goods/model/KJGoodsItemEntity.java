/**  
 * Project Name:cardmanager  
 * File Name:GoodsItem.java  
 * Package Name:com.card.manager.factory.goods.model  
 * Date:Nov 12, 201710:35:27 PM  
 *  
 */
package com.card.manager.factory.goods.model;

/**
 * 
 * ClassName: KJGoodsItemEntity <br/>  
 * Function: 唯一规格商品增加供应商等其他信息后的产品实体. <br/>   
 * date: 2019年2月25日 上午11:16:50 <br/>  
 *  
 * @author why  
 * @version   
 * @since JDK 1.7
 */
public class KJGoodsItemEntity {
	private int id;//
	private String specsTpId;// 唯一规格商品ID
	private String itemId;// itemID
	private Integer supplierId;// 商家ID
	private String supplierName;// 商家名称
	private int status;// 产品状态0:仓库中,1：待审核，2：审核通过，11：审核失败
	private String reason;// 审核失败原因
	private String unit;// 海关备案单位
	private String sku;// 海关备案号
	private String itemCode;// 商家编码
	private String shelfLife;// 效期
	private String remark;// 备注
	private int isDel;// 0未删除;1已删除
	private String createTime;// 创建时间
	private String updateTime;// 更新时间
	private String opt;// 操作人
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
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
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
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
	public String getShelfLife() {
		return shelfLife;
	}
	public void setShelfLife(String shelfLife) {
		this.shelfLife = shelfLife;
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
}
