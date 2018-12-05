package com.card.manager.factory.activity.controller;

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

import com.card.manager.factory.activity.base.BaseActivityModel;
import com.card.manager.factory.activity.service.ActivityService;
import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.base.PageCallBack;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.component.model.GradeBO;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.goods.model.GoodsTagEntity;
import com.card.manager.factory.goods.service.GoodsService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

@Controller
@RequestMapping("/admin/activity/activityMng")
public class ActivityMngController extends BaseController {

	@Resource
	ActivityService activityService;

	@Resource
	GoodsService goodsService;
	
	@RequestMapping(value = "/activityList")
	public ModelAndView activityList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		// set page privilege
		if (opt.getRoleId() == 1) {
			context.put("prilvl", "1");
		} else {
			context.put("prilvl", req.getParameter("privilege"));
		}
		return forword("activity/activityMng/list", context);
	}

	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, BaseActivityModel model) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			String type = req.getParameter("activityType");
			if (!StringUtil.isEmpty(type)) {
				model.setType(Integer.parseInt(type));
			}
			String status = req.getParameter("activityStatus");
			if (!StringUtil.isEmpty(status)) {
				model.setStatus(Integer.parseInt(status));
			}
			String name = req.getParameter("activityName");
			if (!StringUtil.isEmpty(name)) {
				model.setName(name);;
			}
			
//			String searchTime = req.getParameter("searchTime");
//			if (!StringUtil.isEmpty(searchTime)) {
//				String[] times = searchTime.split("~");
//				model.setActivityStartTime(times[0].trim());
//				model.setActivityEndTime(times[1].trim());
//			}

			pcb = activityService.dataList(model, params, staffEntity.getToken(),
					ServerCenterContants.GOODS_CENTER_QUERY_ACTIVITY_INFO, BaseActivityModel.class);

		} catch (ServerCenterNullDataException e) {
			if (pcb == null) {
				pcb = new PageCallBack();
			}
			pcb.setPagination(model);
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

	@RequestMapping(value = "/toAddActivity")
	public ModelAndView toAddActivity(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		return forword("activity/activityMng/addActivity", context);
	}

	@RequestMapping(value = "/listForAdd")
	public ModelAndView listForAdd(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		context.put("suppliers", CachePoolComponent.getSupplier(opt.getToken()));
		List<GoodsTagEntity> tags = goodsService.queryGoodsTags(opt.getToken());
		context.put("tags", tags);
		GradeBO grade = CachePoolComponent.getGrade(opt.getToken()).get(opt.getGradeId());
		context.put("gradeType", grade.getGradeType());
		return forword("activity/activityMng/listForAdd", context);
	}
}
