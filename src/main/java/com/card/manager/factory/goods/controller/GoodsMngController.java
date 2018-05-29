package com.card.manager.factory.goods.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.annotation.Auth;
import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.base.PageCallBack;
import com.card.manager.factory.base.Pagination;
import com.card.manager.factory.common.ResourceContants;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.ftp.service.SftpService;
import com.card.manager.factory.goods.model.FirstCatalogEntity;
import com.card.manager.factory.goods.model.GoodsEntity;
import com.card.manager.factory.goods.model.GoodsFile;
import com.card.manager.factory.goods.model.GoodsTagEntity;
import com.card.manager.factory.goods.model.SecondCatalogEntity;
import com.card.manager.factory.goods.model.ThirdCatalogEntity;
import com.card.manager.factory.goods.model.ThirdWarehouseGoods;
import com.card.manager.factory.goods.pojo.CreateGoodsInfoEntity;
import com.card.manager.factory.goods.pojo.GoodsFielsMaintainBO;
import com.card.manager.factory.goods.pojo.GoodsInfoEntity;
import com.card.manager.factory.goods.pojo.GoodsPojo;
import com.card.manager.factory.goods.pojo.ItemSpecsPojo;
import com.card.manager.factory.goods.service.CatalogService;
import com.card.manager.factory.goods.service.GoodsService;
import com.card.manager.factory.goods.service.SpecsService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.CompressFileUtils;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

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
	SftpService sftpService;

	@RequestMapping(value = "/mng")
	public ModelAndView toFuncList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("goods/goods/add_choose", context);
	}

	@RequestMapping(value = "/ueditor")
	public ModelAndView ueditor(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);

		if (StringUtil.isEmpty(req.getParameter("goodsId"))) {
			context.put(ERROR, "没有商品id");
			return forword("error", context);
		}

		String html = req.getParameter("html");

		if (!StringUtil.isEmpty(html)) {
			context.put("html", html);
		}
		context.put("goodsId", req.getParameter("goodsId"));
		context.put("opt", opt);
		return forword("ueditor/index", context);
	}

	@RequestMapping(value = "/getDetailHtml", method = RequestMethod.POST)
	public void getDetailHtml(HttpServletRequest req, HttpServletResponse resp) {

		try {
			Thread.sleep(100);
		} catch (InterruptedException e1) {
			e1.printStackTrace();
		}

		StaffEntity staffEntity = SessionUtils.getOperator(req);

		String html = req.getParameter("html");

		if (StringUtil.isEmpty(html)) {
			sendFailureMessage(resp, "没有内容，无需上传");
			return;
		}

		String context = "";
		try {
			context = goodsService.getHtmlContext(html, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, context);
	}

	@RequestMapping(value = "/saveHtml", method = RequestMethod.POST)
	public void saveHtml(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);

		String html = req.getParameter("html");
		String goodsId = req.getParameter("goodsId");

		if (StringUtil.isEmpty(html)) {
			sendFailureMessage(resp, "没有内容，无需上传");
			return;
		}

		if (StringUtil.isEmpty(goodsId)) {
			sendFailureMessage(resp, "没有商品编号上传失败，请将文本保存到本地，联系客服处理！");
			return;
		}
		try {
			goodsService.saveHtml(goodsId, html, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/syncGoods")
	public ModelAndView syncGoods(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		try {
			context.put("suppliers", CachePoolComponent.getSupplier(opt.getToken()));
		} catch (Exception e) {
			context.put(ERROR, "同步供应商失败");
			return forword("error", context);
		}
		return forword("goods/goods/sync", context);
	}

	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		context.put("suppliers", CachePoolComponent.getSupplier(opt.getToken()));
		return forword("goods/goods/list", context);
	}

	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, GoodsEntity entity) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {

			String supplierId = req.getParameter("supplierId");
			if (!StringUtil.isEmpty(supplierId)) {
				entity.setSupplierId(Integer.parseInt(supplierId));
			}
			String goodsName = req.getParameter("goodsName");
			if (!StringUtil.isEmpty(goodsName)) {
				entity.setGoodsName(goodsName);
			}
			String goodsId = req.getParameter("goodsId");
			if (!StringUtil.isEmpty(goodsId)) {
				entity.setGoodsId(goodsId);
			}

			pcb = goodsService.dataList(entity, params, staffEntity.getToken(),
					ServerCenterContants.GOODS_CENTER_QUERY_FOR_PAGE, GoodsEntity.class);
		} catch (ServerCenterNullDataException e) {
			if (pcb == null) {
				pcb = new PageCallBack();
			}
			pcb.setPagination(entity);
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

	@RequestMapping(value = "/syncDataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack syncDataList(HttpServletRequest req, HttpServletResponse resp, Pagination pagination) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();

		params.put("sku", req.getParameter("sku"));
		params.put("itemCode", req.getParameter("itemCode"));
		params.put("supplierId", req.getParameter("supplierId"));
		params.put("status", req.getParameter("status"));
		try {
			pcb = goodsService.dataList(pagination, params, staffEntity.getToken(),
					ServerCenterContants.GOODS_CENTER_QUERY_THIRD_GOODS, ThirdWarehouseGoods.class);
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

	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {
			context.put("suppliers", CachePoolComponent.getSupplier(opt.getToken()));
			context.put("brands", CachePoolComponent.getBrands(opt.getToken()));
			List<FirstCatalogEntity> catalogs = catalogService.queryFirstCatalogs(opt.getToken());
			context.put("firsts", catalogs);
			// String type = req.getParameter("type");
			// if (SYNC.equals(type)) {
			// String id = req.getParameter("id");
			// if (StringUtil.isEmpty(id)) {
			// context.put(ERROR, "没有同步商品编码！");
			// return forword(ERROR, context);
			// }
			// ThirdWarehouseGoods thirdGoods = goodsService.queryThirdById(id,
			// opt.getToken());
			// context.put("third", thirdGoods);
			//
			// } else if (NORMAL.equals(type)) {
			// List<BrandEntity> brands =
			// CachePoolComponent.getBrands(opt.getToken());
			// if(brands.size() == 0){
			// context.put(ERROR,"没有品牌信息,无法查看基础商品！");
			// context.put(ERROR_CODE,"405！");
			// return forword("error", context);
			// }
			//
			// context.put("brands", brands);
			//
			// List<FirstCatalogEntity> catalogs =
			// catalogService.queryFirstCatalogs(opt.getToken());
			// context.put("firsts", catalogs);
			//
			// List<GoodsTagEntity> tags =
			// goodsService.queryGoodsTags(opt.getToken());
			// context.put("tags", tags);
			// } else {
			// context.put(ERROR, "没有新增类型，请联系管理员！");
			// return forword(ERROR, context);
			// }
			List<GoodsTagEntity> tags = goodsService.queryGoodsTags(opt.getToken());
			context.put("tags", tags);

			return forword("goods/goods/add", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
	}

	@RequestMapping(value = "/toAddBatch")
	public ModelAndView toAddBatch(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		return forword("goods/goods/goodsImport", context);
	}

	@RequestMapping(value = "/toShow")
	public ModelAndView toShow(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {
			String id = req.getParameter("id");
			GoodsEntity entity = goodsService.queryById(id, opt.getToken());
			context.put("goods", entity);
			List<GoodsTagEntity> tags = goodsService.queryGoodsTags(opt.getToken());
			context.put("tags", tags);
			return forword("goods/goods/show", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}

	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public void edit(HttpServletRequest req, HttpServletResponse resp, @RequestBody GoodsEntity goodsEntity) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		goodsEntity.setOpt(staffEntity.getOptid());
		try {
			GoodsEntity entity = goodsService.queryById(goodsEntity.getId() + "", staffEntity.getToken());
			List<GoodsFile> fileList = new ArrayList<GoodsFile>();
			int fs = entity.getFiles().size();
			GoodsFile gf = new GoodsFile();
			// 要保存的主图数
			int ufs = 0;
			for (int index = 1; index < 5; index++) {
				String fu = "getPicPath" + index;
				if (goodsEntity.getClass().getMethod(fu, new Class[] {}).invoke(goodsEntity, new Object[] {}) != null
						&& !"".equals(goodsEntity.getClass().getMethod(fu, new Class[] {}).invoke(goodsEntity,
								new Object[] {}))) {
					if (index <= fs) {
						gf = entity.getFiles().get(ufs);
						gf.setPath(goodsEntity.getClass().getMethod(fu, new Class[] {})
								.invoke(goodsEntity, new Object[] {}).toString());
					} else {
						gf = new GoodsFile();
						gf.setGoodsId(goodsEntity.getGoodsId());
						gf.setPath(goodsEntity.getClass().getMethod(fu, new Class[] {})
								.invoke(goodsEntity, new Object[] {}).toString());
						gf.setStoreType(0);
						gf.setType(0);
						gf.setOpt(staffEntity.getOpt());
					}
					fileList.add(gf);
					ufs++;
				}
			}
			entity.setFiles(fileList);
			entity.setGoodsName(goodsEntity.getGoodsName());
			// 判断是否需要更新商品标签
			// if (!"".equals(goodsEntity.getTagId())) {
			// GoodsTagBindEntity newTag = new GoodsTagBindEntity();
			// newTag.setItemId(goodsEntity.getGoodsItem().getItemId());
			// newTag.setTagId(Integer.parseInt(goodsEntity.getTagId()));
			// entity.setGoodsTagBind(newTag);
			// } else {
			// if (goodsEntity.getGoodsTagBind() != null) {
			// GoodsTagBindEntity newTag = goodsEntity.getGoodsTagBind();
			// newTag.setTagId(Integer.parseInt(goodsEntity.getTagId()));
			// entity.setGoodsTagBind(newTag);
			// }
			// }
			goodsService.updEntity(entity, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	public void remove(HttpServletRequest req, HttpServletResponse resp, @RequestBody GoodsEntity goodsEntity) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		goodsEntity.setOpt(staffEntity.getOptid());
		try {
			goodsService.delEntity(goodsEntity, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void save(HttpServletRequest req, HttpServletResponse resp, @RequestBody GoodsPojo pojo) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		pojo.setOpt(staffEntity.getOptid());
		try {

			if (pojo.getBaseId() == 0) {
				sendFailureMessage(resp, "没有基础商品信息！");
				return;
			}

			if (StringUtil.isEmpty(pojo.getType())) {
				sendFailureMessage(resp, "没有新增类型，请联系管理处理！");
				return;
			}

			goodsService.addEntity(pojo, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/createGoodsInfo", method = RequestMethod.POST)
	public void createGoodsInfo(HttpServletRequest req, HttpServletResponse resp,
			@RequestBody CreateGoodsInfoEntity entity) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		entity.setOpt(staffEntity.getOptid());
		try {
			goodsService.addGoodsInfoEntity(entity, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
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
				sendSuccessMessage(resp, result.get("msg") == null || "".equals(result.get("msg")) ? null
						: result.get("msg").toString() + "已经存在");
			} else {
				sendFailureMessage(resp, result.get("msg") + "");
			}
		} catch (Exception e) {
			e.printStackTrace();
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

	@RequestMapping(value = "/toEditGoodsInfo")
	public ModelAndView toEditGoodsInfo(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String itemId = req.getParameter("itemId");
			GoodsInfoEntity goodsInfo = goodsService.queryGoodsInfoEntityByItemId(itemId, staffEntity);
			context.put("goodsInfo", goodsInfo);

			String info = goodsInfo.getGoods().getGoodsItem().getInfo();
			if (info != null && !"".equals(info)) {
				JSONArray jsonArray = JSONArray.fromObject(info.substring(1, info.length()));
				int index = jsonArray.size();
				List<ItemSpecsPojo> list = new ArrayList<ItemSpecsPojo>();
				for (int i = 0; i < index; i++) {
					JSONObject jObj = jsonArray.getJSONObject(i);
					list.add(JSONUtilNew.parse(jObj.toString(), ItemSpecsPojo.class));
				}

				// SpecsTemplateEntity entity =
				// specsService.queryById(goodsInfo.getGoods().getTemplateId() +
				// "",
				// staffEntity.getToken());
				// if (entity != null) {
				// for (ItemSpecsPojo isp : list) {
				// for (SpecsEntity se : entity.getSpecs()) {
				// for (SpecsValueEntity sve : se.getValues()) {
				// if (isp.getSvId().equals(sve.getSpecsId() + "")
				// && isp.getSvV().equals(sve.getId() + "")) {
				// isp.setSvT(sve.getValue());
				// }
				// }
				// }
				// }
				// }
				context.put("specsInfo", list);
			}

			List<FirstCatalogEntity> catalogs = catalogService.queryAll(staffEntity.getToken());
			for (FirstCatalogEntity first : catalogs) {
				if (first.getFirstId().equals(goodsInfo.getGoodsBase().getFirstCatalogId())) {
					context.put("firstName", first.getName());
					for (SecondCatalogEntity second : first.getSeconds()) {
						if (second.getSecondId().equals(goodsInfo.getGoodsBase().getSecondCatalogId())) {
							context.put("secondName", second.getName());
							for (ThirdCatalogEntity third : second.getThirds()) {
								if (third.getThirdId().equals(goodsInfo.getGoodsBase().getThirdCatalogId())) {
									context.put("thirdName", third.getName());
									break;
								}
							}
							break;
						}
					}
					break;
				}
			}

			// 初始化商详信息
			String detailInfo = "";
			// 包含商详地址
			if (goodsInfo.getGoods().getDetailPath() != null
					&& goodsInfo.getGoods().getDetailPath().indexOf("html") > 0) {
				detailInfo = goodsService.getHtmlContext(goodsInfo.getGoods().getDetailPath(), staffEntity);
			}
			context.put("detailInfo", detailInfo);

			context.put("suppliers", CachePoolComponent.getSupplier(staffEntity.getToken()));
			context.put("brands", CachePoolComponent.getBrands(staffEntity.getToken()));
			List<GoodsTagEntity> tags = goodsService.queryGoodsTags(staffEntity.getToken());
			context.put("tags", tags);

			return forword("goods/goods/edit", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
	}

	@RequestMapping(value = "/editGoodsInfo", method = RequestMethod.POST)
	public void editGoodsInfo(HttpServletRequest req, HttpServletResponse resp,
			@RequestBody CreateGoodsInfoEntity entity) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		entity.setOpt(staffEntity.getOptid());
		try {
			goodsService.updGoodsInfoEntity(entity, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/toTag")
	public ModelAndView toTag(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {
			return forword("goods/goods/addTag", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
	}

	@RequestMapping(value = "/refreshTag", method = RequestMethod.POST)
	public void refreshTag(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			List<GoodsTagEntity> tags = goodsService.queryGoodsTags(staffEntity.getToken());
			sendSuccessObject(resp, tags);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
	}

	@RequestMapping(value = "/saveTag", method = RequestMethod.POST)
	public void saveTag(HttpServletRequest req, HttpServletResponse resp, @RequestBody GoodsTagEntity goodsTag) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			goodsTag.setPriority(1);
			goodsService.addGoodsTag(goodsTag, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		sendSuccessMessage(resp, null);
	}

	private final int MAX_SIZE = 1024 * 50 * 1024; // 50MB
	SimpleDateFormat sdf = new SimpleDateFormat("YYYYMMDDhhmmss");

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

				String[] itemCodeList = directory.list();
				if (itemCodeList == null || itemCodeList.length == 0) {
					sendFailureMessage(resp, "没有商品信息！：");
					return;
				}

				GoodsFielsMaintainBO bo;
				List<GoodsFielsMaintainBO> list = new ArrayList<GoodsFielsMaintainBO>();
				for (String itemCodeFile : itemCodeList) {
					bo = dealGoodsPic(itemCodeFile, compressedFilePath + sourceNameWithoutSuffix, staffEntity);
					if (bo == null) {
						continue;
					}
					bo.setItemCode(itemCodeFile);
					list.add(bo);
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

	private String getNewFileName(String itemCode, String fileName, StaffEntity staffEntity) {
		// 文件后缀
		String suffix = fileName.indexOf(".") != -1 ? fileName.substring(fileName.lastIndexOf("."), fileName.length())
				: null;

		// 源文件名称
		String sourceNameWithoutSuffix = (fileName.indexOf(".") != -1 ? fileName.substring(0, fileName.lastIndexOf("."))
				: null) + "-" + sdf.format(new Date()) + "-" + staffEntity.getBadge();
		// 源文件名称
		return itemCode + "_" + sourceNameWithoutSuffix + suffix;
	}

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
				bo.setGoodsDetailPath(dealDetailPic(itemCode,
						path + "/" + itemCode + "/" + "detail", detailList, staffEntity));
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
	private Set<String> dealCoverPic(String itemCode, String path, List<String> coverList, StaffEntity staffEntity)
			throws Exception {
		String remotePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.IMAGE + "/";

		Set<String> coverInviteList = new HashSet<String>();
		File file;
		String newFileName;
		for (String fileName : coverList) {
			file = new File(path + "/" + fileName);
			newFileName = getNewFileName(itemCode, fileName, staffEntity);
			sftpService.uploadFile(remotePath, newFileName, new FileInputStream(file), "batchUpload");
			coverInviteList.add(URLUtils.get("static") + "/" + ResourceContants.IMAGE + "/" + "batchUpload"
					+ "/" + newFileName);
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
		String remotePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.IMAGE + "/";
		File file;
		String newFileName;
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

		for (String fileName : detailList) {
			file = new File(path + "/" + fileName);
			newFileName = getNewFileName(itemCode, fileName, staffEntity);
			sftpService.uploadFile(remotePath, newFileName, new FileInputStream(file), "batchUpload");
			sb.append("<p style=\"text-align: center;\"><img src=\"");
			sb.append(
					URLUtils.get("static") + "/" + ResourceContants.IMAGE + "/" + "batchUpload" + "/" + newFileName);
			sb.append("\"></p>");
		}

		return goodsService.saveModelHtml(itemCode, sb.toString(), staffEntity);
	}
}
