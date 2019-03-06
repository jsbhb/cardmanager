/**  
 * Project Name:cardmanager  
 * File Name:GoodsEntity.java  
 * Package Name:com.card.manager.factory.goods.model  
 * Date:Nov 12, 201710:28:15 PM  
 *  
 */
package com.card.manager.factory.goods.model;

import java.util.List;

/**
 * 
 * ClassName: KJGoodsEntity <br/>  
 * Function: 商品库改造新商品BO. <br/>   
 * date: 2019年2月25日 上午10:38:45 <br/>  
 *  
 * @author why  
 * @version   
 * @since JDK 1.7
 */
public class KJGoodsBO {
	private KJGoodsEntity kjGoods;
	private KJSpecsGoodsEntity kjSpecsGoods;
	private KJGoodsSpecsTradepatternEntity kjGoodsSpecsTradePattern;
	private KJGoodsItemEntity kjGoodsItem;
	private List<GoodsFile> goodsFileList;
	private KJGoodsPrice kjGoodsPrice;
	private GoodsStockEntity goodsStock;
	private String opt;
	
	public KJGoodsEntity getKjGoods() {
		return kjGoods;
	}
	public void setKjGoods(KJGoodsEntity kjGoods) {
		this.kjGoods = kjGoods;
	}
	public KJSpecsGoodsEntity getKjSpecsGoods() {
		return kjSpecsGoods;
	}
	public void setKjSpecsGoods(KJSpecsGoodsEntity kjSpecsGoods) {
		this.kjSpecsGoods = kjSpecsGoods;
	}
	public KJGoodsSpecsTradepatternEntity getKjGoodsSpecsTradePattern() {
		return kjGoodsSpecsTradePattern;
	}
	public void setKjGoodsSpecsTradePattern(KJGoodsSpecsTradepatternEntity kjGoodsSpecsTradePattern) {
		this.kjGoodsSpecsTradePattern = kjGoodsSpecsTradePattern;
	}
	public KJGoodsItemEntity getKjGoodsItem() {
		return kjGoodsItem;
	}
	public void setKjGoodsItem(KJGoodsItemEntity kjGoodsItem) {
		this.kjGoodsItem = kjGoodsItem;
	}
	public List<GoodsFile> getGoodsFileList() {
		return goodsFileList;
	}
	public void setGoodsFileList(List<GoodsFile> goodsFileList) {
		this.goodsFileList = goodsFileList;
	}
	public KJGoodsPrice getKjGoodsPrice() {
		return kjGoodsPrice;
	}
	public void setKjGoodsPrice(KJGoodsPrice kjGoodsPrice) {
		this.kjGoodsPrice = kjGoodsPrice;
	}
	public GoodsStockEntity getGoodsStock() {
		return goodsStock;
	}
	public void setGoodsStock(GoodsStockEntity goodsStock) {
		this.goodsStock = goodsStock;
	}
	public String getOpt() {
		return opt;
	}
	public void setOpt(String opt) {
		this.opt = opt;
	}
}
