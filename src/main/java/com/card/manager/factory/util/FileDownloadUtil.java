package com.card.manager.factory.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.RandomAccessFile;

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

}
