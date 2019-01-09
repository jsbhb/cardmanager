/**  
 * Project Name:cardmanager  
 * File Name:GradeMngServiceImpl.java  
 * Package Name:com.card.manager.factory.system.service.impl  
 * Date:Oct 29, 20178:31:28 PM  
 *  
 */
package com.card.manager.factory.user.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.card.manager.factory.annotation.Log;
import com.card.manager.factory.base.Pagination;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.component.model.GradeBO;
import com.card.manager.factory.finance.model.AddCapitalPoolInfoEntity;
import com.card.manager.factory.finance.model.AuditModel;
import com.card.manager.factory.finance.model.CapitalManagement;
import com.card.manager.factory.finance.model.CapitalManagementBusinessItem;
import com.card.manager.factory.finance.model.CapitalManagementDetail;
import com.card.manager.factory.finance.model.CapitalManagementDownLoadEntity;
import com.card.manager.factory.finance.model.CapitalOverviewModel;
import com.card.manager.factory.finance.model.CapitalPoolDetail;
import com.card.manager.factory.finance.model.Refilling;
import com.card.manager.factory.finance.model.Withdrawals;
import com.card.manager.factory.log.LogUtil;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.user.mapper.FinanceMapper;
import com.card.manager.factory.user.model.CardEntity;
import com.card.manager.factory.user.model.Rebate;
import com.card.manager.factory.user.model.RebateDownload;
import com.card.manager.factory.user.model.ShopRebate;
import com.card.manager.factory.user.service.FinanceMngService;
import com.card.manager.factory.util.DateUtil;
import com.card.manager.factory.util.ExcelUtil;
import com.card.manager.factory.util.FileDownloadUtil;
import com.card.manager.factory.util.JSONUtil;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.URLUtils;
import com.fasterxml.jackson.core.type.TypeReference;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

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

	@Resource
	FinanceMapper financeMapper;

	@Override
	@Log(content = "更新账号绑定银行卡信息", source = Log.BACK_PLAT, type = Log.MODIFY)
	public void updateCard(CardEntity cardInfo, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> goodscenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_CARDINFO_UPDATE, staffEntity.getToken(),
				true, cardInfo, HttpMethod.POST);

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
			operId = staffEntity.getUserCenterId() + "";
			operType = "2";
		} else if (staffEntity.getGradeLevel() == 2) {
			operId = staffEntity.getGradeId() + "";
			operType = "0";
		} else if (staffEntity.getGradeLevel() == 3) {
			operId = staffEntity.getShopId() + "";
			operType = "1";
		}
		params.put("id", operId);
		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_QUERY_CARDINFO + "?type=" + operType,
				staffEntity.getToken(), true, staffEntity, HttpMethod.GET, params);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		// return JSONUtilNew.parse(json.getJSONObject("obj").toString(),
		// CardEntity.class);
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), new TypeReference<List<CardEntity>>() {
		});

	}

	@Override
	public String checkCardNo(String cardNo, String token) throws Exception {

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_CARDNO_CHECK + "?cardNo=" + cardNo, token,
				true, null, HttpMethod.GET);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		if (!json.getBoolean("success")) {
			throw new Exception("校验银行卡信息失败:" + json.getString("errorMsg"));
		}
		// return json.getJSONObject("errorMsg").toString();
		return json.getString("errorMsg");
	}

	@Override
	@Log(content = "新增账号绑定银行卡信息", source = Log.BACK_PLAT, type = Log.ADD)
	public void insertCard(CardEntity cardInfo, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> goodscenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_CARDINFO_INSERT, staffEntity.getToken(),
				true, cardInfo, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(goodscenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("新增账号绑定银行卡信息失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public Rebate queryRebate(Integer id, String token) {

		RestCommonHelper helper = new RestCommonHelper();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("gradeId", id);
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
		params.put("gradeId", id);
		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_REBATE_QUERY, token, true, null,
				HttpMethod.GET, params);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), ShopRebate.class);
	}

	@Override
	public CardEntity queryInfoByCardId(CardEntity cardEntity, StaffEntity staffEntity) {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_QUERY_CARD_BY_CARDID,
				staffEntity.getToken(), true, cardEntity, HttpMethod.POST);

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
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_CARDINFO_DELETE, staffEntity.getToken(),
				true, null, HttpMethod.DELETE, params);

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
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_WITHDRAWALS_DETAIL_ID,
				staffEntity.getToken(), true, null, HttpMethod.POST, params);
		JSONObject json = JSONObject.fromObject(result.getBody());

		if (json.getBoolean("success")) {
			Detail = JSONUtilNew.parse(json.getJSONObject("obj").toString(), Withdrawals.class);
		}

		if (Detail != null) {
			Map<Integer, GradeBO> map = CachePoolComponent.getGrade(staffEntity.getToken());
			GradeBO grade = map.get(Detail.getOperatorId());
			if (grade != null) {
				Detail.setOperatorName(grade.getName());
			}
		}
		return Detail;
	}

	@Override
	@Log(content = "审核提现信息", source = Log.BACK_PLAT, type = Log.ADD)
	public void auditWithdrawals(AuditModel entity, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_WITHDRAWALS_AUDIT, staffEntity.getToken(),
				true, entity, HttpMethod.POST);
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
		params.put("gradeId", staffEntity.getGradeId());
		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_CARDINFO_LIST, staffEntity.getToken(),
				true, staffEntity, HttpMethod.GET, params);

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
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_USER_APPLY_WITHDRAWALS,
				staffEntity.getToken(), true, entity, HttpMethod.POST);

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
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_USER_APPLY_REFILLING,
				staffEntity.getToken(), true, entity, HttpMethod.POST, params);

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
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_REFILLING_DETAIL_ID,
				staffEntity.getToken(), true, null, HttpMethod.POST, params);
		JSONObject json = JSONObject.fromObject(result.getBody());

		if (json.getBoolean("success")) {
			// JSONObject tjson =
			// JSONObject.fromObject(json.getJSONObject("obj").toString());
			// Detail = JSONUtilNew.parse(tjson.getJSONObject("obj").toString(),
			// Refilling.class);
			Detail = JSONUtilNew.parse(json.getJSONObject("obj").toString(), Refilling.class);
		}
		if (Detail != null) {
			Map<Integer, GradeBO> map = CachePoolComponent.getGrade(staffEntity.getToken());
			GradeBO grade = map.get(Detail.getCenterId());
			if (grade != null) {
				Detail.setOperatorName(grade.getName());
			}
		}
		return Detail;
	}

	@Override
	@Log(content = "审核返充信息", source = Log.BACK_PLAT, type = Log.ADD)
	public void auditRefilling(AuditModel entity, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_REFILLING_AUDIT, staffEntity.getToken(),
				true, entity, HttpMethod.POST);
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
		ResponseEntity<String> result = helper.requestWithParams(URLUtils.get("gateway")
				+ ServerCenterContants.FINANCE_CENTER_CENTER_CHARGE + "?money=" + money + "&payNo=" + payNo,
				staffEntity.getToken(), true, null, HttpMethod.POST, params);
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
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_CENTER_LIQUIDATION + "?money=" + money,
				staffEntity.getToken(), true, null, HttpMethod.POST, params);
		JSONObject json = JSONObject.fromObject(result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("资金池清算失败，请联系技术人员！");
		}
	}

	@Override
	public Page<CapitalManagement> dataListByType(Pagination pagination, Map<String, Object> params) {
		PageHelper.startPage(pagination.getCurrentPage(), pagination.getNumPerPage(), true);
		return financeMapper.dataListByType(params);
	}

	@Override
	@Log(content = "添加资金池记录", source = Log.BACK_PLAT, type = Log.ADD)
	@Transactional(isolation = Isolation.READ_COMMITTED)
	public void insertCapitalPoolInfo(AddCapitalPoolInfoEntity entity) throws Exception {
		CapitalManagement capitalManagement = new CapitalManagement();
		capitalManagement.setCustomerId(entity.getCustomerId());
		capitalManagement.setCustomerName(entity.getCustomerName());
		capitalManagement.setCustomerType(entity.getCustomerType());
		capitalManagement.setCustomerCode(entity.getCustomerCode());
		capitalManagement.setOpt(entity.getOpt());

		CapitalManagementDetail capitalManagementDetail = new CapitalManagementDetail();
		capitalManagementDetail.setCustomerId(entity.getCustomerId());
		capitalManagementDetail.setCustomerType(entity.getCustomerType());
		capitalManagementDetail.setPayType(entity.getPayType());
		capitalManagementDetail.setMoney(entity.getMoney());
		capitalManagementDetail.setPayNo(entity.getPayNo());
		capitalManagementDetail.setBusinessNo(entity.getBusinessNo());
		capitalManagementDetail.setRemark(entity.getRemark());
		capitalManagementDetail.setOpt(entity.getOpt());

		List<CapitalManagementBusinessItem> itemList = new ArrayList<CapitalManagementBusinessItem>();
		for (CapitalManagementBusinessItem BusinessItem : entity.getItemList()) {
			if (BusinessItem.check()) {
				BusinessItem.setBusinessNo(entity.getBusinessNo());
				BusinessItem.setOpt(entity.getOpt());
				itemList.add(BusinessItem);
			}
		}

		financeMapper.insertOrUpdateCapitalManagement(capitalManagement);
		financeMapper.insertCapitalManagementDetail(capitalManagementDetail);
		if (itemList.size() > 0) {
			financeMapper.insertCapitalManagementBusinessItem(itemList);
		}
		financeMapper.updateCapitalManagementMoney(capitalManagementDetail);
	}

	@Override
	public CapitalManagement queryCapitalManagementByCustomerId(Map<String, Object> param) {
		return financeMapper.selectCapitalManagementByCustomerId(param);
	}

	@Override
	public Page<CapitalManagementDetail> dataListByCustomerId(Pagination pagination, Map<String, Object> params) {
		PageHelper.startPage(pagination.getCurrentPage(), pagination.getNumPerPage(), true);
		return financeMapper.dataListByCustomerId(params);
	}

	@Override
	public CapitalManagement totalCustomerByType(Map<String, Object> params) {
		return financeMapper.totalCustomerByType(params);
	}

	@Override
	public CapitalManagementDetail queryCapitalManagementDetailByParam(Map<String, Object> params) {
		return financeMapper.queryCapitalManagementDetailByParam(params);
	}

	@Override
	public Page<CapitalManagementBusinessItem> dataListByBusinessNo(Pagination pagination, Map<String, Object> params) {
		PageHelper.startPage(pagination.getCurrentPage(), pagination.getNumPerPage(), true);
		return financeMapper.dataListByBusinessNo(params);
	}

	@Override
	public List<CapitalManagementDownLoadEntity> queryCapitalPoolInfoListForDownload(Map<String, Object> params) {
		return financeMapper.queryInfoByParam(params);
	}

	@Override
	public CapitalOverviewModel getCapitalOverviewModel(String token, List<GradeBO> list) {
		RestCommonHelper helper = new RestCommonHelper();
		List<Integer> idList = new ArrayList<Integer>();
		if (list == null || list.size() == 0) {
			throw new RuntimeException("没有分级ID");
		}
		recursion(list, idList);
		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_GET_CAPITALPOOLOVERVIEW, token, true,
				idList, HttpMethod.POST);
		JSONObject json = JSONObject.fromObject(result.getBody());
		if (!json.getBoolean("success")) {
			throw new RuntimeException("资金池列表异常，请联系技术人员！");
		}
		return JSONUtil.parse(json.get("obj").toString(), CapitalOverviewModel.class);
	}

	private void recursion(List<GradeBO> list, List<Integer> result) {
		if (list != null && list.size() > 0) {
			for (GradeBO bo : list) {
				result.add(bo.getId());
				recursion(bo.getChildren(), result);
			}
		}
	}

	@Override
	public void addCapitalPool(CapitalPoolDetail entity, String token) {
		RestCommonHelper helper = new RestCommonHelper();
		if (entity == null) {
			throw new RuntimeException("没有分级对象");
		}
		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.FINANCE_CENTER_ADD_CAPITALPOOL, token, true, entity,
				HttpMethod.POST);
		JSONObject json = JSONObject.fromObject(result.getBody());
		if (!json.getBoolean("success")) {
			throw new RuntimeException(json.get("errorMsg") + "");
		}
	}

	@Override
	public void exportRebate(HttpServletRequest req, HttpServletResponse resp, Map<String, Object> param,
			StaffEntity staffEntity) {
		//获取要下载的数据
		List<RebateDownload> list = listDownLoadModel(param, staffEntity);
		//生成excel并下载
		try {
			createExcelAndDownLoad(req, resp, staffEntity, list);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("生成excel出错");
		}
	}

	private void createExcelAndDownLoad(HttpServletRequest req, HttpServletResponse resp, StaffEntity staffEntity,
			List<RebateDownload> list) throws Exception, IOException {
		WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
		ServletContext servletContext = webApplicationContext.getServletContext();

		String fileName = "rebate_" + DateUtil.getNowLongTime() + ".xlsx";
		String filePath = servletContext.getRealPath("/") + "EXCEL/" + staffEntity.getBadge() + "/" + fileName;

		String[] nameArray = new String[] { "订单号", "状态", "订单类型", "订单来源", "分级名称", "订单返佣", "自有编码", "商品编号", "品名", "零售价", "商品规格",
				"商品数量", "商品返佣" };
		String[] colArray = new String[] { "OrderId", "StatusName", "OrderType", "OrderSourceName", "GradeName", "TotalRebate", "ItemCode",
				"ItemId", "GoodsName", "ItemPrice", "Info", "Quantity", "Rebate" };
		SXSSFWorkbook swb = new SXSSFWorkbook(100);
		ExcelUtil.createExcel(list, nameArray, colArray, filePath, 0, "rebate_" + DateUtil.getNowLongTime(), swb);
		ExcelUtil.writeToExcel(swb, filePath);

		FileDownloadUtil.downloadFileByBrower(req, resp, filePath, fileName);
	}

	private List<RebateDownload> listDownLoadModel(Map<String, Object> param, StaffEntity staffEntity) {
		List<RebateDownload> list = new ArrayList<RebateDownload>();
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_QUERY_ORDERLISTFORDOWNLOAD,
				staffEntity.getToken(), true, null, HttpMethod.POST, param);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			throw new RuntimeException("获取返佣信息失败");
		}

		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();
		Map<Integer, GradeBO> gradeMap = CachePoolComponent.getGrade(staffEntity.getToken());
		try {
			String tmpItemInfo = "";
			for (int i = 0; i < index; i++) {
				JSONObject jObj = obj.getJSONObject(i);
				RebateDownload temp = JSONUtilNew.parse(jObj.toString(), RebateDownload.class);
				temp.setGradeName(gradeMap.get(Integer.valueOf(temp.getGradeId())).getName());
				switch (temp.getOrderFlag()) {
				case 0:
					temp.setOrderType("跨境订单");
					break;
				case 2:
					temp.setOrderType("一般贸易订单");
					break;
				default:
					temp.setOrderType("未知" + temp.getOrderFlag());
					break;
				}
				switch (temp.getStatus()) {
				case 0:
					temp.setStatusName("待到账");
					break;
				case 1:
					temp.setStatusName("已到账");
					break;
				case 2:
					temp.setStatusName("已退款");
					break;
				default:
					temp.setStatusName("未知：" + temp.getStatus());
					break;
				}
				switch (temp.getOrderSource()) {
				case 0:
					temp.setOrderSourceName("PC商城");
					break;
				case 1:
					temp.setOrderSourceName("手机商城");
					break;
				case 2:
					temp.setOrderSourceName("订货平台");
					break;
				case 3:
					temp.setOrderSourceName("有赞");
					break;
				case 4:
					temp.setOrderSourceName("线下");
					break;
				case 5:
					temp.setOrderSourceName("展厅");
					break;
				case 6:
					temp.setOrderSourceName("大客户");
					break;
				case 7:
					temp.setOrderSourceName("福利商城");
					break;
				case 8:
					temp.setOrderSourceName("后台订单");
					break;
				case 9:
					temp.setOrderSourceName("太平惠汇");
					break;
				case 10:
					temp.setOrderSourceName("小程序");
					break;
				case 11:
					temp.setOrderSourceName("聚民惠");
					break;
				case 12:
					temp.setOrderSourceName("拼多多");
					break;
				case 13:
					temp.setOrderSourceName("易捷北京");
					break;
				case 14:
					temp.setOrderSourceName("自营");
					break;
				case 15:
					temp.setOrderSourceName("金融工厂");
					break;
				default:
					temp.setOrderSourceName("未知：" + temp.getOrderSource());
					break;
				}
				if (temp.getInfo() != null) {
					tmpItemInfo = temp.getInfo();
					tmpItemInfo = tmpItemInfo.replace("\"", "");
					tmpItemInfo = tmpItemInfo.replace("{", "");
					tmpItemInfo = tmpItemInfo.replace("}", "");
					temp.setInfo(tmpItemInfo);
				}
				list.add(temp);
			}
		} catch (Exception e) {
			LogUtil.writeErrorLog("获取分级中文名称出错", e);
		}
		return list;
	}
}
