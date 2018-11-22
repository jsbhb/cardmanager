package com.card.manager.factory.user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.customer.model.Address;
import com.card.manager.factory.customer.service.PurchaseService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.user.service.UserAddressMngService;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;

@Controller
@RequestMapping("/admin/user/userAddressMng")
public class UserAddressMngController extends BaseController {
	
	@Resource
	UserAddressMngService userAddressMngService;
	
	@Resource
	PurchaseService purchaseService;

	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		
		Map<String, Object> addressParams = new HashMap<String, Object>();
		addressParams.put("userId", opt.getUserCenterId());
		List<Address> addressList = purchaseService.getUserAddressInfo(addressParams, opt.getToken());
		context.put("addressList", addressList);
		
		return forword("user/address/list", context);
	}
	
	@RequestMapping(value = "/deleteUserAddress", method = RequestMethod.POST)
	public void deleteUserAddress(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity opt = SessionUtils.getOperator(req);
		try {
			String addressId = req.getParameter("addressId");
			if (StringUtil.isEmpty(addressId)) {
				sendFailureMessage(resp, "删除收货地址失败，缺少必要参数！");
				return;
			}

			Map<String, Object> params = new HashMap<String, Object>();
			params.put("userId", opt.getUserCenterId());
			params.put("id", addressId);
			userAddressMngService.deleteUserAddress(params, opt.getToken());
			sendSuccessMessage(resp, "");
		} catch (Exception e) {
			e.printStackTrace();
			sendFailureMessage(resp, e.getMessage());
		}
	}
}
