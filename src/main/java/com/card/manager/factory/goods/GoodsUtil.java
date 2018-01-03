/**  
 * Project Name:cardmanager  
 * File Name:GoodsUtil.java  
 * Package Name:com.card.manager.factory.goods  
 * Date:Dec 25, 20173:14:41 PM  
 *  
 */
package com.card.manager.factory.goods;

import com.card.manager.factory.goods.model.GoodsItemEntity;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * ClassName: GoodsUtil <br/>
 * Function: TODO ADD FUNCTION. <br/>
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

		JSONArray array = JSONArray.fromObject(info.substring(1,info.length()-1));
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

}
