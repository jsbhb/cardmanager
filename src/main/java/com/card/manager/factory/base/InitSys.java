package com.card.manager.factory.base;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.card.manager.factory.log.SysLogger;

/**
 * 初始化系统 1、加载缓存数据
 */
@Component
public class InitSys {

	@Resource
	SysLogger sysLogger;

	@Resource
	private SysCache sysCache;

	@PostConstruct
	public void init() {

	}
}
