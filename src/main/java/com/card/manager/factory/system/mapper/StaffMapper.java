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
import com.card.manager.factory.order.model.OperatorEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.github.pagehelper.Page;

/**  
 * ClassName: StaffMapper <br/>  
 * Function: 员工实体操作类. <br/>   
 * date: Oct 18, 2017 5:54:49 PM <br/>  
 *  
 * @author hebin  
 * @version   
 * @since JDK 1.7  
 */
public interface StaffMapper<T> extends BaseMapper<T>{
	
	/**
	 * 
	 * selectByLoginInfo:查询登陆信息. <br/>   
	 *  
	 * @author hebin 
	 * @param params
	 * @return  
	 * @since JDK 1.7
	 */
	StaffEntity selectByLoginInfo(Map<String, String> params);
	
	/**  
	 * selectByOptId:根据操作者编号查询操作者. <br/>   
	 *  
	 * @author hebin 
	 * @param optId
	 * @return  
	 * @since JDK 1.7  
	 */
	T selectByOptId(int optId);
	
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
	int insert(T t);
	

	/**  
	 * deleteStaff:删除员工. <br/>   
	 *  
	 * @author hebin 
	 * @param roleId  
	 * @since JDK 1.7  
	 */
	void deleteStaff(int roleId);

	/**  
	 * updateUserCenterId:更新用户中心编号. <br/>   
	 *  
	 * @author hebin 
	 * @param staffeEntity  
	 * @since JDK 1.7  
	 */
	void updateUserCenterId(T t);

	/**  
	 * nextVal:查找下个id. <br/>   
	 *  
	 * @author hebin 
	 * @param gradeId
	 * @return  
	 * @since JDK 1.7  
	 */
	int nextVal(String gradeId);

	/**  
	 * insertRoleOpt:角色编号表插入. <br/>   
	 *  
	 * @author hebin 
	 * @param optId
	 * @param roleId  
	 * @since JDK 1.7  
	 */
	void insertRoleOpt(T t);

	/**  
	 * insertNextVal:(这里用一句话描述这个方法的作用). <br/>   
	 *  
	 * @author hebin 
	 * @param parseInt  
	 * @since JDK 1.7  
	 */
	void insertNextVal(int parseInt);

	void updatePwd(Map<String, String> params);

	/**  
	 * updateUserCenterId:更新用户中心编号. <br/>   
	 *  
	 * @author hebin 
	 * @param staffeEntity  
	 * @since JDK 1.7  
	 */
	void update2BFlg(T t);
	
	/**
	 * 
	 * selectByLoginInfo:查询登陆信息. <br/>   
	 *  
	 * @author hebin 
	 * @param params
	 * @return  
	 * @since JDK 1.7
	 */
	List<OperatorEntity> selectOperatorInfoByOpt(StaffEntity staff);

	/**  
	 * updateUserCenterId:更新用户中心编号. <br/>   
	 *  
	 * @author hebin 
	 * @param staffeEntity  
	 * @since JDK 1.7  
	 */
	void update2SFlg(T t);
}
