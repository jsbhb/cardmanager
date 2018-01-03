/**  
 * Project Name:cardmanager  
 * File Name:GoodsStatusEnum.java  
 * Package Name:com.card.manager.factory.goods.pojo  
 * Date:Dec 21, 201710:13:19 AM  
 *  
 */
package com.card.manager.factory.mall.pojo;

/**
 * ClassName: GoodsStatusEnum <br/>
 * Function: 商品状态枚举类. <br/>
 * date: Dec 21, 2017 10:13:19 AM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public enum PopularizeDictTypeEnum {

	NEW("新品", 0), TT("特推", 1), QD("渠道", 2), JX("精选", 3), NORMAL("普通分类", 4);

	private String name;
	private int index;

	private PopularizeDictTypeEnum(String name, int index) {
		this.name = name;
		this.index = index;
	}

	public static String getName(int index) {
		for (PopularizeDictTypeEnum c : PopularizeDictTypeEnum.values()) {
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
