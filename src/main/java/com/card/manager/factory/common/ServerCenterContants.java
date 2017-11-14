/**  
 * Project Name:cardmanager  
 * File Name:ServerCenterContants.java  
 * Package Name:com.card.manager.factory.common  
 * Date:Oct 24, 20174:44:58 PM  
 *  
 */
package com.card.manager.factory.common;

/**
 * ClassName: ServerCenterContants <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: Oct 24, 2017 4:44:58 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class ServerCenterContants {

	private static final String SERVER_CENTER_EDITION = "1.0";

	/**
	 * 
	 */
	public static final String TOKEN_PREFIX = "\"Bearer \"";

	public static final String FIRST_CATALOG = "first";
	public static final String SECOND_CATALOG = "second";
	public static final String THIRD_CATALOG = "third";

	/**
	 * 权限中心url
	 */
	public static final String AUTH_CENTER_LOGIN = "authcenter/auth/login";
	public static final String AUTH_CENTER_REGISTER = "authcenter/auth/register";

	/**
	 * 供应商中心url
	 */
	public static final String SUPPLIER_CENTER_QUERY_FOR_PAGE = "suppliercenter/" + SERVER_CENTER_EDITION
			+ "/supplier/queryForPage";
	public static final String SUPPLIER_CENTER_SAVE = "suppliercenter/" + SERVER_CENTER_EDITION + "/supplier/save";
	public static final String SUPPLIER_CENTER_QUERY = "suppliercenter/" + SERVER_CENTER_EDITION + "/supplier/query";
	public static final String SUPPLIER_CENTER_QUERY_ALL = "suppliercenter/" + SERVER_CENTER_EDITION
			+ "/supplier/queryAll";

	/**
	 * 用户中心url
	 */
	public static final String USER_CENTER_REGISTER = "usercenter/auth/" + SERVER_CENTER_EDITION + "/user/register/erp";
	public static final String USER_CENTER_GRADE_QUERY_FOR_PAGE = "usercenter/" + SERVER_CENTER_EDITION
			+ "/grade/queryForPage";
	public static final String USER_CENTER_GRADE_SAVE = "usercenter/" + SERVER_CENTER_EDITION + "/user/grade/save";
	public static final String USER_CENTER_GRADE_QUERY = "usercenter/" + SERVER_CENTER_EDITION + "/grade/query";

	/**
	 * 商品中心url
	 */
	/*------------------------品牌管理---------------------*/
	public static final String GOODS_CENTER_BRAND_QUERY_FOR_PAGE = "goodscenter/" + SERVER_CENTER_EDITION
			+ "/goods/brand/queryForPage";
	public static final String GOODS_CENTER_BRAND_SAVE = "goodscenter/" + SERVER_CENTER_EDITION + "/goods/brand/save";
	public static final String GOODS_CENTER_BRAND_QUERY = "goodscenter/" + SERVER_CENTER_EDITION + "/goods/brand/query";
	public static final String GOODS_CENTER_BRAND_QUERY_ALL = "goodscenter/" + SERVER_CENTER_EDITION
			+ "/goods/brand/queryAll";
	/*------------------------分类管理-----------------------*/
	public static final String GOODS_CENTER_CATALOG_QUERY = "goodscenter/" + SERVER_CENTER_EDITION
			+ "/goods/catalog/query";
	public static final String GOODS_CENTER_CATALOG_QUERY_FIRSR_ALL = "goodscenter/" + SERVER_CENTER_EDITION
			+ "/goods/catalog/queryFirstAll";
	public static final String GOODS_CENTER_CATALOG_QUERY_SECOND_BY_FIRST_ID = "goodscenter/" + SERVER_CENTER_EDITION
			+ "/goods/catalog/querySecondByFirstId";
	public static final String GOODS_CENTER_CATALOG_QUERY_THIRD_BY_SECOND_ID = "goodscenter/" + SERVER_CENTER_EDITION
			+ "/goods/catalog/queryThirdBySecondId";
	public static final String GOODS_CENTER_CATALOG_SAVE_FIRST_CATALOG = "goodscenter/" + SERVER_CENTER_EDITION
			+ "/goods/catalog/savefirst";
	public static final String GOODS_CENTER_CATALOG_SAVE_SECOND_CATALOG = "goodscenter/" + SERVER_CENTER_EDITION
			+ "/goods/catalog/savesecond";
	public static final String GOODS_CENTER_CATALOG_SAVE_THIRD_CATALOG = "goodscenter/" + SERVER_CENTER_EDITION
			+ "/goods/catalog/savethird";
	/*------------------------基础商品管理-----------------------*/
	public static final String GOODS_CENTER_BASE_QUERY_FOR_PAGE = "goodscenter/" + SERVER_CENTER_EDITION
			+ "/goods/base/queryForPage";
	public static final String GOODS_CENTER_BASE_SAVE = "goodscenter/" + SERVER_CENTER_EDITION + "/goods/base/save";
	public static final String GOODS_CENTER_BASE_QUERY = "goodscenter/" + SERVER_CENTER_EDITION + "/goods/base/query";

}
