package com.card.manager.factory.customer.service.impl;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.constants.Constants;
import com.card.manager.factory.customer.model.Address;
import com.card.manager.factory.customer.model.PostFeeDTO;
import com.card.manager.factory.customer.model.ShoppingCart;
import com.card.manager.factory.customer.model.SupplierPostFeeBO;
import com.card.manager.factory.customer.service.PurchaseService;
import com.card.manager.factory.order.model.OrderInfo;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class PurchaseServiceImpl extends AbstractServcerCenterBaseService implements PurchaseService {

	@Override
	public int getShoppingCartCount(Map<String, Object> params, String token) {
		int retInt = 0;
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_COUNT_USER_SHOPPING_CART, token, true, null,
				HttpMethod.GET, params);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (json.getBoolean("success")) {
			retInt = json.getInt("obj");
		}

		return retInt;
	}

	@Override
	public void addItemToShoppingCart(ShoppingCart cartParam, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_USER_ADD_ITEM_TO_SHOPPING_CART, token, true,
				cartParam, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("添加商品到购物车操作失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	public List<ShoppingCart> getShoppingCartInfo(Map<String, Object> params, String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_GET_USER_SHOPPING_CART_INFO, token, true,
				null, HttpMethod.GET, params);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		List<ShoppingCart> list = new ArrayList<ShoppingCart>();

		if (!json.getBoolean("success") || !json.has("obj")) {
			return list;
		}

		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			list.add(JSONUtilNew.parse(jObj.toString(), ShoppingCart.class));
		}

		return list;
	}

	@Override
	public void deleteItemToShoppingCart(Map<String, Object> params, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_USER_DELETE_ITEM_TO_SHOPPING_CART, token,
				true, null, HttpMethod.DELETE, params);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("从购物车删除商品操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public List<Address> getUserAddressInfo(Map<String, Object> params, String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_GET_USER_ADDRESSINFO, token, true, null,
				HttpMethod.GET, params);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		List<Address> list = new ArrayList<Address>();

		if (!json.getBoolean("success") || !json.has("obj")) {
			return list;
		}

		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			list.add(JSONUtilNew.parse(jObj.toString(), Address.class));
		}

		return list;
	}

	@Override
	public void saveUserAddressInfo(Address addressInfo, String saveType, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = null;
		if ("save".equals(saveType)) {
			result = helper.request(URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_SAVE_USER_ADDRESSINFO,
					token, true, addressInfo, HttpMethod.POST);
		} else {
			result = helper.request(URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_SAVE_USER_ADDRESSINFO,
					token, true, addressInfo, HttpMethod.PUT);
		}

		JSONObject json = JSONObject.fromObject(result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("保存用户收货地址操作失败，请重试！");
		}
	}

	@Override
	public List<SupplierPostFeeBO> getPostFeeByJsonStr(List<PostFeeDTO> postFeeList, String token) {
		List<SupplierPostFeeBO> list = new ArrayList<SupplierPostFeeBO>();
		RestCommonHelper helper = new RestCommonHelper();
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			params.put("data", URLDecoder.decode((JSONArray.fromObject(postFeeList)).toString(),"UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return list;
		}
		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_GET_POST_FEE, token,
				true, null, HttpMethod.POST, params);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success") || !json.has("obj")) {
			return list;
		}

		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			list.add(JSONUtilNew.parse(jObj.toString(), SupplierPostFeeBO.class));
		}

		return list;
	}

	@Override
	public String createOrderByParam(OrderInfo orderInfo, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		String strReturnInfo = "";
		String strCreateOrderParam = "?type=scanCode&openId=";
		if (orderInfo.getOrderDetail().getPayType() == Constants.WX_PAY) {
			strCreateOrderParam = "?type=NATIVE&openId=";
		}
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_CREATE_ORDER_INFO + strCreateOrderParam, token,
				true, orderInfo, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("提交订单操作失败:" + json.getString("errorMsg"));
		} else {
			strReturnInfo = json.getString("errorMsg");
			if (orderInfo.getOrderDetail().getPayType() == Constants.REBATE_PAY) {
				Map<String, Object> rebareOrderUpdateParams = new HashMap<String, Object>();
				rebareOrderUpdateParams.put("orderId", strReturnInfo);
				String strPayNo = "?payNo="+strReturnInfo;
				ResponseEntity<String> orderStatusUpdate_result = helper.requestWithParams(
						URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_REBATE_ORDER_STATUS_UPDATE + strPayNo, token,
						true, orderInfo, HttpMethod.PUT, rebareOrderUpdateParams);

				JSONObject orderStatusUpdateJson = JSONObject.fromObject(orderStatusUpdate_result.getBody());
				if (!orderStatusUpdateJson.getBoolean("success")) {
					throw new Exception("返佣抵扣订单状态更新操作失败:" + json.getString("errorMsg"));
				}
				strReturnInfo += "|" + Constants.REBATE_PAY + "|";
			} else if (orderInfo.getOrderDetail().getPayType() == Constants.ALI_PAY) {
				String strALIPayInfo = json.getString("obj");
				strALIPayInfo = strALIPayInfo.substring(1,strALIPayInfo.length()-1);
				JSONObject jsonobject = JSONObject.fromObject(strALIPayInfo);
				strReturnInfo += "|" + Constants.ALI_PAY + "|" + jsonobject.getString("htmlStr");
			} else if (orderInfo.getOrderDetail().getPayType() == Constants.WX_PAY) {
				String strWXPayInfo = json.getString("obj");
				JSONObject jsonobject = JSONObject.fromObject(strWXPayInfo);
				strReturnInfo += "|" + Constants.WX_PAY + "|" + jsonobject.getString("urlCode");
			} else if (orderInfo.getOrderDetail().getPayType() == Constants.YB_PAY) {
				String strYBPayInfo = json.getString("obj");
				JSONObject jsonobject = JSONObject.fromObject(strYBPayInfo);
				strReturnInfo += "|" + Constants.YB_PAY + "|" + jsonobject.getString("url");
			}
		}
		return strReturnInfo;
	}
	
	@Override
	public String orderContinuePay(Map<String, Object> params, String token) throws Exception {
		String strReturnInfo = "";
		String strCreateOrderParam = "?openId=";
		if ("1".equals(params.get("payType"))) {
			params.put("type", "NATIVE");
		} else if ("2".equals(params.get("payType"))) {
			params.put("type", "scanCode");
		} else if ("5".equals(params.get("payType"))) {
			params.put("type", "scanCode");
		}
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.PAY_CENTER_ORDER_PAY_STATUS_UPDATE + strCreateOrderParam, token,
				true, null, HttpMethod.POST, params);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("继续支付订单操作失败:" + json.getString("errorMsg"));
		} else {
			strReturnInfo = params.get("orderId").toString();
			if ("1".equals(params.get("payType"))) {
				String strWXPayInfo = json.getString("obj");
				JSONObject jsonobject = JSONObject.fromObject(strWXPayInfo);
				strReturnInfo += "|" + Constants.WX_PAY + "|" + jsonobject.getString("urlCode");
			} else if ("2".equals(params.get("payType"))) {
				String strALIPayInfo = json.getString("obj");
				JSONObject jsonobject = JSONObject.fromObject(strALIPayInfo);
				strReturnInfo += "|" + Constants.ALI_PAY + "|" + jsonobject.getString("htmlStr");
			} else if ("5".equals(params.get("payType"))) {
				String strYBPayInfo = json.getString("obj");
				strReturnInfo += "|" + Constants.YB_PAY + "|" + strYBPayInfo;
			}
		}
		return strReturnInfo;
	}
	
	@Override
	public void confirmOrder(Map<String, Object> params, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_ORDER_CONFIRM_UPDATE, token,
				true, null, HttpMethod.PUT, params);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("订单确认收货操作失败:" + json.getString("errorMsg"));
		}
	}
	
	@Override
	public void closeOrder(Map<String, Object> params, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_ORDER_CLOSE_UPDATE, token,
				true, null, HttpMethod.POST, params);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("订单关闭操作失败:" + json.getString("errorMsg"));
		}
	}
}
