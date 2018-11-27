package com.card.manager.factory.customer.controller;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.base.PageCallBack;
import com.card.manager.factory.base.Pagination;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.component.model.GradeBO;
import com.card.manager.factory.constants.Constants;
import com.card.manager.factory.customer.model.Address;
import com.card.manager.factory.customer.model.PostFeeDTO;
import com.card.manager.factory.customer.model.ShoppingCart;
import com.card.manager.factory.customer.model.SupplierPostFeeBO;
import com.card.manager.factory.customer.service.PurchaseService;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.goods.GoodsUtil;
import com.card.manager.factory.goods.model.BrandEntity;
import com.card.manager.factory.goods.model.FirstCatalogEntity;
import com.card.manager.factory.goods.model.GoodsBaseEntity;
import com.card.manager.factory.goods.model.GoodsEntity;
import com.card.manager.factory.goods.model.GoodsItemEntity;
import com.card.manager.factory.goods.model.GoodsTagBindEntity;
import com.card.manager.factory.goods.model.GoodsTagEntity;
import com.card.manager.factory.goods.pojo.ItemSpecsPojo;
import com.card.manager.factory.goods.service.CatalogService;
import com.card.manager.factory.goods.service.GoodsService;
import com.card.manager.factory.log.SysLogger;
import com.card.manager.factory.order.model.OrderGoods;
import com.card.manager.factory.order.model.OrderInfo;
import com.card.manager.factory.order.model.ThirdOrderInfo;
import com.card.manager.factory.order.model.UserInfo;
import com.card.manager.factory.order.service.OrderService;
import com.card.manager.factory.supplier.model.SupplierEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.user.model.Rebate;
import com.card.manager.factory.user.service.FinanceMngService;
import com.card.manager.factory.util.CalculationUtils;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/admin/customer/purchaseMng")
public class purchaseMngController extends BaseController {

	@Resource
	PurchaseService purchaseService;

	@Resource
	GoodsService goodsService;

	@Resource
	CatalogService catalogService;

	@Resource
	FinanceMngService financeMngService;
	
	@Resource
	OrderService orderService;

	@Resource
	SysLogger sysLogger;
	
	private static final Integer DEFAULT = 1;

