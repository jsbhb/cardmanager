package com.card.manager.factory.auth.controller;

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
import com.card.manager.factory.auth.model.FuncEntity;
import com.card.manager.factory.auth.service.FuncMngService;
import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.base.PageCallBack;
import com.card.manager.factory.base.Pagination;
import com.card.manager.factory.common.AuthCommon;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;
import com.github.pagehelper.Page;

@Controller
@RequestMapping("/admin/system/funcMng")
public class FuncMngController extends BaseController {

	private final String PARENT_ENTITY = "parent";
	private final String FUNC_ID = "func_id";
	private final String FUNC_DETAIL = "func";

	@Resource
	FuncMngService funcMngService;

	@RequestMapping(value = "/addFunc", method = RequestMethod.POST)
	public void addFunc(HttpServletRequest req, HttpServletResponse resp, @RequestBody AuthInfo authInfo) {

		try {
			funcMngService.addFunc(authInfo);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/editFunc", method = RequestMethod.POST)
	public void editFunc(HttpServletRequest req, HttpServletResponse resp, @RequestBody AuthInfo authInfo) {

		try {
			funcMngService.editFunc(authInfo);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/deleteFunc", method = RequestMethod.POST)
	public void deleteFunc(HttpServletRequest req, HttpServletResponse resp, String id) {

		if (id == null || "".equals(id)) {
			sendFailureMessage(resp, "删除失败，没有选择对应模块或者节点！");
			return;
		}
		try {
			funcMngService.removeFunc(id);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/list")
	public ModelAndView toFuncList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("menuList", queryMenuList(req, opt));
		return forword("system/func/funcMng2", context);
	}

	@RequestMapping(value = "/list1")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		return forword("system/func/funcMng", context);
	}

	@RequestMapping(value = "/dataList1")
	@ResponseBody
	public PageCallBack dataList1(Pagination pagination, HttpServletRequest req, HttpServletResponse resp) {
		PageCallBack pcb = new PageCallBack();
		try {
			Page<FuncEntity> page = null;
			Map<String, Object> params = new HashMap<String, Object>();

			params.put("name", req.getParameter("name"));
			params.put("parentId", req.getParameter("parentId"));

			String queryAll = req.getParameter("queryAll");
			if (!StringUtil.isEmpty(queryAll)) {
				params.put("queryAll", Boolean.parseBoolean(queryAll));
			}

			page = funcMngService.dataList(pagination, params);

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

	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		Map<String, Object> params = new HashMap<String, Object>();
		try {

			String parentId = req.getParameter("parentId");

			if (!StringUtil.isEmpty(parentId)) {
				params.put("funcId", parentId);
				FuncEntity entity = funcMngService.queryById(params);
				context.put(PARENT_ENTITY, entity);
			}

		} catch (Exception e) {
			e.printStackTrace();
			return forword("error", context);
		}
		return forword("system/func/add", context);
	}

	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		AuthInfo authInfo = funcMngService.queryFuncById(req.getParameter(FUNC_ID));
		context.put(FUNC_DETAIL, authInfo);
		return forword("system/func/edit", context);
	}

	@RequestMapping(value = "/dataList")
	public void dataList(Pagination pagination, HttpServletRequest req, HttpServletResponse resp) {

		StaffEntity opt = SessionUtils.getOperator(req);
		queryMenuList(req, opt);

		sendSuccessMessage(resp, null);

	}

	/**
	 * queryMenuList:根据用户编号查询. <br/>
	 * 
	 * @author hebin
	 * @param request
	 * @param operator
	 * @since JDK 1.7
	 */
	private List<AuthInfo> queryMenuList(HttpServletRequest request, StaffEntity operator) {
		// 设置MenuList到Session
		List<AuthInfo> authInfos = funcMngService.queryFunc();
		return AuthCommon.treeAuthInfo(authInfos);
	}

}
