/**  
 * Project Name:cardmanager  
 * File Name:GradeMngService.java  
 * Package Name:com.card.manager.factory.system.service  
 * Date:Sep 17, 20172:52:45 PM  
 *  
 */
package com.card.manager.factory.system.service;

import java.util.List;
import java.util.Map;

import com.card.manager.factory.base.Pagination;
import com.card.manager.factory.system.model.RoleEntity;
import com.github.pagehelper.Page;

/**  
 * ClassName: GradeMngService <br/>  
 * Function: 分级管理服务类 <br/>   
 * date: Sep 17, 2017 2:52:45 PM <br/>  
 *  
 * @author hebin  
 * @version   
 * @since JDK 1.7  
 */
public interface RoleMngService {
	
	/**
	 * 
	 * dataList:分页查询. <br/>   
	 *  
	 * @author hebin 
	 * @param pagination
	 * @param params
	 * @return  
	 * @since JDK 1.7
	 */
	Page<RoleEntity> dataList(Pagination pagination,Map<String,Object> params);
	
	/**
	 * 
	 * queryList:查询. <br/>   
	 *  
	 * @author hebin 
	 * @return  
	 * @since JDK 1.7
	 */
	List<RoleEntity> queryAll();
	
	List<RoleEntity> queryAllRole();

	/**  
	 * queryById:根据Id查询角色实体类. <br/>   
	 *  
	 * @author hebin 
	 * @param roleId
	 * @return  
	 * @since JDK 1.7  
	 */
	RoleEntity queryById(int roleId);

	/**  
	 * addFunc:新增角色. <br/>   
	 *  
	 * @author hebin 
	 * @param role  
	 * @since JDK 1.7  
	 */
	void addRole(RoleEntity role);
	
	
	/**  
	 * modifyRole:新增角色. <br/>   
	 *  
	 * @author hebin 
	 * @param role  
	 * @since JDK 1.7  
	 */
	void modifyRole(RoleEntity role);

	/**  
	 * edit:编辑角色. <br/>   
	 * needUpdateFunc:是否需要更新权限功能. <br/>
	 *  
	 * @author hebin 
	 * @param role  
	 * @since JDK 1.7  
	 */
	void edit(RoleEntity role,boolean needUpdateFunc) throws Exception;

	/**  
	 * getRoleIdByGradeTypeId:(这里用一句话描述这个方法的作用). <br/>   
	 *  
	 * @author hebin 
	 * @param id  
	 * @since JDK 1.7  
	 */
	Integer getRoleIdByGradeTypeId(Integer id);
	
	

}
