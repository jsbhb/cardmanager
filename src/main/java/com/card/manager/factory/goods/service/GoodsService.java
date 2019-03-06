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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.card.manager.factory.common.serivce.ServerCenterService;
import com.card.manager.factory.goods.grademodel.GradeTypeDTO;
import com.card.manager.factory.goods.grademodel.KJGoodsDTO;
import com.card.manager.factory.goods.model.GoodsEntity;
import com.card.manager.factory.goods.model.GoodsRebateEntity;
import com.card.manager.factory.goods.model.GoodsTagEntity;
import com.card.manager.factory.goods.pojo.GoodsFielsMaintainBO;
import com.card.manager.factory.goods.pojo.GoodsInfoEntity;
import com.card.manager.factory.goods.pojo.Tax;
import com.card.manager.factory.goods.pojo.po.BackGoodsPO;
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

	// /**
	// * queryById:根据编号查询商品信息. <br/>
	// *
	// * @author hebin
	// * @param id
	// * @param token
	// * @return
	// * @since JDK 1.7
	// */
	// GoodsEntity queryById(String id, String token);
	//
	// /**
	// * queryThirdById:根据id查询同步商品. <br/>
	// *
	// * @author hebin
	// * @param id
	// * @param token
	// * @return
	// * @since JDK 1.7
	// */
	// ThirdWarehouseGoods queryThirdById(String id, String token);
	//
	/**
	 * getHtmlContext:获取html的内容. <br/>
	 * 
	 * @author hebin
	 * @param parameter
	 * @since JDK 1.7
	 */
	String getHtmlContext(String html, StaffEntity staffEntity) throws Exception;

	/**
	 * saveHtml:保存html. <br/>
	 *
	 * @author hebin
	 * @param html
	 * @param html
	 * @param staffEntity
	 * @since JDK 1.7
	 */
	String saveModelHtml(String itemCode, String html, StaffEntity staffEntity) throws Exception;

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

	//
	// /**
	// * addEntity:新增商品标签. <br/>
	// *
	// * @author hebin
	// * @param entity
	// * @param token
	// * @since JDK 1.7
	// */
	// void addGoodsTag(GoodsTagEntity entity, String token) throws Exception;
	//
	// /**
	// * queryGoodsTag:根据编号查询商品信息. <br/>
	// *
	// * @author hebin
	// * @param id
	// * @param token
	// * @return
	// * @since JDK 1.7
	// */
	// GoodsTagBindEntity queryGoodsTagBind(String token);

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

	// /**
	// * addEntity:新增商品. <br/>
	// *
	// * @author hebin
	// * @param entity
	// * @param token
	// * @since JDK 1.7
	// */
	// void addGoodsInfoEntity(CreateGoodsInfoEntity entity, StaffEntity
	// staffEntity) throws Exception;

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
	//
	// /**
	// * addEntity:更新商品. <br/>
	// *
	// * @author hebin
	// * @param entity
	// * @param token
	// * @since JDK 1.7
	// */
	// void updGoodsInfoEntity(CreateGoodsInfoEntity entity, StaffEntity
	// staffEntity) throws Exception;

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

	/**
	 * @fun 批量导入
	 * @param filePath
	 * @param staffEntity
	 */
	Map<String, Object> importGoodsInfo(String filePath, StaffEntity staffEntity);

	void exportGoodsInfoTemplate(HttpServletRequest req, HttpServletResponse resp, StaffEntity staffEntity)
			throws Exception;

	/**
	 * batchUploadPic:批量上传文件. <br/>
	 * 
	 * @author hebin
	 * @param bo
	 * @since JDK 1.7
	 */
	void batchUploadPic(List<GoodsFielsMaintainBO> boList, String token) throws Exception;
	//
	// /**
	// * addItemInfoEntity:添加商品规格. <br/>
	// *
	// * @author hebin
	// * @param entity
	// * @param token
	// * @since JDK 1.7
	// */
	// void addItemInfoEntity(CreateGoodsInfoEntity entity, StaffEntity
	// staffEntity) throws Exception;
	//
	// List<GoodsPriceRatioEntity> queryGoodsPriceRatioList(GoodsItemEntity
	// entity, String token);
	//
	// void syncRatioGoodsInfo(List<GoodsPriceRatioEntity> list, StaffEntity
	// staffEntity) throws Exception;

	GoodsEntity queryGoodsInfoByGoodsId(String goodsId, String token);

	List<String> queryGoodsIdByItemCode(String itemCode, String token);

	List<String> queryGoodsPic(String goodsId, String token);

	List<Tax> getTaxInfoByItemIds(List<String> itemIds, String token);
	
	//商品库改造新增方法
	String getGoodsId();

	BackGoodsPO queryBackGoodsPoByEncode(String encode, String goodsType, StaffEntity staffEntity) throws Exception;

	void saveKJGoodsInfo(KJGoodsDTO entity, StaffEntity staffEntity) throws Exception;

	BackGoodsPO queryBackGoodsPoByItemId(String itemId, StaffEntity staffEntity) throws Exception;

	void modifyKJGoodsInfo(KJGoodsDTO entity, StaffEntity staffEntity) throws Exception;
}
