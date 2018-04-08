/**  
 * Project Name:cardmanager  
 * File Name:SupplierServiceImpl.java  
 * Package Name:com.card.manager.factory.supplier.service.impl  
 * Date:Nov 7, 20173:22:23 PM  
 *  
 */
package com.card.manager.factory.goods.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.card.manager.factory.annotation.Log;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.goods.model.GoodsItemEntity;
import com.card.manager.factory.goods.model.GoodsPrice;
import com.card.manager.factory.goods.model.GoodsTagBindEntity;
import com.card.manager.factory.goods.pojo.GoodsPojo;
import com.card.manager.factory.goods.pojo.GoodsStatusEnum;
import com.card.manager.factory.goods.pojo.ItemSpecsPojo;
import com.card.manager.factory.goods.service.GoodsItemService;
import com.card.manager.factory.supplier.model.SupplierEntity;
import com.card.manager.factory.system.mapper.StaffMapper;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.SequeceRule;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * ClassName: SupplierServiceImpl <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: Nov 7, 2017 3:22:23 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
@Service
public class GoodsItemServiceImpl extends AbstractServcerCenterBaseService implements GoodsItemService {

	@Resource
	StaffMapper<?> staffMapper;

	@Override
	@Log(content = "新增商品明细信息操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void addEntity(GoodsPojo entity, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		GoodsItemEntity goodsItem = new GoodsItemEntity();
		goodsItem.setExciseTax(entity.getExciseFax());
		goodsItem.setSku(entity.getSku());
		goodsItem.setStatus(GoodsStatusEnum.INIT.getIndex() + "");
		goodsItem.setItemCode(entity.getItemCode());
		goodsItem.setWeight(entity.getWeight());

		int itemid = staffMapper.nextVal(ServerCenterContants.GOODS_ITEM_ID_SEQUENCE);
		goodsItem.setItemId(SequeceRule.getGoodsItemId(itemid));
		goodsItem.setGoodsId(entity.getGoodsId());

		GoodsPrice goodsPrice = new GoodsPrice();
		goodsPrice.setProxyPrice(entity.getProxyPrice());
		goodsPrice.setRetailPrice(entity.getRetailPrice());
		goodsPrice.setFxPrice(entity.getProxyPrice());
		goodsPrice.setMax(entity.getMax());
		goodsPrice.setMin(entity.getMin());
		goodsPrice.setItemId(goodsItem.getItemId());
		goodsPrice.setOpt(entity.getOpt());

		goodsItem.setGoodsPrice(goodsPrice);
		goodsItem.setOpt(entity.getOpt());

		String keys = entity.getKeys();
		String values = entity.getValues();

		List<ItemSpecsPojo> specsPojos = new ArrayList<ItemSpecsPojo>();
		if (keys != null && values != null) {
			String[] keyArray = keys.split(";");
			String[] valueArray = values.split(";");
			for (int i = 0; i < keyArray.length; i++) {
				ItemSpecsPojo itemSpecsPojo;
				if (keyArray[i].trim() != null || !"".equals(keyArray[i].trim())) {
					itemSpecsPojo = new ItemSpecsPojo();
					String[] kContesnts = keyArray[i].split(":");
					itemSpecsPojo.setSkId(kContesnts[0]);
					itemSpecsPojo.setSkV(kContesnts[1]);
					String[] vContants = valueArray[i].split(":");
					itemSpecsPojo.setSvId(vContants[0]);
					itemSpecsPojo.setSvV(vContants[1]);
					specsPojos.add(itemSpecsPojo);
				}
			}

			JSONArray json = JSONArray.fromObject(specsPojos);
			goodsItem.setInfo(json.toString());
		}
		

		//新增商品时判断是否添加商品标签
		if (!"".equals(entity.getTagId()) && entity.getTagId() != null) {
			GoodsTagBindEntity goodsTagBindEntity = new GoodsTagBindEntity();
			goodsTagBindEntity.setItemId(goodsItem.getItemId());
			goodsTagBindEntity.setTagId(Integer.parseInt(entity.getTagId()));
			goodsItem.setTagBindEntity(goodsTagBindEntity);
		}

		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_ITEM_SAVE, token, true, goodsItem,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("新增商品明细信息操作失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	public GoodsItemEntity queryById(String id, String token) {
		SupplierEntity entity = new SupplierEntity();
		entity.setId(Integer.parseInt(id));

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_ITEM_QUERY, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), GoodsItemEntity.class);
	}

	@Override
	@Log(content = "商品明细状态改为可用操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void beUse(String itemId, String token, String optId) throws Exception {
		GoodsItemEntity entity = new GoodsItemEntity();
		entity.setItemId(itemId);
		entity.setOpt(optId);
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_ITEM_BE_USE, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("商品明细状态改为可用操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	@Log(content = "商品明细状态改为不可分销操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void noBeFx(String itemId, String token, String optId) throws Exception {
		GoodsItemEntity entity = new GoodsItemEntity();
		entity.setItemId(itemId);
		entity.setOpt(optId);
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_ITEM_NOT_BE_USE + itemId, token, true,
				entity, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("商品明细状态改为不可分销操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	@Log(content = "商品明细状态改为可分销操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void beFx(String itemId, String token, String optId) throws Exception {
		GoodsItemEntity entity = new GoodsItemEntity();
		entity.setItemId(itemId);
		entity.setOpt(optId);

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_ITEM_BE_FX, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("商品明细状态改为可分销操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public void fx(String itemId, String token, String optid, int gradeId) throws Exception {

		List<String> list = new ArrayList<String>();
		list.add(itemId);

		String url = (ServerCenterContants.TOKEN_NOT_NEED ? "/" : "/goodscenter/")
				+ ServerCenterContants.SERVER_CENTER_EDITION + "/goods/syncgoods/" + gradeId;
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(URLUtils.get("gateway") + url, token, true, list,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("插入失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	@Log(content = "商品明细上架操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void puton(String itemId, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		List<String> list = new ArrayList<String>();
		list.add(itemId);
		ResponseEntity<String> query_result = helper.request(URLUtils.get("gateway")
				+ ServerCenterContants.GOODS_CENTER_ITEM_PUT_ON + "/" + staffEntity.getGradeId(),
				staffEntity.getToken(), true, list, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("商品明细上架失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	@Log(content = "商品明细下架操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void putoff(String itemId, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_ITEM_PUT_OFF + "/"
						+ staffEntity.getGradeId() + "?itemId=" + itemId,
				staffEntity.getToken(), true, null, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("商品明细下架操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	@Log(content = "商品明细同步库存操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void syncStock(String itemId, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		List<String> itemList = new ArrayList<String>();
		itemList.add(itemId);

		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_SYNC_STOCK, staffEntity.getToken(), true,
				itemList, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("商品明细同步库存操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	@Log(content = "更新商品明细信息操作", source = Log.BACK_PLAT, type = Log.MODIFY)
	public void updateEntity(GoodsPojo pojo, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		GoodsItemEntity goodsItem = new GoodsItemEntity();
		goodsItem.setExciseTax(pojo.getExciseFax());
		goodsItem.setSku(pojo.getSku());
		goodsItem.setItemCode(pojo.getItemCode());
		goodsItem.setWeight(pojo.getWeight());
		goodsItem.setItemId(pojo.getItemId());

		GoodsPrice goodsPrice = new GoodsPrice();
		goodsPrice.setProxyPrice(pojo.getProxyPrice());
		goodsPrice.setRetailPrice(pojo.getRetailPrice());
		goodsPrice.setFxPrice(pojo.getFxPrice());
		goodsPrice.setMax(pojo.getMax());
		goodsPrice.setMin(pojo.getMin());
		goodsPrice.setItemId(goodsItem.getItemId());
		goodsPrice.setOpt(pojo.getOpt());

		goodsItem.setGoodsPrice(goodsPrice);
		goodsItem.setOpt(pojo.getOpt());
		
		GoodsTagBindEntity goodsTagBindEntity = new GoodsTagBindEntity();
		goodsTagBindEntity.setItemId(pojo.getItemId());
		goodsTagBindEntity.setTagId(Integer.parseInt(pojo.getTagId()));
		goodsItem.setTagBindEntity(goodsTagBindEntity);

		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_ITEM_UPDATE, token, true, goodsItem,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("更新商品明细信息操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	@Log(content = "订货平台同步商品信息操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void TBSyncGoods(String itemId, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		List<String> list = new ArrayList<String>();
		list.add(itemId);
		ResponseEntity<String> query_result = helper.request(URLUtils.get("gateway")
				+ ServerCenterContants.GOODS_CENTER_PURCHASE_ITEM_SYNC,
				staffEntity.getToken(), true, list, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("订货平台同步商品信息操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public GoodsPrice queryPriceById(String id, StaffEntity staffEntity) {
		GoodsItemEntity entity = new GoodsItemEntity();
		entity.setItemId(id);

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_PURCHASE_ITEM_QUERY_FOR_EDIT, 
				staffEntity.getToken(), true, entity, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), GoodsPrice.class);
	}

	@Override
	public GoodsPrice queryCheckGoodsPriceById(String id, StaffEntity staffEntity) {
		GoodsItemEntity entity = new GoodsItemEntity();
		entity.setItemId(id);

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_PURCHASE_ITEM_QUERY_FOR_CHECK, 
				staffEntity.getToken(), true, entity, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), GoodsPrice.class);
	}

	@Override
	@Log(content = "更新商品明细价格信息操作", source = Log.BACK_PLAT, type = Log.MODIFY)
	public void editPrice(GoodsPrice price, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		
		ResponseEntity<String> query_result = helper.request(URLUtils.get("gateway")
				+ ServerCenterContants.GOODS_CENTER_PURCHASE_ITEM_EDIT,
				staffEntity.getToken(), true, price, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("更新商品明细价格信息操作失败:" + json.getString("errorMsg"));
		}
	}

}
