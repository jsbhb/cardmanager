package com.card.manager.factory.auth.mapper;

import java.util.List;
import java.util.Map;

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
	
	/**
	 * 查找所有登陆信息
	 * 
	 * @param params
	 */
	List<AuthInfo> selectFunc();

	/**
	 * 
	 * queryFuncById:根据编号查询菜单. <br/>
	 * 
	 * @author hebin
	 * @return
	 * @since JDK 1.7
	 */
	AuthInfo selectFuncById(String id);

	/**
	 * 
	 * deleteFuncById:删除指定菜单. <br/>
	 * 
	 * @author hebin
	 * @param id
	 * @since JDK 1.7
	 */
	void deleteFuncById(String id);

	/**
	 * 
	 * updateFunc:更新菜单. <br/>
	 * 
	 * @author hebin
	 * @param authInfo
	 * @since JDK 1.7
	 */
	void updateFunc(AuthInfo authInfo);
	
	/**
	 * 
	 * insertFunc:插入新菜单. <br/>   
	 *  
	 * @author hebin 
	 * @param authInfo  
	 * @since JDK 1.7
	 */
	void insertFunc(AuthInfo authInfo);
	
	/**
	 * 
	 * selectFuncByRoleId:根据角色查询功能. <br/>   
	 *  
	 * @author hebin 
	 * @return  
	 * @since JDK 1.7
	 */
	List<AuthInfo> selectFuncByRoleId(int roleId);
	
	/**
	 * 
	 * selectFuncByRoleId:根据角色查询功能. <br/>   
	 *  
	 * @author hebin 
	 * @return  
	 * @since JDK 1.7
	 */
	List<AuthInfo> selectFuncByRoleIdParam(Map<String, Object> params);
	
	void insertRoleFunc(String funcId);

}
