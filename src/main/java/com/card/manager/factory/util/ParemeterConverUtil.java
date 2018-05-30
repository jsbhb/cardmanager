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
			put("其他", 4);
		}
	};
	
	@SuppressWarnings({ "serial", "unchecked" })
	private static final Map<String, Integer> orderSource = new CaseInsensitiveMap() {
		{
			put("PC商城", 0);
			put("手机", 1);
			put("有赞", 3);
			put("B2B线下", 4);
			put("展厅", 5);
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
		return result != null ? result : 4;
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
