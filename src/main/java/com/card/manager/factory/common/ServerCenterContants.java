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

	public static final String SERVER_CENTER_EDITION = "1.0";

	public static final boolean TOKEN_NOT_NEED = false;

	/**
	 * 
	 */
	public static final String TOKEN_PREFIX = "\"Bearer \"";

	public static final String FIRST_CATALOG = "first";
	public static final String SECOND_CATALOG = "second";
	public static final String THIRD_CATALOG = "third";
	
	public static final Integer FIRST_GRADE = 1;
	public static final Integer SECOND_GRADE = 2;
	public static final Integer THIRD_GRADE = 3;
	public static final Integer FOURTH_GRADE = 4;

	/**
	 * 权限中心url
	 */
	public static final String AUTH_CENTER_LOGIN = (TOKEN_NOT_NEED ? "/" : "/authcenter") + "/auth/login";
	public static final String AUTH_CENTER_REGISTER = (TOKEN_NOT_NEED ? "/" : "/authcenter") + "/auth/register";
	public static final String AUTH_CENTER_PLATFORM_REGISTER = (TOKEN_NOT_NEED ? "/" : "/authcenter/") + "auth/platform/register?userId={userId}&platUserType={platUserType}";

	/**
	 * 供应商中心url
	 */
	public static final String SUPPLIER_CENTER_QUERY_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/suppliercenter/")
			+ SERVER_CENTER_EDITION + "/supplier/queryForPage";
	public static final String SUPPLIER_CENTER_SAVE = (TOKEN_NOT_NEED ? "/" : "/suppliercenter/") + SERVER_CENTER_EDITION
			+ "/supplier/save";
	public static final String SUPPLIER_CENTER_QUERY = (TOKEN_NOT_NEED ? "/" : "/suppliercenter/")
			+ SERVER_CENTER_EDITION + "/supplier/query";
	public static final String SUPPLIER_CENTER_QUERY_ALL = (TOKEN_NOT_NEED ? "/" : "/suppliercenter/")
			+ SERVER_CENTER_EDITION + "/supplier/queryAll";
	

	/**
	 * 用户中心url
	 */
	public static final String USER_CENTER_REGISTER = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + "auth/"
			+ SERVER_CENTER_EDITION + "/user/register/erp";
	public static final String USER_CENTER_GRADE_QUERY_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/usercenter/")
			+ SERVER_CENTER_EDITION + "/grade/queryForPage";
	public static final String USER_CENTER_GRADE_SAVE = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + SERVER_CENTER_EDITION
			+ "/user/grade/save";
	public static final String USER_CENTER_GRADE_UPDATE = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + SERVER_CENTER_EDITION
			+ "/grade/update";
	public static final String USER_CENTER_GRADE_QUERY = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + SERVER_CENTER_EDITION
			+ "/grade/query";

	/**
	 * 商品中心url
	 */
	/*------------------------品牌管理---------------------*/
	public static final String GOODS_CENTER_BRAND_QUERY_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/brand/queryForPage";
	public static final String GOODS_CENTER_BRAND_SAVE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/brand/save";
	public static final String GOODS_CENTER_BRAND_MODIFY = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/brand/modify";
	public static final String GOODS_CENTER_BRAND_QUERY = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/brand/query";
	public static final String GOODS_CENTER_BRAND_QUERY_ALL = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/brand/queryAll";
	public static final String GOODS_CENTER_BRAND_DELETE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/brand/remove?brandId={brandId}";
	public static final String GOODS_CENTER_SYNC_STOCK = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/syncStock";

	/*------------------------规格管理---------------------*/
	public static final String GOODS_CENTER_SPECS_QUERY_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/specs/queryForPage";
	public static final String GOODS_CENTER_SPECS_SAVE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/specs/save";
	public static final String GOODS_CENTER_SPECS_SAVE_VALUE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/specs/saveValue";
	public static final String GOODS_CENTER_SPECS_SAVE_SPECS = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/specs/saveSpecs";
	public static final String GOODS_CENTER_SPECS_QUERY = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/specs/query";
	public static final String GOODS_CENTER_SPECS_QUERY_ALL = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/specs/queryAll";

	/*------------------------分类管理-----------------------*/
	public static final String GOODS_CENTER_CATALOG_QUERY = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/catalog/query";
	public static final String GOODS_CENTER_CATALOG_QUERY_FIRSR_ALL = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/catalog/queryFirstAll";
	public static final String GOODS_CENTER_CATALOG_QUERY_SECOND_BY_FIRST_ID = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/catalog/querySecondByFirstId";
	public static final String GOODS_CENTER_CATALOG_QUERY_THIRD_BY_SECOND_ID = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/catalog/queryThirdBySecondId";
	public static final String GOODS_CENTER_CATALOG_SAVE_FIRST_CATALOG = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/catalog/savefirst";
	public static final String GOODS_CENTER_CATALOG_SAVE_SECOND_CATALOG = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/catalog/savesecond";
	public static final String GOODS_CENTER_CATALOG_SAVE_THIRD_CATALOG = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/catalog/savethird";
	public static final String GOODS_CENTER_CATALOG_MODIFY_FIRST_CATALOG = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/catalog/modifyFirst";
	public static final String GOODS_CENTER_CATALOG_MODIFY_SECOND_CATALOG = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/catalog/modifySecond";
	public static final String GOODS_CENTER_CATALOG_MODIFY_THIRD_CATALOG = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/catalog/modifyThird";
	public static final String GOODS_CENTER_CATALOG_DELETE_CATALOG = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/catalog/delete?id={id}&type={type}";

	/*------------------------基础商品管理-----------------------*/
	public static final String GOODS_CENTER_BASE_QUERY_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/base/queryForPage";
	public static final String GOODS_CENTER_BASE_SAVE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/base/save";
	public static final String GOODS_CENTER_BASE_QUERY = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/base/query";
	public static final String GOODS_CENTER_BASE_EDIT = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/base/edit";

	/*------------------------商品管理-----------------------*/
	public static final String GOODS_ID_SEQUENCE = "goods";
	
	public static final String GOODS_CENTER_QUERY_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/goods/queryForPage";
	public static final String GOODS_CENTER_SAVE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/goods/save";
	public static final String GOODS_CENTER_QUERY = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/goods/query";
	public static final String GOODS_CENTER_THIRD_QUERY = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/goods/queryThird";
	public static final String GOODS_CENTER_QUERY_THIRD_GOODS = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/third/queryForPage?sku={sku}&itemCode={itemCode}&supplierId={supplierId}&status={status}";
	public static final String GOODS_CENTER_EDIT = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/goods/edit";
	public static final String GOODS_CENTER_REMOVE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/goods/remove";
	public static final String GOODS_CENTER_SAVE_DETAIL_PATH = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/goods/saveDetailPath";

	/*------------------------商品明细管理-----------------------*/
	public static final String GOODS_ITEM_ID_SEQUENCE = "goodsItem";
	
	public static final String GOODS_CENTER_ITEM_QUERY_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/item/queryForPage?centerId={centerId}&shopId={shopId}&gradeLevel={gradeLevel}";
	public static final String GOODS_CENTER_ITEM_SAVE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/item/save";
	public static final String GOODS_CENTER_ITEM_UPDATE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/item/update";
	public static final String GOODS_CENTER_ITEM_QUERY = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/item/query";
	public static final String GOODS_CENTER_ITEM_BE_USE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/item/beUse";
	public static final String GOODS_CENTER_ITEM_BE_FX = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/item/beFx";
	public static final String GOODS_CENTER_ITEM_NOT_BE_USE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/unDistribution?itemId=";
	public static final String GOODS_CENTER_ITEM_PUT_ON = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/upShelves";
	public static final String GOODS_CENTER_ITEM_PUT_OFF = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/downShelves";
	
	/*------------------------销售订单管理-----------------------*/
	public static final String ORDER_CENTER_QUERY_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/ordercenter/")
			+ SERVER_CENTER_EDITION + "/order/stockOut/queryForPage";
	public static final String ORDER_CENTER_QUERY_GOODS_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/ordercenter/")
			+ SERVER_CENTER_EDITION + "/order/stockOut/queryForPageForGoods?orderId={orderId}";
	public static final String ORDER_CENTER_QUERY = (TOKEN_NOT_NEED ? "/" : "/ordercenter/") + SERVER_CENTER_EDITION
			+ "/order/stockOut/query";
	
	
	/*------------------------商城管理-----------------------*/
	public static final int PC = 0;
	public static final int H5 = 1;
	
	public static final String GOODS_CENTER_MALL_QUERY_DICT_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/mall/index/queryDictForPage?code={code}&centerId={centerId}";
	public static final String GOODS_CENTER_MALL_QUERY_DATA_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/mall/index/queryDataForPage?dictId={dictId}&centerId={centerId}";
	public static final String GOODS_CENTER_MALL_QUERY_DICT = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/mall/index/queryDict";
	public static final String GOODS_CENTER_MALL_QUERY_DATA = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/mall/index/queryData";
	public static final String GOODS_CENTER_MALL_SAVE_DICT = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/mall/index/saveDict";
	public static final String GOODS_CENTER_MALL_SAVE_DATA = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/mall/index/saveData";
	public static final String GOODS_CENTER_MALL_DELETE_DICT = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/mall/index/deleteDict";
	public static final String GOODS_CENTER_MALL_DELETE_DATA = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/mall/index/deleteData";
	public static final String GOODS_CENTER_MALL_UPDATE_DICT = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/mall/index/updateDict";
	public static final String GOODS_CENTER_MALL_UPDATE_DATA = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/mall/index/updateData";
	public static final String GOODS_CENTER_MALL_INIT_DICT = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/mall/index/init";
	public static final String GOODS_CENTER_MALL_QUERY_DATA_ALL = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/mall/index/queryDataAll";

}
