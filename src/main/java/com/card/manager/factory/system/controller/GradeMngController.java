package com.card.manager.factory.system.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
import com.card.manager.factory.base.Pagination;
import com.card.manager.factory.common.AuthCommon;
import com.card.manager.factory.common.ResourceContants;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.component.model.GradeBO;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.goods.grademodel.GradeTypeDTO;
import com.card.manager.factory.goods.service.GoodsService;
import com.card.manager.factory.system.model.CustomerTypeEntity;
import com.card.manager.factory.system.model.GradeEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.service.GradeMngService;
import com.card.manager.factory.system.service.StaffMngService;
import com.card.manager.factory.util.DateUtil;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;
import com.github.pagehelper.Page;

@Controller
@RequestMapping("/admin/system/gradeMng")
public class GradeMngController extends BaseController {

	@Resource
	GradeMngService gradeMngService;

	@Resource
	StaffMngService staffMngService;

	@Resource
	GoodsService goodsService;

	@RequestMapping(value = "/mng")
	public ModelAndView toFuncList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("system/grade/gradeMng", context);
	}

	@RequestMapping(value = "/toAdd")
	public ModelAndView add(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		List<StaffEntity> GradeCharge = CachePoolComponent.getGradePersoninCharge(opt.getToken());
		if (opt.getGradeType() == 0) {
			List<GradeTypeDTO> gradeList = goodsService.queryGradeType(null, opt.getToken());
			context.put("gradeList", gradeList);
		} else {
			List<GradeTypeDTO> gradeList = goodsService.queryGradeTypeChildren(opt.getGradeType() + "", opt.getToken());
			context.put("gradeList", gradeList);
		}
		if (opt.getGradeLevel() == 1) {
			context.put("charges", GradeCharge);
		} else {
			GradeCharge.clear();
			GradeCharge.add(opt);
			context.put("charges", GradeCharge);
		}
		context.put("opt", opt);
		List<CustomerTypeEntity> customerTypeList = CachePoolComponent.getCustomerType();
		context.put("customerTypeList", customerTypeList);

		if (opt.getGradeType() == 0 || opt.getGradeType() == 1) {
			context.put("urlShow", "true");
		} else {
			context.put("urlShow", "false");
		}
		if (opt.getGradeId() == 0 || opt.getGradeId() == 2) {
			context.put("showShopExtensionFlg", "true");
		} else {
			context.put("showShopExtensionFlg", "false");
		}

		// 自动产生业务流水号：tmp+GradeId+账号+时间+4位随机数
		Integer num = (int) (Math.random() * 9000) + 1000;
		String key = "";
		try {
			key = "tmpGradeId" + opt.getBadge() + DateUtil.getNowPlusTimeMill() + num;
		} catch (Exception e) {
			e.printStackTrace();
			key = "tmpGradeId" + opt.getBadge() + num;
		}
		context.put("key", key);
		return forword("system/grade/add", context);
	}

	@RequestMapping(value = "/addGrade", method = RequestMethod.POST)
	public void addGrade(HttpServletRequest req, HttpServletResponse resp, @RequestBody GradeEntity gradeInfo) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		String backStr = "";
		try {
			// 判断域名是否以/结尾 如果是去掉/
			String tmpUrl = "";
			String tmpLastStr = "";
			if (gradeInfo.getRedirectUrl() != null) {
				tmpUrl = gradeInfo.getRedirectUrl();
				tmpLastStr = tmpUrl.substring(tmpUrl.length() - 1, tmpUrl.length());
				if (tmpLastStr.equals("/")) {
					gradeInfo.setRedirectUrl(tmpUrl.substring(0, tmpUrl.length() - 1));
				}
			}
			if (gradeInfo.getMobileUrl() != null) {
				tmpUrl = gradeInfo.getMobileUrl();
				tmpLastStr = tmpUrl.substring(tmpUrl.length() - 1, tmpUrl.length());
				if (tmpLastStr.equals("/")) {
					gradeInfo.setMobileUrl(tmpUrl.substring(0, tmpUrl.length() - 1));
				}
			}
			gradeMngService.saveGrade(gradeInfo, staffEntity);
			if (gradeInfo.getId() == null || gradeInfo.getId() <= 0) {
				sendFailureMessage(resp, "新增分级时图片保存失败，未获取到对应的分级编号！");
				return;
			}
			String tmpPicPath = gradeInfo.getPicPath1();
			tmpPicPath = tmpPicPath.substring(tmpPicPath.indexOf("tmp"),
					tmpPicPath.indexOf("/", tmpPicPath.indexOf("tmp")));
			String tmpBasePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.GRADE + "/";
			backStr = tmpBasePath + tmpPicPath + "|" + tmpBasePath + gradeInfo.getId();
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, backStr);
	}

	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		if (opt.getGradeType() == 0) {
			List<GradeTypeDTO> gradeList = goodsService.queryGradeType(null, opt.getToken());
			context.put("gradeList", gradeList);
		} else {
			List<GradeTypeDTO> gradeList = goodsService.queryGradeTypeChildren(opt.getGradeType() + "", opt.getToken());
			context.put("gradeList", gradeList);
		}
		return forword("system/grade/list", context);
	}

	/**
	 * @fun 根据gradeId 获取对应的下级的gradeType
	 * @param req
	 * @param resp
	 */
	@RequestMapping(value = "/listGradeType")
	public void listGradeType(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		String gradeId = req.getParameter("id");
		context.put("opt", opt);
		List<GradeTypeDTO> gradeList = gradeMngService.queryGradeTypeChildren(gradeId, opt.getToken());
		sendSuccessObject(resp, gradeList);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, GradeEntity entity) {
		PageCallBack pcb = null;

		Map<String, Object> params = new HashMap<String, Object>();
		String gradeName = req.getParameter("gradeName");
		if (!StringUtil.isEmpty(gradeName)) {
			entity.setGradeName(gradeName);
		}
		String gradeType = req.getParameter("gradeType");
		if (!StringUtil.isEmpty(gradeType)) {
			entity.setGradeType(Integer.parseInt(gradeType));
		}
		String company = req.getParameter("company");
		if (!StringUtil.isEmpty(company)) {
			entity.setCompany(company);
		}
		String phone = req.getParameter("phone");
		if (!StringUtil.isEmpty(phone)) {
			entity.setPhone(phone);
		}

		StaffEntity opt = SessionUtils.getOperator(req);

		if (opt.getRoleId() != AuthCommon.SUPER_ADMIN) {
			int id = opt.getGradeId();
			if (id != AuthCommon.EARA_ADMIN) {
				entity.setId(id);
			}
		}

		try {
			pcb = gradeMngService.dataList(entity, params, opt.getToken(),
					ServerCenterContants.USER_CENTER_GRADE_QUERY_FOR_PAGE, GradeEntity.class);

			if (opt.getRoleId() != AuthCommon.SUPER_ADMIN) {
				int id = opt.getGradeId();
				if (id != AuthCommon.EARA_ADMIN) {
					if (pcb != null) {
						List<GradeEntity> list = (List<GradeEntity>) pcb.getObj();
						for (GradeEntity ge : list) {
							String tmpGradeTypeName = ge.getGradeTypeName();
							if (tmpGradeTypeName.indexOf("（") != -1) {
								tmpGradeTypeName = tmpGradeTypeName.substring(0, tmpGradeTypeName.indexOf("（"));
							}
							if (tmpGradeTypeName.indexOf("(") != -1) {
								tmpGradeTypeName = tmpGradeTypeName.substring(0, tmpGradeTypeName.indexOf("("));
							}
							ge.setGradeTypeName(tmpGradeTypeName);
						}
						pcb.setObj(list);
					}
				}
			}
		} catch (ServerCenterNullDataException e) {
			if (pcb == null) {
				pcb = new PageCallBack();
			}
			pcb.setPagination(entity);
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

	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		List<StaffEntity> GradeCharge = CachePoolComponent.getGradePersoninCharge(opt.getToken());
		String gradeId = req.getParameter("gradeId");
		if (opt.getGradeLevel() == 1) {
			context.put("charges", GradeCharge);
		} else {
			if (gradeId.equals(opt.getGradeId() + "")) {
				context.put("charges", GradeCharge);
			} else {
				List<StaffEntity> tmpGradeCharge = new ArrayList<StaffEntity>();
				tmpGradeCharge.clear();
				tmpGradeCharge.add(opt);
				context.put("charges", tmpGradeCharge);
			}
		}
		context.put("opt", opt);
		if (opt.getGradeType() == 0) {
			List<GradeTypeDTO> gradeList = goodsService.queryGradeType(null, opt.getToken());
			context.put("gradeList", gradeList);
		} else {
			List<GradeTypeDTO> gradeList = goodsService.queryGradeTypeChildren(opt.getGradeType() + "", opt.getToken());
			context.put("gradeList", gradeList);
		}
		try {
			GradeEntity entity = gradeMngService.queryById(gradeId, opt.getToken());
			if (entity.getWelfareRebate() == null) {
				entity.setWelfareRebate(0.0);
			}
			context.put("grade", entity);
			GradeTypeDTO gradeType = goodsService.queryGradeTypeById(entity.getGradeType() + "", opt.getToken());
			context.put("gradeType", gradeType);
			List<CustomerTypeEntity> customerTypeList = CachePoolComponent.getCustomerType();
			context.put("customerTypeList", customerTypeList);

			StaffEntity editStaff = staffMngService.queryStaffInfoByGradeId(gradeId);
			context.put("editStaff", editStaff);
		} catch (Exception e) {
			context.put("error", e.getMessage());
			return forword("error", context);
		}
		context.put("editFlg", "true");
		if (opt.getGradeType() == 0 || opt.getGradeType() == 1) {
			context.put("urlShow", "true");
		} else {
			context.put("urlShow", "false");
			if (gradeId.equals(opt.getGradeId() + "")) {
				context.put("editFlg", "false");
			}
		}
		if (opt.getGradeId() == 0 || opt.getGradeId() == 2) {
			context.put("showShopExtensionFlg", "true");
		} else {
			context.put("showShopExtensionFlg", "false");
		}
		return forword("system/grade/edit", context);
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public void update(HttpServletRequest req, HttpServletResponse resp, @RequestBody GradeEntity gradeInfo) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			// 判断域名是否以/结尾 如果是去掉/
			String tmpUrl = "";
			String tmpLastStr = "";
			if (gradeInfo.getRedirectUrl() != null) {
				tmpUrl = gradeInfo.getRedirectUrl();
				tmpLastStr = tmpUrl.substring(tmpUrl.length() - 1, tmpUrl.length());
				if (tmpLastStr.equals("/")) {
					gradeInfo.setRedirectUrl(tmpUrl.substring(0, tmpUrl.length() - 1));
				}
			}
			if (gradeInfo.getMobileUrl() != null) {
				tmpUrl = gradeInfo.getMobileUrl();
				tmpLastStr = tmpUrl.substring(tmpUrl.length() - 1, tmpUrl.length());
				if (tmpLastStr.equals("/")) {
					gradeInfo.setMobileUrl(tmpUrl.substring(0, tmpUrl.length() - 1));
				}
			}
			GradeBO grade = CachePoolComponent.getGrade(staffEntity.getToken()).get(gradeInfo.getId());
			gradeInfo.setWelfareType(grade.getWelfareType());
			gradeInfo.setWelfareRebate(grade.getWelfareRebate());
			gradeMngService.updateGrade(gradeInfo, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/syncStaff", method = RequestMethod.POST)
	public void syncStaff(HttpServletRequest req, HttpServletResponse resp) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String gradeId = req.getParameter("gradeId");
			GradeEntity grade = gradeMngService.queryById(gradeId, staffEntity.getToken());
			staffEntity = new StaffEntity();
			staffEntity.setGradeName(grade.getGradeName());
			staffEntity.setParentGradeId(grade.getParentId());
			staffEntity.setOptName(grade.getPersonInCharge());
			staffEntity.setGradeId(grade.getId());
			staffEntity.setUserCenterId(grade.getPersonInChargeId());
			gradeMngService.registerAuthCenter(staffEntity, false);
			;
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/dataListForGrade")
	@ResponseBody
	public PageCallBack dataListForGrade(Pagination pagination, HttpServletRequest req, HttpServletResponse resp) {
		PageCallBack pcb = new PageCallBack();

		try {
			String id = req.getParameter("gradeId");
			StaffEntity entity = SessionUtils.getOperator(req);
			Page<StaffEntity> page = null;
			Map<String, Object> params = new HashMap<String, Object>();

			if (id != null && !"".equals(id)) {
				params.put("gradeId", Integer.parseInt(id));
			} else if (entity.getRoleId() != AuthCommon.SUPER_ADMIN) {
				params.put("gradeId", entity.getGradeId());
			}

			page = staffMngService.dataList(pagination, params);

			pcb.setObj(page);
			pcb.setSuccess(true);
			pcb.setPagination(webPageConverter(page));
		} catch (Exception e) {
			pcb.setErrTrace(e.getMessage());
			pcb.setSuccess(false);
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return pcb;
		}

		return pcb;
	}

	@RequestMapping(value = "/init", method = RequestMethod.POST)
	public void gradeInit(HttpServletRequest req, HttpServletResponse resp) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			Integer id = Integer.valueOf(req.getParameter("id"));
			gradeMngService.gradeInit(id, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}
}
