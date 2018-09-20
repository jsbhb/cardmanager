package com.card.manager.factory.express.mapper;

import java.util.List;
import java.util.Map;

import com.card.manager.factory.base.BaseMapper;
import com.github.pagehelper.Page;

public interface ExpressMapper<T> extends BaseMapper<T>{
	
	Page<T> queryList(Map<String,Object> params);
	
	List<T> queryAllDeliveryInfo();
	
}
