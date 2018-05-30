package com.card.manager.factory.util;

import java.lang.reflect.Field;
import java.util.List;

public class Utils {

	@SuppressWarnings("rawtypes")
	public static boolean isAllFieldNotNull(Object obj, List<String> fields) {
		Class stuCla = (Class) obj.getClass();// 得到类对象
		Field[] fs = stuCla.getDeclaredFields();// 得到属性集合
		boolean flag = true;
		for (Field f : fs) {// 遍历属性
			if (fields.contains(f.getName())) {
				continue;
			}
			f.setAccessible(true); // 设置属性是可以访问的(私有的也可以)
			Object val = null;
			try {
				val = f.get(obj);
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
			if (val == null) {
				flag = false;
				break;
			}
		}
		return flag;
	}

	public static Integer convert(String str) {
		if (str.contains(".")) {
			return Integer.valueOf(str.substring(0, str.indexOf(".")));
		} else {
			return Integer.valueOf(str);
		}
	}

	public static String removePoint(String str) {
		if (str != null) {
			if (str.contains(".")) {
				return str.substring(0, str.indexOf("."));
			}
		}
		return str;
	}
}
