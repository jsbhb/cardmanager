package com.card.manager.factory.auth.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.annotation.Auth;
import com.card.manager.factory.auth.model.AuthInfo;
import com.card.manager.factory.auth.model.PlatUserType;
import com.card.manager.factory.auth.model.UserInfo;
import com.card.manager.factory.auth.service.FuncMngService;
import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.common.AuthCommon;
import com.card.manager.factory.common.ResourceContants;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.constants.Constants;
import com.card.manager.factory.constants.LoggerConstants;
import com.card.manager.factory.ftp.service.SftpService;
import com.card.manager.factory.log.SysLogger;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.service.StaffMngService;
import com.card.manager.factory.util.MethodUtil;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;
import com.card.manager.factory.util.URLUtils;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/admin")
public class LoginController extends BaseController {

	@Resource
	StaffMngService staffMngService;

	@Resource
	FuncMngService funcMngService;

	@Resource
	SftpService sftpService;

	@Resource
	SysLogger sysLogger;

	@RequestMapping(value = "/toLogin")
	@Auth(verifyLogin = false, verifyURL = false)
	public ModelAndView toLogin(HttpServletRequest req, HttpServletResponse resp) {
		// 返回数据类型
		Map<String, Object> context = getRootMap();
		return forword("login", context);
	}

	@RequestMapping(value = "/error")
	@Auth(verifyLogin = false, verifyURL = false)
	public ModelAndView error(HttpServletRequest req, HttpServletResponse resp) {
		// 返回数据类型
		Map<String, Object> context = getRootMap();
		context.put("msg", req.getAttribute("msg"));
		return forword("error", context);
	}

