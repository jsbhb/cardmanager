package com.card.manager.factory.goods.controller;

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
import com.card.manager.factory.common.ResourceContants;
import com.card.manager.factory.goods.model.CatalogModel;
import com.card.manager.factory.goods.model.CategoryTypeEnum;
import com.card.manager.factory.goods.model.FirstCatalogEntity;
import com.card.manager.factory.goods.model.SecondCatalogEntity;
import com.card.manager.factory.goods.model.ThirdCatalogEntity;
import com.card.manager.factory.goods.service.CatalogService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

@Controller
@RequestMapping("/admin/goods/catalogMng")
public class CatalogMngController extends BaseController {

	@Resource
	CatalogService catalogService;

	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd(HttpServletRequest req, HttpServletResponse resp) {

		Map<String, Object> context = getRootMap();
		try {
			StaffEntity opt = SessionUtils.getOperator(req);
			context.put("opt", opt);

			String parentId = req.getParameter("parentId");
			if (StringUtil.isEmpty(parentId)) {
				context.put(MSG, "编号不存在!");
				return forword("error", context);
			}
			context.put("parentId", parentId);

			String type = req.getParameter("type");
			if (StringUtil.isEmpty(type)) {
				context.put(MSG, "没有级别信息!");
				return forword("error", context);
			}
			context.put("type", type);
			
			String key = ResourceContants.GOODS+"/"+ResourceContants.CATEGORY;
			if (CategoryTypeEnum.FIRST.getType().equals(type)) {
			} else if (CategoryTypeEnum.SECOND.getType().equals(type)) {
				key = key + "/" + parentId;
			} else if (CategoryTypeEnum.THIRD.getType().equals(type)) {
				SecondCatalogEntity entity = new SecondCatalogEntity();
				entity.setSecondId(parentId);
				SecondCatalogEntity newEntity = catalogService.queryFirstBySecondId(entity, opt.getToken());
				key = key + "/" + newEntity.getFirstId()+"/"+parentId;
			}
			//根据分类等级获取对应的id
			String tmpCategoryId = catalogService.getGoodsCategoryId(type);
			if ("".equals(tmpCategoryId)) {
				context.put(MSG, "分类等级错误，请重试!");
				return forword("error", context);
			} else {
				context.put("tmpCategoryId", tmpCategoryId);
			}
			key = key+"/"+tmpCategoryId;
			context.put("key", key);

			String parentName = java.net.URLDecoder.decode(req.getParameter("name"), "UTF-8");
			if (StringUtil.isEmpty(parentName)) {
				context.put(MSG, "没有分类名称!");
				return forword("error", context);
			}

			context.put("parentName", parentName);

			return forword("goods/catalog/add", context);
		} catch (Exception e) {
			context.put(MSG, e.getMessage());
			return forword("error", context);
		}
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(HttpServletRequest req, HttpServletResponse resp, @RequestBody CatalogModel model) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			if (model == null) {
				sendFailureMessage(resp, "参数不全！");
				return;
			}
			catalogService.add(model, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		sendSuccessMessage(resp, null);
	}
	
	
	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		try {
			StaffEntity opt = SessionUtils.getOperator(req);
			context.put("opt", opt);

			String id = req.getParameter("id");
			if (StringUtil.isEmpty(id)) {
				context.put(MSG, "编号不存在!");
				return forword("error", context);
			}
			context.put("id", id);

			String type = req.getParameter("type");
			if (StringUtil.isEmpty(type)) {
				context.put(MSG, "没有级别信息!");
				return forword("error", context);
			}
			context.put("type", type);

			String name = java.net.URLDecoder.decode(req.getParameter("name"), "UTF-8");
			if (StringUtil.isEmpty(name)) {
				context.put(MSG, "没有分类名称!");
				return forword("error", context);
			}
			context.put("name", name);

			String accessPath = java.net.URLDecoder.decode(req.getParameter("accessPath"), "UTF-8");
			if (StringUtil.isEmpty(accessPath)) {
				context.put(MSG, "没有分类别称!");
				return forword("error", context);
			}
			context.put("accessPath", accessPath);

			String sort = java.net.URLDecoder.decode(req.getParameter("sort"), "UTF-8");
			if (StringUtil.isEmpty(sort)) {
				context.put(MSG, "没有分类顺序!");
				return forword("error", context);
			}
			context.put("sort", sort);

			String tagPath = java.net.URLDecoder.decode(req.getParameter("tagPath"), "UTF-8");
			if (StringUtil.isEmpty(tagPath)) {
				context.put(MSG, "没有分类图标!");
				return forword("error", context);
			}
			context.put("tagPath", tagPath);
			
			String key = ResourceContants.GOODS+"/"+ResourceContants.CATEGORY;
			String categoryPath = java.net.URLDecoder.decode(req.getParameter("categoryPath"), "UTF-8");
			if (StringUtil.isEmpty(categoryPath)) {
				context.put(MSG, "没有分类路径!");
				return forword("error", context);
			}
			context.put("key", key+"/"+categoryPath);

			return forword("goods/catalog/edit", context);
		} catch (Exception e) {
			context.put(MSG, e.getMessage());
			return forword("error", context);
		}
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public void modify(HttpServletRequest req, HttpServletResponse resp, @RequestBody CatalogModel model) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			if (model == null) {
				sendFailureMessage(resp, "参数不全！");
				return;
			}
			catalogService.modify(model, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		sendSuccessMessage(resp, null);
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public void delete(HttpServletRequest req, HttpServletResponse resp) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String id = req.getParameter("id");
			String type = req.getParameter("type");
			if(StringUtil.isEmpty(id)||StringUtil.isEmpty(type)){
				sendFailureMessage(resp, "信息不全");
				return;
			}
			
			catalogService.delete(id,type,staffEntity);

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

		try {
			List<FirstCatalogEntity> firsts = catalogService.queryAll(opt.getToken());
			context.put("firsts", firsts);
			return forword("goods/catalog/list3", context);
		} catch (Exception e) {
			context.put(MSG, e.getMessage());
			return forword("error", context);
		}
	}

	@RequestMapping(value = "/querySecondCatalogByFirstId", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack querySecondCatalogByFirstId(HttpServletRequest req, HttpServletResponse resp) {
		PageCallBack pcb = new PageCallBack();
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String firstId = req.getParameter("firstId");

			if (StringUtil.isEmpty(firstId)) {
				sendFailureMessage(resp, "一级分类编号不存在！");
				return pcb;
			}

			List<SecondCatalogEntity> seconds = catalogService.querySecondCatalogByFirstId(staffEntity.getToken(),
					firstId);
			pcb.setObj(seconds);
			pcb.setSuccess(true);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return pcb;
		}

		return pcb;
	}
	
	
	@RequestMapping(value = "/queryThirdCatalogBySecondId", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack queryThirdCatalogBySecondId(HttpServletRequest req, HttpServletResponse resp) {
		PageCallBack pcb = new PageCallBack();
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String secondId = req.getParameter("secondId");

			if (StringUtil.isEmpty(secondId)) {
				sendFailureMessage(resp, "一级分类编号不存在！");
				return pcb;
			}

			List<ThirdCatalogEntity> thirds = catalogService.queryThirdCatalogBySecondId(staffEntity.getToken(),
					secondId);
			pcb.setObj(thirds);
			pcb.setSuccess(true);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return pcb;
		}

		return pcb;
	}

	@RequestMapping(value = "/createCategoryInfo")
	public ModelAndView createCategoryInfo(HttpServletRequest req, HttpServletResponse resp) {

		Map<String, Object> context = getRootMap();
		try {
			StaffEntity opt = SessionUtils.getOperator(req);
			context.put("opt", opt);
			List<FirstCatalogEntity> catalogs = catalogService.queryAll(opt.getToken());
			context.put("firsts", catalogs);
			return forword("goods/catalog/addByLabel", context);
		} catch (Exception e) {
			context.put(MSG, e.getMessage());
			return forword("error", context);
		}
	}
	
	@RequestMapping(value = "/categoryInfoPublish", method = RequestMethod.POST)
	public void categoryInfoPublish(HttpServletRequest req, HttpServletResponse resp) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			catalogService.publish(staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		sendSuccessMessage(resp, null);
	}
	
	@RequestMapping(value = "/changeCategorySort", method = RequestMethod.POST)
	public void changeCategorySort(HttpServletRequest req, HttpServletResponse resp) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String id = req.getParameter("id");
			String catelog = req.getParameter("catelog");
			String sort = req.getParameter("sort");
			if (StringUtil.isEmpty(id) || StringUtil.isEmpty(catelog) || StringUtil.isEmpty(sort)) {
				sendFailureMessage(resp, "缺少参数，请确认");
				return;
			}
			CatalogModel model = new CatalogModel();
			model.setId(id);
			model.setType(catelog);
			model.setSort(Integer.parseInt(sort));
			model.setStatus(2);
			catalogService.updCategoryByParam(model,staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		sendSuccessMessage(resp, null);
	}
	
	@RequestMapping(value = "/changeCategoryStatus", method = RequestMethod.POST)
	public void changeCategoryStatus(HttpServletRequest req, HttpServletResponse resp) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String id = req.getParameter("id");
			String catelog = req.getParameter("catelog");
			String status = req.getParameter("status");
			if (StringUtil.isEmpty(id) || StringUtil.isEmpty(catelog) || StringUtil.isEmpty(status)) {
				sendFailureMessage(resp, "缺少参数，请确认");
				return;
			}
			CatalogModel model = new CatalogModel();
			model.setId(id);
			model.setType(catelog);
			model.setSort(2);
			model.setStatus(Integer.parseInt(status));
			catalogService.updCategoryByParam(model,staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		sendSuccessMessage(resp, null);
	}
	
	@RequestMapping(value = "/changeCategoryPopular", method = RequestMethod.POST)
	public void changeCategoryPopular(HttpServletRequest req, HttpServletResponse resp) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String id = req.getParameter("id");
			String popular = req.getParameter("popular");
			if (StringUtil.isEmpty(id) || StringUtil.isEmpty(popular)) {
				sendFailureMessage(resp, "缺少参数，请确认");
				return;
			}
			CatalogModel model = new CatalogModel();
			model.setId(id);
			model.setType("3");
			model.setSort(2);
			model.setStatus(2);
			model.setIsPopular(Integer.parseInt(popular));
			
			catalogService.updCategoryByParam(model,staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		sendSuccessMessage(resp, null);
	}

}
