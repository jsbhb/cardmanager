package com.card.manager.factory.info.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.info.model.NewsModel;
import com.card.manager.factory.info.model.PublishModel;
import com.card.manager.factory.info.model.RecommendGoods;
import com.card.manager.factory.info.service.InfoService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.HttpClientUtil;
import com.card.manager.factory.util.JSONUtil;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.URLUtils;
import com.fasterxml.jackson.core.type.TypeReference;

import net.sf.json.JSONObject;

@Service
public class InfoServiceImpl implements InfoService {

	private final String BAIDU_SUBMIT = "http://data.zz.baidu.com/urls?appid=1621515334865835&token=rMPIWi2BGUpDp6Kw&type=realtime";
	
	@Override
	public void saveAndPublishNews(NewsModel model, StaffEntity entity) throws Exception {
		PublishModel pm = new PublishModel(model);
		RestCommonHelper helper = new RestCommonHelper();
		Map<String, Object> param = new HashMap<>();
		param.put("type", model.getType());
		//随机获取新闻
		ResponseEntity<String> resultEntity = helper.requestWithParams(
				URLUtils.get("gateway") + ServerCenterContants.LIST_NEWS_RAND, entity.getToken(), true, model,
				HttpMethod.GET, param);
		JSONObject json = JSONObject.fromObject(resultEntity.getBody());
		if (json.getBoolean("success")) {
			List<NewsModel> newsList = JSONUtilNew.parse(json.get("obj").toString(), new TypeReference<List<NewsModel>>() {
			});
			pm.initNews(newsList);
		}
		//随机获取商品
		resultEntity = helper.request(
				URLUtils.get("gateway") + ServerCenterContants.LIST_GOODS_RAND, entity.getToken(), true, model,
				HttpMethod.GET);
		json = JSONObject.fromObject(resultEntity.getBody());
		if (json.getBoolean("success")) {
			List<RecommendGoods> goodsList = JSONUtilNew.parse(json.get("obj").toString(), new TypeReference<List<RecommendGoods>>() {
			});
			pm.initRecommendGoods(goodsList);
		}
		pm.initSort();
		pm.setSystem("pcMall");
		String result = HttpClientUtil.post(URLUtils.get("publishUrl"), JSONUtil.toJson(pm), "application/json", true);
		if (result.contains("false")) {
			throw new Exception("发布失败");
		}
		pm.setSystem("mpMall");
		result = HttpClientUtil.post(URLUtils.get("publishUrl"), JSONUtil.toJson(pm), "application/json", true);
		if (result.contains("false")) {
			throw new Exception("发布失败");
		}
		String domain = URLUtils.get("mpDomain");
		if(domain.contains("https://m")){
			String url = domain + pm.getPath() + "/" + pm.getFile() + ".html";
			HttpClientUtil.post(BAIDU_SUBMIT, url, "text/plain", false);
		}
		model.setInvitePath(pm.getPath() + "/" + pm.getFile() + ".html");
		// 将对象保存到微服务数据库中
		resultEntity = helper.request(URLUtils.get("gateway") + ServerCenterContants.SAVE_NEWS, entity.getToken(), true,
				model, HttpMethod.POST);

		json = JSONObject.fromObject(resultEntity.getBody());

		if (!json.getBoolean("success")) {
			throw new Exception("新增数据操作失败:" + json.getString("errorMsg"));
		}
	}

}
