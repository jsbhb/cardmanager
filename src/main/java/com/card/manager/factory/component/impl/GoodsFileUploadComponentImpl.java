package com.card.manager.factory.component.impl;

import java.io.IOException;
import java.net.UnknownHostException;

import com.card.manager.factory.common.ResourceContants;
import com.card.manager.factory.component.FileUploadComponent;
import com.card.manager.factory.socket.exception.ConnetionParamErrorException;
import com.card.manager.factory.socket.util.FileTransfer;

/**
 * 
 * ClassName: FileUploadComponentImpl <br/>
 * date: 2018年9月30日 下午12:04:05 <br/>
 * 
 * @author why
 * @version
 * @since JDK 1.7
 */
public class GoodsFileUploadComponentImpl extends FileUploadComponent {

	private String goodsId;

	public GoodsFileUploadComponentImpl(String goodsId) {
		this.goodsId = goodsId;
	}

	@Override
	protected String createLocalPath() {
		return null;
	}

	@Override
	public String createRemotePath() {
		return ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.GOODS + "/" + goodsId + "/"
				+ ResourceContants.MASTER + "/" + ResourceContants.IMAGE + "/";
	}

	@Override
	public void fileUpload(String localPath, String RemotePath,String ip,String port) throws UnknownHostException, IOException, ConnetionParamErrorException {
		FileTransfer ft = new FileTransfer(localPath, RemotePath,ip,port);
		ft.dataTansfer();
	}
	
	public static void main(String[] args) {
		GoodsFileUploadComponentImpl fuc = new GoodsFileUploadComponentImpl("123");
		try {
			fuc.fileUpload("C:\\Users\\wanghaiyang\\Desktop\\4.jpg", fuc.createRemotePath(),"127.0.0.1","10086");
		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ConnetionParamErrorException e) {
			e.printStackTrace();
		}
	}

}
