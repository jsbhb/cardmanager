package com.card.manager.factory.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.swing.ImageIcon;

import org.krysalis.barcode4j.HumanReadablePlacement;
import org.krysalis.barcode4j.impl.code128.Code128Bean;
import org.krysalis.barcode4j.output.bitmap.BitmapCanvasProvider;
import org.krysalis.barcode4j.tools.UnitConv;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGEncodeParam;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

/**
 * 说明：条形码工具类
 * 
 * @author 赵增丰
 * @version 1.0 2015年1月15日 下午4:27:33
 */
@SuppressWarnings("restriction")
public class BarCodeUtil {

	/**
	 * CODE128是一种高效率条码. 它一共映射了106种编码, 每种编码针对不同版本的CODE128(CODE128A, CODE128B,
	 * CODE128C), 代表了不同的数据组合. 同时, 每种编码通过11个黑白条模块的组合实现. 终止符比较特殊,由13个模块组成.
	 * 
	 * @param fileName
	 * @return
	 */
	public static boolean createCode128Barcode(String barCodeName, String num,String date) {
		boolean generateResult = false;// 是否生成
		Code128Bean bean = new Code128Bean();

		WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
		ServletContext servletContext = webApplicationContext.getServletContext();
		String destPath_ = servletContext.getRealPath("/") + "output/" + date;
		if (!new File(destPath_).exists()) {
			new File(destPath_).mkdirs();
		}
		String destPath = servletContext.getRealPath("/") + "output/" + date + "/" + barCodeName
				+ ".jpg";
		final int dpi = 125;// 分辨率
		// barcode
		bean.setModuleWidth(UnitConv.in2mm(1.0f / dpi));
		// bean.setHeight(20);
		// bean.doQuietZone(false);
		bean.setQuietZone(0);// 两边空白区
		bean.setFontSize(2);
		bean.setMsgPosition(HumanReadablePlacement.HRP_BOTTOM);// 数字位置

		OutputStream out = null;
		File outputFile = null;

		try {

			if (num == null || "".equals(num)) {
				outputFile = new File(destPath);
			} else {
				String destPath1 = servletContext.getRealPath("/") + "output/" + date + "/" + num
						+ barCodeName + ".jpg";
				outputFile = new File(destPath1);
			}
			out = new FileOutputStream(outputFile);

			BitmapCanvasProvider canvas = new BitmapCanvasProvider(out, "image/jpeg", dpi,
					BufferedImage.TYPE_BYTE_BINARY, false, 0);
			// canvas.
			bean.generateBarcode(canvas, barCodeName);
			canvas.finish();
			generateResult = true;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (out != null)
					out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return generateResult;
	}

	/**
	 * 生产新规则条形码并增加文字描述
	 * 
	 * @param barCodeName
	 * @param declNo
	 * @param goodsName
	 * @return
	 */
	public static boolean createCode128BarcodeForDeclNo(String barCodeName, String declNo, String goodsName) {

		if (declNo == null || "".equals(declNo) || barCodeName == null || "".equals(barCodeName)) {
			return false;
		}

		boolean generateResult = false;// 是否生成
		Code128Bean bean = new Code128Bean();

		WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
		ServletContext servletContext = webApplicationContext.getServletContext();
		String destPath_ = servletContext.getRealPath("/") + "output/" + declNo;
		if (!new File(destPath_).exists()) {
			new File(destPath_).mkdirs();
		}
		String barDestPath = destPath_ + "/" + barCodeName + ".jpg";
		final int dpi = 125;// 分辨率
		// barcode
		bean.setModuleWidth(UnitConv.in2mm(1.0f / dpi));
		bean.setFontSize(3);
		bean.setMsgPosition(HumanReadablePlacement.HRP_BOTTOM);// 数字位置

		OutputStream out = null;
		File outputFile = null;

		try {

			outputFile = new File(barDestPath);
			out = new FileOutputStream(outputFile);

			BitmapCanvasProvider canvas = new BitmapCanvasProvider(out, "image/jpeg", dpi,
					BufferedImage.TYPE_BYTE_BINARY, false, 0);
			// canvas.
			bean.generateBarcode(canvas, barCodeName);
			canvas.finish();

			//createStringMark(barDestPath, goodsName, Color.BLACK, 100, destPath_ + "/" + goodsName + ".jpg");

			generateResult = true;

		} catch (Exception e) {
			e.printStackTrace();
			generateResult = false;
		} finally {
			try {
				if (out != null)
					out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return generateResult;
	}
	
	public static boolean createCode128BarcodeForLib(String barCode, String time) {

		if (barCode == null || "".equals(barCode) || time == null || "".equals(time)) {
			return false;
		}

		boolean generateResult = false;// 是否生成
		Code128Bean bean = new Code128Bean();

		WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
		ServletContext servletContext = webApplicationContext.getServletContext();
		String destPath_ = servletContext.getRealPath("/") + "output/lib/" + time;
		if (!new File(destPath_).exists()) {
			new File(destPath_).mkdirs();
		}
		String barDestPath = destPath_ + "/" + barCode + ".jpg";
		final int dpi = 125;// 分辨率
		// barcode
		bean.setModuleWidth(UnitConv.in2mm(1.0f / dpi));
		bean.setFontSize(3);
		bean.setMsgPosition(HumanReadablePlacement.HRP_BOTTOM);// 数字位置

		OutputStream out = null;
		File outputFile = null;

		try {

			outputFile = new File(barDestPath);
			out = new FileOutputStream(outputFile);

			BitmapCanvasProvider canvas = new BitmapCanvasProvider(out, "image/jpeg", dpi,
					BufferedImage.TYPE_BYTE_BINARY, false, 0);
			// canvas.
			bean.generateBarcode(canvas, barCode);
			canvas.finish();

//			createStringMark(barDestPath, goodsName, Color.BLACK, 100, destPath_ + "/" + goodsName + ".jpg");

			generateResult = true;

		} catch (Exception e) {
			e.printStackTrace();
			generateResult = false;
		} finally {
			try {
				if (out != null)
					out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return generateResult;
	}

	/**
	 * CODE128是一种高效率条码. 它一共映射了106种编码, 每种编码针对不同版本的CODE128(CODE128A, CODE128B,
	 * CODE128C), 代表了不同的数据组合. 同时, 每种编码通过11个黑白条模块的组合实现. 终止符比较特殊,由13个模块组成.
	 * 
	 * @param fileName
	 * @return
	 */
	public static boolean createCode128BarcodeByPath(String barCodeName, String path) {
		boolean generateResult = false;// 是否生成
		Code128Bean bean = new Code128Bean();

		if (!new File(path).exists()) {
			new File(path).mkdirs();
		}
		String destPath = path + barCodeName + ".jpg";
		final int dpi = 125;// 分辨率

		bean.setModuleWidth(UnitConv.in2mm(1.0f / dpi));
		bean.setFontSize(3);
		bean.setMsgPosition(HumanReadablePlacement.HRP_BOTTOM);// 数字位置

		OutputStream out = null;
		File outputFile = null;

		try {

			outputFile = new File(destPath);
			out = new FileOutputStream(outputFile);

			BitmapCanvasProvider canvas = new BitmapCanvasProvider(out, "image/jpeg", dpi,
					BufferedImage.TYPE_BYTE_BINARY, false, 0);
			// canvas.
			bean.generateBarcode(canvas, barCodeName);
			canvas.finish();
			generateResult = true;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (out != null)
					out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return generateResult;
	}

	/**
	 * CODE128是一种高效率条码. 它一共映射了106种编码, 每种编码针对不同版本的CODE128(CODE128A, CODE128B,
	 * CODE128C), 代表了不同的数据组合. 同时, 每种编码通过11个黑白条模块的组合实现. 终止符比较特殊,由13个模块组成.
	 * 
	 * @param barCodeName
	 * @param goodsName
	 *            商品名称
	 * @param path
	 *            图片所在位置
	 * @param outPath
	 * @return
	 */
	public static boolean createCode128BarcodeWithName(String barCodeName, String goodsName, String path) {
		boolean generateResult = false;// 是否生成
		Code128Bean bean = new Code128Bean();

		if (!new File(path).exists()) {
			new File(path).mkdirs();
		}
		String destPath = path + barCodeName + ".jpg";
		final int dpi = 125;// 分辨率

		bean.setModuleWidth(UnitConv.in2mm(1.0f / dpi));
		bean.setFontSize(3);
		bean.setMsgPosition(HumanReadablePlacement.HRP_BOTTOM);// 数字位置

		OutputStream out = null;
		File outputFile = null;

		try {

			outputFile = new File(destPath);
			out = new FileOutputStream(outputFile);

			BitmapCanvasProvider canvas = new BitmapCanvasProvider(out, "image/jpeg", dpi,
					BufferedImage.TYPE_BYTE_BINARY, false, 0);
			// canvas.
			bean.generateBarcode(canvas, barCodeName);
			canvas.finish();

			createStringMark(destPath, goodsName, Color.black, 100, path + "/" + goodsName + ".jpg");
			generateResult = true;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (out != null)
					out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return generateResult;
	}

	/**
	 * 添加文字，先生产文字图片，然后与条形码相结合生产新图片
	 * 
	 * @param filePath
	 * @param markContent
	 * @param markContentColor
	 * @param qualNum
	 * @param outPath
	 * @return
	 */
	public static boolean createStringMark(String filePath, String markContent, Color markContentColor, float qualNum,
			String outPath) {
		ImageIcon imgIcon = new ImageIcon(filePath);
		Image theImg = imgIcon.getImage();
		int width = theImg.getWidth(null) == -1 ? 200 : theImg.getWidth(null);
		System.out.println(width);
		BufferedImage bimage = new BufferedImage(width, 20, BufferedImage.TYPE_INT_RGB);
		Graphics2D g = (Graphics2D) bimage.getGraphics();
		g.setColor(Color.BLACK);
		g.setBackground(Color.WHITE);
		g.clearRect(0, 0, width, 20);
		g.setFont(new Font(null, Font.BOLD, 12)); // 字体、字型、字号
		g.drawString(markContent, 10, 14); // 画文字
		g.dispose();
		try {
			FileOutputStream out = new FileOutputStream(outPath); // 先用一个特定的输出文件名
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
			JPEGEncodeParam param = encoder.getDefaultJPEGEncodeParam(bimage);
			param.setQuality(qualNum, true);
			encoder.encode(bimage, param);
			out.close();

			String[] files = new String[] { outPath, filePath };
			merge(files, 2);

		} catch (Exception e) {
			return false;
		}
		return true;
	}

	/**
	 * 图片拼接
	 * 
	 * @param files
	 *            要拼接的文件列表
	 * @param type
	 *            1 横向拼接， 2 纵向拼接
	 * @return
	 */
	public static void merge(String[] files, int type) {

		int len = files.length;

		File[] src = new File[len];
		BufferedImage[] images = new BufferedImage[len];
		int[][] ImageArrays = new int[len][];
		for (int i = 0; i < len; i++) {
			try {
				src[i] = new File(files[i]);
				images[i] = ImageIO.read(src[i]);
			} catch (Exception e) {
				e.printStackTrace();
				return;
			}
			int width = images[i].getWidth();
			int height = images[i].getHeight();
			ImageArrays[i] = new int[width * height];// 从图片中读取RGB
			ImageArrays[i] = images[i].getRGB(0, 0, width, height, ImageArrays[i], 0, width);
		}

		int newHeight = 0;
		int newWidth = 0;
		for (int i = 0; i < images.length; i++) {
			// 横向
			if (type == 1) {
				newHeight = newHeight > images[i].getHeight() ? newHeight : images[i].getHeight();
				newWidth += images[i].getWidth();
			} else if (type == 2) {// 纵向
				newWidth = newWidth > images[i].getWidth() ? newWidth : images[i].getWidth();
				newHeight += images[i].getHeight();
			}
		}

		// 生成新图片
		try {
			BufferedImage ImageNew = new BufferedImage(newWidth, newHeight, BufferedImage.TYPE_INT_RGB);
			int height_i = 0;
			int width_i = 0;
			for (int i = 0; i < images.length; i++) {
				if (type == 1) {
					ImageNew.setRGB(width_i, 0, images[i].getWidth(), newHeight, ImageArrays[i], 0,
							images[i].getWidth());
					width_i += images[i].getWidth();
				} else if (type == 2) {
					ImageNew.setRGB(0, height_i, newWidth, images[i].getHeight(), ImageArrays[i], 0, newWidth);
					height_i += images[i].getHeight();
				}
			}
			File outFile = new File(files[1]);
			ImageIO.write(ImageNew, "jpg", outFile);// 写图片

			ByteArrayOutputStream out = new ByteArrayOutputStream();
			ImageIO.write(ImageNew, "jpg", out);// 图片写入到输出流中

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		String code = "1201212500adsfasadf_asdfasdfasdfasdfasdf";
		createCode128BarcodeWithName(code, "哇哈哈啊哇哈哈啊", "d:");
	}

}
