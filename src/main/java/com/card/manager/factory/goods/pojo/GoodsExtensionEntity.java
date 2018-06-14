/**  
 * Project Name:cardmanager  
 * File Name:GoodsEntity.java  
 * Package Name:com.card.manager.factory.goods.model  
 * Date:Nov 12, 201710:28:15 PM  
 *  
 */
package com.card.manager.factory.goods.pojo;

import com.card.manager.factory.base.Pagination;

/**
 * ClassName: GoodsEntity <br/>
 * Function: 商品实体 <br/>
 * date: Nov 12, 2017 10:28:15 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class GoodsExtensionEntity extends Pagination {
	private int id;
	private String goodsId;// 商品ID
	private String goodsName;// 商品名称
	private String goodsPath;// 商品图片路径
	private String brand;// 商品品牌
	private String specs;// 商品规格
	private String origin;// 原产国
	private String useAge;// 适用年龄
	private String reason;// 推荐理由
	private String remark;// 备注
	private String createTime;// 创建时间
	private String updateTime;// 更新时间
	private String opt;// 操作人
	
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
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getGoodsPath() {
		return goodsPath;
	}
	public void setGoodsPath(String goodsPath) {
		this.goodsPath = goodsPath;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getSpecs() {
		return specs;
	}
	public void setSpecs(String specs) {
		this.specs = specs;
	}
	public String getOrigin() {
		return origin;
	}
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	public String getUseAge() {
		return useAge;
	}
	public void setUseAge(String useAge) {
		this.useAge = useAge;
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
