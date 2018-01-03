/**  
 * Project Name:cardmanager  
 * File Name:SupplierService.java  
 * Package Name:com.card.manager.factory.supplier.service  
 * Date:Nov 7, 20173:19:20 PM  
 *  
 */
package com.card.manager.factory.goods.service;

import com.card.manager.factory.common.serivce.ServerCenterService;
import com.card.manager.factory.goods.model.GoodsItemEntity;
import com.card.manager.factory.goods.pojo.GoodsPojo;

/**
 * ClassName: GoodsItemService <br/>
 * Function: 商品明细服务类. <br/>
 * date: Nov 7, 2017 3:19:20 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public interface GoodsItemService extends ServerCenterService {

	/**
	 * addEntity:新增商品. <br/>
	 * 
	 * @author hebin
	 * @param entity
	 * @param token
	 * @since JDK 1.7
	 */
	void addEntity(GoodsPojo entity, String token) throws Exception;

	/**  
	 * queryById:根据编号查询商品信息. <br/>   
	 *  
	 * @author hebin 
	 * @param id
	 * @param token
	 * @return  
	 * @since JDK 1.7  
	 */
	GoodsItemEntity queryById(String id, String token);

	/**  
	 * beUse:设置商品明细可用. <br/>   
	 *  
	 * @author hebin 
	 * @param parameter
	 * @param token  
	 * @since JDK 1.7  
	 */
	void beUse(String itemId, String token,String optId) throws Exception;

	/**  
	 * noBeFx:设置商品不可分销. <br/>   
	 *  
	 * @author hebin 
	 * @param parameter
	 * @param token  
	 * @since JDK 1.7  
	 */
	void noBeFx(String itemId, String token,String optId) throws Exception;
	
	/**  
	 * noBeFx:设置商品可分销. <br/>   
	 *  
	 * @author hebin 
	 * @param parameter
	 * @param token  
	 * @since JDK 1.7  
	 */
	void beFx(String itemId, String token,String optId) throws Exception;

}
