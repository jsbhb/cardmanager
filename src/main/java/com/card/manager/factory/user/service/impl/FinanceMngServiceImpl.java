/**  
 * Project Name:cardmanager  
 * File Name:GradeMngServiceImpl.java  
 * Package Name:com.card.manager.factory.system.service.impl  
 * Date:Oct 29, 20178:31:28 PM  
 *  
 */
package com.card.manager.factory.user.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.card.manager.factory.annotation.Log;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.finance.model.AuditModel;
import com.card.manager.factory.finance.model.Refilling;
import com.card.manager.factory.finance.model.Withdrawals;
import com.card.manager.factory.order.model.PushUser;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.user.model.CardEntity;
import com.card.manager.factory.user.model.Rebate;
import com.card.manager.factory.user.model.ShopRebate;
import com.card.manager.factory.user.service.FinanceMngService;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.URLUtils;
import com.fasterxml.jackson.core.type.TypeReference;

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
public class FinanceMngServiceImpl extends AbstractServcerCenterBaseService implements FinanceMngService {
	@Override
	@Log(content = "更新账号绑定银行卡信息", source = Log.BACK_PLAT, type = Log.MODIFY)
	public void updateCard(CardEntity cardInfo, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> goodscenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_CARDINFO_UPDATE, staffEntity.getToken(), true, cardInfo,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(goodscenter_result.getBody());
		if (!json.getBoolean("success")) {
			throw new Exception("更新账号绑定银行卡信息失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public List<CardEntity> queryInfoByEntity(StaffEntity staffEntity) {
		RestCommonHelper helper = new RestCommonHelper();
		Map<String, Object> params = new HashMap<String, Object>();
		String operId = "";
		String operType = "";
		if (staffEntity.getGradeLevel() == 1) {
			operId = staffEntity.getUserCenterId()+"";
			operType = "2";
		} else if (staffEntity.getGradeLevel() == 2) {
			operId = staffEntity.getGradeId()+"";
			operType = "0";
		} else if (staffEntity.getGradeLevel() == 3) {
			operId = staffEntity.getShopId()+"";
			operType = "1";
		}
		params.put("id", operId);
		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_QUERY_CARDINFO+"?type="+operType, staffEntity.getToken(), true, staffEntity,
				HttpMethod.GET, params);
		
		JSONObject json = JSONObject.fromObject(query_result.getBody());
//		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), CardEntity.class);
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), new TypeReference<List<CardEntity>>() {});
		 
	}
	
	@Override
	public String checkCardNo(String cardNo, String token) throws Exception {
		
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_CARDNO_CHECK+"?cardNo="+cardNo, token, true, null,
				HttpMethod.GET);
		
		JSONObject json = JSONObject.fromObject(query_result.getBody());
		if (!json.getBoolean("success")) {
			throw new Exception("校验银行卡信息失败:" + json.getString("errorMsg"));
		}
