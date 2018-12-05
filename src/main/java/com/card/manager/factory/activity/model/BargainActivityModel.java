package com.card.manager.factory.activity.model;

import java.util.List;

import com.card.manager.factory.activity.base.BaseActivityModel;

public class BargainActivityModel extends BaseActivityModel {

	private List<BargainActivityGoodsModel> itemList;

	public List<BargainActivityGoodsModel> getItemList() {
		return itemList;
	}

	public void setItemList(List<BargainActivityGoodsModel> itemList) {
		this.itemList = itemList;
	}
}
