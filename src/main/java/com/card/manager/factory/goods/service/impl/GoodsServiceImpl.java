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
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.net.ssl.HttpsURLConnection;
import javax.script.ScriptException;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.map.CaseInsensitiveMap;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.card.manager.factory.annotation.Log;
import com.card.manager.factory.common.ResourceContants;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.goods.grademodel.GradeTypeDTO;
import com.card.manager.factory.goods.model.BrandEntity;
import com.card.manager.factory.goods.model.CatalogEntity;
import com.card.manager.factory.goods.model.FirstCatalogEntity;
import com.card.manager.factory.goods.model.GoodsBaseEntity;
import com.card.manager.factory.goods.model.GoodsEntity;
import com.card.manager.factory.goods.model.GoodsFile;
import com.card.manager.factory.goods.model.GoodsItemEntity;
import com.card.manager.factory.goods.model.GoodsPrice;
import com.card.manager.factory.goods.model.GoodsPriceRatioEntity;
import com.card.manager.factory.goods.model.GoodsRebateEntity;
import com.card.manager.factory.goods.model.GoodsStockEntity;
import com.card.manager.factory.goods.model.GoodsTagBindEntity;
import com.card.manager.factory.goods.model.GoodsTagEntity;
import com.card.manager.factory.goods.model.SecondCatalogEntity;
import com.card.manager.factory.goods.model.SpecsBO;
import com.card.manager.factory.goods.model.SpecsEntity;
import com.card.manager.factory.goods.model.SpecsValueEntity;
import com.card.manager.factory.goods.model.ThirdCatalogEntity;
import com.card.manager.factory.goods.model.ThirdWarehouseGoods;
import com.card.manager.factory.goods.pojo.CreateGoodsInfoEntity;
import com.card.manager.factory.goods.pojo.GoodsFielsMaintainBO;
import com.card.manager.factory.goods.pojo.GoodsInfoEntity;
import com.card.manager.factory.goods.pojo.GoodsRebateBO;
import com.card.manager.factory.goods.pojo.GoodsSpecsBO;
import com.card.manager.factory.goods.pojo.GoodsStatusEnum;
import com.card.manager.factory.goods.pojo.ImportGoodsBO;
import com.card.manager.factory.goods.pojo.ItemSpecsPojo;
import com.card.manager.factory.goods.pojo.Tax;
import com.card.manager.factory.goods.service.GoodsService;
import com.card.manager.factory.log.LogUtil;
import com.card.manager.factory.socket.task.SocketClient;
import com.card.manager.factory.supplier.model.SupplierEntity;
import com.card.manager.factory.system.mapper.StaffMapper;
import com.card.manager.factory.system.model.RebateFormulaBO;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.DateUtil;
import com.card.manager.factory.util.ExcelUtil;
import com.card.manager.factory.util.ExcelUtils;
import com.card.manager.factory.util.FileDownloadUtil;
import com.card.manager.factory.util.FileUtil;
import com.card.manager.factory.util.FormulaUtil;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.SequeceRule;
import com.card.manager.factory.util.URLUtils;
import com.card.manager.factory.util.Utils;

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
public class GoodsServiceImpl extends AbstractServcerCenterBaseService implements GoodsService {

	@Resource
	StaffMapper<?> staffMapper;

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
	public String getHtmlContext(String html, StaffEntity staffEntity) throws Exception {
		// String tmpIp = html.substring(html.indexOf("//") + 2,
		// html.lastIndexOf(":"));
		// html = html.replace(tmpIp, URLUtils.get("LanIp"));
		// Document doc = Jsoup.parse(new URL(html), 3000);

		String htmlContext = "";
		// 创建URL对象
		URL myURL = new URL(html);
		// 创建HttpsURLConnection对象，并设置其SSLSocketFactory对象
		HttpsURLConnection httpsConn = (HttpsURLConnection) myURL.openConnection();
		// 取得该连接的输入流，以读取响应内容
		InputStreamReader insr = new InputStreamReader(httpsConn.getInputStream());
		// 读取服务器的响应内容并显示
		int respInt = insr.read();
		while (respInt != -1) {
			if (respInt != 10) {
				htmlContext = htmlContext + (char) respInt;
			}
//			System.out.println("respInt:"+(char) respInt);
//			System.out.println("respInt:"+ respInt);
			respInt = insr.read();
		}
		insr.close();

		return htmlContext;
		// return htmlToCode(doc.toString());
	}

//	private String htmlToCode(String context) {
//		if (context == null) {
//			return "";
//		} else {
//			context = context.replace("<html>", "");
//			context = context.replace("</html>", "");
//			context = context.replace("<body>", "");
//			context = context.replace("</body>", "");
//			context = context.replace("<head>", "");
//			context = context.replace("</head>", "");
//			context = context.replace("\n", "");
//			context = context.replace("\t", "");
//			context = context.replaceAll("\n\r", "<br>&nbsp;&nbsp;");
//			context = context.replaceAll("\r\n", "<br>&nbsp;&nbsp;");// 这才是正确的！
//			context = context.replaceAll("\t", "&nbsp;&nbsp;&nbsp;&nbsp;");
//			return context;
//		}
//	}

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
			throw new Exception("新增商品标签操作失败:" + json.getString("errorMsg"));
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

		goods.setTemplateId(0);
		goods.setGoodsName(entity.getGoodsName());
		goods.setOrigin(entity.getOrigin());
		goods.setType(entity.getType());
		entity.setGoodsId(Integer.parseInt(goods.getGoodsId()));

		// -------------------保存商品详情---------------------//
		String savePath;
		String invitePath;
		savePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.GOODS + "/" + goods.getGoodsId() + "/"
				+ ResourceContants.DETAIL + "/" + ResourceContants.HTML + "/";
		invitePath = URLUtils.get("static") + "/" + ResourceContants.GOODS + "/" + goods.getGoodsId() + "/"
				+ ResourceContants.DETAIL + "/" + ResourceContants.HTML + "/" + goods.getGoodsId()
				+ ResourceContants.HTML_SUFFIX;
		//通过输入流的方式将选择的文件内容转为FILE文件，此时会生成一个临时文件
		WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
		ServletContext servletContext = webApplicationContext.getServletContext();
		String path =  servletContext.getRealPath("/") + "fileUpload";
		File tmpFile = null;
		InputStream is = new ByteArrayInputStream(entity.getDetailInfo().replace(entity.getCreateKey(), goods.getGoodsId()).getBytes("utf-8"));
	    File fd = new File(path);
	    if (!fd.exists()) {
	    	fd.mkdirs();
	    }
		String tmpFileName = goods.getGoodsId() + ResourceContants.HTML_SUFFIX;
	    tmpFile = new File(path+"/"+tmpFileName);
	    FileUtil.inputStreamToFile(is, tmpFile);
	    SocketClient client = null;
		try {
			client = new SocketClient();
			client.sendFile(tmpFile.getPath(), savePath);
			client.quit();
			client.close();
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("新建商品时商品详情传输到资源服务器异常");
		} finally {
			if (client != null) {
				client.close();
			}
			//将临时文件删除
	   		File del = new File(tmpFile.toURI());
	   		del.delete();
		}
		goods.setDetailPath(invitePath);
		// -------------------保存商品详情---------------------//

		List<GoodsFile> files = new ArrayList<GoodsFile>();
		if (entity.getPicPath() != null) {
			String[] goodsFiles = entity.getPicPath().split(",");
			for (String file : goodsFiles) {
				GoodsFile f = new GoodsFile();
				f.setPath(file.replace(entity.getCreateKey(), goods.getGoodsId()));
				f.setGoodsId(goods.getGoodsId());
				files.add(f);
			}
			String picPathBase = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.GOODS + "/";
			String backPicInfo = picPathBase + entity.getCreateKey() + "|" + picPathBase + goods.getGoodsId();
			entity.setPicPath(backPicInfo);
		}
		goods.setFiles(files);

