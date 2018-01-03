/**  
 * Project Name:cardmanager  
 * File Name:GoodsStatusEnum.java  
 * Package Name:com.card.manager.factory.goods.pojo  
 * Date:Dec 21, 201710:13:19 AM  
 *  
 */
package com.card.manager.factory.order.pojo;

/**
 * ClassName: GoodsStatusEnum <br/>
 * Function: 商品状态枚举类. <br/>
 * date: Dec 21, 2017 10:13:19 AM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public enum OrderStatusEnum {

	INIT("待处理", 0), USEFUL("已付款", 1), PAY_DECLARE("支付单报关", 2), PASS_WAREHOUSE("已发仓库", 3), ORDER_DECLARE("已报海关",
			4), DZFX("单证放行", 5), YFH("已发货", 6), YSH("已收货", 7), TD("退单", 8), TIMEOUT("超时取消", 9), EXCEPTION("异常状态", 99);

	private String name;
	private int index;

	private OrderStatusEnum(String name, int index) {
		this.name = name;
		this.index = index;
	}

	public static String getName(int index) {
		for (OrderStatusEnum c : OrderStatusEnum.values()) {
			if (c.getIndex() == index) {
				return c.name;
			}
		}
		return null;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

}
