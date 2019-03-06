/**  
 * Project Name:cardmanager  
 * File Name:GoodsEntity.java  
 * Package Name:com.card.manager.factory.goods.model  
 * Date:Nov 12, 201710:28:15 PM  
 *  
 */
package com.card.manager.factory.goods.grademodel;

/**
 * 
 * ClassName: KJSpecsGoodsDTO <br/>  
 * Function: 商品库改造新商品规格实体. <br/>   
 * date: 2019年2月25日 上午10:46:42 <br/>  
 *  
 * @author why  
 * @version   
 * @since JDK 1.7
 */
public class KJSpecsGoodsDTO {
	private int id;
	private String encode;// 条形码
	private int weight;// 重量/克
	private String description;// 描述
	private String unit;// 单位
	private String info;// 规格
	private String carton;// 箱规
	private int conversion;// 换算比例
	private String specsGoodsName;// 每个规格的商品名称
	private int isDel;// 0未删除;1已删除
	private String createTime;// 创建时间
	private String updateTime;// 更新时间
	private String opt;// 操作人
	private String itemCode;// 商家编码
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getEncode() {
		return encode;
	}
	public void setEncode(String encode) {
		this.encode = encode;
	}
	public int getWeight() {
		return weight;
	}
	public void setWeight(int weight) {
		this.weight = weight;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getCarton() {
		return carton;
	}
	public void setCarton(String carton) {
		this.carton = carton;
	}
	public int getConversion() {
		return conversion;
	}
	public void setConversion(int conversion) {
		this.conversion = conversion;
	}
	public String getSpecsGoodsName() {
		return specsGoodsName;
	}
	public void setSpecsGoodsName(String specsGoodsName) {
		this.specsGoodsName = specsGoodsName;
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
	public String getItemCode() {
		return itemCode;
	}
	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}
}
