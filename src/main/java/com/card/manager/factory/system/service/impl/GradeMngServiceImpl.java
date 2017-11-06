/**  
 * Project Name:cardmanager  
 * File Name:GradeMngServiceImpl.java  
 * Package Name:com.card.manager.factory.system.service.impl  
 * Date:Oct 29, 20178:31:28 PM  
 *  
 */
package com.card.manager.factory.system.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.card.manager.factory.auth.model.PlatUserType;
import com.card.manager.factory.auth.model.UserInfo;
import com.card.manager.factory.base.PageCallBack;
import com.card.manager.factory.base.Pagination;
import com.card.manager.factory.common.AuthCommon;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.system.mapper.StaffMapper;
import com.card.manager.factory.system.model.GradeEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.service.GradeMngService;
import com.card.manager.factory.util.MethodUtil;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONArray;
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
public class GradeMngServiceImpl implements GradeMngService {

	@Resource
	StaffMapper<StaffEntity> staffMapper;

	@Override
	public PageCallBack dataList(Pagination pagination, Map<String, Object> hashMap, String token) throws Exception {

		if (token == null || "".equals(token)) {
			throw new Exception("无令牌信息");
		}

		// 调用权限中心 验证是否可以登录
		RestCommonHelper helper = new RestCommonHelper(pagination);

		ResponseEntity<String> result = helper.requestForPage(
				URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_GRADE_QUERY_FOR_PAGE, hashMap, token,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(result.getBody());
		JSONObject pJson = json.getJSONObject("pagination");
		pagination = new Pagination(pJson);

		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		if (index == 0) {
			throw new Exception("没有查询到相关数据！");
		}

		List<GradeEntity> gradeList = new ArrayList<GradeEntity>();
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			GradeEntity temp = new GradeEntity(jObj);
			gradeList.add(temp);
		}

		PageCallBack pcb = new PageCallBack();
		pcb.setObj(gradeList);
		pcb.setPagination(pagination);
		pcb.setSuccess(true);

		return pcb;
	}

	@Override
	public void saveGrade(GradeEntity gradeInfo, StaffEntity staff)  throws Exception{
		RestCommonHelper helper = new RestCommonHelper();

		// 用户中心注册
		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_GRADE_SAVE, staff.getToken(), true,
				gradeInfo, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());
		JSONObject obj = json.getJSONObject("obj");
		int userId = obj.getInt("userId");
		int gradeId = obj.getInt("centerId");
		StaffEntity staffEntity = new StaffEntity();
		staffEntity.setGradeName(gradeInfo.getGradeName());
		staffEntity.setParentGradeId(staff.getGradeId());
		staffEntity.setOptName(gradeInfo.getPersonInCharge());
		staffEntity.setGradeId(gradeId);
		staffEntity.setUserCenterId(userId);

		// 权限中心注册
		registerAuthCenter(staffEntity,true);

	}

	@Override
	public void registerAuthCenter(StaffEntity staffEntity,boolean hasUserId) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		UserInfo userInfo = new UserInfo(PlatUserType.CROSS_BORDER.getIndex(), 4, staffEntity.getGradeId());
		userInfo.setUserCenterId(staffEntity.getUserCenterId());

		ResponseEntity<String> register_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.AUTH_CENTER_REGISTER, "", false, userInfo,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(register_result.getBody());

		String success = json.getString("success");

		// 如果失败，在用户表里记录未同步权限中心
		if ("true".equals(success)) {
			staffEntity.setPlatId(json.getJSONObject("obj").getInt("id"));
		}else{
			throw new Exception(json.getString("errorMsg"));
		}

		// 插入badge表
		staffMapper.insertNextVal(staffEntity.getGradeId());

		// 插入用户表
		staffEntity.setBadge(staffEntity.getGradeId() * 10000 + "1");
		staffEntity.setRoleId(AuthCommon.EARA_ADMIN);
		staffEntity.setRoleName("区域负责人");
		
		if(hasUserId){
			staffEntity.setStatus(AuthCommon.STAFF_STATUS_ON + "");
		}else{
			staffEntity.setStatus(AuthCommon.STAFF_STATUS_ON + "");
		}
		staffEntity.setPassword(MethodUtil.MD5("000000"));
		staffMapper.insert(staffEntity);
		staffMapper.insertRoleOpt(staffEntity);
	}

	@Override
	public GradeEntity queryById(String gradeId,String token) {
		GradeEntity entity = new GradeEntity();
		entity.setId(Integer.parseInt(gradeId));
		
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_GRADE_QUERY, token, true, entity,
				HttpMethod.POST);
		
		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return new GradeEntity(json.getJSONObject("obj"));
	}

}
