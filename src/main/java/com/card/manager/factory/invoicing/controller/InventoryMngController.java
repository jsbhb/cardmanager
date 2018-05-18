package com.card.manager.factory.invoicing.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.base.PageCallBack;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.component.model.GradeBO;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.goods.model.BrandEntity;
import com.card.manager.factory.goods.model.FirstCatalogEntity;
import com.card.manager.factory.goods.model.GoodsBaseEntity;
import com.card.manager.factory.goods.model.GoodsItemEntity;
import com.card.manager.factory.goods.model.GoodsStockEntity;
import com.card.manager.factory.goods.model.GoodsTagBindEntity;
import com.card.manager.factory.goods.model.GoodsTagEntity;
import com.card.manager.factory.goods.pojo.GoodsInfoListForDownload;
import com.card.manager.factory.goods.pojo.GoodsListDownloadParam;
import com.card.manager.factory.goods.service.CatalogService;
import com.card.manager.factory.goods.service.GoodsItemService;
import com.card.manager.factory.goods.service.GoodsService;
import com.card.manager.factory.invoicing.service.InventoryService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.DateUtil;
import com.card.manager.factory.util.ExcelUtil;
import com.card.manager.factory.util.FileDownloadUtil;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

@Controller
@RequestMapping("/admin/invoicing/inventoryMng")
public class InventoryMngController extends BaseController {

	@Resource
	GoodsItemService goodsItemService;
	
	@Resource
	GoodsService goodsService;

	@Resource
	CatalogService catalogService;
	
	@Resource
	InventoryService inventoryService;
	
	@RequestMapping(value = "/mng")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		List<GoodsTagEntity> tags = goodsService.queryGoodsTags(opt.getToken());
		context.put("tags", tags);
		List<FirstCatalogEntity> firsts = catalogService.queryAll(opt.getToken());
		context.put("firsts", firsts);
		List<BrandEntity> brands = CachePoolComponent.getBrands(opt.getToken());
		context.put("brands", brands);
		GradeBO grade = CachePoolComponent.getGrade(opt.getToken()).get(opt.getGradeId());
		if (grade != null) {
			context.put("gradeType", grade.getGradeType());
		}
		// set page privilege
		if (opt.getRoleId() == 1) {
			context.put("prilvl", "1");
		} else {
			context.put("prilvl", req.getParameter("privilege"));
		}
		return forword("invoicing/inventory/list", context);
	}
	
	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, GoodsItemEntity item) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {

			String brandId = req.getParameter("brandId");
			String type = req.getParameter("type");
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
					ServerCenterContants.GOODS_CENTER_ITEM_QUERY_FOR_PAGE + "&type=" + type, GoodsItemEntity.class);

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

	@RequestMapping(value = "/maintain", method = RequestMethod.POST)
	public void maintain(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String itemId = req.getParameter("itemId");
			if (StringUtil.isEmpty(itemId)) {
				sendFailureMessage(resp, "操作失败：没有商品编号");
				return;
			}
			String qty = req.getParameter("qty");
			List<GoodsStockEntity> stocks = new ArrayList<GoodsStockEntity>();
			GoodsStockEntity goodsStockEntity = new GoodsStockEntity();
			goodsStockEntity.setItemId(Integer.parseInt(itemId));
			goodsStockEntity.setFxQty(Integer.parseInt(qty));
			stocks.add(goodsStockEntity);
			inventoryService.maintainStock(stocks, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/downLoadExcel")
	public void downLoadFile(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String supplierId = req.getParameter("supplierId").trim();
			String itemIds = req.getParameter("itemIds").trim();
			List<String> itemIdList = new ArrayList<String>();
			if (!"".equals(itemIds)) {
				for (String itemId : itemIds.split(",")) {
					itemIdList.add(itemId);
				}
			}
			GoodsListDownloadParam param = new GoodsListDownloadParam();
			if (!"".equals(supplierId)) {
				param.setSupplierId(Integer.parseInt(supplierId));
			}
			//指定分级类型 得到唯一记录
			param.setGradeType(1);
			if (itemIdList.size() > 0) {
				param.setItemIdList(itemIdList);
			}
			List<GoodsInfoListForDownload> ReportList = new ArrayList<GoodsInfoListForDownload>();
			ReportList = goodsItemService.queryGoodsInfoListForDownload(param, staffEntity.getToken());
			GoodsInfoListForDownload info = new GoodsInfoListForDownload();
			if (ReportList.size() > 0) {
				info = ReportList.get(0);
				info.setRemark("只需要修改商品的虚拟库存");
			}

			WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
			ServletContext servletContext = webApplicationContext.getServletContext();

			String fileName = "inventory_" + DateUtil.getNowLongTime() + ".xlsx";
			String filePath = servletContext.getRealPath("/") + "EXCEL/" + staffEntity.getBadge() + "/" + fileName;

			String[] nameArray = new String[] { "商品名称", "商品编号", "商家编码", "商品品牌", "供应商", "商品价格", "现有库存", "虚拟库存", "", "商品虚拟库存维护说明：" };
			String[] colArray = new String[] { "GoodsName", "ItemId", "Sku", "Brand", "SupplierName", "RetailPrice", "FxQty", "GradeType", "Attr", "Remark" };

			SXSSFWorkbook swb = new SXSSFWorkbook(100);
			ExcelUtil.createExcel(ReportList, nameArray, colArray, filePath, 0, "sheet1", swb);
			ExcelUtil.writeToExcel(swb, filePath);

			FileDownloadUtil.downloadFileByBrower(req, resp, filePath, fileName);
		} catch (Exception e) {
			resp.setContentType("text/html;charset=utf-8");
			resp.getWriter().println("下载失败，请重试!");
			resp.getWriter().println(e.toString());
			return;
		}
	}

	@RequestMapping(value = "/readExcelForMaintain", method = RequestMethod.POST)
	public void readExcelForMaintain(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String filePath = req.getParameter("filePath");
			if (StringUtil.isEmpty(filePath)) {
				sendFailureMessage(resp, "操作失败：文件路径不正确");
				return;
			}
			List<Object> list = ExcelUtil.getCache(filePath,"stock");
			if (list.size()<= 0) {
				sendFailureMessage(resp, "操作失败：无商品需维护虚拟库存");
				return;
			}
			List<GoodsStockEntity> stocks = new ArrayList<GoodsStockEntity>();
			GoodsStockEntity stock = null;
			for (Object info : list) {
				stock = (GoodsStockEntity) info;
				stocks.add(stock);
			}
			inventoryService.maintainStock(stocks, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}
}