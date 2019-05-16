package com.card.manager.factory.info.model;

import java.util.List;

public class NewsModel {

	private String infoTitle;
	private String coverPic;
	private int type;
	private String invitePath;
	private String introduction;
	private SeoModel seo;
	private List<ContentModel> module;
	private String createTime;
	private String opt;

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public String getOpt() {
		return opt;
	}

	public void setOpt(String opt) {
		this.opt = opt;
	}

	public String getInvitePath() {
		return invitePath;
	}

	public void setInvitePath(String invitePath) {
		this.invitePath = invitePath;
	}

	public String getInfoTitle() {
		return infoTitle;
	}

	public void setInfoTitle(String infoTitle) {
		this.infoTitle = infoTitle;
	}

	public String getCoverPic() {
		return coverPic;
	}

	public void setCoverPic(String coverPic) {
		this.coverPic = coverPic;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
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
class ContentModel {
	private String code;
	private String sort;
	private String area;
	private Cont own;
	private List<Cont> cont;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public Cont getOwn() {
		return own;
	}

	public void setOwn(Cont own) {
		this.own = own;
	}

	public List<Cont> getCont() {
		return cont;
	}

	public void setCont(List<Cont> cont) {
		this.cont = cont;
	}

}

class Cont {
	private String href;
	private String text;
	private String alt;
	private String src;
	private String price;
	private String linePrice;

	public String getLinePrice() {
		return linePrice;
	}

	public void setLinePrice(String linePrice) {
		this.linePrice = linePrice;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getAlt() {
		return alt;
	}

	public void setAlt(String alt) {
		this.alt = alt;
	}

	public String getSrc() {
		return src;
	}

	public void setSrc(String src) {
		this.src = src;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getHref() {
		return href;
	}

	public void setHref(String href) {
		this.href = href;
	}

}

class SeoModel {
	private String title;
	private String keywords;
	private String description;

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
}
