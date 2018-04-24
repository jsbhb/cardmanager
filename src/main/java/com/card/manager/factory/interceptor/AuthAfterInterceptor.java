package com.card.manager.factory.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.card.manager.factory.auth.model.AuthInfo;
import com.card.manager.factory.util.SessionUtils;

/**
 * 说明：权限拦截器,获得权限
 * 
 * @author 贺斌
 * @version 1.0
 */
public class AuthAfterInterceptor extends HandlerInterceptorAdapter {

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

		if (modelAndView != null) {
			String menuUrl = StringUtils.remove(request.getRequestURI(), request.getContextPath());
			menuUrl = StringUtils.substringBeforeLast(menuUrl, "/");

			List<AuthInfo> authInfos = SessionUtils.getMenuList(request);

			if (authInfos != null) {
				for (AuthInfo authInfo : authInfos) {
					List<AuthInfo> children = authInfo.getChildren();

					if (children == null) {
						continue;
					}

					for (AuthInfo child : children) {
						List<AuthInfo> grandSons = child.getChildren();
						if (grandSons == null) {
							continue;
						}

						for (AuthInfo grandSon : grandSons) {
							if (grandSon.getUrl() != null && grandSon.getUrl().contains(menuUrl)) {
								modelAndView.addObject("privilege", grandSon.getPrivilege());
								super.postHandle(request, response, handler, modelAndView);
								return;
							}
						}

					}
				}
			}
		}

		super.postHandle(request, response, handler, modelAndView);
	}

}
