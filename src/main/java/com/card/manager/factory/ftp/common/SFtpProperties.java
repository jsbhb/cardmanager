/**  
 * Project Name:cardmanager  
 * File Name:SFtpProperties.java  
 * Package Name:com.card.manager.factory.ftp.common  
 * Date:Apr 3, 20189:20:21 PM  
 *  
 */
package com.card.manager.factory.ftp.common;

/**
 * ClassName: SFtpProperties <br/>
 * Function: sftp属性. <br/>
 * date: Apr 3, 2018 9:20:21 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class SFtpProperties {

	private String server;// 服务器地址
	private String port;// 服务器端口
	private String user;// 用户账号
	private String pwd;// 用户密码
	

	public SFtpProperties(String server, String port, String user, String pwd) {
		this.server = server;
		this.port = port;
		this.user = user;
		this.pwd = pwd;
	}

	public String getServer() {
		return server;
	}

	public void setServer(String server) {
		this.server = server;
	}

	public String getPort() {
		return port;
	}

	public void setPort(String port) {
		this.port = port;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

}
