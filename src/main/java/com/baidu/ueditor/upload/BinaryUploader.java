package com.baidu.ueditor.upload;

import java.io.InputStream;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.baidu.ueditor.PathFormat;
import com.baidu.ueditor.define.AppInfo;
import com.baidu.ueditor.define.BaseState;
import com.baidu.ueditor.define.FileType;
import com.baidu.ueditor.define.State;
import com.card.manager.factory.common.ResourceContants;
import com.card.manager.factory.ftp.common.ReadIniInfo;
import com.card.manager.factory.ftp.service.SftpService;
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
			

			String savePath = (String) conf.get("savePath");
			String invitePath = URLUtils.get("static") + "/" + ResourceContants.IMAGE + "/{yyyy}{mm}{dd}/";
			String originFileName = fileStream.getName();
			String suffix = FileType.getSuffixByFilename(originFileName);
			String saveFileName = UUID.randomUUID().toString() + suffix;
			ReadIniInfo iniInfo = new ReadIniInfo();

			// long maxSize = ((Long) conf.get("maxSize")).longValue();
			//
			// if (!validType(suffix, (String[]) conf.get("allowFiles"))) {
			// return new BaseState(false, AppInfo.NOT_ALLOW_FILE_TYPE);
			// }

			savePath = PathFormat.parse(savePath);
			invitePath = PathFormat.parse(invitePath);

			// String physicalPath = (String) conf.get("rootPath") + savePath;

			InputStream is = fileStream.openStream();

			WebApplicationContext wac = ContextLoader.getCurrentWebApplicationContext();
			SftpService service = (SftpService)wac.getBean("sftpService");
			service.login(iniInfo);
			service.uploadFile(savePath, saveFileName, is, iniInfo, "");

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
		// return new BaseState(false, AppInfo.IO_ERROR);
	}

	private static boolean validType(String type, String[] allowTypes) {
		List<String> list = Arrays.asList(allowTypes);

		return list.contains(type);
	}
}
