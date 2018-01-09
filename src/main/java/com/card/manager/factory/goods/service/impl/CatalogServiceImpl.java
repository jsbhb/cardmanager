/**  
 * Project Name:cardmanager  
 * File Name:SupplierServiceImpl.java  
 * Package Name:com.card.manager.factory.supplier.service.impl  
 * Date:Nov 7, 20173:22:23 PM  
 *  
 */
package com.card.manager.factory.goods.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.goods.model.CatalogModel;
import com.card.manager.factory.goods.model.CategoryTypeEnum;
import com.card.manager.factory.goods.model.FirstCatalogEntity;
import com.card.manager.factory.goods.model.SecondCatalogEntity;
import com.card.manager.factory.goods.model.ThirdCatalogEntity;
import com.card.manager.factory.goods.service.CatalogService;
import com.card.manager.factory.system.mapper.StaffMapper;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.StringUtil;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * ClassName: SupplierServiceImpl <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: Nov 7, 2017 3:22:23 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
@Service
public class CatalogServiceImpl implements CatalogService {

	@Resource
	StaffMapper staffMapper;

	@Override
	public List<FirstCatalogEntity> queryAll(String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_QUERY, token, true, null,
				HttpMethod.GET);

		JSONObject obj = JSONObject.fromObject(query_result.getBody());

		if (obj == null)
			return null;

		JSONArray jsonArray = obj.getJSONArray("obj");

		if (jsonArray == null || jsonArray.size() == 0)
			return null;

		List<FirstCatalogEntity> res = new ArrayList<FirstCatalogEntity>();
		for (int i = 0; i < jsonArray.size(); i++) {

			FirstCatalogEntity first = new FirstCatalogEntity(jsonArray.getJSONObject(i));

			if (first.getId() == 0) {
				continue;
			}
			res.add(first);
		}

