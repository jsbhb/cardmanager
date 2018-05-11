/**  
 * Project Name:cardmanager  
 * File Name:SupplierServiceImpl.java  
 * Package Name:com.card.manager.factory.supplier.service.impl  
 * Date:Nov 7, 20173:22:23 PM  
 *  
 */
package com.card.manager.factory.order.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.card.manager.factory.annotation.Log;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.order.model.OperatorEntity;
import com.card.manager.factory.order.model.OrderInfo;
import com.card.manager.factory.order.model.ThirdOrderInfo;
import com.card.manager.factory.order.pojo.OrderInfoListForDownload;
import com.card.manager.factory.order.service.OrderService;
import com.card.manager.factory.system.mapper.StaffMapper;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONArray;
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

	@Override
	@Log(content = "发起订单退款操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void applyOrderBack(String orderId, StaffEntity staff) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("orderId", orderId);
		ResponseEntity<String> result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_APPLY_ORDER_BACK, staff.getToken(), true, null,
				HttpMethod.POST, params);

		JSONObject json = JSONObject.fromObject(result.getBody());
		if (!json.getBoolean("success")) {
			throw new Exception("发起订单退款操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	@Log(content = "审核订单退款操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void auditOrderBack(String orderId, String payNo, StaffEntity staff) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("orderId", orderId);
		ResponseEntity<String> result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_AUDIT_ORDER_BACK+"?payNo="+payNo, staff.getToken(), true, null,
				HttpMethod.POST, params);

		JSONObject json = JSONObject.fromObject(result.getBody());
		if (!json.getBoolean("success")) {
			throw new Exception("审核订单退款操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public List<ThirdOrderInfo> queryThirdOrderInfoByOrderId(String orderId, String token) {
		OrderInfo entity = new OrderInfo();
		entity.setOrderId(orderId);

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_QUERY_THIRD_INFO, token, true, entity,
				HttpMethod.POST);
		
		JSONObject json = JSONObject.fromObject(query_result.getBody());
		
		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		List<ThirdOrderInfo> list = new ArrayList<ThirdOrderInfo>();
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			list.add(JSONUtilNew.parse(jObj.toString(), ThirdOrderInfo.class));
		}
		
		return list;
	}

	@Override
	@Log(content = "发起订单取消功能操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void cancleTagFuncOrder(List<String> orderIds, StaffEntity staff) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_PRESELL_CANCLEFUNC, staff.getToken(), true, orderIds,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(result.getBody());
		if (!json.getBoolean("success")) {
			throw new Exception("发起订单取消功能操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public List<OrderInfoListForDownload> queryOrderInfoListForDownload(Map<String,Object> param, String token) {

		List<OrderInfoListForDownload> list = new ArrayList<OrderInfoListForDownload>();
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_QUERY_ORDERLISTFORDOWNLOAD, token, true, null,
				HttpMethod.POST,param);
		
		JSONObject json = JSONObject.fromObject(query_result.getBody());
		
		if (!json.getBoolean("success")) {
			return list;
		}
		
		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			list.add(JSONUtilNew.parse(jObj.toString(), OrderInfoListForDownload.class));
		}
		
		return list;
	}
}
