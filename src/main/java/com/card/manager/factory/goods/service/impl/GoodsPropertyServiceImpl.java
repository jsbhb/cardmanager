/**  
 * Project Name:cardmanager  
 * File Name:SupplierServiceImpl.java  
 * Package Name:com.card.manager.factory.supplier.service.impl  
 * Date:Nov 7, 20173:22:23 PM  
 *  
 */
package com.card.manager.factory.goods.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.goods.model.GuidePropertyEntity;
import com.card.manager.factory.goods.model.PropertyEntity;
import com.card.manager.factory.goods.model.PropertyValueEntity;
import com.card.manager.factory.goods.service.GoodsPropertyService;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 
 * ClassName: GoodsPropertyServiceImpl <br/>
 * Function: 商品属性服务实现. <br/>
 * date: 2019年2月20日 上午10:47:34 <br/>
 * 
 * @author why
 * @version
 * @since JDK 1.7
 */
@Service
public class GoodsPropertyServiceImpl extends AbstractServcerCenterBaseService implements GoodsPropertyService {

	@Override
	public void addPropertyName(PropertyEntity entity, String hidTabId, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_PROPERTY_ADD_NAME + "?hidTabId=" + hidTabId,
				token, true, entity, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("新增属性名称操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public PropertyEntity queryPropertyNameById(String id, String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_PROPERTY_QUERY_NAME_BY_ID + "?id=" + id,
				token, true, null, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), PropertyEntity.class);
	}

	@Override
	public GuidePropertyEntity queryGuidePropertyNameById(String id, String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(URLUtils.get("gateway")
				+ ServerCenterContants.GOODS_CENTER_PROPERTY_QUERY_GUIDE_NAME_BY_ID + "?id=" + id, token, true, null,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), GuidePropertyEntity.class);
	}

	@Override
	public void editPropertyName(PropertyEntity entity, String hidTabId, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> usercenter_result = helper.request(URLUtils.get("gateway")
				+ ServerCenterContants.GOODS_CENTER_PROPERTY_EDIT_NAME + "?hidTabId=" + hidTabId, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("修改属性名称操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public void deletePropertyName(String id, String hidTabId, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> usercenter_result = helper.request(URLUtils.get("gateway")
				+ ServerCenterContants.GOODS_CENTER_PROPERTY_DELETE_NAME + "?hidTabId=" + hidTabId + "&id=" + id, token,
				true, null, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("删除属性名称操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public void addPropertyValue(PropertyValueEntity entity, String hidTabId, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> usercenter_result = helper.request(URLUtils.get("gateway")
				+ ServerCenterContants.GOODS_CENTER_PROPERTY_ADD_VALUE + "?hidTabId=" + hidTabId, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("新增属性值操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public PropertyEntity queryPropertyValueById(String id, String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_PROPERTY_QUERY_VALUE_BY_ID + "?id=" + id,
				token, true, null, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), PropertyEntity.class);
	}

	@Override
	public GuidePropertyEntity queryGuidePropertyValueById(String id, String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(URLUtils.get("gateway")
				+ ServerCenterContants.GOODS_CENTER_PROPERTY_QUERY_GUIDE_VALUE_BY_ID + "?id=" + id, token, true, null,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), GuidePropertyEntity.class);
	}

	@Override
	public void editPropertyValue(PropertyValueEntity entity, String hidTabId, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> usercenter_result = helper.request(URLUtils.get("gateway")
				+ ServerCenterContants.GOODS_CENTER_PROPERTY_EDIT_VALUE + "?hidTabId=" + hidTabId, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("修改属性值操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public void deletePropertyValue(String id, String hidTabId, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> usercenter_result = helper.request(URLUtils.get("gateway")
				+ ServerCenterContants.GOODS_CENTER_PROPERTY_DELETE_VALUE + "?hidTabId=" + hidTabId + "&id=" + id,
				token, true, null, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("删除属性值操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public List<PropertyEntity> queryPropertyListByCategory(String categoryId, String categoryType, String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_PROPERTY_QUERY_LIST_BY_CATEGORY
						+ "?categoryId=" + categoryId + "&categoryType=" + categoryType,
				token, true, null, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		List<PropertyEntity> list = new ArrayList<PropertyEntity>();
		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			list.add(JSONUtilNew.parse(jObj.toString(), PropertyEntity.class));
		}
		return list;
	}

	@Override
	public List<PropertyValueEntity> queryPropertyValueListById(String propertyId, String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(URLUtils.get("gateway")
				+ ServerCenterContants.GOODS_CENTER_PROPERTY_QUERY_VALUE_LIST_BY_ID + "?propertyId=" + propertyId,
				token, true, null, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		List<PropertyValueEntity> list = new ArrayList<PropertyValueEntity>();
		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			list.add(JSONUtilNew.parse(jObj.toString(), PropertyValueEntity.class));
		}
		return list;
	}
}
