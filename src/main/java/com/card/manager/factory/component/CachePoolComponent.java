/**  
 * Project Name:cardmanager  
 * File Name:CachePoolComponent.java  
 * Package Name:com.card.manager.factory.common.component  
 * Date:Nov 14, 20178:25:52 PM  
 *  
 */
package com.card.manager.factory.component;

import java.util.ArrayList;
import java.util.List;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;

import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.goods.model.BrandEntity;
import com.card.manager.factory.supplier.model.SupplierEntity;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * ClassName: CachePoolComponent <br/>
 * Function: 缓存池组件. <br/>
 * date: Nov 14, 2017 8:25:52 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class CachePoolComponent {

	private static List<BrandEntity> BRANDS = new ArrayList<BrandEntity>();
	private static List<SupplierEntity> SUPPLIERS = new ArrayList<SupplierEntity>();

	/**
	 * 
	 * getBrands:获取全局品牌信息. <br/>
	 * 
	 * @author hebin
	 * @param token
	 * @return
	 * @since JDK 1.7
	 */
	public static List<BrandEntity> getBrands(String token) {
		if (BRANDS.size() == 0) {
			syncBrand(token);
		}
		return BRANDS;
	}

	/**
	 * syncBrand:服务中心同步品牌信息. <br/>
	 * 
	 * @author hebin
	 * @param token
	 * @since JDK 1.7
	 */
	public static void syncBrand(String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_BRAND_QUERY_ALL, token, true, null,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (json != null && json.getJSONArray("obj") != null) {
			JSONArray array = json.getJSONArray("obj");
			if (array != null && array.size() != 0) {
				for (int i = 0; i < array.size(); i++) {
					BRANDS.add(new BrandEntity(array.getJSONObject(i)));
				}
			}
		}
	}

	/**
	 * 
	 * getSupplier:获取全局供应商信息. <br/>
	 * 
	 * @author hebin
	 * @param token
	 * @return
	 * @since JDK 1.7
	 */
	public static List<SupplierEntity> getSupplier(String token) {
		if (SUPPLIERS.size() == 0) {

			syncSupplier(token);
		}
		return SUPPLIERS;
	}

	/**
	 * syncSupplier:(这里用一句话描述这个方法的作用). <br/>
	 * 
	 * @author hebin
	 * @param token
	 * @since JDK 1.7
	 */
	public static void syncSupplier(String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.SUPPLIER_CENTER_QUERY_ALL, token, true, null,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();
		
		if (index == 0) {
			return;
		}
		
		SUPPLIERS.clear();
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			SUPPLIERS.add(JSONUtilNew.parse(jObj.toString(), SupplierEntity.class));
		}
	}
}
