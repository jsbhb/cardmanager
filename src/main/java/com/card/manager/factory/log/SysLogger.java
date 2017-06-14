package com.card.manager.factory.log;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**
 * @author 贺斌 下午3:02:31 功能：系统日志
 */
@Component
public class SysLogger {

	protected final Logger logger_sys = LoggerFactory.getLogger(SysLogger.class);
	private final String INFO = "-info";
	private final String DEBUG = "-debug";
	private final String ERROR = "-error";

	public void info(String title, String content) {
		logger_sys.info("【" + title + INFO + "】" + content);
	}

	public void error(String title, String content) {
		logger_sys.error("【" + title + ERROR + "】" + content);
	}

	public void error(String title, String content, Exception e) {
		logger_sys.error("【" + title + ERROR + "】" + content, e);
	}

	public void debug(String title, String content) {
		logger_sys.debug("【" + title + DEBUG + "】" + content);
	}

}
