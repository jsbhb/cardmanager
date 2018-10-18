package com.card.manager.factory.socket.util;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.UnknownHostException;

import com.card.manager.factory.log.LogUtil;
import com.card.manager.factory.socket.exception.ConnetionParamErrorException;

/**
 * 
 * ClassName: FileTransfer <br/>
 * date: 2018年9月30日 上午11:48:39 <br/>
 * 
 * @author why
 * @version
 * @since JDK 1.7
 */
public class FileTransfer extends SocketDataTransfer {

	private String localPath;
	private String remotePath;
	DataOutputStream dos = null; // 上传服务器：输出流
	DataInputStream dis = null; // 获取服务器：输入流
	FileInputStream fis = null; // 读取文件：输入流
	Long serverLength = -1l; // 存储在服务器的文件长度，默认-1
	Long clientLength = -1l; // 存储在客户端的文件长度，默认-1


	public FileTransfer(String localPath, String remotePaht,String ip,String port) throws UnknownHostException, IOException, ConnetionParamErrorException {
		this.localPath = localPath;
		this.remotePath = remotePaht;
		connetion(ip, port, false);
	}

	@Override
	public int dataTansfer() {
		
		int result = 0;
		
		// 获取：上传文件
		File file = new File(localPath);

		// ==================== 节点：文件是否存在 ====================
		if (file.exists()) {
			try {
				dos = new DataOutputStream(getSocket().getOutputStream());
			} catch (IOException e2) {
				LogUtil.writeErrorLog("Socket客户端：1.读取输出流发生错误");
				e2.printStackTrace();
			}
			// 发送：向服务器发送 文件名称(包含存放目录)、文件长度

			try {
				dos.writeUTF(remotePath + "," + file.getName());
				dos.flush();
				dos.writeLong(file.length());
				// 读取到文件时将文件长度赋值给默认
				clientLength = file.length();
				dos.flush();
			} catch (IOException e2) {
				LogUtil.writeErrorLog("Socket客户端：2.向服务器发送文件名、长度发生错误");
				e2.printStackTrace();
			}

			// 获取：读取服务器已上传文件长度
			try {
				dis = new DataInputStream(getSocket().getInputStream());
			} catch (IOException e2) {
				LogUtil.writeErrorLog("Socket客户端：3.读取服务器上文件发生错误");
				e2.printStackTrace();
			}
			while (serverLength == -1) {
				try {
					serverLength = dis.readLong();
				} catch (IOException e) {
					LogUtil.writeErrorLog("Socket客户端：4.读取服务器上文件长度错误");
					e.printStackTrace();
				}
			}

			// 读取：需要上传的文件
			try {
				fis = new FileInputStream(file);
			} catch (FileNotFoundException e2) {
				LogUtil.writeErrorLog("Socket客户端：5.读取本地需要上传的文件失败，请确认文件是否存在");
				e2.printStackTrace();
			}
			// 发送：向服务器传输输入流
			// try {
			// dos = new DataOutputStream(client.getOutputStream());
			// } catch (IOException e2) {
			// System.out.println("Socket客户端：6.向服务器传输输入流发生错误");
			// e2.printStackTrace();
			// }

			LogUtil.writeLog("======== 开始传输文件 ========");
			// 定义最大读取长度
			byte[] bytes = new byte[1024];
			int length = 1024;

			// 设置游标：文件读取的位置
			if (serverLength == -1l) {
				serverLength = 0l;
			}
			try {
				// 跳过指定个字符之后开始读取文件内容

				// 比较服务器文件的长度与本地文件的长度
				// 判断是重传还是续传
				if (serverLength >= clientLength) {
					fis.skip(0l);
				} else {
					fis.skip(serverLength);
				}
			} catch (IOException e1) {
				LogUtil.writeErrorLog("Socket客户端：7.设置游标位置发生错误，请确认文件流是否被篡改");
				e1.printStackTrace();
			}

			try {
				// 循环读取文件内容并发送给服务器
				while (true) {
					if (((length = fis.read(bytes, 0, bytes.length)) == -1)) {
						getSocket().shutdownOutput();
						break;
					}
					dos.write(bytes, 0, length);
					dos.flush();
				}
				result = (int) dis.readLong();
			} catch (IOException e) {
				LogUtil.writeErrorLog("Socket客户端：8.设置游标位置发生错误，请确认文件流是否被篡改");
				e.printStackTrace();
			} finally {
				if (fis != null)
					try {
						fis.close();
					} catch (IOException e1) {
						LogUtil.writeErrorLog("Socket客户端：9.关闭读取的输入流异常");
						e1.printStackTrace();
					}
				if (dos != null)
					try {
						dos.close();
					} catch (IOException e1) {
						LogUtil.writeErrorLog("Socket客户端：10.关闭发送的输出流异常");
						e1.printStackTrace();
					}
				try {
					getSocket().close();
				} catch (IOException e) {
					LogUtil.writeErrorLog("Socket客户端：11.关闭客户端异常");
					e.printStackTrace();
				}
			}
			LogUtil.writeLog("======== 文件传输成功 ========");

		} else {
			LogUtil.writeLog("Socket客户端：0.文件不存在");
			return -1;
		}

		return result;
	}

}
