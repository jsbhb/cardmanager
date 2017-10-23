/**  
 * Project Name:cardmanager  
 * File Name:RoleMapper.java  
 * Package Name:com.card.manager.factory.system.mapper  
 * Date:Oct 18, 20175:54:49 PM  
 *  
 */
package com.card.manager.factory.system.mapper;

import java.util.Map;

import com.card.manager.factory.base.BaseMapper;
import com.github.pagehelper.Page;

/**  
 * ClassName: RoleMapper <br/>  
 * Function: TODO ADD FUNCTION. <br/>   
 * date: Oct 18, 2017 5:54:49 PM <br/>  
 *  
 * @author hebin  
 * @version   
 * @since JDK 1.7  
 */
public interface RoleMapper<T> extends BaseMapper<T>{
	
	/**
	 * 
	 * queryList:分页查询. <br/>   
	 *  
	 * @author hebin 
	 * @param params
	 * @return  
	 * @since JDK 1.7
	 */
	Page<T> queryList(Map<String,Object> params);
	
	/**
	 * 
	 * insert:插入. <br/>   
	 *  
	 * @author hebin 
	 * @param t  
	 * @since JDK 1.7
	 */
	void insert(T t);
	
	/**
	 * 
	 * insertRoleFunc:插入权限. <br/>   
	 *  
	 * @author hebin 
	 * @param param  
	 * @since JDK 1.7
	 */
	void insertRoleFunc(Map<String,Object> param);

	/**  
	 * deleteAllFunc:删除该角色所有功能. <br/>   
	 *  
	 * @author hebin 
	 * @param roleId  
	 * @since JDK 1.7  
	 */
	void deleteAllFunc(int roleId);

}
