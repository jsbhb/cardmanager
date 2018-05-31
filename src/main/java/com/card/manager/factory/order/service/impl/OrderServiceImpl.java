/**  
 * Project Name:cardmanager  
 * File Name:SupplierServiceImpl.java  
 * Package Name:com.card.manager.factory.supplier.service.impl  
 * Date:Nov 7, 20173:22:23 PM  
 *  
 */
package com.card.manager.factory.order.service.impl;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.map.CaseInsensitiveMap;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.card.manager.factory.annotation.Log;
import com.card.manager.factory.auth.model.UserInfoBO;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.component.model.GradeBO;
import com.card.manager.factory.order.model.OperatorEntity;
import com.card.manager.factory.order.model.OrderDetail;
import com.card.manager.factory.order.model.OrderGoods;
import com.card.manager.factory.order.model.OrderInfo;
import com.card.manager.factory.order.model.ThirdOrderInfo;
import com.card.manager.factory.order.pojo.OrderImportBO;
import com.card.manager.factory.order.pojo.OrderInfoListForDownload;
import com.card.manager.factory.order.pojo.OrderMaintenanceBO;
import com.card.manager.factory.order.service.OrderService;
import com.card.manager.factory.supplier.model.SupplierEntity;
import com.card.manager.factory.system.mapper.StaffMapper;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.CalculationUtils;
import com.card.manager.factory.util.ExcelUtil;
import com.card.manager.factory.util.ExcelUtils;
import com.card.manager.factory.util.FileDownloadUtil;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.URLUtils;
import com.card.manager.factory.util.Utils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * ClassName: OrderServiceImpl <br/>
 * Function: 订单服务类. <br/>
 * date: Nov 7, 2017 3:22:23 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
@Service
public class OrderServiceImpl extends AbstractServcerCenterBaseService implements OrderService {

	@Resource
	StaffMapper<?> staffMapper;

	@Override
	public OrderInfo queryByOrderId(String orderId, String token) {
		OrderInfo entity = new OrderInfo();
		entity.setOrderId(orderId);

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_QUERY, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return JSONUtilNew.parse(json.getJSONObject("obj").toString(), OrderInfo.class);
	}

	@Override
	public List<OperatorEntity> queryOperatorInfoByOpt(StaffEntity staff) {
		return staffMapper.selectOperatorInfoByOpt(staff);
	}

	@Override
	@Log(content = "发起订单退款操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void applyOrderBack(String orderId, StaffEntity staff) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("orderId", orderId);
		ResponseEntity<String> result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_APPLY_ORDER_BACK, staff.getToken(), true,
				null, HttpMethod.POST, params);

		JSONObject json = JSONObject.fromObject(result.getBody());
		if (!json.getBoolean("success")) {
			throw new Exception("发起订单退款操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	@Log(content = "审核订单退款操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void auditOrderBack(String orderId, String payNo, StaffEntity staff) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("orderId", orderId);
		ResponseEntity<String> result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_AUDIT_ORDER_BACK + "?payNo=" + payNo,
				staff.getToken(), true, null, HttpMethod.POST, params);

		JSONObject json = JSONObject.fromObject(result.getBody());
		if (!json.getBoolean("success")) {
			throw new Exception("审核订单退款操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public List<ThirdOrderInfo> queryThirdOrderInfoByOrderId(String orderId, String token) {
		OrderInfo entity = new OrderInfo();
		entity.setOrderId(orderId);

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_QUERY_THIRD_INFO, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		List<ThirdOrderInfo> list = new ArrayList<ThirdOrderInfo>();
		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			list.add(JSONUtilNew.parse(jObj.toString(), ThirdOrderInfo.class));
		}

		return list;
	}

	@Override
	@Log(content = "发起订单取消功能操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void cancleTagFuncOrder(List<String> orderIds, StaffEntity staff) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_PRESELL_CANCLEFUNC, staff.getToken(), true,
				orderIds, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(result.getBody());
		if (!json.getBoolean("success")) {
			throw new Exception("发起订单取消功能操作失败:" + json.getString("errorMsg"));
		}
	}

	@Override
	public List<OrderInfoListForDownload> queryOrderInfoListForDownload(Map<String, Object> param, String token) {

		List<OrderInfoListForDownload> list = new ArrayList<OrderInfoListForDownload>();
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_QUERY_ORDERLISTFORDOWNLOAD, token, true,
				null, HttpMethod.POST, param);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			return list;
		}

