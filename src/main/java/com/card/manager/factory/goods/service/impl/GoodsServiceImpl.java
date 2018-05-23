/**  
 * Project Name:cardmanager  
 * File Name:SupplierServiceImpl.java  
 * Package Name:com.card.manager.factory.supplier.service.impl  
 * Date:Nov 7, 20173:22:23 PM  
 *  
 */
package com.card.manager.factory.goods.service.impl;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Method;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.baidu.ueditor.PathFormat;
import com.card.manager.factory.annotation.Log;
import com.card.manager.factory.common.ResourceContants;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.ftp.common.ReadIniInfo;
import com.card.manager.factory.ftp.service.SftpService;
import com.card.manager.factory.goods.grademodel.GradeTypeDTO;
import com.card.manager.factory.goods.model.GoodsBaseEntity;
import com.card.manager.factory.goods.model.GoodsEntity;
import com.card.manager.factory.goods.model.GoodsFile;
import com.card.manager.factory.goods.model.GoodsItemEntity;
import com.card.manager.factory.goods.model.GoodsPrice;
import com.card.manager.factory.goods.model.GoodsRebateEntity;
import com.card.manager.factory.goods.model.GoodsStockEntity;
import com.card.manager.factory.goods.model.GoodsTagBindEntity;
import com.card.manager.factory.goods.model.GoodsTagEntity;
import com.card.manager.factory.goods.model.ThirdWarehouseGoods;
import com.card.manager.factory.goods.pojo.CreateGoodsInfoEntity;
import com.card.manager.factory.goods.pojo.GoodsInfoEntity;
import com.card.manager.factory.goods.pojo.GoodsPojo;
import com.card.manager.factory.goods.pojo.GoodsStatusEnum;
import com.card.manager.factory.goods.pojo.ImportGoodsBO;
import com.card.manager.factory.goods.pojo.ItemSpecsPojo;
import com.card.manager.factory.goods.service.GoodsService;
import com.card.manager.factory.supplier.model.SupplierEntity;
import com.card.manager.factory.system.mapper.StaffMapper;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.ExcelUtils;
import com.card.manager.factory.util.FileDownloadUtil;
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
	@Log(content = "新增商品明细信息操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void addEntity(GoodsPojo entity, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		int goodsIdSequence = staffMapper.nextVal(ServerCenterContants.GOODS_ID_SEQUENCE);

		GoodsEntity goods = new GoodsEntity();
		goods.setGoodsId(SequeceRule.getGoodsId(goodsIdSequence));
		goods.setTemplateId(entity.getTemplateId());
		goods.setGoodsName(entity.getName());
		goods.setSupplierId(entity.getSupplierId());
		goods.setSupplierName(entity.getSupplierName());
		goods.setBaseId(entity.getBaseId());
		goods.setOrigin(entity.getOrigin());
		goods.setThirdId(entity.getThirdId());

		GoodsItemEntity goodsItem = new GoodsItemEntity();
		goodsItem.setExciseTax(entity.getExciseFax());
		goodsItem.setSku(entity.getSku());
		goodsItem.setStatus(GoodsStatusEnum.INIT.getIndex() + "");
		goodsItem.setItemCode(entity.getItemCode());
		goodsItem.setWeight(entity.getWeight());

		int itemid = staffMapper.nextVal(ServerCenterContants.GOODS_ITEM_ID_SEQUENCE);
		goodsItem.setItemId(SequeceRule.getGoodsItemId(itemid));
		goodsItem.setGoodsId(goods.getGoodsId());

		GoodsPrice goodsPrice = new GoodsPrice();
		goodsPrice.setProxyPrice(entity.getProxyPrice());
		goodsPrice.setFxPrice(entity.getFxPrice());
		goodsPrice.setMax(entity.getMax());
		goodsPrice.setMin(entity.getMin());
		goodsPrice.setItemId(goodsItem.getItemId());
		goodsPrice.setOpt(entity.getOpt());
		goodsPrice.setRetailPrice(entity.getRetailPrice());

		List<GoodsFile> files = new ArrayList<GoodsFile>();
		if (entity.getPicPath() != null) {
			String[] goodsFiles = entity.getPicPath().split(",");
			for (String file : goodsFiles) {
				GoodsFile f = new GoodsFile();
				f.setPath(file);
				f.setGoodsId(goods.getGoodsId());
				files.add(f);
			}
		}

		goods.setFiles(files);

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

		// 新增商品时判断是否添加商品标签
		if (!"".equals(entity.getTagId()) && entity.getTagId() != null) {
			GoodsTagBindEntity goodsTagBindEntity = new GoodsTagBindEntity();
			goodsTagBindEntity.setItemId(goodsItem.getItemId());
			goodsTagBindEntity.setTagId(Integer.parseInt(entity.getTagId()));
			goods.setGoodsTagBind(goodsTagBindEntity);
		}

		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_SAVE + "?type=" + entity.getType(), token,
				true, goods, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("新增商品明细信息操作失败:" + json.getString("errorMsg"));
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

	@Override
	@Log(content = "更新商品明细信息操作", source = Log.BACK_PLAT, type = Log.MODIFY)
	public void updEntity(GoodsEntity entity, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_EDIT, token, true, entity, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("更新商品明细信息操作失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	@Log(content = "删除商品明细信息操作", source = Log.BACK_PLAT, type = Log.DELETE)
	public void delEntity(GoodsEntity entity, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_REMOVE, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("删除商品明细信息操作失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	public String getHtmlContext(String html, StaffEntity staffEntity) throws Exception {
		Document doc = Jsoup.parse(new URL(html), 3000);
		return htmlToCode(doc.toString());

	}

	private String htmlToCode(String context) {
		if (context == null) {
			return "";
		} else {
			context = context.replace("<html>", "");
			context = context.replace("</html>", "");
			context = context.replace("<body>", "");
			context = context.replace("</body>", "");
			context = context.replace("<head>", "");
			context = context.replace("</head>", "");
			context = context.replace("\n", "");
			context = context.replace("\t", "");
			context = context.replaceAll("\n\r", "<br>&nbsp;&nbsp;");
			context = context.replaceAll("\r\n", "<br>&nbsp;&nbsp;");// 这才是正确的！
			context = context.replaceAll("\t", "&nbsp;&nbsp;&nbsp;&nbsp;");
			return context;
		}
	}

	@Override
	@Log(content = "保存商品详情信息操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void saveHtml(String goodsId, String html, StaffEntity staffEntity) throws Exception {

		String savePath;
		String invitePath;

		savePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.HTML + "/";
		invitePath = URLUtils.get("static") + "/" + ResourceContants.HTML + "/";
		ReadIniInfo.getInstance();

		// long maxSize = ((Long) conf.get("maxSize")).longValue();
		//
		// if (!validType(suffix, (String[]) conf.get("allowFiles"))) {
		// return new BaseState(false, AppInfo.NOT_ALLOW_FILE_TYPE);
		// }

		savePath = PathFormat.parse(savePath);
		invitePath = PathFormat.parse(invitePath);

		// String physicalPath = (String) conf.get("rootPath") + savePath;

		InputStream is = new ByteArrayInputStream(html.getBytes("utf-8"));

		WebApplicationContext wac = ContextLoader.getCurrentWebApplicationContext();
		SftpService service = (SftpService) wac.getBean("sftpService");
		service.login();
		service.uploadFile(savePath, goodsId + ResourceContants.HTML_SUFFIX, is, "");

		GoodsEntity entity = new GoodsEntity();
		entity.setDetailPath(invitePath + goodsId + ResourceContants.HTML_SUFFIX);
		entity.setGoodsId(goodsId);

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_SAVE_DETAIL_PATH, staffEntity.getToken(),
				true, entity, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("保存商品详情信息操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public List<GoodsRebateEntity> queryGoodsRebateById(String id, String token) {
		List<GoodsRebateEntity> list = new ArrayList<GoodsRebateEntity>();

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_GOODS_REBATE_QUERY_BY_ID + "?itemId=" + id,
				token, true, null, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		JSONArray obj = json.getJSONArray("obj");
		if (obj == null || obj.size() == 0) {
			return null;
		}
		for (int i = 0; i < obj.size(); i++) {
			JSONObject jObj = obj.getJSONObject(i);
			list.add(JSONUtilNew.parse(jObj.toString(), GoodsRebateEntity.class));
		}
		return list;
	}

	@Override
	@Log(content = "更新商品返佣信息操作", source = Log.BACK_PLAT, type = Log.MODIFY)
	public void updGoodsRebateEntity(List<GoodsRebateEntity> list, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_GOODS_REBATE_UPDATE, token, true, list,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("更新商品返佣信息操作失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	public GoodsTagEntity queryGoodsTag(String tagId, String token) {
		RestCommonHelper helper = new RestCommonHelper();
		GoodsTagEntity goodsTag = new GoodsTagEntity();
		goodsTag.setId(Integer.parseInt(tagId));
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_QUERY_TAG_INFO, token, true, goodsTag,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), GoodsTagEntity.class);
	}

	@Override
	public List<GoodsTagEntity> queryGoodsTags(String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_QUERY_TAG_LIST_INFO, token, true, null,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		List<GoodsTagEntity> list = new ArrayList<GoodsTagEntity>();
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			list.add(JSONUtilNew.parse(jObj.toString(), GoodsTagEntity.class));
		}
		return list;
	}

	@Override
	@Log(content = "新增商品标签操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void addGoodsTag(GoodsTagEntity entity, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_TAG_SAVE, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("行政商品标签操作失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	@Log(content = "更新商品标签操作", source = Log.BACK_PLAT, type = Log.MODIFY)
	public void updateGoodsTagEntity(GoodsTagEntity entity, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_TAG_UPDATE, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("更新商品标签操作失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	public GoodsTagBindEntity queryGoodsTagBind(String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_QUERY_TAG_INFO, token, true, null,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), GoodsTagBindEntity.class);
	}

	@Override
	@Log(content = "删除商品标签操作", source = Log.BACK_PLAT, type = Log.DELETE)
	public void deleteGoodsTagEntity(GoodsTagEntity entity, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_TAG_REMOVE, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("删除商品标签失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	@Log(content = "新增商品信息操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void addGoodsInfoEntity(CreateGoodsInfoEntity entity, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		// 基础商品
		GoodsBaseEntity goodsBase = new GoodsBaseEntity();
		if (entity.getBaseId() == 0) {
			int baseId = staffMapper.nextVal(ServerCenterContants.GOODS_BASE_ID_SEQUENCE);
			goodsBase.setId(baseId);
			goodsBase.setBrandId(entity.getBrandId());
			goodsBase.setGoodsName(entity.getGoodsName());
			goodsBase.setBrand(entity.getBrand());
			goodsBase.setIncrementTax(entity.getIncrementTax() + "");
			goodsBase.setTariff(entity.getTariff() + "");
			goodsBase.setUnit(entity.getUnit());
			goodsBase.setHscode(entity.getHscode());
			goodsBase.setFirstCatalogId(entity.getFirstCatalogId());
			goodsBase.setSecondCatalogId(entity.getSecondCatalogId());
			goodsBase.setThirdCatalogId(entity.getThirdCatalogId());
			goodsBase.setCenterId(staffEntity.getGradeId());
		} else {
			goodsBase.setId(0);
		}

		int goodsIdSequence = staffMapper.nextVal(ServerCenterContants.GOODS_ID_SEQUENCE);

		GoodsEntity goods = new GoodsEntity();
		goods.setGoodsId(SequeceRule.getGoodsId(goodsIdSequence));
		goods.setSupplierId(entity.getSupplierId());
		goods.setSupplierName(entity.getSupplierName());
		if (entity.getBaseId() == 0) {
			goods.setBaseId(goodsBase.getId());
		} else {
			goods.setBaseId(entity.getBaseId());
		}
		// 还未涉及规格修改暂时默认0
		goods.setTemplateId(0);
		goods.setGoodsName(entity.getGoodsName());
		goods.setOrigin(entity.getOrigin());
		goods.setType(entity.getType());

		// -------------------保存商品详情---------------------//
		String savePath;
		String invitePath;
		savePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.HTML + "/";
		invitePath = URLUtils.get("static") + "/" + ResourceContants.HTML + "/";
		ReadIniInfo.getInstance();
		savePath = PathFormat.parse(savePath);
		invitePath = PathFormat.parse(invitePath);
		InputStream is = new ByteArrayInputStream(entity.getDetailInfo().getBytes("utf-8"));
		WebApplicationContext wac = ContextLoader.getCurrentWebApplicationContext();
		SftpService service = (SftpService) wac.getBean("sftpService");
		service.login();
		service.uploadFile(savePath, goods.getGoodsId() + ResourceContants.HTML_SUFFIX, is, "");
		goods.setDetailPath(invitePath + goods.getGoodsId() + ResourceContants.HTML_SUFFIX);
		// -------------------保存商品详情---------------------//
		// goods.setDetailPath(entity.getDetailInfo());

		GoodsItemEntity goodsItem = new GoodsItemEntity();
		int itemid = staffMapper.nextVal(ServerCenterContants.GOODS_ITEM_ID_SEQUENCE);
		goodsItem.setGoodsId(goods.getGoodsId());
		goodsItem.setItemId(SequeceRule.getGoodsItemId(itemid));
		goodsItem.setItemCode(entity.getItemCode());
		goodsItem.setSku(entity.getSku());
		goodsItem.setWeight(entity.getWeight());
		goodsItem.setExciseTax(entity.getExciseFax());
		goodsItem.setStatus(GoodsStatusEnum.INIT.getIndex() + "");
		goodsItem.setConversion(entity.getConversion());
		goodsItem.setEncode(entity.getEncode());

		GoodsPrice goodsPrice = new GoodsPrice();
		goodsPrice.setItemId(goodsItem.getItemId());
		goodsPrice.setMin(entity.getMin());
		goodsPrice.setMax(entity.getMax());
		goodsPrice.setProxyPrice(entity.getProxyPrice());
		goodsPrice.setFxPrice(entity.getFxPrice());
		goodsPrice.setRetailPrice(entity.getRetailPrice());
		goodsPrice.setOpt(entity.getOpt());

		goodsItem.setGoodsPrice(goodsPrice);
		goodsItem.setOpt(entity.getOpt());

		List<GoodsFile> files = new ArrayList<GoodsFile>();
		if (entity.getPicPath() != null) {
			String[] goodsFiles = entity.getPicPath().split(",");
			for (String file : goodsFiles) {
				GoodsFile f = new GoodsFile();
				f.setPath(file);
				f.setGoodsId(goods.getGoodsId());
				files.add(f);
			}
		}

		goods.setFiles(files);

		// 还未涉及规格修改暂时不调整
		// String keys = entity.getKeys();
		// String values = entity.getValues();
		//
		// List<ItemSpecsPojo> specsPojos = new ArrayList<ItemSpecsPojo>();
		// if (keys != null && values != null) {
		// String[] keyArray = keys.split(";");
		// String[] valueArray = values.split(";");
		// for (int i = 0; i < keyArray.length; i++) {
		// ItemSpecsPojo itemSpecsPojo;
		// if (keyArray[i].trim() != null || !"".equals(keyArray[i].trim())) {
		// itemSpecsPojo = new ItemSpecsPojo();
		// String[] kContesnts = keyArray[i].split(":");
		// itemSpecsPojo.setSkId(kContesnts[0]);
		// itemSpecsPojo.setSkV(kContesnts[1]);
		// String[] vContants = valueArray[i].split(":");
		// itemSpecsPojo.setSvId(vContants[0]);
		// itemSpecsPojo.setSvV(vContants[1]);
		// specsPojos.add(itemSpecsPojo);
		// }
		// }
		//
		// JSONArray json = JSONArray.fromObject(specsPojos);
		// goodsItem.setInfo(json.toString());
		// }

		goods.setGoodsItem(goodsItem);

		// 新增商品时判断是否添加商品标签
		if (!"".equals(entity.getTagId()) && entity.getTagId() != null) {
			GoodsTagBindEntity goodsTagBindEntity = new GoodsTagBindEntity();
			goodsTagBindEntity.setItemId(goodsItem.getItemId());
			goodsTagBindEntity.setTagId(Integer.parseInt(entity.getTagId()));
			goods.setGoodsTagBind(goodsTagBindEntity);
		}

		GoodsInfoEntity goodsInfoEntity = new GoodsInfoEntity();
		goodsInfoEntity.setGoodsBase(goodsBase);
		goodsInfoEntity.setGoods(goods);

		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_SAVE_GOODSINFO, staffEntity.getToken(),
				true, goodsInfoEntity, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("新增商品信息操作失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	public GoodsInfoEntity queryGoodsInfoEntityByItemId(String itemId, StaffEntity staffEntity) {
		RestCommonHelper helper = new RestCommonHelper();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("itemId", itemId);
		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_QUERY_GOODSINFO_ENTITY,
				staffEntity.getToken(), true, null, HttpMethod.POST, params);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), GoodsInfoEntity.class);
	}

	@Override
	@Log(content = "更新商品信息操作", source = Log.BACK_PLAT, type = Log.MODIFY)
	public void updGoodsInfoEntity(CreateGoodsInfoEntity entity, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		GoodsEntity goods = new GoodsEntity();
		goods.setGoodsId(entity.getGoodsId() + "");
		goods.setSupplierId(entity.getSupplierId());
		goods.setSupplierName(entity.getSupplierName());
		goods.setBaseId(entity.getBaseId());
		// 还未涉及规格修改暂时默认0
		goods.setTemplateId(0);
		goods.setGoodsName(entity.getGoodsName());
		goods.setOrigin(entity.getOrigin());
		goods.setType(entity.getType());

		// -------------------保存商品详情---------------------//
		String savePath;
		String invitePath;
		String pathId = "";
		if (entity.getGoodsDetailPath() != null) {
			pathId = entity.getGoodsDetailPath().substring(entity.getGoodsDetailPath().lastIndexOf("/") + 1);
			pathId = pathId.substring(0, pathId.lastIndexOf("."));
		}
		if (!pathId.equals(entity.getGoodsId() + "")) {
			pathId = entity.getGoodsId() + "";
		}
		savePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.HTML + "/";
		invitePath = URLUtils.get("static") + "/" + ResourceContants.HTML + "/";
		ReadIniInfo.getInstance();
		savePath = PathFormat.parse(savePath);
		invitePath = PathFormat.parse(invitePath);
		InputStream is = new ByteArrayInputStream(entity.getDetailInfo().getBytes("utf-8"));
		WebApplicationContext wac = ContextLoader.getCurrentWebApplicationContext();
		SftpService service = (SftpService) wac.getBean("sftpService");
		service.login();
		service.uploadFile(savePath, pathId + ResourceContants.HTML_SUFFIX, is, "");
		goods.setDetailPath(invitePath + pathId + ResourceContants.HTML_SUFFIX);
		// -------------------保存商品详情---------------------//
		// goods.setDetailPath(entity.getDetailInfo());

		GoodsItemEntity goodsItem = new GoodsItemEntity();
		goodsItem.setGoodsId(goods.getGoodsId());
		goodsItem.setItemId(entity.getItemId() + "");
		goodsItem.setItemCode(entity.getItemCode());
		goodsItem.setSku(entity.getSku());
		goodsItem.setWeight(entity.getWeight());
		goodsItem.setExciseTax(entity.getExciseFax());
		goodsItem.setStatus(entity.getItemStatus());
		goodsItem.setConversion(entity.getConversion());
		goodsItem.setEncode(entity.getEncode());

		GoodsPrice goodsPrice = new GoodsPrice();
		goodsPrice.setItemId(goodsItem.getItemId());
		goodsPrice.setMin(entity.getMin());
		goodsPrice.setMax(entity.getMax());
		goodsPrice.setProxyPrice(entity.getProxyPrice());
		goodsPrice.setFxPrice(entity.getFxPrice());
		goodsPrice.setRetailPrice(entity.getRetailPrice());
		goodsPrice.setOpt(entity.getOpt());

		goodsItem.setGoodsPrice(goodsPrice);
		goodsItem.setOpt(entity.getOpt());

		List<GoodsFile> files = new ArrayList<GoodsFile>();
		if (entity.getPicPath() != null) {
			String[] goodsFiles = entity.getPicPath().split(",");
			for (String file : goodsFiles) {
				GoodsFile f = new GoodsFile();
				f.setPath(file);
				f.setGoodsId(goods.getGoodsId());
				files.add(f);
			}
		}

		goods.setFiles(files);

		// 还未涉及规格修改暂时不调整
		// String keys = entity.getKeys();
		// String values = entity.getValues();
		//
		// List<ItemSpecsPojo> specsPojos = new ArrayList<ItemSpecsPojo>();
		// if (keys != null && values != null) {
		// String[] keyArray = keys.split(";");
		// String[] valueArray = values.split(";");
		// for (int i = 0; i < keyArray.length; i++) {
		// ItemSpecsPojo itemSpecsPojo;
		// if (keyArray[i].trim() != null || !"".equals(keyArray[i].trim())) {
		// itemSpecsPojo = new ItemSpecsPojo();
		// String[] kContesnts = keyArray[i].split(":");
		// itemSpecsPojo.setSkId(kContesnts[0]);
		// itemSpecsPojo.setSkV(kContesnts[1]);
		// String[] vContants = valueArray[i].split(":");
		// itemSpecsPojo.setSvId(vContants[0]);
		// itemSpecsPojo.setSvV(vContants[1]);
		// specsPojos.add(itemSpecsPojo);
		// }
		// }
		//
		// JSONArray json = JSONArray.fromObject(specsPojos);
		// goodsItem.setInfo(json.toString());
		// }

		goods.setGoodsItem(goodsItem);

		// 新增商品时判断是否添加商品标签
		if (!"".equals(entity.getTagId()) && entity.getTagId() != null) {
			GoodsTagBindEntity goodsTagBindEntity = new GoodsTagBindEntity();
			goodsTagBindEntity.setItemId(goodsItem.getItemId());
			goodsTagBindEntity.setTagId(Integer.parseInt(entity.getTagId()));
			goods.setGoodsTagBind(goodsTagBindEntity);
		}

		GoodsInfoEntity goodsInfoEntity = new GoodsInfoEntity();
		goodsInfoEntity.setGoods(goods);

		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_UPDATE_GOODSINFO, staffEntity.getToken(),
				true, goodsInfoEntity, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("更新商品信息操作失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	public List<GradeTypeDTO> queryGradeType(String id, String token) {
		List<GradeTypeDTO> list = new ArrayList<GradeTypeDTO>();

		RestCommonHelper helper = new RestCommonHelper();
		String url = URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_GRADE_TYPE;
		if (id != null) {
			url = url + "?id=" + id;
		}
		ResponseEntity<String> query_result = helper.request(url, token, true, null, HttpMethod.GET);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		JSONArray obj = json.getJSONArray("obj");
		if (obj == null || obj.size() == 0) {
			return null;
		}
		for (int i = 0; i < obj.size(); i++) {
			JSONObject jObj = obj.getJSONObject(i);
			list.add(JSONUtilNew.parse(jObj.toString(), GradeTypeDTO.class));
		}
		return list;
	}

	@Override
	public GradeTypeDTO queryGradeTypeById(String id, String token) {
		RestCommonHelper helper = new RestCommonHelper();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		String url = URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_GRADE_TYPE_BY_ID;
		ResponseEntity<String> query_result = helper.requestWithParams(url, token, true, null, HttpMethod.GET, params);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), GradeTypeDTO.class);
	}

	@Override
	public List<GradeTypeDTO> queryGradeTypeChildren(String id, String token) {
		List<GradeTypeDTO> list = new ArrayList<GradeTypeDTO>();

		RestCommonHelper helper = new RestCommonHelper();
		String url = URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_CHILDREN_GRADE_TYPE + "?id=" + id;
		ResponseEntity<String> query_result = helper.request(url, token, true, null, HttpMethod.GET);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		JSONArray obj = json.getJSONArray("obj");
		if (obj == null || obj.size() == 0) {
			return null;
		}
		for (int i = 0; i < obj.size(); i++) {
			JSONObject jObj = obj.getJSONObject(i);
			list.add(JSONUtilNew.parse(jObj.toString(), GradeTypeDTO.class));
		}
		return list;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, String> getGoodsRebate(String itemId, String token) {
		RestCommonHelper helper = new RestCommonHelper();
		String url = URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_GET_REBATE + "?itemId=" + itemId;
		ResponseEntity<String> query_result = helper.request(url, token, true, null, HttpMethod.GET);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), Map.class);
	}

	@Override
	public Map<String, Object> importGoodsInfo(String filePath, StaffEntity staffEntity) {
		List<ImportGoodsBO> list = ExcelUtils.instance().readExcel(filePath, ImportGoodsBO.class);
		StringBuilder sb = new StringBuilder();
		Map<Integer, GradeTypeDTO> map = CachePoolComponent.getGradeType(staffEntity.getToken());
		Map<String, Object> result = new HashMap<String, Object>();
		boolean success = true;
		if (list != null && list.size() > 0) {
			GoodsBaseEntity goodsBase = null;
			GoodsEntity goods = null;
			GoodsItemEntity goodsItem = null;
			GoodsPrice goodsPrice = null;
			GoodsRebateEntity goodsRebate = null;
			GoodsStockEntity goodsStock = null;
			Method method = null;
			GoodsInfoEntity goodsInfo = null;
			List<GoodsRebateEntity> rebateList = null;
			List<GoodsInfoEntity> goodsInfoList = new ArrayList<GoodsInfoEntity>();
			for (ImportGoodsBO model : list) {
				// 基础商品
				goodsBase = new GoodsBaseEntity();
				goodsBase.setBrandId(model.getBrandId());
				goodsBase.setGoodsName(model.getGoodsName());
				goodsBase.setBrand(model.getBrand());
				goodsBase.setIncrementTax(model.getIncrementTax() == null ? "0.16" : model.getIncrementTax());
				goodsBase.setTariff(model.getTariff() == null ? "0" : model.getTariff());
				goodsBase.setUnit(model.getUnit());
				goodsBase.setHscode(model.getHscode());
				goodsBase.setFirstCatalogId(model.getFirstCatalogId());
				goodsBase.setSecondCatalogId(model.getSecondCatalogId());
				goodsBase.setThirdCatalogId(model.getThirdCatalogId());
				goodsBase.setCenterId(staffEntity.getGradeId());
				if (!goodsBase.check()) {
					success = false;
					sb.append(model.getGoodsName() + ",");
					continue;
				}
				int baseId = staffMapper.nextVal(ServerCenterContants.GOODS_BASE_ID_SEQUENCE);
				goodsBase.setId(baseId);

				// goods表
				goods = new GoodsEntity();
				try {
					goods.setSupplierId(model.getSupplierId() == null || "".equals(model.getSupplierId()) ? -1
							: Integer.valueOf(model.getSupplierId()));
					goods.setType(model.getType() == null || "".equals(model.getType()) ? -1
							: Integer.valueOf(model.getType()));
				} catch (Exception e) {
					success = false;
					sb.append(model.getGoodsName() + ",");
					continue;
				}
				goods.setSupplierName(model.getSupplierName());
				goods.setBaseId(baseId);
				// 规格手动编辑
				goods.setTemplateId(0);
				goods.setGoodsName(model.getGoodsName());
				goods.setOrigin(model.getOrigin());
				int goodsIdSequence = staffMapper.nextVal(ServerCenterContants.GOODS_ID_SEQUENCE);
				goods.setGoodsId(SequeceRule.getGoodsId(goodsIdSequence));

				// goodsItem
				goodsItem = new GoodsItemEntity();
				goodsItem.setGoodsId(goods.getGoodsId());
				goodsItem.setItemCode(model.getItemCode());
				goodsItem.setSku(model.getSku());
				try {
					goodsItem.setWeight(model.getWeight() == null || "".equals(model.getWeight()) ? 0
							: Integer.valueOf(model.getWeight()));
					goodsItem.setExciseTax(model.getExciseFax() == null || "".equals(model.getExciseFax()) ? 0
							: Double.valueOf(model.getExciseFax()));
					goodsItem.setConversion(model.getConversion() == null || "".equals(model.getConversion()) ? 1
							: Integer.valueOf(model.getConversion()));
				} catch (Exception e) {
					success = false;
					sb.append(model.getGoodsName() + ",");
					continue;
				}
				goodsItem.setStatus(GoodsStatusEnum.USEFUL.getIndex() + "");
				goodsItem.setEncode(model.getEncode());
				if (!goodsItem.check()) {
					success = false;
					sb.append(model.getGoodsName() + ",");
					continue;
				}
				int itemid = staffMapper.nextVal(ServerCenterContants.GOODS_ITEM_ID_SEQUENCE);
				goodsItem.setItemId(SequeceRule.getGoodsItemId(itemid));

				// goodsPrice
				goodsPrice = new GoodsPrice();
				goodsPrice.setItemId(goodsItem.getItemId());
				if (model.getMin() == null || "".equals(model.getMin()) || model.getMax() == null
						|| "".equals(model.getMax()) || model.getRetailPrice() == null
						|| "".equals(model.getRetailPrice())) {
					sb.append(model.getGoodsName() + ",");
					success = false;
					continue;
				}
				try {
					goodsPrice.setMin(Integer.valueOf(model.getMin()));
					goodsPrice.setMax("-1".equals(model.getMax()) ? null : Integer.valueOf(model.getMax()));
					goodsPrice.setProxyPrice(model.getProxyPrice() == null || "".equals(model.getProxyPrice()) ? 0
							: Double.valueOf(model.getProxyPrice()));
					goodsPrice.setFxPrice(model.getFxPrice() == null || "".equals(model.getFxPrice()) ? 0
							: Double.valueOf(model.getFxPrice()));
					goodsPrice.setRetailPrice(Double.valueOf(model.getRetailPrice()));
					goodsPrice.setOpt(staffEntity.getOptName());
				} catch (Exception e) {
					success = false;
					sb.append(model.getGoodsName() + ",");
					continue;
				}

				goodsItem.setGoodsPrice(goodsPrice);
				goodsItem.setOpt(staffEntity.getOptName());

				goods.setGoodsItem(goodsItem);

				// 库存设置
				if (model.getStock() == null || "".equals(model.getStock())) {
					success = false;
					sb.append(model.getGoodsName() + ",");
					continue;
				}
				goodsStock = new GoodsStockEntity();
				try {
					goodsStock.setItemId(Integer.valueOf(goodsItem.getItemId()));
					goodsStock.setFxQty(Integer.valueOf(model.getStock()));
					goodsStock.setQpQty(Integer.valueOf(model.getStock()));
				} catch (Exception e) {
					success = false;
					sb.append(model.getGoodsName() + ",");
					continue;
				}
				goodsItem.setStock(goodsStock);

				// 返佣设置
				rebateList = new ArrayList<GoodsRebateEntity>();
				for (Map.Entry<Integer, GradeTypeDTO> entry : map.entrySet()) {
					try {
						method = ImportGoodsBO.class.getMethod("getRebate_" + entry.getKey());
						Object value = method.invoke(model);
						if (value != null) {
							goodsRebate = new GoodsRebateEntity();
							goodsRebate.setProportion(Double.valueOf(value.toString()));
							goodsRebate.setGradeType(entry.getKey());
							goodsRebate.setItemId(goodsItem.getItemId());
							rebateList.add(goodsRebate);
						}
					} catch (Exception e) {
						success = false;
						sb.append(model.getGoodsName() + ",");
						break;
					}
				}
				goodsInfo = new GoodsInfoEntity();
				goodsInfo.setGoods(goods);
				goodsInfo.setGoodsBase(goodsBase);
				goodsInfo.setGoodsRebateList(rebateList);
				goodsInfoList.add(goodsInfo);
			}
			if (success) {
				RestCommonHelper helper = new RestCommonHelper();
				ResponseEntity<String> usercenter_result = helper.request(
						URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_IMPORT_GOODSINFO,
						staffEntity.getToken(), true, goodsInfoList, HttpMethod.POST);

				JSONObject json = JSONObject.fromObject(usercenter_result.getBody());
				result.put("sucess", json.get("success"));
				result.put("msg", json.get("errorMsg"));
				return result;
			} else {
				result.put("success", success);
				result.put("msg", sb.append("以上商品信息不全或者有误").toString());
				return result;
			}
		} else { // 没有读到数据
			result.put("success", false);
			result.put("msg", "没有商品信息");
			return result;
		}
	}

	private static final String TEMPLATE_PATH = "EXCEL/GOODSTEMPLATE";
	private static final String FILE_NAME = "goodsTemplate.xlsx";

	@Override
	public void exportGoodsInfoTemplate(HttpServletRequest req, HttpServletResponse resp, StaffEntity staffEntity)
			throws IOException {
		Map<Integer, GradeTypeDTO> map = CachePoolComponent.getGradeType(staffEntity.getToken());
		WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
		ServletContext servletContext = webApplicationContext.getServletContext();
		String filePath = servletContext.getRealPath("/") + TEMPLATE_PATH + "/" + FILE_NAME;
		String name = ExcelUtils.instance().getLastColumn(filePath, 1);
		String id = name.split("_")[1];
		Set<Integer> keySet = map.keySet();
		List<Integer> keyList = new ArrayList<Integer>(keySet);
		Collections.sort(keyList);
		if (keyList.get(keyList.size() - 1) > Integer.valueOf(id)) {
			List<GradeTypeDTO> gradeTypeList = new ArrayList<GradeTypeDTO>();
			for (Integer typeId : keyList) {
				if (typeId > Integer.valueOf(id)) {
					gradeTypeList.add(map.get(typeId));
				}
			}
			ExcelUtils.instance().addHead(filePath, gradeTypeList);
		}
		FileDownloadUtil.downloadFileByBrower(req, resp, filePath, FILE_NAME);
	}

}
