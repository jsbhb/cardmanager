/**  
 * Project Name:cardmanager  
 * File Name:CachePoolComponent.java  
 * Package Name:com.card.manager.factory.common.component  
 * Date:Nov 14, 20178:25:52 PM  
 *  
 */
package com.card.manager.factory.component;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.component.model.GradeBO;
import com.card.manager.factory.goods.grademodel.GradeTypeDTO;
import com.card.manager.factory.goods.model.BrandEntity;
import com.card.manager.factory.goods.model.FirstCatalogEntity;
import com.card.manager.factory.goods.model.SecondCatalogEntity;
import com.card.manager.factory.goods.model.TagFuncEntity;
import com.card.manager.factory.goods.model.ThirdCatalogEntity;
import com.card.manager.factory.order.model.PushUser;
import com.card.manager.factory.order.model.UserDetail;
import com.card.manager.factory.supplier.model.SupplierEntity;
import com.card.manager.factory.system.model.CustomerTypeEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.service.StaffMngService;
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

@Component
public class CachePoolComponent {

	private static List<BrandEntity> BRANDS = new ArrayList<BrandEntity>();
	private static List<SupplierEntity> SUPPLIERS = new ArrayList<SupplierEntity>();
	private static List<StaffEntity> CENTERS = new ArrayList<StaffEntity>();
	private static List<StaffEntity> SHOPS = new ArrayList<StaffEntity>();
	private static List<StaffEntity> GRADEPERSONINCHARGE = new ArrayList<StaffEntity>();
	private static List<PushUser> PUSHUSER = new ArrayList<PushUser>();
	private static List<UserDetail> CUSTOMER = new ArrayList<UserDetail>();
	private static List<FirstCatalogEntity> FIRSTCATALOG = new ArrayList<FirstCatalogEntity>();
	private static List<SecondCatalogEntity> SECONDCATALOG = new ArrayList<SecondCatalogEntity>();
	private static List<ThirdCatalogEntity> THIRDCATALOG = new ArrayList<ThirdCatalogEntity>();
	private static List<TagFuncEntity> TAGFUNC = new ArrayList<TagFuncEntity>();
	private static Map<Integer, GradeBO> GRADEMAP = new HashMap<Integer, GradeBO>();
	private static Map<Integer, GradeTypeDTO> GRADE_TYPE_CACHE = new HashMap<Integer, GradeTypeDTO>();
	private static List<CustomerTypeEntity> CUSTOMERTYPE = new ArrayList<CustomerTypeEntity>();

	private static String HEAD = "1";
	private static String CENTER = "2";
	private static String SHOP = "3";

	@Resource
	StaffMngService staffMngService;

	private static CachePoolComponent component;

	@PostConstruct
	public void init() {
		component = this;
	}

	/**
	 * @fun 获取grade信息
	 * @param token
	 * @return
	 */
	public static Map<Integer, GradeBO> getGrade(String token) {
		if (GRADEMAP.size() == 0) {
			syncGrade(token);
		}
		return GRADEMAP;
	}

	/**
	 * @fun 获取grade信息
	 * @param token
	 */
	private static void syncGrade(String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_ALL_GRADE, token, true, null,
				HttpMethod.GET);

		JSONArray obj = JSONArray.fromObject(query_result.getBody());

		int index = obj.size();

