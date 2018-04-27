package com.card.manager.factory.auth.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.card.manager.factory.auth.model.DiagramPojo;
import com.card.manager.factory.auth.model.StatisticPojo;
import com.card.manager.factory.auth.service.StatisticMngService;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.component.model.GradeBO;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service("statisticService")
public class StatisticMngServceImpl implements StatisticMngService {

	@Override
	public StatisticPojo queryStaticDiagram(String dateType, String timeMode, String modelType, StaffEntity staff) {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("gradeId", staff.getGradeId() + "");
		params.put("dataType", dateType);
		params.put("time", timeMode);
		params.put("modelType", modelType);

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_CACHE, staff.getToken(), true, null,
				HttpMethod.GET, params);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		StatisticPojo temp_result = JSONUtilNew.parse(json.toString(), StatisticPojo.class);

		if (temp_result != null && temp_result.getChartData() != null) {
			if (temp_result.getChartData() != null) {
				Map<Integer, GradeBO> gradeMap = CachePoolComponent.getGrade(staff.getToken());
				for (DiagramPojo pojo : temp_result.getChartData()) {
					pojo.setName(gradeMap.get(Integer.parseInt(pojo.getName())) != null
							? gradeMap.get(Integer.parseInt(pojo.getName())).getName() : "");
				}
			}
		}
		return temp_result;
	}

	@Override
	public List<DiagramPojo> queryStaticHead(String dateType, String modelType, StaffEntity staff) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("gradeId", staff.getGradeId() + "");
		params.put("dataType", dateType);
		params.put("time", "");
		params.put("modelType", modelType);

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_CACHE, staff.getToken(), true, null,
				HttpMethod.GET, params);

		JSONArray json = JSONArray.fromObject(query_result.getBody());

		List<DiagramPojo> tempList = null;
		if (json != null && json.size() > 0) {
			tempList = new ArrayList<DiagramPojo>();
			for (int i = 0; i < json.size(); i++) {
				tempList.add(JSONUtilNew.parse(json.getJSONObject(i).toString(), DiagramPojo.class));
			}
		}

		return tempList;
	}

}
