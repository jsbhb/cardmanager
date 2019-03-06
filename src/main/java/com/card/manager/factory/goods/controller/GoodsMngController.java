package com.card.manager.factory.goods.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.annotation.Auth;
import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.common.ResourceContants;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.goods.GoodsUtil;
import com.card.manager.factory.goods.grademodel.KJGoodsDTO;
import com.card.manager.factory.goods.model.FirstCatalogEntity;
import com.card.manager.factory.goods.model.GoodsFile;
import com.card.manager.factory.goods.model.WarehouseModel;
import com.card.manager.factory.goods.pojo.GoodsFielsMaintainBO;
import com.card.manager.factory.goods.pojo.po.BackGoodsPO;
import com.card.manager.factory.goods.pojo.po.Goods;
import com.card.manager.factory.goods.pojo.po.GoodsPricePO;
import com.card.manager.factory.goods.pojo.po.GoodsSpecs;
import com.card.manager.factory.goods.pojo.po.GoodsSpecsTradePattern;
import com.card.manager.factory.goods.pojo.po.Items;
import com.card.manager.factory.goods.service.CatalogService;
import com.card.manager.factory.goods.service.GoodsService;
import com.card.manager.factory.goods.service.SpecsService;
import com.card.manager.factory.log.SysLogger;
import com.card.manager.factory.socket.task.SocketClient;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.CompressFileUtils;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;
import com.card.manager.factory.util.URLUtils;

@Controller
@RequestMapping("/admin/goods/goodsMng")
public class GoodsMngController extends BaseController {

	@Resource
	GoodsService goodsService;

	@Resource
	CatalogService catalogService;

	@Resource
	SpecsService specsService;

	@Resource
	SysLogger sysLogger;