	@RequestMapping("/purchaseList")
	public ModelAndView purchaseList(HttpServletRequest req, HttpServletResponse res) {
		StaffEntity opt = SessionUtils.getOperator(req);
		Map<String, Object> context = getRootMap();
		context.put(OPT, opt);
		List<GoodsTagEntity> tags = goodsService.queryGoodsTags(opt.getToken());
		context.put("tags", tags);
		List<FirstCatalogEntity> firsts = catalogService.queryAll(opt.getToken());
		context.put("firsts", firsts);
		List<BrandEntity> brands = CachePoolComponent.getBrands(opt.getToken());
		context.put("brands", brands);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", opt.getUserCenterId());
		params.put("gradeId", opt.getGradeId());
		params.put("platformSource", Constants.PLATFORMSOURCE);
		int countShoppingCart = purchaseService.getShoppingCartCount(params, opt.getToken());
		context.put("countShoppingCart", countShoppingCart);
		GradeBO grade = CachePoolComponent.getGrade(opt.getToken()).get(opt.getGradeId());
		if (grade != null) {
			context.put("gradeType", grade.getGradeType());
		}
		return forword("customer/purchase/list", context);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, GoodsItemEntity item) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {

			String brandId = req.getParameter("brandId");
			if (!StringUtil.isEmpty(brandId)) {
				GoodsBaseEntity baseEntity = item.getBaseEntity();
				if (baseEntity != null) {
					baseEntity.setBrandId(brandId);
					item.setBaseEntity(baseEntity);
				} else {
					GoodsBaseEntity newBaseEntity = new GoodsBaseEntity();
					newBaseEntity.setBrandId(brandId);
					item.setBaseEntity(newBaseEntity);
				}
			}
			String tagId = req.getParameter("tagId");
			if (!StringUtil.isEmpty(tagId)) {
				GoodsTagBindEntity tagBindEntity = new GoodsTagBindEntity();
				tagBindEntity.setTagId(Integer.parseInt(tagId));
				item.setTagBindEntity(tagBindEntity);
			}
			String gradeType = req.getParameter("gradeType");
			item.setStatus("1");
			String typeId = item.getTypeId();
			String categoryId = item.getCategoryId();
			if (!StringUtil.isEmpty(typeId) && !StringUtil.isEmpty(categoryId)) {
				GoodsBaseEntity baseEntity = item.getBaseEntity();
				if (baseEntity != null) {
					if ("first".equals(typeId)) {
						baseEntity.setFirstCatalogId(categoryId);
					} else if ("second".equals(typeId)) {
						baseEntity.setSecondCatalogId(categoryId);
					} else if ("third".equals(typeId)) {
						baseEntity.setThirdCatalogId(categoryId);
					}
					item.setBaseEntity(baseEntity);
				} else {
					GoodsBaseEntity newBaseEntity = new GoodsBaseEntity();
					if ("first".equals(typeId)) {
						newBaseEntity.setFirstCatalogId(categoryId);
					} else if ("second".equals(typeId)) {
						newBaseEntity.setSecondCatalogId(categoryId);
					} else if ("third".equals(typeId)) {
						newBaseEntity.setThirdCatalogId(categoryId);
					}
					item.setBaseEntity(newBaseEntity);
				}
			}

			String itemId = req.getParameter("itemId");
			if (!StringUtil.isEmpty(itemId)) {
				item.setItemId(itemId);
			}
			String itemCode = req.getParameter("itemCode");
			if (!StringUtil.isEmpty(itemCode)) {
				item.setItemCode(itemCode);
			}
			String goodsName = req.getParameter("goodsName");
			if (!StringUtil.isEmpty(goodsName)) {
				item.setGoodsName(goodsName);
			}
			String hidGoodsName = req.getParameter("hidGoodsName");
			if (!StringUtil.isEmpty(hidGoodsName)) {
				item.setGoodsName(hidGoodsName);
			}

			GoodsEntity goodsEntity = new GoodsEntity();
			 goodsEntity.setType(2);
			item.setGoodsEntity(goodsEntity);

			params.put("centerId", staffEntity.getGradeId());
			params.put("shopId", staffEntity.getShopId());
			params.put("gradeLevel", staffEntity.getGradeLevel());

			pcb = purchaseService.dataList(item, params, staffEntity.getToken(),
					ServerCenterContants.GOODS_CENTER_ITEM_QUERY_FOR_PAGE, GoodsItemEntity.class);

			List<GoodsItemEntity> list = (List<GoodsItemEntity>) pcb.getObj();
			Map<String, String> rebateMap = null;
			for (GoodsItemEntity entity : list) {
				GoodsUtil.changeSpecsInfo(entity);
				if (gradeType != null && !"".equals(gradeType)) {
					rebateMap = goodsService.getGoodsRebate(entity.getItemId(), staffEntity.getToken());
					String rebateStr = rebateMap.get(gradeType);
					double rebate = Double.valueOf(rebateStr == null ? "0" : rebateStr);
					entity.setRebate(CalculationUtils.round(2,
							CalculationUtils.mul(entity.getGoodsPrice().getRetailPrice(), rebate)));
				}
				
				String infoStr = entity.getInfo();
				if (infoStr != null && !"".equals(infoStr)) {
					JSONArray jsonArray = JSONArray.fromObject(infoStr.substring(1, infoStr.length()));
					int index = jsonArray.size();
					List<ItemSpecsPojo> specslist = new ArrayList<ItemSpecsPojo>();
					for (int i = 0; i < index; i++) {
						JSONObject jObj = jsonArray.getJSONObject(i);
						specslist.add(JSONUtilNew.parse(jObj.toString(), ItemSpecsPojo.class));
					}
					
					String tmpStr = "";
					for (ItemSpecsPojo isp : specslist) {
						tmpStr = tmpStr + isp.getSkV() + ":" + isp.getSvV() + "|";
					}
					entity.setInfo(tmpStr.substring(0, tmpStr.length()-1));
				}
			}
			pcb.setObj(list);

		} catch (ServerCenterNullDataException e) {
			if (pcb == null) {
				pcb = new PageCallBack();
			}
			pcb.setPagination(item);
			pcb.setSuccess(true);
			return pcb;
		} catch (Exception e) {
			if (pcb == null) {
				pcb = new PageCallBack();
			}
			pcb.setErrTrace(e.getMessage());
			pcb.setSuccess(false);
			return pcb;
		}

