package com.card.manager.factory.redis.service;

/**
 * 
 * @author 贺斌
 * @datetime 2016年7月17日
 * @func
 */
public interface RedisBaseService<T> {

	/**
	 * 新增对象
	 * 
	 * @param object
	 */
	void add(T object);

	/**
	 * 根据key值获取redis对象
	 * 
	 * @param key
	 * @return
	 */
	T get(String key);
	
	void del(String key);

}
