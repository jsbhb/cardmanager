package com.card.manager.factory.util;

import java.io.FileInputStream;
import java.io.InputStream;

public class FileUtil {
	
	public String readFileByByte(String fileName) throws Exception {

		String classPath = this.getClass().getResource("/").getPath();
		InputStream in = null;
		StringBuffer sb = new StringBuffer();
		try {
			// 一次读多个字节
			byte[] tempbytes = new byte[1024];
			int byteread = 0;
			in = new FileInputStream(classPath + fileName);
			// 读入多个字节到字节数组中，byteread为一次读入的字节数
			while ((byteread = in.read(tempbytes)) != -1) {
				String str = new String(tempbytes, 0, byteread, "utf-8");
				sb.append(str);
			}

		} catch (Exception e1) {
			e1.printStackTrace();
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (Exception e1) {
				}
			}
		}
		return sb.toString();
	}
}
