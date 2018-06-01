package com.card.manager.factory.auth.model;

import com.card.manager.factory.order.pojo.OrderImportBO;
import com.card.manager.factory.util.Utils;

/**
 * ClassName: UserInfo <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: Aug 16, 2017 2:22:47 PM <br/>
 * 
 * @author wqy
 * @version
 * @since JDK 1.7
 */
public class UserInfoBO {

	private Integer id;

	private Integer userType;

	private String account;

	private String phone;

	private String email;

	private String wechat;

	private String qq;

	private String sinaBlog;

	private String pwd;

	private Integer parentId;

	private Integer band;

	private Integer phoneValidate;

	private Integer emailValidate;

	private Integer status;

	private Integer centerId;

	private Integer shopId;
	
	private Integer guideId;

	private String lastLoginTime;

	private String lastLoginIP;

	private String ipCity;

	private String createTime;

	private String vipTime;

	private Integer duration;

	private String updateTime;

	private String opt;

	private UserDetail userDetail;

	private Integer vipLevel;
	
	private Address address;
	
	public UserInfoBO(){}

	public UserInfoBO(OrderImportBO model) {
		if(!"".equals(model.getPhone()) && !"".equals(model.getName()) && !"".equals(model.getIdNum())){
			phone = Utils.removePoint(model.getPhone());
			userDetail = new UserDetail();
			userDetail.setName(Utils.removePoint(model.getName()));
			userDetail.setIdNum(Utils.removePoint(model.getIdNum()));
		} else {
			phone = Utils.removePoint(model.getReceivePhone());
			userDetail = new UserDetail();
			userDetail.setName(model.getReceiveName());
		}
		centerId = 2;
		shopId = model.getShopId();
		phoneValidate = 1;
		address = new Address();
		address.setAddress(model.getAddress());
		address.setArea(model.getArea());
		address.setCity(model.getCity());
		address.setProvince(model.getProvince());
		address.setReceiveName(model.getReceiveName());
		address.setReceivePhone(Utils.removePoint(model.getReceivePhone()));
	}

	public boolean check() {
		return (account != null || phone != null || email != null) && centerId != null;
	}
	
	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}
	
	public Integer getGuideId() {
		return guideId;
	}

	public void setGuideId(Integer guideId) {
		this.guideId = guideId;
	}

	public Integer getUserType() {
		return userType;
	}

	public void setUserType(Integer userType) {
		this.userType = userType;
	}

	public Integer getVipLevel() {
		return vipLevel;
	}

	public void setVipLevel(Integer vipLevel) {
		this.vipLevel = vipLevel;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getWechat() {
		return wechat;
	}

	public void setWechat(String wechat) {
		this.wechat = wechat;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getSinaBlog() {
		return sinaBlog;
	}

	public void setSinaBlog(String sinaBlog) {
		this.sinaBlog = sinaBlog;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getVipTime() {
		return vipTime;
	}

	public void setVipTime(String vipTime) {
		this.vipTime = vipTime;
	}

	public Integer getDuration() {
		return duration;
	}

	public void setDuration(Integer duration) {
		this.duration = duration;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public Integer getBand() {
		return band;
	}

	public void setBand(Integer band) {
		this.band = band;
	}

	public Integer getPhoneValidate() {
		return phoneValidate;
	}

	public void setPhoneValidate(Integer phoneValidate) {
		this.phoneValidate = phoneValidate;
	}

	public Integer getEmailValidate() {
		return emailValidate;
	}

	public void setEmailValidate(Integer emailValidate) {
		this.emailValidate = emailValidate;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getCenterId() {
		return centerId;
	}

	public void setCenterId(Integer centerId) {
		this.centerId = centerId;
	}

	public Integer getShopId() {
		return shopId;
	}

	public void setShopId(Integer shopId) {
		this.shopId = shopId;
	}

	public String getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(String lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public String getLastLoginIP() {
		return lastLoginIP;
	}

	public void setLastLoginIP(String lastLoginIP) {
		this.lastLoginIP = lastLoginIP;
	}

	public String getIpCity() {
		return ipCity;
	}

	public void setIpCity(String ipCity) {
		this.ipCity = ipCity;
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

	public UserDetail getUserDetail() {
		return userDetail;
	}

	public void setUserDetail(UserDetail userDetail) {
		this.userDetail = userDetail;
	}

	@Override
	public String toString() {
		return "UserInfo [id=" + id + ", userType=" + userType + ", account=" + account + ", phone=" + phone
				+ ", email=" + email + ", wechat=" + wechat + ", qq=" + qq + ", sinaBlog=" + sinaBlog + ", pwd=" + pwd
				+ ", parentId=" + parentId + ", band=" + band + ", phoneValidate=" + phoneValidate + ", emailValidate="
				+ emailValidate + ", status=" + status + ", centerId=" + centerId + ", shopId=" + shopId + ", guideId="
				+ guideId + ", lastLoginTime=" + lastLoginTime + ", lastLoginIP=" + lastLoginIP + ", ipCity=" + ipCity
				+ ", createTime=" + createTime + ", vipTime=" + vipTime + ", duration=" + duration + ", updateTime="
				+ updateTime + ", opt=" + opt + ", userDetail=" + userDetail + ", vipLevel=" + vipLevel + "]";
	}

}
