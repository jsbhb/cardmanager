package com.card.manager.factory.constants;

public class Constants {

	/**
	 * 界面操作类型
	 */
	public static final String EDIT = "1";
	public static final String ADD= "0";
	
	public static final String ACCOUNT_LOCKED = "1";
	public static final String ACCOUNT_RELEASE = "0";

	public static final String ACCOUNT_NEED_CHANGE_PWD = "1";
	public static final String ACCOUNT_NO_NEED_CHANGE_PWD = "0";
	
	/**
	 * 盘点状态机
	 */
	public static final String CNCHECK_WAITE = "1";
	public static final String CNCHECK_CHECKED = "2";
	public static final String CNCHECK_CANCEL = "3";
	public static final String CNCHECK_FAIL = "4";
	
	public static final String CNCHECK_TYPE_ERROR_SEND = "1";
	public static final String CNCHECK_TYPE_MISS_SEND = "2";
	public static final String CNCHECK_TYPE_STOCK_IN = "3";
	public static final String CNCHECK_TYPE_CHECK = "4";
	public static final String CNCHECK_TYPE_OTHER = "5";
	
	public static final String CNCHECK_ACTION_OVER = "1";
	public static final String CNCHECK_ACTION_LESS = "2";
	public static final String CNCHECK_ACTION_DEF = "3";


	

	// -----------------------进货状态----------------
	public final static Integer ASNSTOCK = 1;// 预进货
	public final static Integer ARRIVAL = 2;// 到港
	public final static Integer DECLAR = 3;// 报关
	public final static Integer FINEPOINT1 = 4;// 精点
	public final static Integer RECEIVING = 5;// 报备失败
	public final static Integer REPORT = 6;// 报备成功
	public final static Integer SHELVES = 7;// 上架
	public final static Integer REVOKE = 11;// 撤单
	public final static Integer DECLARE = 31;// 已申报
	public final static Integer DECLARE_FAIL = 32;// 申报失败
	public final static Integer ORDER_DIFF = 21;// 采购单差异
	public final static Integer CHANGE_ORDER = 41;// 改单
	public final static Integer ROUGH_UNREVIEW = 99;// 粗点未审核;
	public final static Integer ROUGH_REVIEW = 98;// 粗点已审核；

	public final static String DECL_REVIEW_INIT = "0";// 创建报检单；
	public final static String DECL_REVIEW_SUC = "1";// 审核通过；
	public final static String DECL_REVIEW_FAIL = "2";// 打回；

	public final static String DECL_REVIEW_SUC_RECORD = "81";// 审核通过；
	public final static String DECL_REVIEW_FAIL_RECORD = "82";// 打回；

	public final static String CUSTOM_REVIEW_INIT = "0";// 创建报关单；
	public final static String CUSTOM_REVIEW_SUC = "1";// 审核通过；
	public final static String CUSTOM_REVIEW_FAIL = "2";// 打回；

	public final static String CUSTOM_REVIEW_SUC_RECORD = "71";// 审核通过；
	public final static String CUSTOM_REVIEW_FAIL_RECORD = "72";// 打回；

	public final static Integer N_ROUGN = 0;// 未粗点
	public final static Integer Y_ROUGN = 1;// 已粗点
	public final static Integer FINEPOINT = 2;// 已精点
	public final static Integer WAREHOUST_PUTON = 3;// 仓库上架
	public final static Integer Y_RECORD = 0;// 已备案
	public final static Integer N_RECORD = 1;// 未备案
	
	public final static String N_ROUGN_STR = "0";// 未粗点
	public final static String Y_ROUGN_STR = "1";// 已粗点
	public final static String FINEPOINT_STR = "2";// 已精点
	public final static String WAREHOUST_PUTON_STR = "3";// 仓库上架
	public final static String Y_RECORD_STR = "0";// 已备案
	public final static String N_RECORD_STR = "1";// 未备案

	// ---------------------asngoodsplan状态周期----------------
	public final static Integer INIT = 0;// 初始状态
	public final static Integer ISROUGH = 1;// 粗点
	public final static Integer FINE_POINT = 2;// 精点
	public final static Integer REPORT_SUCC = 3;// 报备成功
	public final static Integer REPORT_FAIL = 4;// 报备失败
	public final static Integer PUTON = 5;// 上架
	public final static Integer FINE_POINT_DIFF = 11;// 精点差异
	public final static Integer GOODS_ORDER_DIFF = 21;// 采购单差异

