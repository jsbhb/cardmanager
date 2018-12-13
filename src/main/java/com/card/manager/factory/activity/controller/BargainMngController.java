package com.card.manager.factory.activity.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.activity.model.BargainActivityModel;
import com.card.manager.factory.activity.model.BargainActivityShowPageModel;
import com.card.manager.factory.activity.model.BargainActivityShowPageRecordModel;
import com.card.manager.factory.activity.service.BargainService;
import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

@Controller
@RequestMapping("/admin/activity/bargainMng")
public class BargainMngController extends BaseController {

	@Resource
	BargainService bargainService;
	
	@RequestMapping(value = "/saveBargainActivity", method = RequestMethod.POST)
	public void saveBargainActivity(HttpServletRequest req, HttpServletResponse resp, @RequestBody BargainActivityModel bargainModel) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			bargainModel.setOpt(staffEntity.getOptName());
			bargainService.insertBargainActivity(bargainModel, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		sendSuccessMessage(resp, null);
	}
	
	@RequestMapping(value = "/toShowAcitvityInfo")
	public ModelAndView toShowAcitvityInfo(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {
			BargainActivityModel bargainModel = new BargainActivityModel();
			String id = req.getParameter("id");
			if (StringUtil.isEmpty(id)) {
				context.put(MSG, "缺少必要参数，请重试！");
				return forword("error", context);
			} else {
				bargainModel.setId(Integer.parseInt(id));
			}
			BargainActivityModel bargainInfo = bargainService.queryBargainActivityInfoByParam(bargainModel,opt.getToken());
			context.put("bargainInfo", bargainInfo);
		} catch (Exception e) {
			context.put(MSG, e.getMessage());
			return forword("error", context);
		}
		return forword("activity/activityMng/editActivity", context);
	}
	
	@RequestMapping(value = "/changeBargainActivity", method = RequestMethod.POST)
	public void changeBargainActivity(HttpServletRequest req, HttpServletResponse resp, @RequestBody BargainActivityModel bargainModel) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			bargainModel.setOpt(staffEntity.getOptName());
			bargainService.updateBargainActivity(bargainModel, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		sendSuccessMessage(resp, null);
	}
	
	@RequestMapping(value = "/showPage")
	public ModelAndView showPage(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {
			BargainActivityModel bargainModel = new BargainActivityModel();
			bargainModel.setId(1);
			List<BargainActivityShowPageModel> showPageInfoList = bargainService.queryBargainActivityShowPageInfo(bargainModel,opt.getToken());
			Integer totalAllCount = 0;
			Integer totalBargainCount = 0;
			Integer totalBuyCount = 0;
			for (BargainActivityShowPageModel model : showPageInfoList) {
				if (model.getRecordList() != null) {
					totalAllCount += model.getRecordList().size();
					for(BargainActivityShowPageRecordModel record : model.getRecordList()) {
						if (record.isBuy()) {
							totalBuyCount += 1;
							model.setBuyCount(model.getBuyCount() + 1);
						} else {
							totalBargainCount += 1;
						}
						if (record.getName() == null || "".equals(record.getName())) {
							if (record.getNickName() != null && !"".equals(record.getNickName())) {
								record.setName(record.getNickName());
							} else {
								record.setName(record.getUserId());
							}
						}
					}
				}
			}
			context.put("totalAllCount", totalAllCount);
			context.put("totalBargainCount", totalBargainCount);
			context.put("totalBuyCount", totalBuyCount);
			context.put("showPageInfoList", showPageInfoList);
		} catch (Exception e) {
			context.put(MSG, e.getMessage());
			return forword("error", context);
		}
		return forword("activity/bargainActivityMng/showPage", context);
	}
}
