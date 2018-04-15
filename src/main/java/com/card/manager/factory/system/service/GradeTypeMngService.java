/**  
 * Project Name:cardmanager  
 * File Name:GradeMngService.java  
 * Package Name:com.card.manager.factory.system.service  
 * Date:Sep 17, 20172:52:45 PM  
 *  
 */
package com.card.manager.factory.system.service;

import com.card.manager.factory.common.serivce.ServerCenterService;
import com.card.manager.factory.system.model.GradeEntity;
import com.card.manager.factory.system.model.GradeTypeEntity;
import com.card.manager.factory.system.model.StaffEntity;

/**
 * ClassName: GradeMngService <br/>
 * Function: 分级管理服务类 <br/>
 * date: Sep 17, 2017 2:52:45 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public interface GradeTypeMngService extends ServerCenterService {


	/**
	 * saveGrade:新增分级类型. <br/>
	 * 
	 * @author hebin
	 * @param gradeInfo
	 *            分级信息
	 * @param token
	 *            令牌
	 * @since JDK 1.7
	 */
	void save(GradeTypeEntity entity, StaffEntity staff) throws Exception;


	/**
	 * queryById:根据分级类型编号查询分级信息. <br/>
	 * 
	 * @author hebin
	 * @return
	 * @since JDK 1.7
	 */
	GradeTypeEntity queryById(String id, String token);

	/**
	 * update:更新分级类型. <br/>
	 * 
	 * @author hebin
	 * @param gradeInfo
	 * @param staffEntity
	 * @since JDK 1.7
	 */
	void update(GradeTypeEntity entity, StaffEntity staffEntity) throws Exception;
	
	
	/**
	 * update:删除. <br/>
	 * 
	 * @author hebin
	 * @param gradeInfo
	 * @param staffEntity
	 * @since JDK 1.7
	 */
	void delete(String id,StaffEntity staffEntity) throws Exception;
	

}
