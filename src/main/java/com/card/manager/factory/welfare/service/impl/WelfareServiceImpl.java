package com.card.manager.factory.welfare.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.ExcelUtils;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.URLUtils;
import com.card.manager.factory.welfare.model.InviterEntity;
import com.card.manager.factory.welfare.model.WelfareMembeStatistic;
import com.card.manager.factory.welfare.service.WelfareService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class WelfareServiceImpl extends AbstractServcerCenterBaseService implements WelfareService {

	@Override
	public Map<String, Object> importInviterInfo(String filePath, StaffEntity staffEntity) {
		List<InviterEntity> list = ExcelUtils.instance().readExcel(filePath, InviterEntity.class, true);
		return checkAndImportInviterInfo(list, staffEntity);
	}

	@Override
	public Map<String, Object> addInviterInfo(InviterEntity entity, StaffEntity staffEntity) {
		List<InviterEntity> list = new ArrayList<InviterEntity>();
		list.add(entity);
		return checkAndImportInviterInfo(list, staffEntity);
	}

	public Map<String, Object> checkAndImportInviterInfo(List<InviterEntity> list, StaffEntity staffEntity) {
		Map<String, Object> result = new HashMap<String, Object>();

		if (list != null && list.size() > 0) {
			List<InviterEntity> importList = new ArrayList<InviterEntity>();
			for (InviterEntity ie : list) {
				if (ie.getName() == null || "".equals(ie.getName()) || ie.getPhone() == null
						|| "".equals(ie.getPhone())) {
					continue;
				} else {
					ie.setGradeId(staffEntity.getGradeId());
					ie.setStatus(0);
					ie.setOpt(staffEntity.getOptName());
					importList.add(ie);
				}
			}
			if (importList.size() <= 0) {
				result.put("success", false);
				result.put("msg", "没有邀请人信息");
				return result;
			}
			try {
				RestCommonHelper helper = new RestCommonHelper();
				ResponseEntity<String> usercenter_result = helper.request(
						URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_INVITER_IMPORT,
						staffEntity.getToken(), true, importList, HttpMethod.POST);

				JSONObject json = JSONObject.fromObject(usercenter_result.getBody());
				result.put("success", json.get("success"));
				result.put("msg", json.get("errorMsg"));
				return result;
			} catch (Exception e) {
				e.printStackTrace();
				result.put("success", false);
				result.put("msg", e);
				return result;
			}
		} else { // 没有读到数据
			result.put("success", false);
			result.put("msg", "没有邀请人信息");
			return result;
		}
	}

	@Override
	public Map<String, Object> updateInviterInfo(InviterEntity entity, StaffEntity staffEntity) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			RestCommonHelper helper = new RestCommonHelper();
			ResponseEntity<String> usercenter_result = helper.request(
					URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_INVITER_UPDATE, staffEntity.getToken(),
					true, entity, HttpMethod.POST);

			JSONObject json = JSONObject.fromObject(usercenter_result.getBody());
			result.put("success", json.get("success"));
			result.put("msg", json.get("errorMsg"));
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("msg", e);
			return result;
		}
	}

	@Override
	public Map<String, Object> produceCode(InviterEntity entity, StaffEntity staffEntity) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			RestCommonHelper helper = new RestCommonHelper();
			ResponseEntity<String> usercenter_result = helper.request(
					URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_INVITER_PRODUCE_CODE,
					staffEntity.getToken(), true, entity, HttpMethod.POST);

			JSONObject json = JSONObject.fromObject(usercenter_result.getBody());
			result.put("success", json.get("success"));
			result.put("msg", json.get("errorMsg"));
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("msg", e);
			return result;
		}
	}

	@Override
	public Map<String, Object> sendProduceCode(InviterEntity entity, StaffEntity staffEntity) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			RestCommonHelper helper = new RestCommonHelper();
			ResponseEntity<String> usercenter_result = helper.request(
					URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_INVITER_SEND_PRODUCE_CODE,
					staffEntity.getToken(), true, entity, HttpMethod.POST);

			JSONObject json = JSONObject.fromObject(usercenter_result.getBody());
			result.put("success", json.get("success"));
			result.put("msg", json.get("errorMsg"));
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("msg", e);
			return result;
		}
	}

	@Override
	public List<WelfareMembeStatistic> getInviterStatistic(int gradeId, String token) {
		Map<String, Object> param = new HashMap<String, Object>();
		List<WelfareMembeStatistic> list = new ArrayList<WelfareMembeStatistic>();
		try {
			param.put("gradeId", gradeId);
			RestCommonHelper helper = new RestCommonHelper();
			ResponseEntity<String> result = helper.requestWithParams(
					URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_INVITER_STATISTIC, token, true, null,
					HttpMethod.GET, param);

			JSONObject json = JSONObject.fromObject(result.getBody());
			JSONArray jsonArr = json.getJSONArray("obj");
			if(jsonArr.size() > 0){
				for(int i = 0 ;i<jsonArr.size();i++){
					JSONObject obj = jsonArr.getJSONObject(i);
					list.add(JSONUtilNew.parse(obj.toString(), WelfareMembeStatistic.class));
				}
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