	@RequestMapping(value = "/logout")
	@Auth(verifyLogin = false, verifyURL = false)
	public void logout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		// 返回数据类型
		SessionUtils.removeOperator(req);
		SessionUtils.removeMenuList(req);
		resp.sendRedirect(URLUtils.get("wmsUrl") + "/admin/toLogin.shtml");
	}

	/**
	 * 用户登录
	 * 
	 * @param email
	 * @param pwd
	 * @param verifyCode
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/login")
	@Auth(verifyLogin = false, verifyURL = false)
	public void login(String userName, String pwd, String verifyCode, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// 判断验证码是否正确
		if (StringUtil.isEmpty(userName)) {
			sendFailureMessage(response, "账号不能为空.");
			return;
		}
		if (StringUtil.isEmpty(pwd)) {
			sendFailureMessage(response, "密码不能为空.");
			return;
		}

		String msg = "用户登录日志:";
		StaffEntity operator = staffMngService.queryByLoginInfo(userName, MethodUtil.MD5(pwd));
		if (operator == null) {
			// 记录错误登录日志
			sysLogger.error(LoggerConstants.LOGIN_LOGGER, msg + "[" + userName + "]" + "账号或者密码输入错误.");
			sendFailureMessage(response, "账号或者密码输入错误.");
			return;
		}
		if (Constants.ACCOUNT_LOCKED.equals(operator.getLocked())) {
			sysLogger.error(LoggerConstants.LOGIN_LOGGER, msg + "[" + userName + "]" + "账号被锁定.");
			sendFailureMessage(response, "该账号已被锁定，请联系管理员.");
			return;
		}

		Map<String, Object> context = getRootMap();
		String authUrl = (String) context.get("gateway");

		// 调用权限中心 验证是否可以登录
		RestTemplate restTemplate = new RestTemplate();
		UserInfo userInfo = new UserInfo(PlatUserType.CROSS_BORDER.getIndex(), 4, operator.getPlatId());

		HttpEntity<UserInfo> entity = new HttpEntity<UserInfo>(userInfo, null);

		try {
			ResponseEntity<String> result = restTemplate.exchange(authUrl + ServerCenterContants.AUTH_CENTER_LOGIN,
					HttpMethod.POST, entity, String.class);

			JSONObject json = JSONObject.fromObject(result.getBody());
			JSONObject obj = (JSONObject) json.getJSONObject("obj");
			operator.setToken(obj.getString("token"));

		} catch (Exception e) {
			sysLogger.error(LoggerConstants.LOGIN_LOGGER, msg + "[" + userName + "]" + "权限认证失败.");
			sendFailureMessage(response, "权限认证失败，请重试.");
			return;
		}

		initSession(request, operator);

		sendSuccessMessage(response, "登录成功.");
	}

	private boolean initSession(HttpServletRequest request, StaffEntity operator) {
		// 设置Operator到Session
		SessionUtils.setOperator(request, operator);

		// 设置MenuList到Session
		List<AuthInfo> authInfos = funcMngService.queryFuncByOptId(operator.getOptid());
		List<AuthInfo> menuList = AuthCommon.treeAuthInfo2(authInfos);

		if (menuList == null) {
			return false;
		}

		SessionUtils.setMenuList(request, menuList);

		return true;

	}

	@RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
	@Auth(verifyLogin = false, verifyURL = false)
	public void uploadFile(@RequestParam("pic") MultipartFile pic, HttpServletRequest req, HttpServletResponse resp) {

		StaffEntity staffEntity = SessionUtils.getOperator(req);

		try {
			if (pic != null) {
				String fileName = pic.getOriginalFilename();
				// 当前上传文件的文件后缀
				String suffix = fileName.indexOf(".") != -1
						? fileName.substring(fileName.lastIndexOf("."), fileName.length()) : null;

				if (!".png".equalsIgnoreCase(suffix) && !".jpg".equalsIgnoreCase(suffix)
						&& !".jpeg".equalsIgnoreCase(suffix)) {
					sendFailureMessage(resp, "文件格式有误！");
					return;
				}

				// 如果名称不为“”,说明该文件存在，否则说明该文件不存在
				if (!StringUtils.isBlank(fileName)) {
					// 重命名上传后的文件名
					String saveFileName = UUID.randomUUID().toString() + suffix;
					// 定义上传路径
					// 当前上传文件信息

					int gradeLevel = staffEntity.getGradeLevel();

					String descPath = "";
					String remotePath = "";
					String invitePath = "";

					if (gradeLevel != 1) {
						remotePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.CMS + "/";
						descPath = staffEntity.getGradeId() + "";
					} else {
						remotePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.IMAGE + "/";
					}

					sftpService.uploadFile(remotePath, saveFileName, pic.getInputStream(), descPath);

					if (gradeLevel != 1) {
						invitePath = URLUtils.get("static") + "/" + ResourceContants.CMS + "/"
								+ staffEntity.getGradeId() + "/" + saveFileName;
					} else {
						invitePath = URLUtils.get("static") + "/" + ResourceContants.IMAGE + "/" + saveFileName;
					}

					sendSuccessMessage(resp, invitePath);
				} else {
					sendFailureMessage(resp, "操作失败：没有文件信息");
				}

			}

		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

	}

	/**
	 * 首頁
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/main")
	@Auth(verifyLogin = false, verifyURL = false)
	public ModelAndView main(HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
		Map<String, Object> context = getRootMap();

		StaffEntity operator = SessionUtils.getOperator(req);
		if (operator == null) {
			return forword("login", context);
		}

		String id = req.getParameter("id");

		List<AuthInfo> menuList = SessionUtils.getMenuList(req);
		if (menuList != null) {
			context.put("menuList", menuList);
			context.put("id",id);
			if (StringUtil.isEmpty(id)) {
				context.put("childList", menuList.get(0).getChildren());
			} else {
				for(AuthInfo auth:menuList){
					if(id.equals(auth.getFuncId())){
						context.put("childList", auth.getChildren());
					}
				}
			}
		}

		context.put("operator", operator);
		return forword("main", context);
	}

	@RequestMapping("/modifyPwd")
	@Auth(verifyLogin = false, verifyURL = false)
	public ModelAndView modifyPwd(HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
		Map<String, Object> context = getRootMap();

		StaffEntity operator = SessionUtils.getOperator(req);
		if (operator == null) {
			return forword("login", context);
		}
		return forword("modify", context);
	}

	@RequestMapping(value = "/chkModifyPwd", method = RequestMethod.POST)
	@Auth(verifyLogin = false, verifyURL = false)
	public void chkModifyPwd(HttpServletRequest req, HttpServletResponse resp, HttpSession session,
			@RequestBody String param) {
		StaffEntity opt = SessionUtils.getOperator(req);
		try {
			JSONObject jsonObj = JSONObject.fromObject(param);

			String oldPwd = jsonObj.get("oldPwd").toString();
			String newPwd = jsonObj.get("newPwd").toString();

			StaffEntity operator = staffMngService.queryByLoginInfo(opt.getBadge(), MethodUtil.MD5(oldPwd));
			if (operator == null) {
				// 验证登录失败
				sendFailureMessage(resp, "账号或者密码输入错误.");
				return;
			}
			if (Constants.ACCOUNT_LOCKED.equals(operator.getLocked())) {
				// 验证账号是否被锁定
				sendFailureMessage(resp, "该账号已被锁定，请联系管理员.");
				return;
			}

			// 进行更新密码操作
			staffMngService.modifyPwd(opt.getBadge(), MethodUtil.MD5(newPwd));

		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

		sendSuccessMessage(resp, null);
	}

	@RequestMapping(value = "/uploadFileForGrade", method = RequestMethod.POST)
	@Auth(verifyLogin = false, verifyURL = false)
	public void uploadFileForGrade(@RequestParam("pic") MultipartFile pic, HttpServletRequest req,
			HttpServletResponse resp) {

		try {
			if (pic != null) {
				String fileName = pic.getOriginalFilename();
				// 当前上传文件的文件后缀
				String suffix = fileName.indexOf(".") != -1
						? fileName.substring(fileName.lastIndexOf("."), fileName.length()) : null;

				if (!".png".equalsIgnoreCase(suffix) && !".jpg".equalsIgnoreCase(suffix)
						&& !".jpeg".equalsIgnoreCase(suffix)) {
					sendFailureMessage(resp, "文件格式有误！");
					return;
				}

				// 如果名称不为“”,说明该文件存在，否则说明该文件不存在
				if (!StringUtils.isBlank(fileName)) {
					// 重命名上传后的文件名
					String saveFileName = UUID.randomUUID().toString() + suffix;
					// 定义上传路径
					// 当前上传文件信息

					String descPath = "";
					String remotePath = "";
					String invitePath = "";

					remotePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.GRADE + "/";

					sftpService.uploadFile(remotePath, saveFileName, pic.getInputStream(), descPath);

					invitePath = URLUtils.get("static") + "/" + ResourceContants.GRADE + "/" + saveFileName;

					sendSuccessMessage(resp, invitePath);
				} else {
					sendFailureMessage(resp, "操作失败：没有文件信息");
				}

			}

		} catch (Exception e) {
			try {
				sftpService.logout();
			} catch (Exception e1) {
				sendFailureMessage(resp, "操作失败：" + e1.getMessage());
				return;
			}
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

	}

	@RequestMapping(value = "/uploadFileForShop", method = RequestMethod.POST)
	@Auth(verifyLogin = false, verifyURL = false)
	public void uploadFileForShop(@RequestParam("pic1") MultipartFile pic, HttpServletRequest req,
			HttpServletResponse resp) {

		try {
			if (pic != null) {
				String fileName = pic.getOriginalFilename();
				// 当前上传文件的文件后缀
				String suffix = fileName.indexOf(".") != -1
						? fileName.substring(fileName.lastIndexOf("."), fileName.length()) : null;

				if (!".png".equalsIgnoreCase(suffix) && !".jpg".equalsIgnoreCase(suffix)
						&& !".jpeg".equalsIgnoreCase(suffix)) {
					sendFailureMessage(resp, "文件格式有误！");
					return;
				}

				// 如果名称不为“”,说明该文件存在，否则说明该文件不存在
				if (!StringUtils.isBlank(fileName)) {
					// 重命名上传后的文件名
					String saveFileName = UUID.randomUUID().toString() + suffix;
					// 定义上传路径
					// 当前上传文件信息

					String descPath = "";
					String remotePath = "";
					String invitePath = "";

					remotePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.MSHOP + "/";

					sftpService.uploadFile(remotePath, saveFileName, pic.getInputStream(), descPath);

					invitePath = URLUtils.get("static") + "/" + ResourceContants.MSHOP + "/" + saveFileName;

					sendSuccessMessage(resp, invitePath);
				} else {
					sendFailureMessage(resp, "操作失败：没有文件信息");
				}

			}

		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

	}
}
