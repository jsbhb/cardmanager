package com.card.manager.factory.goods.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.base.PageCallBack;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.goods.grademodel.KJGoodsDTO;
import com.card.manager.factory.goods.model.BrandEntity;
import com.card.manager.factory.goods.model.FirstCatalogEntity;
import com.card.manager.factory.goods.model.KJGoodsItemEntity;
import com.card.manager.factory.goods.service.CatalogService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

@Controller
@RequestMapping("/admin/goods/listMng")
public class GoodsListMngController extends BaseController {

	@Resource
	CatalogService catalogService;

	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		context.put("suppliers", CachePoolComponent.getSupplier(opt.getToken()));
		List<FirstCatalogEntity> firsts = catalogService.queryAll(opt.getToken());
		context.put("firsts", firsts);
		List<BrandEntity> brands = CachePoolComponent.getBrands(opt.getToken());
		context.put("brands", brands);
		return forword("goods/product/list", context);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, KJGoodsDTO searchParam) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {

			String brandId = req.getParameter("brandId");
			if (!StringUtil.isEmpty(brandId)) {
				searchParam.setBrandId(brandId);
			}
			String supplierId = req.getParameter("supplierId");
			if (!StringUtil.isEmpty(supplierId)) {
				searchParam.setSupplierId(Integer.parseInt(supplierId));
			}
			String tabId = req.getParameter("hidTabId");
//			if ("first".equals(tabId)) {
//				searchParam.setKjGIstatus(0);
//			} else if ("second".equals(tabId)) {
//				searchParam.setKjGIstatus(1);
//			} else if ("third".equals(tabId)) {
//				searchParam.setKjGIstatus(2);
//			} else if ("fourth".equals(tabId)) {
//				searchParam.setKjGIstatus(11);
//			}

			String typeId = req.getParameter("categoryTypeId");
			String categoryId = req.getParameter("categoryId");
			if (!StringUtil.isEmpty(typeId) && !StringUtil.isEmpty(categoryId)) {
				if ("first".equals(typeId)) {
					searchParam.setFirstCatalogId(categoryId);
				} else if ("second".equals(typeId)) {
					searchParam.setSecondCatalogId(categoryId);
				} else if ("third".equals(typeId)) {
					searchParam.setThirdCatalogId(categoryId);
				}
			}

			String itemId = req.getParameter("itemId");
			if (!StringUtil.isEmpty(itemId)) {
				searchParam.setItemId(itemId);
			}
			String itemCode = req.getParameter("itemCode");
			if (!StringUtil.isEmpty(itemCode)) {
				searchParam.setItemCode(itemCode);
			}
			String goodsName = req.getParameter("goodsName");
			if (!StringUtil.isEmpty(goodsName)) {
				searchParam.setGoodsName(goodsName);
			}
			String hidGoodsName = req.getParameter("hidGoodsName");
			if (!StringUtil.isEmpty(hidGoodsName)) {
				searchParam.setGoodsName(hidGoodsName);
			}
			String goodsType = req.getParameter("goodsType");
			if (!StringUtil.isEmpty(goodsType)) {
				searchParam.setType(Integer.parseInt(goodsType));
			}
			String encode = req.getParameter("encode");
			if (!StringUtil.isEmpty(encode)) {
				searchParam.setEncode(encode);
			}

			pcb = catalogService.dataList(searchParam, params, staffEntity.getToken(),
					ServerCenterContants.GOODS_CENTER_KJ_GOODS_ITEM_QUERY_FOR_PAGE, KJGoodsItemEntity.class);

			if (pcb != null) {
				List<KJGoodsItemEntity> list = (List<KJGoodsItemEntity>) pcb.getObj();
//				List<KJGoodsEntity> kjGoodsList = new ArrayList<KJGoodsEntity>();
//				List<KJSpecsGoodsEntity> kjSpecsGoodsList = new ArrayList<KJSpecsGoodsEntity>();
//				for (KJGoodsItemEntity entity : list) {
//					kjGoodsList.add(entity.getGoodsEntity());
//					kjSpecsGoodsList.add(entity.getSpecsGoodsEntity());
//				}
//				GoodsUtil.changeSpecsGoodsInfo(kjSpecsGoodsList);
//				GoodsUtil.changeCategoryInfo(kjGoodsList, staffEntity.getToken());
				pcb.setObj(list);
			}

		} catch (ServerCenterNullDataException e) {
			if (pcb == null) {
				pcb = new PageCallBack();
			}
			pcb.setPagination(searchParam);
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
}
