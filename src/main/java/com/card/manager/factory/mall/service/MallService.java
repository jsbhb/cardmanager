/**  
 * Project Name:cardmanager  
 * File Name:MallService.java  
 * Package Name:com.card.manager.factory.mall.service  
 * Date:Jan 2, 20183:47:52 PM  
 *  
 */
package com.card.manager.factory.mall.service;

import java.util.List;

import com.card.manager.factory.common.serivce.ServerCenterService;
import com.card.manager.factory.goods.model.DictData;
import com.card.manager.factory.goods.model.Layout;
import com.card.manager.factory.goods.model.PopularizeDict;
import com.card.manager.factory.mall.pojo.BigSalesGoodsRecord;
import com.card.manager.factory.mall.pojo.ComponentData;
import com.card.manager.factory.mall.pojo.FloorDictPojo;

/**
 * ClassName: MallService <br/>
 * Function: 商城服务类. <br/>
 * date: Jan 2, 2018 3:47:52 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public interface MallService extends ServerCenterService {

	/**
	 * queryById:根据编号查询字典数据. <br/>
	 * 
	 * @author hebin
	 * @param id
	 * @param centerId 
	 * @param token
	 * @return
	 * @since JDK 1.7
	 */
	PopularizeDict queryById(String id, int centerId, String token);

	/**
	 * delateData:删除商品数据. <br/>
	 * 
	 * @author hebin
	 * @param id
	 * @param token
	 * @since JDK 1.7
	 */
	void delateData(String id, String token) throws Exception;

	/**
	 * addDict:新增字典数据. <br/>
	 * 
	 * @author hebin
	 * @param pojo
	 * @param token
	 * @since JDK 1.7
	 */
	void addDict(FloorDictPojo pojo, String token) throws Exception;

	/**
	 * addData:插入字典数据. <br/>
	 * 
	 * @author hebin
	 * @param data
	 * @param token
	 * @since JDK 1.7
	 */
	void addData(DictData data, String token) throws Exception;

	/**
	 * delateDict:根据编号删除字典数据. <br/>
	 * 
	 * @author hebin
	 * @param id
	 * @param token
	 * @since JDK 1.7
	 */
	void delateDict(String id, String token) throws Exception;

	/**
	 * initDict:初始化页面. <br/>
	 * 
	 * @author hebin
	 * @param dict
	 * @param token
	 * @since JDK 1.7
	 */
	void initDict(PopularizeDict dict, String token) throws Exception;

	/**
	 * queryDataAll:(这里用一句话描述这个方法的作用). <br/>
	 * 
	 * @author hebin
	 * @param gradeId
	 * @param string
	 * @param token
	 * @return
	 * @since JDK 1.7
	 */
	List<DictData> queryDataAll(Layout layout, String token) throws Exception;

	/**  
	 * queryDataById:(这里用一句话描述这个方法的作用). <br/>   
	 *  
	 * @author hebin 
	 * @param id
	 * @param gradeId
	 * @param token
	 * @return  
	 * @since JDK 1.7  
	 */
	DictData queryDataById(String id, int gradeId, String token);

	/**  
	 * updateData:(这里用一句话描述这个方法的作用). <br/>   
	 *  
	 * @author hebin 
	 * @param data
	 * @param token  
	 * @since JDK 1.7  
	 */
	void updateData(DictData data, String token) throws Exception;

	/**  
	 * updateDict:(这里用一句话描述这个方法的作用). <br/>   
	 *  
	 * @author hebin 
	 * @param dict
	 * @param token  
	 * @since JDK 1.7  
	 */
	void updateDict(PopularizeDict dict, String token) throws Exception;
	
	List<ComponentData> queryComponentDataByPageId(String pageId, String token);
	
	void updateComponentData(ComponentData data, String token) throws Exception;
	
	void mergeInfoToBigSale(List<BigSalesGoodsRecord> list, String token) throws Exception;
	
	List<BigSalesGoodsRecord> queryBigSaleData(String token);

}
