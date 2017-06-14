package com.card.manager.factory.util;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Map;

public class HttpsGetJpgUtil {
	/**
	 * 测试
	 * 
	 * @param args
	 */
	public static void main(String[] args) {
		String[] urls = {
				"http://cg-trade.cainiao.com/tfscom/TB1puJrPFXXXXcLXFXXXXXXXXXX.tfsprivate.jpg",
				"http://cg-trade.cainiao.com/tfscom/TB1_f8bPFXXXXb6XVXXXXXXXXXX.tfsprivate.jpg",
					"http://cg-trade.cainiao.com/tfscom/TB18LXFPFXXXXXfXpXXXXXXXXXX.tfsprivate.jpg",
					"http://cg-trade.cainiao.com/tfscom/TB16ihaPFXXXXc4aXXXXXXXXXXX.tfsprivate.jpg",
					"http://cg-trade.cainiao.com/tfscom/TB1NexmPFXXXXa9XFXXXXXXXXXX.tfsprivate.jpg",
					"http://cg-trade.cainiao.com/tfscom/TB13EXnPFXXXXXCXVXXXXXXXXXX.tfsprivate.jpg",
					"http://cg-trade.cainiao.com/tfscom/TB1b88kPFXXXXbQXVXXXXXXXXXX.tfsprivate.jpg",
					"http://cg-trade.cainiao.com/tfscom/TB1cM8NPFXXXXcnXXXXXXXXXXXX.tfsprivate.jpg",
					"http://cg-trade.cainiao.com/tfscom/TB1J6JSPFXXXXcXXXXXXXXXXXXX.tfsprivate.jpg"
				};

		for (int i = 0; i < urls.length; i++) {
			byte[] btImg = getImageFromNetByUrl(urls[i].replace("http", "https"));
			if (null != btImg && btImg.length > 0) {
				System.out.println("读取到：" + btImg.length + " 字节");
			} else {
				System.out.println("没有从该连接获得内容");
			}
		}
	}

	/**
	 * 将图片写入到磁盘
	 * 
	 * @param img
	 *            图片数据流
	 * @param fileName
	 *            文件保存时的名称
	 */
	public static void writeImageToDisk(byte[] img, String fileName) {
		try {
			File file = new File(fileName);
			FileOutputStream fops = new FileOutputStream(file);
			fops.write(img);
			fops.flush();
			fops.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 根据地址获得数据的字节流
	 * 
	 * @param strUrl
	 *            网络连接地址
	 * @return
	 */
	public static byte[] getImageFromNetByUrl(String strUrl) {
		try {
			URL url = new URL(strUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setConnectTimeout(5 * 1000);
			System.out.println("**************开始打印头"+strUrl+"信息***************");
			boolean flag = false;
			for(Map.Entry<String, List<String>> entry : conn.getHeaderFields().entrySet()){
				
				System.out.println(entry.getKey()+"======="+entry.getValue());
				if(entry.getKey() != null){
					if(entry.getKey().contains("Content-type") && entry.getValue().contains("unknown/unknown")){
						flag = true;
						break;
					}
				}
			}
			System.out.println("*************结束打印*********************");
			if(flag){
				Thread.sleep(5000);
				return getImageFromNetByUrl(strUrl);
			}
			InputStream inStream = conn.getInputStream();// 通过输入流获取图片数据
			byte[] btImg = readInputStream(inStream);// 得到图片的二进制数据
			return btImg;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 从输入流中获取数据
	 * 
	 * @param inStream
	 *            输入流
	 * @return
	 * @throws Exception
	 */
	public static byte[] readInputStream(InputStream inStream) throws Exception {
		ByteArrayOutputStream outStream = new ByteArrayOutputStream();
		byte[] buffer = new byte[1024];
		int len = 0;
		while ((len = inStream.read(buffer)) != -1) {
			outStream.write(buffer, 0, len);
		}
		inStream.close();
		return outStream.toByteArray();
	}
}
