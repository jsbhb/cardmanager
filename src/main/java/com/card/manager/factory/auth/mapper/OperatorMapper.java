package com.card.manager.factory.auth.mapper;

import java.util.Map;

import com.card.manager.factory.auth.model.Operator;
import com.card.manager.factory.base.BaseMapper;

/**
 * 
 * @author 贺斌
 * @datetime 2016年7月27日
 * @func
 */
public interface OperatorMapper<T> extends BaseMapper<T> {

	/**
	 * 根據登陸信息查詢操作人員
	 * 
	 * @param params
	 */
	Operator selectByLoginInfo(Map<String, String> params);
}