		JSONArray obj = json.getJSONArray("obj");
		int index = obj.size();

		for (int i = 0; i < index; i++) {
			JSONObject jObj = obj.getJSONObject(i);
			list.add(JSONUtilNew.parse(jObj.toString(), OrderInfoListForDownload.class));
		}

		return list;
	}

	@Override
	@Log(content = "订单物流信息回填操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void maintenanceExpress(List<OrderMaintenanceBO> list, StaffEntity staff) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_MAINTENANCEEXPRESS, staff.getToken(), true,
				list, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(result.getBody());
		if (!json.getBoolean("success")) {
			throw new Exception("订单物流信息回填操作失败:" + json.getString("errorMsg"));
		}
	}

	private static final String FILE_NAME = "orderImportTpl.xlsx";

	@Override
	public void downLoadOrderImportExcel(HttpServletRequest req, HttpServletResponse resp, StaffEntity staffEntity)
			throws Exception {
		WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
		ServletContext servletContext = webApplicationContext.getServletContext();
		String filePath = servletContext.getRealPath("/") + "WEB-INF/classes/" + FILE_NAME;
		InputStream is = new FileInputStream(filePath);
		XSSFWorkbook xssfWorkbook = new XSSFWorkbook(is);
		List<SupplierEntity> suppliers = CachePoolComponent.getSupplier(staffEntity.getToken());
		String[] supplierHead = new String[] { "供应商编码", "供应商名称" };
		String[] supplierField = new String[] { "Id", "SupplierName" };
		ExcelUtil.createExcel(suppliers, supplierHead, supplierField, filePath, 0, "供应商对照表", xssfWorkbook);
		Map<Integer, GradeBO> gradeMap = CachePoolComponent.getGrade(staffEntity.getToken());
		List<GradeBO> centers = new ArrayList<GradeBO>();
		for (Map.Entry<Integer, GradeBO> entry : gradeMap.entrySet()) {
			centers.add(entry.getValue());
		}
		String[] centerHead = new String[] { "区域中心编码", "区域中心名称" };
		String[] centerField = new String[] { "Id", "Name" };
		ExcelUtil.createExcel(centers, centerHead, centerField, filePath, 0, "区域中心对照表", xssfWorkbook);
		ExcelUtil.writeToExcel(xssfWorkbook, filePath);
		FileDownloadUtil.downloadFileByBrower(req, resp, filePath, FILE_NAME);
	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> importOrder(String filePath, StaffEntity staffEntity) {
		List<OrderImportBO> list = ExcelUtils.instance().readExcel(filePath, OrderImportBO.class, true);
		Map<String, Object> result = new HashMap<String, Object>();
		if (list == null || list.size() == 0) {
			result.put("success", false);
			result.put("msg", "没有订单信息");
			return result;
		}
		String batchId = filePath.substring(filePath.lastIndexOf("/") + 1, filePath.lastIndexOf("."));
		if(batchId.length() > 20){//数据库存储长度只有20
			batchId = batchId.substring(0, 20);
		}
		OrderInfo info = null;
		OrderGoods goods = null;
		OrderDetail detail = null;
		List<OrderGoods> goodsList = null;
		UserInfoBO userInfo = null;
		Map<String, OrderInfo> infoMap = new HashMap<String, OrderInfo>();
		Map<String, UserInfoBO> userMap = new HashMap<String, UserInfoBO>();
		// 分装需要转换的数据
		Map<String, Integer> supplierMap = new CaseInsensitiveMap();
		Map<String, Integer> gradeMapTemp = new CaseInsensitiveMap();
		List<SupplierEntity> suppliers = CachePoolComponent.getSupplier(staffEntity.getToken());
		for (SupplierEntity entity : suppliers) {
			supplierMap.put(entity.getSupplierName(), entity.getId());
		}
		Map<Integer, GradeBO> gradeMap = CachePoolComponent.getGrade(staffEntity.getToken());
		for (Map.Entry<Integer, GradeBO> entry : gradeMap.entrySet()) {
			gradeMapTemp.put(entry.getValue().getName(), entry.getValue().getId());
		}
		// end
		List<String> fields = new ArrayList<String>();
		fields.add("payNo");// payNo可以为null
		for (OrderImportBO model : list) {
			// 初始化,并判断手机号和身份证是否正确
			if (!model.init(gradeMapTemp, supplierMap)) {
				result.put("success", false);
				result.put("msg", "订单号：" + model.getOrderId() + "请确认手机号是否正确，如果有身份证请确认身份证是否正确");
				return result;
			}
			// 判断是否有数据是空的
			if (!Utils.isAllFieldNotNull(model, fields)) {
				result.put("success", false);
				result.put("msg", "订单号：" + model.getOrderId() + "订单信息数据不全");
				return result;
			}
			// 放入订单信息
			if (!infoMap.containsKey(model.getOrderId())) {
				info = new OrderInfo(model);
				infoMap.put(info.getOrderId(), info);
			}
			// 封装商品和订单详细信息信息
			try {
				goods = new OrderGoods(model);
				if (infoMap.get(goods.getOrderId()).getOrderGoodsList() == null) {
					goodsList = new ArrayList<OrderGoods>();
					goodsList.add(goods);
					infoMap.get(goods.getOrderId()).setOrderGoodsList(goodsList);
				} else {
					infoMap.get(goods.getOrderId()).getOrderGoodsList().add(goods);
				}
				detail = new OrderDetail(model);
				if (infoMap.get(detail.getOrderId()).getOrderDetail() == null) {
					infoMap.get(detail.getOrderId()).setOrderDetail(detail);
				}
			} catch (NumberFormatException e) {
				result.put("success", false);
				result.put("msg", "订单号：" + info.getOrderId() + "数字类信息填写有误,请核对");
				return result;
			}
			userInfo = new UserInfoBO(model);
			if (!userMap.containsKey(userInfo.getPhone())) {
				userMap.put(userInfo.getPhone(), userInfo);
			}
		}
		// 开始判断订单金额是否正确、获取订单商品个数，并根据收货信息的手机号在用户中心进行注册
		RestCommonHelper helper = new RestCommonHelper();
		List<OrderInfo> infoList = new ArrayList<OrderInfo>();
		for (Map.Entry<String, OrderInfo> entry : infoMap.entrySet()) {
			entry.getValue().setTdq(entry.getValue().getOrderGoodsList().size());
			double payment = entry.getValue().getOrderDetail().getPayment();
			double amount = 0.0;
			for (OrderGoods goodstpl : entry.getValue().getOrderGoodsList()) {
				amount = CalculationUtils.add(amount,
						CalculationUtils.mul(goodstpl.getItemPrice(), goodstpl.getItemQuantity()));
			}
			amount = CalculationUtils.add(amount, entry.getValue().getOrderDetail().getTaxFee(),
					entry.getValue().getOrderDetail().getPostFee());
			if (amount != payment) {
				result.put("success", false);
				result.put("msg", "订单号：" + entry.getKey() + "金额计算和支付金额不匹配");
				return result;
			}
			int userId = syncUserCenter(userMap.get(info.getPhone()), helper);
			entry.getValue().setUserId(userId);
			entry.getValue().setCombinationId(batchId);//设置批次号
			infoList.add(entry.getValue());
		}
		// 保存订单
		try {
			ResponseEntity<String> usercenter_result = helper.request(
					URLUtils.get("gateway") + ServerCenterContants.ORDER_CENTER_IMPORT_ORDER, staffEntity.getToken(),
					true, infoList, HttpMethod.POST);

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

	private int syncUserCenter(UserInfoBO ucEntity, RestCommonHelper helper) {
		if (ucEntity == null) {
			return 0;
		}
		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.USER_CENTER_REGISTER, null, false, ucEntity,
				HttpMethod.POST);
		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());
		return (int) json.get("obj");
	}

}
