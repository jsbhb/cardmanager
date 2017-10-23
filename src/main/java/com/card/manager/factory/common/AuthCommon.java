/**  
 * Project Name:cardmanager  
 * File Name:AuthCommon.java  
 * Package Name:com.card.manager.factory.common  
 * Date:Oct 20, 201710:04:12 AM  
 *  
 */
package com.card.manager.factory.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.card.manager.factory.auth.model.AuthInfo;

/**
 * ClassName: AuthCommon <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: Oct 20, 2017 10:04:12 AM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class AuthCommon {

	public static List<AuthInfo> treeAuthInfo(List<AuthInfo> authInfos) {
		if (authInfos == null || authInfos.size() == 0) {
			return null;
		}
		Map<String, AuthInfo> authCaches = new HashMap<String, AuthInfo>();
		for (AuthInfo authInfo : authInfos) {
			if (authInfo.getParentId() == null || "".equals(authInfo.getParentId())) {
				authCaches.put(authInfo.getFuncId(), authInfo);
			}
		}

		for (AuthInfo authInfo : authInfos) {
			if (authCaches.containsKey(authInfo.getParentId())) {
				List<AuthInfo> temChild = authCaches.get(authInfo.getParentId()).getChildren();
				if (temChild == null) {
					temChild = new ArrayList<AuthInfo>();
					temChild.add(authInfo);
					authCaches.get(authInfo.getParentId()).setChildren(temChild);
				} else {
					temChild.add(authInfo);
				}
			}
		}

		List<AuthInfo> menuAuth = new ArrayList<AuthInfo>();

		for (Map.Entry<String, AuthInfo> entry : authCaches.entrySet()) {
			menuAuth.add(entry.getValue());
		}

		return menuAuth;
	}

	/**
	 * treeAuthInfo:判断2个权限并进行是否选中的设置. <br/>
	 * 
	 * @author hebin
	 * @param optMenuList
	 * @param roleMenuList
	 * @return
	 * @since JDK 1.7
	 */
	public static List<AuthInfo> treeAuthInfo(List<AuthInfo> optMenuList, List<AuthInfo> roleMenuList) {
		for (AuthInfo authInfo : optMenuList) {
			for (AuthInfo roleAuthInfo : roleMenuList) {
				if (roleAuthInfo.getFuncId() != null && roleAuthInfo.getFuncId().equals(authInfo.getFuncId())) {
					authInfo.setSelected(true);
					break;
				}
			}
		}
		
		List<AuthInfo> menuList = treeAuthInfo(optMenuList);

		return menuList;
	}

}
