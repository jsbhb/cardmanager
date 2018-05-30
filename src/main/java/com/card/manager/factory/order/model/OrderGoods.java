package com.card.manager.factory.order.model;

import com.card.manager.factory.order.pojo.OrderImportBO;
import com.card.manager.factory.util.Utils;

/**
 * ClassName: OrderGoods <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: Aug 11, 2017 3:16:08 PM <br/>
 * 
 * @author wqy
 * @version
 * @since JDK 1.7
 */
public class OrderGoods {

	private Integer id;
	private String orderId;
	private String itemId;
	private String sku;
	private String itemName;
	private String itemImg;
	private String itemInfo;
	private String itemCode;
	private Integer itemQuantity;
	private Double itemPrice;
	private Double actualPrice;
	private String remark;
	
	public OrderGoods(){}

	public OrderGoods(OrderImportBO model) throws NumberFormatException{
		orderId = Utils.removePoint(model.getOrderId());
		itemId = Utils.removePoint(model.getItemId());
		sku = Utils.removePoint(model.getSku());
		itemName = model.getItemName();
		itemCode = Utils.removePoint(model.getItemCode());
		itemQuantity = Integer.valueOf(Utils.convert(model.getItemQuantity()));
		itemPrice = Double.valueOf(model.getItemPrice());
		actualPrice = Double.valueOf(model.getItemPrice());
	}

	public String getItemImg() {
		return itemImg;
	}

	public void setItemImg(String itemImg) {
		this.itemImg = itemImg;
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

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getSku() {
		return sku;
	}

	public void setSku(String sku) {
		this.sku = sku;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public Integer getItemQuantity() {
		return itemQuantity;
	}

	public void setItemQuantity(Integer itemQuantity) {
		this.itemQuantity = itemQuantity;
	}

	public Double getItemPrice() {
		return itemPrice;
	}

	public void setItemPrice(Double itemPrice) {
		this.itemPrice = itemPrice;
	}

	public Double getActualPrice() {
		return actualPrice;
	}

	public void setActualPrice(Double actualPrice) {
		this.actualPrice = actualPrice;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getItemInfo() {
		return itemInfo;
	}

	public void setItemInfo(String itemInfo) {
		this.itemInfo = itemInfo;
	}

	@Override
	public String toString() {
		return "OrderGoods [id=" + id + ", orderId=" + orderId + ", itemId=" + itemId + ", sku=" + sku + ", itemName="
				+ itemName + ", itemInfo=" + itemInfo + ", itemCode=" + itemCode + ", itemQuantity=" + itemQuantity
				+ ", itemPrice=" + itemPrice + ", actualPrice=" + actualPrice + ", remark=" + remark + "]";
	}
}