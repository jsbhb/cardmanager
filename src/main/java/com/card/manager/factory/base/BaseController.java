package com.card.manager.factory.base;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.util.HtmlUtil;
import com.card.manager.factory.util.URLUtils;
import com.github.pagehelper.Page;

public abstract class BaseController {

	public final static String SUCCESS = "success";
	public final static String ERROR = "error";
	public final static String ERROR_CODE = "code";
	public final static String MSG = "msg";
	public final static String DATA = "data";
	public final static String OPT = "opt";
	public final static String LOGOUT_FLAG = "logoutFlag";

	protected Logger log = LoggerFactory.getLogger(this.getClass());

	
	public static Pagination webPageConverter(Page<?> page) {
		Pagination pagination = new Pagination();
		pagination.setCurrentPage(page.getPageNum());
		pagination.setLastIndex(page.getEndRow());
		pagination.setNumPerPage(page.getPageSize());
		pagination.setTotalPages(page.getPages());
		pagination.setTotalRows(page.getTotal());

		return pagination;

	}
	
	/**
	 * 所有ActionMap 统一从这里获取
	 * 
	 * @return
	 */
	public Map<String, Object> getRootMap() {
		Map<String, Object> rootMap = new HashMap<String, Object>();
		// 添加url到 Map中
		rootMap.putAll(URLUtils.getUrlMap());
		return rootMap;
	}

	@SuppressWarnings("unchecked")
	public ModelAndView forword(String viewName, Map context) {
		return new ModelAndView(viewName, context);
	}

	/**
	 *
	 * 提示失败信息
	 *
	 * @param message
	 *
	 */
	public void sendFailureMessage(HttpServletResponse response, String message) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put(SUCCESS, false);
		result.put(MSG, message);
		HtmlUtil.writerJson(response, result);
	}

	/**
	 *
	 * 提示成功信息
	 *
	 * @param message
	 *
	 */
	public void sendSuccessMessage(HttpServletResponse response, String message) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put(SUCCESS, true);
		result.put(MSG, message);
		HtmlUtil.writerJson(response, result);
	}
	
	
	/**
	 *
	 * 提示成功信息
	 *
	 * @param message
	 *
	 */
	public void sendSuccessObject(HttpServletResponse response, Object obj) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put(SUCCESS, true);
		result.put(DATA, obj);
		HtmlUtil.writerJson(response, result);
	}

	/**
	 * 返回信息
	 * 
	 * @param response
	 * @param message
	 */
	public void sendHttpMessage(HttpServletResponse response, String message) {
		HtmlUtil.writerText(response, message);
	}
}
