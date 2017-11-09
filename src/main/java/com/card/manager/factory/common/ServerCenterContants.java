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

	/**
	 * 权限中心url
	 */
	public static final String AUTH_CENTER_LOGIN = "authcenter/auth/login";
	public static final String AUTH_CENTER_REGISTER = "authcenter/auth/register";
	
	/**
	 * 供应商中心url
	 */
	public static final String SUPPLIER_CENTER_QUERY_FOR_PAGE = "suppliercenter/" + SERVER_CENTER_EDITION+"/supplier/queryForPage";
	public static final String SUPPLIER_CENTER_SAVE = "suppliercenter/"+SERVER_CENTER_EDITION+"/supplier/save";
	public static final String SUPPLIER_CENTER_QUERY= "suppliercenter/"+SERVER_CENTER_EDITION+"/supplier/query";



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
	public static final String GOODS_CENTER_BRAND_QUERY_FOR_PAGE = "goodscenter/" + SERVER_CENTER_EDITION+"/goods/brand/queryForPage";
	public static final String GOODS_CENTER_BRAND_SAVE = "goodscenter/"+SERVER_CENTER_EDITION+"/goods/brand/save";
	public static final String GOODS_CENTER_BRAND_QUERY= "goodscenter/"+SERVER_CENTER_EDITION+"/goods/brand/query";

	


}
