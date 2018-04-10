/**  
 * Project Name:cardmanager  
 * File Name:GoodsPojo.java  
 * Package Name:com.card.manager.factory.goods.pojo  
 * Date:Dec 20, 20174:36:34 PM  
 *  
 */
package com.card.manager.factory.goods.pojo;

import com.card.manager.factory.goods.model.GoodsBaseEntity;
import com.card.manager.factory.goods.model.GoodsEntity;

/**
 * ClassName: GoodsInfoEntity <br/>
 * Function: 商品对象. <br/>
 * date: Dec 20, 2017 4:36:34 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class GoodsInfoEntity {

	private GoodsBaseEntity goodsBase;
	private GoodsEntity goods;
	
	
	public GoodsBaseEntity getGoodsBase() {
		return goodsBase;
	}
	public void setGoodsBase(GoodsBaseEntity goodsBase) {
		this.goodsBase = goodsBase;
	}
	public GoodsEntity getGoods() {
		return goods;
	}
	public void setGoods(GoodsEntity goods) {
		this.goods = goods;
	}
}