//		return json.getJSONObject("errorMsg").toString();
		return json.getString("errorMsg");
	}

	@Override
	@Log(content = "新增账号绑定银行卡信息", source = Log.BACK_PLAT, type = Log.ADD)
	public void insertCard(CardEntity cardInfo, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> goodscenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_CARDINFO_INSERT, staffEntity.getToken(), true, cardInfo,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(goodscenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("新增账号绑定银行卡信息失败:" + json.getString("errorMsg"));
		}
	}
	
	@Override
	public Rebate queryRebate(Integer id, String token) {
		
		RestCommonHelper helper = new RestCommonHelper();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_REBATE_QUERY, token, true, null,
				HttpMethod.GET, params);
		
		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), Rebate.class);
	}
	
	@Override
	public ShopRebate queryShopRebate(String id, String type, String token) {
		
		RestCommonHelper helper = new RestCommonHelper();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_REBATE_QUERY+"?type="+type, token, true, null,
				HttpMethod.GET, params);
		
		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), ShopRebate.class);
	}
	
	@Override
	public CardEntity queryInfoByCardId(CardEntity cardEntity, StaffEntity staffEntity) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_QUERY_CARD_BY_CARDID, staffEntity.getToken(), true, cardEntity,
				HttpMethod.POST);
		
		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), CardEntity.class);
	}

	@Override
	@Log(content = "删除账号绑定银行卡信息", source = Log.BACK_PLAT, type = Log.DELETE)
	public void deleteCard(CardEntity cardInfo, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", cardInfo.getId().toString());
		ResponseEntity<String> goodscenter_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_CARDINFO_DELETE, staffEntity.getToken(), true, null,
				HttpMethod.DELETE, params);

		JSONObject json = JSONObject.fromObject(goodscenter_result.getBody());
		if (!json.getBoolean("success")) {
			throw new Exception("删除账号绑定银行卡信息失败:" + json.getString("errorMsg"));
		}
	}
	
	@Override
	public Withdrawals checkWithdrawalsById(String id, StaffEntity staffEntity) {
		Withdrawals Detail = null;
		RestCommonHelper helper = new RestCommonHelper();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		ResponseEntity<String> result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_WITHDRAWALS_DETAIL_ID, staffEntity.getToken(), true,
				null, HttpMethod.POST,params);
		JSONObject json = JSONObject.fromObject(result.getBody());

		if (json.getBoolean("success")) {
			Detail = JSONUtilNew.parse(json.getJSONObject("obj").toString(), Withdrawals.class);
		}
		
		if (Detail != null) {
			if (Detail.getOperatorType() == 0) {
				List<StaffEntity> center = CachePoolComponent.getCenter(staffEntity.getToken());
				for(StaffEntity ce : center) {
					if (Detail.getOperatorId() == ce.getGradeId()) {
						Detail.setOperatorName(ce.getGradeName());
						break;
					}
				}
			} else if (Detail.getOperatorType() == 1) {
				List<StaffEntity> shop = CachePoolComponent.getShop(staffEntity.getToken());
				for(StaffEntity sh : shop) {
					if (Detail.getOperatorId() == sh.getShopId()) {
						Detail.setOperatorName(sh.getGradeName());
						break;
					}
				}
			} else if (Detail.getOperatorType() == 2) {
				List<PushUser> push = CachePoolComponent.getPushUsers(staffEntity.getToken());
				for(PushUser pu : push) {
					if (Detail.getOperatorId().toString().equals(pu.getUserId().toString())) {
						Detail.setOperatorName(pu.getName());
						break;
					}
				}
			}
		}
		return Detail;
	}

	@Override
	@Log(content = "审核提现信息", source = Log.BACK_PLAT, type = Log.ADD)
	public void auditWithdrawals(AuditModel entity, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_WITHDRAWALS_AUDIT, staffEntity.getToken(), true,
				entity, HttpMethod.POST);
		JSONObject json = JSONObject.fromObject(result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("提现审核失败，请联系技术人员！");
		}
	}

	@Override
	public List<CardEntity> queryInfoByUser(StaffEntity staffEntity) {
		List<CardEntity> retList = new ArrayList<CardEntity>();
		RestCommonHelper helper = new RestCommonHelper();
		Map<String, Object> params = new HashMap<String, Object>();
		String operId = "";
		String operType = "";
		if (staffEntity.getGradeLevel() == 1) {
			operId = staffEntity.getUserCenterId()+"";
			operType = "2";
		} else if (staffEntity.getGradeLevel() == 2) {
			operId = staffEntity.getGradeId()+"";
			operType = "0";
		} else if (staffEntity.getGradeLevel() == 3) {
			operId = staffEntity.getShopId()+"";
			operType = "1";
		}
		params.put("id", operId);
		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_CARDINFO_LIST+"?type="+operType, staffEntity.getToken(), true, staffEntity,
				HttpMethod.GET, params);
		
		JSONObject json = JSONObject.fromObject(query_result.getBody());
		if (!json.getBoolean("success")) {
			return retList;
		}
		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();
		if (index == 0) {
			return retList;
		}
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			retList.add(JSONUtilNew.parse(jObj.toString(), CardEntity.class));
		}
		return retList;
	}

	@Override
	@Log(content = "发起提现申请", source = Log.BACK_PLAT, type = Log.ADD)
	public void applyWithdrawals(Withdrawals entity, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> goodscenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_USER_APPLY_WITHDRAWALS, staffEntity.getToken(), true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(goodscenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("发起提现申请失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	@Log(content = "发起返充申请", source = Log.BACK_PLAT, type = Log.ADD)
	public void applyRefilling(Refilling entity, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("centerId", staffEntity.getGradeId());
		ResponseEntity<String> goodscenter_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_USER_APPLY_REFILLING, staffEntity.getToken(), true, entity,
				HttpMethod.POST, params);

		JSONObject json = JSONObject.fromObject(goodscenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("发起返充申请失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public Refilling queryRefillingDetailById(String id, StaffEntity staffEntity) {
		Refilling Detail = null;
		RestCommonHelper helper = new RestCommonHelper();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		ResponseEntity<String> result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_REFILLING_DETAIL_ID, staffEntity.getToken(), true,
				null, HttpMethod.POST,params);
		JSONObject json = JSONObject.fromObject(result.getBody());

		if (json.getBoolean("success")) {
//			JSONObject tjson = JSONObject.fromObject(json.getJSONObject("obj").toString());
//			Detail = JSONUtilNew.parse(tjson.getJSONObject("obj").toString(), Refilling.class);
			Detail = JSONUtilNew.parse(json.getJSONObject("obj").toString(), Refilling.class);
		}
		if (Detail != null) {
			List<StaffEntity> center = CachePoolComponent.getCenter(staffEntity.getToken());
			for(StaffEntity ce : center) {
				if (Detail.getCenterId() == ce.getGradeId()) {
					Detail.setOperatorName(ce.getGradeName());
					break;
				}
			}
		}
		return Detail;
	}

	@Override
	@Log(content = "审核返充信息", source = Log.BACK_PLAT, type = Log.ADD)
	public void auditRefilling(AuditModel entity, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_REFILLING_AUDIT, staffEntity.getToken(), true,
				entity, HttpMethod.POST);
		JSONObject json = JSONObject.fromObject(result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("返充审核失败，请联系技术人员！");
		}
	}

	@Override
	@Log(content = "资金池充值", source = Log.BACK_PLAT, type = Log.ADD)
	public void poolCharge(String centerId, String money, String payNo, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("centerId", centerId);
		ResponseEntity<String> result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_CENTER_CHARGE+"?money="+money+"&payNo="+payNo, staffEntity.getToken(), true,
				null, HttpMethod.POST,params);
		JSONObject json = JSONObject.fromObject(result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("资金池充值失败，请联系技术人员！");
		}
	}

	@Override
	@Log(content = "资金池清算", source = Log.BACK_PLAT, type = Log.ADD)
	public void poolLiquidation(String centerId, String money, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("centerId", centerId);
		ResponseEntity<String> result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_CENTER_LIQUIDATION+"?money="+money, staffEntity.getToken(), true,
				null, HttpMethod.POST,params);
		JSONObject json = JSONObject.fromObject(result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("资金池清算失败，请联系技术人员！");
		}
	}
}
