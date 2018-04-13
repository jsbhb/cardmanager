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
import com.card.manager.factory.finance.model.AuditModel;
import com.card.manager.factory.finance.model.Refilling;
import com.card.manager.factory.finance.model.Withdrawals;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.user.model.CardEntity;
import com.card.manager.factory.user.model.Rebate;
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

}
