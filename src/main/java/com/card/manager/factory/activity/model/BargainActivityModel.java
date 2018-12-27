package com.card.manager.factory.activity.model;

import java.util.List;

import com.card.manager.factory.activity.base.BaseActivityModel;

public class BargainActivityModel extends BaseActivityModel {

	private List<BargainActivityGoodsModel> itemList;
	private Integer joinPerson;
	private String buyFlg;

	public List<BargainActivityGoodsModel> getItemList() {
		return itemList;
	}

	public void setItemList(List<BargainActivityGoodsModel> itemList) {
		this.itemList = itemList;
	}

	public Integer getJoinPerson() {
		return joinPerson;
	}

	public void setJoinPerson(Integer joinPerson) {
		this.joinPerson = joinPerson;
	}

	public String getBuyFlg() {
		return buyFlg;
	}

	public void setBuyFlg(String buyFlg) {
		this.buyFlg = buyFlg;
	}
}
