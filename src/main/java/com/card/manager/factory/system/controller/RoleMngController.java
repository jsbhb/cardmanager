package com.card.manager.factory.system.controller;

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

import com.card.manager.factory.auth.model.AuthInfo;
import com.card.manager.factory.auth.service.FuncMngService;
import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.base.PageCallBack;
import com.card.manager.factory.base.Pagination;
import com.card.manager.factory.common.AuthCommon;
import com.card.manager.factory.common.RoleCommon;
import com.card.manager.factory.system.model.RoleEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.service.RoleMngService;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;
import com.github.pagehelper.Page;

@Controller
@RequestMapping("/admin/system/roleMng")
public class RoleMngController extends BaseController {

	private final String ROLE_ID = "roleId";
	private final String ROLE = "role";
	private final String MENULIST = "menuList";

	@Resource
	RoleMngService roleMngService;

	@Resource
	FuncMngService funcMngService;

	@RequestMapping(value = "/mng")
	public ModelAndView toFuncList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		return forword("system/role/roleMng", context);
	}

	@RequestMapping(value = "/toAdd")
	public ModelAndView add(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);

		String parentId = req.getParameter("id");
		if (!StringUtil.isEmpty(parentId)) {
			RoleEntity parent = roleMngService.queryById(Integer.parseInt(parentId));
			context.put("parent", parent);
		}

		return forword("system/role/add", context);
	}

	@RequestMapping(value = "/addRole", method = RequestMethod.POST)
	public void addFunc(HttpServletRequest req, HttpServletResponse resp, @RequestBody RoleEntity role) {

		StaffEntity opt = SessionUtils.getOperator(req);
		role.setOpt(Integer.parseInt(opt.getOptid()));
		try {
			roleMngService.addRole(role);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {

			// 获取角色信息
			int roleId = Integer.parseInt(req.getParameter(ROLE_ID));
			RoleEntity role = roleMngService.queryById(roleId);
			context.put(ROLE, role);

			List<AuthInfo> menuList = null;
			List<AuthInfo> optMenuList = null;
			// 获取编辑角色信息
			List<AuthInfo> roleMenuList = funcMngService.queryFuncByRoleId(roleId);
			if (roleId == AuthCommon.SUPER_ADMIN) {
				optMenuList = funcMngService.queryFunc();
				menuList = AuthCommon.treeAuthInfo(optMenuList, roleMenuList);
			} else {
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("parentId", (role.getParentId() == 0 ? role.getRoleId() : role.getParentId()));
				params.put("roleId", roleId);
				// 获取当前用户可操作所有功能菜单
				optMenuList = funcMngService.queryFuncByRoleIdParam(params);
				menuList = AuthCommon.treeAuthInfo(optMenuList, roleMenuList);
			}

			context.put(MENULIST, menuList);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword("error", context);
		}

		return forword("system/role/edit", context);
	}

	@RequestMapping(value = "/editRole", method = RequestMethod.POST)
	public void editFunc(HttpServletRequest req, HttpServletResponse resp, @RequestBody RoleEntity role) {
		try {
			StaffEntity opt = SessionUtils.getOperator(req);
			role.setOpt(Integer.parseInt(opt.getOptid()));
			roleMngService.edit(role, true);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/change", method = RequestMethod.POST)
	public void change(HttpServletRequest req, HttpServletResponse resp, RoleEntity role) {
		try {
			StaffEntity opt = SessionUtils.getOperator(req);
			role.setOpt(Integer.parseInt(opt.getOptid()));
			roleMngService.edit(role, false);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);

		List<RoleEntity> roleList = roleMngService.queryAll();

		List<RoleEntity> roleTree = RoleCommon.treeRole(roleList, opt.getRoleId());
		context.put("roleTree", roleTree);

		return forword("system/role/list", context);
	}

	@RequestMapping(value = "/dataList", method = RequestMethod.POST)
	@ResponseBody
	public PageCallBack dataList(HttpServletRequest req, HttpServletResponse resp, Pagination pagination) {
		PageCallBack pcb = new PageCallBack();

		try {
			Page<RoleEntity> page = roleMngService.dataList(pagination, new HashMap<String, Object>());
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

}
