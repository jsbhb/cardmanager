package com.card.manager.factory.user.service;

import java.util.Map;

import com.card.manager.factory.common.serivce.ServerCenterService;

public interface UserAddressMngService extends ServerCenterService {
	
	void deleteUserAddress(Map<String,Object> params, String token) throws Exception;
}
