package com.card.manager.factory.label.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
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
import com.card.manager.factory.util.QrCodeUtil;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

@Controller
@RequestMapping("/admin/label/goodsExtensionMng")
public class GoodsExtensionMngController extends BaseController {
	
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
//			goodsService.updGoodsInfoEntity(entity, staffEntity);
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
			String goodsPath = req.getParameter("path");
			String filePath = QrCodeUtil.checkOrCreate(staffEntity.getBadge(), goodsId, goodsPath);
			String fileName = goodsId + ".jpg";
			
			FileDownloadUtil.downloadFileByBrower(req, resp, filePath, fileName);
		} catch (Exception e) {
			resp.setContentType("text/html;charset=utf-8");
			resp.getWriter().println("下载失败，请重试!");
			resp.getWriter().println(e.getMessage());
			return;
		}
	}
}
