package com.card.manager.factory.activity.service.impl;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.card.manager.factory.activity.model.BargainActivityModel;
import com.card.manager.factory.activity.service.BargainService;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.URLUtils;

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
}
