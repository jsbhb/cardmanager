/**  
 * Project Name:cardmanager  
 * File Name:SftpServiceImpl.java  
 * Package Name:com.card.manager.factory.ftp.service.impl  
 * Date:Jan 3, 201812:58:42 AM  
 *  
 */
package com.card.manager.factory.ftp.service.impl;

import java.io.InputStream;
import java.util.Properties;

import org.apache.commons.net.ftp.FTPClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.card.manager.factory.ftp.common.ReadIniInfo;
import com.card.manager.factory.ftp.service.SftpService;
import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;

/**
 * ClassName: SftpServiceImpl <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: Jan 3, 2018 12:58:42 AM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
@Service
public class SftpServiceImpl implements SftpService {

	Logger logger = LoggerFactory.getLogger(SftpServiceImpl.class);

	private ChannelSftp sftp;

	private Session session;

	@Override
	public void login(ReadIniInfo iniInfo) throws Exception {

		ReadIniInfo info = new ReadIniInfo();

		JSch jsch = new JSch();
		logger.info("sftp connect by host:{} username:{}", info.getFtpServer(), info.getFtpUser());

		session = jsch.getSession(info.getFtpUser(), info.getFtpServer(), Integer.parseInt(info.getFtpPort()));
		logger.info("Session is build");
		if (info.getFtpPwd() != null) {
			session.setPassword(info.getFtpPwd());
		}
		Properties config = new Properties();
		config.put("StrictHostKeyChecking", "no");

		session.setConfig(config);
		session.connect();
		logger.info("Session is connected");

		Channel channel = session.openChannel("sftp");
		channel.connect();
		logger.info("channel is connected");

		sftp = (ChannelSftp) channel;
		logger.info(String.format("sftp server host:[%s] port:[%s] is connect successfull", info.getFtpServer(),
				Integer.parseInt(info.getFtpPort())));
	}

	@Override
	public void logout() throws Exception {
		if (sftp != null) {
			if (sftp.isConnected()) {
				sftp.disconnect();
				logger.info("sftp is closed already");
			}
		}
		if (session != null) {
			if (session.isConnected()) {
				session.disconnect();
				logger.info("sshSession is closed already");
			}
		}
	}

	@Override
	public void uploadFile(String remotePath, String sftpFileName, InputStream inputStream, ReadIniInfo iniInfo,
			String pathContants) throws Exception {
		try {
			sftp.cd(remotePath + pathContants);
		} catch (SftpException e) {
			logger.warn("directory is not exist");
			sftp.mkdir(remotePath + pathContants);
			sftp.cd(remotePath + pathContants);
		}
		sftp.put(inputStream, sftpFileName);
		logger.info("file:{} is upload successful", sftpFileName);
	}

	@Override
	public InputStream downFileByFtp(FTPClient ftpClient, String remotePath, String fileName) throws Exception {
		return null;
	}

	@Override
	public void delFile(FTPClient ftpClient, String pathName) throws Exception {

	}

}
