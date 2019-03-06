/**  
 * Project Name:cardmanager  
 * File Name:SupplierService.java  
 * Package Name:com.card.manager.factory.supplier.service  
 * Date:Nov 7, 20173:19:20 PM  
 *  
 */
package com.card.manager.factory.goods.service;

import java.util.List;

import com.card.manager.factory.common.serivce.ServerCenterService;
import com.card.manager.factory.goods.model.GuidePropertyEntity;
import com.card.manager.factory.goods.model.PropertyEntity;
import com.card.manager.factory.goods.model.PropertyValueEntity;

/**
 * 
 * ClassName: GoodsPropertyService <br/>  
 * Function: 商品属性服务. <br/>   
 * date: 2019年2月20日 上午10:46:53 <br/>  
 *  
 * @author why  
 * @version   
 * @since JDK 1.7
 */
public interface GoodsPropertyService extends ServerCenterService {

	/**
	 * 
	 * addPropertyName:新增属性名称. <br/>  
	 *  
	 * @author why  
	 * @param entity
	 * @param string
	 * @throws Exception  
	 * @since JDK 1.7
	 */
	void addPropertyName(PropertyEntity entity, String hidTabId, String token) throws Exception;
	
	PropertyEntity queryPropertyNameById(String id, String token);
	
	GuidePropertyEntity queryGuidePropertyNameById(String id, String token);
	
	void editPropertyName(PropertyEntity entity, String hidTabId, String token) throws Exception;
	
	void deletePropertyName(String id, String hidTabId, String token) throws Exception;
	
	void addPropertyValue(PropertyValueEntity entity, String hidTabId, String token) throws Exception;
	
	PropertyEntity queryPropertyValueById(String valueId, String token);
	
	GuidePropertyEntity queryGuidePropertyValueById(String valueId, String token);
	
	void editPropertyValue(PropertyValueEntity entity, String hidTabId, String token) throws Exception;
	
	void deletePropertyValue(String id, String hidTabId, String token) throws Exception;
	
	List<PropertyEntity> queryPropertyListByCategory(String categoryId, String categoryType, String token);
	
	List<PropertyValueEntity> queryPropertyValueListById(String propertyId, String token);

}
