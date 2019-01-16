/**  
 * Project Name:cardmanager  
 * File Name:SupplierService.java  
 * Package Name:com.card.manager.factory.supplier.service  
 * Date:Nov 7, 20173:19:20 PM  
 *  
 */
package com.card.manager.factory.order.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.card.manager.factory.common.serivce.ServerCenterService;
import com.card.manager.factory.order.model.OperatorEntity;
import com.card.manager.factory.order.model.OrderInfo;
import com.card.manager.factory.order.model.ThirdOrderInfo;
import com.card.manager.factory.order.model.UserInfo;
import com.card.manager.factory.order.pojo.OrderInfoListForDownload;
import com.card.manager.factory.order.pojo.OrderMaintenanceBO;
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

	void applyOrderBack(String orderId, String orderType, StaffEntity staff) throws Exception;

	void auditOrderBack(String orderId, String payNo, StaffEntity staff) throws Exception;

	/**
	 * queryByOrderId:根据编号查询订单信息. <br/>
	 * 
	 * @author hebin
	 * @param orderId
	 * @param token
	 * @return
	 * @since JDK 1.7
	 */
	List<ThirdOrderInfo> queryThirdOrderInfoByOrderId(String orderId, String token);

	void cancleTagFuncOrder(List<String> orderIds, StaffEntity staff) throws Exception;

	/**
	 * queryByOrderId:根据编号查询订单信息. <br/>
	 * 
	 * @author hebin
	 * @param orderId
	 * @param token
	 * @return
	 * @since JDK 1.7
	 */
	List<OrderInfoListForDownload> queryOrderInfoListForDownload(Map<String, Object> param, String token);

	void maintenanceExpress(List<OrderMaintenanceBO> list, StaffEntity staff) throws Exception;

	void downLoadOrderImportExcel(HttpServletRequest req, HttpServletResponse resp, StaffEntity staffEntity)
			throws Exception;

	Map<String, Object> importOrder(String filePath, StaffEntity staffEntity);

	void sendStockInGoodsInfoToMJYByOrderId(String orderId, StaffEntity staff) throws Exception;

	void sendStockOutGoodsInfoToMJYByOrderId(String orderId, StaffEntity staff) throws Exception;
	
	UserInfo queryUserInfoByUserId(String userId, String token);
}
