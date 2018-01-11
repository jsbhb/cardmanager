package com.card.manager.factory.goods.model;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnore;


public class GoodsFile implements Serializable{

	private static final long serialVersionUID = 1L;

	@JsonIgnore
	private Integer id;
	
	private String goodsId;
	
	private String path;
	
	private String suffix;
	@JsonIgnore
	private Integer storeType;
	@JsonIgnore
	private Integer type;
	@JsonIgnore
	private String createTime;
	@JsonIgnore
	private String updateTime;
	@JsonIgnore
	private String opt;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getSuffix() {
		return suffix;
	}

	public void setSuffix(String suffix) {
		this.suffix = suffix;
	}

	public Integer getStoreType() {
		return storeType;
	}

	public void setStoreType(Integer storeType) {
		this.storeType = storeType;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public String getOpt() {
		return opt;
	}

	public void setOpt(String opt) {
		this.opt = opt;
	}

	@Override
	public String toString() {
		return "GoodsFile [id=" + id + ", goodsId=" + goodsId + ", path=" + path + ", suffix=" + suffix + ", storeType="
				+ storeType + ", type=" + type + ", createTime=" + createTime + ", updateTime=" + updateTime + ", opt="
				+ opt + "]";
	}
	
}