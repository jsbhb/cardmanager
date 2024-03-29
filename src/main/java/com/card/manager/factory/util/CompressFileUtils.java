/**  
 * Project Name:cardmanager  
 * File Name:CompressFileUtils.java  
 * Package Name:com.card.manager.factory.util  
 * Date:May 21, 20185:02:55 PM  
 *  
 */
package com.card.manager.factory.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;

import com.github.junrar.Archive;
import com.github.junrar.rarfile.FileHeader;

/**
 * ClassName: CompressFileUtils <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: May 21, 2018 5:02:55 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class CompressFileUtils {
	// /**
	// * 解压到指定目录
	// *
	// * @param zipPath
	// * @param descDir
	// * @author
	// */
	// public static void unZipFiles(String zipPath, String descDir) throws
	// IOException {
	// unZipFiles(new File(zipPath), descDir);
	// }

	private static byte[] _byte = new byte[1024];

	/**
	 * 对.zip文件进行解压缩
	 * 
	 * @param zipFile
	 *            解压缩文件
	 * @param descDir
	 *            压缩的目标地址，如：D:\\测试 或 /mnt/d/测试
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static void unZipFiles(String zipFile, String descDir) {
		System.setProperty("sun.zip.encoding", System.getProperty("sun.jnu.encoding"));
		List<File> _list = new ArrayList<File>();
		try {
			ZipFile _zipFile = new ZipFile(new File(zipFile), "UTF-8");
			for (Enumeration entries = _zipFile.getEntries(); entries.hasMoreElements();) {
				ZipEntry entry = (ZipEntry) entries.nextElement();
				File _file = new File(descDir + File.separator + entry.getName());
				if (entry.isDirectory()) {
					_file.mkdirs();
				} else {
					File _parent = _file.getParentFile();
					if (!_parent.exists()) {
						_parent.mkdirs();
					}
					InputStream _in = _zipFile.getInputStream(entry);
					OutputStream _out = new FileOutputStream(_file);
					int len = 0;
					while ((len = _in.read(_byte)) > 0) {
						_out.write(_byte, 0, len);
					}
					_in.close();
					_out.flush();
					_out.close();
					_list.add(_file);
				}
			}
		} catch (IOException e) {
		}
	}

	/**
	 * 解压文件到指定目录
	 * 
	 * @param zipFile
	 * @param descDir
	 * @author isea533
	 */
	@SuppressWarnings("rawtypes")
	public static void unZipFiles(File zipFile, String descDir) throws IOException {
		System.setProperty("sun.zip.encoding", System.getProperty("sun.jnu.encoding"));
		File pathFile = new File(descDir);
		if (!pathFile.exists()) {
			pathFile.mkdirs();
		}
		ZipFile zip = new ZipFile(zipFile, "UTF-8");
		for (Enumeration entries = zip.getEntries(); entries.hasMoreElements();) {
			ZipEntry entry = (ZipEntry) entries.nextElement();
			String zipEntryName = File.separator + entry.getName();
			InputStream in = zip.getInputStream(entry);
			String outPath = (descDir + zipEntryName).replaceAll("\\*", "/");
			;
			// 判断路径是否存在,不存在则创建文件路径
			File file = new File(outPath.substring(0, outPath.lastIndexOf('/')));
			if (!file.exists()) {
				file.mkdirs();
			}
			// 判断文件全路径是否为文件夹,如果是上面已经上传,不需要解压
			if (new File(outPath).isDirectory()) {
				continue;
			}
			// 输出文件路径信息
			System.out.println(outPath);

			OutputStream out = new FileOutputStream(outPath);
			byte[] buf1 = new byte[1024];
			int len;
			while ((len = in.read(buf1)) > 0) {
				out.write(buf1, 0, len);
			}
			in.close();
			out.close();
		}
		System.out.println("******************解压完毕********************");
	}

	/**
	 * 根据原始rar路径，解压到指定文件夹下.
	 * 
	 * @param srcRarPath
	 *            原始rar路径
	 * @param dstDirectoryPath
	 *            解压到的文件夹
	 */
	public static void unRarFile(String srcRarPath, String dstDirectoryPath) {
		if (!srcRarPath.toLowerCase().endsWith(".rar")) {
			System.out.println("非rar文件！");
			return;
		}
		File dstDiretory = new File(dstDirectoryPath);
		if (!dstDiretory.exists()) {// 目标目录不存在时，创建该文件夹
			dstDiretory.mkdirs();
		}
		Archive a = null;
		try {
			a = new Archive(new File(srcRarPath));
			if (a != null) {
				a.getMainHeader().print(); // 打印文件信息.
				FileHeader fh = a.nextFileHeader();
				while (fh != null) {
					if (fh.isDirectory()) { // 文件夹
						File fol = new File(dstDirectoryPath + File.separator + fh.getFileNameString());
						fol.mkdirs();
					} else { // 文件
						File out = new File(dstDirectoryPath + File.separator + fh.getFileNameString().trim());
						// System.out.println(out.getAbsolutePath());
						try {// 之所以这么写try，是因为万一这里面有了异常，不影响继续解压.
							if (!out.exists()) {
								if (!out.getParentFile().exists()) {// 相对路径可能多级，可能需要创建父目录.
									out.getParentFile().mkdirs();
								}
								out.createNewFile();
							}
							FileOutputStream os = new FileOutputStream(out);
							a.extractFile(fh, os);
							os.close();
						} catch (Exception ex) {
							ex.printStackTrace();
						}
					}
					fh = a.nextFileHeader();
				}
				a.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
