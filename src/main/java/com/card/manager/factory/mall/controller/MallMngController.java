package com.card.manager.factory.mall.controller;

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
import com.card.manager.factory.goods.model.DictData;
import com.card.manager.factory.goods.model.FirstCatalogEntity;
import com.card.manager.factory.goods.model.Layout;
import com.card.manager.factory.goods.model.PopularizeDict;
import com.card.manager.factory.goods.service.CatalogService;
import com.card.manager.factory.goods.service.GoodsItemService;
import com.card.manager.factory.goods.service.GoodsService;
import com.card.manager.factory.mall.pojo.FloorDictPojo;
import com.card.manager.factory.mall.pojo.PageTypeEnum;
import com.card.manager.factory.mall.pojo.PopularizeDictTypeEnum;
import com.card.manager.factory.mall.service.MallService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.DateUtil;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

@Controller
@RequestMapping("/admin/mall/indexMng")
public class MallMngController extends BaseController {

	@Resource
	MallService mallService;

	@Resource
	CatalogService catalogService;

	@Resource
	GoodsItemService goodsItemService;

	@Resource
	GoodsService goodsService;

	@RequestMapping(value = "/mng")
	public ModelAndView toFuncList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		//分级类型不是海外购时，提示无法使用功能
		if (opt.getGradeType() != 1 && opt.getRoleId() != 1) {
			return forword("mall/goods/notice", context);
		}
		return forword("mall/index/mng", context);
	}

	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		return forword("mall/index/floor", context);
	}

	@RequestMapping(value = "/toAddFloor")
	public ModelAndView toAddDict(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);

		try {
			List<FirstCatalogEntity> catalogs = catalogService.queryFirstCatalogs(opt.getToken());
			context.put("firsts", catalogs);
			
			// 自动产生业务流水号：tmp+GoodsId+账号+时间+4位随机数
			Integer num = (int) (Math.random() * 9000) + 1000;
			String key = "";
			try {
				key = "tmpFloorId" + opt.getBadge() + DateUtil.getNowPlusTimeMill() + num;
			} catch (Exception e) {
				e.printStackTrace();
				key = "tmpFloorId" + opt.getBadge() + num;
			}
			context.put("key", key);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword("error", context);
		}

		return forword("mall/index/floorAdd", context);
	}

	@RequestMapping(value = "/toEditFloor")
	public ModelAndView toShow(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {
			String id = req.getParameter("id");
			PopularizeDict entity = mallService.queryById(id, opt.getGradeId(), opt.getToken());
			context.put("dict", entity);
			List<FirstCatalogEntity> catalogs = catalogService.queryFirstCatalogs(opt.getToken());
			context.put("firsts", catalogs);
			return forword("mall/index/floorEdit", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
	}

	@RequestMapping(value = "/toAddFloorContent")
	public ModelAndView toAddFloorContent(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);

		try {
			String id = req.getParameter("id");
			if (StringUtil.isEmpty(id)) {
				context.put(ERROR, "没有编号信息");
				return forword("error", context);
			}
			String pageType = req.getParameter("pageType");
			if (StringUtil.isEmpty(pageType)) {
				context.put(ERROR, "没有页面类型信息");
				return forword("error", context);
			}
			context.put("id", id);
			context.put("pageType", pageType);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword("error", context);
		}

		return forword("mall/index/addFloorContent", context);
	}

	@RequestMapping(value = "/ad")
	public ModelAndView ad(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		context.put(OPT, staffEntity);

		Layout layout = new Layout();
		layout.setCode("module_00006");
		if (staffEntity.getGradeId() == 0) {
			layout.setCenterId(2);
		} else {
			layout.setCenterId(staffEntity.getGradeId());
		}

		List<DictData> dictDataList;
		try {
			dictDataList = mallService.queryDataAll(layout, staffEntity.getToken());
			context.put("dataList", dictDataList);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword("error", context);
		}

		return forword("mall/index/ad", context);
	}

	@RequestMapping(value = "/banner")
	public ModelAndView banner(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		context.put(OPT, staffEntity);

		Layout layout = new Layout();
		layout.setCode("module_00003");
		layout.setPageType(PageTypeEnum.PC.getIndex());
		if (staffEntity.getGradeId() == 0) {
			layout.setCenterId(2);
		} else {
			layout.setCenterId(staffEntity.getGradeId());
		}

		List<DictData> dictDataList;
		try {
			dictDataList = mallService.queryDataAll(layout, staffEntity.getToken());
			context.put("dataList", dictDataList);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword("error", context);
		}

		return forword("mall/index/banner", context);
	}

	@RequestMapping(value = "/h5Banner")
	public ModelAndView h5Banner(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		context.put(OPT, staffEntity);

		Layout layout = new Layout();
		layout.setCode("module_00003");
		layout.setPageType(PageTypeEnum.H5.getIndex());
		if (staffEntity.getGradeId() == 0) {
			layout.setCenterId(2);
		} else {
			layout.setCenterId(staffEntity.getGradeId());
		}

		List<DictData> dictDataList;
		try {
			dictDataList = mallService.queryDataAll(layout, staffEntity.getToken());
			context.put("dataList", dictDataList);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword("error", context);
		}

		return forword("mall/index/h5Banner", context);
	}

	@RequestMapping(value = "/toEditContent")
	public ModelAndView toEditContent(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {
			String id = req.getParameter("id");
			DictData data = mallService.queryDataById(id, opt.getGradeId(), opt.getToken());
			context.put("data", data);
			String key = req.getParameter("key");
			if (StringUtil.isEmpty(key)) {
				context.put(ERROR, "没有key信息");
				return forword("error", context);
			}
			context.put("key", key);
			String pageType = req.getParameter("pageType");
			if (StringUtil.isEmpty(pageType)) {
				context.put(ERROR, "没有页面类型信息");
				return forword("error", context);
			}
			context.put("pageType", pageType);
			String bussinessType = req.getParameter("bussinessType");
			if (StringUtil.isEmpty(bussinessType)) {
				context.put(ERROR, "没有业务类型信息");
				return forword("error", context);
			}
			context.put("bussinessType", bussinessType);
			return forword("mall/index/contentEdit", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
	}


	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, Pagination pagination) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			String code = req.getParameter("code");
			params.put("code", code);
			if (staffEntity.getGradeId() == 0) {
				params.put("centerId", 2);
			} else {
				params.put("centerId", staffEntity.getGradeId());
			}

			pcb = mallService.dataList(pagination, params, staffEntity.getToken(),
					ServerCenterContants.GOODS_CENTER_MALL_QUERY_DICT_FOR_PAGE, PopularizeDict.class);
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

	@RequestMapping(value = "/dataListForData", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataListForOrderGoods(HttpServletRequest req, HttpServletResponse resp, Pagination pagination) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			String dictId = req.getParameter("dictId");
			if (staffEntity.getGradeId() == 0) {
				params.put("centerId", 2);
			} else {
				params.put("centerId", staffEntity.getGradeId());
			}
			params.put("dictId", dictId);

			pcb = mallService.dataList(pagination, params, staffEntity.getToken(),
					ServerCenterContants.GOODS_CENTER_MALL_QUERY_DATA_FOR_PAGE, DictData.class);
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

	@RequestMapping(value = "/saveDict", method = RequestMethod.POST)
	public void save(HttpServletRequest req, HttpServletResponse resp, @RequestBody FloorDictPojo pojo) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		pojo.setOpt(staffEntity.getOptid());
		if (staffEntity.getGradeId() == 0) {
			pojo.setCenterId(2);
		} else {
			pojo.setCenterId(staffEntity.getGradeId());
		}

		try {

			mallService.addDict(pojo, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		sendSuccessMessage(resp, pojo.getPicPath1());
	}

	@RequestMapping(value = "/saveData", method = RequestMethod.POST)
	public void save(HttpServletRequest req, HttpServletResponse resp, @RequestBody DictData data) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		data.setOpt(staffEntity.getOptid());
		if (staffEntity.getGradeId() == 0) {
			data.setCenterId(2);
		} else {
			data.setCenterId(staffEntity.getGradeId());
		}
		try {
			mallService.addData(data, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public void updateAd(HttpServletRequest req, HttpServletResponse resp, @RequestBody DictData data) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		data.setOpt(staffEntity.getOptid());
		if (staffEntity.getGradeId() == 0) {
			data.setCenterId(2);
		} else {
			data.setCenterId(staffEntity.getGradeId());
		}
		try {
			mallService.updateData(data, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/updateDict", method = RequestMethod.POST)
	public void updateDict(HttpServletRequest req, HttpServletResponse resp, @RequestBody PopularizeDict dict) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		dict.setOpt(staffEntity.getOptid());
		dict.setCenterId(staffEntity.getGradeId());
		try {
			if (dict.getLayout() == null) {
				Layout layout = new Layout();
				layout.setId(dict.getLayoutId());
				layout.setSort(dict.getSort());
				dict.setLayout(layout);
			} else {
				dict.getLayout().setSort(dict.getSort());
			}
			mallService.updateDict(dict, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/delateDict", method = RequestMethod.POST)
	public void delateDict(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String id = req.getParameter("id");
			mallService.delateDict(id, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/delateData", method = RequestMethod.POST)
	public void delateData(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String id = req.getParameter("id");
			mallService.delateData(id, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/init", method = RequestMethod.POST)
	public void init(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);

		String module = req.getParameter("module");
		if (StringUtil.isEmpty(module)) {
			sendFailureMessage(resp, "操作失败：没有模块编码");
			return;
		}

		try {
			Layout layout = new Layout();
			layout.setCode(module);
			layout.setOpt(staffEntity.getOptid());
			String pageType = req.getParameter("pageType");

			if (StringUtil.isEmpty(pageType)) {
				sendFailureMessage(resp, "操作失败：没有pageType");
				return;
			}

			layout.setPageType(Integer.parseInt(pageType));

			layout.setShow(1);
			layout.setType(0);
			layout.setPage("index");
			if (staffEntity.getGradeId() == 0) {
				layout.setCenterId(2);
			} else {
				layout.setCenterId(staffEntity.getGradeId());
			}

			PopularizeDict dict = new PopularizeDict();
			dict.setCenterId(staffEntity.getGradeId());
			dict.setType(PopularizeDictTypeEnum.NORMAL.getIndex());
			dict.setLayout(layout);
			if (staffEntity.getGradeId() == 0) {
				dict.setCenterId(2);
			} else {
				dict.setCenterId(staffEntity.getGradeId());
			}

			mallService.initDict(dict, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

}
