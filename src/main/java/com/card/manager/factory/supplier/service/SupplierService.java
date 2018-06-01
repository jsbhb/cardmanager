/**  
 * Project Name:cardmanager  
 * File Name:SupplierService.java  
 * Package Name:com.card.manager.factory.supplier.service  
 * Date:Nov 7, 20173:19:20 PM  
 *  
 */
package com.card.manager.factory.supplier.service;

import com.card.manager.factory.common.serivce.ServerCenterService;
import com.card.manager.factory.supplier.model.SupplierEntity;

/**
 * ClassName: SupplierService <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: Nov 7, 2017 3:19:20 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public interface SupplierService extends ServerCenterService {

	/**
	 * addSupplier:新增供应商. <br/>
	 * 
	 * @author hebin
	 * @param entity
	 * @param string
	 * @since JDK 1.7
	 */
	void addSupplier(SupplierEntity entity, String string) throws Exception;

	/**  
	 * queryById:根据编号查询供应商信息. <br/>   
	 *  
	 * @author hebin 
	 * @param id
	 * @param token
	 * @return  
	 * @since JDK 1.7  
	 */
	SupplierEntity queryById(String id, String token);

	/**
	 * updSupplier:新增供应商. <br/>
	 * 
	 * @author hebin
	 * @param entity
	 * @param string
	 * @since JDK 1.7
	 */
	void updSupplier(SupplierEntity entity, String string) throws Exception;

}