		List<GoodsItemEntity> items = new ArrayList<GoodsItemEntity>();
		if (entity.getItems() != null && entity.getItems().size() > 0) {
			for (GoodsItemEntity gie : entity.getItems()) {
				GoodsItemEntity goodsItem = new GoodsItemEntity();
				goodsItem.setGoodsId(goods.getGoodsId());
				int itemid = staffMapper.nextVal(ServerCenterContants.GOODS_ITEM_ID_SEQUENCE);
				goodsItem.setItemId(SequeceRule.getGoodsItemId(itemid));
				goodsItem.setItemCode(gie.getItemCode());
				goodsItem.setSku(gie.getSku());
				goodsItem.setWeight(gie.getWeight());
				goodsItem.setExciseTax(gie.getExciseTax());
				goodsItem.setStatus(GoodsStatusEnum.DOWNSHELF.getIndex() + "");
				goodsItem.setConversion(gie.getConversion());
				goodsItem.setEncode(gie.getEncode());
				goodsItem.setShelfLife(gie.getShelfLife());
				goodsItem.setCarTon(gie.getCarTon());

				GoodsPrice goodsPrice = new GoodsPrice();
				goodsPrice.setItemId(goodsItem.getItemId());
				goodsPrice.setMin(gie.getGoodsPrice().getMin());
				goodsPrice.setMax(gie.getGoodsPrice().getMax());
				goodsPrice.setProxyPrice(gie.getGoodsPrice().getProxyPrice());
				goodsPrice.setFxPrice(gie.getGoodsPrice().getFxPrice());
				goodsPrice.setRetailPrice(gie.getGoodsPrice().getRetailPrice());
				goodsPrice.setLinePrice(gie.getGoodsPrice().getLinePrice());
				goodsPrice.setOpt(entity.getOpt());

				goodsItem.setGoodsPrice(goodsPrice);
				goodsItem.setOpt(entity.getOpt());

				String keys = gie.getInfo();
				List<ItemSpecsPojo> specsPojos = new ArrayList<ItemSpecsPojo>();
				if ((keys != null && !"".equals(keys))) {
					String[] keyArray = keys.split(";");
					for (int i = 0; i < keyArray.length; i++) {
						ItemSpecsPojo itemSpecsPojo;
						if (keyArray[i].trim() != null || !"".equals(keyArray[i].trim())) {
							itemSpecsPojo = new ItemSpecsPojo();
							String[] kContesnts = keyArray[i].split("&");
							itemSpecsPojo.setSkId(kContesnts[0].split("\\|")[0]);
							itemSpecsPojo.setSkV(kContesnts[0].split("\\|")[1]);
							itemSpecsPojo.setSvId(kContesnts[1].split("\\|")[0]);
							itemSpecsPojo.setSvV(kContesnts[1].split("\\|")[1]);
							specsPojos.add(itemSpecsPojo);
						}
					}

					JSONArray json = JSONArray.fromObject(specsPojos);
					goodsItem.setInfo(json.toString());
				}
				items.add(goodsItem);
			}
		} else {
			GoodsItemEntity goodsItem = new GoodsItemEntity();
			int itemid = staffMapper.nextVal(ServerCenterContants.GOODS_ITEM_ID_SEQUENCE);
			goodsItem.setGoodsId(goods.getGoodsId());
			goodsItem.setItemId(SequeceRule.getGoodsItemId(itemid));
			goodsItem.setItemCode(entity.getItemCode());
			goodsItem.setSku(entity.getSku());
			goodsItem.setWeight(entity.getWeight());
			goodsItem.setExciseTax(entity.getExciseTax());
			goodsItem.setStatus(GoodsStatusEnum.DOWNSHELF.getIndex() + "");
			goodsItem.setConversion(entity.getConversion());
			goodsItem.setEncode(entity.getEncode());
			goodsItem.setShelfLife(entity.getShelfLife());
			goodsItem.setCarTon(entity.getCarTon());

			GoodsPrice goodsPrice = new GoodsPrice();
			goodsPrice.setItemId(goodsItem.getItemId());
			goodsPrice.setMin(entity.getMin());
			goodsPrice.setMax(entity.getMax());
			goodsPrice.setProxyPrice(entity.getProxyPrice());
			goodsPrice.setFxPrice(entity.getFxPrice());
			goodsPrice.setRetailPrice(entity.getRetailPrice());
			goodsPrice.setLinePrice(entity.getLinePrice());
			goodsPrice.setOpt(entity.getOpt());

			goodsItem.setGoodsPrice(goodsPrice);
			goodsItem.setOpt(entity.getOpt());
			items.add(goodsItem);
		}
		goods.setItems(items);

