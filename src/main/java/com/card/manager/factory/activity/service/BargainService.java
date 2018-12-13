package com.card.manager.factory.activity.service;

import java.util.List;

import com.card.manager.factory.activity.model.BargainActivityModel;
import com.card.manager.factory.activity.model.BargainActivityShowPageModel;

public interface BargainService {

	void insertBargainActivity(BargainActivityModel model, String token) throws Exception;
	
	BargainActivityModel queryBargainActivityInfoByParam(BargainActivityModel model, String token);

	void updateBargainActivity(BargainActivityModel model, String token) throws Exception;
	
	List<BargainActivityShowPageModel> queryBargainActivityShowPageInfo(BargainActivityModel model, String token);
}
