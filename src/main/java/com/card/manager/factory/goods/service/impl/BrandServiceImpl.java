/**  
 * Project Name:cardmanager  
 * File Name:SupplierServiceImpl.java  
 * Package Name:com.card.manager.factory.supplier.service.impl  
 * Date:Nov 7, 20173:22:23 PM  
 *  
 */
package com.card.manager.factory.goods.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.goods.model.BrandEntity;
import com.card.manager.factory.goods.service.BrandService;
import com.card.manager.factory.system.mapper.StaffMapper;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.URLUtils;

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
public class BrandServiceImpl extends AbstractServcerCenterBaseService implements BrandService {

	@Resource
	StaffMapper staffMapper;

	@Override
	public void addBrand(BrandEntity entity, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		int brandIdSequence = staffMapper.nextVal("brand");
		entity.setBrandId("brand_" + brandIdSequence);

		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_BRAND_SAVE, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("插入失败:" + json.getString("errorCode") + "-" + json.getString("errorMsg"));
		}

		CachePoolComponent.syncBrand(token);

	}

	@Override
	public BrandEntity queryById(String id, String token) {
		BrandEntity entity = new BrandEntity();
		entity.setId(Integer.parseInt(id));

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_BRAND_QUERY, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return new BrandEntity(json.getJSONObject("obj"));
	}

	@Override
	public void delete(String brandId, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = null;
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("brandId", brandId);

		result = helper.requestWithParams(URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_BRAND_DELETE,
				staffEntity.getToken(), true, null, HttpMethod.POST, params);

		if (result == null)
			throw new Exception("没有返回信息");

		JSONObject json = JSONObject.fromObject(result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("删除失败:" + json.getString("errorCode") + "-" + json.getString("errorMsg"));
		}
	}

	@Override
	public void modify(BrandEntity entity, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_BRAND_MODIFY, staffEntity.getToken(), true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("更新失败:" + json.getString("errorCode") + "-" + json.getString("errorMsg"));
		}
	}

}
