package com.card.manager.factory.label.controller;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.Map;
import java.util.UUID;

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
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.component.model.GradeBO;
import com.card.manager.factory.goods.grademodel.GradeTypeDTO;
import com.card.manager.factory.goods.service.GoodsItemService;
import com.card.manager.factory.shop.model.ShopEntity;
import com.card.manager.factory.system.model.GradeEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.service.GradeMngService;
import com.card.manager.factory.util.FileDownloadUtil;
import com.card.manager.factory.util.FileUtil;
import com.card.manager.factory.util.ImageUtil;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.URLUtils;
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
			firstGradeId = 2;
		}
		GradeEntity entity = gradeMngService.queryById(firstGradeId+"", opt.getToken());
		String strLink = "";
		if (entity != null) {
			strLink = entity.getMobileUrl() + "/index.html?shopId=" + opt.getGradeId();
		}
		context.put("strLink", strLink);

		Map<Integer, GradeTypeDTO> gradeTypes = CachePoolComponent.getGradeType(opt.getToken());
		String strExtensionLink = "";
		//admin或者海外购账号
		if (opt.getGradeType() == 0 || opt.getGradeType() == 1) {
			strExtensionLink = URLUtils.get("mobileUrl") + "amount-access.html?shopId=2";
		} else {
			//海外购以外所有分级
			strExtensionLink = URLUtils.get("mobileUrl") + "amount-access.html?shopId=" + opt.getGradeId();
			GradeTypeDTO tmpGradeType = gradeTypes.get(opt.getGradeType());
			if (tmpGradeType.getName().indexOf("线上合伙人") != -1 ||
				tmpGradeType.getName().indexOf("门店") != -1 ||
				tmpGradeType.getName().indexOf("店中店") != -1) {
				strExtensionLink = "";
			}
		}
		context.put("strExtensionLink", strExtensionLink);
		if ("".equals(strExtensionLink)) {
			context.put("strExtensionLinkShow", "false");
		} else {
			context.put("strExtensionLinkShow", "true");
		}
		
		String strWelfareUrlLink = "";
		String strWelfareType = "";
		GradeBO gradeInfo = CachePoolComponent.getGrade(opt.getToken()).get(opt.getGradeId());
		if (gradeInfo != null && gradeInfo.getWelfareType() == 1) {
			strWelfareType = gradeInfo.getWelfareType() + "";
			strWelfareUrlLink = URLUtils.get("welfareShopQrUrl") + "?shopId=" + opt.getGradeId();
		}
		context.put("strWelfareType", strWelfareType);
		context.put("strWelfareUrlLink", strWelfareUrlLink);
		// set page privilege
		if (opt.getRoleId() == 1) {
			context.put("prilvl", "1");
		} else {
			context.put("prilvl", req.getParameter("privilege"));
		}
		
		return forword("label/shop/mng", context);
	}
	
	@RequestMapping(value = "/downLoadFile")
	public void downLoadFile(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		File tmpFile = null;
		try {
			
			WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
			ServletContext servletContext = webApplicationContext.getServletContext();
			String logoPath = servletContext.getRealPath("/") + "img/goodsExtensionLogo.png";
			ShopEntity shop = gradeMngService.queryByGradeId(staffEntity.getGradeId() + "", staffEntity.getToken());
			if (shop != null && shop.getQrcodeLogo() != null) {
				URL url = new URL(shop.getQrcodeLogo());
				String suffix = shop.getQrcodeLogo().indexOf(".") != -1 ? shop.getQrcodeLogo()
						.substring(shop.getQrcodeLogo().lastIndexOf("."), shop.getQrcodeLogo().length()) : null;
				String tmpFileName = UUID.randomUUID().toString() + suffix;
				tmpFile = new File(servletContext.getRealPath("/") + "fileUpload/" + tmpFileName);
				FileUtil.inputStreamToFile(url.openStream(), tmpFile);
				logoPath = tmpFile.getPath();
			}
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
			//设置DPI300 java生成图片默认DPI72 不适用于打印
			ImageUtil.handleDpi(QrCodeFile, 300, 300);
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
		} finally {
			if (tmpFile != null) {
				// 将临时文件删除
				File del = new File(tmpFile.toURI());
				del.delete();
			}
		}
	}
}
