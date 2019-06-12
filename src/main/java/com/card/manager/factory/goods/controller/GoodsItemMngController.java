package com.card.manager.factory.goods.controller;

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
import org.springframework.web.bind.annotation.RequestBody;
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
import com.card.manager.factory.goods.GoodsUtil;
import com.card.manager.factory.goods.grademodel.GradeTypeDTO;
import com.card.manager.factory.goods.model.BrandEntity;
import com.card.manager.factory.goods.model.FirstCatalogEntity;
import com.card.manager.factory.goods.model.GoodsBaseEntity;
import com.card.manager.factory.goods.model.GoodsEntity;
import com.card.manager.factory.goods.model.GoodsItemEntity;
import com.card.manager.factory.goods.model.GoodsPriceRatioEntity;
import com.card.manager.factory.goods.model.GoodsRebateEntity;
import com.card.manager.factory.goods.model.GoodsTagBindEntity;
import com.card.manager.factory.goods.model.GoodsTagEntity;
import com.card.manager.factory.goods.model.SecondCatalogEntity;
import com.card.manager.factory.goods.model.ThirdCatalogEntity;
import com.card.manager.factory.goods.pojo.GoodsInfoListForDownload;
import com.card.manager.factory.goods.pojo.GoodsListDownloadParam;
import com.card.manager.factory.goods.pojo.ItemSpecsPojo;
import com.card.manager.factory.goods.service.CatalogService;
import com.card.manager.factory.goods.service.GoodsItemService;
import com.card.manager.factory.goods.service.GoodsService;
import com.card.manager.factory.goods.service.SpecsService;
import com.card.manager.factory.system.model.RebateFormulaBO;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.CalculationUtils;
import com.card.manager.factory.util.DateUtil;
import com.card.manager.factory.util.ExcelUtil;
import com.card.manager.factory.util.FileDownloadUtil;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

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

	@RequestMapping(value = "/mng")
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
		GradeBO grade = CachePoolComponent.getGrade(opt.getToken()).get(opt.getGradeId());
		if (grade != null) {
			context.put("gradeType", grade.getGradeType());
			context.put("customType", grade.getType());
		}
		// set page privilege
		if (opt.getRoleId() == 1) {
			context.put("prilvl", "1");
		} else {
			context.put("prilvl", req.getParameter("privilege"));
		}
		return forword("goods/item/list", context);
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
			String gradeType = req.getParameter("gradeType");
			String tabId = req.getParameter("hidTabId");
			if ("first".equals(tabId)) {
				item.setStatus("1");
			} else if ("second".equals(tabId)) {
				item.setStatus("0");
			} else if ("third".equals(tabId)) {
				item.setStatus("2");
			} else if ("fourth".equals(tabId)) {
				item.setStatus("3");
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
			String goodsType = req.getParameter("goodsType");
			if (!StringUtil.isEmpty(goodsType)) {
				GoodsEntity goodsEntity = new GoodsEntity();
				goodsEntity.setType(Integer.parseInt(goodsType));
				item.setGoodsEntity(goodsEntity);
			}
			String encode = req.getParameter("encode");
			if (!StringUtil.isEmpty(encode)) {
				item.setEncode(encode);
			}
			String searchTime = req.getParameter("searchTime");
			if (!StringUtil.isEmpty(searchTime)) {
				String[] times = searchTime.split("~");
				item.setStartTime(times[0].trim());
				item.setEndTime(times[1].trim());
			}

			params.put("centerId", staffEntity.getGradeId());
			params.put("shopId", staffEntity.getShopId());
			params.put("gradeLevel", staffEntity.getGradeLevel());

			pcb = goodsItemService.dataList(item, params, staffEntity.getToken(),
					ServerCenterContants.GOODS_CENTER_ITEM_QUERY_FOR_PAGE + "&type=" + type, GoodsItemEntity.class);

			List<GoodsItemEntity> list = (List<GoodsItemEntity>) pcb.getObj();
			Map<String, String> rebateMap = null;
			for (GoodsItemEntity entity : list) {
				GoodsUtil.changeSpecsInfo(entity);
				if (gradeType != null && !"".equals(gradeType)) {
					rebateMap = goodsService.getGoodsRebate(entity.getItemId(), staffEntity.getToken());
					String rebateStr = rebateMap.get(gradeType);
					double rebate = Double.valueOf(rebateStr == null ? "0" : rebateStr);
					entity.setRebate(CalculationUtils.round(2,
							CalculationUtils.mul(entity.getGoodsPrice().getRetailPrice(), rebate)));
				}
			}

			if (pcb != null) {
				List<FirstCatalogEntity> first = CachePoolComponent.getFirstCatalog(staffEntity.getToken());
				List<SecondCatalogEntity> second = CachePoolComponent.getSecondCatalog(staffEntity.getToken());
				List<ThirdCatalogEntity> third = CachePoolComponent.getThirdCatalog(staffEntity.getToken());
				GoodsBaseEntity goodsInfo = null;
				String tmpWebUrlParam = "";
				for (GoodsItemEntity info : list) {
					goodsInfo = info.getBaseEntity();
					tmpWebUrlParam = "";
					for (FirstCatalogEntity fce : first) {
						if (goodsInfo.getFirstCatalogId().equals(fce.getFirstId())) {
							tmpWebUrlParam = tmpWebUrlParam + fce.getAccessPath();
							goodsInfo.setFirstCatalogId(fce.getName());
							break;
						}
					}
					for (SecondCatalogEntity sce : second) {
						if (goodsInfo.getSecondCatalogId().equals(sce.getSecondId())) {
							tmpWebUrlParam = tmpWebUrlParam + "/" + sce.getAccessPath();
							goodsInfo.setSecondCatalogId(sce.getName());
							break;
						}
					}
					for (ThirdCatalogEntity tce : third) {
						if (goodsInfo.getThirdCatalogId().equals(tce.getThirdId())) {
							tmpWebUrlParam = tmpWebUrlParam + "/" + tce.getAccessPath();
							goodsInfo.setThirdCatalogId(tce.getName());
							break;
						}
					}
					if (!"".equals(tmpWebUrlParam)) {
						tmpWebUrlParam = tmpWebUrlParam + "/" + info.getGoodsId() + ".html";
						info.setWebUrlParam(tmpWebUrlParam);
					}
					
					String infoStr = info.getInfo();
					if (infoStr != null && !"".equals(infoStr)) {
						JSONArray jsonArray = JSONArray.fromObject(infoStr.substring(1, infoStr.length()));
						int index = jsonArray.size();
						List<ItemSpecsPojo> specslist = new ArrayList<ItemSpecsPojo>();
						for (int i = 0; i < index; i++) {
							JSONObject jObj = jsonArray.getJSONObject(i);
							specslist.add(JSONUtilNew.parse(jObj.toString(), ItemSpecsPojo.class));
						}
						
						String tmpStr = "";
						for (ItemSpecsPojo isp : specslist) {
							tmpStr = tmpStr + isp.getSkV() + ":" + isp.getSvV() + "|";
						}
						info.setInfo(tmpStr.substring(0, tmpStr.length()-1));
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

	@RequestMapping(value = "/toSetRebate")
	public ModelAndView toSetRebate(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);

		String id = req.getParameter("id");
		String prilvl = req.getParameter("prilvl");
		context.put("prilvl", prilvl);
		if (StringUtil.isEmpty(id)) {
			context.put(ERROR, "没有商品编号");
			return forword("error", context);
		}
		try {
			context.put("itemId", id);
			List<GoodsRebateEntity> list = goodsService.queryGoodsRebateById(id, opt.getToken());
			if (list != null) {
				Map<Integer, Double> map = new HashMap<Integer, Double>();
				for (GoodsRebateEntity model : list) {
					map.put(model.getGradeType(), model.getProportion());
				}
				context.put("map", map);
			}
			List<GradeTypeDTO> gradeList = goodsService.queryGradeType(null, opt.getToken());
			context.put("gradeList", gradeList);
			
			//获取所有分级的返佣公式
			List<RebateFormulaBO> rebateFormulaList = new ArrayList<RebateFormulaBO>();
			Map<Integer, RebateFormulaBO> rebateFormulaMap = CachePoolComponent.getRebateFormula(opt.getToken());
			for (RebateFormulaBO rfbo:rebateFormulaMap.values()) {
				rebateFormulaList.add(rfbo);
			}
			context.put("rebateFormulaList", rebateFormulaList);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword("error", context);
		}

		return forword("goods/item/rebate", context);
	}

	@RequestMapping(value = "/rebate")
	public void rebate(HttpServletRequest req, HttpServletResponse resp, @RequestBody List<GoodsRebateEntity> list) {
		StaffEntity opt = SessionUtils.getOperator(req);
		try {
			goodsService.updGoodsRebateEntity(list, opt.getToken());
			sendSuccessMessage(resp, "保存成功");
		} catch (Exception e) {
			e.printStackTrace();
			sendFailureMessage(resp, e.getMessage());
		}
	}

	@RequestMapping(value = "/beFx", method = RequestMethod.POST)
	public void beFx(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String itemId = req.getParameter("itemId");
			if (StringUtil.isEmpty(itemId)) {
				sendFailureMessage(resp, "操作失败：没有商品编号");
				return;
			}
			goodsItemService.beFx(itemId, staffEntity.getToken(), staffEntity.getOptid());
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
				sendFailureMessage(resp, "操作失败：没有商品编号");
				return;
			}
			goodsItemService.noBeFx(itemId, staffEntity.getToken(), staffEntity.getOptid());
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
				sendFailureMessage(resp, "操作失败：没有商品编号");
				return;
			}
			goodsItemService.syncStock(itemId, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/toExport")
	public ModelAndView toExport(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		List<GoodsTagEntity> tags = goodsService.queryGoodsTags(opt.getToken());
		context.put("tags", tags);

		Integer gradeType = opt.getGradeType();
		List<GradeTypeDTO> gradeList = goodsService.queryGradeType(null, opt.getToken());
		List<GradeTypeDTO> rootList = new ArrayList<GradeTypeDTO>();
		if (gradeList != null && gradeList.size() > 0) {
			for(GradeTypeDTO gtFirst:gradeList) {
				if (gtFirst.getId() == gradeType) {
					rootList.addAll(gtFirst.getChildern());
					break;
				} else {
					if (gtFirst.getChildern() != null && gtFirst.getChildern().size() >0) {
						for(GradeTypeDTO gtSecond:gtFirst.getChildern()) {
							if (gtSecond.getId() == gradeType) {
								String tmpGradeName = gtSecond.getName();
								if (tmpGradeName.indexOf("（") != -1) {
									tmpGradeName = tmpGradeName.substring(0, tmpGradeName.indexOf("（"));
								}
								if (tmpGradeName.indexOf("(") != -1) {
									tmpGradeName = tmpGradeName.substring(0, tmpGradeName.indexOf("("));
								}
								gtSecond.setName(tmpGradeName);
								
								if (gtSecond.getChildern() != null && gtSecond.getChildern().size() > 0) {
									for(GradeTypeDTO gtThird:gtSecond.getChildern()) {
										tmpGradeName = gtThird.getName();
										if (tmpGradeName.indexOf("（") != -1) {
											tmpGradeName = tmpGradeName.substring(0, tmpGradeName.indexOf("（"));
										}
										if (tmpGradeName.indexOf("(") != -1) {
											tmpGradeName = tmpGradeName.substring(0, tmpGradeName.indexOf("("));
										}
										gtThird.setName(tmpGradeName);
									}
								}
								rootList.add(gtSecond);
								break;
							} else {
								if (gtSecond.getChildern() != null && gtSecond.getChildern().size() >0) {
									for(GradeTypeDTO gtThird:gtSecond.getChildern()) {
										if (gtThird.getId() == gradeType) {
											String tmpGradeName = gtThird.getName();
											if (tmpGradeName.indexOf("（") != -1) {
												tmpGradeName = tmpGradeName.substring(0, tmpGradeName.indexOf("（"));
											}
											if (tmpGradeName.indexOf("(") != -1) {
												tmpGradeName = tmpGradeName.substring(0, tmpGradeName.indexOf("("));
											}
											gtThird.setName(tmpGradeName);
											rootList.add(gtThird);
											break;
										}
									}
								}
							}
						}
					}
				}
			}
		}
		if (rootList != null && rootList.size() > 0) {
			context.put("gradeList", rootList);
		} else {
			context.put("gradeList", gradeList);
		}
		List<FirstCatalogEntity> catalogs = catalogService.queryFirstCatalogs(opt.getToken());
		context.put("firsts", catalogs);
		context.put("suppliers", CachePoolComponent.getSupplier(opt.getToken()));
		context.put("type", req.getParameter("type"));
		return forword("goods/item/modelExport", context);
	}

	@RequestMapping(value = "/downLoadExcel")
	public void downLoadFile(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String type = req.getParameter("type");
			String supplierId = req.getParameter("supplierId").trim();
			String itemIds = req.getParameter("itemIds");
			List<String> itemIdList = new ArrayList<String>();
			if (!"".equals(itemIds) && itemIds != null) {
				for (String itemId : itemIds.split(",")) {
					itemIdList.add(itemId);
				}
			}
			String selectedGradeType = req.getParameter("gradeType");
			String tagIds = req.getParameter("tagIds");
			List<String> tagIdList = new ArrayList<String>();
			if (!"".equals(tagIds) && tagIds != null) {
				for (String tagId : tagIds.split(",")) {
					tagIdList.add(tagId);
				}
			}
			String rebateStart = req.getParameter("rebateStart");
			String rebateEnd = req.getParameter("rebateEnd");
			String firstCatalogId = req.getParameter("firstCatalogId");
			String secondCatalogId = req.getParameter("secondCatalogId");
			String thirdCatalogId = req.getParameter("thirdCatalogId");
			String goodsType = req.getParameter("goodsType");
			String itemStatus = req.getParameter("itemStatus");
			GoodsListDownloadParam param = new GoodsListDownloadParam();
			if (!"".equals(supplierId)) {
				param.setSupplierId(Integer.parseInt(supplierId));
			}
			if (itemIdList.size() > 0) {
				param.setItemIdList(itemIdList);
			}
			//筛选是否有返佣的数据 -1：不筛选
			param.setProportionFlg(-1);
			if (!StringUtil.isEmpty(selectedGradeType)) {
				param.setGradeType(Integer.parseInt(selectedGradeType));
			}
			if (tagIdList.size() > 0) {
				param.setTagIdList(tagIdList);
			}
			if (!StringUtil.isEmpty(rebateStart)) {
				param.setRebateStart(Double.parseDouble(rebateStart));
			}
			if (!StringUtil.isEmpty(rebateEnd)) {
				param.setRebateEnd(Double.parseDouble(rebateEnd));
			}
			//目前只做了一条类目选择，后期会修改成同时选择多条类目
			if (!"".equals(firstCatalogId) && firstCatalogId != null && !"-1".equals(firstCatalogId)) {
				List<String> firstCatalogList = new ArrayList<String>();
//				for (String firstCatalog : firstCatalogId.split(",")) {
//					firstCatalogList.add(firstCatalog);
//				}
				firstCatalogList.add(firstCatalogId);
				param.setFirstCatalogList(firstCatalogList);
			}
			if (!"".equals(secondCatalogId) && secondCatalogId != null && !"-1".equals(secondCatalogId)) {
				List<String> secondCatalogList = new ArrayList<String>();
//				for (String secondCatalog : secondCatalogId.split(",")) {
//					secondCatalogList.add(secondCatalog);
//				}
				secondCatalogList.add(secondCatalogId);
				param.setSecondCatalogList(secondCatalogList);
			}
			if (!"".equals(thirdCatalogId) && thirdCatalogId != null && !"-1".equals(thirdCatalogId)) {
				List<String> thirdCatalogList = new ArrayList<String>();
//				for (String thirdCatalog : thirdCatalogId.split(",")) {
//					thirdCatalogList.add(thirdCatalog);
//				}
				thirdCatalogList.add(thirdCatalogId);
				param.setThirdCatalogList(thirdCatalogList);
			}
			if (!StringUtil.isEmpty(itemStatus)) {
				param.setItemStatus(Integer.parseInt(itemStatus));
			}
			if (!StringUtil.isEmpty(goodsType)) {
				param.setGoodsType(Integer.parseInt(goodsType));
			}
			//商品报价单默认查询上架商品
			if ("3".equals(type)) {
				param.setItemStatus(1);
				param.setProportionFlg(1);
			}
			
			List<GoodsInfoListForDownload> ReportList = new ArrayList<GoodsInfoListForDownload>();
			ReportList = goodsItemService.queryGoodsInfoListForDownload(param, staffEntity.getToken());
			List<FirstCatalogEntity> firsts = CachePoolComponent.getFirstCatalog(staffEntity.getToken());
			List<SecondCatalogEntity> seconds = CachePoolComponent.getSecondCatalog(staffEntity.getToken());
			List<ThirdCatalogEntity> thirds = CachePoolComponent.getThirdCatalog(staffEntity.getToken());
			Map<Integer, GradeTypeDTO> gradeTypes = CachePoolComponent.getGradeType(staffEntity.getToken());

			for (GoodsInfoListForDownload gi : ReportList) {
				switch (gi.getGoodsStatus()) {
				case 0:gi.setGoodsStatusName("初始状态");break;
				case 1:gi.setGoodsStatusName("可用");break;
				case 2:gi.setGoodsStatusName("可分销");break;
				}

				if (gi.getItemStatus() != null) {
					switch (gi.getItemStatus()) {
					case 1:gi.setItemStatusName("上架");break;
					default :gi.setItemStatusName("未上架");
					}
				} else {
					gi.setItemStatusName("未上架");
				}
				
				if (gi.getGoodsType() != null) {
					switch (gi.getGoodsType()) {
					case "0":gi.setGoodsTypeName("保税商品");break;
					case "2":gi.setGoodsTypeName("一般贸易商品");break;
					case "3":gi.setGoodsTypeName("直邮商品");break;
					default :gi.setGoodsTypeName("保税商品");
					}
				} else {
					gi.setGoodsTypeName("保税商品");
				}
				
				String infoStr = gi.getInfo();
				if (infoStr != null && !"".equals(infoStr)) {
					JSONArray jsonArray = JSONArray.fromObject(infoStr.substring(1, infoStr.length()));
					int index = jsonArray.size();
					List<ItemSpecsPojo> specslist = new ArrayList<ItemSpecsPojo>();
					for (int i = 0; i < index; i++) {
						JSONObject jObj = jsonArray.getJSONObject(i);
						specslist.add(JSONUtilNew.parse(jObj.toString(), ItemSpecsPojo.class));
					}
					
					String tmpStr = "";
					for (ItemSpecsPojo isp : specslist) {
						tmpStr = tmpStr + isp.getSkV() + ":" + isp.getSvV() + "|";
					}
					gi.setInfo(tmpStr.substring(0, tmpStr.length()-1));
				}
				
				for(FirstCatalogEntity first:firsts) {
					if (first.getFirstId().equals(gi.getFirstName())) {
						gi.setFirstName(first.getName());
						break;
					}
				}
				for(SecondCatalogEntity second:seconds) {
					if (second.getSecondId().equals(gi.getSecondName())) {
						gi.setSecondName(second.getName());
						break;
					}
				}
				for(ThirdCatalogEntity third:thirds) {
					if (third.getThirdId().equals(gi.getThirdName())) {
						gi.setThirdName(third.getName());
						break;
					}
				}
				
				if (gi.getGradeType() != null) {
					GradeTypeDTO gradeType = gradeTypes.get(gi.getGradeType());
					if (gradeType != null) {
						gi.setGradeTypeName(gradeType.getName());
					}
				}
				
				//商品标签
				String tmpGoodsTagName = "";
				for(GoodsTagEntity gte:gi.getGoodsTagList()) {
					tmpGoodsTagName = tmpGoodsTagName + gte.getTagName() + "|";
				}
				if (tmpGoodsTagName != "") {
					gi.setGoodsTagName(tmpGoodsTagName.substring(0, tmpGoodsTagName.length()-1));
				} else {
					gi.setGoodsTagName("普通");
				}
				
				//比价信息
				String tmpGoodsPriceRatioInfo = "";
				for (GoodsPriceRatioEntity gpre:gi.getGoodsPriceRatioList()) {
					tmpGoodsPriceRatioInfo = tmpGoodsPriceRatioInfo + gpre.getRatioPlatformName() +
							"平台:价格￥" + gpre.getRatioPrice() + " 评价数" + gpre.getEvaluateQty() +
							" 销量" + gpre.getSalesVolume() +"|";
				}
				if (tmpGoodsPriceRatioInfo != "") {
					gi.setGoodsPriceRatioInfo(tmpGoodsPriceRatioInfo.substring(0, tmpGoodsPriceRatioInfo.length()-1));
				} else {
					gi.setGoodsPriceRatioInfo("无");
				}
			}

			WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
			ServletContext servletContext = webApplicationContext.getServletContext();

			String fileType = "";
			if ("1".equals(type)) {
				fileType = "goods_stock_";
			} else if ("2".equals(type)) {
				fileType = "goods_info_";
			} else if ("3".equals(type)) {
				fileType = "goods_quotation_";
			}
			String fileName = fileType + DateUtil.getNowLongTime() + ".xlsx";
			String filePath = servletContext.getRealPath("/") + "EXCEL/" + staffEntity.getBadge() + "/" + fileName;

			String[] nameArray = null;
			String[] colArray = null;
			if ("1".equals(type)) {
				nameArray = new String[] { "商品编号", "商家编码", "商品名称", "规格", "上架状态", "供应商", "库存", "一级类目",
						"二级类目", "三级类目", "零售价", "分级类型", "返佣比例", "商品标签", "比价信息", "条码", "单位", "产地", "商品类型",
						"保质期", "品牌", "箱规" };
				colArray = new String[] { "ItemId", "Sku", "GoodsName", "Info", "ItemStatusName",
						"SupplierName", "FxQty", "FirstName", "SecondName", "ThirdName", "RetailPrice", 
						"GradeTypeName", "Proportion", "GoodsTagName", "GoodsPriceRatioInfo", "Encode", "Unit", 
						"Origin", "GoodsTypeName", "ShelfLife", "Brand", "Carton" };
			} else if ("2".equals(type)) {
				nameArray = new String[] { "商品ID", "商品编号", "商家编码", "商品名称", "规格", "上架状态", "供应商", "库存", "一级类目", "二级类目", "三级类目",
						"成本价", "内供价", "零售价", "分级类型", "返佣比例", "商品标签", "比价信息", "条码", "单位", "产地", "商品类型",
						"保质期", "品牌", "箱规"};
				colArray = new String[] { "GoodsId", "ItemId", "Sku", "GoodsName", "Info", "ItemStatusName",
						"SupplierName", "FxQty", "FirstName", "SecondName", "ThirdName", "ProxyPrice", "FxPrice",
						"RetailPrice", "GradeTypeName", "Proportion", "GoodsTagName", "GoodsPriceRatioInfo", "Encode", "Unit", 
						"Origin", "GoodsTypeName", "ShelfLife", "Brand", "Carton" };
			} else if ("3".equals(type)) {
				nameArray = new String[] { "分级类型", "一级类目", "二级类目", "三级类目", "商家编码", "商品条码", "商品名称", "商品品牌", 
						"产地", "规格", "单位", "箱规", "保质期", "商品类型", "库存", "零售价", "返佣比例", "商品标签", "比价信息" };
				colArray = new String[] { "GradeTypeName", "FirstName", "SecondName", "ThirdName", "Sku", "Encode", "GoodsName", "Brand", 
						"Origin", "Info", "Unit", "Carton", "ShelfLife", "GoodsTypeName", "FxQty", "RetailPrice", "Proportion", "GoodsTagName", "GoodsPriceRatioInfo" };
			}

			SXSSFWorkbook swb = new SXSSFWorkbook(100);
			ExcelUtil.createExcel(ReportList, nameArray, colArray, filePath, 0, "sheet1", swb);
			ExcelUtil.writeToExcel(swb, filePath);

			FileDownloadUtil.downloadFileByBrower(req, resp, filePath, fileName);
		} catch (Exception e) {
			resp.setContentType("text/html;charset=utf-8");
			resp.getWriter().println("下载失败，请重试!");
			resp.getWriter().println(e.getMessage());
			return;
		}
	}
	
	@RequestMapping(value = "/batchBindGoodsTag", method = RequestMethod.POST)
	public void batchBindGoodsTag(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String itemIds = req.getParameter("itemIds");
			String tagIds = req.getParameter("tagId");
			goodsItemService.batchBindTag(itemIds, tagIds, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}
}
