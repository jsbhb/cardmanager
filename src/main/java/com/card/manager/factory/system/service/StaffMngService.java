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
import com.card.manager.factory.system.exception.OperatorSaveException;
import com.card.manager.factory.system.exception.SyncUserCenterException;
import com.card.manager.factory.system.model.StaffEntity;
import com.github.pagehelper.Page;

/**
 * ClassName: GradeMngService <br/>
 * Function: 员工管理服务类 <br/>
 * date: Sep 17, 2017 2:52:45 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public interface StaffMngService {

	/**
	 * 
	 * queryByLoginInfo:查询登陆信息. <br/>
	 * 
	 * @author hebin
	 * @param userName
	 * @param pwd
	 * @return
	 * @since JDK 1.7
	 */
	StaffEntity queryByLoginInfo(String userName, String pwd);

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
	Page<StaffEntity> dataList(Pagination pagination, Map<String, Object> params);

	/**
	 * queryById:根据Id查询员工实体类. <br/>
	 * 
	 * @author hebin
	 * @param roleId
	 * @return
	 * @since JDK 1.7
	 */
	StaffEntity queryById(int optId);

	/**
	 * 
	 * sync:用户中心同步用户. <br/>
	 * 
	 * @author hebin
	 * @param entity
	 * @param phone
	 * @since JDK 1.7
	 */
	void sync(int optId, String phone) throws Exception;

	/**
	 * addStaff:新增员工. <br/>
	 * 
	 * @author hebin
	 * @param role
	 * @since JDK 1.7
	 */
	void addStaff(StaffEntity staff) throws OperatorSaveException,SyncUserCenterException;

	/**
	 * modifyStaff:编辑. <br/>
	 * 
	 * @author hebin
	 * @param role
	 * @since JDK 1.7
	 */
	void modifyStaff(StaffEntity staff);
	
	void modifyPwd(String userName, String pwd);

	/**
	 * 
	 * sync:权限中心开通账号. <br/>
	 * 
	 * @author hebin
	 * @param entity
	 * @param phone
	 * @since JDK 1.7
	 */
	void sync2B(StaffEntity staff,int optId) throws Exception;

	/**
	 * 
	 * sync:权限中心开通账号. <br/>
	 * 
	 * @author hebin
	 * @param entity
	 * @param phone
	 * @since JDK 1.7
	 */
	void sync2S(StaffEntity staff,int optId) throws Exception;
	
	/**
	 * 
	 * queryByParam<br/>
	 * 
	 * @author hebin
	 * @param userName
	 * @param pwd
	 * @return
	 * @since JDK 1.7
	 */
	List<StaffEntity> queryByParam(Map<String, String> params);
}