	// ------------------是否锁定------------------
	public final static Integer UNLOCK = 0;// 解锁
	public final static Integer LOCK = 1;// 锁定

	// ------------------预进货类型(字符串)------------------
	public final static String LOCAL_STR = "0";// 本地
	public final static String CUS_TRAN__STR = "1";// 转关

	// ------------------预进货类型(数字)------------------
	public final static Integer LOCAL = 0;// 本地
	public final static Integer CUS_TRAN = 1;// 转关

	// ------------------采购单是否是菜鸟------------------
	public final static Integer NORMAL = 1;// 正常
	public final static Integer CAINIAO = 2;// 菜鸟\

	// ------------------商家是否菜鸟------------------
	public final static String SUP_NORMAL = "1";// 正常
	public final static String SUP_CAINIAO = "0";// 菜鸟

	// ------------------商家未删除------------------
	public final static Integer SUP_ISDEL = 1;// 已删除
	public final static Integer SUP_NOTDEL = 0;// 未删除

	/**
	 * oor表state状态
	 */
	public static final String ORDER_STATE_3 = "3";// 拣货移位完成
	public static final String ORDER_STATE_4 = "4";// 单据已打印
	public static final String ORDER_STATE_5 = "5";// 商品已取货
	public static final String ORDER_STATE_6 = "6";// 商品已配检

	public static final String DECL_PAGE_TYPE = "0";//
	public static final String CUSTOMS_PAGE_TYPE = "1";//

	/******************************** 入库单状态 **************************************/
	public static final String CN_STOCK_IN_INIT = "0";// 未理货
	public static final String CN_STOCK_IN_ARRIVAL = "1";// 接单
	public static final String CN_STOCK_IN_COMFIRM = "2";// 确认
	public static final String CN_STOCK_IN_REJECT = "3";// 拒单
	public static final String CN_STOCK_IN_CANCEL = "4";// 取消
	public static final String CN_STOCK_IN_BIND = "5";// 已绑定

	/******************************** 入库单理货状态 **************************************/
	public static final String TALLY_STATE_INIT = "0";// 未理货
	public static final String TALLY_STATE_TALLING = "1";// 理货中
	public static final String TALLY_STATE_TALLIED = "2";// 理货完毕

	/******************************** 单据状态回传接口 **************************************/
	public static final String WMS_REJECT = "WMS_REJECT";// 拒单
	public static final String WMS_RECEIVED = "WMS_RECEIVED";// 收货完成
	public static final String WMS_PRINT = "WMS_PRINT";// 打印
	public static final String WMS_PACKAGE = "WMS_PACKAGE";// 打包
	public static final String WMS_ONSALE = "WMS_ONSALE";// 上架完成
	public static final String WMS_LACK = "WMS_LACK";// 缺货
	public static final String WMS_ARRIVE = "WMS_ARRIVE";// 货到仓库
	public static final String WMS_ACCEPT = "WMS_ACCEPT";// 接单
	public static final String WMS_TALLING = "WMS_TALLING";// 理货中
	public static final String WMS_TALLIED = "WMS_TALLIED";// 接单完成

	/******************************** 理货结果类型 **************************************/
	public static final String MORE_THEN = "1";// 超数量
	public static final String MORE_GOODS = "2";// 超品
	public static final String SAME = "3";// 无差异

	/******************************** 是否差异单 **************************************/
	public static final String SUPPLY_STOCK_IN = "1";// 差异单
	public static final String NORMAL_STOCK_IN = "0";// 非差异单
	public static final String MOVE_STOCK_IN = "2";// 搬仓入库单
	
	/******************************** 理货商品类型 **************************************/
	public static final String QUALITY = "1";// 可销售库存(正品)
	public static final String IMPERFECT = "101";// 残次
	public static final String DAMAGE = "102";// 机损
	public static final String PACAGE = "103";// 箱损
	public static final String FROZEN = "201";// 冻结库存
	
