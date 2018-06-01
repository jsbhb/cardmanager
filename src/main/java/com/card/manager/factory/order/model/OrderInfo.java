package com.card.manager.factory.order.model;

import java.util.List;

import com.card.manager.factory.base.Pagination;
import com.card.manager.factory.order.pojo.OrderImportBO;
import com.card.manager.factory.util.Utils;

public class OrderInfo extends Pagination{

	private Integer id;

	private String orderId;

	// 订单拆分时提供一个总ID
	private String combinationId;

	private Integer userId;

	private Integer status;// 0：初始；1：已付款;2：支付单报关;3：已发仓库；4：已报海关；5：单证放行；6：已发货；7：已收货；8：退单;9、超时取消;99异常状态

	// 物流、自提
	private Integer expressType;// 0：快递；1：自提

	// 区域中心ID
	private Integer centerId;
	
	private String centerName;

	private Integer shopId;
	
	private String shopName;

	private Integer guideId;

	private Integer supplierId;

	private String supplierName;

	private Integer tdq;

	private Integer weight;

	private String gtime;

	private String sendTime;

	private String createTime;

	private String updateTime;

	private String remark;

	private Integer orderFlag;// 0:跨境；1：大贸;2：一般贸易

	private String statusArr;

	private OrderDetail orderDetail;

	private List<OrderGoods> orderGoodsList;

	private List<ThirdOrderInfo> orderExpressList;

	private String startTime;

	private String endTime;

	private String couponIds;
	
	private Integer pushUserId;

	private Integer createType;// 0:普通订单；1：活动订单；2：优惠券订单；3：活动+优惠券

	private String customerName;

	private String pushUserName;
	
	private String itemId;
	
	private String itemCode;
	
	private Integer tagFun;
	
	private Integer orderSource;
	
	private Integer manual;//是否手工单，0：自动；1手动
	
	private String phone;
	
	public OrderInfo(){}

	public OrderInfo(OrderImportBO model) {
		orderId = Utils.removePoint(model.getOrderId());
		status = 3;
		expressType = 0;
		centerId = 2;
		centerName = "中国供销海外购";
		shopId = model.getShopId();
		shopName = model.getShopName();
		supplierId = model.getSupplierId();
		supplierName = model.getSupplierName();
		weight = 100;
		orderFlag = model.getOrderFlag();
		createType = 0;
		tagFun = 0;
		orderSource = model.getOrderSource();
		manual = 1;
		if(!"".equals(model.getPhone()) && !"".equals(model.getName()) && !"".equals(model.getIdNum())){
			phone = Utils.removePoint(model.getPhone());
		}else {
			phone = Utils.removePoint(model.getReceivePhone());
		}
		remark = model.getRemark();
	}

	public boolean check() {
		if (orderDetail == null || orderGoodsList == null || orderFlag == null || createType == null || userId == null
				|| tdq == null || expressType == null || centerId == null || supplierId == null) {
			return false;
		}
		return true;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Integer getManual() {
		return manual;
	}

	public void setManual(Integer manual) {
		this.manual = manual;
	}
	
	public Integer getPushUserId() {
		return pushUserId;
	}

	public void setPushUserId(Integer pushUserId) {
		this.pushUserId = pushUserId;
	}

	public Integer getCreateType() {
		return createType;
	}

	public void setCreateType(Integer createType) {
		this.createType = createType;
	}

	public String getCouponIds() {
		return couponIds;
	}

	public void setCouponIds(String couponIds) {
		this.couponIds = couponIds;
	}

	public Integer getWeight() {
		return weight;
	}

	public void setWeight(Integer weight) {
		this.weight = weight;
	}

	public Integer getGuideId() {
		return guideId;
	}

	public void setGuideId(Integer guideId) {
		this.guideId = guideId;
	}

	public String getStatusArr() {
		return statusArr;
	}

	public void setStatusArr(String statusArr) {
		this.statusArr = statusArr;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public Integer getOrderFlag() {
		return orderFlag;
	}

	public void setOrderFlag(Integer orderFlag) {
		this.orderFlag = orderFlag;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getCombinationId() {
		return combinationId;
	}

	public void setCombinationId(String combinationId) {
		this.combinationId = combinationId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getExpressType() {
		return expressType;
	}

	public void setExpressType(Integer expressType) {
		this.expressType = expressType;
	}

	public Integer getCenterId() {
		return centerId;
	}

	public void setCenterId(Integer centerId) {
		this.centerId = centerId;
	}

	public Integer getShopId() {
		return shopId;
	}

	public void setShopId(Integer shopId) {
		this.shopId = shopId;
	}

	public Integer getSupplierId() {
		return supplierId;
	}

	public void setSupplierId(Integer supplierId) {
		this.supplierId = supplierId;
	}

	public Integer getTdq() {
		return tdq;
	}

	public void setTdq(Integer tdq) {
		this.tdq = tdq;
	}

	public String getGtime() {
		return gtime;
	}

	public void setGtime(String gtime) {
		this.gtime = gtime;
	}

	public String getSendTime() {
		return sendTime;
	}

	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
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

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public OrderDetail getOrderDetail() {
		return orderDetail;
	}

	public void setOrderDetail(OrderDetail orderDetail) {
		this.orderDetail = orderDetail;
	}

	public List<OrderGoods> getOrderGoodsList() {
		return orderGoodsList;
	}

	public void setOrderGoodsList(List<OrderGoods> orderGoodsList) {
		this.orderGoodsList = orderGoodsList;
	}

	public List<ThirdOrderInfo> getOrderExpressList() {
		return orderExpressList;
	}

	public void setOrderExpressList(List<ThirdOrderInfo> orderExpressList) {
		this.orderExpressList = orderExpressList;
	}

	public String getSupplierName() {
		return supplierName;
	}

	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}

	public String getCenterName() {
		return centerName;
	}

	public void setCenterName(String centerName) {
		this.centerName = centerName;
	}

	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getPushUserName() {
		return pushUserName;
	}

	public void setPushUserName(String pushUserName) {
		this.pushUserName = pushUserName;
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

	public Integer getTagFun() {
		return tagFun;
	}

	public void setTagFun(Integer tagFun) {
		this.tagFun = tagFun;
	}

	public Integer getOrderSource() {
		return orderSource;
	}

	public void setOrderSource(Integer orderSource) {
		this.orderSource = orderSource;
	}

	@Override
	public String toString() {
		return "OrderInfo [id=" + id + ", orderId=" + orderId + ", combinationId=" + combinationId + ", userId="
				+ userId + ", status=" + status + ", expressType=" + expressType + ", centerId=" + centerId
				+ ", shopId=" + shopId + ", guideId=" + guideId + ", supplierId=" + supplierId + ", tdq=" + tdq
				+ ", gtime=" + gtime + ", sendTime=" + sendTime + ", createTime=" + createTime + ", updateTime="
				+ updateTime + ", remark=" + remark + ", orderFlag=" + orderFlag + ", statusArr=" + statusArr
				+ ", orderDetail=" + orderDetail + ", orderGoodsList=" + orderGoodsList + ", orderExpressList="
				+ orderExpressList + ", startTime=" + startTime + ", endTime=" + endTime + "]";
	}

}