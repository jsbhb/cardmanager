package com.card.manager.factory.label.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.goods.model.GoodsItemEntity;
import com.card.manager.factory.goods.pojo.GoodsExtensionEntity;
import com.card.manager.factory.goods.service.GoodsItemService;
import com.card.manager.factory.system.model.GradeEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.service.GradeMngService;
import com.card.manager.factory.util.FileDownloadUtil;
import com.card.manager.factory.util.ImageUtil;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;
import com.card.manager.factory.util.ZXingCodeUtil;

@Controller
@RequestMapping("/admin/label/goodsExtensionMng")
public class GoodsExtensionMngController extends BaseController {
	
	private static String imgPath = "label/goodsExtension";
	
	@Resource
	GoodsItemService goodsItemService;
	
	@Resource
	GradeMngService gradeMngService;

	@RequestMapping(value = "/mng")
	public ModelAndView goodsList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		return forword("label/goodsExtension/list", context);
	}

	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack goodsdataList(HttpServletRequest req, HttpServletResponse resp, GoodsItemEntity item) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			//查询已上架状态的数据
			item.setStatus("1");
			
			String goodsName = req.getParameter("goodsName");
			if (!StringUtil.isEmpty(goodsName)) {
				item.setGoodsName(goodsName);
			}
			String hidGoodsName = req.getParameter("hidGoodsName");
			if (!StringUtil.isEmpty(hidGoodsName)) {
				item.setGoodsName(hidGoodsName);
			}
			String goodsId = req.getParameter("goodsId");
			if (!StringUtil.isEmpty(goodsId)) {
				item.setGoodsId(goodsId);
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
					ServerCenterContants.GOODS_CENTER_EXTENSION_QUERY_FOR_PAGE_DOWNLOAD, GoodsExtensionEntity.class);
			
//			String tmpLink = "";
//			if (entity != null) {
//				tmpLink = entity.getMobileUrl() + "/goodsDetail.html?shopId=" + staffEntity.getGradeId() + "&goodsId=";
//				//根据获取到的域名进行商品二维码内容的拼接
//				//内容格式：域名+商品明细地址+centerId+shopId+goodsId
//				//http://shop1.cncoopbuy.com/goodsDetail.html?centerId=13&shopId=15&goodsId=1002
//				if (staffEntity.getGradeLevel() == 2) {
//					tmpLink = entity.getMobileUrl() + "/goodsDetail.html?goodsId=";
//					tmpLink = entity.getRedirectUrl() + "goodsDetail.html?goodsId=";
//				} else if (staffEntity.getGradeLevel() == 3) {
//					tmpLink = entity.getMobileUrl() + "/goodsDetail.html?shopId=" + staffEntity.getShopId() + "&goodsId=";
//					tmpLink = entity.getRedirectUrl() + "goodsDetail.html?shopId=" + staffEntity.getShopId() + "&goodsId=";
//				}
//			}
			
//			@SuppressWarnings("unchecked")
//			List<GoodsEntity> list = (List<GoodsEntity>) pcb.getObj();
//			for (GoodsEntity gEntity : list) {
//				if (tmpLink == "") {
//					gEntity.setDetailPath("");
//				} else {
//					gEntity.setDetailPath(tmpLink + gEntity.getGoodsId());
//				}
//			}
			
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
	
	@RequestMapping(value = "/toEditInfo")
	public ModelAndView toEditInfo(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String goodsId = req.getParameter("goodsId");
			GoodsExtensionEntity goodsExtensionInfo = goodsItemService.queryExtensionByGoodsId(goodsId, staffEntity.getToken());
			if (goodsExtensionInfo == null) {
				goodsExtensionInfo = new GoodsExtensionEntity();
				goodsExtensionInfo.setGoodsId(goodsId);
			}
			context.put("goodsExtensionInfo", goodsExtensionInfo);
			context.put("brands", CachePoolComponent.getBrands(staffEntity.getToken()));
			return forword("label/goodsExtension/edit", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
	}

	@RequestMapping(value = "/editGoodsInfo", method = RequestMethod.POST)
	public void editGoodsInfo(HttpServletRequest req, HttpServletResponse resp,
			@RequestBody GoodsExtensionEntity entity) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		entity.setOpt(staffEntity.getOptid());
		try {
			goodsItemService.updGoodsExtensionInfoEntity(entity, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/downLoadFile")
	public void downLoadFile(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String goodsId = req.getParameter("goodsId");
			GoodsExtensionEntity goodsExtensionInfo = goodsItemService.queryExtensionByGoodsId(goodsId, staffEntity.getToken());
			
			//根据账号信息获取对应的最上级分级ID
			int firstGradeId = gradeMngService.queryFirstGradeIdByOpt(staffEntity.getGradeId()+"");
			//如果是admin进入则显示海外购的内容
			if (firstGradeId == 0) {
				firstGradeId = 2;
			}
			GradeEntity entity = gradeMngService.queryById(firstGradeId+"", staffEntity.getToken());
			
			String tmpLink = "";
			if (entity != null) {
				tmpLink = entity.getMobileUrl() + "/goodsDetail.html?shopId=" + staffEntity.getGradeId() + "&goodsId=" + goodsId;
				//根据获取到的域名进行商品二维码内容的拼接
				//内容格式：域名+商品明细地址+centerId+shopId+goodsId
				//http://shop1.cncoopbuy.com/goodsDetail.html?centerId=13&shopId=15&goodsId=1002
//				if (staffEntity.getGradeLevel() == 2) {
//					tmpLink = entity.getMobileUrl() + "/goodsDetail.html?goodsId=" + goodsId;
//					tmpLink = entity.getRedirectUrl() + "goodsDetail.html?goodsId=" + goodsId;
//				} else if (staffEntity.getGradeLevel() == 3) {
//					tmpLink = entity.getMobileUrl() + "/goodsDetail.html?shopId=" + staffEntity.getShopId() + "&goodsId=" + goodsId;
//					tmpLink = entity.getRedirectUrl() + "goodsDetail.html?shopId=" + staffEntity.getShopId() + "&goodsId=" + goodsId;
//				}
			}
			
			
			WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
			ServletContext servletContext = webApplicationContext.getServletContext();
			String logoPath = servletContext.getRealPath("/") + "img/goodsExtensionLogo.png";
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
	        String url = tmpLink;
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
		}
	}
}
