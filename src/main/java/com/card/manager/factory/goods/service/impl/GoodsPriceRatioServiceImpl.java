package com.card.manager.factory.goods.service.impl;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.card.manager.factory.annotation.Log;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.goods.model.GoodsRatioPlatformEntity;
import com.card.manager.factory.goods.service.GoodsPriceRatioService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONObject;

@Service
public class GoodsPriceRatioServiceImpl extends AbstractServcerCenterBaseService implements GoodsPriceRatioService {


	@Override
	@Log(content = "新增比价平台信息操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void addRatioPlatformInfo(GoodsRatioPlatformEntity entity, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CREATE_GOODS_RATIO_PLATFORM_INFO, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("新增比价平台信息操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public GoodsRatioPlatformEntity queryInfoByParam(GoodsRatioPlatformEntity entity, String token) {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_QUERY_GOODS_RATIO_PLATFORM_INFO, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), GoodsRatioPlatformEntity.class);
	}

	@Override
	@Log(content = "更新比价平台信息操作", source = Log.BACK_PLAT, type = Log.MODIFY)
	public void modify(GoodsRatioPlatformEntity entity, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_UPDATE_GOODS_RATIO_PLATFORM_INFO, staffEntity.getToken(), true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("更新比价平台信息操作失败:" + json.getString("errorMsg"));
		}
	}

}
