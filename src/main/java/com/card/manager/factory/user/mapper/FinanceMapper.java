/**  
 * Project Name:cardmanager  
 * File Name:FinanceMapper.java  
 * Package Name:com.card.manager.factory.user.mapper  
 * Date:Oct 18, 20175:54:49 PM  
 *  
 */
package com.card.manager.factory.user.mapper;

import java.util.List;
import java.util.Map;

import com.card.manager.factory.finance.model.CapitalManagement;
import com.card.manager.factory.finance.model.CapitalManagementBusinessItem;
import com.card.manager.factory.finance.model.CapitalManagementDetail;
import com.github.pagehelper.Page;

/**  
 * ClassName: FinanceMapper <br/>  
 * Function: TODO ADD FUNCTION. <br/>   
 * date: Oct 18, 2017 5:54:49 PM <br/>  
 *  
 * @author hebin  
 * @version   
 * @since JDK 1.7  
 */
public interface FinanceMapper {
	
	/**
	 * 
	 * queryList:分页查询. <br/>   
	 *  
	 * @author hebin 
	 * @param params
	 * @return  
	 * @since JDK 1.7
	 */
	Page<CapitalManagement> dataListByType(Map<String,Object> params);

	/**
	 * insert:插入/更新资金管理主表. <br/>
	 * 
	 * @author hebin
	 * @param entity
	 * @since JDK 1.7
	 */
	void insertOrUpdateCapitalManagement(CapitalManagement entity);

	/**
	 * insert:插入资金管理记录表. <br/>
	 * 
	 * @author hebin
	 * @param entity
	 * @since JDK 1.7
	 */
	void insertCapitalManagementDetail(CapitalManagementDetail entity);

	/**
	 * insert:业务明细记录表. <br/>
	 * 
	 * @author hebin
	 * @param entity
	 * @since JDK 1.7
	 */
	void insertCapitalManagementBusinessItem(List<CapitalManagementBusinessItem> list);

	/**
	 * insert:更新资金管理主表金额. <br/>
	 * 
	 * @author hebin
	 * @param entity
	 * @since JDK 1.7
	 */
	void updateCapitalManagementMoney(CapitalManagementDetail entity);
	
	CapitalManagement selectCapitalManagementByCustomerId(String customerId);
	
	/**
	 * 
	 * queryList:分页查询. <br/>   
	 *  
	 * @author hebin 
	 * @param params
	 * @return  
	 * @since JDK 1.7
	 */
	Page<CapitalManagementDetail> dataListByCustomerId(Map<String,Object> params);
}
