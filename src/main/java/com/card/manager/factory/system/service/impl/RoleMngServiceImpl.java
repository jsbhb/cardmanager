/**  
 * Project Name:cardmanager  
 * File Name:RoleMngServiceImpl.java  
 * Package Name:com.card.manager.factory.system.service.impl  
 * Date:Oct 18, 20175:42:10 PM  
 *  
 */
package com.card.manager.factory.system.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.card.manager.factory.base.Pagination;
import com.card.manager.factory.common.AuthCommon;
import com.card.manager.factory.system.mapper.RoleMapper;
import com.card.manager.factory.system.model.RoleEntity;
import com.card.manager.factory.system.service.RoleMngService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

/**
 * ClassName: RoleMngServiceImpl <br/>
 * Function: 角色服务类. <br/>
 * date: Oct 18, 2017 5:42:10 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
@Service("roleMngService")
public class RoleMngServiceImpl implements RoleMngService {

	@Resource
	RoleMapper<RoleEntity> roleMapper;

	@Override
	public Page<RoleEntity> dataList(Pagination pagination, Map<String, Object> params) {
		PageHelper.startPage(pagination.getCurrentPage(), pagination.getNumPerPage(), true);
		return roleMapper.queryList(params);
	}

	@Override
	public RoleEntity queryById(int roleId) {
		return roleMapper.queryById(roleId);
	}

	@Override
	public void addRole(RoleEntity role) {
		roleMapper.insert(role);
	}

	@Override
	public void modifyRole(RoleEntity role) {
		roleMapper.update(role);
	}

	@Override
	public void edit(RoleEntity role, boolean needUpdateFunc) throws Exception {
		if (role == null) {
			throw new Exception("没有角色信息！");
		}

		if (role.getRoleId() == 0 || role.getRoleId() < 0) {
			throw new Exception("角色编号获取有误！");
		}

		roleMapper.update(role);
		
		if(needUpdateFunc){
			String funcIds = role.getFuncId();
			String privileges = role.getPrivilege();
			
			roleMapper.deleteAllFunc(role.getRoleId());
			
			if(StringUtils.isEmpty(funcIds)){
				return;
			}
			
			List<RoleEntity> rolesData = new ArrayList<RoleEntity>();
			
			String[] funcArray = funcIds.split(",");
			String[] privilegeArray = privileges.split(",");
			RoleEntity roleData;
			boolean isDeal;
			
			for(String func:funcArray){
				roleData = new RoleEntity();
				roleData.setRoleId(role.getRoleId());
				roleData.setOpt(role.getOpt());
				roleData.setFuncId(func);
				isDeal = false;
				if(!StringUtils.isEmpty(privileges)){
					for(String privilege:privilegeArray){
						if(privilege.equals(func)){
							roleData.setPrivilege(AuthCommon.PRIVILEGE_DEAL);
							isDeal = true;
							break;
						}
					}
				}
				if(!isDeal){
					roleData.setPrivilege(AuthCommon.PRIVILEGE_QUERY);
				}
				
				rolesData.add(roleData);
			}
			
			
			
			roleMapper.insertRoleFunc(rolesData);
					
		}
	}

	@Override
	public List<RoleEntity> queryAll() {
		return roleMapper.queryNormal();
	}

	@Override
	public Integer getRoleIdByGradeTypeId(Integer id) {
		return roleMapper.getRoleIdByGradeTypeId(id);
	}

}
