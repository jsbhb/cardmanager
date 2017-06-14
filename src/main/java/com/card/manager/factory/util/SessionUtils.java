package com.card.manager.factory.util;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import com.card.manager.factory.auth.model.AuthInfo;
import com.card.manager.factory.auth.model.Operator;

/**
 * 说明：回话管理工具类
 * 
 * @author 贺斌
 * @version 1.0 2014-8-18 上午10:14:09
 */
public final class SessionUtils {

	protected static final Logger logger = Logger.getLogger(SessionUtils.class);

	private static final String SESSION_OPERATOR = "session_Operator";// 后台用户

	private static final String SESSION_MENULIST = "session_MenuList";// 后台用户

	private static final String SESSION_VALIDATECODE = "session_validatecode";// 验证码

	private static final String SESSION_ACCESS_URLS = "session_access_urls"; // 系统能够访问的URL

	/**
	 * 设置session的值
	 * 
	 * @param request
	 * @param key
	 * @param value
	 */
	public static void setAttr(HttpServletRequest request, String key, Object value) {
		request.getSession(true).setAttribute(key, value);
	}

	/**
	 * 获取session的值
	 * 
	 * @param request
	 * @param key
	 * @param value
	 */
	public static Object getAttr(HttpServletRequest request, String key) {
		return request.getSession(true).getAttribute(key);
	}

	/**
	 * 删除Session值
	 * 
	 * @param request
	 * @param key
	 */
	public static void removeAttr(HttpServletRequest request, String key) {
		request.getSession(true).removeAttribute(key);
	}

	/**
	 * 从session中获取用户信息
	 * 
	 * @param request
	 * @return SysUser
	 */
	public static Operator getOperator(HttpServletRequest request) {
		return (Operator) request.getSession(true).getAttribute(SESSION_OPERATOR);
	}

	/**
	 * 从session中获取用户信息
	 * 
	 * @param request
	 * @return opt
	 */
	public static void setOperator(HttpServletRequest request, Operator opt) {
		request.getSession(true).setAttribute(SESSION_OPERATOR, opt);
	}

	/**
	 * session中设置菜单集合
	 * 
	 * @param request
	 */
	public static void setMenuList(HttpServletRequest request, List<AuthInfo> menuList) {
		request.getSession(true).setAttribute(SESSION_MENULIST, menuList);
		setAccessUrl(request, menuList);
	}

	/**
	 * 从session中获取菜单集合
	 * 
	 * @param request
	 * @return menuList
	 */
	@SuppressWarnings("unchecked")
	public static List<AuthInfo> getMenuList(HttpServletRequest request) {
		return (List<AuthInfo>) request.getSession(true).getAttribute(SESSION_MENULIST);
	}

	/**
	 * 从session中获取用户信息
	 * 
	 * @param request
	 * @return SysUser
	 */
	public static void removeOperator(HttpServletRequest request) {
		removeAttr(request, SESSION_OPERATOR);
	}
	
	/**
	 * 从session中获取用户信息
	 * 
	 * @param request
	 * @return SysUser
	 */
	public static void removeMenuList(HttpServletRequest request) {
		removeAttr(request, SESSION_MENULIST);
	}

	/**
	 * 设置验证码 到session
	 * 
	 * @param request
	 * @param user
	 */
	public static void setValidateCode(HttpServletRequest request, String validateCode) {
		request.getSession(true).setAttribute(SESSION_VALIDATECODE, validateCode);
	}

	/**
	 * 从session中获取验证码
	 * 
	 * @param request
	 * @return SysUser
	 */
	public static String getValidateCode(HttpServletRequest request) {
		return (String) request.getSession(true).getAttribute(SESSION_VALIDATECODE);
	}

	/**
	 * 从session中获删除验证码
	 * 
	 * @param request
	 * @return SysUser
	 */
	public static void removeValidateCode(HttpServletRequest request, String state) {
		removeAttr(request, SESSION_VALIDATECODE);
	}

	/**
	 * 判断当前登录用户是否超级管理员
	 * 
	 * @param request
	 * @return
	 */
	public static void setAccessUrl(HttpServletRequest request, List<AuthInfo> authInfos) { // 判断登录用户是否超级管理员
		// 能够访问的url列表
		List<String> accessUrls = new ArrayList<String>();
		if (authInfos != null) {
			for (AuthInfo authinfo : authInfos) {
				
				List<AuthInfo> children = authinfo.getChildren();
				
				if(children==null||children.size()==0){
					continue;
				}
				
				for(AuthInfo childAuthInfo:children){
					accessUrls.add(StringUtils.substringBeforeLast(childAuthInfo.getUrl(), "/"));
				}
			}
		}

		setAttr(request, SESSION_ACCESS_URLS, accessUrls);
	}

	/**
	 * 判断URL是否可访问
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static boolean isAccessUrl(HttpServletRequest request, String url) {
		List<String> accessUrls = (List<String>) getAttr(request, SESSION_ACCESS_URLS);
		if (accessUrls == null || accessUrls.isEmpty() || !accessUrls.contains(url)) {
			return false;
		}
		return true;
	}

}