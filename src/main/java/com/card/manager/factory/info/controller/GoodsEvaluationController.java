package com.card.manager.factory.info.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.info.model.NewsModel;
import com.card.manager.factory.info.service.InfoService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.SessionUtils;

@Controller
@RequestMapping("/admin/goods/evaluation")
public class GoodsEvaluationController extends BaseController {

	@Resource
	InfoService infoService;
	
	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		return forword("info/goodsEvaluation/add", context);
	}
	

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(HttpServletRequest req, HttpServletResponse resp,@RequestBody NewsModel model) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		model.setOpt(staffEntity.getOptid());
		try {
			infoService.saveAndPublishNews(model, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		sendSuccessMessage(resp, "");
	}

}
