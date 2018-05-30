package com.card.manager.factory.util;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;

/**
 * 说明：wms
 * 
 * @author 赵增丰
 * @version 1.0 2014-8-11 下午2:42:30
 */
public class URLUtils {

	private static ResourceBundle res = ResourceBundle.getBundle("urls");
	private static ResourceBundle conf = ResourceBundle.getBundle("conf");
	private static ResourceBundle excelconvert = ResourceBundle.getBundle("excelConvertConf");
	private static Map<String, String> urlsMap = null;
	private static Map<String, String> confMap = null;
	private static Map<String, String> excelconvertMap = null;

	/**
	 * 获取urlMap
	 * 
	 * @return
	 */
	public static Map<String, String> getUrlMap() {
		if (urlsMap != null && !urlsMap.isEmpty()) {
			return urlsMap;
		}
		urlsMap = new HashMap<String, String>();
		Enumeration e = res.getKeys();
		while (e.hasMoreElements()) {
			String key = e.nextElement().toString();
			String value = get(key);
			urlsMap.put(key, value);
			System.out.println(key + "---" + value);
		}
		return urlsMap;
	}
	
	public static Map<String, String> getExcelconvert() {
		if (excelconvertMap != null && !excelconvertMap.isEmpty()) {
			return excelconvertMap;
		}
		excelconvertMap = new HashMap<String, String>();
		Enumeration e = excelconvert.getKeys();
		while (e.hasMoreElements()) {
			String key = e.nextElement().toString();
			String value = getExcelconvertMap(key);
			excelconvertMap.put(key, value);
			System.out.println(key + "---" + value);
		}
		return excelconvertMap;
	}

	public static Map<String, String> getConfMap() {
		if (confMap != null && !confMap.isEmpty()) {
			return confMap;
		}
		confMap = new HashMap<String, String>();
		Enumeration e = conf.getKeys();
		while (e.hasMoreElements()) {
			String key = e.nextElement().toString();
			String value = getConfMapKey(key);
			confMap.put(key, value);
			System.out.println(key + "---" + value);
		}
		return confMap;
	}

	public static String get(String key) {
		return res.getString(key);
	}

	public static String getConfMapKey(String key) {
		return conf.getString(key);
	}
	
	public static String getExcelconvertMap(String key) {
		return excelconvert.getString(key);
	}

}
