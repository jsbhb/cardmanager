package com.card.manager.factory.auth.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.card.manager.factory.auth.mapper.FuncEntityMapper;
import com.card.manager.factory.auth.mapper.FuncMapper;
import com.card.manager.factory.auth.model.AuthInfo;
import com.card.manager.factory.auth.model.FuncEntity;
import com.card.manager.factory.auth.service.FuncMngService;
import com.card.manager.factory.base.Pagination;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

@Service("funcMngService")
public class FuncMngServceImpl implements FuncMngService {

	@Resource
	FuncMapper<AuthInfo> funcMapper;

	@Resource
	FuncEntityMapper<FuncEntity> funcEntityMapper;

	@Override
	public List<AuthInfo> queryFuncByOptId(String id) {
		return funcMapper.queryFuncByOptId(id);
	}

	@Override
	public Page<FuncEntity> queryParentFunc(Pagination pagination) {
		PageHelper.startPage(pagination.getCurrentPage(), pagination.getNumPerPage(), true);
		return funcEntityMapper.queryParentFunc();
	}

	@Override
	public AuthInfo queryFuncById(String id) {
		return funcMapper.queryById(id);
	}

	@Override
	public void removeFunc(String id) {
		funcMapper.deleteFuncById(id);
	}

	@Override
	public void updateFunc(AuthInfo authInfo) {

	}

	@Override
	public void addFunc(AuthInfo authInfo) {

		if ("-1".equals(authInfo.getParentId())) {
			authInfo.setParentId(null);
		}

		funcMapper.insertFunc(authInfo);
	}

	@Override
	public List<AuthInfo> queryFunc() {
		return funcMapper.selectFunc();
	}

	@Override
	public void editFunc(AuthInfo authInfo) {
		funcMapper.updateFunc(authInfo);
	}

	@Override
	public List<AuthInfo> queryFuncByRoleId(int roleId) {
		return funcMapper.selectFuncByRoleId(roleId);
	}

	@Override
	public Page<FuncEntity> dataList(Pagination pagination, Map<String, Object> params) {
		PageHelper.startPage(pagination.getCurrentPage(), pagination.getNumPerPage(), true);
		return funcEntityMapper.queryByList(params);
	}

	@Override
	public FuncEntity queryById(Map<String, Object> params) {
		return funcEntityMapper.queryById(params);
	}

	@Override
	public List<AuthInfo> queryFuncByRoleIdParam(Map<String, Object> params) {
		return funcMapper.selectFuncByRoleIdParam(params);
	}

}
