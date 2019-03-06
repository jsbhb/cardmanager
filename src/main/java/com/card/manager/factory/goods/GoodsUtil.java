/**  
 * Project Name:cardmanager  
 * File Name:GoodsUtil.java  
 * Package Name:com.card.manager.factory.goods  
 * Date:Dec 25, 20173:14:41 PM  
 *  
 */
package com.card.manager.factory.goods;

import java.util.ArrayList;
import java.util.List;

import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.goods.model.FirstCatalogEntity;
import com.card.manager.factory.goods.model.GoodsItemEntity;
import com.card.manager.factory.goods.model.KJGoodsEntity;
import com.card.manager.factory.goods.model.KJSpecsGoodsEntity;
import com.card.manager.factory.goods.model.SecondCatalogEntity;
import com.card.manager.factory.goods.model.ThirdCatalogEntity;
import com.card.manager.factory.goods.pojo.ItemSpecsPojo;
import com.card.manager.factory.goods.pojo.po.BackGoodsPO;
import com.card.manager.factory.goods.pojo.po.Goods;
import com.card.manager.factory.goods.pojo.po.GoodsSpecs;
import com.card.manager.factory.util.JSONUtilNew;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * ClassName: GoodsUtil <br/>
 * Function: 商品库改造商品信息转换工具. <br/>
 * date: Dec 25, 2017 3:14:41 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class GoodsUtil {

	public static void changeSpecsInfo(GoodsItemEntity entity) {
		String info = entity.getInfo();
		if (info == null || "".equals(info)) {
			return;
		}

		JSONArray array = JSONArray.fromObject(info.substring(1, info.length() - 1));
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < array.size(); i++) {
			JSONObject obj = array.getJSONObject(i);
			sb.append(obj.getString("skV"));
			sb.append(":");
			sb.append(obj.getString("svV"));
			sb.append(";");
		}

		entity.setSimpleInfo(sb.toString());
	}

	public static void changeSpecsGoodsInfo(List<KJSpecsGoodsEntity> kjSpecsGoodsList) {
		for (KJSpecsGoodsEntity entity : kjSpecsGoodsList) {
			String info = entity.getInfo();
			if (info == null || "".equals(info)) {
				return;
			}

			JSONArray array = JSONArray.fromObject(info.substring(1, info.length() - 1));
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < array.size(); i++) {
				JSONObject obj = array.getJSONObject(i);
				sb.append(obj.getString("skV"));
				sb.append(":");
				sb.append(obj.getString("svV"));
				sb.append("|");
			}
			entity.setInfo(sb.toString());
		}
	}

	public static void changeCategoryInfo(List<KJGoodsEntity> kjGoodsList, String token) {
		List<FirstCatalogEntity> first = CachePoolComponent.getFirstCatalog(token);
		List<SecondCatalogEntity> second = CachePoolComponent.getSecondCatalog(token);
		List<ThirdCatalogEntity> third = CachePoolComponent.getThirdCatalog(token);
		for (KJGoodsEntity entity : kjGoodsList) {
			for (FirstCatalogEntity fce : first) {
				if (entity.getFirstCategory().equals(fce.getFirstId())) {
					entity.setFirstCategory(fce.getName());
					break;
				}
			}
			for (SecondCatalogEntity sce : second) {
				if (entity.getSecondCategory().equals(sce.getSecondId())) {
					entity.setSecondCategory(sce.getName());
					break;
				}
			}
			for (ThirdCatalogEntity tce : third) {
				if (entity.getThirdCategory().equals(tce.getThirdId())) {
					entity.setThirdCategory(tce.getName());
					break;
				}
			}
		}
	}

	public static void changeGoodsCategoryInfo(BackGoodsPO backGoodsPo, String token) {
		List<FirstCatalogEntity> first = CachePoolComponent.getFirstCatalog(token);
		List<SecondCatalogEntity> second = CachePoolComponent.getSecondCatalog(token);
		List<ThirdCatalogEntity> third = CachePoolComponent.getThirdCatalog(token);
		Goods entity = backGoodsPo.getGoods();
		for (FirstCatalogEntity fce : first) {
			if (entity.getFirstCategory().equals(fce.getFirstId())) {
				entity.setFirstCategoryName(fce.getName());
				break;
			}
		}
		for (SecondCatalogEntity sce : second) {
			if (entity.getSecondCategory().equals(sce.getSecondId())) {
				entity.setSecondCategoryName(sce.getName());
				break;
			}
		}
		for (ThirdCatalogEntity tce : third) {
			if (entity.getThirdCategory().equals(tce.getThirdId())) {
				entity.setThirdCategoryName(tce.getName());
				break;
			}
		}
	}

	public static void changeGoodsSpecsInfoToList(List<GoodsSpecs> gslist) {
		for (GoodsSpecs gs:gslist) {
			JSONArray jsonArray = JSONArray.fromObject(gs.getInfo());
			int index = jsonArray.size();
			List<ItemSpecsPojo> list = new ArrayList<ItemSpecsPojo>();
			for (int i = 0; i < index; i++) {
				JSONObject jObj = jsonArray.getJSONObject(i);
				list.add(JSONUtilNew.parse(jObj.toString(), ItemSpecsPojo.class));
			}
			gs.setItemSpecsList(list);
		}
	}
}
