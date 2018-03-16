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

import com.card.manager.factory.auth.model.PlatUserType;
import com.card.manager.factory.auth.model.UserInfo;
import com.card.manager.factory.common.AuthCommon;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.shop.model.ShopEntity;
import com.card.manager.factory.system.mapper.StaffMapper;
import com.card.manager.factory.system.model.GradeEntity;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.service.GradeMngService;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.MethodUtil;
import com.card.manager.factory.util.URLUtils;
import com.card.manager.factory.annotation.Log;

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
public class GradeMngServiceImpl extends AbstractServcerCenterBaseService implements GradeMngService {

	@Resource
	StaffMapper<StaffEntity> staffMapper;

//	@Override
//	public PageCallBack dataList(Pagination pagination, Map<String, Object> hashMap, String token) throws Exception {
//
//		if (token == null || "".equals(token)) {
//			throw new Exception("无令牌信息");
//		}
//
//		// 调用权限中心 验证是否可以登录
//		RestCommonHelper helper = new RestCommonHelper(pagination);
//
//		ResponseEntity<String> result = helper.requestForPage(
//				URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_GRADE_QUERY_FOR_PAGE, hashMap, token,
//				HttpMethod.POST);
//
//		JSONObject json = JSONObject.fromObject(result.getBody());
//		JSONObject pJson = json.getJSONObject("pagination");
//		pagination = new Pagination(pJson);
//
//		JSONArray obj = json.getJSONArray("obj");
//		int index = obj.size();
//
//		if (index == 0) {
//			throw new Exception("没有查询到相关数据！");
//		}
//
//		List<GradeEntity> gradeList = new ArrayList<GradeEntity>();
//		for (int i = 0; i < index; i++) {
//			JSONObject jObj = obj.getJSONObject(i);
//			GradeEntity temp = new GradeEntity(jObj);
//			gradeList.add(temp);
//		}
//
//		PageCallBack pcb = new PageCallBack();
//		pcb.setObj(gradeList);
//		pcb.setPagination(pagination);
//		pcb.setSuccess(true);
//
//		return pcb;
//	}

	@Override
	public void saveGrade(GradeEntity gradeInfo, StaffEntity staff)  throws Exception{
		RestCommonHelper helper = new RestCommonHelper();

		// 确认当前分级负责人电话是否已经存在
		ResponseEntity<String> phonecheck_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_PHONE_CHECK+"?account="+gradeInfo.getPhone(), staff.getToken(), true,
				null, HttpMethod.GET);
		JSONObject pcjson = JSONObject.fromObject(phonecheck_result.getBody());

		if (!pcjson.getBoolean("success")) {
			throw new Exception("校验失败,手机号：" + gradeInfo.getPhone() + "已经被使用，请修改后重试");
		}
		
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
		int gradeLevel = gradeInfo.getGradeLevel();
		staffEntity.setGradeLevel(gradeLevel);
		
		if(gradeLevel == ServerCenterContants.SECOND_GRADE){
			staffEntity.setGradeId(gradeId);
		}
		if(gradeLevel == ServerCenterContants.THIRD_GRADE){
			staffEntity.setGradeId(staffEntity.getParentGradeId());
			staffEntity.setShopId(gradeId);
		}
		
		staffEntity.setOptName(gradeInfo.getPersonInCharge());
		staffEntity.setGradeId(gradeId);
		staffEntity.setUserCenterId(userId);
		//订货平台账号
		staffEntity.setPhone(gradeInfo.getPhone());

		// 权限中心注册
		registerAuthCenter(staffEntity,true);

		CachePoolComponent.syncCenter(staffEntity.getToken());
		CachePoolComponent.syncShop(staffEntity.getToken());
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
		if(staffEntity.getGradeLevel() == ServerCenterContants.SECOND_GRADE){
			staffEntity.setRoleId(AuthCommon.EARA_ADMIN);
			staffEntity.setRoleName("区域负责人");
		}else{
			staffEntity.setRoleName("店铺负责人");
			staffEntity.setRoleId(AuthCommon.SHOP_ADMIN);
		}
		
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
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), GradeEntity.class);
	}

	@Override
	public void updateGrade(GradeEntity gradeInfo, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		// 确认当前分级负责人电话是否已经存在
//		ResponseEntity<String> phonecheck_result = helper.request(
//				URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_PHONE_CHECK+"?account="+gradeInfo.getPhone(), staffEntity.getToken(), true,
//				null, HttpMethod.GET);
//		JSONObject pcjson = JSONObject.fromObject(phonecheck_result.getBody());
//
//		if (!pcjson.getBoolean("success")) {
//			throw new Exception("校验失败,手机号：" + gradeInfo.getPhone() + "已经被使用，请修改后重试");
//		}

		ResponseEntity<String> goodscenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_GRADE_UPDATE, staffEntity.getToken(), true, gradeInfo,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(goodscenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("插入失败:" + json.getString("errorCode") + "-" + json.getString("errorMsg"));
		}

		CachePoolComponent.syncCenter(staffEntity.getToken());
		CachePoolComponent.syncShop(staffEntity.getToken());
	}
	
	@Override
	public ShopEntity queryByGradeId(String gradeId,String token) {
		ShopEntity entity = new ShopEntity();
		entity.setGradeId(Integer.parseInt(gradeId));
		
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_MICRO_SHOP_QUERY, token, true, entity,
				HttpMethod.POST);
		
		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), ShopEntity.class);
	}
	

	@Override
	@Log(content = "更新微店信息", source = Log.BACK_PLAT, type = Log.MODIFY)
	public void updateShop(ShopEntity shopInfo, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> goodscenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_MICRO_SHOP_UPDATE, staffEntity.getToken(), true, shopInfo,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(goodscenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("编辑失败:" + json.getString("errorCode") + "-" + json.getString("errorMsg"));
		}
	}
}
