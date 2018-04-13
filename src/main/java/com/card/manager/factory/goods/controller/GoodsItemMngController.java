package com.card.manager.factory.goods.controller;

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
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.goods.GoodsUtil;
import com.card.manager.factory.goods.model.BrandEntity;
import com.card.manager.factory.goods.model.FirstCatalogEntity;
import com.card.manager.factory.goods.model.GoodsBaseEntity;
import com.card.manager.factory.goods.model.GoodsItemEntity;
import com.card.manager.factory.goods.model.GoodsTagBindEntity;
import com.card.manager.factory.goods.model.GoodsTagEntity;
import com.card.manager.factory.goods.model.SecondCatalogEntity;
import com.card.manager.factory.goods.model.ThirdCatalogEntity;
import com.card.manager.factory.goods.pojo.GoodsPojo;
import com.card.manager.factory.goods.service.CatalogService;
import com.card.manager.factory.goods.service.GoodsItemService;
import com.card.manager.factory.goods.service.GoodsService;
import com.card.manager.factory.goods.service.SpecsService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

@Controller
@RequestMapping("/admin/goods/itemMng")
public class GoodsItemMngController extends BaseController {

	@Resource
	GoodsItemService goodsItemService;

	@Resource
	SpecsService specsService;
	
	@Resource
	GoodsService goodsService;
	
	@Resource
	CatalogService catalogService;

//	@RequestMapping(value = "/mng")
//	public ModelAndView toFuncList(HttpServletRequest req, HttpServletResponse resp) {
//		Map<String, Object> context = getRootMap();
//		StaffEntity opt = SessionUtils.getOperator(req);
//		context.put("opt", opt);
//		return forword("goods/item/mng", context);
//	}

