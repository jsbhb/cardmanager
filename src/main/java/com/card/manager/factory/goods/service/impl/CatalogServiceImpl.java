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

import com.card.manager.factory.annotation.Log;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.goods.model.CatalogModel;
import com.card.manager.factory.goods.model.CategoryPropertyBindModel;
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
public class CatalogServiceImpl extends AbstractServcerCenterBaseService implements CatalogService {

	@SuppressWarnings("rawtypes")
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
	@Log(content = "新增商品分类信息操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void add(CatalogModel model, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = null;
		if (CategoryTypeEnum.FIRST.getType().equals(model.getType())) {
			FirstCatalogEntity entity = new FirstCatalogEntity();
			if (StringUtil.isEmpty(model.getId())) {
				int sequence = staffMapper.nextVal(ServerCenterContants.FIRST_CATALOG);
				entity.setFirstId(ServerCenterContants.FIRST_CATALOG + sequence);
			} else {
				entity.setFirstId(model.getId());
			}
			entity.setName(model.getName());
			entity.setOpt(staffEntity.getOptName());
			entity.setAccessPath(model.getAccessPath());
			entity.setSort(model.getSort());
			entity.setTagPath(model.getTagPath());
			entity.setStatus(1);

			result = helper.request(
					URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_SAVE_FIRST_CATALOG,
					staffEntity.getToken(), true, entity, HttpMethod.POST);
		} else if (CategoryTypeEnum.SECOND.getType().equals(model.getType())) {
			if (StringUtil.isEmpty(model.getParentId())) {
				throw new Exception("新增二级分类没有上级分类信息！");
			}
			SecondCatalogEntity entity = new SecondCatalogEntity();
			if (StringUtil.isEmpty(model.getId())) {
				int sequence = staffMapper.nextVal(ServerCenterContants.SECOND_CATALOG);
				entity.setSecondId(ServerCenterContants.SECOND_CATALOG + sequence);
			} else {
				entity.setSecondId(model.getId());
			}
			entity.setFirstId(model.getParentId());
			entity.setName(model.getName());
			entity.setOpt(staffEntity.getOptName());
			entity.setAccessPath(model.getAccessPath());
			entity.setSort(model.getSort());
			entity.setTagPath(model.getTagPath());
			entity.setStatus(1);

			result = helper.request(
					URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_SAVE_SECOND_CATALOG,
					staffEntity.getToken(), true, entity, HttpMethod.POST);
		} else if (CategoryTypeEnum.THIRD.getType().equals(model.getType())) {
			if (StringUtil.isEmpty(model.getParentId())) {
				throw new Exception("新增三级分类没有上级分类信息！");
			}
			ThirdCatalogEntity entity = new ThirdCatalogEntity();
			entity.setSecondId(model.getParentId());
			if (StringUtil.isEmpty(model.getId())) {
				int sequence = staffMapper.nextVal(ServerCenterContants.THIRD_CATALOG);
				entity.setThirdId(ServerCenterContants.THIRD_CATALOG + sequence);
			} else {
				entity.setThirdId(model.getId());
			}
			entity.setName(model.getName());
			entity.setOpt(staffEntity.getOptName());
			entity.setAccessPath(model.getAccessPath());
			entity.setSort(model.getSort());
			entity.setTagPath(model.getTagPath());
			entity.setStatus(1);

			result = helper.request(
					URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_SAVE_THIRD_CATALOG,
					staffEntity.getToken(), true, entity, HttpMethod.POST);
		}
		if (result == null) {
			throw new Exception("没有返回信息");
		}
		JSONObject json = JSONObject.fromObject(result.getBody());
		if (!json.getBoolean("success")) {
			throw new Exception("新增商品分类信息操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	@Log(content = "更新商品分类信息操作", source = Log.BACK_PLAT, type = Log.MODIFY)
	public void modify(CatalogModel model, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = null;
		if (CategoryTypeEnum.FIRST.getType().equals(model.getType())) {
			FirstCatalogEntity entity = new FirstCatalogEntity();
			entity.setFirstId(model.getId());
			entity.setName(model.getName());
			entity.setOpt(staffEntity.getOptName());
			entity.setAccessPath(model.getAccessPath());
			entity.setSort(model.getSort());
			entity.setTagPath(model.getTagPath());
			result = helper.request(
					URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_MODIFY_FIRST_CATALOG,
					staffEntity.getToken(), true, entity, HttpMethod.POST);

		} else if (CategoryTypeEnum.SECOND.getType().equals(model.getType())) {
			SecondCatalogEntity entity = new SecondCatalogEntity();
			entity.setSecondId(model.getId());
			entity.setName(model.getName());
			entity.setOpt(staffEntity.getOptName());
			entity.setAccessPath(model.getAccessPath());
			entity.setSort(model.getSort());
			entity.setTagPath(model.getTagPath());
			result = helper.request(
					URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_MODIFY_SECOND_CATALOG,
					staffEntity.getToken(), true, entity, HttpMethod.POST);
		} else if (CategoryTypeEnum.THIRD.getType().equals(model.getType())) {
			ThirdCatalogEntity entity = new ThirdCatalogEntity();
			entity.setThirdId(model.getId());
			entity.setName(model.getName());
			entity.setOpt(staffEntity.getOptName());
			entity.setAccessPath(model.getAccessPath());
			entity.setSort(model.getSort());
			entity.setTagPath(model.getTagPath());
			result = helper.request(
					URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_MODIFY_THIRD_CATALOG,
					staffEntity.getToken(), true, entity, HttpMethod.POST);
		}
		if (result == null)
			throw new Exception("没有返回信息");
		JSONObject json = JSONObject.fromObject(result.getBody());
		if (!json.getBoolean("success")) {
			throw new Exception("更新商品分类信息操作失败:" + json.getString("errorMsg"));
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
	@Log(content = "删除商品分类信息操作", source = Log.BACK_PLAT, type = Log.DELETE)
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
			throw new Exception("删除商品分类信息操作失败:" + json.getString("errorMsg"));
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

	@Override
	@Log(content = "发布商品分类信息操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void publish(StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = null;

		result = helper.request(URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_PUBLISH,
				staffEntity.getToken(), true, null, HttpMethod.POST);

		if (result == null)
			throw new Exception("没有返回信息");

		JSONObject json = JSONObject.fromObject(result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("发布商品分类信息操作失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	@Log(content = "执行商品分类操作", source = Log.BACK_PLAT, type = Log.MODIFY)
	public void updCategoryByParam(CatalogModel model, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = null;
		if (CategoryTypeEnum.FIRST.getType().equals(model.getType())) {
			FirstCatalogEntity entity = new FirstCatalogEntity();
			entity.setFirstId(model.getId());
			entity.setSort(model.getSort());
			entity.setStatus(model.getStatus());

			result = helper.request(
					URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_UPDATE_FIRST_CATALOG_BY_PARAM,
					staffEntity.getToken(), true, entity, HttpMethod.POST);

		} else if (CategoryTypeEnum.SECOND.getType().equals(model.getType())) {

			SecondCatalogEntity entity = new SecondCatalogEntity();
			entity.setSecondId(model.getId());
			entity.setSort(model.getSort());
			entity.setStatus(model.getStatus());

			result = helper.request(
					URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_UPDATE_SECOND_CATALOG_BY_PARAM,
					staffEntity.getToken(), true, entity, HttpMethod.POST);
		} else if (CategoryTypeEnum.THIRD.getType().equals(model.getType())) {
			ThirdCatalogEntity entity = new ThirdCatalogEntity();
			entity.setThirdId(model.getId());
			entity.setSort(model.getSort());
			entity.setStatus(model.getStatus());
			entity.setIsPopular(model.getIsPopular());

			result = helper.request(
					URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_UPDATE_THIRD_CATALOG_BY_PARAM,
					staffEntity.getToken(), true, entity, HttpMethod.POST);
		}

		if (result == null)
			throw new Exception("没有返回信息");

		JSONObject json = JSONObject.fromObject(result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("执行商品分类操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public SecondCatalogEntity queryFirstBySecondId(SecondCatalogEntity entity, String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_QUERY_FIRST_BY_SECONDID, token,
				true, entity, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), SecondCatalogEntity.class);
	}

	@Override
	public String getGoodsCategoryId(String categoryType) {
		String retCategoryId = "";
		int sequence = 0;
		if (CategoryTypeEnum.FIRST.getType().equals(categoryType)) {
			sequence = staffMapper.nextVal(ServerCenterContants.FIRST_CATALOG);
			retCategoryId = ServerCenterContants.FIRST_CATALOG + sequence;
		} else if (CategoryTypeEnum.SECOND.getType().equals(categoryType)) {
			sequence = staffMapper.nextVal(ServerCenterContants.SECOND_CATALOG);
			retCategoryId = ServerCenterContants.SECOND_CATALOG + sequence;
		} else if (CategoryTypeEnum.THIRD.getType().equals(categoryType)) {
			sequence = staffMapper.nextVal(ServerCenterContants.THIRD_CATALOG);
			retCategoryId = ServerCenterContants.THIRD_CATALOG + sequence;
		}
		return retCategoryId;
	}

	@Override
	public FirstCatalogEntity getCatelogInfoByParams(Map<String, Object> params, String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_QUERY_CATALOGINFO_BY_PARAMS, token,
				true, null, HttpMethod.POST, params);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), FirstCatalogEntity.class);
	}

	@Override
	public void categoryJoinProperty(CategoryPropertyBindModel model, String propertyType, StaffEntity staffEntity)
			throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = helper
				.request(
						URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_CATEGORY_JOIN_PROPERTY
								+ "?propertyType=" + propertyType,
						staffEntity.getToken(), true, model, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("类目关联属性操作失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	public void categoryUnJoinProperty(Map<String, Object> params, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_CATEGORY_UN_JOIN_PROPERTY,
				staffEntity.getToken(), true, null, HttpMethod.POST, params);

		JSONObject json = JSONObject.fromObject(result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("类目移除属性操作失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	public void updCategoryJoinPropertyByParam(Map<String,Object> params, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_MODIFY_CATEGORY_JOIN_PROPERTY,
				staffEntity.getToken(), true, null, HttpMethod.POST, params);

		JSONObject json = JSONObject.fromObject(result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("更新类目关联属性操作失败:" + json.getString("errorMsg"));
		}

	}
}
