package com.card.manager.factory.order.pojo;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.card.manager.factory.util.ParemeterConverUtil;
import com.card.manager.factory.util.RegularUtil;

public class OrderImportBO {

	private String orderId;
	private String supplierName;
	private Integer supplierId;
	private Integer shopId;
	private String shopName;
	private String orderFlagName;
	private Integer orderFlag;
	private String sku;
	private String itemId;
	private String itemCode;
	private String itemPrice;
	private String itemQuantity;
	private String orderSourceName;
	private Integer orderSource;
	private String payment;
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
	private String itemName;
	private String phone;
	private String name;
	private String idNum;

	public boolean init(Map<String, Integer> gradeMapTemp, Map<String, Integer> supplierMap) {

		supplierId = supplierMap.get(supplierName);
		shopId = gradeMapTemp.get(shopName);
		orderSource = ParemeterConverUtil.getOrderSource(orderSourceName);
		orderFlag = ParemeterConverUtil.getOrderFlag(orderFlagName);
		payType = ParemeterConverUtil.getPayType(payTypeName);
		taxFee = taxFee == null || "".equals(taxFee) ? "0" : taxFee;
		postFee = postFee == null || "".equals(postFee) ? "0" : postFee;
		phone = phone == null ? "" : phone;
		name = name == null ? "" : name;
		idNum = idNum == null ? "" : idNum;
		payNo = "".equals(payNo) ? null : payNo;
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
		fields.add("itemId");// itemId可以为null
		return fields;
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

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getSupplierName() {
		return supplierName;
	}

	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}

	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public String getOrderFlagName() {
		return orderFlagName;
	}

	public void setOrderFlagName(String orderFlagName) {
		this.orderFlagName = orderFlagName;
	}

	public Integer getOrderFlag() {
		return orderFlag;
	}

	public void setOrderFlag(Integer orderFlag) {
		this.orderFlag = orderFlag;
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

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
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

	public String getPayment() {
		return payment;
	}

	public void setPayment(String payment) {
		this.payment = payment;
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

	public Integer getSupplierId() {
		return supplierId;
	}

	public void setSupplierId(Integer supplierId) {
		this.supplierId = supplierId;
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

}
