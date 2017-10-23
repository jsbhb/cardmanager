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
	
	
	/**
	 * 查找所有功能模块
	 * 
	 * @return
	 */
	List<AuthInfo> queryFunc();

	/**
	 * 
	 * queryParentFunc:分页查询功能菜单. <br/>
	 * 
	 * @author hebin
	 * @param pagination
	 * @return
	 * @since JDK 1.7
	 */
	public Page<FuncEntity> queryParentFunc(Pagination pagination);

	/**
	 * 
	 * queryFuncById:根据菜单编号查询. <br/>
	 * 
	 * @author hebin
	 * @param id
	 * @return
	 * @since JDK 1.7
	 */
	public AuthInfo queryFuncById(String id);
	
	/**
	 * 
	 * queryFuncById:根据菜单编号查询. <br/>
	 * 
	 * @author hebin
	 * @param id
	 * @return
	 * @since JDK 1.7
	 */
	public List<AuthInfo> queryFuncByRoleId(int roleId);

	/**
	 * 
	 * removeFunc:移除菜单. <br/>
	 * 
	 * @author hebin
	 * @param id
	 * @since JDK 1.7
	 */
	public void removeFunc(String id);

	/**
	 * 
	 * updateFunc:更新菜单. <br/>
	 * 
	 * @author hebin
	 * @param authInfo
	 * @since JDK 1.7
	 */
	public void updateFunc(AuthInfo authInfo);
	
	/**
	 * 
	 * addFunc:新增菜单. <br/>   
	 *  
	 * @author hebin 
	 * @param authInfo  
	 * @since JDK 1.7
	 */
	public void addFunc(AuthInfo authInfo);


	/**  
	 * editFunc:修改菜单. <br/>   
	 *  
	 * @author hebin 
	 * @param authInfo  
	 * @since JDK 1.7  
	 */
	public void editFunc(AuthInfo authInfo);

}