		// 新增商品时判断是否添加商品标签
		if (!"".equals(entity.getTagId()) && entity.getTagId() != null) {
			List<GoodsTagBindEntity> goodsTagBindList = new ArrayList<GoodsTagBindEntity>();
			GoodsTagBindEntity goodsTagBindEntity = null;
			String[] tagArray = entity.getTagId().split("\\|");
			for (GoodsItemEntity gie : items) {
				for (int i = 0; i < tagArray.length; i++) {
					if (tagArray[i].trim() != null || !"".equals(tagArray[i].trim())) {
						goodsTagBindEntity = new GoodsTagBindEntity();
						goodsTagBindEntity.setItemId(gie.getItemId());
						goodsTagBindEntity.setTagId(Integer.parseInt(tagArray[i].trim()));
						goodsTagBindList.add(goodsTagBindEntity);
					}
				}
			}
			goods.setGoodsTagBindList(goodsTagBindList);
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
		goods.setTemplateId(0);
		goods.setGoodsName(entity.getGoodsName());
		goods.setOrigin(entity.getOrigin());
		goods.setType(entity.getType());

		// -------------------保存商品详情---------------------//
		String savePath;
		String invitePath;
		savePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.GOODS + "/" + goods.getGoodsId() + "/"
				+ ResourceContants.DETAIL + "/" + ResourceContants.HTML + "/";
		invitePath = URLUtils.get("static") + "/" + ResourceContants.GOODS + "/" + goods.getGoodsId() + "/"
				+ ResourceContants.DETAIL + "/" + ResourceContants.HTML + "/" + goods.getGoodsId()
				+ ResourceContants.HTML_SUFFIX;
		//通过输入流的方式将选择的文件内容转为FILE文件，此时会生成一个临时文件
		WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
		ServletContext servletContext = webApplicationContext.getServletContext();
		String path =  servletContext.getRealPath("/") + "fileUpload";
		File tmpFile = null;
		InputStream is = new ByteArrayInputStream(entity.getDetailInfo().getBytes("utf-8"));
	    File fd = new File(path);
	    if (!fd.exists()) {
	    	fd.mkdirs();
	    }
		String tmpFileName = goods.getGoodsId() + ResourceContants.HTML_SUFFIX;
	    tmpFile = new File(path+"/"+tmpFileName);
	    FileUtil.inputStreamToFile(is, tmpFile);
	    SocketClient client = null;
		try {
			client = new SocketClient();
			client.sendFile(tmpFile.getPath(), savePath);
			client.quit();
			client.close();
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("修改商品时商品详情传输到资源服务器异常");
		} finally {
			if (client != null) {
				client.close();
			}
			//将临时文件删除
	   		File del = new File(tmpFile.toURI());
	   		del.delete();
		}
		goods.setDetailPath(invitePath);
		// -------------------保存商品详情---------------------//

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

		List<GoodsItemEntity> items = new ArrayList<GoodsItemEntity>();
		GoodsItemEntity goodsItem = new GoodsItemEntity();
		goodsItem.setGoodsId(goods.getGoodsId());
		goodsItem.setItemId(entity.getItemId() + "");
		goodsItem.setItemCode(entity.getItemCode());
		goodsItem.setSku(entity.getSku());
		goodsItem.setWeight(entity.getWeight());
		goodsItem.setExciseTax(entity.getExciseTax());
		goodsItem.setStatus(entity.getItemStatus());
		goodsItem.setConversion(entity.getConversion());
		goodsItem.setEncode(entity.getEncode());
		goodsItem.setShelfLife(entity.getShelfLife());
		goodsItem.setCarTon(entity.getCarTon());

		GoodsPrice goodsPrice = new GoodsPrice();
		goodsPrice.setItemId(goodsItem.getItemId());
		goodsPrice.setMin(entity.getMin());
		goodsPrice.setMax(entity.getMax());
		goodsPrice.setProxyPrice(entity.getProxyPrice());
		goodsPrice.setFxPrice(entity.getFxPrice());
		goodsPrice.setRetailPrice(entity.getRetailPrice());
		goodsPrice.setLinePrice(entity.getLinePrice());
		goodsPrice.setOpt(entity.getOpt());

		goodsItem.setGoodsPrice(goodsPrice);
		goodsItem.setOpt(entity.getOpt());

		String keys = entity.getKeys();
		List<ItemSpecsPojo> specsPojos = new ArrayList<ItemSpecsPojo>();
		if ((keys != null && !"".equals(keys))) {
			String[] keyArray = keys.split(";");
			for (int i = 0; i < keyArray.length; i++) {
				ItemSpecsPojo itemSpecsPojo;
				if (keyArray[i].trim() != null || !"".equals(keyArray[i].trim())) {
					itemSpecsPojo = new ItemSpecsPojo();
					String[] kContesnts = keyArray[i].split("&");
					itemSpecsPojo.setSkId(kContesnts[0].split("\\|")[0]);
					itemSpecsPojo.setSkV(kContesnts[0].split("\\|")[1]);
					itemSpecsPojo.setSvId(kContesnts[1].split("\\|")[0]);
					itemSpecsPojo.setSvV(kContesnts[1].split("\\|")[1]);
					specsPojos.add(itemSpecsPojo);
				}
			}

			JSONArray json = JSONArray.fromObject(specsPojos);
			goodsItem.setInfo(json.toString());
		} else {
			goodsItem.setInfo("");
		}
		items.add(goodsItem);
		goods.setItems(items);

		// 新增商品时判断是否添加商品标签
		if (!"".equals(entity.getTagId()) && entity.getTagId() != null) {
			List<GoodsTagBindEntity> goodsTagBindList = new ArrayList<GoodsTagBindEntity>();
			GoodsTagBindEntity goodsTagBindEntity = null;
			String[] tagArray = entity.getTagId().split("\\|");
			for (int i = 0; i < tagArray.length; i++) {
				if (tagArray[i].trim() != null || !"".equals(tagArray[i].trim())) {
					goodsTagBindEntity = new GoodsTagBindEntity();
					goodsTagBindEntity.setItemId(goodsItem.getItemId());
					goodsTagBindEntity.setTagId(Integer.parseInt(tagArray[i].trim()));
					goodsTagBindList.add(goodsTagBindEntity);
				}
			}
			goods.setGoodsTagBindList(goodsTagBindList);
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

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> importGoodsInfo(String filePath, StaffEntity staffEntity) {
		List<ImportGoodsBO> list = ExcelUtils.instance().readExcel(filePath, ImportGoodsBO.class, true);
		Map<String, Object> result = new HashMap<String, Object>();
		RestCommonHelper helper = new RestCommonHelper();
		// 中文转ID准备数据
		Map<String, Integer> supplierMap = new CaseInsensitiveMap();
		Map<String, Integer> gradeMapTemp = new CaseInsensitiveMap();
		Map<String, String> firstMapTemp = new CaseInsensitiveMap();
		Map<String, String> secondMapTemp = new CaseInsensitiveMap();
		Map<String, String> thirdMapTemp = new CaseInsensitiveMap();
		Map<String, String> brandMapTemp = new CaseInsensitiveMap();
		Map<String, Integer> specsNameMap = new CaseInsensitiveMap();
		Map<Integer, Map<String, Integer>> specsValueMap = new HashMap<Integer, Map<String, Integer>>();
		packConvertData(staffEntity, supplierMap, gradeMapTemp, firstMapTemp, secondMapTemp, thirdMapTemp, brandMapTemp,
				specsNameMap, specsValueMap, helper);
		// end
		Map<String, GoodsInfoEntity> infoMap = new HashMap<String, GoodsInfoEntity>();
		int i = 1;
		if (list != null && list.size() > 0) {
			GoodsItemEntity goodsItem = null;
			GoodsInfoEntity goodsInfo = null;
			List<List<GoodsSpecsBO>> repeatList = null;// 判断规格是否重复
			List<GoodsInfoEntity> goodsInfoList = new ArrayList<GoodsInfoEntity>();
			List<GoodsTagEntity> tagList = queryGoodsTags(staffEntity.getToken());
			Map<Integer, GradeTypeDTO> gradeMap = CachePoolComponent.getGradeType(staffEntity.getToken());
			for (ImportGoodsBO model : list) {
				model.init(supplierMap, gradeMapTemp, firstMapTemp, secondMapTemp, thirdMapTemp, brandMapTemp,
						specsNameMap, specsValueMap);
				// 判断字段属性全不全
				checkFieldIsNull(result, infoMap, model);
				if (!(boolean) result.get("success")) {
					return result;
				}
				String tempId = i + DateUtil.getintTimePlusString();
				if (!infoMap.containsKey(model.getId())) {// 不存在新增base和goods
					// 处理goods
					goodsInfo = goodsHandler(staffEntity, infoMap, goodsInfoList, model, tempId);
					repeatList = new ArrayList<List<GoodsSpecsBO>>();// 判断多规格是否重复用
				} else {
					goodsInfo = infoMap.get(model.getId());
				}

				// goodsItem
				goodsItem = goodsItemHandler(staffEntity, result, helper, specsNameMap, specsValueMap, goodsInfo,
						repeatList, model, tempId);
				if (!(boolean) result.get("success")) {
					return result;
				}

				// goodsPrice
				priceHandler(staffEntity, result, goodsItem, model);
				if (!(boolean) result.get("success")) {
					return result;
				}
				// 库存设置
				stockHandler(result, goodsItem, model);
				if (!(boolean) result.get("success")) {
					return result;
				}
				// 返佣设置
				rebateHandler(staffEntity, result, goodsItem, gradeMap, model);
				if (!(boolean) result.get("success")) {
					return result;
				}
				// 处理标签
				if (model.getTagNames() != null) {
					tagHandler(model, result, goodsInfo, tagList, goodsItem.getItemId());
				}
				if (!(boolean) result.get("success")) {
					return result;
				}
				i++;
			}
			try {
				ResponseEntity<String> usercenter_result = helper.request(
						URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_IMPORT_GOODSINFO,
						staffEntity.getToken(), true, goodsInfoList, HttpMethod.POST);

				JSONObject json = JSONObject.fromObject(usercenter_result.getBody());
				result.put("success", json.get("success"));
				result.put("msg", json.get("errorMsg"));
				return result;
			} catch (Exception e) {
				e.printStackTrace();
				result.put("success", false);
				result.put("msg", e);
				return result;
			}
		} else { // 没有读到数据
			result.put("success", false);
			result.put("msg", "没有商品信息");
			return result;
		}
	}

	/**
	 * @fun 封装goodsItem
	 * @param staffEntity
	 * @param result
	 * @param helper
	 * @param specsNameMap
	 * @param specsValueMap
	 * @param goodsInfo
	 * @param repeatList
	 * @param model
	 * @param tempId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private GoodsItemEntity goodsItemHandler(StaffEntity staffEntity, Map<String, Object> result,
			RestCommonHelper helper, Map<String, Integer> specsNameMap,
			Map<Integer, Map<String, Integer>> specsValueMap, GoodsInfoEntity goodsInfo,
			List<List<GoodsSpecsBO>> repeatList, ImportGoodsBO model, String tempId) {
		StringBuilder sb;
		GoodsItemEntity goodsItem;
		List<GoodsItemEntity> items;
		Map<String, Integer> spv;
		goodsItem = new GoodsItemEntity();
		goodsItem.setGoodsId(goodsInfo.getGoods().getGoodsId());
		goodsItem.setItemCode(Utils.removePoint(model.getItemCode()));
		goodsItem.setSku(Utils.removePoint(model.getSku()));
		goodsItem.setShelfLife(model.getShelfLife());
		goodsItem.setCarTon(model.getCarTon());
		try {
			goodsItem.setWeight(
					model.getWeight() == null || "".equals(model.getWeight()) ? 0 : Utils.convert(model.getWeight()));
			goodsItem.setExciseTax(Double.valueOf(model.getExciseFax()));
			goodsItem.setConversion(model.getConversion() == null || "".equals(model.getConversion()) ? 1
					: Utils.convert(model.getConversion()));
		} catch (Exception e) {
			result.put("success", false);
			result.put("msg", "编号：" + model.getId() + "请检查数字是否填写准确,并使用文本格式");
			return null;
		}
		goodsItem.setStatus(GoodsStatusEnum.DOWNSHELF.getIndex() + "");
		goodsItem.setEncode(Utils.removePoint(model.getEncode()));
		if (model.getSpecsList() != null) {
			sb = new StringBuilder("[");
			for (GoodsSpecsBO specs : model.getSpecsList()) {
				if (specs.getSpecsNameId() == null) {
					int id = addSpecs(helper, specs, ServerCenterContants.GOODS_CENTER_SPECS_ADD,
							staffEntity.getToken());
					specs.setSpecsNameId(id);
					specsNameMap.put(specs.getSpecsName(), id);// 放入map，如果该excel里有其他商品使用该规格就不需要请求微服务
				}
				if (specs.getSpecsValueId() == null) {
					int id = addSpecs(helper, specs, ServerCenterContants.GOODS_CENTER_SPECS_VALUE_ADD,
							staffEntity.getToken());
					specs.setSpecsValueId(id);
					// 同specsName
					if (specsValueMap.get(specs.getSpecsNameId()) == null) {
						spv = new CaseInsensitiveMap();
						spv.put(specs.getSpecsValue(), id);
						specsValueMap.put(specs.getSpecsNameId(), spv);
					} else {
						specsValueMap.get(specs.getSpecsNameId()).put(specs.getSpecsValue(), id);
					}
				}
				sb.append("{\"svV\":\"" + specs.getSpecsValue() + "\",\"skV\":\"" + specs.getSpecsName()
						+ "\",\"svId\":\"" + specs.getSpecsValueId() + "\",\"skId\":\"" + specs.getSpecsNameId()
						+ "\"},");
			}
			String info = sb.substring(0, sb.length() - 1) + "]";
			goodsItem.setInfo(info);
		} else {
			if (goodsInfo.getGoods().getItems() != null) {
				result.put("success", false);
				result.put("msg", "编号：" + model.getId() + ",请填写规格,如果没有规格,id请不要重复");
				return null;
			}
		}
		goodsItem.setItemId(tempId);
		if (goodsInfo.getGoods().getItems() == null) {
			items = new ArrayList<GoodsItemEntity>();
			items.add(goodsItem);
			goodsInfo.getGoods().setItems(items);
		} else {
			goodsInfo.getGoods().getItems().add(goodsItem);
		}
		// 判断规格是否重复
		if (repeatList.size() == 0) {
			repeatList.add(model.getSpecsList());
		} else {
			for (List<GoodsSpecsBO> temp : repeatList) {
				if (Utils.isEqualCollection(temp, model.getSpecsList())) {
					result.put("success", false);
					result.put("msg", "编号：" + model.getId() + ",规格有重复");
					return null;
				}
			}
			repeatList.add(model.getSpecsList());
		}
		return goodsItem;
	}

	/**
	 * @fun 封装goods
	 * @param staffEntity
	 * @param infoMap
	 * @param goodsInfo
	 * @param goodsInfoList
	 * @param model
	 * @param tempId
	 */
	private GoodsInfoEntity goodsHandler(StaffEntity staffEntity, Map<String, GoodsInfoEntity> infoMap,
			List<GoodsInfoEntity> goodsInfoList, ImportGoodsBO model, String tempId) {
		GoodsBaseEntity goodsBase;
		GoodsEntity goods;
		GoodsInfoEntity goodsInfo = new GoodsInfoEntity();
		// 基础商品
		goodsBase = new GoodsBaseEntity();
		goodsBase.setBrandId(model.getBrandId());
		goodsBase.setGoodsName(model.getGoodsName());
		goodsBase.setBrand(model.getBrandName());
		goodsBase.setIncrementTax(model.getIncrementTax());
		goodsBase.setTariff(model.getTariff());
		goodsBase.setUnit(model.getUnit());
		goodsBase.setHscode(model.getHscode());
		goodsBase.setFirstCatalogId(model.getFirstCatalogId());
		goodsBase.setSecondCatalogId(model.getSecondCatalogId());
		goodsBase.setThirdCatalogId(model.getThirdCatalogId());
		goodsBase.setCenterId(staffEntity.getGradeId());
		int baseId = Integer.valueOf(tempId);
		goodsBase.setId(baseId);
		goodsInfo.setGoodsBase(goodsBase);

		// goods表
		goods = new GoodsEntity();
		goods.setSupplierId(model.getSupplierId());
		goods.setType(model.getType());
		goods.setSupplierName(model.getSupplierName());
		goods.setTemplateId(0);
		goods.setGoodsName(model.getGoodsName());
		goods.setOrigin(model.getOrigin());
		goods.setGoodsId(tempId);
		goods.setBaseId(baseId);
		goodsInfo.setGoods(goods);
		infoMap.put(model.getId(), goodsInfo);
		goodsInfoList.add(goodsInfo);

		return goodsInfo;
	}

	/**
	 * @fun 价格处理
	 * @param staffEntity
	 * @param result
	 * @param goodsItem
	 * @param model
	 */
	private void priceHandler(StaffEntity staffEntity, Map<String, Object> result, GoodsItemEntity goodsItem,
			ImportGoodsBO model) {
		GoodsPrice goodsPrice;
		goodsPrice = new GoodsPrice();
		goodsPrice.setItemId(goodsItem.getItemId());
		try {
			goodsPrice.setMin(Utils.convert(model.getMin()));
			goodsPrice.setMax("-1".equals(Utils.removePoint(model.getMax())) || null == model.getMax() ? null
					: Utils.convert(model.getMax()));
			goodsPrice.setProxyPrice(Double.valueOf(model.getProxyPrice()));
			goodsPrice.setFxPrice(Double.valueOf(model.getFxPrice()));
			goodsPrice.setRetailPrice(Double.valueOf(model.getRetailPrice()));
			goodsPrice.setOpt(staffEntity.getOptName());
		} catch (Exception e) {
			result.put("success", false);
			result.put("msg", "编号：" + model.getId() + "请检查数字是否填写准确,并使用文本格式");
			return;
		}

		goodsItem.setGoodsPrice(goodsPrice);
		goodsItem.setOpt(staffEntity.getOptName());
	}

	/**
	 * @fun 库存处理
	 * @param result
	 * @param goodsItem
	 * @param model
	 */
	private void stockHandler(Map<String, Object> result, GoodsItemEntity goodsItem, ImportGoodsBO model) {
		GoodsStockEntity goodsStock;
		goodsStock = new GoodsStockEntity();
		try {
			goodsStock.setItemId(goodsItem.getItemId());
			goodsStock.setFxQty(Utils.convert(model.getStock()));
			goodsStock.setQpQty(Utils.convert(model.getStock()));
		} catch (Exception e) {
			result.put("success", false);
			result.put("msg", "编号：" + model.getId() + "请检查数字是否填写准确,并使用文本格式");
			return;
		}
		goodsItem.setStock(goodsStock);
	}

	/**
	 * @fun 返佣对象封装
	 * @param staffEntity
	 * @param result
	 * @param goodsItem
	 * @param gradeMap
	 * @param model
	 */
	private void rebateHandler(StaffEntity staffEntity, Map<String, Object> result, GoodsItemEntity goodsItem,
			Map<Integer, GradeTypeDTO> gradeMap, ImportGoodsBO model) {
		GoodsRebateEntity goodsRebate;
		GradeTypeDTO gradeType;
		List<GoodsRebateEntity> rebateList;
		Map<Integer, GoodsRebateEntity> tempMap;
		tempMap = new HashMap<Integer, GoodsRebateEntity>();
		rebateList = new ArrayList<GoodsRebateEntity>();
		if (model.getRebateList() != null) {
			for (GoodsRebateBO rebate : model.getRebateList()) {
				if (Double.valueOf(rebate.getProportion()) > 1) {
					result.put("success", false);
					result.put("msg", "编号：" + model.getId() + ",返佣比例设置不能大于1");
					return;
				}
				gradeType = gradeMap.get(rebate.getGradeNameId());
				goodsRebate = tempMap.get(gradeType.getParentId());
				if (goodsRebate != null) {
					if (gradeType.getParentId() != 1) {// 因为海外购返佣比例为0所以不校验
						if (Double.valueOf(rebate.getProportion()) > goodsRebate.getProportion()) {
							result.put("success", false);
							result.put("msg", "编号：" + model.getId() + ",下级返佣不能大于上级返佣");
							return;
						}
					}
				} else {
					if (gradeType.getParentId() != 1 && gradeType.getParentId() != 0) {
						result.put("success", false);
						result.put("msg", "编号：" + model.getId() + ",请先填写上一级返佣");
						return;
					}
				}
				goodsRebate = new GoodsRebateEntity();
				goodsRebate.setGradeType(rebate.getGradeNameId());
				goodsRebate.setItemId(goodsItem.getItemId());
				goodsRebate.setProportion(Double.valueOf(rebate.getProportion()));
				rebateList.add(goodsRebate);
				tempMap.put(rebate.getGradeNameId(), goodsRebate);
			}
		} else {
			result.put("success", false);
			result.put("msg", "编号：" + model.getId() + ",请至少填写区域中心的返佣比例");
			return;
		}

		// 根据返佣公式设置没有填写的返佣比例
		Map<Integer, RebateFormulaBO> rebateFormulaMap = CachePoolComponent.getRebateFormula(staffEntity.getToken());
		renderDefaultRebateForUnSet(rebateList, result, gradeMap, rebateFormulaMap, goodsItem.getItemId(),
				model.getId());
		if (!(boolean) result.get("success")) {
			return;
		}
		goodsItem.setGoodsRebateList(rebateList);
	}

	/**
	 * @fun 标签设置
	 * @param tagNames
	 * @param goodsInfo
	 * @param helper
	 */
	private void tagHandler(ImportGoodsBO model, Map<String, Object> result, GoodsInfoEntity goodsInfo,
			List<GoodsTagEntity> tagList, String itemId) {
		String[] tagNameArr = model.getTagNames().split(",");
		// 标签封装成名称和对象的map
		Map<String, GoodsTagEntity> tempMap = new HashMap<String, GoodsTagEntity>();
		for (GoodsTagEntity tagEntity : tagList) {
			tempMap.put(tagEntity.getTagName(), tagEntity);
		}
		// 生成标签绑定实体类
		GoodsTagEntity temp = null;
		List<GoodsTagBindEntity> bindList = null;
		GoodsTagBindEntity tempBindEntity = null;
		// 判断之前goods里是否有标签绑定的list，有的话在原来基础上加，没有就新建
		if (goodsInfo.getGoods().getGoodsTagBindList() == null) {
			bindList = new ArrayList<GoodsTagBindEntity>();
			goodsInfo.getGoods().setGoodsTagBindList(bindList);
		} else {
			bindList = goodsInfo.getGoods().getGoodsTagBindList();
		}
		for (String tagName : tagNameArr) {
			temp = tempMap.get(tagName.trim());
			if (temp == null) {
				result.put("success", false);
				result.put("msg", "编号：" + model.getId() + ",找不到对应的标签ID，请检查标签是否正确，或通过后台新增标签");
				return;
			}
			tempBindEntity = new GoodsTagBindEntity();
			tempBindEntity.setItemId(itemId);
			tempBindEntity.setTagId(temp.getId());
			bindList.add(tempBindEntity);
		}
	}

	/**
	 * @fun 把没有设置返佣的分级根据提取设置的公式进行计算
	 * @param rebateList
	 * @param result
	 * @param gradeTypeMap
	 * @param rebateFormulaMap
	 */
	private final int AREA_CENTER_GRADE_TYPE = 2;

	private void renderDefaultRebateForUnSet(List<GoodsRebateEntity> rebateList, Map<String, Object> result,
			Map<Integer, GradeTypeDTO> gradeTypeMap, Map<Integer, RebateFormulaBO> rebateFormulaMap, String itemId,
			String id) {

		Double rebate = null;
		// 去除已经设置返佣的分级类型并获得区域中心的返佣值
		Map<Integer, GradeTypeDTO> temp = new HashMap<Integer, GradeTypeDTO>();
		for (Map.Entry<Integer, GradeTypeDTO> entry : gradeTypeMap.entrySet()) {
			temp.put(entry.getKey(), entry.getValue());
		}
		for (GoodsRebateEntity entity : rebateList) {
			if (entity.getGradeType() == AREA_CENTER_GRADE_TYPE) {
				rebate = entity.getProportion();
			}
			temp.remove(entity.getGradeType());
		}
		if (rebate == null) {
			result.put("success", false);
			result.put("msg", "区域中心的返佣必须填写");
			return;
		}
		RebateFormulaBO bo = null;
		GoodsRebateEntity tempRebate = null;
		if (temp != null && temp.size() > 0) {
			for (Map.Entry<Integer, GradeTypeDTO> entry : temp.entrySet()) {
				bo = rebateFormulaMap.get(entry.getKey());// 获取该分级的返佣公式
				if (bo == null || bo.getFormula() == null || "".equals(bo.getFormula())) {
					result.put("success", false);
					result.put("msg", entry.getValue().getName() + ":该分级返佣公式不存在，请确认");
					return;
				}
				tempRebate = new GoodsRebateEntity();
				tempRebate.setItemId(itemId);
				tempRebate.setGradeType(entry.getKey());
				try {
					double rebateTemp = FormulaUtil.calRebate(bo.getFormula(), rebate);
					if (rebateTemp < 0) {
						result.put("success", false);
						result.put("msg", "编号：" + id + ":该分级返佣计算后存在负数，请确认");
						return;
					}
					tempRebate.setProportion(rebateTemp);
				} catch (NoSuchMethodException | ScriptException e) {
					LogUtil.writeErrorLog("返佣公式计算出错==" + bo.getFormula(), e);
					result.put("success", false);
					result.put("msg", entry.getValue().getName() + ":该分级返佣存在问题，请确认");
					return;
				}
				rebateList.add(tempRebate);
			}
		}
	}

	private int addSpecs(RestCommonHelper helper, GoodsSpecsBO specs, String url, String token) {
		ResponseEntity<String> query_result = helper.request(URLUtils.get("gateway") + url, token, true, specs,
				HttpMethod.POST);
		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return (int) json.get("obj");
	}

	private void checkFieldIsNull(Map<String, Object> result, Map<String, GoodsInfoEntity> infoMap,
			ImportGoodsBO model) {
		Map<String, Object> tempMap = null;
		if (infoMap.containsKey(model.getId())) {// 是多规格
			tempMap = Utils.isAllFieldNotNull(model, model.getSpecsUnCheckFieldName());
			if (!(boolean) tempMap.get("success")) {
				result.put("success", false);
				result.put("msg", "编号：" + model.getId() + "," + tempMap.get("describe"));
				return;
			}
		} else {
			tempMap = Utils.isAllFieldNotNull(model, model.getBaseUnCheckFieldName());
			if (!(boolean) tempMap.get("success")) {
				result.put("success", false);
				result.put("msg", "编号：" + model.getId() + "," + tempMap.get("describe"));
				return;
			}
		}
		if (model.getRebateList() != null) {
			for (GoodsRebateBO rebate : model.getRebateList()) {
				tempMap = Utils.isAllFieldNotNull(rebate, null);
				if (!(boolean) tempMap.get("success")) {
					result.put("success", false);
					result.put("msg", "编号：" + model.getId() + "," + tempMap.get("describe"));
					return;
				}
			}
		}
		if (model.getSpecsList() != null) {
			for (GoodsSpecsBO specs : model.getSpecsList()) {
				tempMap = Utils.isAllFieldNotNull(specs, specs.getUnCheckFieldName());
				if (!(boolean) tempMap.get("success")) {
					result.put("success", false);
					result.put("msg", "编号：" + model.getId() + "," + tempMap.get("describe"));
					return;
				}
			}
		}
		result.put("success", true);
	}

	@SuppressWarnings("unchecked")
	private void packConvertData(StaffEntity staffEntity, Map<String, Integer> supplierMap,
			Map<String, Integer> gradeMapTemp, Map<String, String> firstMapTemp, Map<String, String> secondMapTemp,
			Map<String, String> thirdMapTemp, Map<String, String> brandMapTemp, Map<String, Integer> specsNameMap,
			Map<Integer, Map<String, Integer>> specsValueMap, RestCommonHelper helper) {
		Map<Integer, GradeTypeDTO> map = CachePoolComponent.getGradeType(staffEntity.getToken());
		List<SupplierEntity> suppliers = CachePoolComponent.getSupplier(staffEntity.getToken());
		List<FirstCatalogEntity> firstList = CachePoolComponent.getFirstCatalog(staffEntity.getToken());
		List<SecondCatalogEntity> secondList = CachePoolComponent.getSecondCatalog(staffEntity.getToken());
		List<ThirdCatalogEntity> thirdList = CachePoolComponent.getThirdCatalog(staffEntity.getToken());
		List<BrandEntity> brandList = CachePoolComponent.getBrands(staffEntity.getToken());
		List<Object> specsList = getSpecs(helper, ServerCenterContants.GOODS_CENTER_SPECS, staffEntity.getToken(),
				SpecsEntity.class);
		List<Object> specsValueList = getSpecs(helper, ServerCenterContants.GOODS_CENTER_SPECS_VALUE,
				staffEntity.getToken(), SpecsValueEntity.class);
		SpecsEntity specs = null;
		SpecsValueEntity specsvalue = null;
		Map<String, Integer> spv = null;
		for (Object obj : specsList) {
			specs = (SpecsEntity) obj;
			specsNameMap.put(specs.getName(), specs.getId());
		}
		for (Object obj : specsValueList) {
			specsvalue = (SpecsValueEntity) obj;
			if (specsValueMap.get(specsvalue.getSpecsId()) == null) {
				spv = new CaseInsensitiveMap();
				spv.put(specsvalue.getValue(), specsvalue.getId());
				specsValueMap.put(specsvalue.getSpecsId(), spv);
			} else {
				specsValueMap.get(specsvalue.getSpecsId()).put(specsvalue.getValue(), specsvalue.getId());
			}
		}
		for (SupplierEntity entity : suppliers) {
			supplierMap.put(entity.getSupplierName(), entity.getId());
		}
		for (FirstCatalogEntity entity : firstList) {
			firstMapTemp.put(entity.getName(), entity.getFirstId());
		}
		for (SecondCatalogEntity entity : secondList) {
			secondMapTemp.put(entity.getName(), entity.getSecondId());
		}
		for (ThirdCatalogEntity entity : thirdList) {
			thirdMapTemp.put(entity.getName(), entity.getThirdId());
		}
		for (BrandEntity entity : brandList) {
			brandMapTemp.put(entity.getBrand(), entity.getBrandId());
		}
		for (Map.Entry<Integer, GradeTypeDTO> entry : map.entrySet()) {
			gradeMapTemp.put(entry.getValue().getName(), entry.getValue().getId());
		}
	}

	private List<Object> getSpecs(RestCommonHelper helper, String url, String token, Class<?> clazz) {
		ResponseEntity<String> query_result = helper.request(URLUtils.get("gateway") + url, token, true, null,
				HttpMethod.GET);
		List<Object> list = new ArrayList<Object>();
		JSONObject json = JSONObject.fromObject(query_result.getBody());

		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		if (index == 0) {
			return null;
		}

		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			list.add(JSONUtilNew.parse(jObj.toString(), clazz));
		}
		return list;
	}

	private static final String FILE_NAME = "goodsTemplate.xlsx";

	@Override
	public void exportGoodsInfoTemplate(HttpServletRequest req, HttpServletResponse resp, StaffEntity staffEntity)
			throws Exception {
		WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
		ServletContext servletContext = webApplicationContext.getServletContext();
		String filePath = servletContext.getRealPath("/") + "WEB-INF/classes/" + FILE_NAME;
		InputStream is = new FileInputStream(filePath);
		XSSFWorkbook xssfWorkbook = new XSSFWorkbook(is);
		// 生成供应商对照表
		List<SupplierEntity> suppliers = CachePoolComponent.getSupplier(staffEntity.getToken());
		String[] supplierHead = new String[] { "供应商名称", "供应商自有编码" };
		String[] supplierField = new String[] { "SupplierName", "SupplierCode" };
		ExcelUtil.createExcel(suppliers, supplierHead, supplierField, filePath, 0, "供应商对照表", xssfWorkbook);
		// 生成分级类型对照表
		Map<Integer, GradeTypeDTO> gradeMap = CachePoolComponent.getGradeType(staffEntity.getToken());
		List<GradeTypeDTO> centers = new ArrayList<GradeTypeDTO>();
		for (Map.Entry<Integer, GradeTypeDTO> entry : gradeMap.entrySet()) {
			centers.add(entry.getValue());
		}
		String[] centerHead = new String[] { "分级编码", "父级编码", "分级名称" };
		String[] centerField = new String[] { "Id", "ParentId", "Name" };
		ExcelUtil.createExcel(centers, centerHead, centerField, filePath, 0, "分级对照表", xssfWorkbook);
		List<FirstCatalogEntity> firstList = CachePoolComponent.getFirstCatalog(staffEntity.getToken());
		List<SecondCatalogEntity> secondList = CachePoolComponent.getSecondCatalog(staffEntity.getToken());
		List<ThirdCatalogEntity> thirdList = CachePoolComponent.getThirdCatalog(staffEntity.getToken());
		Map<String, FirstCatalogEntity> firstMap = new HashMap<String, FirstCatalogEntity>();
		Map<String, SecondCatalogEntity> secondMap = new HashMap<String, SecondCatalogEntity>();
		for (FirstCatalogEntity first : firstList) {
			firstMap.put(first.getFirstId(), first);
		}
		for (SecondCatalogEntity second : secondList) {
			secondMap.put(second.getSecondId(), second);
		}
		CatalogEntity entity = null;
		List<CatalogEntity> entityList = new ArrayList<CatalogEntity>();
		for (ThirdCatalogEntity third : thirdList) {
			entity = new CatalogEntity();
			entity.setThirdCatalogName(third.getName());
			entity.setSecondCatalogName(secondMap.get(third.getSecondId()).getName());
			entity.setFirstCatalogName(firstMap.get(secondMap.get(third.getSecondId()).getFirstId()).getName());
			entityList.add(entity);
		}
		String[] catalogHead = new String[] { "一级分类名称", "二级分类名称", "三级分类名称" };
		String[] catalogField = new String[] { "FirstCatalogName", "SecondCatalogName", "ThirdCatalogName" };
		ExcelUtil.createExcel(entityList, catalogHead, catalogField, filePath, 0, "分类对照表", xssfWorkbook);
		// 生成品牌对照表
		List<BrandEntity> brandList = CachePoolComponent.getBrands(staffEntity.getToken());
		String[] brandHead = new String[] { "品牌名称" };
		String[] brandField = new String[] { "Brand" };
		ExcelUtil.createExcel(brandList, brandHead, brandField, filePath, 0, "品牌对照表", xssfWorkbook);
		RestCommonHelper helper = new RestCommonHelper();
		List<Object> specsList = getSpecs(helper, ServerCenterContants.GOODS_CENTER_SPECS, staffEntity.getToken(),
				SpecsEntity.class);
		List<Object> specsValueList = getSpecs(helper, ServerCenterContants.GOODS_CENTER_SPECS_VALUE,
				staffEntity.getToken(), SpecsValueEntity.class);
		Map<Integer, String> specsMap = new HashMap<Integer, String>();
		SpecsEntity specs = null;
		SpecsValueEntity specsValue = null;
		SpecsBO specsBO = null;
		List<SpecsBO> specsBOList = new ArrayList<SpecsBO>();
		for (Object obj : specsList) {
			specs = (SpecsEntity) obj;
			specsMap.put(specs.getId(), specs.getName());
		}
		for (Object obj : specsValueList) {
			specsBO = new SpecsBO();
			specsValue = (SpecsValueEntity) obj;
			specsBO.setSpecs(specsMap.get(specsValue.getSpecsId()));
			specsBO.setSpecsValue(specsValue.getValue());
			specsBOList.add(specsBO);
		}
		String[] specsValueHead = new String[] { "规格项", "规格值" };
		String[] specsValueField = new String[] { "Specs", "SpecsValue" };
		ExcelUtil.createExcel(specsBOList, specsValueHead, specsValueField, filePath, 0, "规格对照表", xssfWorkbook);
		// 生成标签sheet
		List<GoodsTagEntity> tagList = queryGoodsTags(staffEntity.getToken());
		String[] tagValueHead = new String[] { "标签名称" };
		String[] tagValueField = new String[] { "TagName" };
		ExcelUtil.createExcel(tagList, tagValueHead, tagValueField, filePath, 0, "标签对照表", xssfWorkbook);
		ExcelUtil.writeToExcel(xssfWorkbook, filePath);
		FileDownloadUtil.downloadFileByBrower(req, resp, filePath, FILE_NAME);
	}

	@Override
	@Log(content = "保存商品详情信息操作", source = Log.BACK_PLAT, type = Log.ADD)
	public String saveModelHtml(String itemCode, String html, StaffEntity staffEntity) throws Exception {

		String savePath;
		String invitePath;

		savePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.GOODS + "/" + 
				itemCode + "/" + ResourceContants.DETAIL + "/" + ResourceContants.HTML + "/";
		invitePath = URLUtils.get("static") + "/" + ResourceContants.GOODS + "/" + 
				itemCode + "/" + ResourceContants.DETAIL + "/" + ResourceContants.HTML + "/" + 
				itemCode + ResourceContants.HTML_SUFFIX;
		
		SocketClient client = null;
		try {
			client = new SocketClient();
			client.sendFile(html, savePath);
			client.quit();
			client.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (client != null) {
				client.close();
			}
		}

		return invitePath;
	}

	@Override
	public void batchUploadPic(List<GoodsFielsMaintainBO> boList, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_PIC_BATCH_UPLOAD, token, true, boList,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("新增商品明细信息操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	@Log(content = "添加商品规格信息操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void addItemInfoEntity(CreateGoodsInfoEntity entity, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		GoodsEntity goods = new GoodsEntity();
		goods.setGoodsId(entity.getGoodsId() + "");
		goods.setSupplierId(entity.getSupplierId());
		goods.setSupplierName(entity.getSupplierName());
		goods.setBaseId(entity.getBaseId());
		goods.setTemplateId(0);
		goods.setGoodsName(entity.getGoodsName());
		goods.setOrigin(entity.getOrigin());
		goods.setType(entity.getType());

		// -------------------保存商品详情---------------------//
		String savePath;
		String invitePath;
		savePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.GOODS + "/" + goods.getGoodsId() + "/"
				+ ResourceContants.DETAIL + "/" + ResourceContants.HTML + "/";
		invitePath = URLUtils.get("static") + "/" + ResourceContants.GOODS + "/" + goods.getGoodsId() + "/"
				+ ResourceContants.DETAIL + "/" + ResourceContants.HTML + "/" + goods.getGoodsId()
				+ ResourceContants.HTML_SUFFIX;
		//通过输入流的方式将选择的文件内容转为FILE文件，此时会生成一个临时文件
		WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
		ServletContext servletContext = webApplicationContext.getServletContext();
		String path =  servletContext.getRealPath("/") + "fileUpload";
		File tmpFile = null;
		InputStream is = new ByteArrayInputStream(entity.getDetailInfo().getBytes("utf-8"));
	    File fd = new File(path);
	    if (!fd.exists()) {
	    	fd.mkdirs();
	    }
		String tmpFileName = goods.getGoodsId() + ResourceContants.HTML_SUFFIX;
	    tmpFile = new File(path+"/"+tmpFileName);
	    FileUtil.inputStreamToFile(is, tmpFile);
	    SocketClient client = null;
		try {
			client = new SocketClient();
			client.sendFile(tmpFile.getPath(), savePath);
			client.quit();
			client.close();
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("修改商品时商品详情传输到资源服务器异常");
		} finally {
			if (client != null) {
				client.close();
			}
			//将临时文件删除
	   		File del = new File(tmpFile.toURI());
	   		del.delete();
		}
		goods.setDetailPath(invitePath);
		// -------------------保存商品详情---------------------//

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

		List<GoodsItemEntity> items = new ArrayList<GoodsItemEntity>();
		if (entity.getItems() != null && entity.getItems().size() > 0) {
			for (GoodsItemEntity gie : entity.getItems()) {
				GoodsItemEntity goodsItem = new GoodsItemEntity();
				goodsItem.setGoodsId(goods.getGoodsId());
				int itemid = staffMapper.nextVal(ServerCenterContants.GOODS_ITEM_ID_SEQUENCE);
				goodsItem.setItemId(SequeceRule.getGoodsItemId(itemid));
				goodsItem.setItemCode(gie.getItemCode());
				goodsItem.setSku(gie.getSku());
				goodsItem.setWeight(gie.getWeight());
				goodsItem.setExciseTax(gie.getExciseTax());
				goodsItem.setStatus(GoodsStatusEnum.DOWNSHELF.getIndex() + "");
				goodsItem.setConversion(gie.getConversion());
				goodsItem.setEncode(gie.getEncode());
				goodsItem.setShelfLife(gie.getShelfLife());
				goodsItem.setCarTon(gie.getCarTon());

				GoodsPrice goodsPrice = new GoodsPrice();
				goodsPrice.setItemId(goodsItem.getItemId());
				goodsPrice.setMin(gie.getGoodsPrice().getMin());
				goodsPrice.setMax(gie.getGoodsPrice().getMax());
				goodsPrice.setProxyPrice(gie.getGoodsPrice().getProxyPrice());
				goodsPrice.setFxPrice(gie.getGoodsPrice().getFxPrice());
				goodsPrice.setRetailPrice(gie.getGoodsPrice().getRetailPrice());
				goodsPrice.setLinePrice(gie.getGoodsPrice().getLinePrice());
				goodsPrice.setOpt(entity.getOpt());

				goodsItem.setGoodsPrice(goodsPrice);
				goodsItem.setOpt(entity.getOpt());

				String keys = gie.getInfo();
				List<ItemSpecsPojo> specsPojos = new ArrayList<ItemSpecsPojo>();
				if ((keys != null && !"".equals(keys))) {
					String[] keyArray = keys.split(";");
					for (int i = 0; i < keyArray.length; i++) {
						ItemSpecsPojo itemSpecsPojo;
						if (keyArray[i].trim() != null || !"".equals(keyArray[i].trim())) {
							itemSpecsPojo = new ItemSpecsPojo();
							String[] kContesnts = keyArray[i].split("&");
							itemSpecsPojo.setSkId(kContesnts[0].split("\\|")[0]);
							itemSpecsPojo.setSkV(kContesnts[0].split("\\|")[1]);
							itemSpecsPojo.setSvId(kContesnts[1].split("\\|")[0]);
							itemSpecsPojo.setSvV(kContesnts[1].split("\\|")[1]);
							specsPojos.add(itemSpecsPojo);
						}
					}

					JSONArray json = JSONArray.fromObject(specsPojos);
					goodsItem.setInfo(json.toString());
				}
				items.add(goodsItem);
			}
		} else {
			GoodsItemEntity goodsItem = new GoodsItemEntity();
			int itemid = staffMapper.nextVal(ServerCenterContants.GOODS_ITEM_ID_SEQUENCE);
			goodsItem.setGoodsId(goods.getGoodsId());
			goodsItem.setItemId(SequeceRule.getGoodsItemId(itemid));
			goodsItem.setItemCode(entity.getItemCode());
			goodsItem.setSku(entity.getSku());
			goodsItem.setWeight(entity.getWeight());
			goodsItem.setExciseTax(entity.getExciseTax());
			goodsItem.setStatus(GoodsStatusEnum.DOWNSHELF.getIndex() + "");
			goodsItem.setConversion(entity.getConversion());
			goodsItem.setEncode(entity.getEncode());
			goodsItem.setShelfLife(entity.getShelfLife());
			goodsItem.setCarTon(entity.getCarTon());

			GoodsPrice goodsPrice = new GoodsPrice();
			goodsPrice.setItemId(goodsItem.getItemId());
			goodsPrice.setMin(entity.getMin());
			goodsPrice.setMax(entity.getMax());
			goodsPrice.setProxyPrice(entity.getProxyPrice());
			goodsPrice.setFxPrice(entity.getFxPrice());
			goodsPrice.setRetailPrice(entity.getRetailPrice());
			goodsPrice.setLinePrice(entity.getLinePrice());
			goodsPrice.setOpt(entity.getOpt());

			goodsItem.setGoodsPrice(goodsPrice);
			goodsItem.setOpt(entity.getOpt());
			items.add(goodsItem);
		}
		goods.setItems(items);

		// 新增商品时判断是否添加商品标签
		if (!"".equals(entity.getTagId()) && entity.getTagId() != null) {
			List<GoodsTagBindEntity> goodsTagBindList = new ArrayList<GoodsTagBindEntity>();
			GoodsTagBindEntity goodsTagBindEntity = null;
			String[] tagArray = entity.getTagId().split("\\|");
			for (GoodsItemEntity gie : items) {
				for (int i = 0; i < tagArray.length; i++) {
					if (tagArray[i].trim() != null || !"".equals(tagArray[i].trim())) {
						goodsTagBindEntity = new GoodsTagBindEntity();
						goodsTagBindEntity.setItemId(gie.getItemId());
						goodsTagBindEntity.setTagId(Integer.parseInt(tagArray[i].trim()));
						goodsTagBindList.add(goodsTagBindEntity);
					}
				}
			}
			goods.setGoodsTagBindList(goodsTagBindList);
		}

		GoodsInfoEntity goodsInfoEntity = new GoodsInfoEntity();
		goodsInfoEntity.setGoods(goods);

		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_CREATE_ITEMINFO, staffEntity.getToken(),
				true, goodsInfoEntity, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("添加商品规格信息操作失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	public List<GoodsPriceRatioEntity> queryGoodsPriceRatioList(GoodsItemEntity entity, String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_QUERY_GOODS_PIRCE_RATIO_LIST_INFO, token,
				true, entity, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		List<GoodsPriceRatioEntity> list = new ArrayList<GoodsPriceRatioEntity>();
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			list.add(JSONUtilNew.parse(jObj.toString(), GoodsPriceRatioEntity.class));
		}
		return list;
	}

	@Override
	@Log(content = "同步商品比价信息操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void syncRatioGoodsInfo(List<GoodsPriceRatioEntity> list, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		for (GoodsPriceRatioEntity gpre : list) {
			gpre.setStatus(0);
			gpre.setOpt(staffEntity.getOpt());
		}

		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_SYNC_GOODS_PRICE_RATIO_INFO,
				staffEntity.getToken(), true, list, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("同步商品比价信息操作失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	public GoodsEntity queryGoodsInfoByGoodsId(String goodsId, String token) {
		GoodsEntity entity = new GoodsEntity();
		entity.setGoodsId(goodsId);

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_QUERY_GOODSINFO_BY_GOODSID, token, true,
				entity, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), GoodsEntity.class);
	}

	@Override
	public List<String> queryGoodsIdByItemCode(String itemCode, String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_MAINTAIN_FILES_QUERY_GOODSID_BY_ITEMCODE,
				token, true, itemCode, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		if (index == 0) {
			return null;
		}
		List<String> list = new ArrayList<String>();
		for (int i = 0; i < index; i++) {
			list.add(obj.get(i).toString());
		}
		return list;
	}
	
	@Override
	public List<String> queryGoodsPic(String goodsId, String token) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("goodsId", goodsId);
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_QUERY_GOODSPIC_BY_GOODSID,
				token, true, null, HttpMethod.GET, param);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		if (index == 0) {
			return null;
		}
		List<String> list = new ArrayList<String>();
		for (int i = 0; i < index; i++) {
			list.add(obj.get(i).toString());
		}
		return list;
	}
	
	@Override
	public List<Tax> getTaxInfoByItemIds(List<String> itemIds, String token) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_QUERY_TAX_INFO_BY_ITEMID_LIST,
				token, true, itemIds, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		if (index == 0) {
			return null;
		}
		List<Tax> list = new ArrayList<Tax>();
		for (int i = 0; i < index; i++) {
			list.add(JSONUtilNew.parse(obj.get(i).toString(), Tax.class));
		}
		return list;
	}

}
