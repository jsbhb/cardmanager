package com.card.manager.factory.util;

import java.io.StringReader;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
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

import com.card.manager.factory.constants.LoggerConstants;
import com.card.manager.factory.log.SysLogger;


/**
 * 
 * @author 贺斌
 *
 */
public class XMLCoreParser {

	private SysLogger sysLogger = new SysLogger();
	private static XMLCoreParser parser;

	private final int HEAD_START_INDEX = 0;
	private final int HEAD_END_INDEX = 38;
	private final String ENTER_MARK = "\r";
	private final String BLANK_MARK = "\n";
	private final String NONE_STR = "";
	private final String BLANK_STR = " ";
	private final String XML_HEAD_MARK = "<?xml";
	private final String LIST_END_MARK = "List";

	public static XMLCoreParser instanceOf() {
		if (parser == null) {
			parser = new XMLCoreParser();
		}
		return parser;
	}

	private XMLCoreParser() {
	}

	/**
	 * 
	 * @param xmlStr
	 * @param clazz
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Object parseXMLForObject(String xmlStr, Class clazz) throws Exception {
		// xml 去掉换行符
		xmlStr = xmlStr.replace(BLANK_MARK, NONE_STR).replace(ENTER_MARK, NONE_STR);
		if (xmlStr.contains(XML_HEAD_MARK)) {
			xmlStr = xmlStr.substring(HEAD_START_INDEX, HEAD_END_INDEX)
					+ xmlStr.substring(HEAD_END_INDEX, xmlStr.length()).replace(BLANK_STR, NONE_STR);
		}

		sysLogger.info(LoggerConstants.XML_PARSER_LOGGER, "去头部后报文：" + xmlStr);

		Document doc = null;
		DocumentBuilderFactory docBuildFac = DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuild = docBuildFac.newDocumentBuilder();
		doc = docBuild.parse(new InputSource(new StringReader(xmlStr)));
		Element rootElt = doc.getDocumentElement();

		Object obj = null;
		try {
			obj = clazz.newInstance();
		} catch (InstantiationException e) {
			sysLogger.error(LoggerConstants.XML_PARSER_LOGGER, "实例化对象异常：", e);
		} catch (IllegalAccessException e) {
			sysLogger.error(LoggerConstants.XML_PARSER_LOGGER, "实例化对象异常：", e);
		}
		Field[] fields = getDeclaredFields(clazz);

		Map<String, String> objMap = getDeclaredFields(fields);

		NodeList nodeList = rootElt.getChildNodes();

		for (int i = 0; i < nodeList.getLength(); i++) {
			Node childNode = nodeList.item(i);
			String nodeName = childNode.getNodeName();
			Field field = getDeclaredField(fields, nodeName);

			if (nodeName.endsWith(LIST_END_MARK)) {
				for (Map.Entry<String, String> entry : objMap.entrySet()) {
					if (entry.getKey().endsWith(nodeName.substring(1, nodeName.length()))) {
						parserList(entry.getValue(), childNode, obj, field);
					}
				}
			} else if (objMap.containsKey(nodeName)) {
				parserObj(objMap.get(nodeName), childNode, obj, field);
			} else {
				assignment(childNode.getTextContent(), obj, field);
			}
		}
		return obj;
	}

	/**
	 * 通过反射调用set方法赋值
	 * 
	 * @param childNode
	 * @param obj
	 */
	@SuppressWarnings("rawtypes")
	private void assignment(Object value, Object obj, Field field) throws Exception {
		Method setMethod = null;
		if (field == null) {
			return;
		}
		Class type = field.getType();
		if (type == null) {
			return;
		}
		setMethod = obj.getClass()
				.getMethod("set" + field.getName().substring(0, 1).toUpperCase() + field.getName().substring(1), type);
		setMethod.invoke(obj, value);
	}

	/**
	 * 解析对象类型
	 * 
	 * @param string
	 * @param childNode
	 * @param obj
	 * @throws Exception
	 */
	private void parserObj(String objName, Node childNode, Object obj, Field field) throws Exception {
		Object itemObj = newInstance(childNode, objName);
		assignment(itemObj, obj, field);
	}

	/**
	 * 解析集合类型
	 * 
	 * @param value
	 * @param itemNodeList
	 * @param obj
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	private void parserList(String objName, Node childNode, Object obj, Field field) throws Exception {
		NodeList itemNodeList = childNode.getChildNodes();
		List list = new ArrayList();

		for (int j = 0; j < itemNodeList.getLength(); j++) {
			Node itemChildNode = itemNodeList.item(j);
			if (itemChildNode.hasChildNodes()) {
				list.add(newInstance(itemChildNode, objName));
			}
		}

		assignment(list, obj, field);
	}

	/**
	 * 反射出对象
	 * 
	 * @param childNode
	 * @param objName
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	private Object newInstance(Node childNode, String objName) throws Exception {
		Class clz = Class.forName(objName);
		Object obj = clz.newInstance();
		Field[] fields = clz.getDeclaredFields();

		NodeList itemNodeList = childNode.getChildNodes();
		for (int j = 0; j < itemNodeList.getLength(); j++) {
			Node subItemNode = itemNodeList.item(j);
			String nodeName = subItemNode.getNodeName();
			Field field = getDeclaredField(fields, nodeName);

			assignment(subItemNode.getTextContent(), obj, field);
		}

		return obj;
	}

	/**
	 * 获取参数域中所有对象类型的参数列表
	 * 
	 * @param fields
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private Map<String, String> getDeclaredFields(Field[] fields) {

		Map<String, String> objMap = new HashMap<String, String>();

		Class fieldClz;
		for (Field field : fields) {
			fieldClz = field.getType();
			if (fieldClz.isPrimitive())
				continue;
			if (fieldClz.getName().startsWith("java.lang"))
				continue;

			if (fieldClz.isAssignableFrom(List.class)) {
				Type genericType = field.getGenericType();
				if (genericType == null)
					continue;
				if (genericType instanceof ParameterizedType) {
					ParameterizedType pt = (ParameterizedType) genericType;
					Class genericClazz = (Class) pt.getActualTypeArguments()[0];
					objMap.put(field.getName(), genericClazz.getName());
				}
			} else {
				objMap.put(field.getName(), field.getType().getName());
			}

		}
		return objMap;
	}

	/**
	 * 获取属性
	 * 
	 * @param clazz
	 * @param nodeName
	 * @return
	 */
	public Field getDeclaredField(Field[] fields, String nodeName) {
		for (Field field : fields) {
			if (nodeName.equalsIgnoreCase(field.getName())) {
				return field;
			}
			if (nodeName.endsWith(LIST_END_MARK)
					&& field.getName().endsWith(nodeName.substring(1, nodeName.length()))) {
				return field;
			}
		}
		return null;
	}

	/**
	 * 递归查找所有的属性，包括父类的属性，直到父类是BaseDomain时停止
	 * 
	 * @param object
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	private Field[] getDeclaredFields(Class clazz) {
		if (clazz == null)
			return null;
		Field[] fields = clazz.getDeclaredFields();
		return fields;
	}

	public static void main(String[] args) throws Exception {
		FileUtil fu = new FileUtil();
		String str = fu.readFileByByte("报文.xml");
	}

}
