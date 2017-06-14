package com.card.manager.factory.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.card.manager.factory.annotation.Auth;
import com.card.manager.factory.auth.model.Operator;
import com.card.manager.factory.util.SessionUtils;

/**
 * 说明：权限拦截器
 * 
 * @author 贺斌
 * @version 1.0 2014-8-18 上午10:09:47
 */
public class AuthInterceptor extends HandlerInterceptorAdapter {
	
	private static String BASIC_URL = "/admin/basic";

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HandlerMethod method = (HandlerMethod) handler;
		Auth auth = method.getMethod().getAnnotation(Auth.class);
		String baseUri = request.getContextPath();
		
		//// 验证登陆超时问题 auth = null，默认验证)
		if (auth == null || auth.verifyLogin()) {
			Operator opt = SessionUtils.getOperator(request);

			if (opt == null) {
				if (request.getHeader("x-requested-with") != null && request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) { // 如果是ajax请求响应头会有，x-requested-with
					response.setHeader("sessionstatus", "timeout");// 在响应头设置session状态
				} else {
					response.sendRedirect(baseUri + "/admin/toLogin.shtml");
				}
				return false;
			}
		}

		// 验证URL权限auth == null || auth.verifyURL()
		if (auth == null || auth.verifyURL()) {
			String menuUrl = StringUtils.remove(request.getRequestURI(), request.getContextPath());
			menuUrl = StringUtils.substringBeforeLast(menuUrl, "/");
			
			if (!menuUrl.startsWith(BASIC_URL)&&!SessionUtils.isAccessUrl(request, StringUtils.trim(menuUrl))) {
				// 日志记录
				String msg = "URL权限验证不通过:[url=" + menuUrl + "]";
				request.setAttribute("msg", msg);
				response.sendRedirect(baseUri + "/admin/error.shtml");
				return false;
			}
		}
		return super.preHandle(request, response, handler);
	}
}
