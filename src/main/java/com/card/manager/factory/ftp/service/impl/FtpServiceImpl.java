/**  
 * Project Name:cardmanager  
 * File Name:FtpServiceImpl.java  
 * Package Name:com.card.manager.factory.ftp.service.impl  
 * Date:Jan 2, 20189:40:59 PM  
 *  
 */
package com.card.manager.factory.ftp.service.impl;

import java.io.IOException;
import java.io.InputStream;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.card.manager.factory.ftp.common.ReadIniInfo;
import com.card.manager.factory.ftp.service.FtpService;

/**
 * ClassName: FtpServiceImpl <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: Jan 2, 2018 9:40:59 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
@Service
public class FtpServiceImpl implements FtpService {

	Logger logger = LoggerFactory.getLogger(FtpServiceImpl.class);

	@Override
	public void login(FTPClient ftpClient, ReadIniInfo iniInfo) throws Exception {
		// 获取FTP服务器地址
		String ftpServer = iniInfo.getFtpServer();
		// 获取FTP服务器端口
		String ftpPort = iniInfo.getFtpPort();
		// 获取FTP用户账号
		String ftpUser = iniInfo.getFtpUser();
		// 获取FTP用户密码
		String ftpPwd = iniInfo.getFtpPwd();

		try {
			// 链接到FTP服务器
			ftpClient.connect(ftpServer, Integer.valueOf(ftpPort));

			logger.info("链接到FTP服务器：" + ftpServer + "成功..");
			// 开始登陆服务器
			boolean boo = ftpClient.login(ftpUser, ftpPwd);
			if (boo) {
				logger.info("登陆到FTP服务器：" + ftpServer + "成功..");
			} else {
				logger.info("登陆到FTP服务器：" + ftpServer + "失败..");
				logout(ftpClient);// 退出/断开FTP服务器链接
			}

		} catch (Exception e) {
			logger.error("登陆到FTP服务器：" + ftpServer + "失败..");
		}
	}

	@Override
	public void logout(FTPClient ftpClient) throws Exception {
		ftpClient.logout();// 退出登陆

		logger.info("已退出FTP远程服务器..");

		if (ftpClient.isConnected()) {
			ftpClient.disconnect();// 断开链接
			logger.info("已断开FTP服务器链接..");
		}
	}

	@Override
	public void uploadFile(FTPClient ftpClient, String remotePath, String fileNewName, InputStream inputStream,
			ReadIniInfo iniInfo, String pathContants) throws Exception {
		try {

			String ftpRemotePath = iniInfo.getFtpRemotePath();// ftp目的地仓库位置,而文件实例地址=仓库位置+上传指定位置
			// 设置被动模式
			// 设置PassiveMode传输
			ftpClient.enterLocalPassiveMode();

			// 设置以二进制流的方式传输
			ftpClient.setFileType(FTP.BINARY_FILE_TYPE);

			// 设置字符集
			ftpClient.setControlEncoding("UTF-8");
			// 创建目录结构
			if (pathContants != null && !"".equals(pathContants.trim())) {
				String[] pathes = pathContants.split("/");
				for (String onepath : pathes) {
					if (onepath == null || "".equals(onepath.trim())) {
						continue;
					}
					onepath = new String(onepath.getBytes("UTF-8"), "UTF-8");
					if (!ftpClient.changeWorkingDirectory(onepath)) {
						ftpClient.makeDirectory(onepath);// 创建FTP服务器目录
						ftpClient.changeWorkingDirectory(onepath);// 改变FTP服务器目录
					}
				}
			}
			boolean boo = ftpClient.storeFile(new String(fileNewName.getBytes("UTF-8"), "UTF-8"), inputStream);
			if (boo) {
				logger.info("文件上传成功..");
			} else {
				logger.info("文件上传失败..");
			}

		} catch (Exception e) {
			logger.info(e.getMessage());
		} finally {
			try {
				if (null != inputStream) {
					inputStream.close();
				}
				logout(ftpClient);// 退出/断开FTP服务器链接
			} catch (IOException e) {
				logger.info("关闭链接失败..");
			}
		}
	}

	@Override
	public InputStream downFileByFtp(FTPClient ftpClient, String remotePath, String fileName) throws Exception {
		return null;
	}

	@Override
	public void delFile(FTPClient ftpClient, String pathName) throws Exception {

	}

}
