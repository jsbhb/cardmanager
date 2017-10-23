package com.card.manager.factory.auth.model;

/**
 * 
 * @author hebin
 *
 */
public class UserInfo {
	private String userName;
	private String password;
	private String userId;
	private int platUserType;
	private int loginType;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getPlatUserType() {
		return platUserType;
	}

	public void setPlatUserType(int platUserType) {
		this.platUserType = platUserType;
	}

	public UserInfo(String userName, String password, String userId, int platUserType) {
		super();
		this.userName = userName;
		this.password = password;
		this.userId = userId;
		this.platUserType = platUserType;
		this.loginType = 3;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getLoginType() {
		return loginType;
	}

	public void setLoginType(int loginType) {
		this.loginType = loginType;
	}
	
	

}
