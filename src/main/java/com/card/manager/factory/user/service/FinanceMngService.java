/**  
 * Project Name:cardmanager  
 * File Name:GradeMngService.java  
 * Package Name:com.card.manager.factory.system.service  
 * Date:Sep 17, 20172:52:45 PM  
 *  
 */
package com.card.manager.factory.user.service;

import java.util.List;
import java.util.Map;

import com.card.manager.factory.base.Pagination;
import com.card.manager.factory.common.serivce.ServerCenterService;
import com.card.manager.factory.component.model.GradeBO;
import com.card.manager.factory.finance.model.AddCapitalPoolInfoEntity;
import com.card.manager.factory.finance.model.AuditModel;
import com.card.manager.factory.finance.model.CapitalManagement;
import com.card.manager.factory.finance.model.CapitalManagementBusinessItem;
import com.card.manager.factory.finance.model.CapitalManagementDetail;
import com.card.manager.factory.finance.model.CapitalManagementDownLoadEntity;
import com.card.manager.factory.finance.model.CapitalOverviewModel;
import com.card.manager.factory.finance.model.CapitalPoolDetail;
import com.card.manager.factory.finance.model.Refilling;
import com.card.manager.factory.finance.model.Withdrawals;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.user.model.CardEntity;
import com.card.manager.factory.user.model.Rebate;
import com.card.manager.factory.user.model.ShopRebate;
import com.github.pagehelper.Page;

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

	void updateCard(CardEntity cardInfo, StaffEntity staffEntity) throws Exception;

	List<CardEntity> queryInfoByEntity(StaffEntity staffEntity);

	String checkCardNo(String cardNo, String token) throws Exception;

	void insertCard(CardEntity cardInfo, StaffEntity staffEntity) throws Exception;

	Rebate queryRebate(Integer id, String token);

	ShopRebate queryShopRebate(String id, String type, String token);

	CardEntity queryInfoByCardId(CardEntity cardEntity, StaffEntity staffEntity);

	void deleteCard(CardEntity cardInfo, StaffEntity staffEntity) throws Exception;

	Withdrawals checkWithdrawalsById(String id, StaffEntity staffEntity);

	void auditWithdrawals(AuditModel entity, StaffEntity staffEntity) throws Exception;

	List<CardEntity> queryInfoByUser(StaffEntity staffEntity);

	void applyWithdrawals(Withdrawals entity, StaffEntity staffEntity) throws Exception;

	void applyRefilling(Refilling entity, StaffEntity staffEntity) throws Exception;

	Refilling queryRefillingDetailById(String id, StaffEntity staffEntity);

	void auditRefilling(AuditModel entity, StaffEntity staffEntity) throws Exception;

	void poolCharge(String centerId, String money, String payNo, StaffEntity staffEntity) throws Exception;

	void poolLiquidation(String centerId, String money, StaffEntity staffEntity) throws Exception;

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
	Page<CapitalManagement> dataListByType(Pagination pagination, Map<String, Object> params);

	void insertCapitalPoolInfo(AddCapitalPoolInfoEntity entity) throws Exception;

	CapitalManagement queryCapitalManagementByCustomerId(Map<String, Object> param);

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
	Page<CapitalManagementDetail> dataListByCustomerId(Pagination pagination, Map<String, Object> params);

	CapitalManagement totalCustomerByType(Map<String, Object> params);

	CapitalManagementDetail queryCapitalManagementDetailByParam(Map<String, Object> params);

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
	Page<CapitalManagementBusinessItem> dataListByBusinessNo(Pagination pagination, Map<String, Object> params);

	List<CapitalManagementDownLoadEntity> queryCapitalPoolInfoListForDownload(Map<String, Object> params);

	CapitalOverviewModel getCapitalOverviewModel(String token, List<GradeBO> list);

	void addCapitalPool(CapitalPoolDetail entity, String token);

}
