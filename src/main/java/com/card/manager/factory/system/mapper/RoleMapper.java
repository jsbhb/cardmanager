/**  
 * Project Name:cardmanager  
 * File Name:RoleMapper.java  
 * Package Name:com.card.manager.factory.system.mapper  
 * Date:Oct 18, 20175:54:49 PM  
 *  
 */
package com.card.manager.factory.system.mapper;

import java.util.List;
import java.util.Map;

import com.card.manager.factory.base.BaseMapper;
import com.card.manager.factory.system.model.GradeTypeRole;
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
	 * queryList:分页查询. <br/>   
	 *  
	 * @author hebin 
	 * @param params
	 * @return  
	 * @since JDK 1.7
	 */
	List<T> queryNormal();
	
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

	/**  
	 * insertGradeTypeRole:(这里用一句话描述这个方法的作用). <br/>   
	 *  
	 * @author hebin 
	 * @param gtr  
	 * @since JDK 1.7  
	 */
	void insertGradeTypeRole(GradeTypeRole gtr);

	/**  
	 * getRoleIdByGradeTypeId:(这里用一句话描述这个方法的作用). <br/>   
	 *  
	 * @author hebin 
	 * @param gradeType
	 * @return  
	 * @since JDK 1.7  
	 */
	Integer getRoleIdByGradeTypeId(Integer gradeTypeId);

	/**  
	 * updateByGradeTypeId:(这里用一句话描述这个方法的作用). <br/>   
	 *  
	 * @author hebin 
	 * @param id  
	 * @since JDK 1.7  
	 */
	void updateByGradeTypeId(GradeTypeRole role);


}
