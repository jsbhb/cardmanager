/**  
 * Project Name:cardmanager  
 * File Name:SupplierServiceImpl.java  
 * Package Name:com.card.manager.factory.supplier.service.impl  
 * Date:Nov 7, 20173:22:23 PM  
 *  
 */
package com.card.manager.factory.goods.service.impl;

import javax.annotation.Resource;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.card.manager.factory.annotation.Log;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.common.serivce.impl.AbstractServcerCenterBaseService;
import com.card.manager.factory.goods.model.GoodsBaseEntity;
import com.card.manager.factory.goods.service.GoodsBaseService;
import com.card.manager.factory.supplier.model.SupplierEntity;
import com.card.manager.factory.system.mapper.StaffMapper;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONObject;

/**
 * ClassName: SupplierServiceImpl <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: Nov 7, 2017 3:22:23 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
@Service
public class GoodsBaseServiceImpl extends AbstractServcerCenterBaseService implements GoodsBaseService {

	@Resource
	StaffMapper staffMapper;

	@Override
	@Log(content = "新增商品基础信息操作", source = Log.BACK_PLAT, type = Log.ADD)
	public void addEntity(GoodsBaseEntity entity, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();
		int baseId = staffMapper.nextVal(ServerCenterContants.GOODS_BASE_ID_SEQUENCE);
		entity.setId(baseId);

		ResponseEntity<String> usercenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_BASE_SAVE, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(usercenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("新增商品基础信息操作失败:" + json.getString("errorMsg"));
		}

	}

	@Override
	public GoodsBaseEntity queryById(String id, String token) {
		SupplierEntity entity = new SupplierEntity();
		entity.setId(Integer.parseInt(id));

		RestCommonHelper helper = new RestCommonHelper();
		ResponseEntity<String> query_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_BASE_QUERY, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(query_result.getBody());
		return new GoodsBaseEntity(json.getJSONObject("obj"));
	}

	@Override
	@Log(content = "更新商品基础信息操作", source = Log.BACK_PLAT, type = Log.MODIFY)
	public void updEntity(GoodsBaseEntity entity, String token) throws Exception {
		RestCommonHelper helper = new RestCommonHelper();

		ResponseEntity<String> goodscenter_result = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.GOODS_CENTER_BASE_EDIT, token, true, entity,
				HttpMethod.POST);

		JSONObject json = JSONObject.fromObject(goodscenter_result.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("更新商品基础信息操作失败:" + json.getString("errorMsg"));
		}

	}

}
