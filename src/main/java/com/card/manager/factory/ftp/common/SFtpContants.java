/**  
 * Project Name:cardmanager  
 * File Name:SFtpContants.java  
 * Package Name:com.card.manager.factory.ftp.common  
 * Date:Apr 3, 20189:19:36 PM  
 *  
 */
package com.card.manager.factory.ftp.common;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * ClassName: SFtpContants <br/>
 * Function: SFtp单例. <br/>
 * date: Apr 3, 2018 9:19:36 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class SFtpContants {

	private static SFtpProperties sFtpProperties;
	private static Logger logger = LoggerFactory.getLogger(SFtpContants.class);

	public static SFtpProperties getInstance() {

		if (sFtpProperties == null) {

			Properties properties = new Properties();
			// 读取配置文件：ftpconfig.properties
			InputStream is = SFtpContants.class.getResourceAsStream("/ftpconfig.properties");

			try {
				properties.load(is);
				sFtpProperties = new SFtpProperties(properties.getProperty("ftpServer"),
						properties.getProperty("ftpPort"), properties.getProperty("ftpUser"),
						properties.getProperty("ftpPwd"));

			} catch (FileNotFoundException e) {
				logger.error("配置文件不存在..", e);
			} catch (IOException e) {
				logger.error("读取配置文件错误：", e);
			} finally {
				try {

					if (null != is) {
						is.close();
					}
				} catch (IOException e) {
					logger.error("关闭链接失败..", 3);
				}
			}
		}

		return sFtpProperties;
	}

}
