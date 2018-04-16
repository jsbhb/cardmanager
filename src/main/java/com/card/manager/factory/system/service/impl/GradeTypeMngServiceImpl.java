/**  
 * Project Name:cardmanager  
 * File Name:GradeMngServiceImpl.java  
 * Package Name:com.card.manager.factory.system.service.impl  
 * Date:Oct 29, 20178:31:28 PM  
 *  
 */
package com.card.manager.factory.system.service.impl;

import javax.annotation.Resource;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.card.manager.factory.annotation.Log;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.system.mapper.StaffMapper;
import com.card.manager.factory.system.model.GradeTypeEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.service.GradeTypeMngService;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONObject;

/**
 * ClassName: GradeMngServiceImpl <br/>
 * Function: 分级服务实现类. <br/>
 * date: Oct 29, 2017 8:31:28 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
@Service
public class GradeTypeMngServiceImpl extends AbstractServcerCenterBaseService implements GradeTypeMngService {

	@Resource
	StaffMapper<StaffEntity> staffMapper;

	@Override
	@Log(content = "新增分级类型信息操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void save(GradeTypeEntity entity, StaffEntity staff) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_GRADE_TYPE, staff.getToken(), true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(result.getBody());

		boolean success = json.getBoolean("success");

		// 如果失败，提示
		if (!success) {
			throw new Exception("新增失败:" + json.getString("errorMsg"));
		}
	}


	@Override
	public GradeTypeEntity queryById(String id, String token) {
		return null;
	}

	@Override
	@Log(content = "更新分级类型信息操作", source = Log.BACK_PLAT, type = Log.MODIFY)
	public void update(GradeTypeEntity entity, StaffEntity staff) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_GRADE_TYPE_UPDATE, staff.getToken(), true,
				entity, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(result.getBody());

		boolean success = json.getBoolean("success");

		// 如果失败，提示
		if (!success) {
			throw new Exception("更新失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	@Log(content = "删除分级类型信息操作", source = Log.BACK_PLAT, type = Log.DELETE)
	public void delete(String id, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_GRADE_TYPE + "?id=" + id,
				staffEntity.getToken(), true, null, HttpMethod.DELETE);

		JSONObject json = JSONObject.fromObject(result.getBody());

		boolean success = json.getBoolean("success");

		// 如果失败，提示
		if (!success) {
			throw new Exception("删除失败:" + json.getString("errorMsg"));
		}
	}

}
