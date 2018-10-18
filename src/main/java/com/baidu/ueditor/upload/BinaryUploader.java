package com.baidu.ueditor.upload;

import java.io.File;
import java.io.InputStream;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.baidu.ueditor.define.AppInfo;
import com.baidu.ueditor.define.BaseState;
import com.baidu.ueditor.define.FileType;
import com.baidu.ueditor.define.State;
import com.card.manager.factory.common.ResourceContants;
import com.card.manager.factory.socket.task.SocketClient;
import com.card.manager.factory.util.FileUtil;
import com.card.manager.factory.util.URLUtils;

public class BinaryUploader {

	public static final State save(HttpServletRequest request, Map<String, Object> conf) {
		FileItemStream fileStream = null;
		boolean isAjaxUpload = request.getHeader("X_Requested_With") != null;

		if (!ServletFileUpload.isMultipartContent(request)) {
			return new BaseState(false, AppInfo.NOT_MULTIPART_CONTENT);
		}

		ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory());

		if (isAjaxUpload) {
			upload.setHeaderEncoding("UTF-8");
		}

		try {
			FileItemIterator iterator = upload.getItemIterator(request);

			while (iterator.hasNext()) {
				fileStream = iterator.next();

				if (!fileStream.isFormField())
					break;
				fileStream = null;
			}

			if (fileStream == null) {
				return new BaseState(false, AppInfo.NOTFOUND_UPLOAD_DATA);
			}

			String goodsId = request.getParameter("goodsId").toString();

			String savePath = (String) conf.get("savePath");
			String invitePath = URLUtils.get("static") + "/" + ResourceContants.GOODS + "/{goodsId}/"
					+ ResourceContants.DETAIL + "/" + ResourceContants.IMAGE + "/";
			String originFileName = fileStream.getName();
			String suffix = FileType.getSuffixByFilename(originFileName);
			String saveFileName = UUID.randomUUID().toString() + suffix;

			// long maxSize = ((Long) conf.get("maxSize")).longValue();
			//
			// if (!validType(suffix, (String[]) conf.get("allowFiles"))) {
			// return new BaseState(false, AppInfo.NOT_ALLOW_FILE_TYPE);
			// }

			// savePath = PathFormat.parse(savePath);
			// invitePath = PathFormat.parse(invitePath);
			savePath = savePath.replace("{goodsId}", goodsId);
			invitePath = invitePath.replace("{goodsId}", goodsId);

			// String physicalPath = (String) conf.get("rootPath") + savePath;

			InputStream is = fileStream.openStream();
			
			WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
			ServletContext servletContext = webApplicationContext.getServletContext();

			String path = servletContext.getRealPath("/") + "fileUpload/";
			File tmpFile = null;
			File fd = new File(path);
			if (!fd.exists()) {
				fd.mkdirs();
			}
			tmpFile = new File(path + "/" + saveFileName);
			FileUtil.inputStreamToFile(is, tmpFile);
			
			SocketClient client = null;
			try {
				client = new SocketClient();
				client.sendFile(tmpFile.getPath(), savePath);
				client.quit();
				client.close();
			} catch (Exception e) {
				return new BaseState(false, AppInfo.PARSE_REQUEST_ERROR);
			} finally {
				if (client != null) {
					client.close();
				}
				// 将临时文件删除
				File del = new File(tmpFile.toURI());
				del.delete();
			}

			// State storageState = StorageManager.saveFileByInputStream(is,
			// physicalPath, maxSize);
			// is.close();
			State storageState = new BaseState(true);
			if (storageState.isSuccess()) {
				storageState.putInfo("url", invitePath + saveFileName);
				storageState.putInfo("type", suffix);
				storageState.putInfo("original", originFileName + suffix);
			}

			return storageState;
		} catch (Exception e) {
			return new BaseState(false, AppInfo.PARSE_REQUEST_ERROR);
		}
	}

	// private static boolean validType(String type, String[] allowTypes) {
	// List<String> list = Arrays.asList(allowTypes);
	//
	// return list.contains(type);
	// }
}
