package com.card.manager.factory.system.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.goods.grademodel.GradeTypeDTO;
import com.card.manager.factory.goods.service.GoodsService;
import com.card.manager.factory.system.model.GradeTypeEntity;
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
}
