package com.card.manager.factory.shop.controller;

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
import com.card.manager.factory.shop.model.ShopEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.model.UserInfo;
import com.card.manager.factory.system.service.GradeMngService;
import com.card.manager.factory.util.DateUtil;
import com.card.manager.factory.util.ExcelUtil;
import com.card.manager.factory.util.FileDownloadUtil;
import com.card.manager.factory.util.SessionUtils;

@Controller
@RequestMapping("/admin/shop/shopMng")
public class ShopMngController extends BaseController {
	
	@Resource
	GradeMngService gradeMngService;

	@RequestMapping(value = "/mng")
	public ModelAndView mngInfo(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		//未开通跳转提示页面
		if (!"1".equals(opt.getTsFlg())) {
			return forword("shop/notice", context);
		}
		
		ShopEntity shop = gradeMngService.queryByGradeId(opt.getGradeId()+"", opt.getToken());
		context.put("shop", shop);
		context.put("gradeId", opt.getGradeId()+"");
		return forword("shop/mng", context);
	}
	
	@RequestMapping(value = "/dataListForShop")
	@ResponseBody
	public PageCallBack dataListForGrade(UserInfo userInfo, HttpServletRequest req, HttpServletResponse resp) {
		PageCallBack pcb = null;
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("needPaging", true);
		StaffEntity opt = SessionUtils.getOperator(req);
		try {
			String shopId = req.getParameter("shopId");
			userInfo.setShopId(Integer.parseInt(shopId));
			pcb = gradeMngService.dataList(userInfo, params, opt.getToken(),
					ServerCenterContants.USER_CENTER_MICRO_SHOP_USERINFO_QUERY, UserInfo.class);
		} catch (ServerCenterNullDataException e) {
			if (pcb == null) {
				pcb = new PageCallBack();
			}
			pcb.setPagination(userInfo);
			pcb.setSuccess(true);
			return pcb;
		} catch (Exception e) {
			if (pcb == null) {
				pcb = new PageCallBack();
			}
			pcb.setErrTrace(e.getMessage());
			pcb.setSuccess(false);
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return pcb;
		}

		return pcb;
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public void update(HttpServletRequest req, HttpServletResponse resp, @RequestBody ShopEntity shopInfo) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			gradeMngService.updateShop(shopInfo, staffEntity);
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
			String shopId = req.getParameter("shopId");
			List<UserInfo> ReportList = new ArrayList<UserInfo>();
			UserInfo searchEntity = new UserInfo();
			searchEntity.setShopId(Integer.parseInt(shopId));
			ReportList = gradeMngService.queryAllUserInfoByShopIdForDownload(searchEntity, staffEntity.getToken());

			Map<Integer, GradeBO> gradeMap = CachePoolComponent.getGrade(staffEntity.getToken());
			GradeBO gradeInfo = gradeMap.get(Integer.parseInt(shopId));
			if (gradeInfo == null) {
				gradeInfo = new GradeBO();
				gradeInfo.setName(staffEntity.getGradeName());
			}
			for (UserInfo ui : ReportList) {
				ui.setOpt(gradeInfo.getName());
				if ("".equals(ui.getUserDetail().getName())) {
					ui.setAccount(ui.getUserDetail().getNickName());
				} else {
					ui.setAccount(ui.getUserDetail().getName());
				}
				
				switch (ui.getUserDetail().getSex()) {
				case 0:ui.setWechat("男");break;
				default:ui.setWechat("女");break;
				}
			}

			WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
			ServletContext servletContext = webApplicationContext.getServletContext();

			String fileType = "shop_userinfo_";
			String fileName = fileType + DateUtil.getNowLongTime() + ".xlsx";
			String filePath = servletContext.getRealPath("/") + "EXCEL/" + staffEntity.getBadge() + "/" + fileName;

			String[] nameArray = null;
			String[] colArray = null;
			nameArray = new String[] { "手机号", "姓名/昵称", "性别", "注册时间", "所属店铺" };
			colArray = new String[] { "Phone", "Account", "Wechat", "CreateTime", "Opt" };

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
}