		return res;
	}

	@Override
	public void add(CatalogModel model, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = null;
		if (CategoryTypeEnum.FIRST.getType().equals(model.getType())) {
			FirstCatalogEntity entity = new FirstCatalogEntity();
			int sequence = staffMapper.nextVal(ServerCenterContants.FIRST_CATALOG);
			entity.setFirstId(ServerCenterContants.FIRST_CATALOG + sequence);
			entity.setName(model.getName());
			entity.setOpt(staffEntity.getOpt());

			result = helper.request(
					URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_SAVE_FIRST_CATALOG,
					staffEntity.getToken(), true, entity, HttpMethod.POST);

		} else if (CategoryTypeEnum.SECOND.getType().equals(model.getType())) {

			if (StringUtil.isEmpty(model.getParentId())) {
				throw new Exception("新增二级分类没有上级分类信息！");
			}
			SecondCatalogEntity entity = new SecondCatalogEntity();
			int sequence = staffMapper.nextVal(ServerCenterContants.SECOND_CATALOG);
			entity.setSecondId(ServerCenterContants.SECOND_CATALOG + sequence);
			entity.setFirstId(model.getParentId());
			entity.setName(model.getName());
			entity.setOpt(staffEntity.getOpt());

			result = helper.request(
					URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_SAVE_SECOND_CATALOG,
					staffEntity.getToken(), true, entity, HttpMethod.POST);
		} else if (CategoryTypeEnum.THIRD.getType().equals(model.getType())) {
			if (StringUtil.isEmpty(model.getParentId())) {
				throw new Exception("新增三级分类没有上级分类信息！");
			}
			ThirdCatalogEntity entity = new ThirdCatalogEntity();
			int sequence = staffMapper.nextVal(ServerCenterContants.THIRD_CATALOG);
			entity.setSecondId(model.getParentId());
			entity.setThirdId(ServerCenterContants.THIRD_CATALOG + sequence);
			entity.setName(model.getName());
			entity.setOpt(staffEntity.getOpt());

			result = helper.request(
					URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_SAVE_THIRD_CATALOG,
					staffEntity.getToken(), true, entity, HttpMethod.POST);
		}

		if (result == null)
			throw new Exception("没有返回信息");

		JSONObject json = JSONObject.fromObject(result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("插入失败:" + json.getString("errorCode") + "-" + json.getString("errorMsg"));
		}

	}
	
	@Override
	public void modify(CatalogModel model, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = null;
		if (CategoryTypeEnum.FIRST.getType().equals(model.getType())) {
			FirstCatalogEntity entity = new FirstCatalogEntity();
			entity.setFirstId(model.getId());
			entity.setName(model.getName());
			entity.setOpt(staffEntity.getOpt());

			result = helper.request(
					URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_MODIFY_FIRST_CATALOG,
					staffEntity.getToken(), true, entity, HttpMethod.POST);

		} else if (CategoryTypeEnum.SECOND.getType().equals(model.getType())) {

			SecondCatalogEntity entity = new SecondCatalogEntity();
			entity.setSecondId(model.getId());
			entity.setName(model.getName());

			result = helper.request(
					URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_MODIFY_SECOND_CATALOG,
					staffEntity.getToken(), true, entity, HttpMethod.POST);
		} else if (CategoryTypeEnum.THIRD.getType().equals(model.getType())) {
			ThirdCatalogEntity entity = new ThirdCatalogEntity();
			entity.setThirdId(model.getId());
			entity.setName(model.getName());

			result = helper.request(
					URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_MODIFY_THIRD_CATALOG,
					staffEntity.getToken(), true, entity, HttpMethod.POST);
		}

		if (result == null)
			throw new Exception("没有返回信息");

		JSONObject json = JSONObject.fromObject(result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("插入失败:" + json.getString("errorCode") + "-" + json.getString("errorMsg"));
		}
	}

	@Override
	public List<FirstCatalogEntity> queryFirstCatalogs(String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_QUERY_FIRSR_ALL, token, true, null,
				HttpMethod.GET);

		JSONObject obj = JSONObject.fromObject(query_result.getBody());

		if (obj == null)
			return null;

		JSONArray jsonArray = obj.getJSONArray("obj");

		if (jsonArray == null || jsonArray.size() == 0)
			return null;

		List<FirstCatalogEntity> res = new ArrayList<FirstCatalogEntity>();
		for (int i = 0; i < jsonArray.size(); i++) {

			FirstCatalogEntity first = new FirstCatalogEntity(jsonArray.getJSONObject(i));

			if (first.getId() == 0) {
				continue;
			}
			res.add(first);
		}

		return res;
	}

	@Override
	public List<SecondCatalogEntity> querySecondCatalogByFirstId(String token, String firstId) {
		RestCommonHelper helper = new RestCommonHelper();

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("firstId", firstId);

		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_QUERY_SECOND_BY_FIRST_ID, token,
				true, params, HttpMethod.POST);

		JSONObject obj = JSONObject.fromObject(query_result.getBody());

		if (obj == null)
			return null;

		JSONArray jsonArray = obj.getJSONArray("obj");

		if (jsonArray == null || jsonArray.size() == 0)
			return null;

		List<SecondCatalogEntity> res = new ArrayList<SecondCatalogEntity>();
		for (int i = 0; i < jsonArray.size(); i++) {

			SecondCatalogEntity first = new SecondCatalogEntity(jsonArray.getJSONObject(i));

			if (first.getId() == 0) {
				continue;
			}
			res.add(first);
		}

		return res;
	}

	@Override
	public List<ThirdCatalogEntity> queryThirdCatalogBySecondId(String token, String secondId) {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("secondId", secondId);

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_QUERY_THIRD_BY_SECOND_ID, token,
				true, params, HttpMethod.POST);

		JSONObject obj = JSONObject.fromObject(query_result.getBody());

		if (obj == null)
			return null;

		JSONArray jsonArray = obj.getJSONArray("obj");

		if (jsonArray == null || jsonArray.size() == 0)
			return null;

		List<ThirdCatalogEntity> res = new ArrayList<ThirdCatalogEntity>();
		for (int i = 0; i < jsonArray.size(); i++) {

			ThirdCatalogEntity first = new ThirdCatalogEntity(jsonArray.getJSONObject(i));

			if (first.getId() == 0) {
				continue;
			}
			res.add(first);
		}

		return res;
	}

	@Override
	public void delete(String id, String type, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = null;
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("type", type);

		result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_DELETE_CATALOG,
				staffEntity.getToken(), true, null, HttpMethod.POST, params);

		if (result == null)
			throw new Exception("没有返回信息");

		JSONObject json = JSONObject.fromObject(result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("删除失败:" + json.getString("errorCode") + "-" + json.getString("errorMsg"));
		}

	}

	@Override
	public CatalogModel queryForEdit(CatalogModel model, String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_QUERY_THIRD_BY_SECOND_ID, token,
				true, model, HttpMethod.POST);
		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), CatalogModel.class);

	}
}
