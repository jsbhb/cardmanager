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

import com.card.manager.factory.annotation.Log;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.goods.model.SpecsEntity;
import com.card.manager.factory.goods.model.SpecsTemplateEntity;
import com.card.manager.factory.goods.model.SpecsValueEntity;
import com.card.manager.factory.goods.service.SpecsService;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * ClassName: SupplierServiceImpl <br/>
 * Function: 规格服务. <br/>
 * date: Nov 7, 2017 3:22:23 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
@Service
public class SpecsServiceImpl extends AbstractServcerCenterBaseService implements SpecsService {

	@Override
	@Log(content = "新增商品规格模板信息操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void add(SpecsTemplateEntity entity, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_SPECS_SAVE, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("新增商品规格模板信息操作失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	public SpecsTemplateEntity queryById(String id, String token) {
		SpecsTemplateEntity entity = new SpecsTemplateEntity();
		entity.setId(Integer.parseInt(id));

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_SPECS_QUERY, token, true, entity,
				HttpMethod.POST);

		 JSONObject json = JSONObject.fromObject(query_result.getBody());
		// return new SpecsTemplateEntity(json.getJSONObject("obj"));
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), SpecsTemplateEntity.class);
	}

	@Override
	@Log(content = "新增商品规格信息操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void addSpecsValue(SpecsValueEntity entity, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_SPECS_SAVE_VALUE, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("新增商品规格信息操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	@Log(content = "新增商品规格操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void addSpecs(SpecsEntity specsEntity, String token) throws Exception{
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_SPECS_SAVE_SPECS, token, true, specsEntity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("新增商品规格操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public List<SpecsEntity> queryAllSpecs(String token) {

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_SPECS, token, true, null,
				HttpMethod.GET);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		List<SpecsEntity> list = new ArrayList<SpecsEntity>();
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			list.add(JSONUtilNew.parse(jObj.toString(), SpecsEntity.class));
		}
		return list;
	}

	@Override
	public List<SpecsValueEntity> queryAllSpecsValue(String token) {

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_SPECS_VALUE, token, true, null,
				HttpMethod.GET);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		List<SpecsValueEntity> list = new ArrayList<SpecsValueEntity>();
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			list.add(JSONUtilNew.parse(jObj.toString(), SpecsValueEntity.class));
		}
		return list;
	}

}
