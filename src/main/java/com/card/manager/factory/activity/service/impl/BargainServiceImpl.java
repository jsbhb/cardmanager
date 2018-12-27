package com.card.manager.factory.activity.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.card.manager.factory.activity.model.BargainActivityModel;
import com.card.manager.factory.activity.model.BargainActivityShowPageModel;
import com.card.manager.factory.activity.model.BargainActivityShowPageRecordModel;
import com.card.manager.factory.activity.service.BargainService;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class BargainServiceImpl implements BargainService {

	@Override
	public void insertBargainActivity(BargainActivityModel model, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_SAVE_BARGAIN_ACTIVITY_INFO, token, true, model,
				HttpMethod.POST);
		JSONObject json = JSONObject.fromObject(result.getBody());
		if (!json.getBoolean("success")) {
			throw new Exception("创建活动操作失败:" + json.getString("errorMsg"));
		}
	}
	
	@Override
	public BargainActivityModel queryBargainActivityInfoByParam(BargainActivityModel model, String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_SHOW_BARGAIN_ACTIVITY_INFO, token, true, model,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), BargainActivityModel.class);
	}
	
	@Override
	public void updateBargainActivity(BargainActivityModel model, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_MODIFY_BARGAIN_ACTIVITY_INFO, token, true, model,
				HttpMethod.POST);
		JSONObject json = JSONObject.fromObject(result.getBody());
		if (!json.getBoolean("success")) {
			throw new Exception("更新活动信息操作失败:" + json.getString("errorMsg"));
		}

	}
	
	@Override
	public List<BargainActivityShowPageModel> queryBargainActivityShowPageInfo(BargainActivityModel model, String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_SHOW_BARGAIN_ACTIVITY_SHOW_PAGE_INFO, token, true, model,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(result.getBody());
		List<BargainActivityShowPageModel> list = new ArrayList<BargainActivityShowPageModel>();
		if (!json.getBoolean("success") || !json.has("obj")) {
			return list;
		}
		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			list.add(JSONUtilNew.parse(jObj.toString(), BargainActivityShowPageModel.class));
		}
		return list;
	}
	
	@Override
	public Map<String, Object> pickBargainActivityShowPageInfo(BargainActivityModel BAModel, String token,Integer totalAllCount,Integer totalBargainCount,Integer totalBuyCount) {
		List<BargainActivityShowPageModel> showPageInfoList = queryBargainActivityShowPageInfo(BAModel,token);
		for (BargainActivityShowPageModel model : showPageInfoList) {
			if (model.getRecordList() != null) {
				totalAllCount += model.getRecordList().size();
				for(BargainActivityShowPageRecordModel record : model.getRecordList()) {
					if (record.isBuy()) {
						totalBuyCount += 1;
						model.setBuyCount(model.getBuyCount() + 1);
					} else {
						totalBargainCount += 1;
					}
					if (record.getName() == null || "".equals(record.getName())) {
						if (record.getNickName() != null && !"".equals(record.getNickName())) {
							record.setName(record.getNickName());
						} else {
							record.setName(record.getUserId());
						}
					}
				}
			}
		}
		Map<String, Object> context = new HashMap<String, Object>();
		context.put("totalAllCount", totalAllCount);
		context.put("totalBargainCount", totalBargainCount);
		context.put("totalBuyCount", totalBuyCount);
		context.put("showPageInfoList", showPageInfoList);
		return context;
	}
}
