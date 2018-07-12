package com.card.manager.factory.goods.service;

import com.card.manager.factory.common.serivce.ServerCenterService;
import com.card.manager.factory.goods.model.GoodsRatioPlatformEntity;
import com.card.manager.factory.system.model.StaffEntity;


public interface GoodsPriceRatioService extends ServerCenterService {


	void addRatioPlatformInfo(GoodsRatioPlatformEntity entity, String token) throws Exception;
	
	GoodsRatioPlatformEntity queryInfoByParam(GoodsRatioPlatformEntity entity, String token);

	void modify(GoodsRatioPlatformEntity entity, StaffEntity staffEntity) throws Exception;

}
