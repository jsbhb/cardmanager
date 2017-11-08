/**  
 * Project Name:cardmanager  
 * File Name:ServerCenterService.java  
 * Package Name:com.card.manager.factory.common.serivce  
 * Date:Nov 7, 20175:19:40 PM  
 *  
 */
package com.card.manager.factory.common.serivce;

import java.util.Map;

import com.card.manager.factory.base.PageCallBack;
import com.card.manager.factory.base.Pagination;

/**
 * ClassName: ServerCenterService <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: Nov 7, 2017 5:19:40 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public interface ServerCenterService {

	/**
	 * 
	 * dataList:查询分页效果. <br/>
	 * 
	 * @author hebin
	 * @param pagination
	 *            分页参数
	 * @param params
	 *            请求参数
	 * @param token
	 *            令牌
	 * @param url
	 *            服务中心访问url
	 * @return
	 * @throws Exception
	 * @since JDK 1.7
	 */
	public PageCallBack dataList(Pagination pagination, Map<String, Object> params, String token, String url,
			Class<?> entityClass) throws Exception;

}
