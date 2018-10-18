package com.card.manager.factory.goods.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.annotation.Auth;
import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.common.ResourceContants;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.ftp.service.SftpService;
import com.card.manager.factory.goods.model.FirstCatalogEntity;
import com.card.manager.factory.goods.model.GoodsEntity;
import com.card.manager.factory.goods.model.GoodsItemEntity;
import com.card.manager.factory.goods.model.GoodsPriceRatioEntity;
import com.card.manager.factory.goods.model.GoodsTagBindEntity;
import com.card.manager.factory.goods.model.GoodsTagEntity;
import com.card.manager.factory.goods.model.SecondCatalogEntity;
import com.card.manager.factory.goods.model.SpecsEntity;
import com.card.manager.factory.goods.model.ThirdCatalogEntity;
import com.card.manager.factory.goods.pojo.CreateGoodsInfoEntity;
import com.card.manager.factory.goods.pojo.GoodsFielsMaintainBO;
import com.card.manager.factory.goods.pojo.GoodsInfoEntity;
import com.card.manager.factory.goods.pojo.ItemSpecsPojo;
import com.card.manager.factory.goods.service.CatalogService;
import com.card.manager.factory.goods.service.GoodsService;
import com.card.manager.factory.goods.service.SpecsService;
import com.card.manager.factory.log.SysLogger;
import com.card.manager.factory.socket.task.SocketClient;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.CompressFileUtils;
import com.card.manager.factory.util.DateUtil;
import com.card.manager.factory.util.JSONUtilNew;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/admin/goods/goodsMng")
public class GoodsMngController extends BaseController {

	@Resource
	GoodsService goodsService;

	@Resource
	CatalogService catalogService;

	@Resource
	SpecsService specsService;

	@Resource
	SftpService sftpService;

	@Resource
	SysLogger sysLogger;

