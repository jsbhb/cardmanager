package com.card.manager.factory.label.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.base.PageCallBack;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.goods.model.GoodsEntity;
import com.card.manager.factory.goods.model.GoodsItemEntity;
import com.card.manager.factory.goods.service.GoodsItemService;
import com.card.manager.factory.system.model.GradeEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.service.GradeMngService;
import com.card.manager.factory.util.FileDownloadUtil;
import com.card.manager.factory.util.QrCodeUtil;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

@Controller
@RequestMapping("/admin/label/goodsQRMng")
public class GoodsQRMngController extends BaseController {
	
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
				tmpLink = entity.getMobileUrl() + "/goodsDetail.html?shopId=" + staffEntity.getGradeId() + "&goodsId=";
				//根据获取到的域名进行商品二维码内容的拼接
				//内容格式：域名+商品明细地址+centerId+shopId+goodsId
				//http://shop1.cncoopbuy.com/goodsDetail.html?centerId=13&shopId=15&goodsId=1002
//				if (staffEntity.getGradeLevel() == 2) {
//					tmpLink = entity.getMobileUrl() + "/goodsDetail.html?goodsId=";
//					tmpLink = entity.getRedirectUrl() + "goodsDetail.html?goodsId=";
//				} else if (staffEntity.getGradeLevel() == 3) {
//					tmpLink = entity.getMobileUrl() + "/goodsDetail.html?shopId=" + staffEntity.getShopId() + "&goodsId=";
//					tmpLink = entity.getRedirectUrl() + "goodsDetail.html?shopId=" + staffEntity.getShopId() + "&goodsId=";
//				}
			}
			
			@SuppressWarnings("unchecked")
			List<GoodsEntity> list = (List<GoodsEntity>) pcb.getObj();
			for (GoodsEntity gEntity : list) {
				if (tmpLink == "") {
					gEntity.setDetailPath("");
				} else {
					gEntity.setDetailPath(tmpLink + gEntity.getGoodsId());
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
		try {
			String goodsId = req.getParameter("goodsId");
			String goodsPath = req.getParameter("path");
//			if (StringUtil.isEmpty(goodsId)) {
//				sendFailureMessage(resp, "操作失败：没有商品编号");
//				return;
//			}
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
