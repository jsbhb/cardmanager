package com.card.manager.factory.label.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
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
import com.card.manager.factory.goods.model.FirstCatalogEntity;
import com.card.manager.factory.goods.model.GoodsBaseEntity;
import com.card.manager.factory.goods.model.GoodsEntity;
import com.card.manager.factory.goods.model.GoodsItemEntity;
import com.card.manager.factory.goods.model.SecondCatalogEntity;
import com.card.manager.factory.goods.model.ThirdCatalogEntity;
import com.card.manager.factory.goods.pojo.GoodsExtensionEntity;
import com.card.manager.factory.goods.service.GoodsBaseService;
import com.card.manager.factory.goods.service.GoodsItemService;
import com.card.manager.factory.goods.service.GoodsService;
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
	
	@Resource
	GoodsService goodsService;
	
	@Resource
	GoodsBaseService goodsBaseService;

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
			String goodsType = req.getParameter("goodsType");
			if (!StringUtil.isEmpty(goodsType)) {
				GoodsEntity goodsEntity = new GoodsEntity();
				goodsEntity.setType(Integer.parseInt(goodsType));
				item.setGoodsEntity(goodsEntity);
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
			GoodsEntity goodsInfo = goodsService.queryGoodsInfoByGoodsId(goodsId, staffEntity.getToken());
			GoodsBaseEntity base = goodsBaseService.queryById(goodsInfo.getBaseId()+"", staffEntity.getToken());
			
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
				tmpLink = entity.getMobileUrl();
				List<FirstCatalogEntity> first = CachePoolComponent.getFirstCatalog(staffEntity.getToken());
				List<SecondCatalogEntity> second = CachePoolComponent.getSecondCatalog(staffEntity.getToken());
				List<ThirdCatalogEntity> third = CachePoolComponent.getThirdCatalog(staffEntity.getToken());
				for (FirstCatalogEntity fce : first) {
					if (base.getFirstCatalogId().equals(fce.getFirstId())) {
						tmpLink = tmpLink + "/" + fce.getAccessPath();
						break;
					}
				}
				for (SecondCatalogEntity sce : second) {
					if (base.getSecondCatalogId().equals(sce.getSecondId())) {
						tmpLink = tmpLink + "/" + sce.getAccessPath();
						break;
					}
				}
				for (ThirdCatalogEntity tce : third) {
					if (base.getThirdCatalogId().equals(tce.getThirdId())) {
						tmpLink = tmpLink + "/" + tce.getAccessPath();
						break;
					}
				}
				tmpLink = entity.getMobileUrl() + "/" + goodsId + ".html?shopId=" + staffEntity.getGradeId();
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
