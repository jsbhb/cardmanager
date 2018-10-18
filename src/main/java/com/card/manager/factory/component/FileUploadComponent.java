package com.card.manager.factory.component;

import java.io.IOException;
import java.net.UnknownHostException;

import com.card.manager.factory.socket.exception.ConnetionParamErrorException;

/**
 * 
 * ClassName: FileUploadComponent <br/>  
 * Function: TODO ADD FUNCTION. <br/>   
 * date: 2018年9月30日 下午12:04:18 <br/>  
 *  
 * @author why  
 * @version   
 * @since JDK 1.7
 */
public abstract class FileUploadComponent {
	
	protected abstract String createLocalPath();
	
	protected abstract String createRemotePath();
	
	protected abstract void fileUpload(String localPath, String RemotePath,String ip,String port)throws UnknownHostException, IOException, ConnetionParamErrorException;

}
