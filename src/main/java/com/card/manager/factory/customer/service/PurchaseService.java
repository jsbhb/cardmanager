package com.card.manager.factory.customer.service;

import java.util.List;
import java.util.Map;

import com.card.manager.factory.common.serivce.ServerCenterService;
import com.card.manager.factory.customer.model.Address;
import com.card.manager.factory.customer.model.PostFeeDTO;
import com.card.manager.factory.customer.model.ShoppingCart;
import com.card.manager.factory.customer.model.SupplierPostFeeBO;
import com.card.manager.factory.order.model.OrderInfo;

public interface PurchaseService extends ServerCenterService {

	int getShoppingCartCount(Map<String,Object> params, String token);
	
	void addItemToShoppingCart(ShoppingCart cartParam, String token) throws Exception;
	
	List<ShoppingCart> getShoppingCartInfo(Map<String,Object> params, String token);
	
	void deleteItemToShoppingCart(Map<String,Object> params, String token) throws Exception;
	
	List<Address> getUserAddressInfo(Map<String,Object> params, String token);
	
	void saveUserAddressInfo(Address addressInfo, String saveType, String token) throws Exception;
	
	List<SupplierPostFeeBO> getPostFeeByJsonStr(List<PostFeeDTO> postFeeList, String token);
	
	String createOrderByParam(OrderInfo orderInfo, String token) throws Exception;
	
	String orderContinuePay(Map<String,Object> params, String token) throws Exception;
	
	void confirmOrder(Map<String,Object> params, String token) throws Exception;
	
	void closeOrder(Map<String,Object> params, String token) throws Exception;
}