	@RequestMapping(value = "/mng")
	public ModelAndView toFuncList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("goods/goods/add_choose", context);
	}

	@RequestMapping(value = "/toAddKJGoods")
	public ModelAndView toAddKJGoods(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {
			context.put("suppliers", CachePoolComponent.getSupplier(opt.getToken()));
			context.put("brands", CachePoolComponent.getBrands(opt.getToken()));
			List<FirstCatalogEntity> catalogs = catalogService.queryFirstCatalogs(opt.getToken());
			context.put("firsts", catalogs);

			// 先获取goodsId
			context.put("goodsId", goodsService.getGoodsId());
			return forword("goods/goods/add", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
	}

	@RequestMapping(value = "/checkEncodeExist", method = RequestMethod.POST)
	public void checkEncodeExist(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		// try {
		// String encode = req.getParameter("encode");
		// String goodsType = req.getParameter("goodsType");
		// BackGoodsPO backGoodsPo =
		// goodsService.queryBackGoodsPoByEncode(encode, goodsType,
		// staffEntity);
		// if (backGoodsPo != null) {
		// // 初始化商详信息
		// String detailInfo = "";
		// // 包含商详地址
		// if (backGoodsPo.getGoods().getDetailPath() != null
		// && backGoodsPo.getGoods().getDetailPath().indexOf("html") > 0) {
		// try {
		// detailInfo =
		// goodsService.getHtmlContext(backGoodsPo.getGoods().getDetailPath(),
		// staffEntity);
		// } catch (Exception e) {
		// sendFailureMessage(resp, e.getMessage());
		// }
		// } else if (backGoodsPo.getGoods().getDetailPath() != null) {
		// String[] imgArr = backGoodsPo.getGoods().getDetailPath().split(";");
		// String BaseUrl = URLUtils.get("static");
		// for (int i = 0; i < imgArr.length; i++) {
		// detailInfo = detailInfo + "<p style=\"text-align: center;\"><img
		// src=\"" + BaseUrl
		// + "/images/orignal/detail/" + imgArr[i] + "\"></p> ";
		// }
		// detailInfo = detailInfo + "<p><br/></p>";
		// }
		// backGoodsPo.getGoods().setDetailPath(detailInfo);
		// GoodsUtil.changeGoodsSpecsInfoToList(backGoodsPo.getSpecsList());
		// GoodsUtil.changeGoodsCategoryInfo(backGoodsPo,
		// staffEntity.getToken());
		// sendSuccessObject(resp, backGoodsPo);
		// } else {
		// sendSuccessMessage(resp, "");
		// }
		// } catch (Exception e) {
		// sendFailureMessage(resp, "操作失败：" + e.getMessage());
		// return;
		// }

		BackGoodsPO backGoodsPo = new BackGoodsPO();
		Goods g = new Goods();
		g.setGoodsId("100001795");
		g.setGoodsName("测试商品");
		g.setType(0);
		g.setBrandId("brand_5");
		g.setBrandName("高丝");
		g.setOrigin("美国");
		g.setHscode("hscode123456");
		g.setFirstCategory("first3");
		g.setSecondCategory("second6");
		g.setThirdCategory("third3");
		List<GoodsFile> gfList = new ArrayList<GoodsFile>();
		GoodsFile gf = null;
		gf = new GoodsFile();
		gf.setPath(
				"https://static.cncoopbuy.com:8080/goods/100000798/master/images/008516dc-7d08-4048-b018-b2cc312241d6.jpg");
		gfList.add(gf);
		gf = new GoodsFile();
		gf.setPath(
				"https://static.cncoopbuy.com:8080/goods/100000798/master/images/aa6e55c1-7013-4d79-b0cb-577e4b4f9036.jpg");
		gfList.add(gf);
		gf = new GoodsFile();
		gf.setPath(
				"https://static.cncoopbuy.com:8080/goods/100000798/master/images/9ec7e9ec-030b-42a7-bb5d-21ffa0d068a7.jpg");
		gfList.add(gf);
		g.setGoodsFileList(gfList);
		g.setDetailPath("https://teststatic.cncoopbuy.com:8080/goods/105050200/detail/html/GZKJ0495010037.html");
		// 初始化商详信息
		String detailInfo = "";
		// 包含商详地址
		if (g.getDetailPath() != null && g.getDetailPath().indexOf("html") > 0) {
			try {
				detailInfo = goodsService.getHtmlContext(g.getDetailPath(), staffEntity);
			} catch (Exception e) {
				sendFailureMessage(resp, e.getMessage());
			}
		} else if (g.getDetailPath() != null) {
			String[] imgArr = g.getDetailPath().split(";");
			String BaseUrl = URLUtils.get("static");
			for (int i = 0; i < imgArr.length; i++) {
				detailInfo = detailInfo + "<p style=\"text-align: center;\"><img src=\"" + BaseUrl
						+ "/images/orignal/detail/" + imgArr[i] + "\"></p> ";
			}
			detailInfo = detailInfo + "<p><br/></p>";
		}
		g.setDetailPath(detailInfo);
		backGoodsPo.setGoods(g);

		List<GoodsSpecs> gslist = new ArrayList<GoodsSpecs>();
		GoodsSpecs gs = new GoodsSpecs();
		gs.setSpecsId("100001795-1");
		gs.setEncode("encode123456");
		gs.setWeight(1500);
		gs.setUnit("件");
		gs.setDescription("测试specs");
		gs.setSpecsGoodsName("30g");
		gs.setConversion(5);
		gs.setCarton("6box");
		gs.setInfo(
				"[{\"svV\":\"1盒装\",\"skId\":\"5\",\"svId\":\"60\",\"skV\":\"套装\"},{\"svV\":\"抹茶味\",\"skId\":\"1\",\"svId\":\"245\",\"skV\":\"口味\"}]");
		gslist.add(gs);
		backGoodsPo.setSpecsList(gslist);
		GoodsUtil.changeGoodsSpecsInfoToList(backGoodsPo.getSpecsList());

		List<Items> itemList = new ArrayList<Items>();
		Items item = new Items();
		item.setSupplierId(3);
		item.setSupplierName("行云仓");
		item.setItemCode("itemcode123456");
		item.setSku("sku123456");
		item.setStatus(2);
		item.setUnit("件");
		item.setShelfLife("2年");
		itemList.add(item);
		item = new Items();
		item.setSupplierId(8);
		item.setSupplierName("乾丰仓");
		item.setItemCode("itemcode1234567");
		item.setSku("sku1234567");
		item.setStatus(1);
		item.setUnit("件");
		item.setShelfLife("1年");
		itemList.add(item);
		backGoodsPo.setItemsList(itemList);

		List<GoodsSpecsTradePattern> specsTpList = new ArrayList<GoodsSpecsTradePattern>();
		GoodsSpecsTradePattern gstp = new GoodsSpecsTradePattern();
		gstp.setGoodsId("100001795");
		gstp.setSpecsId("100001795-1");
		gstp.setSpecsTpId("100001795-2");
		specsTpList.add(gstp);
		backGoodsPo.setGoodsSpecsTpList(specsTpList);

		GoodsUtil.changeGoodsCategoryInfo(backGoodsPo, staffEntity.getToken());
		sendSuccessObject(resp, backGoodsPo);
		// sendSuccessMessage(resp, "");
	}

	@RequestMapping(value = "/saveKJGoodsInfo", method = RequestMethod.POST)
	public void saveKJGoodsInfo(HttpServletRequest req, HttpServletResponse resp, @RequestBody KJGoodsDTO entity) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		entity.setOpt(staffEntity.getOptName());
		try {
			goodsService.saveKJGoodsInfo(entity, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		sendSuccessMessage(resp, "");
	}

	@RequestMapping(value = "/toEditKJGoodsInfo")
	public ModelAndView toEditKJGoodsInfo(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			// String itemId = req.getParameter("itemId");
			// BackGoodsPO backGoodsPo =
			// goodsService.queryBackGoodsPoByItemId(itemId, staffEntity);
			// if (backGoodsPo != null) {
			// // 初始化商详信息
			// String detailInfo = "";
			// // 包含商详地址
			// if (backGoodsPo.getGoods().getDetailPath() != null
			// && backGoodsPo.getGoods().getDetailPath().indexOf("html") > 0) {
			// try {
			// detailInfo =
			// goodsService.getHtmlContext(backGoodsPo.getGoods().getDetailPath(),
			// staffEntity);
			// } catch (Exception e) {
			// sendFailureMessage(resp, e.getMessage());
			// }
			// } else if (backGoodsPo.getGoods().getDetailPath() != null) {
			// String[] imgArr =
			// backGoodsPo.getGoods().getDetailPath().split(";");
			// String BaseUrl = URLUtils.get("static");
			// for (int i = 0; i < imgArr.length; i++) {
			// detailInfo = detailInfo + "<p style=\"text-align: center;\"><img
			// src=\"" + BaseUrl
			// + "/images/orignal/detail/" + imgArr[i] + "\"></p> ";
			// }
			// detailInfo = detailInfo + "<p><br/></p>";
			// }
			// backGoodsPo.getGoods().setDetailPath(detailInfo);
			// GoodsUtil.changeGoodsSpecsInfoToList(backGoodsPo.getSpecsList());
			// GoodsUtil.changeGoodsCategoryInfo(backGoodsPo,
			// staffEntity.getToken());
			// }

			BackGoodsPO backGoodsPo = new BackGoodsPO();
			Goods g = new Goods();
			g.setGoodsId("100001795");
			g.setGoodsName("测试商品");
			g.setDescription("卖点1 卖点2");
			g.setType(0);
			g.setBrandId("brand_5");
			g.setBrandName("高丝");
			g.setOrigin("美国");
			g.setHscode("hscode123456");
			g.setFirstCategory("first3");
			g.setSecondCategory("second6");
			g.setThirdCategory("third3");
			List<GoodsFile> gfList = new ArrayList<GoodsFile>();
			GoodsFile gf = null;
			gf = new GoodsFile();
			gf.setPath(
					"https://static.cncoopbuy.com:8080/goods/100000798/master/images/008516dc-7d08-4048-b018-b2cc312241d6.jpg");
			gfList.add(gf);
			gf = new GoodsFile();
			gf.setPath(
					"https://static.cncoopbuy.com:8080/goods/100000798/master/images/aa6e55c1-7013-4d79-b0cb-577e4b4f9036.jpg");
			gfList.add(gf);
			gf = new GoodsFile();
			gf.setPath(
					"https://static.cncoopbuy.com:8080/goods/100000798/master/images/9ec7e9ec-030b-42a7-bb5d-21ffa0d068a7.jpg");
			gfList.add(gf);
			g.setGoodsFileList(gfList);
			g.setDetailPath("https://teststatic.cncoopbuy.com:8080/goods/105050200/detail/html/GZKJ0495010037.html");
			// 初始化商详信息
			String detailInfo = "";
			// 包含商详地址
			if (g.getDetailPath() != null && g.getDetailPath().indexOf("html") > 0) {
				try {
					detailInfo = goodsService.getHtmlContext(g.getDetailPath(), staffEntity);
				} catch (Exception e) {
					sendFailureMessage(resp, e.getMessage());
				}
			} else if (g.getDetailPath() != null) {
				String[] imgArr = g.getDetailPath().split(";");
				String BaseUrl = URLUtils.get("static");
				for (int i = 0; i < imgArr.length; i++) {
					detailInfo = detailInfo + "<p style=\"text-align: center;\"><img src=\"" + BaseUrl
							+ "/images/orignal/detail/" + imgArr[i] + "\"></p> ";
				}
				detailInfo = detailInfo + "<p><br/></p>";
			}
			g.setDetailPath(detailInfo);
			backGoodsPo.setGoods(g);

			List<GoodsSpecs> gslist = new ArrayList<GoodsSpecs>();
			GoodsSpecs gs = new GoodsSpecs();
			gs.setSpecsId("100001795-1");
			gs.setEncode("encode123456");
			gs.setWeight(1500);
			gs.setUnit("件");
			gs.setDescription("测试specs");
			gs.setSpecsGoodsName("30g");
			gs.setConversion(5);
			gs.setCarton("6box");
			gs.setInfo(
					"[{\"svV\":\"1盒装\",\"skId\":\"5\",\"svId\":\"60\",\"skV\":\"套装\"},{\"svV\":\"抹茶味\",\"skId\":\"1\",\"svId\":\"245\",\"skV\":\"口味\"}]");
			gslist.add(gs);
			backGoodsPo.setSpecsList(gslist);
			GoodsUtil.changeGoodsSpecsInfoToList(backGoodsPo.getSpecsList());

			List<Items> itemList = new ArrayList<Items>();
			Items item = new Items();
			item.setItemId("100001795-3");
			item.setSpecsTpId("100001795-2");
			item.setSupplierId(3);
			item.setSupplierName("行云仓");
			item.setItemCode("itemcode123456");
			item.setSku("sku123456");
			item.setStatus(2);
			item.setUnit("件");
			item.setShelfLife("2年");
			itemList.add(item);
			backGoodsPo.setItemsList(itemList);

			List<GoodsSpecsTradePattern> specsTpList = new ArrayList<GoodsSpecsTradePattern>();
			GoodsSpecsTradePattern gstp = new GoodsSpecsTradePattern();
			gstp.setGoodsId("100001795");
			gstp.setSpecsId("100001795-1");
			gstp.setSpecsTpId("100001795-2");
			specsTpList.add(gstp);
			backGoodsPo.setGoodsSpecsTpList(specsTpList);
			GoodsUtil.changeGoodsCategoryInfo(backGoodsPo, staffEntity.getToken());

			List<GoodsPricePO> priceList = new ArrayList<GoodsPricePO>();
			GoodsPricePO goodsPrice = new GoodsPricePO();
			goodsPrice.setItemId("100001795-3");
			goodsPrice.setSpecsTpId("100001795-2");
			goodsPrice.setCostPrice(110);
			goodsPrice.setInternalPrice(120);
			priceList.add(goodsPrice);
			backGoodsPo.setPriceList(priceList);

			List<WarehouseModel> stockList = new ArrayList<WarehouseModel>();
			WarehouseModel stock = new WarehouseModel();
			stock.setItemId("100001795-3");
			stock.setSpecsTpId("100001795-2");
			stock.setFxqty(100);
			stockList.add(stock);
			backGoodsPo.setStockList(stockList);

			context.put("backGoodsPo", backGoodsPo);
			context.put("suppliers", CachePoolComponent.getSupplier(staffEntity.getToken()));
			context.put("brands", CachePoolComponent.getBrands(staffEntity.getToken()));
			List<FirstCatalogEntity> catalogs = catalogService.queryFirstCatalogs(staffEntity.getToken());
			context.put("firsts", catalogs);

			return forword("goods/goods/edit", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
	}

	@RequestMapping(value = "/editKJGoodsInfo", method = RequestMethod.POST)
	public void editKJGoodsInfo(HttpServletRequest req, HttpServletResponse resp, @RequestBody KJGoodsDTO entity) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		entity.setOpt(staffEntity.getOptName());
		try {
			goodsService.modifyKJGoodsInfo(entity, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		sendSuccessMessage(resp, null);
	}

	// @RequestMapping(value = "/toTag")
	// public ModelAndView toTag(HttpServletRequest req, HttpServletResponse
	// resp) {
	// Map<String, Object> context = getRootMap();
	// StaffEntity opt = SessionUtils.getOperator(req);
	// context.put(OPT, opt);
	// try {
	// return forword("goods/goods/addTag", context);
	// } catch (Exception e) {
	// context.put(ERROR, e.getMessage());
	// return forword(ERROR, context);
	// }
	// }
	//
	// @RequestMapping(value = "/refreshTag", method = RequestMethod.POST)
	// public void refreshTag(HttpServletRequest req, HttpServletResponse resp)
	// {
	// StaffEntity staffEntity = SessionUtils.getOperator(req);
	// try {
	// List<GoodsTagEntity> tags =
	// goodsService.queryGoodsTags(staffEntity.getToken());
	// sendSuccessObject(resp, tags);
	// } catch (Exception e) {
	// sendFailureMessage(resp, "操作失败：" + e.getMessage());
	// return;
	// }
	// }
	//
	// @RequestMapping(value = "/saveTag", method = RequestMethod.POST)
	// public void saveTag(HttpServletRequest req, HttpServletResponse resp,
	// @RequestBody GoodsTagEntity goodsTag) {
	// StaffEntity staffEntity = SessionUtils.getOperator(req);
	// try {
	// goodsTag.setPriority(1);
	// goodsService.addGoodsTag(goodsTag, staffEntity.getToken());
	// } catch (Exception e) {
	// sendFailureMessage(resp, "操作失败：" + e.getMessage());
	// return;
	// }
	// sendSuccessMessage(resp, null);
	// }

	@RequestMapping(value = "/toAddBatch")
	public ModelAndView toAddBatch(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		return forword("goods/goods/goodsImport", context);
	}

	@RequestMapping(value = "/importGoodsInfo", method = RequestMethod.POST)
	public void importGoodsInfo(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String filePath = req.getParameter("filePath");
			if (StringUtil.isEmpty(filePath)) {
				sendFailureMessage(resp, "操作失败：文件路径不正确");
				return;
			}
			Map<String, Object> result = goodsService.importGoodsInfo(filePath, staffEntity);
			if ((boolean) result.get("success")) {
				sendSuccessMessage(resp, result.get("msg") + "");
			} else {
				sendFailureMessage(resp, result.get("msg") + "");
			}
		} catch (Exception e) {
			sysLogger.error("批量导入商品", "error", e);
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
	}

	@RequestMapping(value = "/exportGoodsInfoTemplate", method = RequestMethod.GET)
	public void exportGoodsInfoTemplate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		try {
			StaffEntity staffEntity = SessionUtils.getOperator(req);
			goodsService.exportGoodsInfoTemplate(req, resp, staffEntity);
		} catch (Exception e) {
			resp.setContentType("text/html;charset=utf-8");
			resp.getWriter().println("下载失败，请重试!");
			resp.getWriter().println(e.getMessage());
			return;
		}
	}

	private final int MAX_SIZE = 1024 * 50 * 1024; // 50MB
	SimpleDateFormat sdf = new SimpleDateFormat("YYYYMMDDhhmmssSSS");

	@RequestMapping(value = "/toBatchUploadPic")
	public ModelAndView toBatchUploadPic(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		return forword("goods/goods/goodsPicBatchImport", context);
	}

	@RequestMapping(value = "/uploadCompressedFile", method = RequestMethod.POST)
	@Auth(verifyLogin = false, verifyURL = false)
	public void uploadFile(@RequestParam("file") MultipartFile file, HttpServletRequest req, HttpServletResponse resp) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);

		if (file != null) {

			if (file.getSize() > MAX_SIZE) {
				sendFailureMessage(resp, "文件内容超过50M，请合理控制上传文件大小！");
				return;
			}

			String fileName = file.getOriginalFilename();
			// 文件后缀
			String suffix = fileName.indexOf(".") != -1
					? fileName.substring(fileName.lastIndexOf("."), fileName.length()) : null;

			String itemCode = fileName.indexOf(".") != -1 ? fileName.substring(0, fileName.lastIndexOf(".")) : null;

			// 通过itemCode获得对应的goodsId
			List<String> goodsIds = goodsService.queryGoodsIdByItemCode(itemCode, staffEntity.getToken());
			if (goodsIds.size() <= 0) {
				sendFailureMessage(resp, "该自有编码未匹配到对应的商品ID，请确认自有编码是否正确！");
				return;
			} else if (goodsIds.size() > 1) {
				sendFailureMessage(resp, "该自有编码匹配到多个商品ID，请联系技术先合并商品ID！");
				return;
			} else {
				// 将查询到的goodsId 替换itemCode的值
				itemCode = goodsIds.get(0);
			}

			// 源文件名称
			String sourceNameWithoutSuffix = itemCode + "-" + sdf.format(new Date()) + "-" + staffEntity.getBadge();
			// 源文件名称
			String sourceName = sourceNameWithoutSuffix + suffix;

			if (!".zip".equalsIgnoreCase(suffix) && !".rar".equalsIgnoreCase(suffix)) {
				sendFailureMessage(resp, "文件格式有误！");
				return;
			}

			String compressedFilePath = req.getServletContext().getRealPath("upload") + "/";
			File descFiles = new File(compressedFilePath + sourceName);

			try {
				// 后台保存文件

				if (!descFiles.exists()) {
					descFiles.mkdirs();
				}

				file.transferTo(descFiles);

				// 解压缩
				if (".zip".equalsIgnoreCase(suffix)) {
					CompressFileUtils.unZipFiles(compressedFilePath + sourceName,
							compressedFilePath + sourceNameWithoutSuffix);
				} else if (".rar".equalsIgnoreCase(suffix)) {
					CompressFileUtils.unRarFile(compressedFilePath + sourceName,
							compressedFilePath + sourceNameWithoutSuffix);
				} else {
					sendFailureMessage(resp, "没有指定压缩包！" + compressedFilePath + sourceName);
					return;
				}

				File directory = new File(compressedFilePath + sourceNameWithoutSuffix);

				// 解压后的目录结构
				String[] itemCodeList = directory.list();
				if (itemCodeList == null || itemCodeList.length == 0) {
					sendFailureMessage(resp, "没有商品信息！");
					return;
				}

				// 重命名目录结构
				for (String itemCodeFile : itemCodeList) {
					File fileDir = new File(compressedFilePath + sourceNameWithoutSuffix + "/" + itemCodeFile);
					File newFileDir = new File(compressedFilePath + sourceNameWithoutSuffix + "/" + itemCode);
					if (!fileDir.renameTo(newFileDir)) {
						sendFailureMessage(resp, "自有编码装换为商品ID时异常，请重新上传压缩包！");
						return;
					}
				}
				itemCodeList = directory.list();

				GoodsFielsMaintainBO bo;
				List<GoodsFielsMaintainBO> list = new ArrayList<GoodsFielsMaintainBO>();
				for (String itemCodeFile : itemCodeList) {
					try {
						bo = dealGoodsPic(itemCodeFile, compressedFilePath + sourceNameWithoutSuffix, staffEntity);
						if (bo == null) {
							continue;
						}
						bo.setItemCode(itemCodeFile);
						list.add(bo);
					} catch (Exception e) {
						e.printStackTrace();
						sendFailureMessage(resp, "操作失败：" + e.getMessage());
					}
				}

				goodsService.batchUploadPic(list, staffEntity.getToken());

				sendSuccessMessage(resp, "");

			} catch (Exception e) {
				sendFailureMessage(resp, "操作失败：" + e.getMessage());
			} finally {
				delAllFile(compressedFilePath + sourceNameWithoutSuffix);
				descFiles.delete();
			}
		} else {
			sendFailureMessage(resp, "没有文件内容！");
		}
	}

	private static boolean delAllFile(String path) {
		boolean flag = false;
		File file = new File(path);
		if (!file.exists()) {
			return flag;
		}
		if (!file.isDirectory()) {
			return flag;
		}
		String[] tempList = file.list();
		File temp = null;
		for (int i = 0; i < tempList.length; i++) {
			if (path.endsWith("/")) {
				temp = new File(path + tempList[i]);
			} else {
				temp = new File(path + "/" + tempList[i]);
			}
			if (temp.isFile()) {
				temp.delete();
			}
			if (temp.isDirectory()) {
				delAllFile(path + "/" + tempList[i]);// 先删除文件夹里面的文件
				delFolder(path + "/" + tempList[i]);// 再删除空文件夹
				flag = true;
			}
		}
		return flag;
	}

	public static void delFolder(String folderPath) {
		try {
			delAllFile(folderPath); // 删除完里面所有内容
			String filePath = folderPath;
			filePath = filePath.toString();
			java.io.File myFilePath = new java.io.File(filePath);
			myFilePath.delete(); // 删除空文件夹
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// private String getNewFileName(String itemCode, String fileName,
	// StaffEntity staffEntity, Integer i) {
	// // 文件后缀
	// String suffix = fileName.indexOf(".") != -1 ?
	// fileName.substring(fileName.lastIndexOf("."), fileName.length())
	// : null;
	//
	// // 源文件名称
	// String sourceNameWithoutSuffix = (fileName.indexOf(".") != -1 ?
	// fileName.substring(0, fileName.lastIndexOf("."))
	// : null) + "-" + sdf.format(new Date()) + "-" + staffEntity.getBadge() +
	// "-" + i;
	// // 源文件名称
	// return itemCode + "_" + sourceNameWithoutSuffix + suffix;
	// }

	/**
	 * dealGoodsPic:(这里用一句话描述这个方法的作用). <br/>
	 * 
	 * @author hebin
	 * @param string
	 * @throws Exception
	 * @since JDK 1.7
	 */
	private GoodsFielsMaintainBO dealGoodsPic(String itemCode, String path, StaffEntity staffEntity) throws Exception {
		File file = new File(path + "/" + itemCode);
		List<String> coverList = new ArrayList<String>();
		List<String> detailList = new ArrayList<String>();
		GoodsFielsMaintainBO bo = new GoodsFielsMaintainBO();

		if (!file.exists()) {
			throw new Exception("没有文件信息!");
		}

		if (file.isDirectory()) {
			System.out.println("文件夹！");
			String[] fileList = file.list();
			for (int i = 0; i < fileList.length; i++) {
				File readFile = new File(path + "/" + itemCode + "/" + fileList[i]);
				if (readFile.isDirectory()) {
					String name = readFile.getName();
					if ("detail".equals(name)) {
						String[] detailFileList = readFile.list();
						for (String detailFile : detailFileList) {
							if (detailFile.endsWith(".png") || detailFile.endsWith(".jpg")
									|| detailFile.endsWith(".gif") || detailFile.endsWith(".jpeg")) {
								detailList.add(detailFile);
							}
						}
					}
				} else {
					if (fileList[i].endsWith(".png") || fileList[i].endsWith(".jpg") || fileList[i].endsWith(".gif")
							|| fileList[i].endsWith(".jpeg")) {
						coverList.add(fileList[i]);
					}
				}
			}

			if (coverList.size() == 0) {
				throw new Exception("没有主图信息");
			} else {
				bo.setPicPathList(dealCoverPic(itemCode, path + "/" + itemCode, coverList, staffEntity));
			}

			if (detailList.size() != 0) {
				bo.setGoodsDetailPath(
						dealDetailPic(itemCode, path + "/" + itemCode + "/" + "detail", detailList, staffEntity));
			}
		} else {
			throw new Exception("文件格式出错");
		}
		return bo;
	}

	/**
	 * dealCoverPic:处理主图图片. <br/>
	 * 
	 * @author hebin
	 * @param coverList
	 * @throws Exception
	 * @since JDK 1.7
	 */
	private List<String> dealCoverPic(String itemCode, String path, List<String> coverList, StaffEntity staffEntity)
			throws Exception {
		String remotePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.GOODS + "/" + itemCode + "/"
				+ ResourceContants.MASTER + "/" + ResourceContants.IMAGE + "/";

		List<String> coverInviteList = new ArrayList<String>();
		File file;
		// String newFileName;
		Collections.sort(coverList, new Comparator<String>() {

			@Override
			public int compare(String file0, String file1) {
				try {
					String s1 = file0.substring(0, file0.lastIndexOf("."));
					String s2 = file1.substring(0, file1.lastIndexOf("."));
					return s1.compareTo(s2);
				} catch (Exception e) {
					return 1;
				}
			}
		});
		// int i = 0;
		for (String fileName : coverList) {
			file = new File(path + "/" + fileName);
			// newFileName = getNewFileName(itemCode, fileName, staffEntity, i);
			// i++;

			SocketClient client = null;
			try {
				client = new SocketClient();
				client.sendFile(file.getPath(), remotePath);
				client.quit();
				client.close();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (client != null) {
					client.close();
				}
			}
			coverInviteList.add(URLUtils.get("static") + "/" + ResourceContants.GOODS + "/" + itemCode + "/"
					+ ResourceContants.MASTER + "/" + ResourceContants.IMAGE + "/" + file.getName());
		}
		return coverInviteList;
	}

	/**
	 * dealDetailPic:处理商品详情图片. <br/>
	 * 
	 * @author hebin
	 * @param detailList
	 * @throws Exception
	 * @since JDK 1.7
	 */
	private String dealDetailPic(String itemCode, String path, List<String> detailList, StaffEntity staffEntity)
			throws Exception {
		String remotePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.GOODS + "/" + itemCode + "/"
				+ ResourceContants.DETAIL + "/" + ResourceContants.IMAGE + "/";
		File file;
		// String newFileName;
		StringBuffer sb = new StringBuffer();

		Collections.sort(detailList, new Comparator<String>() {

			@Override
			public int compare(String file0, String file1) {
				try {
					Integer num0 = Integer.parseInt(file0.substring(0, file0.lastIndexOf(".")));
					Integer num1 = Integer.parseInt(file1.substring(0, file1.lastIndexOf(".")));
					if (num0 < num1) {
						return -1;
					} else {
						return 1;
					}
				} catch (Exception e) {
					return 1;
				}
			}
		});
		// int i = 0;
		for (String fileName : detailList) {
			file = new File(path + "/" + fileName);
			// newFileName = getNewFileName(itemCode, fileName, staffEntity, i);
			// i++;

			SocketClient client = null;
			try {
				client = new SocketClient();
				client.sendFile(file.getPath(), remotePath);
				client.quit();
				client.close();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (client != null) {
					client.close();
				}
			}

			sb.append("<p style=\"text-align: center;\"><img src=\"");
			sb.append(URLUtils.get("static") + "/" + ResourceContants.GOODS + "/" + itemCode + "/"
					+ ResourceContants.DETAIL + "/" + ResourceContants.IMAGE + "/" + file.getName());
			sb.append("\"></p>");
		}

		// 新建临时目录和文件 将商详内容写入文件中
		String tmpHtmlPath = path + "/" + ResourceContants.HTML + "/";
		File directory = new File(tmpHtmlPath);
		if (!directory.exists()) {
			directory.mkdirs();
		}
		tmpHtmlPath = tmpHtmlPath + "/" + itemCode + ResourceContants.HTML_SUFFIX;
		InputStream is = new ByteArrayInputStream(sb.toString().getBytes("utf-8"));
		BufferedInputStream bin = null;
		BufferedOutputStream bout = null;
		bin = new BufferedInputStream(is);
		bout = new BufferedOutputStream(new FileOutputStream(tmpHtmlPath));
		int len = -1;
		byte[] b = new byte[1024];
		while ((len = bin.read(b)) != -1) {
			bout.write(b, 0, len);
		}
		bin.close();
		bout.close();

		return goodsService.saveModelHtml(itemCode, tmpHtmlPath, staffEntity);
	}
}
