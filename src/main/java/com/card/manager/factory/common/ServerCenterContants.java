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
	public static final String AUTH_CENTER_PLATFORM_REGISTER = (TOKEN_NOT_NEED ? "/" : "/authcenter/")
			+ "auth/platform/register?userId={userId}&platUserType={platUserType}";

	/**
	 * 供应商中心url
	 */
	public static final String SUPPLIER_CENTER_QUERY_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/suppliercenter/")
			+ SERVER_CENTER_EDITION + "/supplier/queryForPage";
	public static final String SUPPLIER_CENTER_SAVE = (TOKEN_NOT_NEED ? "/" : "/suppliercenter/")
			+ SERVER_CENTER_EDITION + "/supplier/save";
	public static final String SUPPLIER_CENTER_QUERY = (TOKEN_NOT_NEED ? "/" : "/suppliercenter/")
			+ SERVER_CENTER_EDITION + "/supplier/query";
	public static final String SUPPLIER_CENTER_QUERY_ALL = (TOKEN_NOT_NEED ? "/" : "/suppliercenter/")
			+ SERVER_CENTER_EDITION + "/supplier/queryAll";
	public static final String SUPPLIER_CENTER_UPDATE = (TOKEN_NOT_NEED ? "/" : "/suppliercenter/")
			+ SERVER_CENTER_EDITION + "/supplier/update";

	/**
	 * 用户中心url
	 */
	public static final String USER_CENTER_REGISTER = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + "auth/"
			+ SERVER_CENTER_EDITION + "/user/register/erp";
	public static final String USER_CENTER_GRADE_QUERY_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/usercenter/")
			+ SERVER_CENTER_EDITION + "/grade/queryForPage";
	public static final String USER_CENTER_GRADE_SAVE = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + SERVER_CENTER_EDITION
			+ "/user/grade/save";
	public static final String USER_CENTER_GRADE_UPDATE = (TOKEN_NOT_NEED ? "/" : "/usercenter/")
			+ SERVER_CENTER_EDITION + "/grade/update";
	public static final String USER_CENTER_GRADE_QUERY = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + SERVER_CENTER_EDITION
			+ "/grade/query";
	public static final String USER_CENTER_GRADE_QUERY_CHILDREN = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + SERVER_CENTER_EDITION
			+ "/user/feign/grade/children";
	public static final String USER_CENTER_PHONE_CHECK = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + SERVER_CENTER_EDITION
			+ "/user/userNameVerify";
	public static final String USER_CENTER_PUSHUSER_REGISER = (TOKEN_NOT_NEED ? "/" : "/usercenter/auth/")
			+ SERVER_CENTER_EDITION + "/pushuser/register/{code}";
	public static final String USER_CENTER_MICRO_SHOP_QUERY = (TOKEN_NOT_NEED ? "/" : "/usercenter/")
			+ SERVER_CENTER_EDITION + "/shop/query";
	public static final String USER_CENTER_MICRO_SHOP_UPDATE = (TOKEN_NOT_NEED ? "/" : "/usercenter/")
			+ SERVER_CENTER_EDITION + "/shop/update";
	public static final String USER_CENTER_ALL_PUSH_USER = (TOKEN_NOT_NEED ? "/" : "/usercenter/")
			+ SERVER_CENTER_EDITION + "/pushuser/listAllPushUser";
	public static final String USER_CENTER_ALL_CUSTOMER = (TOKEN_NOT_NEED ? "/" : "/usercenter/")
			+ SERVER_CENTER_EDITION + "/user/customer";
	public static final String USER_CENTER_ALL_GRADE = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + SERVER_CENTER_EDITION
			+ "/user/feign/list-grade";
	public static final String USER_CENTER_GRADE_TYPE = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + SERVER_CENTER_EDITION
			+ "/grade/type";
	public static final String USER_CENTER_GRADE_TYPE_UPDATE = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + SERVER_CENTER_EDITION
			+ "/grade/type/update";
	public static final String USER_CENTER_GRADE_TYPE_BY_ID = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + SERVER_CENTER_EDITION
			+ "/grade/type/{id}";
	public static final String USER_CENTER_CHILDREN_GRADE_TYPE = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + SERVER_CENTER_EDITION
			+ "/grade/type/children";
	public static final String USER_CENTER_SHOPKEEPER_QUERY_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + SERVER_CENTER_EDITION
			+ "/cooperation/shopkeeper";
	public static final String USER_CENTER_PARTNER_QUERY_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + SERVER_CENTER_EDITION
			+ "/cooperation/partner";
	public static final String USER_CENTER_GRADE_INIT = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + SERVER_CENTER_EDITION
			+ "/grade/area-center/init/{id}";
	public static final String USER_CENTER_INVITER_IMPORT = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + SERVER_CENTER_EDITION
			+ "/welfare/inviter/import";
	public static final String USER_CENTER_INVITER_QUERY_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/usercenter/")
			+ SERVER_CENTER_EDITION + "/welfare/inviter/queryForPage";
	public static final String USER_CENTER_INVITER_UPDATE = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + SERVER_CENTER_EDITION
			+ "/welfare/inviter/update";
	public static final String USER_CENTER_INVITER_PRODUCE_CODE = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + SERVER_CENTER_EDITION
			+ "/welfare/inviter/produceCode";
	public static final String USER_CENTER_INVITER_SEND_PRODUCE_CODE = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + SERVER_CENTER_EDITION
			+ "/welfare/inviter/sendProduceCode";
	public static final String USER_CENTER_INVITER_STATISTIC = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + SERVER_CENTER_EDITION
			+ "/welfare/inviter/statistic/{gradeId}";
	public static final String USER_CENTER_UPDATE_WELFARE_TYPE_INFO = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + SERVER_CENTER_EDITION
			+ "/grade/updateWelfareType";
	public static final String USER_CENTER_GET_GRADE_TYPE_REBATEFORMULA = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + SERVER_CENTER_EDITION
			+ "/grade/rebate/formula/{id}";
	public static final String USER_CENTER_SAVE_GRADE_TYPE_REBATEFORMULA = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + SERVER_CENTER_EDITION
			+ "/grade/rebate/formula";
	public static final String USER_CENTER_LIST_GRADE_TYPE_REBATEFORMULA = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + SERVER_CENTER_EDITION
			+ "/grade/rebate/formula/{needPaging}";
	public static final String USER_CENTER_UPDATE_GRADE_TYPE_REBATEFORMULA = (TOKEN_NOT_NEED ? "/" : "/usercenter/") + SERVER_CENTER_EDITION
			+ "/grade/rebate/formula/update";
	/**
	 * 商品中心url
	 */
	/*------------------------品牌管理---------------------*/
	public static final String GOODS_CENTER_BRAND_QUERY_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/brand/queryForPage";
	public static final String GOODS_CENTER_BRAND_SAVE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/brand/save";
	public static final String GOODS_CENTER_BRAND_MODIFY = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/brand/modify";
	public static final String GOODS_CENTER_BRAND_QUERY = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/brand/query";
	public static final String GOODS_CENTER_BRAND_QUERY_ALL = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/brand/queryAll";
	public static final String GOODS_CENTER_BRAND_DELETE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/brand/remove?brandId={brandId}";
	public static final String GOODS_CENTER_SYNC_STOCK = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/syncStock";
	public static final String GOODS_CENTER_GET_REBATE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/item/rebate";

	/*------------------------规格管理---------------------*/
	public static final String GOODS_CENTER_SPECS_QUERY_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/specs/queryForPage";
	public static final String GOODS_CENTER_SPECS_SAVE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/specs/save";
	public static final String GOODS_CENTER_SPECS_SAVE_VALUE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/specs/saveValue";
	public static final String GOODS_CENTER_SPECS_SAVE_SPECS = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/specs/saveSpecs";
	public static final String GOODS_CENTER_SPECS_QUERY = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/specs/query";
	public static final String GOODS_CENTER_SPECS_QUERY_ALL = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/specs/queryAll";
	public static final String GOODS_CENTER_SPECS = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/specs/selectAllSpece";
	public static final String GOODS_CENTER_SPECS_VALUE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/specs/selectAllSpeceValue";
	public static final String GOODS_CENTER_SPECS_ADD = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/specs/save/new";
	public static final String GOODS_CENTER_SPECS_VALUE_ADD = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/specs/value/save";
	public static final String GOODS_CENTER_SPECS_ALL_INFO = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/specs/selectAllSpeceInfo";
	public static final String GOODS_CENTER_SPECS_UPDATE_VALUE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/specs/updateValue";
	public static final String GOODS_CENTER_SPECS_UPDATE_SPECS = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/specs/updateSpecs";


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
	public static final String GOODS_CENTER_CATALOG_QUERY_SECOND_ALL = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/catalog/querySecondAll";
	public static final String GOODS_CENTER_CATALOG_QUERY_THIRD_ALL = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/catalog/queryThirdAll";
	public static final String GOODS_CENTER_CATALOG_PUBLISH = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/navigation/publish";
	public static final String GOODS_CENTER_CATALOG_UPDATE_FIRST_CATALOG_BY_PARAM = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/catalog/updateFirstByParam";
	public static final String GOODS_CENTER_CATALOG_UPDATE_SECOND_CATALOG_BY_PARAM = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/catalog/updateSecondByParam";
	public static final String GOODS_CENTER_CATALOG_UPDATE_THIRD_CATALOG_BY_PARAM = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/catalog/updateThirdByParam";

	/*------------------------基础商品管理-----------------------*/
	public static final String GOODS_BASE_ID_SEQUENCE = "base";
	public static final String GOODS_CENTER_BASE_QUERY_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/base/queryForPage";
	public static final String GOODS_CENTER_BASE_SAVE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/base/save";
	public static final String GOODS_CENTER_BASE_QUERY = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/base/query";
	public static final String GOODS_CENTER_BASE_EDIT = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/base/edit";

	/*------------------------商品管理-----------------------*/
	public static final String GOODS_ID_SEQUENCE = "goods";

	public static final String GOODS_CENTER_QUERY_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/goods/queryForPage";
	public static final String GOODS_CENTER_SAVE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/goods/save";
	public static final String GOODS_PIC_BATCH_UPLOAD = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/maintain/files";
	public static final String GOODS_CENTER_QUERY = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/goods/query";
	public static final String GOODS_CENTER_THIRD_QUERY = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/goods/queryThird";
	public static final String GOODS_CENTER_QUERY_THIRD_GOODS = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION
			+ "/goods/third/queryForPage?sku={sku}&itemCode={itemCode}&supplierId={supplierId}&status={status}";
	public static final String GOODS_CENTER_EDIT = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/goods/edit";
	public static final String GOODS_CENTER_REMOVE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/goods/remove";
	public static final String GOODS_CENTER_SAVE_DETAIL_PATH = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/goods/saveDetailPath";
	public static final String GOODS_CENTER_GOODS_REBATE_QUERY_ALL = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/goodsRebate/queryAllGoods";
	public static final String GOODS_CENTER_GOODS_REBATE_QUERY_BY_ID = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/goodsRebate/queryById";
	public static final String GOODS_CENTER_GOODS_REBATE_UPDATE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/goodsRebate/updateRebate";
	public static final String GOODS_CENTER_SAVE_GOODSINFO = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/goods/saveGoodsInfo";
	public static final String GOODS_CENTER_QUERY_GOODSINFO_ENTITY = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/goods/queryGoodsInfoEntity?itemId={itemId}";
	public static final String GOODS_CENTER_UPDATE_GOODSINFO = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/goods/updateGoodsInfo";
	public static final String GOODS_CENTER_IMPORT_GOODSINFO = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/import/goods";
	public static final String GOODS_CENTER_CREATE_ITEMINFO = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/goods/saveItemInfo";
	public static final String GOODS_CENTER_QUERY_GOODSINFO_BY_GOODSID = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/goods/queryGoodsInfoByGoodsId";

	/*------------------------商品明细管理-----------------------*/
	public static final String GOODS_ITEM_ID_SEQUENCE = "goodsItem";

	public static final String GOODS_CENTER_ITEM_QUERY_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION
			+ "/goods/item/queryForPage?centerId={centerId}&shopId={shopId}&gradeLevel={gradeLevel}";
	public static final String GOODS_CENTER_ITEM_SAVE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/item/save";
	public static final String GOODS_CENTER_ITEM_UPDATE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/item/update";
	public static final String GOODS_CENTER_ITEM_QUERY = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/item/query";
	public static final String GOODS_CENTER_ITEM_BE_USE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/item/beUse";
	public static final String GOODS_CENTER_ITEM_BE_FX = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/item/beFx";
	public static final String GOODS_CENTER_ITEM_NOT_BE_USE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/unDistribution?itemId=";
	public static final String GOODS_CENTER_ITEM_NOT_BE_FX = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/item/notBeFx";
	public static final String GOODS_CENTER_ITEM_PUT_ON = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/upShelves";
	public static final String GOODS_CENTER_ITEM_PUT_OFF = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/downShelves";
	public static final String GOODS_CENTER_PURCHASE_ITEM_SYNC = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/itemSync/-1";
	public static final String GOODS_CENTER_PURCHASE_ITEM_QUERY_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/item/queryPurchaseItemForPage?centerId={centerId}";
	public static final String GOODS_CENTER_PURCHASE_ITEM_QUERY = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/item/queryPurchaseItem";
	public static final String GOODS_CENTER_PURCHASE_ITEM_QUERY_FOR_EDIT = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/item/queryPurchaseItemForEdit";
	public static final String GOODS_CENTER_PURCHASE_ITEM_QUERY_FOR_CHECK = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/item/queryPurchaseItemForCheck";
	public static final String GOODS_CENTER_PURCHASE_ITEM_EDIT = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/item/editPurchaseItem";
	public static final String GOODS_CENTER_ITEM_QUERY_FOR_PAGE_DOWNLOAD = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/item/queryForPageDownload?centerId={centerId}&gradeLevel={gradeLevel}";
	public static final String GOODS_CENTER_QUERY_GOODSLISTFORDOWNLOAD = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/item/queryGoodsInfoListForDownload";
	public static final String GOODS_CENTER_MAINTAIN_STOCK_BY_ITEMID = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/item/maintainStockByItemId";
	public static final String GOODS_CENTER_EXTENSION_QUERY_FOR_PAGE_DOWNLOAD = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/item/queryGoodsExtensionForPageDownload?centerId={centerId}&gradeLevel={gradeLevel}";
	public static final String GOODS_CENTER_QUERY_EXTENSION_INFO_BY_GOODSID = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/item/queryGoodsExtensionInfo";
	public static final String GOODS_CENTER_UPDATE_EXTENSION_INFO = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/item/updateGoodsExtensionInfo";
	public static final String GOODS_CENTER_PUBLISH_ERROR_LIST = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/publish/exception/{centerId}/{type}";
	public static final String GOODS_CENTER_PUBLISH = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/publish/{centerId}";
	public static final String GOODS_CENTER_UNPUBLISH = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/publish/del/{centerId}";
	/*------------------------商品标签管理-----------------------*/
	public static final String GOODS_CENTER_TAG_QUERY_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/goodsTag/queryForPage";
	public static final String GOODS_CENTER_BIND_TAG_BATCH = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/tag/batch-bind";
	public static final String GOODS_CENTER_TAG_SAVE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/") + SERVER_CENTER_EDITION
			+ "/goods/goodsTag/saveTag";
	public static final String GOODS_CENTER_QUERY_TAG_INFO = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/goodsTag/queryTagInfo";
	public static final String GOODS_CENTER_QUERY_TAG_LIST_INFO = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/goodsTag/queryTagListInfo";
	public static final String GOODS_CENTER_TAG_UPDATE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/goodsTag/modifyTag";
	public static final String GOODS_CENTER_TAG_REMOVE = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/goodsTag/removeTag";
	public static final String GOODS_CENTER_TAG_FUNC_QUERY_ALL = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/goodsTag/tagFunc";
	public static final String ORDER_CENTER_PRESELL_CANCLEFUNC = (TOKEN_NOT_NEED ? "/" : "/ordercenter/")
			+ SERVER_CENTER_EDITION + "/order/presell/pass";
	public static final String GOODS_CENTER_QUERY_GOODS_PIRCE_RATIO_LIST_INFO = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/item/queryGoodsPriceRatioListInfo";
	public static final String GOODS_CENTER_QUERY_GOODS_RATIO_PLATFORM_PAGE_INFO = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/item/queryGoodsRatioPlatformForPage";
	public static final String GOODS_CENTER_CREATE_GOODS_RATIO_PLATFORM_INFO = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/item/createGoodsRatioPlatformInfo";
	public static final String GOODS_CENTER_UPDATE_GOODS_RATIO_PLATFORM_INFO = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/item/updateGoodsRatioPlatformInfo";
	public static final String GOODS_CENTER_QUERY_GOODS_RATIO_PLATFORM_INFO = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/item/queryGoodsRatioPlatformForEdit";
	public static final String GOODS_CENTER_SYNC_GOODS_PRICE_RATIO_INFO = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/goods/item/syncGoodsPriceRatioInfo";

	/*------------------------销售订单管理-----------------------*/
	public static final String ORDER_CENTER_QUERY_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/ordercenter/")
			+ SERVER_CENTER_EDITION + "/order/stockOut/queryForPage";
	public static final String ORDER_CENTER_QUERY_GOODS_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/ordercenter/")
			+ SERVER_CENTER_EDITION + "/order/stockOut/queryForPageForGoods?orderId={orderId}";
	public static final String ORDER_CENTER_QUERY = (TOKEN_NOT_NEED ? "/" : "/ordercenter/") + SERVER_CENTER_EDITION
			+ "/order/stockOut/query";
	public static final String ORDER_CENTER_APPLY_ORDER_BACK = (TOKEN_NOT_NEED ? "/" : "/ordercenter/")
			+ SERVER_CENTER_EDITION + "/order/refunds/{orderId}";
	public static final String ORDER_CENTER_IMPORT_ORDER = (TOKEN_NOT_NEED ? "/" : "/ordercenter/")
			+ SERVER_CENTER_EDITION + "/order/import";
	public static final String ORDER_CENTER_AUDIT_ORDER_BACK = (TOKEN_NOT_NEED ? "/" : "/ordercenter/")
			+ SERVER_CENTER_EDITION + "/order/backcancel/{orderId}";
	public static final String ORDER_CENTER_QUERY_THIRD_INFO = (TOKEN_NOT_NEED ? "/" : "/ordercenter/")
			+ SERVER_CENTER_EDITION + "/order/stockOut/queryThirdInfo";
	public static final String ORDER_CENTER_CACHE = (TOKEN_NOT_NEED ? "/" : "/ordercenter/")
			+ SERVER_CENTER_EDITION + "/cache?gradeId={gradeId}&dataType={dataType}&time={time}&modelType={modelType}";
	public static final String ORDER_CENTER_QUERY_ORDERLISTFORDOWNLOAD = (TOKEN_NOT_NEED ? "/" : "/ordercenter/")
			+ SERVER_CENTER_EDITION + "/order/stockOut/queryOrdreInfoListForDownload?startTime={startTime}&endTime={endTime}&gradeId={gradeId}&supplierId={supplierId}";
	public static final String ORDER_CENTER_MAINTENANCEEXPRESS = (TOKEN_NOT_NEED ? "/" : "/ordercenter/")
			+ SERVER_CENTER_EDITION + "/order/stockOut/maintenance/express";
	public static final String ORDER_CENTER_SENDSTOCKINGOODINFOTOMJY = (TOKEN_NOT_NEED ? "/" : "/ordercenter/")
			+ SERVER_CENTER_EDITION + "/order/stockOut/sendStockInGoodsInfoToMJY";
	public static final String ORDER_CENTER_SENDSTOCKOUTGOODINFOTOMJY = (TOKEN_NOT_NEED ? "/" : "/ordercenter/")
			+ SERVER_CENTER_EDITION + "/order/stockOut/sendStockOutGoodsInfoToMJY";
	/*------------------------订货订单管理-----------------------*/
	public static final String ORDER_CENTER_QUERY_PURCHASE_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/ordercenter/")
			+ SERVER_CENTER_EDITION + "/order/purchase/queryForPage";
	/*------------------------预售订单管理-----------------------*/
	public static final String ORDER_CENTER_QUERY_PRESELL_FOR_PAGE = (TOKEN_NOT_NEED ? "/" : "/ordercenter/")
			+ SERVER_CENTER_EDITION + "/order/presell/queryForPage";
	
	
	/*----------------------运费模板管理--------------------------------*/
	public static final String ORDER_CENTER_POST_TEMPLATE_ENABLE = (TOKEN_NOT_NEED ? "/" : "/ordercenter/")
			+ SERVER_CENTER_EDITION + "/express/template/enable/{id}";
	public static final String ORDER_CENTER_POST_TEMPLATE_GET = (TOKEN_NOT_NEED ? "/" : "/ordercenter/")
			+ SERVER_CENTER_EDITION + "/express/template/{id}";
	public static final String ORDER_CENTER_POST_TEMPLATE_UPDATE = (TOKEN_NOT_NEED ? "/" : "/ordercenter/")
			+ SERVER_CENTER_EDITION + "/express/template/update";
	public static final String ORDER_CENTER_POST_TEMPLATE_SAVE = (TOKEN_NOT_NEED ? "/" : "/ordercenter/")
			+ SERVER_CENTER_EDITION + "/express/template/save";
	public static final String ORDER_CENTER_POST_TEMPLATE_QUERY = (TOKEN_NOT_NEED ? "/" : "/ordercenter/")
			+ SERVER_CENTER_EDITION + "/express/template/list";
	public static final String ORDER_CENTER_POST_EXPRESS_DELETE = (TOKEN_NOT_NEED ? "/" : "/ordercenter/")
			+ SERVER_CENTER_EDITION + "/express/template/express-fee/{id}";

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
	
	
	/*------------------------cms-----------------------*/
	public static final String GOODS_CENTER_CMS_RETRIEVE_DATAL = (TOKEN_NOT_NEED ? "/" : "/goodscenter/")
			+ SERVER_CENTER_EDITION + "/cms/index/";

	/**
	 * 日志中心url
	 */
	public static final String LOG_CENTER_EXCEPTION_LOG = (TOKEN_NOT_NEED ? "/" : "/logcenter/") + SERVER_CENTER_EDITION
			+ "/exception/log";
	public static final String LOG_CENTER_LOGINFO_LOG = (TOKEN_NOT_NEED ? "/" : "/logcenter/") + SERVER_CENTER_EDITION
			+ "/logInfo/log";

	/**
	 * 财务中心url
	 */
	public static final String FINANCE_CENTER_QUERY_CARDINFO = (TOKEN_NOT_NEED ? "/" : "/financecenter/")
			+ SERVER_CENTER_EDITION + "/finance/card/queryForPage";
	public static final String FINANCE_CENTER_CARDINFO_INSERT = (TOKEN_NOT_NEED ? "/" : "/financecenter/")
			+ SERVER_CENTER_EDITION + "/finance/card";
	public static final String FINANCE_CENTER_CARDINFO_UPDATE = (TOKEN_NOT_NEED ? "/" : "/financecenter/")
			+ SERVER_CENTER_EDITION + "/finance/modify/card";
	public static final String FINANCE_CENTER_CARDNO_CHECK = (TOKEN_NOT_NEED ? "/" : "/financecenter/")
			+ SERVER_CENTER_EDITION + "/finance/card/check";
	public static final String FINANCE_CENTER_CAPITALPOOL_REGISTER = (TOKEN_NOT_NEED ? "/" : "/financecenter/")
			+ SERVER_CENTER_EDITION + "/finance/capitalpool/register/{centerId}";
	public static final String FINANCE_CENTER_QUERY_CAPITALPOOL = (TOKEN_NOT_NEED ? "/" : "/financecenter/")
			+ SERVER_CENTER_EDITION + "/finance/listcalCapitalPool";
	public static final String FINANCE_CENTER_CENTER_CHARGE = (TOKEN_NOT_NEED ? "/" : "/financecenter/")
			+ SERVER_CENTER_EDITION + "/finance/recharge/{centerId}";
	public static final String FINANCE_CENTER_REBATE_QUERY = (TOKEN_NOT_NEED ? "/" : "/financecenter/")
			+ SERVER_CENTER_EDITION + "/finance/rebate/{gradeId}";
	public static final String FINANCE_CENTER_REBATE_DETAIL_QUERY = (TOKEN_NOT_NEED ? "/" : "/financecenter/")
			+ SERVER_CENTER_EDITION + "/finance/rebate/detail";
	public static final String FINANCE_CENTER_WITHDRAWALS_QUERY = (TOKEN_NOT_NEED ? "/" : "/financecenter/")
			+ SERVER_CENTER_EDITION + "/finance/withdrawal/queryForPage";
	public static final String FINANCE_CENTER_WITHDRAWALS_DETAIL_ID = (TOKEN_NOT_NEED ? "/" : "/financecenter/")
			+ SERVER_CENTER_EDITION + "/finance/withdrawal/detailById/{id}";
	public static final String FINANCE_CENTER_WITHDRAWALS_AUDIT = (TOKEN_NOT_NEED ? "/" : "/financecenter/")
			+ SERVER_CENTER_EDITION + "/finance/withdrawal/audit";
	public static final String FINANCE_CENTER_WITHDRAWALS_ADMIN_CHECK = (TOKEN_NOT_NEED ? "/" : "/financecenter/")
			+ SERVER_CENTER_EDITION + "/finance/rebate/list";
	public static final String FINANCE_CENTER_QUERY_CARD_BY_CARDID = (TOKEN_NOT_NEED ? "/" : "/financecenter/")
			+ SERVER_CENTER_EDITION + "/finance/card/queryByCardId";
	public static final String FINANCE_CENTER_CARDINFO_DELETE = (TOKEN_NOT_NEED ? "/" : "/financecenter/")
			+ SERVER_CENTER_EDITION + "/finance/card/{id}";
	public static final String FINANCE_CENTER_CARDINFO_LIST = (TOKEN_NOT_NEED ? "/" : "/financecenter/")
			+ SERVER_CENTER_EDITION + "/finance/card/{gradeId}";
	public static final String FINANCE_CENTER_USER_APPLY_WITHDRAWALS = (TOKEN_NOT_NEED ? "/" : "/financecenter/")
			+ SERVER_CENTER_EDITION + "/finance/withdrawal/apply";
	public static final String FINANCE_CENTER_REFILLING_QUERY = (TOKEN_NOT_NEED ? "/" : "/financecenter/")
			+ SERVER_CENTER_EDITION + "/finance/capital/recharge/queryForPage";
	public static final String FINANCE_CENTER_USER_APPLY_REFILLING = (TOKEN_NOT_NEED ? "/" : "/financecenter/")
			+ SERVER_CENTER_EDITION + "/finance/capital/recharge/apply/{centerId}";
	public static final String FINANCE_CENTER_REFILLING_DETAIL_ID = (TOKEN_NOT_NEED ? "/" : "/financecenter/")
			+ SERVER_CENTER_EDITION + "/finance/refilling/detailById/{id}";
	public static final String FINANCE_CENTER_REFILLING_AUDIT = (TOKEN_NOT_NEED ? "/" : "/financecenter/")
			+ SERVER_CENTER_EDITION + "/finance/rebate/recharge/audit";
	public static final String FINANCE_CENTER_CENTER_LIQUIDATION = (TOKEN_NOT_NEED ? "/" : "/financecenter/")
			+ SERVER_CENTER_EDITION + "/finance/capitalpool/liquidation/{centerId}";
	public static final String FINANCE_CENTER_GET_CAPITALPOOLOVERVIEW = (TOKEN_NOT_NEED ? "/" : "/financecenter/")
			+ SERVER_CENTER_EDITION + "/finance/capitalpool/capitalPoolOverview";
	public static final String FINANCE_CENTER_QUERY_CAPITALPOOL_DETAIL = (TOKEN_NOT_NEED ? "/" : "/financecenter/")
			+ SERVER_CENTER_EDITION + "/finance/capitalpool/detail";
	public static final String FINANCE_CENTER_ADD_CAPITALPOOL = (TOKEN_NOT_NEED ? "/" : "/financecenter/")
			+ SERVER_CENTER_EDITION + "/finance/capitalpool";
	
	/**
	 * 调度器管理中心url
	 */
	/*------------------------调度器管理---------------------*/
	public static final String TIMETASK_CENTER_QUERY_ALL_TIMETASK = (TOKEN_NOT_NEED ? "/" : "/timetaskcenter/")
			+ SERVER_CENTER_EDITION + "/timetask/queryAllTimeTask";
	public static final String TIMETASK_CENTER_QUERY_TIMETASK_BY_ID = (TOKEN_NOT_NEED ? "/" : "/timetaskcenter/")
			+ SERVER_CENTER_EDITION + "/timetask/queryTimeTaskById";
	public static final String TIMETASK_CENTER_START_TIMETASK = (TOKEN_NOT_NEED ? "/" : "/timetaskcenter/")
			+ SERVER_CENTER_EDITION + "/timetask/start";
	public static final String TIMETASK_CENTER_STOP_TIMETASK = (TOKEN_NOT_NEED ? "/" : "/timetaskcenter/")
			+ SERVER_CENTER_EDITION + "/timetask/stop";
	public static final String TIMETASK_CENTER_UPDATE_TIMETASK = (TOKEN_NOT_NEED ? "/" : "/timetaskcenter/")
			+ SERVER_CENTER_EDITION + "/timetask/update";
	
}
