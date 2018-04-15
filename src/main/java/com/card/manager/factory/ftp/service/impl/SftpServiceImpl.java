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

import com.card.manager.factory.ftp.common.SFtpContants;
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
@Service("sftpService")
public class SftpServiceImpl implements SftpService {

	Logger logger = LoggerFactory.getLogger(SftpServiceImpl.class);

	private ChannelSftp sftp = null;

	private Session session = null;

	private Boolean isLogin = false;

	@Override
	public void login() throws Exception {

		JSch jsch = new JSch();

		logger.info("start sftp connect by host:{} username:{}", SFtpContants.getInstance().getServer(),
				SFtpContants.getInstance().getUser());

		logger.info("start create session by host:{} username:{}", SFtpContants.getInstance().getServer(),
				SFtpContants.getInstance().getUser());
		session = jsch.getSession(SFtpContants.getInstance().getUser(), SFtpContants.getInstance().getServer(),
				Integer.parseInt(SFtpContants.getInstance().getPort()));
		logger.info("Session is build");
		if (SFtpContants.getInstance().getPwd() != null) {
			session.setPassword(SFtpContants.getInstance().getPwd());
		}

		logger.info("start connect session by host:{} username:{}", SFtpContants.getInstance().getServer(),
				SFtpContants.getInstance().getUser());
		Properties config = new Properties();
		config.put("StrictHostKeyChecking", "no");
		session.setConfig(config);
		session.connect();
		logger.info("Session is connected");

		Channel channel = session.openChannel("sftp");
		channel.connect();
		logger.info("channel is connected");

		sftp = (ChannelSftp) channel;
		logger.info(String.format("sftp server host:[%s] port:[%s] is connect successfull",
				SFtpContants.getInstance().getServer(), SFtpContants.getInstance().getUser()));
		isLogin = true;

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
	public synchronized void uploadFile(String remotePath, String sftpFileName, InputStream inputStream,
			String pathContants) throws Exception {
		try {
				login();
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
