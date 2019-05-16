package com.card.manager.factory.info.service;

import com.card.manager.factory.info.model.NewsModel;
import com.card.manager.factory.system.model.StaffEntity;

public interface InfoService {

	void saveAndPublishNews(NewsModel model, StaffEntity entity) throws Exception;
}
