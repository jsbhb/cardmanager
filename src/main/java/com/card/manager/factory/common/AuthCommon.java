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

	/*
	 * 员工状态
	 */
	public static final int STAFF_STATUS_ON = 1;
	public static final int STAFF_STATUS_OFF = 2;
	public static final int STAFF_STATUS_DELETED = 3;
	public static final int SUPER_ADMIN = 1;
	public static final int EARA_ADMIN = 2;
	public static final int SHOP_ADMIN = 3;

	public static final String PRIVILEGE_DEAL = "1";
	public static final String PRIVILEGE_QUERY = "2";
	public static final String OPERATION_DIAGRAM = "1";
	public static final String ORDER_DIAGRAM = "17";
	public static final String FINANCIAL_DIAGRAM = "22";
	public static final String PERSONAL_DIAGRAM = "35";
	public static final String PURCHASE_DIAGRAM = "51";
	

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

		List<AuthInfo> menuList = treeAuthInfo2(optMenuList);

		return menuList;
	}

	public static List<AuthInfo> treeAuthInfo2(List<AuthInfo> authInfos) {
		if (authInfos == null || authInfos.size() == 0) {
			return null;
		}
		List<AuthInfo> authCaches = new ArrayList<AuthInfo>();
		for (AuthInfo authInfo : authInfos) {
			if (authInfo.getParentId() == null || "".equals(authInfo.getParentId())) {
				authCaches.add(authInfo);
			}
		}

		List<AuthInfo> childList;
		List<AuthInfo> grandSonList;

		for (AuthInfo pAuth : authCaches) {
			childList = new ArrayList<AuthInfo>();
			for (AuthInfo child : authInfos) {
				if (child.getParentId() != null && pAuth.getFuncId().equals(child.getParentId())) {
					grandSonList = new ArrayList<AuthInfo>();
					for (AuthInfo grandSon : authInfos) {
						if (grandSon.getParentId() != null && child.getFuncId().equals(grandSon.getParentId())) {
							grandSonList.add(grandSon);
						}
					}
					child.setChildren(grandSonList);
					childList.add(child);
				}
			}
			pAuth.setChildren(childList);
		}

		return authCaches;
	}

}
