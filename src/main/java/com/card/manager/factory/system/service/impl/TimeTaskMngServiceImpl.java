/**  
 * Project Name:cardmanager  
 * File Name:StaffMngServiceImpl.java  
 * Package Name:com.card.manager.factory.system.service.impl  
 * Date:Oct 26, 20172:18:25 PM  
 *  
 */
package com.card.manager.factory.system.service.impl;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.card.manager.factory.annotation.Log;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.model.TimeTaskModel;
import com.card.manager.factory.system.service.TimeTaskMngService;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONObject;

@Service
public class TimeTaskMngServiceImpl extends AbstractServcerCenterBaseService implements TimeTaskMngService {

	@Override
	public TimeTaskModel queryTimeTaskById(Integer id, StaffEntity opt) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.TIMETASK_CENTER_QUERY_TIMETASK_BY_ID + "?id=" + id, opt.getToken(), true, null,
				HttpMethod.GET);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), TimeTaskModel.class);
	}

	@Override
	@Log(content = "启动调度器操作", source = Log.BACK_PLAT, type = Log.MODIFY)
	public void startTimeTaskById(Integer id, StaffEntity staff) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.TIMETASK_CENTER_START_TIMETASK + "?id=" + id, staff.getToken(), true,
				null, HttpMethod.GET);

		JSONObject json = JSONObject.fromObject(result.getBody());

		boolean success = json.getBoolean("success");

		// 如果失败，提示
		if (!success) {
			throw new Exception("启动调度器失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	@Log(content = "停止调度器操作", source = Log.BACK_PLAT, type = Log.MODIFY)
	public void stopTimeTaskById(Integer id, StaffEntity staff) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.TIMETASK_CENTER_STOP_TIMETASK + "?id=" + id, staff.getToken(), true,
				null, HttpMethod.GET);

		JSONObject json = JSONObject.fromObject(result.getBody());

		boolean success = json.getBoolean("success");

		// 如果失败，提示
		if (!success) {
			throw new Exception("停止调度器失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	@Log(content = "更新调度器操作", source = Log.BACK_PLAT, type = Log.MODIFY)
	public void updateTimeTask(TimeTaskModel entity, StaffEntity staff) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.TIMETASK_CENTER_UPDATE_TIMETASK, staff.getToken(), true,
				entity, HttpMethod.PUT);

		JSONObject json = JSONObject.fromObject(result.getBody());

		boolean success = json.getBoolean("success");

		// 如果失败，提示
		if (!success) {
			throw new Exception("更新调度器失败:" + json.getString("errorMsg"));
		}
	}
}
