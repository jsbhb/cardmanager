package com.card.manager.factory.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URL;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import com.card.manager.factory.goods.pojo.GoodsExtensionEntity;

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
			//读取网络地址
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
			InputStream is = new FileInputStream(new File(fontfilename));
			Font contentFont = Font.createFont(Font.TRUETYPE_FONT,is);//返回一个指定字体类型和输入数据的font
			Font contentFontBase = contentFont.deriveFont(Font.PLAIN,40);//通过复制此 Font 对象并应用新样式和大小，创建一个新 Font 对象。
			Color contentColor = new Color(102, 102, 102);
			Color titleColor = new Color(50, 51, 51);
			Font titleFont = new Font("微软雅黑", Font.PLAIN, 36);
			//商品参数
			g.setFont(contentFontBase);
			g.setPaint(contentColor);
			g.drawString(entity.getBrand(), 460, 1059);

			g.setFont(contentFontBase);
			g.setPaint(contentColor);
			g.drawString(entity.getGoodsName(), 905, 1060);

			g.setFont(contentFontBase);
			g.setPaint(contentColor);
			g.drawString(entity.getOrigin(), 460, 1138);
			
			g.setFont(titleFont);
			g.setColor(titleColor);
			g.drawString(entity.getCustom().split(":")[0]+" ：", 728, 1136);

			g.setFont(contentFontBase);
			g.setPaint(contentColor);
			g.drawString(entity.getCustom().split(":")[1], 920, 1136);

			g.setFont(contentFontBase);
			g.setPaint(contentColor);
			g.drawString(entity.getSpecs(), 540, 1214);
			
			if (entity.getShelfLife() != "" && entity.getShelfLife() != null) {
				g.setFont(titleFont);
				g.setColor(titleColor);
				g.drawString("保 质 期 ：", 728, 1212);

				g.setFont(contentFontBase);
				g.setPaint(contentColor);
				g.drawString(entity.getShelfLife(), 920, 1212);
			}
			
			g.drawImage(tag, 220, 1600, 20, 20, null);
			g.setFont(titleFont);
			g.setColor(titleColor);
			g.drawString("深度保湿", 260, 1620);
			g.dispose();
			
	        ImageIO.write(bufferedImage2, "jpg", new File(targetPath));
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
//	public static void main(String[] args) {
//		GoodsExtensionEntity entity = new GoodsExtensionEntity();
//		entity.setGoodsPath("C:\\Users\\wanghaiyang\\Desktop\\切图\\goodsExtensionLogo.png");
//		ImageUtil.overlapImage(null, "C:\\Users\\wanghaiyang\\Desktop\\切图\\code.png", entity, "", "C:\\Users\\wanghaiyang\\Desktop\\切图\\goodsExtensionTemplate.jpg");
//	}

}
