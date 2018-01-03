package com.card.manager.factory.mall.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.base.PageCallBack;
import com.card.manager.factory.base.Pagination;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.ftp.common.ReadIniInfo;
import com.card.manager.factory.ftp.service.SftpService;
import com.card.manager.factory.goods.model.DictData;
import com.card.manager.factory.goods.model.FirstCatalogEntity;
import com.card.manager.factory.goods.model.Layout;
import com.card.manager.factory.goods.model.PopularizeDict;
import com.card.manager.factory.goods.service.CatalogService;
import com.card.manager.factory.mall.pojo.FloorDictPojo;
import com.card.manager.factory.mall.pojo.PageTypeEnum;
import com.card.manager.factory.mall.pojo.PopularizeDictTypeEnum;
import com.card.manager.factory.mall.service.MallService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

@Controller
@RequestMapping("/admin/mall/indexMng")
public class MallMngController extends BaseController {

	@Resource
	MallService mallService;

	@Resource
	CatalogService catalogService;

	@Resource
	SftpService sftpService;

	@RequestMapping(value = "/mng")
	public ModelAndView toFuncList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("mall/index/mng", context);
	}

	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		return forword("mall/index/floor", context);
	}

	@RequestMapping(value = "/toAddFloor")
	public ModelAndView toAddDict(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);

		try {
			List<FirstCatalogEntity> catalogs = catalogService.queryFirstCatalogs(opt.getToken());
			context.put("firsts", catalogs);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword("error", context);
		}

		return forword("mall/index/floorAdd", context);
	}
	
	@RequestMapping(value = "/toEditFloor")
	public ModelAndView toShow(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {
			String id = req.getParameter("id");
			PopularizeDict entity = mallService.queryById(id, opt.getToken());
			context.put("dict", entity);
			return forword("mall/index/floorEdit", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
	}
	
	@RequestMapping(value = "/ad")
	public ModelAndView ad(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		context.put(OPT, staffEntity);

		Layout layout = new Layout();
		layout.setCode("module_00006");
		layout.setCenterId(staffEntity.getGradeId());

		List<DictData> dictDataList;
		try {
			dictDataList = mallService.queryDataAll(layout, staffEntity.getToken());
			context.put("dataList", dictDataList);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword("error", context);
		}

		return forword("mall/index/ad", context);
	}
	
	@RequestMapping(value = "/toEditAd")
	public ModelAndView toEditAd(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {
			String id = req.getParameter("id");
			PopularizeDict entity = mallService.queryById(id, opt.getToken());
			context.put("dict", entity);
			return forword("mall/index/adEdit", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
	}

	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, Pagination pagination) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			String code = req.getParameter("code");
			params.put("code", code);
			params.put("centerId", staffEntity.getGradeId());

			pcb = mallService.dataList(pagination, params, staffEntity.getToken(),
					ServerCenterContants.GOODS_CENTER_MALL_QUERY_DICT_FOR_PAGE, PopularizeDict.class);
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

	@RequestMapping(value = "/dataListForData", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataListForOrderGoods(HttpServletRequest req, HttpServletResponse resp, Pagination pagination) {
		PageCallBack pcb = null;
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			String dictId = req.getParameter("dictId");
			params.put("centerId", staffEntity.getGradeId());
			params.put("dictId", dictId);

			pcb = mallService.dataList(pagination, params, staffEntity.getToken(),
					ServerCenterContants.GOODS_CENTER_MALL_QUERY_DATA_FOR_PAGE, DictData.class);
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


	@RequestMapping(value = "/saveDict", method = RequestMethod.POST)
	public void save(HttpServletRequest req, HttpServletResponse resp, @RequestBody FloorDictPojo pojo) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		pojo.setOpt(staffEntity.getOptid());
		pojo.setCenterId(staffEntity.getGradeId());

		try {

			mallService.addDict(pojo, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
	public void uploadFile(@RequestParam("pic") MultipartFile pic, HttpServletRequest req, HttpServletResponse resp) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		ReadIniInfo iniInfo = new ReadIniInfo();

		// try {
		// sftpService.login(iniInfo);
		// } catch (Exception e2) {
		// sendFailureMessage(resp, "操作失败：无法连接sftp：" + iniInfo.getFtpServer() +
		// ":" + iniInfo.getFtpPort());
		// return;
		// }

		try {
			if (pic != null) {
				String fileName = pic.getOriginalFilename();
				// 当前上传文件的文件后缀
				String suffix = fileName.indexOf(".") != -1
						? fileName.substring(fileName.lastIndexOf("."), fileName.length()) : null;

				if (!".png".equalsIgnoreCase(suffix) && !".jpg".equalsIgnoreCase(suffix)
						&& !".jpeg".equalsIgnoreCase(suffix)) {
					sendFailureMessage(resp, "文件格式有误！");
					return;
				}

				// 如果名称不为“”,说明该文件存在，否则说明该文件不存在
				if (!StringUtils.isBlank(fileName)) {
					// 重命名上传后的文件名
					String saveFileName = System.currentTimeMillis() + suffix;
					// 定义上传路径
					String savePath = "/opt/static/images/";
					// 当前上传文件信息

					// sftpService.uploadFile(savePath, saveFileName,
					// pic.getInputStream(), iniInfo,
					// staffEntity.getGradeId() + "");
					// sftpService.logout();
					sendSuccessMessage(resp, "http://" + iniInfo.getFtpServer() + ":8080" + savePath
							+ staffEntity.getGradeId() + "/" + saveFileName);
				} else {
					sendFailureMessage(resp, "操作失败：没有文件信息");
				}

			}

		} catch (Exception e) {
			try {
				sftpService.logout();
			} catch (Exception e1) {
				sendFailureMessage(resp, "操作失败：" + e1.getMessage());
				return;
			}
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

	}

	@RequestMapping(value = "/saveData", method = RequestMethod.POST)
	public void save(HttpServletRequest req, HttpServletResponse resp, @RequestBody DictData data) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		data.setOpt(staffEntity.getOptid());
		try {
			mallService.addData(data, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/delateDict", method = RequestMethod.POST)
	public void delateDict(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String id = req.getParameter("id");
			mallService.delateDict(id, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/delateData", method = RequestMethod.POST)
	public void delateData(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String id = req.getParameter("id");
			mallService.delateData(id, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/init", method = RequestMethod.POST)
	public void init(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);

		String module = req.getParameter("module");
		if (StringUtil.isEmpty(module)) {
			sendFailureMessage(resp, "操作失败：没有模块编码");
			return;
		}

		try {
			Layout layout = new Layout();
			layout.setCode(module);
			layout.setOpt(staffEntity.getOptid());
			if ("module_00006".equals(module)) {
				layout.setPageType(PageTypeEnum.PC.getIndex());
			} else {
				layout.setPageType(PageTypeEnum.H5.getIndex());
			}

			layout.setShow(1);
			layout.setType(0);
			layout.setPage("index");
			layout.setCenterId(staffEntity.getGradeId());

			PopularizeDict dict = new PopularizeDict();
			dict.setCenterId(staffEntity.getGradeId());
			dict.setType(PopularizeDictTypeEnum.NORMAL.getIndex());
			dict.setLayout(layout);
			dict.setCenterId(staffEntity.getGradeId());

			mallService.initDict(dict, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

}
