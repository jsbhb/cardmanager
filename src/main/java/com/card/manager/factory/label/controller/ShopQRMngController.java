package com.card.manager.factory.label.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.goods.service.GoodsItemService;
import com.card.manager.factory.system.model.GradeEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.service.GradeMngService;
import com.card.manager.factory.util.QrCodeUtil;
import com.card.manager.factory.util.SessionUtils;

@Controller
@RequestMapping("/admin/label/shopQRMng")
public class ShopQRMngController extends BaseController {
	
	@Resource
	GoodsItemService goodsItemService;
	
	@Resource
	GradeMngService gradeMngService;

	@RequestMapping(value = "/mng")
	public ModelAndView mngList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		
		//根据账号信息获取对应的分级地址
		String gradeId = "";
		if (opt.getGradeLevel() == 2) {
			gradeId = opt.getGradeId()+"";
		} else if (opt.getGradeLevel() == 3) {
			gradeId = opt.getParentGradeId()+"";
		} else {
			gradeId = "1";
		}

		GradeEntity entity = gradeMngService.queryById(gradeId, opt.getToken());
		String strLink = "";
		if (entity != null) {
			if (opt.getGradeLevel() == 3) {
				strLink = entity.getMobileUrl() + "/index.html?shopId=" + opt.getShopId();
			}
		}
		context.put("strLink", strLink);
		
		return forword("label/shop/mng", context);
	}
	
	@RequestMapping(value = "/downLoadFile")
	public void downLoadFile(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String goodsPath = req.getParameter("path");
			String filePath = QrCodeUtil.checkOrCreateShop(staffEntity.getBadge(), goodsPath);
			String fileName = staffEntity.getBadge() + ".jpg";
			
			req.setCharacterEncoding("UTF-8");
		    //第一步：设置响应类型
		    resp.setContentType("application/force-download");//应用程序强制下载
		    InputStream in = new FileInputStream(filePath);
		    //设置响应头，对文件进行url编码
		    fileName = URLEncoder.encode(fileName, "UTF-8");
		    resp.setHeader("Content-Disposition", "attachment;filename="+fileName);   
		    resp.setContentLength(in.available());
		    
		    //第三步：老套路，开始copy
		    OutputStream out = resp.getOutputStream();
		    byte[] b = new byte[4096];
		    int len = 0;
		    while((len = in.read(b))!=-1){
		      out.write(b, 0, len);
		    }
		    out.flush();
		    out.close();
		    in.close();
		    
		    
//			File obj = null;
//	    	obj = new File(filePath);
//	    	
//	    	String fileName = goodsId + ".jpg";
//	    	ServletOutputStream out = resp.getOutputStream();
//	    	resp.setContentType("application/OCTET-STREAM;charset=utf-8");
//	    	fileName = fileName.trim();
//	    	resp.setHeader("Content-disposition", "attachment;filename="
//	    						+ new String(filePath.getBytes("gb2312"), "ISO-8859-1")
//	    						+ "");
//	    	BufferedInputStream bis = null;
//	    	BufferedOutputStream bos = null;
//	    	try {
//		    	bis = new BufferedInputStream(new FileInputStream(obj));
//		    	bos = new BufferedOutputStream(out);
//		    	byte[] buff = new byte[4096];
//		    	int bytesRead = bis.read(buff, 0, buff.length);
//		    	while (-1 != bytesRead) {
//		    		bos.write(buff, 0, bytesRead);
//		    	}
//	    	} catch (IOException e) {
//	    		e.printStackTrace();  
//	    		throw e;
//	    	} catch (Exception e) {
//	    		e.printStackTrace();  
//	    		throw e;
//	    	} finally {
//		    	if (bis != null) {
//		    		bis.close();
//		    	}
//		    	if (bos != null) {
//		    		bos.close();
//		    	}
//		    }
		} catch (Exception e) {
			resp.setContentType("text/html;charset=utf-8");
			resp.getWriter().print("下载失败，请重试!");
			return;
			
//			sendFailureMessage(resp, "操作失败：" + e.getMessage());
//			return;
		}

//		sendSuccessMessage(resp, null);
	}
}
