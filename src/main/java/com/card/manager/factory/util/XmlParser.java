package com.card.manager.factory.util;

import java.io.StringReader;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

/**
 * 说明：xml解析类
 * 
 * @author 赵增丰
 * @version 1.0 2014-12-5 上午11:15:33
 */
public class XmlParser {

	/**
	 * 解析xml请求,利用反射自动生成obj对象
	 * 
	 * @param xmlStr
	 * @param classes
	 * @return 返回一直map 包括 对象 以及里面的list
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public static Map<String, Object> parseXMLRequest(String xmlStr, Class clazz, Class childClazz) throws Exception {
		// xml 去掉换行符
		xmlStr = xmlStr.replace("\n", "").replace("\r", "");
		if (xmlStr.contains("<?xml")) {
			xmlStr = xmlStr.substring(0, 38) + xmlStr.substring(38, xmlStr.length()).replace(" ", "");
		}
		System.out.println(xmlStr);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Object> itemList = new ArrayList<Object>();
		// 使用DOM的方式解析
		Document doc = null;
		DocumentBuilderFactory docBuildFac = DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuild = docBuildFac.newDocumentBuilder();
		doc = docBuild.parse(new InputSource(new StringReader(xmlStr)));
		// 得到root元素
		Element rootElt = doc.getDocumentElement();

		Object obj = null;
		Object childObj = null;
		try {
			obj = clazz.newInstance();
		} catch (InstantiationException e) {
			// logger.error("异常", e);
		} catch (IllegalAccessException e) {
			// logger.error("异常", e);
		}
		// 获得实例的属性
		Field[] fields = getDeclaredFields(clazz);
		// 获得实例的属性
		Field[] childFields = null;
		if (childClazz != null) {
			childFields = getDeclaredFields(childClazz);
		}
		// 实例的set方法
		Method setMethod = null;

		NodeList nodeList = rootElt.getChildNodes();

		for (int i = 0; i < nodeList.getLength(); i++) {
			Node childNode = nodeList.item(i);
			if ("item".equals(childNode.getNodeName())) {
				NodeList itemNodeList = childNode.getChildNodes();
				try {
					childObj = childClazz.newInstance();
				} catch (InstantiationException e) {
					// logger.error("异常", e);
				} catch (IllegalAccessException e) {
					// logger.error("异常", e);
				}
				for (int j = 0; j < itemNodeList.getLength(); j++) {
					Node itemChildNode = itemNodeList.item(j);
					String nodeName = itemChildNode.getNodeName();
					Field field = getDeclaredField(childFields, nodeName);
					if (field == null) {
						continue;
					}
					Class type = field.getType();
					if (type == null) {
						continue;
					}
					setMethod = childObj.getClass().getMethod("set" + nodeName.substring(0, 1).toUpperCase() + nodeName.substring(1), type);
					setMethod.invoke(childObj, itemChildNode.getTextContent());
				}
				itemList.add(childObj);
			} else {
				String nodeName = childNode.getNodeName();
				Field field = getDeclaredField(fields, nodeName);
				if (field == null) {
					continue;
				}
				Class type = field.getType();
				if (type == null) {
					continue;
				}
				setMethod = obj.getClass().getMethod("set" + nodeName.substring(0, 1).toUpperCase() + nodeName.substring(1), type);
				setMethod.invoke(obj, childNode.getTextContent());
			}
		}
		resultMap.put("object", obj);
		resultMap.put("itemList", itemList);
		return resultMap;
	}

	/**
	 * 递归查找所有的属性，包括父类的属性，直到父类是BaseDomain时停止
	 * 
	 * @param object
	 * @return
	 */
	public static Field[] getDeclaredFields(Class clazz) {
		if (clazz == null)
			return null;
		Field[] fields = clazz.getDeclaredFields();
		return fields;
	}

	/**
	 * 获取属性
	 * 
	 * @param clazz
	 * @param filedName
	 * @return
	 */
	public static Field getDeclaredField(Field[] fields, String filedName) {
		for (Field field : fields) {
			if (filedName.equalsIgnoreCase(field.getName())) {
				return field;
			}
		}
		return null;
	}

	public static Map<String, String> parseXMLResponse(String xmlStr) throws Exception {

		xmlStr = xmlStr.replace("\n", "").replace("\r", "");
		if (xmlStr.contains("<?xml")) {
			xmlStr = xmlStr.substring(0, 38) + xmlStr.substring(38, xmlStr.length()).replace(" ", "");
		}

		// 使用DOM的方式解析
		Map<String, String> resultMap = new HashMap<String, String>();
		Document doc = null;
		DocumentBuilderFactory docBuildFac = DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuild = docBuildFac.newDocumentBuilder();
		doc = docBuild.parse(new InputSource(new StringReader(xmlStr)));
		// 得到root元素
		Element rootElt = doc.getDocumentElement();
		NodeList nodeList = rootElt.getChildNodes();
		for (int i = 0; i < nodeList.getLength(); i++) {
			Node childNode = nodeList.item(i);
			String key = childNode.getNodeName();
			String value = childNode.getTextContent();
			resultMap.put(key, value);
		}
		return resultMap;
	}

	public static Map<String, String> parseXMLDsResponse(String xmlStr) throws Exception {

		xmlStr = xmlStr.replace("\n", "").replace("\r", "");
		if (xmlStr.contains("<?xml")) {
			xmlStr = xmlStr.substring(0, 38) + xmlStr.substring(38, xmlStr.length()).replace(" ", "");
		}

		// 使用DOM的方式解析
		Map<String, String> resultMap = new HashMap<String, String>();
		Document doc = null;
		DocumentBuilderFactory docBuildFac = DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuild = docBuildFac.newDocumentBuilder();
		doc = docBuild.parse(new InputSource(new StringReader(xmlStr)));
		// 得到root元素
		Element rootElt = doc.getDocumentElement();
		NodeList nodeList = rootElt.getChildNodes();
		nodeList = nodeList.item(0).getChildNodes();
		
		for (int i = 0; i < nodeList.getLength(); i++) {
			Node childNode = nodeList.item(i);
			String key = childNode.getNodeName();
			String value = childNode.getTextContent();
			resultMap.put(key, value);
		}
		return resultMap;
	}

	public static Map<String, String> parseXMLResponseGTS(String xmlStr) throws Exception {
		// 使用DOM的方式解析
		Map<String, String> resultMap = new HashMap<String, String>();
		Document doc = null;
		DocumentBuilderFactory docBuildFac = DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuild = docBuildFac.newDocumentBuilder();
		doc = docBuild.parse(new InputSource(new StringReader(xmlStr)));
		// 得到root元素
		Element rootElt = doc.getDocumentElement();
		NodeList nodeList = rootElt.getChildNodes();
		List<String> externalNo2 = new ArrayList<String>();
		for (int i = 0; i < nodeList.getLength(); i++) {
			Node childNode = nodeList.item(i);
			String key = childNode.getNodeName();
			String value = childNode.getTextContent();
			resultMap.put(key, value);
		}
		return resultMap;
	}
}
