package com.card.manager.manager.factory.redis.mapper;

import java.util.List;

import com.card.manager.factory.base.BaseMapper;

public interface ForRedisMapper<T> extends BaseMapper<T>{
	
	public List<String> queryFromOrder();
	
	public List<String> queryFromAsn();
	
	public List<String> queryExternalNo();
}
