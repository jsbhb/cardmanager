package com.card.manager.factory.util;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

public class Utils {

	/**
	 * @fun 判断除去指定字段的其他字段是否都为空
	 * @param obj
	 * @param fields
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static boolean isAllFieldNotNull(Object obj, List<String> fields) {
		Class stuCla = (Class) obj.getClass();// 得到类对象
		Field[] fs = stuCla.getDeclaredFields();// 得到属性集合
		boolean flag = true;
		for (Field f : fs) {// 遍历属性
			if(fields != null){
				if (fields.contains(f.getName())) {
					continue;
				}
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

	/**
	 * @fun 字符串转整数
	 * @param str
	 * @return
	 */
	public static Integer convert(String str) {
		if (str.contains(".")) {
			return Integer.valueOf(str.substring(0, str.indexOf(".")));
		} else {
			return Integer.valueOf(str);
		}
	}

	/**
	 * @fun 字符串去除小数点后的字符
	 * @param str
	 * @return
	 */
	public static String removePoint(String str) {
		if (str != null) {
			if (str.contains(".")) {
				return str.substring(0, str.indexOf("."));
			}
		}
		return str;
	}

	public static String StringToUtf8(String str, String charsetName) {
		try {
			return new String(str.getBytes(charsetName), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * @fun 获得指定字段名的类型
	 * @param clazz
	 * @param fieldName
	 * @return
	 */
	public static Class<?> getGenericClazz(Class<?> clazz, String fieldName) {
		Field[] fields = clazz.getDeclaredFields();

		for (Field f : fields) {
			if (f.getName().equals(fieldName)) {
				f.setAccessible(true);
				if (f.getType() == java.util.List.class || f.getType() == java.util.Set.class) {
					// 如果是List类型，得到其Generic的类型
					Type genericType = f.getGenericType();
					if (genericType == null){
						return null;
					}
					// 如果是泛型参数的类型
					if (genericType instanceof ParameterizedType) {
						ParameterizedType pt = (ParameterizedType) genericType;
						// 得到泛型里的class类型对象
						Class<?> genericClazz = (Class<?>) pt.getActualTypeArguments()[0];
						return genericClazz;
					}
				} else {
					return f.getType();
				}
			}
		}
		return null;
	}
}
