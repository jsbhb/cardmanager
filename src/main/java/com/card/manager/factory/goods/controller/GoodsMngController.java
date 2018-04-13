package com.card.manager.factory.goods.controller;

import java.util.ArrayList;
import java.util.HashMap;
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
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.goods.model.FirstCatalogEntity;
import com.card.manager.factory.goods.model.GoodsEntity;
import com.card.manager.factory.goods.model.GoodsFile;
import com.card.manager.factory.goods.model.GoodsTagEntity;
import com.card.manager.factory.goods.model.SecondCatalogEntity;
import com.card.manager.factory.goods.model.ThirdCatalogEntity;
import com.card.manager.factory.goods.model.ThirdWarehouseGoods;
import com.card.manager.factory.goods.pojo.CreateGoodsInfoEntity;
import com.card.manager.factory.goods.pojo.GoodsInfoEntity;
import com.card.manager.factory.goods.pojo.GoodsPojo;
import com.card.manager.factory.goods.service.CatalogService;
import com.card.manager.factory.goods.service.GoodsService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

@Controller
@RequestMapping("/admin/goods/goodsMng")
public class GoodsMngController extends BaseController {

	private final String SYNC = "sync";
	private final String NORMAL = "normal";

	@Resource
	GoodsService goodsService;
	
	@Resource
	CatalogService catalogService;

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
//			String type = req.getParameter("type");
//			if (SYNC.equals(type)) {
//				String id = req.getParameter("id");
//				if (StringUtil.isEmpty(id)) {
//					context.put(ERROR, "没有同步商品编码！");
//					return forword(ERROR, context);
//				}
//				ThirdWarehouseGoods thirdGoods = goodsService.queryThirdById(id, opt.getToken());
//				context.put("third", thirdGoods);
//
//			} else if (NORMAL.equals(type)) {
//				 List<BrandEntity> brands =
//				 CachePoolComponent.getBrands(opt.getToken());
//				 if(brands.size() == 0){
//				 context.put(ERROR,"没有品牌信息,无法查看基础商品！");
//				 context.put(ERROR_CODE,"405！");
//				 return forword("error", context);
//				 }
//				
//				 context.put("brands", brands);
//				
//				 List<FirstCatalogEntity> catalogs =
//				 catalogService.queryFirstCatalogs(opt.getToken());
//				 context.put("firsts", catalogs);
//				
//				List<GoodsTagEntity> tags = goodsService.queryGoodsTags(opt.getToken());
//				context.put("tags", tags);
//			} else {
//				context.put(ERROR, "没有新增类型，请联系管理员！");
//				return forword(ERROR, context);
//			}
			List<GoodsTagEntity> tags = goodsService.queryGoodsTags(opt.getToken());
			context.put("tags", tags);

			return forword("goods/goods/add", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
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
			GoodsEntity entity = goodsService.queryById(goodsEntity.getId()+"", staffEntity.getToken());
			List<GoodsFile> fileList = new ArrayList<GoodsFile>();
			int fs = entity.getFiles().size();
			GoodsFile gf = new GoodsFile();
			//要保存的主图数
			int ufs = 0;
			for(int index = 1; index < 5; index++) {
				String fu = "getPicPath" + index;
				if (goodsEntity.getClass().getMethod(fu, new Class[]{}).invoke(goodsEntity, new Object[]{}) != null 
						&& !"".equals(goodsEntity.getClass().getMethod(fu, new Class[]{}).invoke(goodsEntity, new Object[]{}))) {
					if (index <= fs) {
						gf = entity.getFiles().get(ufs);
						gf.setPath(goodsEntity.getClass().getMethod(fu, new Class[]{}).invoke(goodsEntity, new Object[]{}).toString());
					} else {
						gf = new GoodsFile();
						gf.setGoodsId(goodsEntity.getGoodsId());
						gf.setPath(goodsEntity.getClass().getMethod(fu, new Class[]{}).invoke(goodsEntity, new Object[]{}).toString());
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
			//判断是否需要更新商品标签
//			if (!"".equals(goodsEntity.getTagId())) {
//				GoodsTagBindEntity newTag = new GoodsTagBindEntity();
//				newTag.setItemId(goodsEntity.getGoodsItem().getItemId());
//				newTag.setTagId(Integer.parseInt(goodsEntity.getTagId()));
//				entity.setGoodsTagBind(newTag);
//			} else {
//				if (goodsEntity.getGoodsTagBind() != null) {
//					GoodsTagBindEntity newTag = goodsEntity.getGoodsTagBind();
//					newTag.setTagId(Integer.parseInt(goodsEntity.getTagId()));
//					entity.setGoodsTagBind(newTag);
//				}
//			}
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
	public void createGoodsInfo(HttpServletRequest req, HttpServletResponse resp, @RequestBody CreateGoodsInfoEntity entity) {
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

	@RequestMapping(value = "/toEditGoodsInfo")
	public ModelAndView toEditGoodsInfo(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String itemId = req.getParameter("itemId");
			GoodsInfoEntity goodsInfo = goodsService.queryGoodsInfoEntityByItemId(itemId, staffEntity);
			context.put("goodsInfo", goodsInfo);
			List<FirstCatalogEntity> catalogs = catalogService.queryAll(staffEntity.getToken());
			for(FirstCatalogEntity first : catalogs) {
				if (first.getFirstId().equals(goodsInfo.getGoodsBase().getFirstCatalogId())) {
					context.put("firstName", first.getName());
					for(SecondCatalogEntity second : first.getSeconds()) {
						if (second.getSecondId().equals(goodsInfo.getGoodsBase().getSecondCatalogId())) {
							context.put("secondName", second.getName());
							for(ThirdCatalogEntity third : second.getThirds()) {
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
			
			//初始化商详信息
			String detailInfo = "";
			detailInfo = goodsService.getHtmlContext(goodsInfo.getGoods().getDetailPath(), staffEntity);
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
	public void editGoodsInfo(HttpServletRequest req, HttpServletResponse resp, @RequestBody CreateGoodsInfoEntity entity) {
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

	@RequestMapping(value = "/toAddTag")
	public ModelAndView toAddTag(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {
			return forword("goods/goods/addTag2", context);
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
}