	@RequestMapping(value = "/mng")
//	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		context.put("suppliers", CachePoolComponent.getSupplier(opt.getToken()));
		List<GoodsTagEntity> tags = goodsService.queryGoodsTags(opt.getToken());
		context.put("tags", tags);
		List<FirstCatalogEntity> firsts = catalogService.queryAll(opt.getToken());
		context.put("firsts", firsts);
		List<BrandEntity> brands = CachePoolComponent.getBrands(opt.getToken());
		context.put("brands", brands);
		return forword("goods/item/list_1", context);
	}

	@RequestMapping(value = "/dataListForGoods", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataListForGoods(HttpServletRequest req, HttpServletResponse resp, GoodsItemEntity entity) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			String goodsId = req.getParameter("goodsId");
			if (StringUtil.isEmpty(goodsId)) {
				pcb = new PageCallBack();
				pcb.setErrTrace("没有商品编码信息！");
				pcb.setSuccess(false);
				return pcb;
			}

			params.put("centerId", staffEntity.getGradeId());
			params.put("shopId", staffEntity.getShopId());
			params.put("gradeLevel", staffEntity.getGradeLevel());

			entity.setGoodsId(goodsId);
			pcb = goodsItemService.dataList(entity, params, staffEntity.getToken(),
					ServerCenterContants.GOODS_CENTER_ITEM_QUERY_FOR_PAGE, GoodsItemEntity.class);

			List<GoodsItemEntity> list = (List<GoodsItemEntity>) pcb.getObj();
			for (GoodsItemEntity goodsItem : list) {
				GoodsUtil.changeSpecsInfo(goodsItem);
			}

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

//	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
//	@ResponseBody
//	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, GoodsItemEntity item) {
//		PageCallBack pcb = null;
//		StaffEntity staffEntity = SessionUtils.getOperator(req);
//		Map<String, Object> params = new HashMap<String, Object>();
//		try {
//			String status = req.getParameter("status");
//			if (!StringUtil.isEmpty(status)) {
//				item.setStatus(status);
//			}
//			String itemCode = req.getParameter("itemCode");
//			if (!StringUtil.isEmpty(itemCode)) {
//				item.setItemCode(itemCode);
//			}
//			String supplierId = req.getParameter("supplierId");
//			if (!StringUtil.isEmpty(supplierId)) {
//				item.setSupplierId(supplierId);
//			}
//			String goodsName = req.getParameter("goodsName");
//			if (!StringUtil.isEmpty(goodsName)) {
//				item.setGoodsName(goodsName);
//			}
//			String sku = req.getParameter("sku");
//			if (!StringUtil.isEmpty(sku)) {
//				item.setSku(sku);
//			}
//			String goodsId = req.getParameter("goodsId");
//			if (!StringUtil.isEmpty(goodsId)) {
//				item.setGoodsId(goodsId);
//			}
//			String itemId = req.getParameter("itemId");
//			if (!StringUtil.isEmpty(itemId)) {
//				item.setItemId(itemId);
//			}
//			String tagId = req.getParameter("tagId");
//			if (!StringUtil.isEmpty(tagId)) {
//				GoodsTagBindEntity tagBindEntity = new GoodsTagBindEntity();
//				tagBindEntity.setTagId(Integer.parseInt(tagId));
//				item.setTagBindEntity(tagBindEntity);
//			}
//
//			params.put("centerId", staffEntity.getGradeId());
//			params.put("shopId", staffEntity.getShopId());
//			params.put("gradeLevel", staffEntity.getGradeLevel());
//
//			pcb = goodsItemService.dataList(item, params, staffEntity.getToken(),
//					ServerCenterContants.GOODS_CENTER_ITEM_QUERY_FOR_PAGE, GoodsItemEntity.class);
//
//			List<GoodsItemEntity> list = (List<GoodsItemEntity>) pcb.getObj();
//			for (GoodsItemEntity entity : list) {
//				GoodsUtil.changeSpecsInfo(entity);
//			}
//
//		} catch (ServerCenterNullDataException e) {
//			if (pcb == null) {
//				pcb = new PageCallBack();
//			}
//			pcb.setPagination(item);
//			pcb.setSuccess(true);
//			return pcb;
//		} catch (Exception e) {
//			if (pcb == null) {
//				pcb = new PageCallBack();
//			}
//			pcb.setErrTrace(e.getMessage());
//			pcb.setSuccess(false);
//			return pcb;
//		}
//
//		return pcb;
//	}

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
			String supplierId = req.getParameter("supplierId");
			if (!StringUtil.isEmpty(supplierId)) {
				item.setSupplierId(supplierId);
			}
			String tagId = req.getParameter("tagId");
			if (!StringUtil.isEmpty(tagId)) {
				GoodsTagBindEntity tagBindEntity = new GoodsTagBindEntity();
				tagBindEntity.setTagId(Integer.parseInt(tagId));
				item.setTagBindEntity(tagBindEntity);
			}
			
//			String status = req.getParameter("status");
//			if (!StringUtil.isEmpty(status)) {
//				item.setStatus(status);
//			}
			String tabId = req.getParameter("hidTabId");
			if ("first".equals(tabId)) {
				item.setStatus("3");
			} else if ("second".equals(tabId)) {
				item.setStatus("4");
			} else if ("third".equals(tabId)) {
				item.setStatus("5");
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

			params.put("centerId", staffEntity.getGradeId());
			params.put("shopId", staffEntity.getShopId());
			params.put("gradeLevel", staffEntity.getGradeLevel());

			pcb = goodsItemService.dataList(item, params, staffEntity.getToken(),
					ServerCenterContants.GOODS_CENTER_ITEM_QUERY_FOR_PAGE, GoodsItemEntity.class);

			List<GoodsItemEntity> list = (List<GoodsItemEntity>) pcb.getObj();
			for (GoodsItemEntity entity : list) {
				GoodsUtil.changeSpecsInfo(entity);
			}
			
			if (pcb != null) {
				List<FirstCatalogEntity> first = CachePoolComponent.getFirstCatalog(staffEntity.getToken());
				List<SecondCatalogEntity> second = CachePoolComponent.getSecondCatalog(staffEntity.getToken());
				List<ThirdCatalogEntity> third = CachePoolComponent.getThirdCatalog(staffEntity.getToken());
				GoodsBaseEntity goodsInfo = null;
				for(GoodsItemEntity info : list){
					goodsInfo = info.getBaseEntity();
					for(FirstCatalogEntity fce : first) {
						if (goodsInfo.getFirstCatalogId().equals(fce.getFirstId())) {
							goodsInfo.setFirstCatalogId(fce.getName());
							break;
						}
					}
					for(SecondCatalogEntity sce : second) {
						if (goodsInfo.getSecondCatalogId().equals(sce.getSecondId())) {
							goodsInfo.setSecondCatalogId(sce.getName());
							break;
						}
					}
					for(ThirdCatalogEntity tce : third) {
						if (goodsInfo.getThirdCatalogId().equals(tce.getThirdId())) {
							goodsInfo.setThirdCatalogId(tce.getName());
							break;
						}
					}
				}
				pcb.setObj(list);
			}

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

	@RequestMapping(value = "/dataListByLabel", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataListByLabel(HttpServletRequest req, HttpServletResponse resp, @RequestBody GoodsItemEntity item) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			item.setCurrentPage(1);
			item.setNumPerPage(10);
			
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
			String tabId = item.getTabId();
			if (!StringUtil.isEmpty(tabId)) {
				if ("first".equals(tabId)) {
					item.setStatus("3");
				} else if ("second".equals(tabId)) {
					item.setStatus("4");
				} else if ("third".equals(tabId)) {
					item.setStatus("5");
				}
			}
			params.put("centerId", staffEntity.getGradeId());
			params.put("shopId", staffEntity.getShopId());
			params.put("gradeLevel", staffEntity.getGradeLevel());

			pcb = goodsItemService.dataList(item, params, staffEntity.getToken(),
					ServerCenterContants.GOODS_CENTER_ITEM_QUERY_FOR_PAGE, GoodsItemEntity.class);

			List<GoodsItemEntity> list = (List<GoodsItemEntity>) pcb.getObj();
			for (GoodsItemEntity entity : list) {
				GoodsUtil.changeSpecsInfo(entity);
			}
			
			if (pcb != null) {
				List<FirstCatalogEntity> first = CachePoolComponent.getFirstCatalog(staffEntity.getToken());
				List<SecondCatalogEntity> second = CachePoolComponent.getSecondCatalog(staffEntity.getToken());
				List<ThirdCatalogEntity> third = CachePoolComponent.getThirdCatalog(staffEntity.getToken());
				GoodsBaseEntity goodsInfo = null;
				for(GoodsItemEntity info : list){
					goodsInfo = info.getBaseEntity();
					if (goodsInfo == null) {
						continue;
					}
					for(FirstCatalogEntity fce : first) {
						if (goodsInfo.getFirstCatalogId().equals(fce.getFirstId())) {
							goodsInfo.setFirstCatalogId(fce.getName());
							break;
						}
					}
					for(SecondCatalogEntity sce : second) {
						if (goodsInfo.getSecondCatalogId().equals(sce.getSecondId())) {
							goodsInfo.setSecondCatalogId(sce.getName());
							break;
						}
					}
					for(ThirdCatalogEntity tce : third) {
						if (goodsInfo.getThirdCatalogId().equals(tce.getThirdId())) {
							goodsInfo.setThirdCatalogId(tce.getName());
							break;
						}
					}
				}
				pcb.setObj(list);
			}

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

	@RequestMapping(value = "/toShow")
	public ModelAndView toShow(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);

		String id = req.getParameter("id");
		if (StringUtil.isEmpty(id)) {
			context.put(ERROR, "没有明细编号");
			return forword("error", context);
		}
		try {
			context.put("item", goodsItemService.queryById(id,opt.getToken()));
			List<GoodsTagEntity> tags = goodsService.queryGoodsTags(opt.getToken());
			context.put("tags", tags);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword("error", context);
		}

		return forword("goods/item/show", context);
	}

	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		String goodsId = req.getParameter("goodsId");
		String templateId = req.getParameter("templateId");

		try {
			context.put("goodsId", goodsId);
			context.put("template", specsService.queryById(templateId, opt.getToken()));
			List<GoodsTagEntity> tags = goodsService.queryGoodsTags(opt.getToken());
			context.put("tags", tags);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword("error", context);
		}

		return forword("goods/item/add", context);
	}

	@RequestMapping(value = "/beUse", method = RequestMethod.POST)
	public void beUse(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String itemId = req.getParameter("itemId");
			if (StringUtil.isEmpty(itemId)) {
				sendFailureMessage(resp, "操作失败：没有明细编号");
				return;
			}
			goodsItemService.beUse(itemId, staffEntity.getToken(), staffEntity.getOptid());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/beFx", method = RequestMethod.POST)
	public void beFx(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String itemId = req.getParameter("itemId");
			if (StringUtil.isEmpty(itemId)) {
				sendFailureMessage(resp, "操作失败：没有明细编号");
				return;
			}
			goodsItemService.beFx(itemId, staffEntity.getToken(), staffEntity.getOptid());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/syncStock", method = RequestMethod.POST)
	public void syncStock(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String itemId = req.getParameter("itemId");
			if (StringUtil.isEmpty(itemId)) {
				sendFailureMessage(resp, "操作失败：没有明细编号");
				return;
			}
			goodsItemService.syncStock(itemId, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/fx", method = RequestMethod.POST)
	public void fx(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String itemId = req.getParameter("itemId");
			if (StringUtil.isEmpty(itemId)) {
				sendFailureMessage(resp, "操作失败：没有明细编号");
				return;
			}
			goodsItemService.fx(itemId, staffEntity.getToken(), staffEntity.getOptid(), staffEntity.getGradeId());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/noBeFx", method = RequestMethod.POST)
	public void noBeFx(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String itemId = req.getParameter("itemId");
			if (StringUtil.isEmpty(itemId)) {
				sendFailureMessage(resp, "操作失败：没有明细编号");
				return;
			}
			goodsItemService.noBeFx(itemId, staffEntity.getToken(), staffEntity.getOptid());
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
			goodsItemService.addEntity(pojo, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public void update(HttpServletRequest req, HttpServletResponse resp, @RequestBody GoodsPojo pojo) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		pojo.setOpt(staffEntity.getOptid());
		try {
			goodsItemService.updateEntity(pojo, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		
		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		String id = req.getParameter("id");

		try {
			// GoodsEntity goodsItem = goodsService.queryById(id,
			// opt.getToken());
			// context.put("goodsItem", goodsItem);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword("error", context);
		}

		return forword("goods/item/edit", context);
	}
}
