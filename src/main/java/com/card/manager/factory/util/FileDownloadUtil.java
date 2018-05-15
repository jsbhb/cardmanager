package com.card.manager.factory.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.RandomAccessFile;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FileDownloadUtil {
	public static void downloadFile(HttpServletRequest request, HttpServletResponse response, File file) throws Exception {
        RandomAccessFile raf = new RandomAccessFile(file, "r");
        FileInputStream fis = new FileInputStream(raf.getFD());
        response.setHeader("Accept-Ranges", "bytes");
        long pos = 0;
        long len;
        len = raf.length();
        if (request.getHeader("Range") != null) {
            response.setStatus(HttpServletResponse.SC_PARTIAL_CONTENT);
            pos = Long.parseLong(request.getHeader("Range")
                    .replaceAll("bytes=", "")
                    .replaceAll("-", "")
            );
        }
        response.setHeader("Content-Length", Long.toString(len - pos));
        if (pos != 0) {
            response.setHeader("Content-Range", new StringBuffer()
                    .append("bytes ")
                    .append(pos)
                    .append("-")
                    .append(Long.toString(len - 1))
                    .append("/")
                    .append(len)
                    .toString()
            );
        }
        String fileName = new String(file.getName().getBytes("UTF-8"),"ISO_8859_1");
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition", new StringBuffer()
                .append("attachment;filename=\"")
                .append(fileName)
                .append("\"").toString());
        raf.seek(pos);
        byte[] b = new byte[2048];
        int i;
        OutputStream outs = response.getOutputStream();
        while ((i = raf.read(b)) != -1) {
            outs.write(b, 0, i);
        }
        raf.close();
        fis.close();
    }

	public static void downloadFileByBrower(HttpServletRequest req, HttpServletResponse resp, String filePath, String fileName) throws IOException {
		req.setCharacterEncoding("UTF-8");
		// 第一步：设置响应类型
		resp.setContentType("application/force-download");// 应用程序强制下载
		InputStream in = new FileInputStream(filePath);
		// 设置响应头，对文件进行url编码
		fileName = URLEncoder.encode(fileName, "UTF-8");
		resp.setHeader("Content-Disposition", "attachment;filename=" + fileName);
		resp.setContentLength(in.available());

		// 第三步：老套路，开始copy
		OutputStream out = resp.getOutputStream();
		byte[] b = new byte[4096];
		int len = 0;
		while ((len = in.read(b)) != -1) {
			out.write(b, 0, len);
		}
		out.flush();
		out.close();
		in.close();
    }
}
