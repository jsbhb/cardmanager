package com.card.manager.factory.label.controller;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.goods.service.GoodsItemService;
import com.card.manager.factory.system.model.GradeEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.service.GradeMngService;
import com.card.manager.factory.util.FileDownloadUtil;
import com.card.manager.factory.util.ImageUtil;
import com.card.manager.factory.util.QrCodeUtil;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.ZXingCodeUtil;

@Controller
@RequestMapping("/admin/label/shopQRMng")
public class ShopQRMngController extends BaseController {

	private static String imgPath = "label/shop/";
	
	@Resource
	GoodsItemService goodsItemService;
	
	@Resource
	GradeMngService gradeMngService;

	@RequestMapping(value = "/mng")
	public ModelAndView mngList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		
		//根据账号信息获取对应的最上级分级ID
		int firstGradeId = gradeMngService.queryFirstGradeIdByOpt(opt.getGradeId()+"");
		//如果是admin进入则显示海外购的内容
		if (firstGradeId == 0) {
			firstGradeId = 4;
		}
		GradeEntity entity = gradeMngService.queryById(firstGradeId+"", opt.getToken());
		String strLink = "";
		if (entity != null) {
			strLink = entity.getMobileUrl() + "/index.html?shopId=" + opt.getGradeId();
		}
		context.put("strLink", strLink);
		
		return forword("label/shop/mng", context);
	}
	
	@RequestMapping(value = "/downLoadFile")
	public void downLoadFile(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			
			WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
			ServletContext servletContext = webApplicationContext.getServletContext();
			String logoPath = servletContext.getRealPath("/") + "img/goodsExtensionLogo.png";
			String QRPicPath = servletContext.getRealPath("/") + imgPath + "/" + staffEntity.getBadge();
			File QrCodeFile = null;
			QrCodeFile = new File(QRPicPath);
			if (!QrCodeFile.exists()) {
				QrCodeFile.mkdirs();
			}
			QRPicPath = QRPicPath + "/" + staffEntity.getBadge() + ".jpg";
			//生成二维码
			ZXingCodeUtil zXingCode=new ZXingCodeUtil();
			File logoFile = new File(logoPath);
	        QrCodeFile = new File(QRPicPath);
	        String url = req.getParameter("path");
	        String note = "";
	        zXingCode.drawLogoQRCode(logoFile, QrCodeFile, url, note);
			String filePath = QRPicPath;
			String fileName = staffEntity.getBadge() + ".jpg";
			FileDownloadUtil.downloadFileByBrower(req, resp, filePath, fileName);
			if (QrCodeFile.exists()) {
	    		QrCodeFile.delete();
	    	}
		} catch (Exception e) {
			resp.setContentType("text/html;charset=utf-8");
			resp.getWriter().println("下载失败，请重试!");
			resp.getWriter().println(e.getMessage());
			return;
		}
	}
}
