/**  
 * Project Name:cardmanager  
 * File Name:FtpService.java  
 * Package Name:com.card.manager.factory.ftp  
 * Date:Jan 2, 20189:37:31 PM  
 *  
 */
package com.card.manager.factory.ftp.service;

import java.io.InputStream;

import org.apache.commons.net.ftp.FTPClient;

import com.card.manager.factory.ftp.common.ReadIniInfo;

/**
 * ClassName: FtpService <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: Jan 2, 2018 9:37:31 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public interface SftpService {

	/**
	 * 登陆FTP服务器
	 */
	public void login(ReadIniInfo iniInfo) throws Exception;

	/**
	 * 断开服务器链接
	 */
	public void logout() throws Exception;

	/**
	 * 上传本地文件
	 */
	public void uploadFile(String remotePath, String fileNewName, InputStream inputStream, ReadIniInfo iniInfo,
			String pathContants) throws Exception;

	/**
	 * 下载远程文件
	 */
	public InputStream downFileByFtp(FTPClient ftpClient, String remotePath, String fileName) throws Exception;

	/**
	 * 
	 * @描述：删除文件
	 */
	public void delFile(FTPClient ftpClient, String pathName) throws Exception;

}
