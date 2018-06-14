package com.card.manager.factory.express.model;

import java.util.List;

import com.card.manager.factory.base.Pagination;

public class ExpressTemplateBO extends Pagination{

	private Integer id;
	private Integer supplierId;
	private String supplierName;
	private String templateName;
	private Integer freePost;
	private Integer freeTax;
	private Integer enable;
	private List<ExpressFee> expressList;
	private String opt;
	public String getOpt() {
		return opt;
	}
	public void setOpt(String opt) {
		this.opt = opt;
	}
	public List<ExpressFee> getExpressList() {
		return expressList;
	}
	public String getSupplierName() {
		return supplierName;
	}
	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}
	public void setExpressList(List<ExpressFee> expressList) {
		this.expressList = expressList;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getSupplierId() {
		return supplierId;
	}
	public void setSupplierId(Integer supplierId) {
		this.supplierId = supplierId;
	}
	public String getTemplateName() {
		return templateName;
	}
	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}
	public Integer getFreePost() {
		return freePost;
	}
	public void setFreePost(Integer freePost) {
		this.freePost = freePost;
	}
	public Integer getFreeTax() {
		return freeTax;
	}
	public void setFreeTax(Integer freeTax) {
		this.freeTax = freeTax;
	}
	public Integer getEnable() {
		return enable;
	}
	public void setEnable(Integer enable) {
		this.enable = enable;
	}
}
