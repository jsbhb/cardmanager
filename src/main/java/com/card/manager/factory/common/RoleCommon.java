/**  
 * Project Name:cardmanager  
 * File Name:AuthCommon.java  
 * Package Name:com.card.manager.factory.common  
 * Date:Oct 20, 201710:04:12 AM  
 *  
 */
package com.card.manager.factory.common;

import java.util.ArrayList;
import java.util.List;

import com.card.manager.factory.system.model.RoleEntity;

/**
 * ClassName: AuthCommon <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: Oct 20, 2017 10:04:12 AM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class RoleCommon {

	public static List<RoleEntity> treeRole(List<RoleEntity> roleList, int roleId) {
		List<RoleEntity> roleTree = new ArrayList<RoleEntity>();
		if (roleId == AuthCommon.SUPER_ADMIN) {
			for (RoleEntity role : roleList) {
				if (role.getParentId() == 0) {
					addChild(role, roleList);
					roleTree.add(role);
				}
			}
		} else {
			for (RoleEntity role : roleList) {
				if (role.getRoleId() == roleId) {
					addChild(role, roleList);
					roleTree.add(role);
				}
			}
		}

		return roleTree;

	}

	public static void addChild(RoleEntity parent, List<RoleEntity> roleList) {
		List<RoleEntity> temp;
		for (RoleEntity role : roleList) {
			if (role.getParentId() == parent.getRoleId()) {
				if (parent.getChildren() == null) {
					temp = new ArrayList<RoleEntity>();
					addChild(role, roleList);
					temp.add(role);
					parent.setChildren(temp);
				} else {
					parent.getChildren().add(role);
					addChild(role, roleList);
				}
			}
		}
	}

	/**
	 * roleList:(这里用一句话描述这个方法的作用). <br/>
	 * 
	 * @author hebin
	 * @param roleList
	 * @param roleId
	 * @return
	 * @since JDK 1.7
	 */
	public static List<RoleEntity> roleList(List<RoleEntity> roleList, int roleId) {

		if (roleId == AuthCommon.SUPER_ADMIN) {
			return roleList;
		} else {
			List<RoleEntity> tempRoleList = new ArrayList<RoleEntity>();
			List<RoleEntity> rList = treeRole(roleList, roleId);
			for (RoleEntity roleEntity : rList) {
				tempRoleList.add(roleEntity);
				addChildList(tempRoleList, roleEntity.getChildren());
			}
			return tempRoleList;
		}

	}

	private static void addChildList(List<RoleEntity> tempRoleList, List<RoleEntity> children) {
		if (children == null) {
			return;
		}
		for (RoleEntity roleEntity : children) {
			tempRoleList.add(roleEntity);
			addChildList(tempRoleList, roleEntity.getChildren());
		}

	}

}
