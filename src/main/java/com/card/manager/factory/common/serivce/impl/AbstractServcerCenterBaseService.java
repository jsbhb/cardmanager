/**  
 * Project Name:cardmanager  
 * File Name:AbstractBaseService.java  
 * Package Name:com.card.manager.factory.common.serivce  
 * Date:Nov 7, 20174:15:12 PM  
 *  
 */
package com.card.manager.factory.common.serivce.impl;

import java.lang.reflect.Constructor;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;

import com.card.manager.factory.base.PageCallBack;
import com.card.manager.factory.base.Pagination;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.serivce.ServerCenterService;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * ClassName: AbstractBaseService <br/>
 * Function: 内部服务类. <br/>
 * date: Nov 7, 2017 4:15:12 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public abstract class AbstractServcerCenterBaseService implements ServerCenterService {

	private static String PAGE_PARAM = "pagination";
	private static String BODY_CONTENT = "obj";
	private static String GATE_WAY = "gateway";

	@Override
	public PageCallBack dataList(Pagination pagination, Map<String, Object> params, String token, String url,
			Class<?> entityClass) throws Exception {
		if (token == null || "".equals(token)) {
			throw new Exception("无令牌信息");
		}

		// 调用权限中心 验证是否可以登录
		RestCommonHelper helper = new RestCommonHelper(pagination);

		ResponseEntity<String> result = helper.requestForPage(URLUtils.get(GATE_WAY) + url, params, token,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(result.getBody());
		JSONObject pJson = json.getJSONObject(PAGE_PARAM);
		pagination = new Pagination(pJson);

		JSONArray obj = json.getJSONArray(BODY_CONTENT);
		int index = obj.size();

		if (index == 0) {
			throw new Exception("没有查询到相关数据！");
		}

		List<Object> gradeList = new ArrayList<Object>();
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			Constructor<?> cons = entityClass.getDeclaredConstructor(JSONObject.class);
			gradeList.add(cons.newInstance(jObj));
		}

		PageCallBack pcb = new PageCallBack();
		pcb.setObj(gradeList);
		pcb.setPagination(pagination);
		pcb.setSuccess(true);

		return pcb;
	}
}
