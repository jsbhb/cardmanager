package com.card.manager.factory.auth.service.impl;

import java.util.List;

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

}
