/**  
 * Project Name:cardmanager  
 * File Name:StaffMngServiceImpl.java  
 * Package Name:com.card.manager.factory.system.service.impl  
 * Date:Oct 26, 20172:18:25 PM  
 *  
 */
package com.card.manager.factory.system.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.card.manager.factory.base.Pagination;
import com.card.manager.factory.common.AuthCommon;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.system.exception.OperatorSaveException;
import com.card.manager.factory.system.exception.SyncUserCenterException;
import com.card.manager.factory.system.mapper.StaffMapper;
import com.card.manager.factory.system.model.PushUser;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.servercenter.UserCenterEntity;
import com.card.manager.factory.system.service.StaffMngService;
import com.card.manager.factory.util.MethodUtil;
import com.card.manager.factory.util.URLUtils;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

import net.sf.json.JSONObject;

/**
 * ClassName: StaffMngServiceImpl <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: Oct 26, 2017 2:18:25 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
@Service
public class StaffMngServiceImpl implements StaffMngService {

	@Resource
	StaffMapper<StaffEntity> staffMapper;

	@Override
	public Page<StaffEntity> dataList(Pagination pagination, Map<String, Object> params) {
		PageHelper.startPage(pagination.getCurrentPage(), pagination.getNumPerPage(), true);
		return staffMapper.queryByList(params);
	}

	@Override
	public StaffEntity queryById(int optId) {
		return staffMapper.selectByOptId(optId);
	}

	@Override
	public void addStaff(StaffEntity staff) throws OperatorSaveException, SyncUserCenterException {
		// 生成badge
		try {
			int badge = staffMapper.nextVal(staff.getGradeId() + "");
			staff.setBadge(staff.getGradeId() +"00000"+badge);
			staff.setPassword(MethodUtil.MD5("000000"));
		} catch (Exception e) {
			throw new OperatorSaveException("生成自增bagde出错:" + e.getMessage());
		}

		//新建员工时需要控制员工账号新建分级的权限
		//根据roleId 获取绑定的gradeTypeId
//		try {
//			int gradeTypeId = staffMapper.queryGradeTypeIdByRoleId(staff.getRoleId()+"");
//			staff.setGradeType(gradeTypeId);
//		} catch (Exception e) {
//			throw new OperatorSaveException("根据roleId获取绑定的gradeTypeId出错:" + e.getMessage());
//		}
		try {
			staff.setStatus(AuthCommon.STAFF_STATUS_OFF + "");
			staffMapper.insert(staff);
			staffMapper.insertRoleOpt(staff);

		} catch (Exception e) {
			throw new OperatorSaveException("插入后台员工表出错:" + e.getMessage());
		}

		// 调用用户中心
		ResponseEntity<String> result = null;
		try {
			result = syncUserCenter(new UserCenterEntity(staff, staff.getPhone()));
		} catch (Exception e) {
			throw new SyncUserCenterException("同步用户中心信息出错:" + e.getMessage());
		}

		try {
			JSONObject json = JSONObject.fromObject(result.getBody());
			staff.setUserCenterId(json.getInt("obj"));
			staffMapper.updateUserCenterId(staff);
		} catch (Exception e) {
			throw new SyncUserCenterException("更新用户中心编号失败！" + e.getMessage());
		}

	}

	@Override
	public void modifyStaff(StaffEntity staff) {
	}

	@Override
	public StaffEntity queryByLoginInfo(String userName, String pwd) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("userName", userName);
		params.put("password", pwd);

		return staffMapper.selectByLoginInfo(params);
	}

	@Override
	public void sync(int optId, String phone) throws Exception {
		StaffEntity staffeEntity = staffMapper.selectByOptId(optId);
		UserCenterEntity ucEntity = new UserCenterEntity(staffeEntity, phone);

		// 调用用户中心
		ResponseEntity<String> result = null;
		try {
			result = syncUserCenter(ucEntity);
		} catch (Exception e) {
			throw new Exception("同步失败！" + e.getMessage());
		}

		try {
			JSONObject json = JSONObject.fromObject(result.getBody());
			staffeEntity.setUserCenterId(json.getInt("obj"));
			staffMapper.updateUserCenterId(staffeEntity);
		} catch (Exception e) {
			throw new Exception("更新用户中心编号失败！" + e.getMessage());
		}
	}

	/**
	 * syncUserCenter:(这里用一句话描述这个方法的作用). <br/>
	 * 
	 * @author hebin
	 * @param ucEntity
	 * @return
	 * @since JDK 1.7
	 */
	private ResponseEntity<String> syncUserCenter(UserCenterEntity ucEntity) {
		RestTemplate restTemplate = new RestTemplate();

		HttpEntity<UserCenterEntity> httpEntity = new HttpEntity<UserCenterEntity>(ucEntity, null);

		ResponseEntity<String> result = restTemplate.exchange(
				(String) URLUtils.getUrlMap().get("gateway") + ServerCenterContants.USER_CENTER_REGISTER,
				HttpMethod.POST, httpEntity, String.class);
		return result;
	}

	@Override
	public void modifyPwd(String userName, String pwd) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("userName", userName);
		params.put("password", pwd);

		staffMapper.updatePwd(params);
	}

	@Override
	public void sync2B(StaffEntity staff,int optId) throws Exception {
		//根据id进行查询
		StaffEntity staffeEntity = staffMapper.selectByOptId(optId);
		
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = null;
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", optId);
		//设置platform为订货平台（6）
		params.put("platUserType", 6);

		try {
			result = helper.requestWithParams(URLUtils.get("gateway") + ServerCenterContants.AUTH_CENTER_PLATFORM_REGISTER,
					staff.getToken(), false, null, HttpMethod.POST, params);
			
			if (result == null)
				throw new Exception("没有返回信息");
			
			JSONObject json = JSONObject.fromObject(result.getBody());
	
			if (!json.getBoolean("success")) {
				throw new Exception("开通订货平台账号失败:" + json.getString("errorMsg"));
			}
			staffMapper.update2BFlg(staffeEntity);
		} catch (Exception e) {
			throw new Exception("更新账号状态失败！" + e.getMessage());
		}
	}

	@Override
	public void sync2S(StaffEntity staff,int optId) throws Exception {
		//根据id进行查询
		StaffEntity staffeEntity = staffMapper.selectByOptId(optId);
		
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = null;
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", optId);
		//设置platform为推手平台（7）
		params.put("platUserType", 7);
		Map<String, Object> params2 = new HashMap<String, Object>();
		params2.put("code", "erp");

		try {
			//开通推手账号时，需要先创建推手信息
			PushUser pushUser = new PushUser();
			pushUser.setUserId(staffeEntity.getUserCenterId());
			pushUser.setGradeId(staffeEntity.getGradeId());
			pushUser.setStatus(2);
			pushUser.setType(1);
			pushUser.setPhone(staffeEntity.getPhone());
			pushUser.setName(staffeEntity.getOptName());
			pushUser.setInviter("");
			pushUser.setSpecialtyChannel("");
			
			result = helper.requestWithParams(URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_PUSHUSER_REGISER,
					staff.getToken(), false, pushUser, HttpMethod.POST, params2);
			if (result == null)
				throw new Exception("创建推手没有返回信息");
			
			JSONObject json2 = JSONObject.fromObject(result.getBody());
	
			if (!json2.getBoolean("success")) {
				throw new Exception("创建推手信息失败:" + json2.getString("errorMsg"));
			}
			
			result = null;
			
			result = helper.requestWithParams(URLUtils.get("gateway") + ServerCenterContants.AUTH_CENTER_PLATFORM_REGISTER,
					staff.getToken(), false, null, HttpMethod.POST, params);
			
			if (result == null)
				throw new Exception("开通推手平台账号没有返回信息");
			
			JSONObject json = JSONObject.fromObject(result.getBody());
	
			if (!json.getBoolean("success")) {
				throw new Exception("开通推手平台账号失败:" + json.getString("errorMsg"));
			}
			staffMapper.update2SFlg(staffeEntity);
		} catch (Exception e) {
			throw new Exception("更新账号状态失败！" + e.getMessage());
		}
	}

	@Override
	public List<StaffEntity> queryByParam(Map<String, String> params) {
		return staffMapper.selectByParam(params);
	}
}
