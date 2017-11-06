/**  
 * Project Name:cardmanager  
 * File Name:GradeMngService.java  
 * Package Name:com.card.manager.factory.system.service  
 * Date:Sep 17, 20172:52:45 PM  
 *  
 */
package com.card.manager.factory.system.service;

import java.util.Map;

import com.card.manager.factory.base.PageCallBack;
import com.card.manager.factory.base.Pagination;
import com.card.manager.factory.system.model.GradeEntity;
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
public interface GradeMngService {

	/**
	 * dataList:分页查询. <br/>
	 * 
	 * @author hebin
	 * @param pagination
	 * @param hashMap
	 * @return
	 * @since JDK 1.7
	 */
	PageCallBack dataList(Pagination pagination, Map<String, Object> hashMap, String token) throws Exception;

	/**
	 * saveGrade:新增分级. <br/>
	 * 
	 * @author hebin
	 * @param gradeInfo
	 *            分级信息
	 * @param token
	 *            令牌
	 * @since JDK 1.7
	 */
	void saveGrade(GradeEntity gradeInfo, StaffEntity staff) throws Exception;

	/**
	 * registerAuthCenter:用户中心注册. <br/>
	 * 
	 * @author hebin
	 * @param gradeId
	 * @param staffEntity
	 * @since JDK 1.7
	 */
	void registerAuthCenter(StaffEntity staffEntity, boolean hasUserId) throws Exception;

	/**
	 * queryById:根据分级编号查询分级信息. <br/>
	 * 
	 * @author hebin
	 * @return
	 * @since JDK 1.7
	 */
	GradeEntity queryById(String gradeId, String token);

}
