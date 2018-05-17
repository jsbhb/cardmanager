/**  
 * Project Name:cardmanager  
 * File Name:SupplierServiceImpl.java  
 * Package Name:com.card.manager.factory.supplier.service.impl  
 * Date:Nov 7, 20173:22:23 PM  
 *  
 */
package com.card.manager.factory.invoicing.service.impl;

import java.util.List;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.card.manager.factory.annotation.Log;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.goods.model.GoodsStockEntity;
import com.card.manager.factory.invoicing.service.InventoryService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONObject;

@Service
public class InventoryServiceImpl extends AbstractServcerCenterBaseService implements InventoryService {

	@Override
	@Log(content = "商品维护虚拟库存操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void maintainStock(List<GoodsStockEntity> stocks, StaffEntity staffEntity) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_MAINTAIN_STOCK_BY_ITEMID, staffEntity.getToken(), true,
				stocks, HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("商品维护虚拟库存操作失败:" + json.getString("errorMsg"));
		}
	}
}
