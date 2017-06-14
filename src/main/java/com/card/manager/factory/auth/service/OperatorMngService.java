package com.card.manager.factory.auth.service;

import com.card.manager.factory.auth.model.Operator;

/**
 * 
 * @author 賀斌
 * @datetime 2016年7月27日
 * @func
 */
public interface OperatorMngService {

	/**
	 * 
	 * @param userName
	 * @param pwd
	 * @return
	 */
	Operator queryByLoginInfo(String userName, String pwd);

}
