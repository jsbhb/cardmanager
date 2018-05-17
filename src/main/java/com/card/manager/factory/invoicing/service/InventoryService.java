/**  
 * Project Name:cardmanager  
 * File Name:SupplierService.java  
 * Package Name:com.card.manager.factory.supplier.service  
 * Date:Nov 7, 20173:19:20 PM  
 *  
 */
package com.card.manager.factory.invoicing.service;

import java.util.List;

import com.card.manager.factory.common.serivce.ServerCenterService;
import com.card.manager.factory.goods.model.GoodsStockEntity;
import com.card.manager.factory.system.model.StaffEntity;

public interface InventoryService extends ServerCenterService {

	/**
	 * syncStock:(这里用一句话描述这个方法的作用). <br/>
	 * 
	 * @author hebin
	 * @param itemId
	 * @param staffEntity
	 * @since JDK 1.7
	 */
	void maintainStock(List<GoodsStockEntity> stocks, StaffEntity staffEntity) throws Exception;

}
