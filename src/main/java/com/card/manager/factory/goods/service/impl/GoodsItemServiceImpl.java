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

import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.goods.model.GoodsItemEntity;
import com.card.manager.factory.goods.model.GoodsPrice;
import com.card.manager.factory.goods.pojo.GoodsPojo;
import com.card.manager.factory.goods.pojo.GoodsStatusEnum;
import com.card.manager.factory.goods.pojo.ItemSpecsPojo;
import com.card.manager.factory.goods.service.GoodsItemService;
import com.card.manager.factory.supplier.model.SupplierEntity;
import com.card.manager.factory.system.mapper.StaffMapper;
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
	public void addEntity(GoodsPojo entity, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		GoodsItemEntity goodsItem = new GoodsItemEntity();
		goodsItem.setExciseTax(entity.getExciseFax());
		goodsItem.setSku(entity.getSku());
		goodsItem.setStatus(GoodsStatusEnum.INIT.getIndex());
		goodsItem.setItemCode(entity.getItemCode());
		goodsItem.setWeight(entity.getWeight());

		int itemid = staffMapper.nextVal(ServerCenterContants.GOODS_ITEM_ID_SEQUENCE);
		goodsItem.setItemId(SequeceRule.getGoodsItemId(itemid));
		goodsItem.setGoodsId(entity.getGoodsId());

		GoodsPrice goodsPrice = new GoodsPrice();
		goodsPrice.setProxyPrice(entity.getProxyPrice());
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

		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_ITEM_SAVE, token, true, goodsItem,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("插入失败:" + json.getString("errorCode") + "-" + json.getString("errorMsg"));
		}

	}

	@Override
	public GoodsItemEntity queryById(String id, String token) {
		SupplierEntity entity = new SupplierEntity();
		entity.setId(Integer.parseInt(id));

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_QUERY, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), GoodsItemEntity.class);
	}

	@Override
	public void beUse(String itemId, String token,String optId) throws Exception {
		GoodsItemEntity entity = new GoodsItemEntity();
		entity.setItemId(itemId);
		entity.setOpt(optId);
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_ITEM_BE_USE, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("插入失败:" + json.getString("errorCode") + "-" + json.getString("errorMsg"));
		}
	}

	@Override
	public void noBeFx(String itemId, String token,String optId)  throws Exception{
		GoodsItemEntity entity = new GoodsItemEntity();
		entity.setItemId(itemId);
		entity.setOpt(optId);
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_ITEM_NOT_BE_USE, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("插入失败:" + json.getString("errorCode") + "-" + json.getString("errorMsg"));
		}
	}

	@Override
	public void beFx(String itemId, String token,String optId)  throws Exception {
		GoodsItemEntity entity = new GoodsItemEntity();
		entity.setItemId(itemId);
		entity.setOpt(optId);

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_ITEM_BE_FX, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("插入失败:" + json.getString("errorCode") + "-" + json.getString("errorMsg"));
		}
	}

}
