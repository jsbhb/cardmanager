package com.card.manager.factory.socket.util;

import java.io.IOException;
import java.net.Socket;
import java.net.UnknownHostException;

import com.card.manager.factory.socket.exception.ConnetionParamErrorException;
import com.card.manager.factory.socket.task.SocketClient;
import com.card.manager.factory.util.StringUtil;

/**
 * 
 * ClassName: SocketDataTransfer <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: 2018年9月30日 上午11:48:48 <br/>
 * 
 * @author why
 * @version
 * @since JDK 1.7
 */
public abstract class SocketDataTransfer {

	private SocketClient client;

	/**
	 * 
	 * connetion:(这里用一句话描述这个方法的作用). <br/>
	 * 
	 * @author why
	 * @param ip
	 * @param port
	 * @param isDefault
	 * @return
	 * @throws UnknownHostException
	 * @throws IOException
	 * @throws ConnetionParamErrorException
	 * @since JDK 1.7
	 */
	final SocketClient connetion(String ip, String port, boolean isDefault)
			throws UnknownHostException, IOException, ConnetionParamErrorException {
		if (isDefault) {
			client = new SocketClient();
		} else {
			if (StringUtil.isEmpty(ip)) {
				throw new ConnetionParamErrorException("ip为空");
			}
			if (StringUtil.isEmpty(port)) {
				throw new ConnetionParamErrorException("port为空");
			}
			client = new SocketClient(ip, port);
		}
		return client;
	};

	/**
	 * 
	 * dataTansfer:(这里用一句话描述这个方法的作用). <br/>  
	 *  
	 * @author why  
	 * @return  
	 * @since JDK 1.7
	 */
	abstract int dataTansfer();

	/**
	 * 
	 * getSocket:(这里用一句话描述这个方法的作用). <br/>  
	 *  
	 * @author why  
	 * @return  
	 * @since JDK 1.7
	 */
	final Socket getSocket() {
		return client.getSocket();
	}

	/**
	 * 
	 * closeConnetion:(这里用一句话描述这个方法的作用). <br/>  
	 *  
	 * @author why  
	 * @throws IOException  
	 * @since JDK 1.7
	 */
	final void closeConnetion() throws IOException {
		client.quit();
	}
}
