package com.card.manager.factory.auth.service;

import java.util.List;

import com.card.manager.factory.auth.model.AuthInfo;
import com.card.manager.factory.auth.model.FuncEntity;
import com.card.manager.factory.base.Pagination;
import com.github.pagehelper.Page;

/**
 * 
 * @author 贺斌
 * @datetime 2016年7月27日
 * @func 功能模块管理
 */
public interface FuncMngService {

	/**
	 * 根据操作员信息进行功能控制
	 * 
	 * @param id
	 * @return
	 */
	List<AuthInfo> queryFuncByOptId(String id);
	
	public Page<FuncEntity> queryParentFunc(Pagination pagination);

}
