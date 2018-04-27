package com.card.manager.factory.auth.service;

import java.util.List;

import com.card.manager.factory.auth.model.DiagramPojo;
import com.card.manager.factory.auth.model.StatisticPojo;
import com.card.manager.factory.system.model.StaffEntity;

/**
 * 
 * @author 贺斌
 * @datetime 2016年7月27日
 * @func 功能模块管理
 */
public interface StatisticMngService {

	public final static String DATA_TYPE_CHART = "chart";
	public final static String DATA_TYPE_HEAD = "head";
	public final static String TIME_MODE_WEEK = "week";
	public final static String TIME_MODE_MONTH = "month";
	public final static String MODEL_TYPE_ORDER = "order";
	public final static String MODEL_TYPE_FINANCE = "finance";

	/**
	 * 根据操作员信息进行功能控制
	 * 
	 * @param id
	 * @return
	 */
	StatisticPojo queryStaticDiagram(String dateType, String timeMode, String modelType,
			StaffEntity staff);

	/**
	 * 根据操作员信息进行功能控制
	 * 
	 * @param id
	 * @return
	 */
	List<DiagramPojo> queryStaticHead(String dateType, String modelType, StaffEntity staff);

}
