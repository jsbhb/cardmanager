/**  
 * Project Name:cardmanager  
 * File Name:GoodsEntity.java  
 * Package Name:com.card.manager.factory.goods.model  
 * Date:Nov 12, 201710:28:15 PM  
 *  
 */
package com.card.manager.factory.goods.model;

/**
 * 
 * ClassName: KJGoodsSpecsTradepatternEntity <br/>  
 * Function: 商品库改造唯一规格商品实体. <br/>   
 * date: 2019年2月25日 上午10:55:07 <br/>  
 *  
 * @author why  
 * @version   
 * @since JDK 1.7
 */
public class KJGoodsSpecsTradepatternEntity {
	private int id;
	private String specsTpId;// 唯一规格商品ID
	private String goodsId;// 商品ID
	private String specsId;// 商品规格ID
	private int status;// 商品运营状态0:初始,1：下架，2：上架，3：售罄
	private int isFreePost;// 是否包邮;0:否,1:是
	private int isFreeTax;// 是否包税,0:否,1是
	private int tagRatio;// 权重
	private Double incrementTax;// 增值税
	private Double tariff;// 关税
	private Double exciseTax;// 消费税
	private int isPromotion;// 是否促销0:否;1是
	private Double discount;// 促销折扣
	private int isDistribution;// 是否分销0:否;1:是
	private int isWelfare;// 是否在福利商城显示0:否;1:是
	private int isCombinedgoods;// 是否组合商品0:否;1:是
	private String combinedSpecsTpId;// 组合商品包含的specs_tp_id
	private int display;// 显示(针对上架商品):0:不显示;1:前端显示;2:后台显示;3:前后台都显示
	private Double distributionPrice;// 分销价格
	private Double vipPrice;// 会员价格
	private Double retailPrice;// 零售价格
	private Double linePrice;// 划线价
	private int departmentProfit;// 部门利润
	private int instantRatio;// 顺加比例
	private int saleNum;// 销量
	private String itemId;// 跨境商品上架需绑定对应ItemId
	private int isFresh;// 是否新品:0是，1：否
	private String remark;// 备注
	private int isDel;// 0未删除;1已删除
	private String upshelfTime;// 创建时间
	private String downshelfTime;// 更新时间
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
	public String getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
	}
	public String getSpecsId() {
		return specsId;
	}
	public void setSpecsId(String specsId) {
		this.specsId = specsId;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getIsFreePost() {
		return isFreePost;
	}
	public void setIsFreePost(int isFreePost) {
		this.isFreePost = isFreePost;
	}
	public int getIsFreeTax() {
		return isFreeTax;
	}
	public void setIsFreeTax(int isFreeTax) {
		this.isFreeTax = isFreeTax;
	}
	public int getTagRatio() {
		return tagRatio;
	}
	public void setTagRatio(int tagRatio) {
		this.tagRatio = tagRatio;
	}
	public Double getIncrementTax() {
		return incrementTax;
	}
	public void setIncrementTax(Double incrementTax) {
		this.incrementTax = incrementTax;
	}
	public Double getTariff() {
		return tariff;
	}
	public void setTariff(Double tariff) {
		this.tariff = tariff;
	}
	public Double getExciseTax() {
		return exciseTax;
	}
	public void setExciseTax(Double exciseTax) {
		this.exciseTax = exciseTax;
	}
	public int getIsPromotion() {
		return isPromotion;
	}
	public void setIsPromotion(int isPromotion) {
		this.isPromotion = isPromotion;
	}
	public Double getDiscount() {
		return discount;
	}
	public void setDiscount(Double discount) {
		this.discount = discount;
	}
	public int getIsDistribution() {
		return isDistribution;
	}
	public void setIsDistribution(int isDistribution) {
		this.isDistribution = isDistribution;
	}
	public int getIsWelfare() {
		return isWelfare;
	}
	public void setIsWelfare(int isWelfare) {
		this.isWelfare = isWelfare;
	}
	public int getIsCombinedgoods() {
		return isCombinedgoods;
	}
	public void setIsCombinedgoods(int isCombinedgoods) {
		this.isCombinedgoods = isCombinedgoods;
	}
	public String getCombinedSpecsTpId() {
		return combinedSpecsTpId;
	}
	public void setCombinedSpecsTpId(String combinedSpecsTpId) {
		this.combinedSpecsTpId = combinedSpecsTpId;
	}
	public int getDisplay() {
		return display;
	}
	public void setDisplay(int display) {
		this.display = display;
	}
	public Double getDistributionPrice() {
		return distributionPrice;
	}
	public void setDistributionPrice(Double distributionPrice) {
		this.distributionPrice = distributionPrice;
	}
	public Double getVipPrice() {
		return vipPrice;
	}
	public void setVipPrice(Double vipPrice) {
		this.vipPrice = vipPrice;
	}
	public Double getRetailPrice() {
		return retailPrice;
	}
	public void setRetailPrice(Double retailPrice) {
		this.retailPrice = retailPrice;
	}
	public Double getLinePrice() {
		return linePrice;
	}
	public void setLinePrice(Double linePrice) {
		this.linePrice = linePrice;
	}
	public int getDepartmentProfit() {
		return departmentProfit;
	}
	public void setDepartmentProfit(int departmentProfit) {
		this.departmentProfit = departmentProfit;
	}
	public int getInstantRatio() {
		return instantRatio;
	}
	public void setInstantRatio(int instantRatio) {
		this.instantRatio = instantRatio;
	}
	public int getSaleNum() {
		return saleNum;
	}
	public void setSaleNum(int saleNum) {
		this.saleNum = saleNum;
	}
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public int getIsFresh() {
		return isFresh;
	}
	public void setIsFresh(int isFresh) {
		this.isFresh = isFresh;
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
	public String getUpshelfTime() {
		return upshelfTime;
	}
	public void setUpshelfTime(String upshelfTime) {
		this.upshelfTime = upshelfTime;
	}
	public String getDownshelfTime() {
		return downshelfTime;
	}
	public void setDownshelfTime(String downshelfTime) {
		this.downshelfTime = downshelfTime;
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