		return pcb;
	}

	@RequestMapping(value = "/addItemToShoppingCart", method = RequestMethod.POST)
	public void addItemToShoppingCart(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity opt = SessionUtils.getOperator(req);
		try {
			String itemId = req.getParameter("itemId");
			String supplierId = req.getParameter("supplierId");
			String supplierName = java.net.URLDecoder.decode(req.getParameter("supplierName"), "UTF-8");
			String goodsName = java.net.URLDecoder.decode(req.getParameter("goodsName"), "UTF-8");
			if (StringUtil.isEmpty(itemId) || StringUtil.isEmpty(supplierId) || StringUtil.isEmpty(supplierName)
					|| StringUtil.isEmpty(goodsName)) {
				sendFailureMessage(resp, "添加购物车失败，缺少必要参数！");
				return;
			}

			ShoppingCart cartParam = new ShoppingCart();
			cartParam.setUserId(opt.getUserCenterId());
			cartParam.setItemId(itemId);
			cartParam.setQuantity(1);
			cartParam.setGradeId(opt.getGradeId());
			cartParam.setGoodsName(goodsName);
			cartParam.setSupplierId(Integer.parseInt(supplierId));
			cartParam.setSupplierName(supplierName);
			cartParam.setType(2);
			cartParam.setPlatformSource(Constants.PLATFORMSOURCE);
			purchaseService.addItemToShoppingCart(cartParam, opt.getToken());

			Map<String, Object> params = new HashMap<String, Object>();
			params.put("userId", opt.getUserCenterId());
			params.put("gradeId", opt.getGradeId());
			params.put("platformSource", Constants.PLATFORMSOURCE);
			int countShoppingCart = purchaseService.getShoppingCartCount(params, opt.getToken());
			sendSuccessMessage(resp, countShoppingCart + "");
		} catch (Exception e) {
			e.printStackTrace();
			sendFailureMessage(resp, e.getMessage());
		}
	}

	@RequestMapping("/shopCart")
	public ModelAndView shopCart(HttpServletRequest req, HttpServletResponse res) {
		StaffEntity opt = SessionUtils.getOperator(req);
		Map<String, Object> context = getRootMap();
		context.put(OPT, opt);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", opt.getUserCenterId());
		params.put("gradeId", opt.getGradeId());
		params.put("platformSource", Constants.PLATFORMSOURCE);
		int countShoppingCart = purchaseService.getShoppingCartCount(params, opt.getToken());
		context.put("countShoppingCart", countShoppingCart);
		GradeBO grade = CachePoolComponent.getGrade(opt.getToken()).get(opt.getGradeId());
		List<ShoppingCart> list = purchaseService.getShoppingCartInfo(params, opt.getToken());

		Map<String, String> rebateMap = null;
		Double totalMoney = 0.0;
		for (ShoppingCart entity : list) {
			transferItemInfo(entity);
			entity.setHref(entity.getHref().substring(1, entity.getHref().length()));
			rebateMap = goodsService.getGoodsRebate(entity.getItemId(), opt.getToken());
			String rebateStr = null;
			if (grade != null) {
				rebateStr = rebateMap.get(grade.getGradeType() + "");
			}
			double rebate = Double.valueOf(rebateStr == null ? "0" : rebateStr);
			entity.getGoodsSpecs().setMinPrice(CalculationUtils.round(2, CalculationUtils.sub(
					entity.getGoodsSpecs().getMinPrice(),
					CalculationUtils.round(2, CalculationUtils.mul(entity.getGoodsSpecs().getMinPrice(), rebate)))));
			entity.getGoodsSpecs().setMaxPrice(CalculationUtils.round(2,
					CalculationUtils.mul(entity.getGoodsSpecs().getMinPrice(), entity.getQuantity())));
			totalMoney += CalculationUtils.round(2,
					CalculationUtils.mul(entity.getGoodsSpecs().getMinPrice(), entity.getQuantity()));
		}
		if (list.size() > 1) {
			Collections.sort(list, list.get(0));
		}
		context.put("totalShoppingCartMoney", totalMoney);
		context.put("ShoppingCartInfoList", list);
		return forword("customer/shopCart/list", context);
	}

	private void transferItemInfo(ShoppingCart entity) {
		String info = entity.getGoodsSpecs().getInfo();
		if (info == null || "".equals(info)) {
			return;
		}

		entity.getGoodsSpecs().setOpt(info.substring(1, info.length() - 1).replace("\"", "~"));
		info = "[" + info.substring(1, info.length() - 1) + "]";
		JSONArray array = JSONArray.fromObject(info);
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < array.size(); i++) {
			JSONObject obj = array.getJSONObject(i);
			String[] infoList = obj.toString().split(",");
			for (String str : infoList) {
				sb.append(str.split(":")[1] + "|");
			}
		}
		entity.getGoodsSpecs().setInfo(sb.toString().substring(0, sb.length() - 2).replace("\"", ""));
	}

	@RequestMapping(value = "/deleteItemToShoppingCart", method = RequestMethod.POST)
	public void deleteItemToShoppingCart(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity opt = SessionUtils.getOperator(req);
		try {
			String ids = req.getParameter("ids");
			if (StringUtil.isEmpty(ids)) {
				sendFailureMessage(resp, "从购物车删除商品失败，缺少必要参数！");
				return;
			}

			Map<String, Object> params = new HashMap<String, Object>();
			params.put("userId", opt.getUserCenterId());
			params.put("gradeId", opt.getGradeId());
			params.put("ids", ids);
			params.put("platformSource", Constants.PLATFORMSOURCE);
			purchaseService.deleteItemToShoppingCart(params, opt.getToken());
			sendSuccessMessage(resp, "");
		} catch (Exception e) {
			e.printStackTrace();
			sendFailureMessage(resp, e.getMessage());
		}
	}

	@RequestMapping("/toCheckOrderInfo")
	public ModelAndView toCheckOrderInfo(HttpServletRequest req, HttpServletResponse res) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);

		try {
			String ids = req.getParameter("ids");
			if (StringUtil.isEmpty(ids)) {
				context.put(MSG, "跳转到确认采购单页面失败，缺少必要参数！");
				return forword("error", context);
			}
			String itemInfoList = URLDecoder.decode(req.getParameter("itemInfoList"), "UTF-8");
			if (!StringUtil.isEmpty(itemInfoList)) {
				String[] itemInfoArr = itemInfoList.split(",");
				for (String itemInfo : itemInfoArr) {
					ShoppingCart cartParam = new ShoppingCart();
					cartParam.setUserId(opt.getUserCenterId());
					cartParam.setItemId(itemInfo.split("\\|")[0]);
					cartParam.setQuantity(Integer.parseInt(itemInfo.split("\\|")[1]));
					cartParam.setGradeId(opt.getGradeId());
					cartParam.setGoodsName("");
					cartParam.setSupplierId(0);
					cartParam.setSupplierName("");
					cartParam.setType(2);
					cartParam.setPlatformSource(Constants.PLATFORMSOURCE);
					purchaseService.addItemToShoppingCart(cartParam, opt.getToken());
				}
			}

			Map<String, Object> params = new HashMap<String, Object>();
			params.put("userId", opt.getUserCenterId());
			params.put("gradeId", opt.getGradeId());
			params.put("platformSource", Constants.PLATFORMSOURCE);
			List<ShoppingCart> list = purchaseService.getShoppingCartInfo(params, opt.getToken());
			List<ShoppingCart> showList = new ArrayList<ShoppingCart>();
			String[] idsArr = ids.split(",");
			for (String id : idsArr) {
				for (ShoppingCart entity : list) {
					if (id.equals(entity.getId() + "")) {
						showList.add(entity);
						break;
					}
				}
			}

			if (showList.size() > 1) {
				Collections.sort(showList, showList.get(0));
			}
			GradeBO grade = CachePoolComponent.getGrade(opt.getToken()).get(opt.getGradeId());
			Map<String, String> rebateMap = null;
			Map<Integer, Double> suppliersMap = new HashMap<Integer, Double>();
			Map<Integer, Integer> itemsMap = new HashMap<Integer, Integer>();
			Double totalMoney = 0.0;
			Integer totalWeight = 0;
			for (ShoppingCart entity : showList) {
				if (!suppliersMap.containsKey(entity.getSupplierId())) {
					suppliersMap.put(entity.getSupplierId(), 0.0);
				}
				if (!itemsMap.containsKey(entity.getSupplierId())) {
					itemsMap.put(entity.getSupplierId(), 0);
				}
				transferItemInfo(entity);
				entity.setHref(entity.getHref().substring(1, entity.getHref().length()));
				rebateMap = goodsService.getGoodsRebate(entity.getItemId(), opt.getToken());
				String rebateStr = rebateMap.get(grade.getGradeType() + "");
				double rebate = Double.valueOf(rebateStr == null ? "0" : rebateStr);
				entity.getGoodsSpecs()
						.setMinPrice(CalculationUtils.round(2,
								CalculationUtils.sub(entity.getGoodsSpecs().getMinPrice(), CalculationUtils.round(2,
										CalculationUtils.mul(entity.getGoodsSpecs().getMinPrice(), rebate)))));
				entity.getGoodsSpecs().setMaxPrice(CalculationUtils.round(2,
						CalculationUtils.mul(entity.getGoodsSpecs().getMinPrice(), entity.getQuantity())));
				totalMoney = CalculationUtils.round(2,
						CalculationUtils.mul(entity.getGoodsSpecs().getMinPrice(), entity.getQuantity()));
				totalWeight = entity.getGoodsSpecs().getWeight() * entity.getQuantity();
				suppliersMap.put(entity.getSupplierId(), suppliersMap.get(entity.getSupplierId()) + totalMoney);
				if (entity.getFreePost() == 0) {
					itemsMap.put(entity.getSupplierId(), itemsMap.get(entity.getSupplierId()) + totalWeight);
				}
			}
			context.put("ShoppingCartInfoList", showList);
			context.put("suppliersMap", suppliersMap);
			context.put("itemsMap", itemsMap);
			Map<String, Object> postFeeParams = new HashMap<String, Object>();
			postFeeParams.put("suppliersMap", suppliersMap);
			postFeeParams.put("itemsMap", itemsMap);
			String defaultProvince = "北京";
			Map<String, Object> addressParams = new HashMap<String, Object>();
			addressParams.put("userId", opt.getUserCenterId());
			List<Address> addressList = purchaseService.getUserAddressInfo(addressParams, opt.getToken());
			for (Address add : addressList) {
				if (DEFAULT.equals(add.getSetDefault())) {
					defaultProvince = add.getProvince();
					break;
				}
			}
			context.put("userAddressInfoList", addressList);
			postFeeParams.put("province", defaultProvince);
			postFeeParams.put("token", opt.getToken());
			List<SupplierPostFeeBO> postFeeList = calcPostFeeByParam(postFeeParams);
			context.put("postFeeList", postFeeList);
			Rebate rebate = financeMngService.queryRebate(opt.getGradeId(), opt.getToken());
			context.put("gradeRebateInfo", rebate);
		} catch (Exception e) {
			e.printStackTrace();
			context.put(MSG, e.getMessage());
			return forword("error", context);
		}
		return forword("customer/orderSure/list", context);
	}

	@RequestMapping(value = "/saveUserAddressInfoByParam", method = RequestMethod.POST)
	public void saveUserAddressInfoByParam(HttpServletRequest req, HttpServletResponse resp, @RequestBody Address addressInfo) {
		StaffEntity opt = SessionUtils.getOperator(req);
		try {
			String saveType = req.getParameter("saveType");
			if (StringUtil.isEmpty(saveType)) {
				sendFailureMessage(resp, "保存收货地址失败，缺少必要参数！");
				return;
			}
			addressInfo.setUserId(opt.getUserCenterId());
			addressInfo.setOpt(opt.getOptName());
			purchaseService.saveUserAddressInfo(addressInfo, saveType, opt.getToken());
			sendSuccessMessage(resp, "");
		} catch (Exception e) {
			e.printStackTrace();
			sendFailureMessage(resp, e.getMessage());
		}
	}

	@RequestMapping(value = "/refreshAddressList", method = RequestMethod.POST)
	public void refreshAddressList(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity opt = SessionUtils.getOperator(req);
		try {
			Map<String, Object> addressParams = new HashMap<String, Object>();
			addressParams.put("userId", opt.getUserCenterId());
			List<Address> addressList = purchaseService.getUserAddressInfo(addressParams, opt.getToken());
			sendSuccessObject(resp, addressList);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
	}

	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value = "/refreshSupplierPostFee", method = RequestMethod.POST)
	@ResponseBody
	public void refreshSupplierPostFee(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity opt = SessionUtils.getOperator(req);
		try {
			Map<String, Object> postFeeParams = new HashMap<String, Object>();
			String suppliersMapStr = req.getParameter("suppliersMap");
			JSONObject suppliersMapJsonObject = JSONObject.fromObject(suppliersMapStr);
			Iterator supplierKeyIter = suppliersMapJsonObject.keys();                
	        Map<Integer, Double> suppliersMap = new HashMap<Integer, Double>();
	        while (supplierKeyIter.hasNext()) {
	            String key = (String) supplierKeyIter.next(); 
	            suppliersMap.put(Integer.parseInt(key), (Double)suppliersMapJsonObject.get(key));
	        }
			String itemsMapStr = req.getParameter("itemsMap");
			JSONObject itemsMapJsonObject = JSONObject.fromObject(itemsMapStr);
			Iterator itemsKeyIter = suppliersMapJsonObject.keys();                
	        Map<Integer, Integer> itemsMap = new HashMap<Integer, Integer>();
	        while (itemsKeyIter.hasNext()) {
	            String key = (String) itemsKeyIter.next(); 
	            itemsMap.put(Integer.parseInt(key), (Integer)itemsMapJsonObject.get(key));
	        }
			postFeeParams.put("suppliersMap", suppliersMap);
			postFeeParams.put("itemsMap", itemsMap);
			String defaultProvince = URLDecoder.decode(req.getParameter("province"), "UTF-8");
			if (StringUtil.isEmpty(defaultProvince)) {
				defaultProvince = "北京";
			}
			postFeeParams.put("province", defaultProvince);
			postFeeParams.put("token", opt.getToken());
			List<SupplierPostFeeBO> postFeeList = calcPostFeeByParam(postFeeParams);
			sendSuccessObject(resp, postFeeList);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
	}
	
	@SuppressWarnings("unchecked")
	private List<SupplierPostFeeBO> calcPostFeeByParam(Map<String, Object> postFeeParams) {
		List<SupplierPostFeeBO> retList = new ArrayList<SupplierPostFeeBO>();
		try {
			Map<Integer, Double> suppliersMap = (Map<Integer, Double>)postFeeParams.get("suppliersMap");
			Map<Integer, Integer> itemsMap = (Map<Integer, Integer>)postFeeParams.get("itemsMap");
			List<PostFeeDTO> postFeeList = new ArrayList<PostFeeDTO>();
			List<PostFeeDTO> unPostFeeList = new ArrayList<PostFeeDTO>();
			PostFeeDTO postFee = null;
			SupplierPostFeeBO supplierPostFee = null;
			for (Integer supplierId: itemsMap.keySet()) {
				if (itemsMap.get(supplierId) != 0) {
					postFee = new PostFeeDTO();
					postFee.setCenterId(2);
					postFee.setPrice(suppliersMap.get(supplierId));
					postFee.setProvince(postFeeParams.get("province").toString());
					postFee.setSupplierId(supplierId);
					postFee.setWeight(itemsMap.get(supplierId));
					postFeeList.add(postFee);
				} else {
					postFee = new PostFeeDTO();
					postFee.setCenterId(2);
					postFee.setPrice(suppliersMap.get(supplierId));
					postFee.setProvince(postFeeParams.get("province").toString());
					postFee.setSupplierId(supplierId);
					postFee.setWeight(itemsMap.get(supplierId));
					unPostFeeList.add(postFee);
				}
			}
			if (postFeeList.size() > 0) {
				retList = purchaseService.getPostFeeByJsonStr(postFeeList, postFeeParams.get("token").toString());
			}
			
			if (retList.size() <= 0) {
				for (Integer supplierId: itemsMap.keySet()) {
					supplierPostFee = new SupplierPostFeeBO();
					supplierPostFee.setSupplierId(supplierId);
					supplierPostFee.setPostFee(CalculationUtils.round(2,0.0));
					retList.add(supplierPostFee);
				}
			} else {
				for (PostFeeDTO unPostfee: unPostFeeList) {
					supplierPostFee = new SupplierPostFeeBO();
					supplierPostFee.setSupplierId(unPostfee.getSupplierId());
					supplierPostFee.setPostFee(CalculationUtils.round(2,0.0));
					retList.add(supplierPostFee);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return retList;
	}
	
	@RequestMapping(value = "/getInfoToOrder", method = RequestMethod.POST)
	public void getInfoToOrder(HttpServletRequest req, HttpServletResponse resp, @RequestBody OrderInfo orderInfo) {
		StaffEntity opt = SessionUtils.getOperator(req);
		try {
			Rebate rebate = financeMngService.queryRebate(opt.getGradeId(), opt.getToken());
			Double surplusRebateMoney = CalculationUtils.round(2,CalculationUtils.sub(rebate.getAlreadyCheck(),orderInfo.getOrderDetail().getRebateFee()));
			Double orderTotalMoney = 0.0;
			if (Double.doubleToLongBits(surplusRebateMoney) >= Double.doubleToLongBits(0.00)) {
				for (OrderGoods orderGoods: orderInfo.getOrderGoodsList()) {
					orderGoods.setItemInfo(orderGoods.getItemInfo().replace("~", "\""));
					orderTotalMoney+= CalculationUtils.round(2,orderGoods.getActualPrice() * orderGoods.getItemQuantity());
				}
				orderTotalMoney+= CalculationUtils.round(2,orderInfo.getOrderDetail().getPostFee());
				if (Double.doubleToLongBits(orderTotalMoney) == Double.doubleToLongBits(orderInfo.getOrderDetail().getRebateFee())) {
					orderInfo.getOrderDetail().setPayType(Constants.REBATE_PAY);
				}
			}
			orderInfo.setUserId(opt.getUserCenterId());
			orderInfo.setCenterId(2);
			orderInfo.setCreateType(0);
			orderInfo.setExpressType(0);
			orderInfo.setShopId(opt.getGradeId());
			orderInfo.setOrderSource(Constants.PLATFORMSOURCE);
			String strCreateOrderReturnInfo = purchaseService.createOrderByParam(orderInfo, opt.getToken());
			
			String shopcartIds = req.getParameter("shopcartIds");
			if (StringUtil.isEmpty(shopcartIds)) {
				sendFailureMessage(resp, "订单创建成功，删除购物车内商品失败，缺少必要参数！");
				return;
			}
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("userId", opt.getUserCenterId());
			params.put("gradeId", opt.getGradeId());
			params.put("ids", shopcartIds);
			params.put("platformSource", Constants.PLATFORMSOURCE);
			purchaseService.deleteItemToShoppingCart(params, opt.getToken());
			
			sendSuccessMessage(resp, strCreateOrderReturnInfo);
		} catch (Exception e) {
			e.printStackTrace();
			sendFailureMessage(resp, e.getMessage());
		}
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/toPay")
	public ModelAndView toPay(HttpServletRequest req, HttpServletResponse res) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		try {
			String orderId = req.getParameter("orderId");
			OrderInfo entity = orderService.queryByOrderId(orderId, opt.getToken());
			entity.getOrderDetail().setPayment(CalculationUtils.sub(entity.getOrderDetail().getPayment(),entity.getOrderDetail().getRebateFee()));
			List<SupplierEntity> supplier = CachePoolComponent.getSupplier(opt.getToken());
			for (SupplierEntity sup : supplier) {
				if (entity.getSupplierId() == null) {
					break;
				}
				if (sup.getId() == entity.getSupplierId()) {
					entity.setSupplierName(sup.getSupplierName());
					break;
				}
			}

			Map<String, Object> params = new HashMap<String, Object>();
			params.put("orderId", orderId);
			PageCallBack pcb = null;
			Pagination pagination = new Pagination();
			pagination.setCurrentPage(1);
			pagination.setNumPerPage(1000);
			pcb = orderService.dataList(pagination, params, opt.getToken(),
					ServerCenterContants.ORDER_CENTER_QUERY_GOODS_FOR_PAGE, OrderGoods.class);
			List<OrderGoods> list = (List<OrderGoods>) pcb.getObj();
			for (OrderGoods info : list) {
				String infoStr = info.getItemInfo();
				if (infoStr != null && !"".equals(infoStr)) {
					String tmpStr = "";
					infoStr = infoStr.replace("{", "").replace("}", "");
					String[] infoArr = infoStr.split(",");
					for (int i = 0; i < infoArr.length; i++) {
						tmpStr = tmpStr + infoArr[i].replace("\"", "") + "|";
					}
					info.setItemInfo(tmpStr.substring(0, tmpStr.length()-1));
				}
			}
			entity.setOrderGoodsList(list);
			context.put("orderInfo", entity);
			String strInfo = req.getParameter("strInfo");
			context.put("strInfo", strInfo);
		} catch (Exception e) {
			e.printStackTrace();
			context.put(MSG, e.getMessage());
			return forword("error", context);
		}
		return forword("customer/pay/list", context);
	}
	
	@RequestMapping(value = "/continuePay", method = RequestMethod.POST)
	public void continuePay(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity opt = SessionUtils.getOperator(req);
		try {
			String orderId = req.getParameter("orderId");
			String payType = req.getParameter("payType");
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("payType", payType);
			params.put("orderId", orderId);
			String strReturnInfo = purchaseService.orderContinuePay(params, opt.getToken());
			sendSuccessMessage(resp, strReturnInfo);
		} catch (Exception e) {
			e.printStackTrace();
			sendFailureMessage(resp, e.getMessage());
		}
	}

	@RequestMapping(value = "/orderList")
	public ModelAndView orderList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		context.put("supplierId", CachePoolComponent.getSupplier(opt.getToken()));
		return forword("customer/orderList/list", context);
	}

	@RequestMapping(value = "/orderDataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack orderDataList(HttpServletRequest req, HttpServletResponse resp, OrderInfo pagination) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			pagination.setOrderId(req.getParameter("orderId"));
			List<OrderGoods> orderGoodsList = null;
			OrderGoods orderGoods = null;
			String itemId = req.getParameter("itemId");
			if (!StringUtil.isEmpty(itemId)) {
				orderGoods = new OrderGoods();
				orderGoods.setItemId(itemId);
			}
			String itemCode = req.getParameter("itemCode");
			if (!StringUtil.isEmpty(itemCode)) {
				if (orderGoods != null) {
					orderGoods.setItemCode(itemCode);
				} else {
					orderGoods = new OrderGoods();
					orderGoods.setItemCode(itemCode);
				}
			}
			String itemName = req.getParameter("itemName");
			if (!StringUtil.isEmpty(itemName)) {
				if (orderGoods != null) {
					orderGoods.setItemName(itemName);
				} else {
					orderGoods = new OrderGoods();
					orderGoods.setItemName(itemName);
				}
			}
			if (orderGoods != null) {
				orderGoodsList = new ArrayList<OrderGoods>();
				orderGoodsList.add(orderGoods);
				pagination.setOrderGoodsList(orderGoodsList);
			}
			
			List<ThirdOrderInfo> orderExpressList = null;
			ThirdOrderInfo thirdOrderInfo = null;
			String expressId = req.getParameter("expressId");
			if (!StringUtil.isEmpty(expressId)) {
				thirdOrderInfo = new ThirdOrderInfo();
				thirdOrderInfo.setExpressId(expressId);
			}
			if (thirdOrderInfo != null) {
				orderExpressList = new ArrayList<ThirdOrderInfo>();
				orderExpressList.add(thirdOrderInfo);
				pagination.setOrderExpressList(orderExpressList);
			}
			String status = req.getParameter("status");
			if (!StringUtil.isEmpty(status)) {
				pagination.setStatus(Integer.parseInt(status));
			}
			String supplierId = req.getParameter("supplierId");
			if (!StringUtil.isEmpty(supplierId)) {
				pagination.setSupplierId(Integer.parseInt(supplierId));
			}
			Integer gradeId = staffEntity.getGradeId();
			if (gradeId != 0 && gradeId != null) {
				pagination.setShopId(gradeId);
			}
			pagination.setUserId(staffEntity.getUserCenterId());
			//一般贸易&后台订单
			pagination.setOrderFlag(2);
			pagination.setOrderSource(Constants.PLATFORMSOURCE);
			
			String searchTime = req.getParameter("searchTime");
			if (!StringUtil.isEmpty(searchTime)) {
				String[] times = searchTime.split("~");
				pagination.setStartTime(times[0].trim());
				pagination.setEndTime(times[1].trim());
			}

			pcb = orderService.dataList(pagination, params, staffEntity.getToken(),
					ServerCenterContants.ORDER_CENTER_QUERY_FOR_PAGE, OrderInfo.class);
		} catch (ServerCenterNullDataException e) {
			if (pcb == null) {
				pcb = new PageCallBack();
			}
			pcb.setPagination(pagination);
			pcb.setSuccess(true);
			return pcb;
		} catch (Exception e) {
			if (pcb == null) {
				pcb = new PageCallBack();
			}
			pcb.setErrTrace(e.getMessage());
			pcb.setSuccess(false);
			return pcb;
		}
		return pcb;
	}

	@RequestMapping(value = "/toShow")
	public ModelAndView toShow(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {
			String orderId = req.getParameter("orderId");
			OrderInfo entity = orderService.queryByOrderId(orderId, opt.getToken());
			context.put("order", entity);
			UserInfo user = orderService.queryUserInfoByUserId(entity.getUserId()+"", opt.getToken());
			context.put("user", user);
			List<SupplierEntity> supplier = CachePoolComponent.getSupplier(opt.getToken());
			for (SupplierEntity sup : supplier) {
				if (entity.getSupplierId() == null) {
					break;
				}
				if (sup.getId() == entity.getSupplierId()) {
					entity.setSupplierName(sup.getSupplierName());
					break;
				}
			}
			List<StaffEntity> center = CachePoolComponent.getCenter(opt.getToken());
			for (StaffEntity cen : center) {
				if (entity.getCenterId() == null) {
					break;
				}
				if (cen.getGradeId() == entity.getCenterId()) {
					entity.setCenterName(cen.getGradeName());
					break;
				}
			}
			if (entity.getShopId() != null) {
				GradeBO grade = CachePoolComponent.getGrade(opt.getToken()).get(entity.getShopId());
				if (grade != null) {
					entity.setShopName(grade.getName());
				}
			}
			List<ThirdOrderInfo> orderExpressList = orderService.queryThirdOrderInfoByOrderId(orderId, opt.getToken());
			context.put("orderExpressList", orderExpressList);
			return forword("customer/orderList/show", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
	}
	
	@RequestMapping(value = "/confirmOrder", method = RequestMethod.POST)
	public void confirmOrder(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity opt = SessionUtils.getOperator(req);
		try {
			String orderId = req.getParameter("orderId");
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("userId", opt.getUserCenterId());
			params.put("orderId", orderId);
			purchaseService.confirmOrder(params, opt.getToken());
			sendSuccessMessage(resp, "");
		} catch (Exception e) {
			e.printStackTrace();
			sendFailureMessage(resp, e.getMessage());
		}
	}
	
	@RequestMapping(value = "/closeOrder", method = RequestMethod.POST)
	public void closeOrder(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity opt = SessionUtils.getOperator(req);
		try {
			String orderId = req.getParameter("orderId");
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("userId", opt.getUserCenterId());
			params.put("orderId", orderId);
			purchaseService.closeOrder(params, opt.getToken());
			sendSuccessMessage(resp, "");
		} catch (Exception e) {
			e.printStackTrace();
			sendFailureMessage(resp, e.getMessage());
		}
	}
}
