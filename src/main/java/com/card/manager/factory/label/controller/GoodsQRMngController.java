package com.card.manager.factory.label.controller;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
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
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.goods.model.FirstCatalogEntity;
import com.card.manager.factory.goods.model.GoodsEntity;
import com.card.manager.factory.goods.model.GoodsItemEntity;
import com.card.manager.factory.goods.model.SecondCatalogEntity;
import com.card.manager.factory.goods.model.ThirdCatalogEntity;
import com.card.manager.factory.goods.pojo.GoodsExtensionEntity;
import com.card.manager.factory.goods.service.GoodsItemService;
import com.card.manager.factory.shop.model.ShopEntity;
import com.card.manager.factory.system.model.GradeEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.service.GradeMngService;
import com.card.manager.factory.util.FileDownloadUtil;
import com.card.manager.factory.util.FileUtil;
import com.card.manager.factory.util.ImageUtil;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;
import com.card.manager.factory.util.ZXingCodeUtil;

@Controller
@RequestMapping("/admin/label/goodsQRMng")
public class GoodsQRMngController extends BaseController {
	
	private static String imgPath = "label/goodsExtension";
	
	@Resource
	GoodsItemService goodsItemService;
	
	@Resource
	GradeMngService gradeMngService;

//	@RequestMapping(value = "/mng")
//	public ModelAndView mngList(HttpServletRequest req, HttpServletResponse resp) {
//		Map<String, Object> context = getRootMap();
//		StaffEntity opt = SessionUtils.getOperator(req);
//		context.put("opt", opt);
//		return forword("label/goods/mng", context);
//	}

