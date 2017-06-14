package com.card.manager.factory.auth.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.auth.model.FuncEntity;
import com.card.manager.factory.auth.service.FuncMngService;
import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.base.PageCallBack;
import com.card.manager.factory.base.Pagination;
import com.github.pagehelper.Page;

@Controller
@RequestMapping("/admin/system/funcMng")
public class FuncMngController extends BaseController {

	@Resource
	FuncMngService funcMngService;
	
	@RequestMapping(value = "/list")
//	@Auth(verifyLogin = false, verifyURL = false)
	public ModelAndView toFuncList(HttpServletRequest req, HttpServletResponse resp) {
		// 返回数据类型
		Map<String, Object> context = getRootMap();
		return forword("system/funcMng", context);
	}
	
	@RequestMapping(value="/dataList")
	public PageCallBack dataList(Pagination pagination, HttpServletRequest req, HttpServletResponse resp){
		PageCallBack pcb = new PageCallBack();
		try {
			Page<FuncEntity> funcPage = funcMngService.queryParentFunc(pagination);
			pcb.setPagination(webPageConverter(funcPage));
			pcb.setObj(funcPage);
			pcb.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			pcb.setErrTrace(e.getMessage());
			pcb.setSuccess(false);
		}
		
		return pcb;
	}
}
