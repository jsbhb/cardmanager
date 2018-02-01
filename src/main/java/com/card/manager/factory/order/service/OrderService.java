/**  
 * Project Name:cardmanager  
 * File Name:SupplierService.java  
 * Package Name:com.card.manager.factory.supplier.service  
 * Date:Nov 7, 20173:19:20 PM  
 *  
 */
package com.card.manager.factory.order.service;

import java.util.List;

import com.card.manager.factory.common.serivce.ServerCenterService;
import com.card.manager.factory.order.model.OperatorEntity;
import com.card.manager.factory.order.model.OrderInfo;
import com.card.manager.factory.system.model.StaffEntity;

/**
 * ClassName: OrderService <br/>
 * Function: 订单服务类. <br/>
 * date: Nov 7, 2017 3:19:20 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public interface OrderService extends ServerCenterService {

	/**  
	 * queryByOrderId:根据编号查询订单信息. <br/>   
	 *  
	 * @author hebin 
	 * @param orderId
	 * @param token
	 * @return  
	 * @since JDK 1.7  
	 */
	OrderInfo queryByOrderId(String orderId, String token);

	List<OperatorEntity> queryOperatorInfoByOpt(StaffEntity staff);
}