	/******************************** 菜鸟API **************************************/
	public static final String WMS_STOCK_IN_TALLY_ORDER_UPLOAD = "WMS_STOCK_IN_TALLY_ORDER_UPLOAD";//上传理货信息
	public static final String WMS_ORDER_STATUS_UPLOAD = "WMS_ORDER_STATUS_UPLOAD";// 更新状态机
	public static final String WMS_STOCK_IN_ORDER_CONFIRM = "WMS_STOCK_IN_ORDER_CONFIRM";// 入库单确认
	public static final String WMS_SKU_INFO_CONFIRM = "WMS_SKU_INFO_CONFIRM";//商品信息回传
	public static final String WMS_INVENTORY_COUNT = "WMS_INVENTORY_COUNT";//商品信息回传
	public static final String WMS_STOCK_OUT_ORDER_CONFIRM = "WMS_STOCK_OUT_ORDER_CONFIRM";
	
	/******************************** kjb2c-API **************************************/
	public static final String IM_1 = "cnec_im_1";//入库单报备
	
	/**
	 * 订单状态：0:初始订单；1：国际物流锁定标记，库存被锁；2：单证放行；3:分类分拣；4:快递单打印；5出货；6退单；
	 * 7菜鸟订单(未指示)；11菜鸟订单(初始订单)；12拒单；13KJB2C下发但菜鸟未下发；14IM3报备失败；99国检抽检未打快递单印
	 * ；98国检抽检已打快递单；-2海关审核不通过，废单 ；21分配库存时有库存，分配库位时找不到
	 **/
	public static final String ORDER_INIT = "0";
	public static final String ORDER_LOCK = "1";
	public static final String ORDER_DZFX = "2";
	public static final String ORDER_CLASSIFICATION = "3";
	public static final String ORDER_PRINT = "4";
	public static final String ORDER_DELIVER = "5";
	public static final String ORDER_CANCEL = "6";
	public static final String ORDER_CN_UNINSTRUCT = "7";
	public static final String ORDER_CN_INIT = "11";
	public static final String ORDER_CN_REFUSE = "12";
	public static final String ORDER_KJB2C_ONLY = "13";
	public static final String ORDER_IM3_ERROR = "14";
	public static final String ORDER_SAMPLING_UNPRINT = "99";
	public static final String ORDER_SAMPLING_PRINT = "98";
	public static final String ORDER_CUSTOMS_UNPASS = "-2";
	public static final String ORDER_ERROR_CALLIB = "21";
	
	/**封装map*/
	public static final String STATUS = "status";
	public static final String SUCCESS = "success";
	public static final String MSG = "msg";
	
	/**动态页面请求状态值*/
	public static final String POST_SUCCESS = "0";
	public static final String POST_TIMEOUT = "1";
	
	
	/**SKU缓存信息*/
	public static final String SKUDATA = "skudata";
	public static final String SKUALL = "skuall";
	
	/**ShopInfo缓存*/
	public static final String SHOPINFOINFO = "shopinfoinfo";
	
	/**绑定入库单缓存*/
	public static final String BIND_STOCK_IN = "bindStockIn";
	
	/**Rule缓存*/
	public static final String RULE_INFO_CACHE = "RULE_INFO_CACHE";
	
	/**Rule缓存*/
	public static final String STOCK_OUT_STATISTIC = "0";
	public static final String STOCK_OUT_ACCEPT = "1";
	public static final String STOCK_OUT_PACKAGE = "2";
	public static final String STOCK_OUT_STOCTOUT = "3";
	
	public static final String STOCK_IN_STATISTIC = "1";
	
	/** 入库单来源标志：A,B:菜鸟入库单；1：国际物流入库单 **/
	public static final String ASNTAB_CN_A = "A";//32000仓
	public static final String ASNTAB_CN_B = "B";//5000仓
	public static final String ASNTAB_KJB2C = "1";
	
	/** 回传打包成功 */
	public static final String PACKAGE = "99";
	
	/******************************** 良品库 **************************************/
	public static final String QUALITY_GOODS_LIBRARY = "1";
	
	
	//菜鸟重量拦截
	public static final int MIN_WEIGHT = 10;
	public static final int MAX_WEIGHT = 50000;
	
	//SKU-DECLNO
	public static final String SKUDECL="sku-declNo";
	
	public static final String IM_3 = "cnec_im_3";//接收“订单号”、“SKU”、“报检单号”分配反馈
	
	//出库单状态机
	public static final String ST_INIT = "0";
	public static final String ST_ACCEPT = "1";
	public static final String ST_CONFIRM = "2";
	public static final String ST_REFUSE = "3";
	public static final String ST_CANCEL = "4";

	public static final Double FIRST_VERSION = 1.0;
}