		if (index == 0) {
			return;
		}
		GRADEMAP.clear();
		GradeBO grade = null;
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			grade = JSONUtilNew.parse(jObj.toString(), GradeBO.class);
			GRADEMAP.put(grade.getId(), grade);
		}

	}
	
	/**
	 * @fun 获取gradeType信息
	 * @param token
	 * @return
	 */
	public static Map<Integer, GradeTypeDTO> getGradeType(String token) {
		if (GRADE_TYPE_CACHE.size() == 0) {
			syncGradeType(token);
		}
		return GRADE_TYPE_CACHE;
	}

	/**
	 * @fun 获取gradeType信息
	 * @param token
	 */
	public static void syncGradeType(String token) {
		RestCommonHelper helper = new RestCommonHelper();
		String url = URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_GRADE_TYPE;
		ResponseEntity<String> query_result = helper.request(url, token, true, null, HttpMethod.GET);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		JSONArray obj = json.getJSONArray("obj");
		if (obj == null || obj.size() == 0) {
			return;
		}

		GradeTypeDTO gradeType;
		for (int i = 0; i < obj.size(); i++) {
			JSONObject jObj = obj.getJSONObject(i);
			gradeType = JSONUtilNew.parse(jObj.toString(), GradeTypeDTO.class);

			List<GradeTypeDTO> children = gradeType.getChildern();

			capGradeType(children);

			GRADE_TYPE_CACHE.put(gradeType.getId(), gradeType);
		}
	}

	/**
	 * capGradeType:封装客户类型. <br/>
	 * 
	 * @author hebin
	 * @param children
	 * @since JDK 1.7
	 */
	private static void capGradeType(List<GradeTypeDTO> children) {
		if(children == null){
			return;
		}
		for (GradeTypeDTO child : children) {
			GRADE_TYPE_CACHE.put(child.getId(), child);
			capGradeType(child.getChildern());
		}
	}

	public static void addGrade(GradeBO grade) {
		GRADEMAP.put(grade.getId(), grade);
	}

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

		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		if (index == 0) {
			return;
		}

		BRANDS.clear();
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			BRANDS.add(JSONUtilNew.parse(jObj.toString(), BrandEntity.class));
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

	/**
	 * 
	 * getSupplier:获取全局供应商信息. <br/>
	 * 
	 * @author hebin
	 * @param token
	 * @return
	 * @since JDK 1.7
	 */
	public static List<StaffEntity> getCenter(String token) {
		// if (CENTERS.size() == 0) {
		// syncCenter(token);
		// }
		syncCenter(token);
		return CENTERS;
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
	public static List<StaffEntity> getAllCenter(String token) {
		// if (CENTERS.size() == 0) {
		// syncCenter(token);
		// }
		CENTERS.clear();
		Map<String, String> params = new HashMap<String, String>();
		CENTERS = component.staffMngService.queryByParam(params);
		return CENTERS;
	}

	/**
	 * syncSupplier:(这里用一句话描述这个方法的作用). <br/>
	 * 
	 * @author hebin
	 * @param token
	 * @since JDK 1.7
	 */
	public static void syncCenter(String token) {
		// RestCommonHelper helper = new RestCommonHelper();
		// ResponseEntity<String> query_result = helper.request(
		// URLUtils.get("gateway") +
		// ServerCenterContants.SUPPLIER_CENTER_QUERY_ALL, token, true, null,
		// HttpMethod.POST);
		//
		// JSONObject json = JSONObject.fromObject(query_result.getBody());
		//
		// JSONArray obj = json.getJSONArray("obj");
		// int index = obj.size();
		//
		// if (index == 0) {
		// return;
		// }
		//
		// CENTERS.clear();
		// for (int i = 0; i < index; i++) {
		// JSONObject jObj = obj.getJSONObject(i);
		// CENTERS.add(JSONUtilNew.parse(jObj.toString(), StaffEntity.class));
		// }

		CENTERS.clear();
		Map<String, String> params = new HashMap<String, String>();
		params.put("gradelevel", CENTER);
		CENTERS = component.staffMngService.queryByParam(params);
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
	public static List<StaffEntity> getGradePersoninCharge(String token) {
		// if (GRADEPERSONINCHARGE.size() == 0) {
		// syncGradePersoninCharge(token);
		// }
		syncGradePersoninCharge(token);
		return GRADEPERSONINCHARGE;
	}

	/**
	 * syncSupplier:(这里用一句话描述这个方法的作用). <br/>
	 * 
	 * @author hebin
	 * @param token
	 * @since JDK 1.7
	 */
	public static void syncGradePersoninCharge(String token) {
		// RestCommonHelper helper = new RestCommonHelper();
		// ResponseEntity<String> query_result = helper.request(
		// URLUtils.get("gateway") +
		// ServerCenterContants.SUPPLIER_CENTER_QUERY_ALL, token, true, null,
		// HttpMethod.POST);
		//
		// JSONObject json = JSONObject.fromObject(query_result.getBody());
		//
		// JSONArray obj = json.getJSONArray("obj");
		// int index = obj.size();
		//
		// if (index == 0) {
		// return;
		// }
		//
		// GRADEPERSONINCHARGE.clear();
		// for (int i = 0; i < index; i++) {
		// JSONObject jObj = obj.getJSONObject(i);
		// GRADEPERSONINCHARGE.add(JSONUtilNew.parse(jObj.toString(),
		// StaffEntity.class));
		// }

		GRADEPERSONINCHARGE.clear();
		Map<String, String> params = new HashMap<String, String>();
		params.put("gradelevel", HEAD);
		GRADEPERSONINCHARGE = component.staffMngService.queryByParam(params);
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
	public static List<StaffEntity> getShop(String token) {
		// if (SHOPS.size() == 0) {
		// syncShop(token);
		// }
		syncShop(token);
		return SHOPS;
	}

	/**
	 * syncSupplier:(这里用一句话描述这个方法的作用). <br/>
	 * 
	 * @author hebin
	 * @param token
	 * @since JDK 1.7
	 */
	public static void syncShop(String token) {
		// RestCommonHelper helper = new RestCommonHelper();
		// ResponseEntity<String> query_result = helper.request(
		// URLUtils.get("gateway") +
		// ServerCenterContants.SUPPLIER_CENTER_QUERY_ALL, token, true, null,
		// HttpMethod.POST);
		//
		// JSONObject json = JSONObject.fromObject(query_result.getBody());
		//
		// JSONArray obj = json.getJSONArray("obj");
		// int index = obj.size();
		//
		// if (index == 0) {
		// return;
		// }
		//
		// SHOPS.clear();
		// for (int i = 0; i < index; i++) {
		// JSONObject jObj = obj.getJSONObject(i);
		// SHOPS.add(JSONUtilNew.parse(jObj.toString(), StaffEntity.class));
		// }

		SHOPS.clear();
		Map<String, String> params = new HashMap<String, String>();
		params.put("gradelevel", SHOP);
		SHOPS = component.staffMngService.queryByParam(params);
	}

	/**
	 * 
	 * getBrands:获取全局品牌信息. <br/>
	 * 
	 * @author hebin
	 * @param token
	 * @return
	 * @since JDK 1.7
	 */
	public static List<PushUser> getPushUsers(String token) {
		// if (PUSHUSER.size() == 0) {
		// syncPushUser(token);
		// }
		syncPushUser(token);
		return PUSHUSER;
	}

	/**
	 * syncBrand:服务中心同步品牌信息. <br/>
	 * 
	 * @author hebin
	 * @param token
	 * @since JDK 1.7
	 */
	public static void syncPushUser(String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_ALL_PUSH_USER, token, true, null,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		if (index == 0) {
			return;
		}

		PUSHUSER.clear();
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			PUSHUSER.add(JSONUtilNew.parse(jObj.toString(), PushUser.class));
		}
	}

	/**
	 * 
	 * getBrands:获取全局品牌信息. <br/>
	 * 
	 * @author hebin
	 * @param token
	 * @return
	 * @since JDK 1.7
	 */
	public static List<UserDetail> getCustomers(String token) {
		// if (CUSTOMER.size() == 0) {
		// syncCustomer(token);
		// }
		syncCustomer(token);
		return CUSTOMER;
	}

	/**
	 * syncBrand:服务中心同步品牌信息. <br/>
	 * 
	 * @author hebin
	 * @param token
	 * @since JDK 1.7
	 */
	public static void syncCustomer(String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_ALL_CUSTOMER, token, true, null,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		if (index == 0) {
			return;
		}

		CUSTOMER.clear();
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			CUSTOMER.add(JSONUtilNew.parse(jObj.toString(), UserDetail.class));
		}
	}

	/**
	 * 
	 * getBrands:获取全局品牌信息. <br/>
	 * 
	 * @author hebin
	 * @param token
	 * @return
	 * @since JDK 1.7
	 */
	public static List<FirstCatalogEntity> getFirstCatalog(String token) {
		syncFirstCatalog(token);
		return FIRSTCATALOG;
	}

	/**
	 * syncBrand:服务中心同步品牌信息. <br/>
	 * 
	 * @author hebin
	 * @param token
	 * @since JDK 1.7
	 */
	public static void syncFirstCatalog(String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_QUERY_FIRSR_ALL, token, true, null,
				HttpMethod.GET);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		if (index == 0) {
			return;
		}

		FIRSTCATALOG.clear();
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			FIRSTCATALOG.add(JSONUtilNew.parse(jObj.toString(), FirstCatalogEntity.class));
		}
	}

	/**
	 * 
	 * getBrands:获取全局品牌信息. <br/>
	 * 
	 * @author hebin
	 * @param token
	 * @return
	 * @since JDK 1.7
	 */
	public static List<SecondCatalogEntity> getSecondCatalog(String token) {
		syncSecondCatalog(token);
		return SECONDCATALOG;
	}

	/**
	 * syncBrand:服务中心同步品牌信息. <br/>
	 * 
	 * @author hebin
	 * @param token
	 * @since JDK 1.7
	 */
	public static void syncSecondCatalog(String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_QUERY_SECOND_ALL, token, true, null,
				HttpMethod.GET);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		if (index == 0) {
			return;
		}

		SECONDCATALOG.clear();
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			SECONDCATALOG.add(JSONUtilNew.parse(jObj.toString(), SecondCatalogEntity.class));
		}
	}

	/**
	 * 
	 * getBrands:获取全局品牌信息. <br/>
	 * 
	 * @author hebin
	 * @param token
	 * @return
	 * @since JDK 1.7
	 */
	public static List<ThirdCatalogEntity> getThirdCatalog(String token) {
		syncThirdCatalog(token);
		return THIRDCATALOG;
	}

	/**
	 * syncBrand:服务中心同步品牌信息. <br/>
	 * 
	 * @author hebin
	 * @param token
	 * @since JDK 1.7
	 */
	public static void syncThirdCatalog(String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CATALOG_QUERY_THIRD_ALL, token, true, null,
				HttpMethod.GET);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		if (index == 0) {
			return;
		}

		THIRDCATALOG.clear();
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			THIRDCATALOG.add(JSONUtilNew.parse(jObj.toString(), ThirdCatalogEntity.class));
		}
	}

	/**
	 * 
	 * getBrands:获取全局品牌信息. <br/>
	 * 
	 * @author hebin
	 * @param token
	 * @return
	 * @since JDK 1.7
	 */
	public static List<TagFuncEntity> getTagFuncs(String token) {

		syncTagFunc(token);
		return TAGFUNC;
	}

	/**
	 * syncBrand:服务中心同步品牌信息. <br/>
	 * 
	 * @author hebin
	 * @param token
	 * @since JDK 1.7
	 */
	public static void syncTagFunc(String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_TAG_FUNC_QUERY_ALL, token, true, null,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		if (index == 0) {
			return;
		}

		TAGFUNC.clear();
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			TAGFUNC.add(JSONUtilNew.parse(jObj.toString(), TagFuncEntity.class));
		}
	}
	
	public static List<CustomerTypeEntity> getCustomerType() {
		CUSTOMERTYPE.clear();
		CustomerTypeEntity firstType = new CustomerTypeEntity();
		firstType.setTypeId(1);
		firstType.setTypeName("普通客户");
		CUSTOMERTYPE.add(firstType);
		CustomerTypeEntity secondType = new CustomerTypeEntity();
		secondType.setTypeId(2);
		secondType.setTypeName("对接客户");
		CUSTOMERTYPE.add(secondType);
		CustomerTypeEntity thirdType = new CustomerTypeEntity();
		thirdType.setTypeId(3);
		thirdType.setTypeName("福利客户");
		CUSTOMERTYPE.add(thirdType);
		return CUSTOMERTYPE;
	}
}
