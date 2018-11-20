package com.card.manager.factory.util;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.RenderingHints;
import java.awt.Transparency;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGEncodeParam;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

import org.springframework.stereotype.Component;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.card.manager.factory.goods.pojo.GoodsExtensionEntity;

@SuppressWarnings("restriction")
@Component
public class ImageUtil {

	public static void overlapImage(HttpServletResponse response, String QRFilePath, GoodsExtensionEntity entity,
			String targetPath) {
		try {
			WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
			ServletContext servletContext = webApplicationContext.getServletContext();
			String templatePath = servletContext.getRealPath("/") + "img/goodsExtensionTemplate.jpg";
			String tagPath = servletContext.getRealPath("/") + "img/pointLogo.png";

			BufferedImage template = ImageIO.read(new File(templatePath));
			// 读取网络地址
			URL url = new URL(entity.getGoodsPath());
			BufferedImage goodsImage = ImageIO.read(url.openStream());

			BufferedImage qrImage = ImageIO.read(new File(QRFilePath));
			BufferedImage tag = ImageIO.read(new File(tagPath));

			int width = 1441;
			int height = 2102;
			Image image = template.getScaledInstance(width, height, Image.SCALE_SMOOTH);
			BufferedImage bufferedImage2 = new BufferedImage(width, height, BufferedImage.TYPE_INT_BGR);
			Graphics2D g = bufferedImage2.createGraphics();

			g.drawImage(image, 0, 0, null);
			// 头部图片
			g.drawImage(goodsImage, 0, 0, 1441, 890, null);

			// 二维码
			g.drawImage(qrImage, 640, 1758, 240, 240, null);

			String fontfilename = servletContext.getRealPath("/") + "mysh/Microsoft-Yahei-UI-Light.ttc";
			String fontfilename2 = servletContext.getRealPath("/") + "mysh/Microsoft-Yahei.ttf";
			InputStream is = new FileInputStream(new File(fontfilename));
			InputStream is2 = new FileInputStream(new File(fontfilename2));
			Font contentFont = Font.createFont(Font.TRUETYPE_FONT, is);// 返回一个指定字体类型和输入数据的font
			Font contentFontBase = contentFont.deriveFont(Font.PLAIN, 40);// 通过复制此
																			// Font
																			// 对象并应用新样式和大小，创建一个新
																			// Font
																			// 对象。
			Color contentColor = new Color(102, 102, 102);
			Color titleColor = new Color(50, 51, 51);
			// Font titleFont = new Font("微软雅黑", Font.PLAIN, 36);
			Font titleFont = Font.createFont(Font.TRUETYPE_FONT, is2);// 返回一个指定字体类型和输入数据的font
			Font titleFontBase = titleFont.deriveFont(Font.PLAIN, 36);// 通过复制此
																		// Font
																		// 对象并应用新样式和大小，创建一个新
																		// Font
																		// 对象。
			// 商品参数
			g.setFont(contentFontBase);
			g.setPaint(contentColor);
			int tmpBrandIndex = entity.getBrand().lastIndexOf(" ");
			String tmpBrand = entity.getBrand().substring(tmpBrandIndex + 1, entity.getBrand().length());
			g.drawString(tmpBrand, 460, 1059);
			// MyDrawString(entity.getBrand(), 460, 1059, 1.1, g);

			g.setFont(contentFontBase);
			g.setPaint(contentColor);
			g.drawString(entity.getGoodsName(), 905, 1060);
			// MyDrawString(entity.getGoodsName(), 905, 1060, 1.1, g);

			g.setFont(contentFontBase);
			g.setPaint(contentColor);
			MyDrawString(entity.getOrigin(), 460, 1138, 1.1, g);

			g.setFont(titleFontBase);
			g.setColor(titleColor);
			MyDrawString(entity.getCustom().split(":")[0] + ":", 728, 1136, 1.5, g);

			g.setFont(contentFontBase);
			g.setPaint(contentColor);
			MyDrawString(entity.getCustom().split(":")[1], 950, 1136, 1.1, g);

			g.setFont(contentFontBase);
			g.setPaint(contentColor);
			g.drawString(entity.getSpecs(), 540, 1214);
			// MyDrawString(entity.getSpecs(), 540, 1214, 1.5, g);

			if (entity.getShelfLife() != "" && entity.getShelfLife() != null) {
				g.setFont(titleFontBase);
				g.setColor(titleColor);
				MyDrawString("保质期:", 728, 1212, 1.5, g);
				g.setFont(contentFontBase);
				g.setPaint(contentColor);
				g.drawString(entity.getShelfLife(), 905, 1212);
				// MyDrawString(entity.getShelfLife(), 905, 1212, 1.1, g);
			}

			String[] reason = new String[0];
			int arrIndex = 0;
			int xIndex = 106;
			int yIndex = 1430;
			if (entity.getReason() != null) {
				reason = entity.getReason().split(";");
				if (reason.length > 4) {
					arrIndex = 4;
				} else {
					arrIndex = reason.length;
				}
			}

			for (int i = 0; i < arrIndex; i++) {
				if (i % 2 == 0) {
					g.drawImage(tag, xIndex, yIndex, 20, 20, null);
					g.setFont(titleFontBase);
					g.setColor(titleColor);
					MyDrawString(reason[i], xIndex + 40, yIndex + 20, 1.5, g);
				} else {
					g.drawImage(tag, xIndex + 534, yIndex, 20, 20, null);
					g.setFont(titleFontBase);
					g.setColor(titleColor);
					MyDrawString(reason[i], xIndex + 574, yIndex + 20, 1.5, g);

					yIndex = yIndex + 79;
				}
			}

			g.dispose();
			ImageIO.write(bufferedImage2, "jpg", new File(targetPath));
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public static void MyDrawString(String str, int x, int y, double rate, Graphics g) {
		String tempStr = new String();
		int orgStringWight = g.getFontMetrics().stringWidth(str);
		int orgStringLength = str.length();
		int tempx = x;
		int tempy = y;
		while (str.length() > 0) {
			tempStr = str.substring(0, 1);
			str = str.substring(1, str.length());
			g.drawString(tempStr, tempx, tempy);
			tempx = (int) (tempx + (double) orgStringWight / (double) orgStringLength * rate);
		}
	}

	// public static void main(String[] args) {
	// GoodsExtensionEntity entity = new GoodsExtensionEntity();
	// entity.setGoodsPath("C:\\Users\\wanghaiyang\\Desktop\\切图\\goodsExtensionLogo.png");
	// ImageUtil.overlapImage(null,
	// "C:\\Users\\wanghaiyang\\Desktop\\切图\\code.png", entity, "",
	// "C:\\Users\\wanghaiyang\\Desktop\\切图\\goodsExtensionTemplate.jpg");
	// }

	/**
	 * 改变图片DPI
	 *
	 * @param file
	 * @param xDensity
	 * @param yDensity
	 */
	public static void handleDpi(File file, int xDensity, int yDensity) {
		try {
			BufferedImage image = ImageIO.read(file);
			JPEGImageEncoder jpegEncoder = JPEGCodec.createJPEGEncoder(new FileOutputStream(file));
			JPEGEncodeParam jpegEncodeParam = jpegEncoder.getDefaultJPEGEncodeParam(image);
			jpegEncodeParam.setDensityUnit(JPEGEncodeParam.DENSITY_UNIT_DOTS_INCH);
			jpegEncoder.setJPEGEncodeParam(jpegEncodeParam);
			jpegEncodeParam.setQuality(0.75f, false);
			jpegEncodeParam.setXDensity(xDensity);
			jpegEncodeParam.setYDensity(yDensity);
			jpegEncoder.encode(image, jpegEncodeParam);
			image.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @fun 把inputstream输出为图片
	 * @param instreams
	 * @param imgPath
	 *            路径
	 * @param imgName
	 *            名称
	 * @return
	 */
	public static int saveToImgByInputStream(InputStream instreams, String imgPath, String imgName) {
		int stateInt = 1;
		if (instreams != null) {
			try {
				File file = new File(imgPath, imgName);// 可以是任何图片格式.jpg,.png等
				FileOutputStream fos = new FileOutputStream(file);
				byte[] b = new byte[1024];
				int nRead = 0;
				while ((nRead = instreams.read(b)) != -1) {
					fos.write(b, 0, nRead);
				}
				fos.flush();
				fos.close();
			} catch (Exception e) {
				stateInt = 0;
				e.printStackTrace();
			} finally {
			}
		}
		return stateInt;
	}

	/**
	 * @fun 小程序二维码替换logo
	 * @param codePath
	 * @param logoPath
	 * @param netPath
	 *            是否网络路径
	 * @param temporaryPath
	 *            临时存放图片的路径
	 */
	public static void replaceCodeLogo(String codePath, String logoPath, boolean netPath, String temporaryPath) {
		BufferedImage image = null;
		try {
			if (netPath) {
				image = ImageIO.read(new URL(logoPath));
			} else {
				image = ImageIO.read(new File(logoPath));
			}
		} catch (IOException e2) {
			e2.printStackTrace();
		}
		BufferedImage output = new BufferedImage(195, 195, BufferedImage.TYPE_INT_ARGB);
		Graphics2D g2 = output.createGraphics();
		output = g2.getDeviceConfiguration().createCompatibleImage(195, 195, Transparency.TRANSLUCENT);
		g2.dispose();
		g2 = output.createGraphics();
		g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
		g2.fillRoundRect(0, 0, 195, 195, 720, 720);
		g2.setComposite(AlphaComposite.SrcIn);
		g2.drawImage(image, 0, 0, 195, 195, null);
		g2.dispose();
		// 这是生成的临时替换logo图片的保存路径，已经切成圆形
		File temporaryFile = new File(temporaryPath + "/" + System.currentTimeMillis() + ".png");//临时logo图片
		try {
			ImageIO.write(output, "png", temporaryFile);
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		// 生产新的二维码图片
		try {
			// 此处是小程序码的路径
			BufferedImage appletImg = ImageIO.read(new FileInputStream(codePath));
			Graphics2D g2d = appletImg.createGraphics();

			// 设置抗锯齿的属性
			g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
			g2d.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING, RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
			// 此处是替换logo的临时图片路径
			BufferedImage centerImg = ImageIO.read(temporaryFile);
			g2d.drawImage(centerImg.getScaledInstance(centerImg.getWidth(), centerImg.getHeight(), Image.SCALE_SMOOTH),
					(appletImg.getWidth() - centerImg.getWidth()) / 2,
					(appletImg.getHeight() - centerImg.getHeight()) / 2, null);

			// 关闭资源
			g2d.dispose();
			// 生成新的二维码，覆盖原来的，此处为原小程序码路径，如需另为保存，请自定义路径
			ImageIO.write(appletImg, "png", new File(codePath));
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 删除生成的临时替代logo文件
		temporaryFile.delete();
	}

}
