package com.card.manager.factory.auth.mapper;

import java.util.List;
import java.util.Map;

import com.card.manager.factory.base.BaseMapper;
import com.github.pagehelper.Page;

/**
 * 
 * @author 贺斌
 *
 */
public interface FuncEntityMapper<T> extends BaseMapper<T> {

	public List<T> queryByParams(Map<String,Object> params);
	
	public Page<T> queryParentFunc();
	
}
