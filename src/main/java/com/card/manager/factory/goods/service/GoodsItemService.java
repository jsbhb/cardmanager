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
import com.card.manager.factory.goods.model.GoodsItemEntity;
import com.card.manager.factory.goods.model.GoodsPrice;
import com.card.manager.factory.goods.pojo.GoodsExtensionEntity;
import com.card.manager.factory.goods.pojo.GoodsInfoListForDownload;
import com.card.manager.factory.goods.pojo.GoodsListDownloadParam;
import com.card.manager.factory.goods.pojo.GoodsPojo;
import com.card.manager.factory.system.model.StaffEntity;

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
	void beUse(String itemId, String token, String optId) throws Exception;

	/**
	 * noBeFx:设置商品不可分销. <br/>
	 * 
	 * @author hebin
	 * @param parameter
	 * @param token
	 * @since JDK 1.7
	 */
	void noBeFx(String itemId, String token, String optId) throws Exception;

	/**
	 * noBeFx:设置商品可分销. <br/>
	 * 
	 * @author hebin
	 * @param parameter
	 * @param token
	 * @since JDK 1.7
	 */
	void beFx(String itemId, String token, String optId) throws Exception;

	/**
	 * fx:(这里用一句话描述这个方法的作用). <br/>
	 * 
	 * @author hebin
	 * @param itemId
	 * @param token
	 * @param optid
	 * @param gradeId
	 * @since JDK 1.7
	 */
	void fx(String itemId, String token, String optid, int gradeId) throws Exception;

	/**
	 * puton:(这里用一句话描述这个方法的作用). <br/>
	 * 
	 * @author hebin
	 * @param itemId
	 * @param staffEntity
	 * @since JDK 1.7
	 */
	void puton(String itemId, StaffEntity staffEntity) throws Exception;

	/**
	 * putoff:(这里用一句话描述这个方法的作用). <br/>
	 * 
	 * @author hebin
	 * @param itemId
	 * @param staffEntity
	 * @since JDK 1.7
	 */
	void putoff(String itemId, StaffEntity staffEntity) throws Exception;

	/**
	 * syncStock:(这里用一句话描述这个方法的作用). <br/>
	 * 
	 * @author hebin
	 * @param itemId
	 * @param staffEntity
	 * @since JDK 1.7
	 */
	void syncStock(String itemId, StaffEntity staffEntity) throws Exception;

	/**  
	 * updateEntity:(这里用一句话描述这个方法的作用). <br/>   
	 *  
	 * @author hebin 
	 * @param pojo
	 * @param token  
	 * @since JDK 1.7  
	 */
	void updateEntity(GoodsPojo pojo, String token) throws Exception;

	/**
	 * puton:(这里用一句话描述这个方法的作用). <br/>
	 * 
	 * @author hebin
	 * @param itemId
	 * @param staffEntity
	 * @since JDK 1.7
	 */
	void TBSyncGoods(String itemId, StaffEntity staffEntity) throws Exception;

	/**
	 * queryById:根据编号查询商品信息. <br/>
	 * 
	 * @author hebin
	 * @param id
	 * @param token
	 * @return
	 * @since JDK 1.7
	 */
	GoodsPrice queryPriceById(String id, StaffEntity staffEntity);

	/**
	 * queryById:根据编号查询商品信息. <br/>
	 * 
	 * @author hebin
	 * @param id
	 * @param token
	 * @return
	 * @since JDK 1.7
	 */
	GoodsPrice queryCheckGoodsPriceById(String id, StaffEntity staffEntity);

	/**
	 * puton:(这里用一句话描述这个方法的作用). <br/>
	 * 
	 * @author hebin
	 * @param itemId
	 * @param staffEntity
	 * @since JDK 1.7
	 */
	void editPrice(GoodsPrice price, StaffEntity staffEntity) throws Exception;

	List<GoodsInfoListForDownload> queryGoodsInfoListForDownload(GoodsListDownloadParam param, String token);
	
	GoodsExtensionEntity queryExtensionByGoodsId(String goodsId, String token);

	void updGoodsExtensionInfoEntity(GoodsExtensionEntity entity, StaffEntity staffEntity) throws Exception;

	void batchBindTag(String itemIds, String tagIds, StaffEntity staffEntity);

	void publish(String goodsIds, StaffEntity staffEntity);

	void unPublish(String goodsIds, StaffEntity staffEntity);
}
