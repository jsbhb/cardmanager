package com.card.manager.factory.order.pojo;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.card.manager.factory.util.ParemeterConverUtil;
import com.card.manager.factory.util.RegularUtil;

public class OrderImportBO {

	private String orderId;
	private Integer shopId;
	private String shopName;
	private String sku;
	private String itemId;
	private String itemPrice;
	private String itemQuantity;
	private String orderSourceName;
	private Integer orderSource;
	private Integer payType;
	private String payTypeName;
	private String payNo;
	private String receiveName;
	private String receivePhone;
	private String province;
	private String city;
	private String area;
	private String address;
	private String taxFee;
	private String postFee;
	private String phone;
	private String name;
	private String idNum;
	private String remark;
	private String conversion;

	public boolean init(Map<String, Integer> gradeMapTemp, Map<String, Integer> supplierMap) {

		shopId = gradeMapTemp.get(shopName);
		orderSource = ParemeterConverUtil.getOrderSource(orderSourceName);
		payType = ParemeterConverUtil.getPayType(payTypeName);
		taxFee = taxFee == null || "".equals(taxFee) ? "0" : taxFee;
		postFee = postFee == null || "".equals(postFee) ? "0" : postFee;
		phone = phone == null ? "" : phone;
		name = name == null ? "" : name;
		idNum = idNum == null ? "" : idNum;
		payNo = "".equals(payNo) ? null : payNo;
		if(itemId != null && !"".equals(itemId)){//有itemId则以itemId为准，sku和conversion置空字符串
			sku = "";
			conversion = "";
		} else {//itemId没有则必须要有sku和conversion
			itemId = "";
			if("".equals(sku) || "".equals(conversion)){
				sku = null;
				conversion = null;
			}
		}
		if(!RegularUtil.isPhone(receivePhone)){
			return false;
		}
		if(!"".equals(phone)){
			if(!RegularUtil.isPhone(phone)){
				return false;
			}
		}
		if(!"".equals(idNum)){
			if(!RegularUtil.isIdentify(idNum)){
				return false;
			}
		}
		return true;
	}
	
	public List<String> getUnCheckFieldName(){
		List<String> fields = new ArrayList<String>();
		fields.add("payNo");// payNo可以为null
		fields.add("remark");
		fields.add("itemPrice");
		return fields;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIdNum() {
		return idNum;
	}

	public void setIdNum(String idNum) {
		this.idNum = idNum;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public String getSku() {
		return sku;
	}

	public void setSku(String sku) {
		this.sku = sku;
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getItemPrice() {
		return itemPrice;
	}

	public void setItemPrice(String itemPrice) {
		this.itemPrice = itemPrice;
	}

	public String getItemQuantity() {
		return itemQuantity;
	}

	public void setItemQuantity(String itemQuantity) {
		this.itemQuantity = itemQuantity;
	}

	public String getOrderSourceName() {
		return orderSourceName;
	}

	public void setOrderSourceName(String orderSourceName) {
		this.orderSourceName = orderSourceName;
	}

	public String getPayTypeName() {
		return payTypeName;
	}

	public void setPayTypeName(String payTypeName) {
		this.payTypeName = payTypeName;
	}

	public String getPayNo() {
		return payNo;
	}

	public void setPayNo(String payNo) {
		this.payNo = payNo;
	}

	public String getReceiveName() {
		return receiveName;
	}

	public void setReceiveName(String receiveName) {
		this.receiveName = receiveName;
	}

	public String getReceivePhone() {
		return receivePhone;
	}

	public void setReceivePhone(String receivePhone) {
		this.receivePhone = receivePhone;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTaxFee() {
		return taxFee;
	}

	public void setTaxFee(String taxFee) {
		this.taxFee = taxFee;
	}

	public String getPostFee() {
		return postFee;
	}

	public void setPostFee(String postFee) {
		this.postFee = postFee;
	}

	public Integer getShopId() {
		return shopId;
	}

	public void setShopId(Integer shopId) {
		this.shopId = shopId;
	}

	public Integer getOrderSource() {
		return orderSource;
	}

	public void setOrderSource(Integer orderSource) {
		this.orderSource = orderSource;
	}

	public Integer getPayType() {
		return payType;
	}

	public void setPayType(Integer payType) {
		this.payType = payType;
	}

	public String getConversion() {
		return conversion;
	}

	public void setConversion(String conversion) {
		this.conversion = conversion;
	}

}