	@RequestMapping(value = "/mng")
	public ModelAndView toFuncList(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put("opt", opt);
		return forword("goods/goods/add_choose", context);
	}

	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {
			context.put("suppliers", CachePoolComponent.getSupplier(opt.getToken()));
			context.put("brands", CachePoolComponent.getBrands(opt.getToken()));
			List<FirstCatalogEntity> catalogs = catalogService.queryFirstCatalogs(opt.getToken());
			context.put("firsts", catalogs);
			List<GoodsTagEntity> tags = goodsService.queryGoodsTags(opt.getToken());
			context.put("tags", tags);

			// 自动产生业务流水号：tmp+GoodsId+账号+时间+4位随机数
			Integer num = (int) (Math.random() * 9000) + 1000;
			String key = "";
			try {
				key = "tmpGoodsId" + opt.getBadge() + DateUtil.getNowPlusTimeMill() + num;
			} catch (Exception e) {
				e.printStackTrace();
				key = "tmpGoodsId" + opt.getBadge() + num;
			}
			context.put("key", key);
			return forword("goods/goods/add", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
	}

	@RequestMapping(value = "/toAddBatch")
	public ModelAndView toAddBatch(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		return forword("goods/goods/goodsImport", context);
	}

	@RequestMapping(value = "/toShow")
	public ModelAndView toShow(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {
			String id = req.getParameter("id");
			GoodsEntity entity = goodsService.queryById(id, opt.getToken());
			context.put("goods", entity);
			List<GoodsTagEntity> tags = goodsService.queryGoodsTags(opt.getToken());
			context.put("tags", tags);
			return forword("goods/goods/show", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}

	}

	@RequestMapping(value = "/createGoodsInfo", method = RequestMethod.POST)
	public void createGoodsInfo(HttpServletRequest req, HttpServletResponse resp,
			@RequestBody CreateGoodsInfoEntity entity) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		entity.setOpt(staffEntity.getOptid());
		try {
			goodsService.addGoodsInfoEntity(entity, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		sendSuccessMessage(resp, entity.getPicPath());
	}

	@RequestMapping(value = "/importGoodsInfo", method = RequestMethod.POST)
	public void importGoodsInfo(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String filePath = req.getParameter("filePath");
			if (StringUtil.isEmpty(filePath)) {
				sendFailureMessage(resp, "操作失败：文件路径不正确");
				return;
			}
			Map<String, Object> result = goodsService.importGoodsInfo(filePath, staffEntity);
			if ((boolean) result.get("success")) {
				sendSuccessMessage(resp, result.get("msg") + "");
			} else {
				sendFailureMessage(resp, result.get("msg") + "");
			}
		} catch (Exception e) {
			sysLogger.error("批量导入商品", "error", e);
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
	}

	@RequestMapping(value = "/exportGoodsInfoTemplate", method = RequestMethod.GET)
	public void exportGoodsInfoTemplate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		try {
			StaffEntity staffEntity = SessionUtils.getOperator(req);
			goodsService.exportGoodsInfoTemplate(req, resp, staffEntity);
		} catch (Exception e) {
			resp.setContentType("text/html;charset=utf-8");
			resp.getWriter().println("下载失败，请重试!");
			resp.getWriter().println(e.getMessage());
			return;
		}
	}

	@RequestMapping(value = "/toEditGoodsInfo")
	public ModelAndView toEditGoodsInfo(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			List<SpecsEntity> specs = specsService.queryAllSpecsInfo(staffEntity.getToken());
			context.put("specs", specs);

			String itemId = req.getParameter("itemId");
			GoodsInfoEntity goodsInfo = goodsService.queryGoodsInfoEntityByItemId(itemId, staffEntity);
			for (GoodsItemEntity gie : goodsInfo.getGoods().getItems()) {
				if (gie.getInfo() != null && !"".equals(gie.getInfo())) {
					JSONArray jsonArray = JSONArray.fromObject(gie.getInfo().substring(1, gie.getInfo().length()));
					int index = jsonArray.size();
					List<ItemSpecsPojo> list = new ArrayList<ItemSpecsPojo>();
					List<String> titles = new ArrayList<String>();
					for (int i = 0; i < index; i++) {
						JSONObject jObj = jsonArray.getJSONObject(i);
						list.add(JSONUtilNew.parse(jObj.toString(), ItemSpecsPojo.class));
						titles.add(JSONUtilNew.parse(jObj.toString(), ItemSpecsPojo.class).getSkV());
					}
					gie.setSpecs(list);

					context.put("specsInfos", list);
					context.put("specsTitles", titles);
				}
			}
			context.put("goodsInfo", goodsInfo);

			List<GoodsTagEntity> tags = goodsService.queryGoodsTags(staffEntity.getToken());
			for (GoodsTagEntity gte : tags) {
				for (GoodsTagBindEntity gtbe : goodsInfo.getGoods().getGoodsTagBindList()) {
					if (gte.getId() == gtbe.getTagId()) {
						gte.setTagFunId(1);
						break;
					}
				}
			}
			context.put("tags", tags);

			List<FirstCatalogEntity> catalogs = catalogService.queryAll(staffEntity.getToken());
			for (FirstCatalogEntity first : catalogs) {
				if (first.getFirstId().equals(goodsInfo.getGoodsBase().getFirstCatalogId())) {
					context.put("firstName", first.getName());
					for (SecondCatalogEntity second : first.getSeconds()) {
						if (second.getSecondId().equals(goodsInfo.getGoodsBase().getSecondCatalogId())) {
							context.put("secondName", second.getName());
							for (ThirdCatalogEntity third : second.getThirds()) {
								if (third.getThirdId().equals(goodsInfo.getGoodsBase().getThirdCatalogId())) {
									context.put("thirdName", third.getName());
									break;
								}
							}
							break;
						}
					}
					break;
				}
			}

			// 初始化商详信息
			String detailInfo = "";
			// 包含商详地址
			if (goodsInfo.getGoods().getDetailPath() != null
					&& goodsInfo.getGoods().getDetailPath().indexOf("html") > 0) {
				detailInfo = goodsService.getHtmlContext(goodsInfo.getGoods().getDetailPath(), staffEntity);
			} else if (goodsInfo.getGoods().getDetailPath() != null) {
				String[] imgArr = goodsInfo.getGoods().getDetailPath().split(";");
				String BaseUrl = URLUtils.get("static");
				for (int i = 0; i < imgArr.length; i++) {
					detailInfo = detailInfo + "<p style=\"text-align: center;\"><img src=\"" + BaseUrl
							+ "/images/orignal/detail/" + imgArr[i] + "\"></p> ";
				}
				detailInfo = detailInfo + "<p><br></p>";
			}
			context.put("detailInfo", detailInfo);

			context.put("suppliers", CachePoolComponent.getSupplier(staffEntity.getToken()));
			context.put("brands", CachePoolComponent.getBrands(staffEntity.getToken()));

			return forword("goods/goods/edit", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
	}

	@RequestMapping(value = "/editGoodsInfo", method = RequestMethod.POST)
	public void editGoodsInfo(HttpServletRequest req, HttpServletResponse resp,
			@RequestBody CreateGoodsInfoEntity entity) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		entity.setOpt(staffEntity.getOptid());
		try {
			goodsService.updGoodsInfoEntity(entity, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/toTag")
	public ModelAndView toTag(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		try {
			return forword("goods/goods/addTag", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
	}

	@RequestMapping(value = "/refreshTag", method = RequestMethod.POST)
	public void refreshTag(HttpServletRequest req, HttpServletResponse resp) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			List<GoodsTagEntity> tags = goodsService.queryGoodsTags(staffEntity.getToken());
			sendSuccessObject(resp, tags);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
	}

	@RequestMapping(value = "/saveTag", method = RequestMethod.POST)
	public void saveTag(HttpServletRequest req, HttpServletResponse resp, @RequestBody GoodsTagEntity goodsTag) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			goodsTag.setPriority(1);
			goodsService.addGoodsTag(goodsTag, staffEntity.getToken());
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
		sendSuccessMessage(resp, null);
	}

	private final int MAX_SIZE = 1024 * 50 * 1024; // 50MB
	SimpleDateFormat sdf = new SimpleDateFormat("YYYYMMDDhhmmssSSS");

	@RequestMapping(value = "/toBatchUploadPic")
	public ModelAndView toBatchUploadPic(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity opt = SessionUtils.getOperator(req);
		context.put(OPT, opt);
		return forword("goods/goods/goodsPicBatchImport", context);
	}

	@RequestMapping(value = "/uploadCompressedFile", method = RequestMethod.POST)
	@Auth(verifyLogin = false, verifyURL = false)
	public void uploadFile(@RequestParam("file") MultipartFile file, HttpServletRequest req, HttpServletResponse resp) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);

		if (file != null) {

			if (file.getSize() > MAX_SIZE) {
				sendFailureMessage(resp, "文件内容超过50M，请合理控制上传文件大小！");
				return;
			}

			String fileName = file.getOriginalFilename();
			// 文件后缀
			String suffix = fileName.indexOf(".") != -1
					? fileName.substring(fileName.lastIndexOf("."), fileName.length()) : null;

			String itemCode = fileName.indexOf(".") != -1 ? fileName.substring(0, fileName.lastIndexOf(".")) : null;

			// 通过itemCode获得对应的goodsId
			List<String> goodsIds = goodsService.queryGoodsIdByItemCode(itemCode, staffEntity.getToken());
			if (goodsIds.size() <= 0) {
				sendFailureMessage(resp, "该自有编码未匹配到对应的商品ID，请确认自有编码是否正确！");
				return;
			} else if (goodsIds.size() > 1) {
				sendFailureMessage(resp, "该自有编码匹配到多个商品ID，请联系技术先合并商品ID！");
				return;
			} else {
				// 将查询到的goodsId 替换itemCode的值
				itemCode = goodsIds.get(0);
			}

			// 源文件名称
			String sourceNameWithoutSuffix = itemCode + "-" + sdf.format(new Date()) + "-" + staffEntity.getBadge();
			// 源文件名称
			String sourceName = sourceNameWithoutSuffix + suffix;

			if (!".zip".equalsIgnoreCase(suffix) && !".rar".equalsIgnoreCase(suffix)) {
				sendFailureMessage(resp, "文件格式有误！");
				return;
			}

			String compressedFilePath = req.getServletContext().getRealPath("upload") + "/";
			File descFiles = new File(compressedFilePath + sourceName);

			try {
				// 后台保存文件

				if (!descFiles.exists()) {
					descFiles.mkdirs();
				}

				file.transferTo(descFiles);

				// 解压缩
				if (".zip".equalsIgnoreCase(suffix)) {
					CompressFileUtils.unZipFiles(compressedFilePath + sourceName,
							compressedFilePath + sourceNameWithoutSuffix);
				} else if (".rar".equalsIgnoreCase(suffix)) {
					CompressFileUtils.unRarFile(compressedFilePath + sourceName,
							compressedFilePath + sourceNameWithoutSuffix);
				} else {
					sendFailureMessage(resp, "没有指定压缩包！" + compressedFilePath + sourceName);
					return;
				}

				File directory = new File(compressedFilePath + sourceNameWithoutSuffix);

				//解压后的目录结构
				String[] itemCodeList = directory.list();
				if (itemCodeList == null || itemCodeList.length == 0) {
					sendFailureMessage(resp, "没有商品信息！");
					return;
				}
				
				//重命名目录结构
				for (String itemCodeFile : itemCodeList) {
					File fileDir = new File(compressedFilePath + sourceNameWithoutSuffix + "/" + itemCodeFile);
					File newFileDir = new File(compressedFilePath + sourceNameWithoutSuffix + "/" + itemCode);
					if (!fileDir.renameTo(newFileDir)) {
						sendFailureMessage(resp, "自有编码装换为商品ID时异常，请重新上传压缩包！");
						return;
					}
				}
				itemCodeList = directory.list();

				GoodsFielsMaintainBO bo;
				List<GoodsFielsMaintainBO> list = new ArrayList<GoodsFielsMaintainBO>();
				for (String itemCodeFile : itemCodeList) {
					try {
						bo = dealGoodsPic(itemCodeFile, compressedFilePath + sourceNameWithoutSuffix, staffEntity);
						if (bo == null) {
							continue;
						}
						bo.setItemCode(itemCodeFile);
						list.add(bo);
					} catch (Exception e) {
						e.printStackTrace();
						sendFailureMessage(resp, "操作失败：" + e.getMessage());
					}
				}

				goodsService.batchUploadPic(list, staffEntity.getToken());

				sendSuccessMessage(resp, "");

			} catch (Exception e) {
				sendFailureMessage(resp, "操作失败：" + e.getMessage());
			} finally {
				delAllFile(compressedFilePath + sourceNameWithoutSuffix);
				descFiles.delete();
			}
		} else {
			sendFailureMessage(resp, "没有文件内容！");

		}

	}

	private static boolean delAllFile(String path) {
		boolean flag = false;
		File file = new File(path);
		if (!file.exists()) {
			return flag;
		}
		if (!file.isDirectory()) {
			return flag;
		}
		String[] tempList = file.list();
		File temp = null;
		for (int i = 0; i < tempList.length; i++) {
			if (path.endsWith("/")) {
				temp = new File(path + tempList[i]);
			} else {
				temp = new File(path + "/" + tempList[i]);
			}
			if (temp.isFile()) {
				temp.delete();
			}
			if (temp.isDirectory()) {
				delAllFile(path + "/" + tempList[i]);// 先删除文件夹里面的文件
				delFolder(path + "/" + tempList[i]);// 再删除空文件夹
				flag = true;
			}
		}
		return flag;
	}

	public static void delFolder(String folderPath) {
		try {
			delAllFile(folderPath); // 删除完里面所有内容
			String filePath = folderPath;
			filePath = filePath.toString();
			java.io.File myFilePath = new java.io.File(filePath);
			myFilePath.delete(); // 删除空文件夹
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

//	private String getNewFileName(String itemCode, String fileName, StaffEntity staffEntity, Integer i) {
//		// 文件后缀
//		String suffix = fileName.indexOf(".") != -1 ? fileName.substring(fileName.lastIndexOf("."), fileName.length())
//				: null;
//
//		// 源文件名称
//		String sourceNameWithoutSuffix = (fileName.indexOf(".") != -1 ? fileName.substring(0, fileName.lastIndexOf("."))
//				: null) + "-" + sdf.format(new Date()) + "-" + staffEntity.getBadge() + "-" + i;
//		// 源文件名称
//		return itemCode + "_" + sourceNameWithoutSuffix + suffix;
//	}

	/**
	 * dealGoodsPic:(这里用一句话描述这个方法的作用). <br/>
	 * 
	 * @author hebin
	 * @param string
	 * @throws Exception
	 * @since JDK 1.7
	 */
	private GoodsFielsMaintainBO dealGoodsPic(String itemCode, String path, StaffEntity staffEntity) throws Exception {
		File file = new File(path + "/" + itemCode);
		List<String> coverList = new ArrayList<String>();
		List<String> detailList = new ArrayList<String>();
		GoodsFielsMaintainBO bo = new GoodsFielsMaintainBO();

		if (!file.exists()) {
			throw new Exception("没有文件信息!");
		}

		if (file.isDirectory()) {
			System.out.println("文件夹！");
			String[] fileList = file.list();
			for (int i = 0; i < fileList.length; i++) {
				File readFile = new File(path + "/" + itemCode + "/" + fileList[i]);
				if (readFile.isDirectory()) {
					String name = readFile.getName();
					if ("detail".equals(name)) {
						String[] detailFileList = readFile.list();
						for (String detailFile : detailFileList) {
							if (detailFile.endsWith(".png") || detailFile.endsWith(".jpg")
									|| detailFile.endsWith(".gif") || detailFile.endsWith(".jpeg")) {
								detailList.add(detailFile);
							}
						}
					}
				} else {
					if (fileList[i].endsWith(".png") || fileList[i].endsWith(".jpg") || fileList[i].endsWith(".gif")
							|| fileList[i].endsWith(".jpeg")) {
						coverList.add(fileList[i]);
					}

				}
			}

			if (coverList.size() == 0) {
				throw new Exception("没有主图信息");
			} else {
				bo.setPicPathList(dealCoverPic(itemCode, path + "/" + itemCode, coverList, staffEntity));
			}

			if (detailList.size() != 0) {
				bo.setGoodsDetailPath(
						dealDetailPic(itemCode, path + "/" + itemCode + "/" + "detail", detailList, staffEntity));
			}

		} else {
			throw new Exception("文件格式出错");
		}

		return bo;

	}

	/**
	 * dealCoverPic:处理主图图片. <br/>
	 * 
	 * @author hebin
	 * @param coverList
	 * @throws Exception
	 * @since JDK 1.7
	 */
	private List<String> dealCoverPic(String itemCode, String path, List<String> coverList, StaffEntity staffEntity)
			throws Exception {
		String remotePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.GOODS + "/" + 
				itemCode + "/" + ResourceContants.MASTER + "/" + ResourceContants.IMAGE + "/";

		List<String> coverInviteList = new ArrayList<String>();
		File file;
//		String newFileName;
		Collections.sort(coverList, new Comparator<String>() {

			@Override
			public int compare(String file0, String file1) {
				try {
					String s1 = file0.substring(0, file0.lastIndexOf("."));
					String s2 = file1.substring(0, file1.lastIndexOf("."));
					return s1.compareTo(s2);
				} catch (Exception e) {
					return 1;
				}

			}

		});
//		int i = 0;
		for (String fileName : coverList) {
			file = new File(path + "/" + fileName);
//			newFileName = getNewFileName(itemCode, fileName, staffEntity, i);
//			i++;
			
			SocketClient client = null;
			try {
				client = new SocketClient();
				client.sendFile(file.getPath(), remotePath);
				client.quit();
				client.close();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (client != null) {
					client.close();
				}
			}
			
			coverInviteList.add(URLUtils.get("static") + "/" + ResourceContants.GOODS + "/" + 
					itemCode + "/" + ResourceContants.MASTER + "/" + ResourceContants.IMAGE + "/" + file.getName());
		}

		return coverInviteList;
	}

	/**
	 * dealDetailPic:处理商品详情图片. <br/>
	 * 
	 * @author hebin
	 * @param detailList
	 * @throws Exception
	 * @since JDK 1.7
	 */
	private String dealDetailPic(String itemCode, String path, List<String> detailList, StaffEntity staffEntity)
			throws Exception {
		String remotePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.GOODS + "/" + 
				itemCode + "/" + ResourceContants.DETAIL + "/" + ResourceContants.IMAGE + "/";
		File file;
//		String newFileName;
		StringBuffer sb = new StringBuffer();

		Collections.sort(detailList, new Comparator<String>() {

			@Override
			public int compare(String file0, String file1) {
				try {
					Integer num0 = Integer.parseInt(file0.substring(0, file0.lastIndexOf(".")));
					Integer num1 = Integer.parseInt(file1.substring(0, file1.lastIndexOf(".")));
					if (num0 < num1) {
						return -1;
					} else {
						return 1;
					}
				} catch (Exception e) {
					return 1;
				}

			}

		});
//		int i = 0;
		for (String fileName : detailList) {
			file = new File(path + "/" + fileName);
//			newFileName = getNewFileName(itemCode, fileName, staffEntity, i);
//			i++;
			
			SocketClient client = null;
			try {
				client = new SocketClient();
				client.sendFile(file.getPath(), remotePath);
				client.quit();
				client.close();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (client != null) {
					client.close();
				}
			}
			
			sb.append("<p style=\"text-align: center;\"><img src=\"");
			sb.append(URLUtils.get("static") + "/" + ResourceContants.GOODS + "/" + itemCode + "/" + 
						ResourceContants.DETAIL + "/" + ResourceContants.IMAGE + "/" + file.getName());
			sb.append("\"></p>");
		}
		
		//新建临时目录和文件 将商详内容写入文件中
		String tmpHtmlPath = path + "/" + ResourceContants.HTML + "/";
		File directory = new File(tmpHtmlPath);
		if (!directory.exists()) {
			directory.mkdirs();
		}
		tmpHtmlPath = tmpHtmlPath + "/" + itemCode + ResourceContants.HTML_SUFFIX;
		InputStream is = new ByteArrayInputStream(sb.toString().getBytes("utf-8"));
		BufferedInputStream bin=null;
	    BufferedOutputStream bout=null;
	    bin=new BufferedInputStream(is);
	    bout=new BufferedOutputStream(new FileOutputStream(tmpHtmlPath));
	    int len=-1;
	    byte[] b=new byte[1024];
	    while((len=bin.read(b))!=-1){
	        bout.write(b,0,len);
	    }
	    bin.close();
	    bout.close();

		return goodsService.saveModelHtml(itemCode, tmpHtmlPath, staffEntity);
	}

	@RequestMapping(value = "/toCreateItemInfo")
	public ModelAndView toCreateItemInfo(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			List<SpecsEntity> specs = specsService.queryAllSpecsInfo(staffEntity.getToken());
			context.put("specs", specs);

			String itemId = req.getParameter("itemId");
			GoodsInfoEntity goodsInfo = goodsService.queryGoodsInfoEntityByItemId(itemId, staffEntity);
			context.put("goodsInfo", goodsInfo);

			List<GoodsTagEntity> tags = goodsService.queryGoodsTags(staffEntity.getToken());
			for (GoodsTagEntity gte : tags) {
				for (GoodsTagBindEntity gtbe : goodsInfo.getGoods().getGoodsTagBindList()) {
					if (gte.getId() == gtbe.getTagId()) {
						gte.setTagFunId(1);
						break;
					}
				}
			}
			context.put("tags", tags);

			List<FirstCatalogEntity> catalogs = catalogService.queryAll(staffEntity.getToken());
			for (FirstCatalogEntity first : catalogs) {
				if (first.getFirstId().equals(goodsInfo.getGoodsBase().getFirstCatalogId())) {
					context.put("firstName", first.getName());
					for (SecondCatalogEntity second : first.getSeconds()) {
						if (second.getSecondId().equals(goodsInfo.getGoodsBase().getSecondCatalogId())) {
							context.put("secondName", second.getName());
							for (ThirdCatalogEntity third : second.getThirds()) {
								if (third.getThirdId().equals(goodsInfo.getGoodsBase().getThirdCatalogId())) {
									context.put("thirdName", third.getName());
									break;
								}
							}
							break;
						}
					}
					break;
				}
			}

			// 初始化商详信息
			String detailInfo = "";
			// 包含商详地址
			if (goodsInfo.getGoods().getDetailPath() != null
					&& goodsInfo.getGoods().getDetailPath().indexOf("html") > 0) {
				detailInfo = goodsService.getHtmlContext(goodsInfo.getGoods().getDetailPath(), staffEntity);
			} else if (goodsInfo.getGoods().getDetailPath() != null) {
				String[] imgArr = goodsInfo.getGoods().getDetailPath().split(";");
				String BaseUrl = URLUtils.get("static");
				for (int i = 0; i < imgArr.length; i++) {
					detailInfo = detailInfo + "<p style=\"text-align: center;\"><img src=\"" + BaseUrl
							+ "/images/orignal/detail/" + imgArr[i] + "\"></p> ";
				}
				detailInfo = detailInfo + "<p><br></p>";
			}
			context.put("detailInfo", detailInfo);

			context.put("suppliers", CachePoolComponent.getSupplier(staffEntity.getToken()));
			context.put("brands", CachePoolComponent.getBrands(staffEntity.getToken()));

			return forword("goods/goods/create", context);
		} catch (Exception e) {
			context.put(MSG, e.getMessage());
			return forword(MSG, context);
		}
	}

	@RequestMapping(value = "/createItemInfo", method = RequestMethod.POST)
	public void createItemInfo(HttpServletRequest req, HttpServletResponse resp,
			@RequestBody CreateGoodsInfoEntity entity) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		entity.setOpt(staffEntity.getOptid());
		try {
			goodsService.addItemInfoEntity(entity, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/toShowGoodsInfo")
	public ModelAndView toShowGoodsInfo(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			List<SpecsEntity> specs = specsService.queryAllSpecsInfo(staffEntity.getToken());
			context.put("specs", specs);

			String itemId = req.getParameter("itemId");
			GoodsInfoEntity goodsInfo = goodsService.queryGoodsInfoEntityByItemId(itemId, staffEntity);
			for (GoodsItemEntity gie : goodsInfo.getGoods().getItems()) {
				if (gie.getInfo() != null && !"".equals(gie.getInfo())) {
					JSONArray jsonArray = JSONArray.fromObject(gie.getInfo().substring(1, gie.getInfo().length()));
					int index = jsonArray.size();
					List<ItemSpecsPojo> list = new ArrayList<ItemSpecsPojo>();
					List<String> titles = new ArrayList<String>();
					for (int i = 0; i < index; i++) {
						JSONObject jObj = jsonArray.getJSONObject(i);
						list.add(JSONUtilNew.parse(jObj.toString(), ItemSpecsPojo.class));
						titles.add(JSONUtilNew.parse(jObj.toString(), ItemSpecsPojo.class).getSkV());
					}
					gie.setSpecs(list);

					context.put("specsInfos", list);
					context.put("specsTitles", titles);
				}
			}
			context.put("goodsInfo", goodsInfo);

			List<GoodsTagEntity> tags = goodsService.queryGoodsTags(staffEntity.getToken());
			for (GoodsTagEntity gte : tags) {
				for (GoodsTagBindEntity gtbe : goodsInfo.getGoods().getGoodsTagBindList()) {
					if (gte.getId() == gtbe.getTagId()) {
						gte.setTagFunId(1);
						break;
					}
				}
			}
			context.put("tags", tags);

			List<FirstCatalogEntity> catalogs = catalogService.queryAll(staffEntity.getToken());
			for (FirstCatalogEntity first : catalogs) {
				if (first.getFirstId().equals(goodsInfo.getGoodsBase().getFirstCatalogId())) {
					context.put("firstName", first.getName());
					for (SecondCatalogEntity second : first.getSeconds()) {
						if (second.getSecondId().equals(goodsInfo.getGoodsBase().getSecondCatalogId())) {
							context.put("secondName", second.getName());
							for (ThirdCatalogEntity third : second.getThirds()) {
								if (third.getThirdId().equals(goodsInfo.getGoodsBase().getThirdCatalogId())) {
									context.put("thirdName", third.getName());
									break;
								}
							}
							break;
						}
					}
					break;
				}
			}

			// 初始化商详信息
			String detailInfo = "";
			// 包含商详地址
			if (goodsInfo.getGoods().getDetailPath() != null
					&& goodsInfo.getGoods().getDetailPath().indexOf("html") > 0) {
				detailInfo = goodsService.getHtmlContext(goodsInfo.getGoods().getDetailPath(), staffEntity);
			} else if (goodsInfo.getGoods().getDetailPath() != null) {
				String[] imgArr = goodsInfo.getGoods().getDetailPath().split(";");
				String BaseUrl = URLUtils.get("static");
				for (int i = 0; i < imgArr.length; i++) {
					detailInfo = detailInfo + "<p style=\"text-align: center;\"><img src=\"" + BaseUrl
							+ "/images/orignal/detail/" + imgArr[i] + "\"></p> ";
				}
				detailInfo = detailInfo + "<p><br></p>";
			}
			context.put("detailInfo", detailInfo);

			context.put("suppliers", CachePoolComponent.getSupplier(staffEntity.getToken()));
			context.put("brands", CachePoolComponent.getBrands(staffEntity.getToken()));

			return forword("goods/goods/show", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
	}

	@RequestMapping(value = "/toEditRatioGoodsInfo")
	public ModelAndView toEditRatioGoodsInfo(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> context = getRootMap();
		StaffEntity staffEntity = SessionUtils.getOperator(req);
		try {
			String itemId = req.getParameter("itemId");
			String goodsName = java.net.URLDecoder.decode(req.getParameter("goodsName"), "UTF-8");
			String itemInfo = java.net.URLDecoder.decode(req.getParameter("itemInfo"), "UTF-8");
			if (itemInfo == null || "null".equals(itemInfo)) {
				itemInfo = "";
			}
			GoodsItemEntity entity = new GoodsItemEntity();
			entity.setItemId(itemId);

			List<GoodsPriceRatioEntity> goodPriceRatios = goodsService.queryGoodsPriceRatioList(entity,
					staffEntity.getToken());
			if (goodPriceRatios.size() <= 0) {
				return forword("goods/goodsRatio/notice", context);
			}

			context.put("itemId", itemId);
			context.put("goodsName", goodsName);
			context.put("itemInfo", itemInfo);
			context.put("goodPriceRatios", goodPriceRatios);
			return forword("goods/goodsRatio/show", context);
		} catch (Exception e) {
			context.put(ERROR, e.getMessage());
			return forword(ERROR, context);
		}
	}

	@RequestMapping(value = "/syncRatioGoodsInfo")
	public void syncRatioGoodsInfo(HttpServletRequest req, HttpServletResponse resp,
			@RequestBody List<GoodsPriceRatioEntity> list) {
		StaffEntity staffEntity = SessionUtils.getOperator(req);

		try {
			goodsService.syncRatioGoodsInfo(list, staffEntity);
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}
}
