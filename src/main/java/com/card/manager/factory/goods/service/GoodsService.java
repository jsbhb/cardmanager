/**  
 * Project Name:cardmanager  
 * File Name:SupplierService.java  
 * Package Name:com.card.manager.factory.supplier.service  
 * Date:Nov 7, 20173:19:20 PM  
 *  
 */
package com.card.manager.factory.goods.service;

import java.util.List;
import java.util.Map;

import com.card.manager.factory.common.serivce.ServerCenterService;
import com.card.manager.factory.goods.grademodel.GradeTypeDTO;
import com.card.manager.factory.goods.model.GoodsEntity;
import com.card.manager.factory.goods.model.GoodsRebateEntity;
import com.card.manager.factory.goods.model.GoodsTagBindEntity;
import com.card.manager.factory.goods.model.GoodsTagEntity;
import com.card.manager.factory.goods.model.ThirdWarehouseGoods;
import com.card.manager.factory.goods.pojo.CreateGoodsInfoEntity;
import com.card.manager.factory.goods.pojo.GoodsInfoEntity;
import com.card.manager.factory.goods.pojo.GoodsPojo;
import com.card.manager.factory.system.model.StaffEntity;

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

	/**
	 * addEntity:新增商品. <br/>
	 * 
	 * @author hebin
	 * @param entity
	 * @param token
	 * @since JDK 1.7
	 */
	void updEntity(GoodsEntity entity, String token) throws Exception;

	/**
	 * addEntity:新增商品. <br/>
	 * 
	 * @author hebin
	 * @param entity
	 * @param token
	 * @since JDK 1.7
	 */
	void delEntity(GoodsEntity entity, String token) throws Exception;

	/**
	 * getHtmlContext:(这里用一句话描述这个方法的作用). <br/>
	 * 
	 * @author hebin
	 * @param parameter
	 * @since JDK 1.7
	 */
	String getHtmlContext(String html, StaffEntity staffEntity) throws Exception;

	/**
	 * saveHtml:(这里用一句话描述这个方法的作用). <br/>
	 * 
	 * @author hebin
	 * @param html
	 * @param html
	 * @param staffEntity
	 * @since JDK 1.7
	 */
	void saveHtml(String goodsId, String html, StaffEntity staffEntity) throws Exception;

	/**
	 * queryById:根据编号查询商品信息. <br/>
	 * 
	 * @author hebin
	 * @param id
	 * @param token
	 * @return
	 * @since JDK 1.7
	 */
	List<GoodsRebateEntity> queryGoodsRebateById(String id, String token);

	/**
	 * 
	 * @author hebin
	 * @param entity
	 * @param token
	 * @since JDK 1.7
	 */
	void updGoodsRebateEntity(List<GoodsRebateEntity> list, String token) throws Exception;

	/**
	 * queryGoodsTag:根据编号查询商品信息. <br/>
	 * 
	 * @author hebin
	 * @param id
	 * @param token
	 * @return
	 * @since JDK 1.7
	 */
	GoodsTagEntity queryGoodsTag(String tagId, String token);

	/**
	 * queryGoodsTag:根据编号查询商品信息. <br/>
	 * 
	 * @author hebin
	 * @param id
	 * @param token
	 * @return
	 * @since JDK 1.7
	 */
	List<GoodsTagEntity> queryGoodsTags(String token);

	/**
	 * addEntity:新增商品标签. <br/>
	 * 
	 * @author hebin
	 * @param entity
	 * @param token
	 * @since JDK 1.7
	 */
	void addGoodsTag(GoodsTagEntity entity, String token) throws Exception;

	/**
	 * queryGoodsTag:根据编号查询商品信息. <br/>
	 * 
	 * @author hebin
	 * @param id
	 * @param token
	 * @return
	 * @since JDK 1.7
	 */
	GoodsTagBindEntity queryGoodsTagBind(String token);

	/**
	 * addEntity:新增商品. <br/>
	 * 
	 * @author hebin
	 * @param entity
	 * @param token
	 * @since JDK 1.7
	 */
	void updateGoodsTagEntity(GoodsTagEntity entity, String token) throws Exception;

	/**
	 * addEntity:新增商品. <br/>
	 * 
	 * @author hebin
	 * @param entity
	 * @param token
	 * @since JDK 1.7
	 */
	void deleteGoodsTagEntity(GoodsTagEntity entity, String token) throws Exception;

	/**
	 * addEntity:新增商品. <br/>
	 * 
	 * @author hebin
	 * @param entity
	 * @param token
	 * @since JDK 1.7
	 */
	void addGoodsInfoEntity(CreateGoodsInfoEntity entity, StaffEntity staffEntity) throws Exception;

	/**
	 * queryGoodsTag:根据编号查询商品信息. <br/>
	 * 
	 * @author hebin
	 * @param id
	 * @param token
	 * @return
	 * @since JDK 1.7
	 */
	GoodsInfoEntity queryGoodsInfoEntityByItemId(String itemId, StaffEntity staffEntity);

	/**
	 * addEntity:更新商品. <br/>
	 * 
	 * @author hebin
	 * @param entity
	 * @param token
	 * @since JDK 1.7
	 */
	void updGoodsInfoEntity(CreateGoodsInfoEntity entity, StaffEntity staffEntity) throws Exception;

	/**
	 * @fun 应该在系统那块，防止冲突暂时写在这里
	 * @param id
	 * @param token
	 * @return
	 */
	List<GradeTypeDTO> queryGradeType(String id, String token);

	/**
	 * @fun 应该在系统那块，防止冲突暂时写在这里
	 * @param id
	 * @param token
	 * @return
	 */
	GradeTypeDTO queryGradeTypeById(String id, String token);

	/**
	 * @fun 应该在系统那块，防止冲突暂时写在这里
	 * @param id
	 * @param token
	 * @return
	 */
	List<GradeTypeDTO> queryGradeTypeChildren(String id, String token);

	Map<String, String> getGoodsRebate(String itemId, String token);

}
