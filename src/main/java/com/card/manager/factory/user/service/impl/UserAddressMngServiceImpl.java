package com.card.manager.factory.user.service.impl;

import java.util.Map;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.user.service.UserAddressMngService;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONObject;

@Service
public class UserAddressMngServiceImpl extends AbstractServcerCenterBaseService implements UserAddressMngService {

	@Override
	public void deleteUserAddress(Map<String,Object> params, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_DELETE_USER_ADDRESSINFO, token, true,
				null, HttpMethod.DELETE, params);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("删除用户收货地址失败:" + json.getString("errorMsg"));
		}
	}
}
