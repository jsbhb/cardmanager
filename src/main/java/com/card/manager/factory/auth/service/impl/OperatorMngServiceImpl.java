package com.card.manager.factory.auth.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.card.manager.factory.auth.mapper.OperatorMapper;
import com.card.manager.factory.auth.model.Operator;
import com.card.manager.factory.auth.service.OperatorMngService;

@Service("operatorMngService")
public class OperatorMngServiceImpl implements OperatorMngService{

	@Resource
	OperatorMapper<Operator> operatorMapper;

	@Override
	public Operator queryByLoginInfo(String userName, String password) {
		
		Map<String,String> params = new HashMap<String,String>();
		params.put("userName", userName);
		params.put("password", password);
		
		return operatorMapper.selectByLoginInfo(params);
	}
}
