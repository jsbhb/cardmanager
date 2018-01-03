/**  
 * Project Name:cardmanager  
 * File Name:SequeceRule.java  
 * Package Name:com.card.manager.factory.util  
 * Date:Dec 21, 201710:08:45 AM  
 *  
 */
package com.card.manager.factory.util;

/**
 * ClassName: SequeceRule <br/>
 * Function: 自制编码规则. <br/>
 * date: Dec 21, 2017 10:08:45 AM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class SequeceRule {

	/**
	 *
	 * getGoodsId: 生成商品自制编码. <br/>
	 * 
	 * @author hebin
	 * @param goodsSequence
	 * @return
	 * @since JDK 1.7
	 */
	public static String getGoodsId(int goodsSequence) {
		return (100000000 + goodsSequence) + "";
	}

	/**
	 * 
	 * getGoodsItemId:生成商品明细自制编码. <br/>
	 * 
	 * @author hebin
	 * @param goodsItemSequence
	 * @return
	 * @since JDK 1.7
	 */
	public static String getGoodsItemId(int goodsItemSequence) {
		return (100000000 + goodsItemSequence) + "";
	}

}
