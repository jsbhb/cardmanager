package com.card.manager.factory.util;

import java.util.Map;

import org.apache.commons.collections.map.CaseInsensitiveMap;

public class ParemeterConverUtil {

	@SuppressWarnings({ "serial", "unchecked" })
	private static final Map<String, Integer> payType = new CaseInsensitiveMap() {
		{
			put("微信", 1);
			put("支付宝", 2);
			put("银联", 3);
			put("转账", 4);
			put("其他", 5);
			put("月结", 6);
		}
	};
	
	@SuppressWarnings({ "serial", "unchecked" })
	private static final Map<String, Integer> orderSource = new CaseInsensitiveMap() {
		{
			put("PC商城", 0);
			put("手机", 1);
			put("有赞", 3);
			put("线下", 4);
			put("展厅", 5);
			put("大客户", 6);
			put("福利商城", 7);
			put("后台订单", 8);
			put("太平惠汇", 9);
			put("小程序", 10);
			put("聚民惠", 11);
			put("拼多多", 12);
			put("易捷北京", 13);
			put("自营", 14);
			put("金融工厂", 15);
			put("中信乐益通", 16);
			put("波罗蜜", 17);
			put("马上消费金融", 18);
			put("供销e家", 19);
			put("淘宝", 20);
		}
	};
	
	@SuppressWarnings({ "serial", "unchecked" })
	private static final Map<String, Integer> orderFlag = new CaseInsensitiveMap() {
		{
			put("跨境", 0);
			put("一般贸易", 2);
		}
	};
	
	public static Integer getPayType(String code) {
		Integer result = payType.get(code);
		return result;
	}
	
	public static Integer getOrderSource(String code) {
		Integer result = orderSource.get(code);
		return result;
	}
	
	public static Integer getOrderFlag(String code) {
		Integer result = orderFlag.get(code);
		return result;
	}
}
