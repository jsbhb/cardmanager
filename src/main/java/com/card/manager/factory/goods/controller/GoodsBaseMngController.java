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
import com.card.manager.factory.base.Pagination;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.goods.model.BrandEntity;
import com.card.manager.factory.goods.model.FirstCatalogEntity;
import com.card.manager.factory.goods.model.GoodsBaseEntity;
import com.card.manager.factory.goods.model.SecondCatalogEntity;
import com.card.manager.factory.goods.model.ThirdCatalogEntity;
import com.card.manager.factory.goods.service.CatalogService;
import com.card.manager.factory.goods.service.GoodsBaseService;
import com.card.manager.factory.system.model.GradeEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.SessionUtils;

@Controller
@RequestMapping("/admin/goods/baseMng")
public class GoodsBaseMngController extends BaseController {

	@Resource
	GoodsBaseService goodsBaseService;

	@Resource
	CatalogService catalogService;

	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {
			List<BrandEntity> brands = CachePoolComponent.getBrands(opt.getToken());
			if (brands.size() == 0) {
				context.put(ERROR, "没有品牌信息,无法查看基础商品！");
				context.put(ERROR_CODE, "405！");
				return forword("error", context);
			}

			context.put("brands", brands);

			List<FirstCatalogEntity> catalogs = catalogService.queryFirstCatalogs(opt.getToken());
			context.put("firsts", catalogs);

			return forword("goods/base/add", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword("error", context);
		}

	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void save(HttpServletRequest req, HttpServletResponse resp, @RequestBody GoodsBaseEntity entity) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		entity.setOpt(staffEntity.getOptid());
		try {
			entity.setCenterId(staffEntity.getGradeId());
			goodsBaseService.addEntity(entity, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		List<BrandEntity> brands = CachePoolComponent.getBrands(opt.getToken());
		context.put("brands", brands);
		context.put(OPT, opt);
		return forword("goods/base/list", context);
	}

	@RequestMapping(value = "/listForAdd")
	public ModelAndView listForAdd(HttpServletRequest req, HttpServletResponse resp, GoodsBaseEntity entity) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		List<BrandEntity> brands = CachePoolComponent.getBrands(opt.getToken());
		context.put("brands", brands);
		context.put(OPT, opt);
		return forword("goods/base/listForAdd", context);
	}

	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, GoodsBaseEntity entity) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			pcb = goodsBaseService.dataList(entity, params, staffEntity.getToken(),
					ServerCenterContants.GOODS_CENTER_BASE_QUERY_FOR_PAGE, GoodsBaseEntity.class);
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

	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		String id = req.getParameter("baseId");

		try {
			GoodsBaseEntity brand = goodsBaseService.queryById(id, opt.getToken());
			context.put("brand", brand);
			
			List<FirstCatalogEntity> catalogs = catalogService.queryFirstCatalogs(opt.getToken());
			for (FirstCatalogEntity fce : catalogs) {
				if (fce.getFirstId().equals(brand.getFirstCatalogId())) {
					context.put("firstId", brand.getFirstCatalogId());
					context.put("firstName", fce.getName());
					break;
				}
			}
			
			List<SecondCatalogEntity> secondCatalogs = catalogService.querySecondCatalogByFirstId(opt.getToken(),brand.getFirstCatalogId());
			for (SecondCatalogEntity sce : secondCatalogs) {
				if (sce.getSecondId().equals(brand.getSecondCatalogId())) {
					context.put("secondId", brand.getSecondCatalogId());
					context.put("secondName", sce.getName());
					break;
				}
			}
			
			List<ThirdCatalogEntity> thirdCatalogs = catalogService.queryThirdCatalogBySecondId(opt.getToken(),brand.getSecondCatalogId());
			for (ThirdCatalogEntity tce : thirdCatalogs) {
				if (tce.getThirdId().equals(brand.getThirdCatalogId())) {
					context.put("thirdId", brand.getThirdCatalogId());
					context.put("thirdName", tce.getName());
					break;
				}
			}
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword("error", context);
		}

		return forword("goods/base/edit", context);
	}

	@RequestMapping(value = "/editGoodsBase", method = RequestMethod.POST)
	public void editGoodsBase(HttpServletRequest req, HttpServletResponse resp, @RequestBody GoodsBaseEntity entity) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		entity.setOpt(staffEntity.getOptid());
		try {
			entity.setCenterId(staffEntity.getGradeId());
			goodsBaseService.updEntity(entity, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/editBrand", method = RequestMethod.POST)
	public void editBrand(HttpServletRequest req, HttpServletResponse resp, @RequestBody GradeEntity gradeInfo) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			// gradeMngService.saveGrade(gradeInfo, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}
}
