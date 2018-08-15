package com.card.manager.factory.welfare.service;

import java.util.Map;

import com.card.manager.factory.common.serivce.ServerCenterService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.welfare.model.InviterEntity;

public interface WelfareService extends ServerCenterService {

	/**
	 * @fun 批量导入
	 * @param filePath
	 * @param staffEntity
	 */
	Map<String, Object> importInviterInfo(String filePath, StaffEntity staffEntity);
	
	/**
	 * @fun 单条导入
	 * @param InviterEntity
	 * @param staffEntity
	 */
	Map<String, Object> addInviterInfo(InviterEntity entity, StaffEntity staffEntity);
	
	/**
	 * @fun 更新邀请人信息
	 * @param InviterEntity
	 * @param staffEntity
	 */
	Map<String, Object> updateInviterInfo(InviterEntity entity, StaffEntity staffEntity);
	
	/**
	 * @fun 生成邀请码信息
	 * @param InviterEntity
	 * @param staffEntity
	 */
	Map<String, Object> produceCode(InviterEntity entity, StaffEntity staffEntity);
	
	/**
	 * @fun 发送邀请码信息
	 * @param InviterEntity
	 * @param staffEntity
	 */
	Map<String, Object> sendProduceCode(InviterEntity entity, StaffEntity staffEntity);
}
