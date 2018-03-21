/**  
 * Project Name:cardmanager  
 * File Name:GradeMngService.java  
 * Package Name:com.card.manager.factory.system.service  
 * Date:Sep 17, 20172:52:45 PM  
 *  
 */
package com.card.manager.factory.user.service;

import java.util.List;

import com.card.manager.factory.common.serivce.ServerCenterService;
import com.card.manager.factory.shop.model.ShopEntity;
import com.card.manager.factory.system.model.GradeEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.user.model.CardEntity;
import com.card.manager.factory.user.model.CenterRebate;
import com.card.manager.factory.user.model.ShopRebate;

/**
 * ClassName: FinanceMngService <br/>
 * Function: 财务管理服务类 <br/>
 * date: Sep 17, 2017 2:52:45 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public interface FinanceMngService extends ServerCenterService {

	// /**
	// * dataList:分页查询. <br/>
	// *
	// * @author hebin
	// * @param pagination
	// * @param hashMap
	// * @return
	// * @since JDK 1.7
	// */
	// PageCallBack dataList(Pagination pagination, Map<String, Object> hashMap,
	// String token) throws Exception;

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

	/**
	 * updateGrade:(这里用一句话描述这个方法的作用). <br/>
	 * 
	 * @author hebin
	 * @param gradeInfo
	 * @param staffEntity
	 * @since JDK 1.7
	 */
	void updateGrade(GradeEntity gradeInfo, StaffEntity staffEntity) throws Exception;
	
	ShopEntity queryByGradeId(String gradeId, String token);
	
	void updateCard(CardEntity cardInfo, StaffEntity staffEntity) throws Exception;
	
	List<CardEntity> queryInfoByEntity(StaffEntity staffEntity);
	
	String checkCardNo(String cardNo, String token);
	
	void insertCard(CardEntity cardInfo, StaffEntity staffEntity) throws Exception;
	
	CenterRebate queryCenterRebate(String id, String type, String token);
	
	ShopRebate queryShopRebate(String id, String type, String token);

}
