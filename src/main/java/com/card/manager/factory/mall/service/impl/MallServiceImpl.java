/**  
 * Project Name:cardmanager  
 * File Name:MallServiceImpl.java  
 * Package Name:com.card.manager.factory.mall.service.impl  
 * Date:Jan 2, 20184:01:07 PM  
 *  
 */
package com.card.manager.factory.mall.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.card.manager.factory.annotation.Log;
import com.card.manager.factory.common.ResourceContants;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.goods.model.DictData;
import com.card.manager.factory.goods.model.Layout;
import com.card.manager.factory.goods.model.PopularizeDict;
import com.card.manager.factory.mall.pojo.BigSalesGoodsRecord;
import com.card.manager.factory.mall.pojo.ComponentData;
import com.card.manager.factory.mall.pojo.FloorDictPojo;
import com.card.manager.factory.mall.service.MallService;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * ClassName: MallServiceImpl <br/>
 * date: Jan 2, 2018 4:01:07 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
@Service
public class MallServiceImpl extends AbstractServcerCenterBaseService implements MallService {

	@Override
	public PopularizeDict queryById(String id, int centerId, String token) {
		PopularizeDict entity = new PopularizeDict();
		entity.setId(Integer.parseInt(id));
		if (centerId == 0) {
			entity.setCenterId(2);
		} else {
			entity.setCenterId(centerId);
		}

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_MALL_QUERY_DICT, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), PopularizeDict.class);
	}

	@Override
	public DictData queryDataById(String id, int gradeId, String token) {
		DictData data = new DictData();
		data.setId(Integer.parseInt(id));
		if (gradeId == 0) {
			data.setCenterId(2);
		} else {
			data.setCenterId(gradeId);
		}

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_MALL_QUERY_DATA, token, true, data,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), DictData.class);
	}

	@Override
	@Log(content = "删除楼层商品操作", source = Log.BACK_PLAT, type = Log.DELETE)
	public void delateData(String id, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_MALL_DELETE_DATA, token, true, id,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("删除楼层商品操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	@Log(content = "新增楼层信息操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void addDict(FloorDictPojo pojo, String token) throws Exception {

		PopularizeDict dict = new PopularizeDict();
		dict.setName(pojo.getName());
		dict.setEnname(pojo.getEnname());
		dict.setPicPath1(pojo.getPicPath1());
		dict.setOpt(pojo.getOpt());
		dict.setType(4);
		dict.setCenterId(pojo.getCenterId());
		dict.setFirstCategory(pojo.getFirstCatalogId());

		Layout layout = new Layout();
		layout.setPage("index");

		if (pojo.getPageType() == 1) {
			layout.setCode("module_00009");
		} else {
			layout.setCode("module_00024");
		}

		layout.setDescription(dict.getName());
		layout.setShow(pojo.getShow());
		layout.setPageType(pojo.getPageType());
		layout.setType(pojo.getType());
		layout.setType(0);
		layout.setSort(pojo.getSort());

		dict.setLayout(layout);

		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_MALL_SAVE_DICT, token, true, dict,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("新增楼层信息操作失败:" + json.getString("errorMsg"));
		} else {
			String dictId = json.getString("errorMsg");
			if (dictId == null || "".equals(dictId)) {
				throw new Exception("新增楼层时重命名目录操作失败，请联系技术");
			}
			String tmpPicPath = pojo.getPicPath1();
			tmpPicPath = tmpPicPath.substring(tmpPicPath.indexOf("tmp"),
					tmpPicPath.indexOf("/", tmpPicPath.indexOf("tmp")));
			String oldPicPath = pojo.getPicPath1()
					.substring(0, pojo.getPicPath1().indexOf("/", pojo.getPicPath1().indexOf(tmpPicPath)))
					.replace(URLUtils.get("static"), ResourceContants.RESOURCE_BASE_PATH);
			tmpPicPath = oldPicPath + "|" + oldPicPath.replace(tmpPicPath, dictId);
			pojo.setPicPath1(tmpPicPath);
		}
	}

	@Override
	@Log(content = "新增楼层商品操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void addData(DictData data, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_MALL_SAVE_DATA, token, true, data,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("新增楼层商品操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	@Log(content = "删除楼层信息操作", source = Log.BACK_PLAT, type = Log.DELETE)
	public void delateDict(String id, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_MALL_DELETE_DICT, token, true, id,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("删除楼层信息操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	@Log(content = "初始化楼层信息操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void initDict(PopularizeDict dict, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_MALL_INIT_DICT, token, true, dict,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("初始化楼层信息操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public List<DictData> queryDataAll(Layout layout, String token) throws Exception {
		if (!ServerCenterContants.TOKEN_NOT_NEED) {
			if (token == null || "".equals(token)) {
				throw new Exception("无令牌信息");
			}
		}

		// 调用权限中心 验证是否可以登录
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_MALL_QUERY_DATA_ALL, token, true, layout,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(result.getBody());

		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		if (index == 0) {
			return null;
		}

		List<DictData> list = new ArrayList<DictData>();
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			list.add(JSONUtilNew.parse(jObj.toString(), DictData.class));
		}
		return list;
	}

	@Override
	@Log(content = "更新楼层商品信息操作", source = Log.BACK_PLAT, type = Log.MODIFY)
	public void updateData(DictData data, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_MALL_UPDATE_DATA, token, true, data,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("更新楼层商品信息操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	@Log(content = "更新楼层信息操作", source = Log.BACK_PLAT, type = Log.MODIFY)
	public void updateDict(PopularizeDict dict, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_MALL_UPDATE_DICT, token, true, dict,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("更新楼层信息操作失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	public List<ComponentData> queryComponentDataByPageId(String pageId, String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_MALL_QUERY_COMPONENTDATA_BY_PAGEID+"?pageId="+pageId, token, true, null,
				HttpMethod.POST);
		JSONObject json = JSONObject.fromObject(query_result.getBody());
		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();
		if (index == 0) {
			return null;
		}
		List<ComponentData> list = new ArrayList<ComponentData>();
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			list.add(JSONUtilNew.parse(jObj.toString(), ComponentData.class));
		}
		return list;
	}

	@Override
	@Log(content = "更新活动楼层商品信息操作", source = Log.BACK_PLAT, type = Log.MODIFY)
	public void updateComponentData(ComponentData data, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_MALL_UPDATE_COMPONENTDATA, token, true, data,
				HttpMethod.POST);
		JSONObject json = JSONObject.fromObject(result.getBody());
		if (!json.getBoolean("success")) {
			throw new Exception("更新活动楼层商品信息操作失败:" + json.getString("errorMsg"));
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	@Log(content = "更新活动楼层商品信息操作", source = Log.BACK_PLAT, type = Log.MODIFY)
	public void mergeInfoToBigSale(List<BigSalesGoodsRecord> list, String token) throws Exception {
		Map<String, String>  rebateMap = null;
		for(BigSalesGoodsRecord bsgr:list) {
			RestCommonHelper helper = new RestCommonHelper();
			String url = URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_GET_REBATE + "?itemId=" + bsgr.getItemId();
			ResponseEntity<String> query_result = helper.request(url, token, true, null, HttpMethod.GET);

			JSONObject json = JSONObject.fromObject(query_result.getBody());
			rebateMap = JSONUtilNew.parse(json.getJSONObject("obj").toString(), Map.class);
			String rebateStr = rebateMap.get("2");
			bsgr.setOldRebate(Double.valueOf(rebateStr == null ? "0" : rebateStr));
			
			SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
			Date date = dateFormatter.parse(bsgr.getStartTime());
			Calendar cDate = Calendar.getInstance();
			cDate.setFirstDayOfWeek(Calendar.MONDAY);
			cDate.setTime(date);
			int typeWeek  = cDate.get(Calendar.WEEK_OF_YEAR);
			int typeDay  = cDate.get(Calendar.DAY_OF_YEAR);
			int typeYear  = cDate.get(Calendar.YEAR);
			if (typeWeek == 1 && typeDay > 7) {
				typeYear += 1;
			}
//			dateFormatter.applyPattern("w");
//			bsgr.setWeek(Integer.parseInt(dateFormatter.format(date)));
//			dateFormatter.applyPattern("y");
//			bsgr.setYear(Integer.parseInt(dateFormatter.format(date)));
			bsgr.setWeek(typeWeek);
			bsgr.setYear(typeYear);
		}
		
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_MALL_MERGE_BIGSALEDATA, token, true, list,
				HttpMethod.POST);
		JSONObject json = JSONObject.fromObject(result.getBody());
		if (!json.getBoolean("success")) {
			throw new Exception("更新活动楼层商品信息操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public List<BigSalesGoodsRecord> queryBigSaleData(String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_MALL_QUERY_BIGSALEDATA, token, true, null,
				HttpMethod.POST);
		JSONObject json = JSONObject.fromObject(query_result.getBody());
		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();
		if (index == 0) {
			return null;
		}
		List<BigSalesGoodsRecord> list = new ArrayList<BigSalesGoodsRecord>();
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			list.add(JSONUtilNew.parse(jObj.toString(), BigSalesGoodsRecord.class));
		}
		return list;
	}
}
