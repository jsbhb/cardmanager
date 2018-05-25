/**  
 * Project Name:cardmanager  
 * File Name:FileUploadSingleton.java  
 * Package Name:com.card.manager.factory.singleton  
 * Date:May 22, 201810:07:54 AM  
 *  
 */
package com.card.manager.factory.singleton;

import java.io.File;

import org.apache.commons.fileupload.disk.DiskFileItemFactory;

/**
 * ClassName: FileUploadSingleton <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: May 22, 2018 10:07:54 AM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class FileUploadSingleton {
	// 上传配置
	private static DiskFileItemFactory factory = null;
	private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3; // 3MB

	public static DiskFileItemFactory getInstance() {
		if (factory == null) {
			factory = new DiskFileItemFactory();
			// 设置内存临界值 - 超过后将产生临时文件并存储于临时目录中
			factory.setSizeThreshold(MEMORY_THRESHOLD);
			// 设置临时存储目录
			factory.setRepository(new File(System.getProperty("java.io.tmdir")));
		}

		return factory;
	}

}
