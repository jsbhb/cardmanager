package com.card.manager.factory.auth.model;

/**
 * 
 * ClassName: UserInfo <br/>
 * Function: 用户登录<br/>
 * date: Oct 24, 2017 4:37:11 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class UserInfo {
	private int userId;//
	private int platUserType;
	private int loginType;
	private int userCenterId;

	public UserInfo() {

	}

	public UserInfo(int platUserType, int loginType, int userId) {
		this.platUserType = platUserType;
		this.loginType = loginType;
		this.userId = userId;
	}

	public int getUserCenterId() {
		return userCenterId;
	}

	public void setUserCenterId(int userCenterId) {
		this.userCenterId = userCenterId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getPlatUserType() {
		return platUserType;
	}

	public void setPlatUserType(int platUserType) {
		this.platUserType = platUserType;
	}

	public int getLoginType() {
		return loginType;
	}

	public void setLoginType(int loginType) {
		this.loginType = loginType;
	}
}
