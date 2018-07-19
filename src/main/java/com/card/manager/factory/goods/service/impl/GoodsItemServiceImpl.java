/**  
 * Project Name:cardmanager  
 * File Name:SupplierServiceImpl.java  
 * Package Name:com.card.manager.factory.supplier.service.impl  
 * Date:Nov 7, 20173:22:23 PM  
 *  
 */
package com.card.manager.factory.goods.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.card.manager.factory.annotation.Log;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.goods.model.GoodsItemEntity;
import com.card.manager.factory.goods.model.GoodsTagBindEntity;
import com.card.manager.factory.goods.pojo.GoodsExtensionEntity;
import com.card.manager.factory.goods.pojo.GoodsInfoListForDownload;
import com.card.manager.factory.goods.pojo.GoodsListDownloadParam;
import com.card.manager.factory.goods.service.GoodsItemService;
import com.card.manager.factory.log.SysLogger;
import com.card.manager.factory.supplier.model.SupplierEntity;
import com.card.manager.factory.system.mapper.StaffMapper;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * ClassName: SupplierServiceImpl <br/>
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

	@Resource
	SysLogger sysLogger;

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
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_ITEM_NOT_BE_FX, token, true,
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

		String[] arr = itemId.split(",");
		List<String> itemIdList = Arrays.asList(arr);
		// List<String> list = new ArrayList<String>();
		// list.add(itemId);
		ResponseEntity<String> query_result = helper.request(URLUtils.get("gateway")
				+ ServerCenterContants.GOODS_CENTER_ITEM_PUT_ON + "/" + staffEntity.getGradeId(),
				staffEntity.getToken(), true, itemIdList, HttpMethod.POST);

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
	public List<GoodsInfoListForDownload> queryGoodsInfoListForDownload(GoodsListDownloadParam param, String token) {

		sysLogger.debug("商品导出处理开始", System.currentTimeMillis() / 1000 + "");
		List<GoodsInfoListForDownload> list = new ArrayList<GoodsInfoListForDownload>();
		RestCommonHelper helper = new RestCommonHelper();
		sysLogger.debug("商品导出发送请求", System.currentTimeMillis() / 1000 + "");
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_QUERY_GOODSLISTFORDOWNLOAD, token, true,
				param, HttpMethod.POST);
		sysLogger.debug("商品导出收到回执", System.currentTimeMillis() / 1000 + "");
		JSONObject json = JSONObject.fromObject(query_result.getBody());
		sysLogger.debug("商品导出回执转换Json", System.currentTimeMillis() / 1000 + "");

		if (!json.getBoolean("success")) {
			return list;
		}

		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			list.add(JSONUtilNew.parse(jObj.toString(), GoodsInfoListForDownload.class));
		}
		sysLogger.debug("商品导出拼接list", System.currentTimeMillis() / 1000 + "");
		sysLogger.debug("商品导出处理结束", System.currentTimeMillis() / 1000 + "");

		return list;
	}

	@Override
	public GoodsExtensionEntity queryExtensionByGoodsId(String goodsId, String token) {
		GoodsExtensionEntity goodsExtension = new GoodsExtensionEntity();
		goodsExtension.setGoodsId(goodsId);
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_QUERY_EXTENSION_INFO_BY_GOODSID, token,
				true, goodsExtension, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), GoodsExtensionEntity.class);
	}

	@Override
	@Log(content = "更新商品推广信息操作", source = Log.BACK_PLAT, type = Log.MODIFY)
	public void updGoodsExtensionInfoEntity(GoodsExtensionEntity entity, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_UPDATE_EXTENSION_INFO,
				staffEntity.getToken(), true, entity, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("更新商品推广信息操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public void batchBindTag(String itemIds, String tagIds, StaffEntity staffEntity) {
		if (itemIds == null || tagIds == null) {
			return;
		}
		String[] itemIdArr = itemIds.split(",");
		String[] tagIdArr = tagIds.split(",");
		GoodsTagBindEntity entity = null;
		List<GoodsTagBindEntity> list = new ArrayList<GoodsTagBindEntity>();
		for (String itemId : itemIdArr) {
			for (String tagId : tagIdArr) {
				entity = new GoodsTagBindEntity();
				entity.setItemId(itemId);
				entity.setTagId(Integer.valueOf(tagId));
				entity.setOpt(staffEntity.getOptName());
				list.add(entity);
			}
		}
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_BIND_TAG_BATCH, staffEntity.getToken(),
				true, list, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			throw new RuntimeException("批量绑定商品标签出错:" + json.getString("errorMsg"));
		}
	}

	@Override
	public void publish(String goodsIds, StaffEntity staffEntity) {
		RestCommonHelper helper = new RestCommonHelper();
		String[] goodsIdArr = goodsIds.split(",");
		List<String> goodsIdList = Arrays.asList(goodsIdArr);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("centerId", staffEntity.getGradeId());

		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_PUBLISH,
				staffEntity.getToken(), true, goodsIdList, HttpMethod.POST, param);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			throw new RuntimeException("商品发布失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	public void unPublish(String goodsIds, StaffEntity staffEntity) {
		RestCommonHelper helper = new RestCommonHelper();
		String[] goodsIdArr = goodsIds.split(",");
		List<String> goodsIdList = Arrays.asList(goodsIdArr);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("centerId", staffEntity.getGradeId());

		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_UNPUBLISH,
				staffEntity.getToken(), true, goodsIdList, HttpMethod.POST, param);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			throw new RuntimeException("商品删除发布失败:" + json.getString("errorMsg"));
		}

	}
}
