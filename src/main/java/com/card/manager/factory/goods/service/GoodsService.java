/**  
 * Project Name:cardmanager  
 * File Name:SupplierService.java  
 * Package Name:com.card.manager.factory.supplier.service  
 * Date:Nov 7, 20173:19:20 PM  
 *  
 */
package com.card.manager.factory.goods.service;

import com.card.manager.factory.common.serivce.ServerCenterService;
import com.card.manager.factory.goods.model.GoodsEntity;
import com.card.manager.factory.goods.model.ThirdWarehouseGoods;
import com.card.manager.factory.goods.pojo.GoodsPojo;

/**
 * ClassName: GoodsService <br/>
 * Function: 商品服务类. <br/>
 * date: Nov 7, 2017 3:19:20 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public interface GoodsService extends ServerCenterService {

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
	GoodsEntity queryById(String id, String token);

	/**  
	 * queryThirdById:根据id查询同步商品. <br/>   
	 *  
	 * @author hebin 
	 * @param id
	 * @param token
	 * @return  
	 * @since JDK 1.7  
	 */
	ThirdWarehouseGoods queryThirdById(String id, String token);

}
