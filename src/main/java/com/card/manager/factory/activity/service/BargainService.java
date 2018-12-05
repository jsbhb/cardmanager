package com.card.manager.factory.activity.service;

import com.card.manager.factory.activity.model.BargainActivityModel;

public interface BargainService {

	void insertBargainActivity(BargainActivityModel model, String token) throws Exception;
	
	BargainActivityModel queryBargainActivityInfoByParam(BargainActivityModel model, String token);

	void updateBargainActivity(BargainActivityModel model, String token) throws Exception;
}
