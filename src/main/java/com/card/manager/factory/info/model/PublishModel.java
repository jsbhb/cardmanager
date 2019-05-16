package com.card.manager.factory.info.model;

import java.util.ArrayList;
import java.util.List;

import com.card.manager.factory.util.DateUtil;

public class PublishModel {

	private String page;
	private String file;
	private String path;
	private String region;
	private String system;
	private SeoModel seo;
	private List<ContentModel> module;

	public PublishModel(NewsModel model) {
		page = "information";
		file = System.currentTimeMillis() + "";
		try {
			path = "/info/" + DateUtil.getNowShortDate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		seo = model.getSeo();
		module = new ArrayList<>();
		ContentModel m = new ContentModel();
		m.setArea("body");
		m.setCode("message-1");
		module.add(m);
		m = new ContentModel();
		m.setArea("body");
		m.setCode("alertDefault-1");
		module.add(m);
		m = new ContentModel();
		m.setArea("body");
		m.setCode("alertDiscount-1");
		module.add(m);
		m = new ContentModel();
		m.setArea("bodyHeader");
		m.setCode("header-1");
		module.add(m);
		m = new ContentModel();
		m.setArea("bodyHeader");
		m.setCode("header-2");
		module.add(m);
		m = new ContentModel();
		m.setArea("bodyHeader");
		m.setCode("nav-1");
		module.add(m);
		for (ContentModel cm : model.getModule()) {
			module.add(cm);
		}
	}

	public void initRecommendGoods(List<RecommendGoods> goodsList) {
		ContentModel m = new ContentModel();
		m.setArea("bodyCenter");
		m.setCode("goodsList-right");
		Cont c = null;
		List<Cont> list = new ArrayList<>();
		for (RecommendGoods goods : goodsList) {
			c = new Cont();
			c.setAlt(goods.getGoodsName());
			c.setHref("/" + goods.getHref() + ".html");
			c.setPrice(goods.getPrice());
			c.setSrc(goods.getPicPath());
			c.setText(goods.getGoodsName());
			c.setLinePrice(goods.getLinePrice());
			list.add(c);
		}
		m.setCont(list);
		module.add(m);
	}

	public void initSort() {
		ContentModel m = new ContentModel();
		m.setArea("bodyFooter");
		m.setCode("footer-1");
		module.add(m);
		for (int i = 0; i < module.size(); i++) {
			module.get(i).setSort((i + 1) + "");
		}
	}

	public void initNews(List<NewsModel> newsList) {
		ContentModel m = new ContentModel();
		m.setArea("bodyCenter");
		m.setCode("newsList-right");
		Cont c = null;
		List<Cont> list = new ArrayList<>();
		for (NewsModel newsModel : newsList) {
			c = new Cont();
			c.setAlt(newsModel.getCreateTime());
			c.setHref(newsModel.getInvitePath());
			c.setSrc(newsModel.getCoverPic());
			c.setText(newsModel.getInfoTitle());
			list.add(c);
		}
		m.setCont(list);
		module.add(m);
	}

	public String getPage() {
		return page;
	}

	public void setPage(String page) {
		this.page = page;
	}

	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getSystem() {
		return system;
	}

	public void setSystem(String system) {
		this.system = system;
	}

	public SeoModel getSeo() {
		return seo;
	}

	public void setSeo(SeoModel seo) {
		this.seo = seo;
	}

	public List<ContentModel> getModule() {
		return module;
	}

	public void setModule(List<ContentModel> module) {
		this.module = module;
	}
}
