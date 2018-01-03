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
import com.card.manager.factory.goods.model.GoodsEntity;
import com.card.manager.factory.goods.model.GoodsItemEntity;
import com.card.manager.factory.goods.model.GoodsPrice;
import com.card.manager.factory.goods.model.ThirdWarehouseGoods;
import com.card.manager.factory.goods.pojo.GoodsPojo;
import com.card.manager.factory.goods.pojo.GoodsStatusEnum;
import com.card.manager.factory.goods.pojo.ItemSpecsPojo;
import com.card.manager.factory.goods.service.GoodsService;
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
public class GoodsServiceImpl extends AbstractServcerCenterBaseService implements GoodsService {

	@Resource
	StaffMapper<?> staffMapper;

	@Override
	public void addEntity(GoodsPojo entity, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		int goodsId = staffMapper.nextVal(ServerCenterContants.GOODS_ID_SEQUENCE);

		GoodsEntity goods = new GoodsEntity();
		goods.setGoodsId(SequeceRule.getGoodsId(goodsId));
		goods.setTemplateId(entity.getTemplateId());
		goods.setGoodsName(entity.getName());
		goods.setSupplierName(entity.getSupplierName());
		goods.setBaseId(entity.getBaseId());
		goods.setOrigin(entity.getOrigin());
		goods.setThirdId(entity.getThirdId());

		GoodsItemEntity goodsItem = new GoodsItemEntity();
		goodsItem.setExciseTax(entity.getExciseFax());
		goodsItem.setSku(entity.getSku());
		goodsItem.setStatus(GoodsStatusEnum.INIT.getIndex());
		goodsItem.setItemCode(entity.getItemCode());
		goodsItem.setWeight(entity.getWeight());
		
		int itemid = staffMapper.nextVal(ServerCenterContants.GOODS_ITEM_ID_SEQUENCE);
		goodsItem.setItemId(SequeceRule.getGoodsItemId(itemid));
		goodsItem.setGoodsId(goods.getGoodsId());
		
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

		goods.setGoodsItem(goodsItem);

		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_SAVE + "?type=" + entity.getType(), token,
				true, goods, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("插入失败:" + json.getString("errorCode") + "-" + json.getString("errorMsg"));
		}

	}

	@Override
	public GoodsEntity queryById(String id, String token) {
		SupplierEntity entity = new SupplierEntity();
		entity.setId(Integer.parseInt(id));

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_QUERY, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), GoodsEntity.class);
	}

	/**
	 * TODO 简单描述该方法的实现功能（可选）.
	 * 
	 * @see com.card.manager.factory.goods.service.GoodsService#queryThirdById(java.lang.String,
	 *      java.lang.String)
	 */
	@Override
	public ThirdWarehouseGoods queryThirdById(String id, String token) {
		ThirdWarehouseGoods entity = new ThirdWarehouseGoods();
		entity.setId(id);

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_THIRD_QUERY, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), ThirdWarehouseGoods.class);
	}

}
