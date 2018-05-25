/**  
 * Project Name:cardmanager  
 * File Name:GoodsFielsMaintainBO.java  
 * Package Name:com.card.manager.factory.goods.pojo  
 * Date:May 25, 20189:59:26 AM  
 *  
 */
package com.card.manager.factory.goods.pojo;

import java.util.Set;

/**
 * ClassName: GoodsFielsMaintainBO <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: May 25, 2018 9:59:26 AM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class GoodsFielsMaintainBO {
	private String itemCode;
	private String goodsDetailPath;
	private Set<String> picPathList;

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public String getGoodsDetailPath() {
		return goodsDetailPath;
	}

	public void setGoodsDetailPath(String goodsDetailPath) {
		this.goodsDetailPath = goodsDetailPath;
	}

	public Set<String> getPicPathList() {
		return picPathList;
	}

	public void setPicPathList(Set<String> picPathList) {
		this.picPathList = picPathList;
	}
}
