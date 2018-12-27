/**  
 * Project Name:cardmanager  
 * File Name:SupplierService.java  
 * Package Name:com.card.manager.factory.supplier.service  
 * Date:Nov 7, 20173:19:20 PM  
 *  
 */
package com.card.manager.factory.goods.service;

import java.util.List;

import com.card.manager.factory.goods.model.CatalogModel;
import com.card.manager.factory.goods.model.FirstCatalogEntity;
import com.card.manager.factory.goods.model.SecondCatalogEntity;
import com.card.manager.factory.goods.model.ThirdCatalogEntity;
import com.card.manager.factory.system.model.StaffEntity;

/**
 * ClassName: SupplierService <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: Nov 7, 2017 3:19:20 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public interface CatalogService {

	/**
	 * queryById:根据编号查询供应商信息. <br/>
	 * 
	 * @author hebin
	 * @param id
	 * @param token
	 * @return
	 * @since JDK 1.7
	 */
	List<FirstCatalogEntity> queryAll(String token);

	/**
	 * add:(这里用一句话描述这个方法的作用). <br/>
	 * 
	 * @author hebin
	 * @param name
	 * @param type
	 * @param staffEntity
	 * @param parentId
	 * @since JDK 1.7
	 */
	void add(CatalogModel model, StaffEntity staffEntity) throws Exception;

	/**
	 * queryFirstCatalogs:查询一级分类. <br/>
	 * 
	 * @author hebin
	 * @param token
	 * @return
	 * @since JDK 1.7
	 */
	List<FirstCatalogEntity> queryFirstCatalogs(String token);

	/**
	 * querySecondCatalogByFirstId:根据一级分类编号查询二级分类. <br/>
	 * 
	 * @author hebin
	 * @param token
	 * @param firstId
	 * @return
	 * @since JDK 1.7
	 */
	List<SecondCatalogEntity> querySecondCatalogByFirstId(String token, String firstId);

	/**
	 * queryThirdCatalogByFirstId:根据二级分类编号查询三级分类. <br/>
	 * 
	 * @author hebin
	 * @param token
	 * @param secondId
	 * @return
	 * @since JDK 1.7
	 */
	List<ThirdCatalogEntity> queryThirdCatalogBySecondId(String token, String secondId);

	/**
	 * delete:(这里用一句话描述这个方法的作用). <br/>
	 * 
	 * @author hebin
	 * @param model
	 * @param staffEntity
	 * @since JDK 1.7
	 */
	void delete(String id, String type, StaffEntity staffEntity) throws Exception;

	/**  
	 * queryForEdit:(这里用一句话描述这个方法的作用). <br/>   
	 *  
	 * @author hebin 
	 * @param model
	 * @return  
	 * @since JDK 1.7  
	 */
	CatalogModel queryForEdit(CatalogModel model,String token);

	/**  
	 * modify:(这里用一句话描述这个方法的作用). <br/>   
	 *  
	 * @author hebin 
	 * @param model
	 * @param staffEntity  
	 * @since JDK 1.7  
	 */
	void modify(CatalogModel model, StaffEntity staffEntity) throws Exception;

	void publish(StaffEntity staffEntity) throws Exception;

	void updCategoryByParam(CatalogModel model, StaffEntity staffEntity) throws Exception;

	SecondCatalogEntity queryFirstBySecondId(SecondCatalogEntity entity,String token);
	
	String getGoodsCategoryId(String categoryType);

}
