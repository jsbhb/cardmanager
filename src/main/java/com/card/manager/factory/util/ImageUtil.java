package com.card.manager.factory.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.InputStream;
import java.net.URL;
import java.text.SimpleDateFormat;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.card.manager.factory.goods.pojo.GoodsExtensionEntity;

@Component
public class ImageUtil {

	public static void overlapImage(HttpServletResponse response, String QRFileName, GoodsExtensionEntity entity,
			String targetPath, String templatePath) {
		try {
//			SimpleDateFormat sdf_ = new SimpleDateFormat("yyyyMMdd");
//			WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
//			ServletContext servletContext = webApplicationContext.getServletContext();

//			URL url = new URL(templatePath);
//			BufferedImage template = ImageIO.read(url.openStream());
//			url = new URL(entity.getGoodsPath());
//			BufferedImage goodsImage = ImageIO.read(url.openStream());
//			url = new URL(QRFileName);
//			BufferedImage qrImage = ImageIO.read(url.openStream());
			BufferedImage template = ImageIO.read(new File(templatePath));
			BufferedImage goodsImage = ImageIO.read(new File(entity.getGoodsPath()));
			BufferedImage qrImage = ImageIO.read(new File(QRFileName));
			BufferedImage tag = ImageIO.read(new File("C:\\Users\\user\\Desktop\\切图\\QQ图片20180615151958.png"));

			int width = 1441;
			int height = 2102;
			Image image = template.getScaledInstance(width, height, Image.SCALE_SMOOTH);
			BufferedImage bufferedImage2 = new BufferedImage(width, height, BufferedImage.TYPE_INT_BGR);
			Graphics2D g = bufferedImage2.createGraphics();

			g.drawImage(image, 0, 0, null);
			// 头部图片
			g.drawImage(goodsImage, 0, 0, 1441, 890, null);

			// 二维码
			g.drawImage(qrImage, 580, 1500, 240, 240, null);
			
			String fontfilename = "/Microsoft-Yahei-UI-Light.ttc";
			InputStream is = ImageUtil.class.getResourceAsStream(fontfilename);
			Font contentFont = Font.createFont(Font.TRUETYPE_FONT,is);//返回一个指定字体类型和输入数据的font
			Font contentFontBase = contentFont.deriveFont(Font.PLAIN,40);//通过复制此 Font 对象并应用新样式和大小，创建一个新 Font 对象。
			Color contentColor = new Color(102, 102, 102);
			Color titleColor = new Color(50, 51, 51);
			Font titleFont = new Font("微软雅黑", Font.PLAIN, 40);
			g.setFont(contentFontBase);
			g.setPaint(contentColor);
			g.drawString("JAYJUN", 240, 1200);
			
			g.drawImage(tag, 220, 1600, 20, 20, null);
			g.setFont(titleFont);
			g.setColor(titleColor);
			g.drawString("深度保湿", 260, 1620);
			g.dispose();  
	          ImageIO.write(bufferedImage2, "jpg", new File("C:\\Users\\user\\Desktop\\切图\\4.jpg"));  
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	public static void main(String[] args) {
		GoodsExtensionEntity entity = new GoodsExtensionEntity();
		entity.setGoodsPath("C:\\Users\\user\\Desktop\\切图\\QQ图片20180615142820.png");
		ImageUtil.overlapImage(null, "C:\\Users\\user\\Desktop\\切图\\右三角.png", entity, "", "C:\\Users\\user\\Desktop\\切图\\产品介绍扫码卡.png");
	}

}
