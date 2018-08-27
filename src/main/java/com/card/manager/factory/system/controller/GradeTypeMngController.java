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
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.exception.ServerCenterNullDataException;
import com.card.manager.factory.goods.grademodel.GradeTypeDTO;
import com.card.manager.factory.goods.service.GoodsService;
import com.card.manager.factory.system.model.GradeTypeEntity;
import com.card.manager.factory.system.model.RebateFormula;
import com.card.manager.factory.system.model.RoleEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.service.GradeTypeMngService;
import com.card.manager.factory.system.service.RoleMngService;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

@Controller
@RequestMapping("/admin/system/gradeType")
public class GradeTypeMngController extends BaseController {

	private static final String TYPE_ADD = "0";
	private static final String TYPE_EDIT = "1";

	@Resource
	RoleMngService roleMngService;

	@Resource
	GoodsService goodsService;

	@Resource
	RoleMngService roleService;

	@Resource
	GradeTypeMngService gradeTypeService;

	@RequestMapping(value = "/list")
	public ModelAndView toSetRebate(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);

		try {
			List<GradeTypeDTO> gradeList = goodsService.queryGradeType(null, opt.getToken());
			context.put("gradeList", gradeList);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword("error", context);
		}

		return forword("system/gradeType/list", context);
	}

	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		try {

			String id = req.getParameter("id");
			String parentId = req.getParameter("parentId");

			if (StringUtil.isEmpty(parentId)) {
				context.put(MSG, "没有父分类编号！");
				return forword("error", context);
			}
			String type = req.getParameter("type");

			List<RoleEntity> roleList = roleMngService.queryAll();
			context.put("roles", roleList);

			if (TYPE_ADD.equals(type)) {
				GradeTypeDTO parentGrade = goodsService.queryGradeTypeById(id, opt.getToken());
				req.setAttribute("parentGradeTypeDTO", parentGrade);
				return forword("system/gradeType/add", context);
			}

			if (TYPE_EDIT.equals(type)) {
				if (!"1".equals(id)) {
					GradeTypeDTO parentGrade = goodsService.queryGradeTypeById(parentId, opt.getToken());
					req.setAttribute("parentGradeTypeDTO", parentGrade);
				}

				Integer roleId = roleService.getRoleIdByGradeTypeId(Integer.parseInt(id));
				GradeTypeDTO grade = goodsService.queryGradeTypeById(id, opt.getToken());
				req.setAttribute("GradeTypeDTO", grade);
				req.setAttribute("parentId", parentId);
				req.setAttribute("roleId", roleId);
				return forword("system/gradeType/edit", context);
			}

			context.put(MSG, "没有操作类型信息！");
			return forword("error", context);
		} catch (Exception e) {
			e.printStackTrace();
			return forword("error", context);
		}
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void save(HttpServletRequest req, HttpServletResponse resp, @RequestBody GradeTypeEntity entity) {

		try {
			gradeTypeService.save(entity, SessionUtils.getOperator(req));
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public void edit(HttpServletRequest req, HttpServletResponse resp, @RequestBody GradeTypeEntity entity) {

		try {
			gradeTypeService.update(entity, SessionUtils.getOperator(req));
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public void delete(HttpServletRequest req, HttpServletResponse resp) {

		String id = req.getParameter("id");
		if (id == null || "".equals(id)) {
			sendFailureMessage(resp, "删除失败，没有选择对应模块或者节点！");
			return;
		}
		try {
			gradeTypeService.delete(id, SessionUtils.getOperator(req));
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/typerebate/toAdd")
	public ModelAndView toAddGradeTypeRebate(HttpServletRequest req, HttpServletResponse resp) {

		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		try {
			Map<Integer, GradeTypeDTO> gradeTypeMap = CachePoolComponent.getGradeType(opt.getToken());
			List<GradeTypeDTO> list = new ArrayList<GradeTypeDTO>();
			for (GradeTypeDTO dto : gradeTypeMap.values()) {
				if(dto.getId() != 2){
					list.add(dto);
				}
			}
			context.put("gradeTypeList", list);
			return forword("system/gradeType/rebateformula/add", context);

		} catch (Exception e) {
			e.printStackTrace();
			return forword("error", context);
		}
	}

	@RequestMapping(value = "/typerebate/toEdit")
	public ModelAndView toEditGradeTypeRebate(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		try {
			StaffEntity opt = SessionUtils.getOperator(req);
			String id = req.getParameter("id");
			RebateFormula rebateFormula = gradeTypeService.queryGradeTypeRebateFormulaById(id, opt.getToken());
			context.put("rebateFormula", rebateFormula);
			return forword("system/gradeType/rebateformula/edit", context);
		} catch (Exception e) {
			e.printStackTrace();
			context.put(MSG, e.getMessage());
			return forword("error", context);
		}
	}

	@RequestMapping(value = "/typerebate/edit", method = RequestMethod.POST)
	public void updateGradeTypeRebate(HttpServletRequest req, HttpServletResponse resp,
			@RequestBody RebateFormula entity) {
		try {
			StaffEntity opt = SessionUtils.getOperator(req);
			entity.setOpt(opt.getOptName());
			gradeTypeService.updateGradeTypeRebate(entity, opt.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			e.printStackTrace();
		}
		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/typerebate/add", method = RequestMethod.POST)
	public void saveGradeTypeRebate(HttpServletRequest req, HttpServletResponse resp,
			@RequestBody RebateFormula entity) {

		try {
			StaffEntity staff = SessionUtils.getOperator(req);
			entity.setOpt(staff.getOptName());
			gradeTypeService.saveGradeTypeRebate(entity, staff);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/typerebate/list")
	public ModelAndView toGradeTypeRebateList(HttpServletRequest req, HttpServletResponse resp) {

		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		return forword("system/gradeType/rebateformula/list", context);
	}

	@RequestMapping(value = "/typerebate/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, RebateFormula entity) {
		PageCallBack pcb = null;

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("needPaging", true);
		StaffEntity opt = SessionUtils.getOperator(req);

		try {
			pcb = gradeTypeService.dataList(entity, params, opt.getToken(),
					ServerCenterContants.USER_CENTER_LIST_GRADE_TYPE_REBATEFORMULA, RebateFormula.class);

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

}
