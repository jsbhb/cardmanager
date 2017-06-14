package com.card.manager.factory.auth.mapper;

import java.util.List;

import com.card.manager.factory.auth.model.AuthInfo;
import com.card.manager.factory.base.BaseMapper;

/**
 * 
 * @author 贺斌
 * @datetime 2016年7月27日
 * @func
 */
public interface FuncMapper<T> extends BaseMapper<T> {

	/**
	 * 根据登陆信息查詢功能列表
	 * 
	 * @param params
	 */
	List<AuthInfo> queryFuncByOptId(String id);
}
