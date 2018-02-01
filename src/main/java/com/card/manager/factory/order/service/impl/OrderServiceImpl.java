/**  
 * Project Name:cardmanager  
 * File Name:SupplierServiceImpl.java  
 * Package Name:com.card.manager.factory.supplier.service.impl  
 * Date:Nov 7, 20173:22:23 PM  
 *  
 */
package com.card.manager.factory.order.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.order.model.OperatorEntity;
import com.card.manager.factory.order.model.OrderInfo;
import com.card.manager.factory.order.service.OrderService;
import com.card.manager.factory.system.mapper.StaffMapper;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONObject;

/**
 * ClassName: OrderServiceImpl <br/>
 * Function: 订单服务类. <br/>
 * date: Nov 7, 2017 3:22:23 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
@Service
public class OrderServiceImpl extends AbstractServcerCenterBaseService implements OrderService {

	@Resource
	StaffMapper<?> staffMapper;

	@Override
	public OrderInfo queryByOrderId(String orderId, String token) {
		OrderInfo entity = new OrderInfo();
		entity.setOrderId(orderId);

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_QUERY, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), OrderInfo.class);
	}

	@Override
	public List<OperatorEntity> queryOperatorInfoByOpt(StaffEntity staff) {
		return staffMapper.selectOperatorInfoByOpt(staff);
	}

}