	@RequestMapping(value = "/mng")
//	@RequestMapping(value = "/list")
	public ModelAndView goodsItemList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {
			//context.put("suppliers", CachePoolComponent.getSupplier(opt.getToken()));
		} catch (Exception e) {
		}
		return forword("label/goods/list", context);
	}

	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack goodsItemdataList(HttpServletRequest req, HttpServletResponse resp, GoodsItemEntity item) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			//查询已上架状态的数据
			item.setStatus("1");
			
			String itemCode = req.getParameter("itemCode");
			if (!StringUtil.isEmpty(itemCode)) {
				item.setItemCode(itemCode);
			}
			String supplierId = req.getParameter("supplierId");
			if (!StringUtil.isEmpty(supplierId)) {
				item.setSupplierId(supplierId);
			}
			String goodsName = req.getParameter("goodsName");
			if (!StringUtil.isEmpty(goodsName)) {
				item.setGoodsName(goodsName);
			}
			String hidGoodsName = req.getParameter("hidGoodsName");
			if (!StringUtil.isEmpty(hidGoodsName)) {
				item.setGoodsName(hidGoodsName);
			}
			String sku = req.getParameter("sku");
			if (!StringUtil.isEmpty(sku)) {
				item.setSku(sku);
			}
			String goodsId = req.getParameter("goodsId");
			if (!StringUtil.isEmpty(goodsId)) {
				item.setGoodsId(goodsId);
			}
			String itemId = req.getParameter("itemId");
			if (!StringUtil.isEmpty(itemId)) {
				item.setItemId(itemId);
			}

			//根据账号信息获取对应的最上级分级ID
			int firstGradeId = gradeMngService.queryFirstGradeIdByOpt(staffEntity.getGradeId()+"");
			//如果是admin进入则显示海外购的内容
			if (firstGradeId == 0) {
				firstGradeId = 2;
			}
			GradeEntity entity = gradeMngService.queryById(firstGradeId+"", staffEntity.getToken());
			
			//总部账号不设置centerId
			//根据账号信息获取对应的分级地址
			params.put("gradeLevel", staffEntity.getGradeLevel());
			params.put("centerId", entity.getId());

			pcb = goodsItemService.dataList(item, params, staffEntity.getToken(),
					ServerCenterContants.GOODS_CENTER_ITEM_QUERY_FOR_PAGE_DOWNLOAD, GoodsEntity.class);
			
			String tmpLink = "";
			if (entity != null) {
				tmpLink = entity.getMobileUrl();
			}
			List<FirstCatalogEntity> first = CachePoolComponent.getFirstCatalog(staffEntity.getToken());
			List<SecondCatalogEntity> second = CachePoolComponent.getSecondCatalog(staffEntity.getToken());
			List<ThirdCatalogEntity> third = CachePoolComponent.getThirdCatalog(staffEntity.getToken());
			
			@SuppressWarnings("unchecked")
			List<GoodsEntity> list = (List<GoodsEntity>) pcb.getObj();
			for (GoodsEntity gEntity : list) {
				if (tmpLink == "") {
					gEntity.setDetailPath("");
				} else {
					tmpLink = entity.getMobileUrl();
					for (FirstCatalogEntity fce : first) {
						if (gEntity.getBaseEntity().getFirstCatalogId().equals(fce.getFirstId())) {
							tmpLink = tmpLink + "/" + fce.getAccessPath();
							break;
						}
					}
					for (SecondCatalogEntity sce : second) {
						if (gEntity.getBaseEntity().getSecondCatalogId().equals(sce.getSecondId())) {
							tmpLink = tmpLink + "/" + sce.getAccessPath();
							break;
						}
					}
					for (ThirdCatalogEntity tce : third) {
						if (gEntity.getBaseEntity().getThirdCatalogId().equals(tce.getThirdId())) {
							tmpLink = tmpLink + "/" + tce.getAccessPath();
							break;
						}
					}
					gEntity.setDetailPath(tmpLink + "/" + gEntity.getGoodsId() + ".html?shopId=" + staffEntity.getGradeId());
				}
			}
			
		} catch (ServerCenterNullDataException e) {
			if (pcb == null) {
				pcb = new PageCallBack();
			}
			pcb.setPagination(item);
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

	@RequestMapping(value = "/downLoadFile")
	public void downLoadFile(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		File tmpFile = null;
		try {
			String goodsId = req.getParameter("goodsId");
			GoodsExtensionEntity goodsExtensionInfo = goodsItemService.queryExtensionByGoodsId(goodsId, staffEntity.getToken());
			
			if (goodsExtensionInfo == null) {
				resp.setContentType("text/html;charset=utf-8");
				resp.getWriter().println("商品推广信息未维护，请先维护后再下载!");
				return;
			}
			
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
			QRPicPath = QRPicPath + "/" + goodsId + ".jpg";
			//生成二维码
			ZXingCodeUtil zXingCode=new ZXingCodeUtil();
			File logoFile = new File(logoPath);
	        QrCodeFile = new File(QRPicPath);
	        String url = req.getParameter("path");
	        String note = "";
	        zXingCode.drawLogoQRCode(logoFile, QrCodeFile, url, note);
	        //拼接模板文件
			ImageUtil.overlapImage(null, QRPicPath, goodsExtensionInfo, QRPicPath);
			//设置DPI300 java生成图片默认DPI72 不适用于打印
			ImageUtil.handleDpi(QrCodeFile, 300, 300);
			String filePath = QrCodeFile.toString();
			String fileName = goodsId + ".jpg";
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

	@RequestMapping(value = "/downLoadQRCodeFile")
	public void downLoadQRCodeFile(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		File tmpFile = null;
		try {
			String goodsId = req.getParameter("goodsId");
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
			QRPicPath = QRPicPath + "/" + goodsId + ".jpg";
			//生成二维码
			ZXingCodeUtil zXingCode=new ZXingCodeUtil();
			File logoFile = new File(logoPath);
	        QrCodeFile = new File(QRPicPath);
	        String url = req.getParameter("path");
	        String note = "";
	        zXingCode.drawLogoQRCode(logoFile, QrCodeFile, url, note);
			String filePath = QrCodeFile.toString();
			String fileName = goodsId + ".jpg";
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
