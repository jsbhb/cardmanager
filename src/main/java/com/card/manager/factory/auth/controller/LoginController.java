package com.card.manager.factory.auth.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
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
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.card.manager.factory.annotation.Auth;
import com.card.manager.factory.auth.model.AuthInfo;
import com.card.manager.factory.auth.model.DiagramPojo;
import com.card.manager.factory.auth.model.PlatUserType;
import com.card.manager.factory.auth.model.StatisticPojo;
import com.card.manager.factory.auth.model.UserInfo;
import com.card.manager.factory.auth.service.FuncMngService;
import com.card.manager.factory.auth.service.StatisticMngService;
import com.card.manager.factory.base.BaseController;
import com.card.manager.factory.base.PageCallBack;
import com.card.manager.factory.common.AuthCommon;
import com.card.manager.factory.common.ResourceContants;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.component.CachePoolComponent;
import com.card.manager.factory.component.impl.GoodsFileUploadComponentImpl;
import com.card.manager.factory.component.model.GradeBO;
import com.card.manager.factory.constants.Constants;
import com.card.manager.factory.constants.LoggerConstants;
import com.card.manager.factory.customer.model.Address;
import com.card.manager.factory.customer.service.PurchaseService;
import com.card.manager.factory.ftp.service.SftpService;
import com.card.manager.factory.goods.grademodel.GradeTypeDTO;
import com.card.manager.factory.log.SysLogger;
import com.card.manager.factory.order.model.OrderInfo;
import com.card.manager.factory.order.service.OrderService;
import com.card.manager.factory.socket.exception.ConnetionParamErrorException;
import com.card.manager.factory.socket.task.SocketClient;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.service.StaffMngService;
import com.card.manager.factory.user.model.CardEntity;
import com.card.manager.factory.user.model.Rebate;
import com.card.manager.factory.user.service.FinanceMngService;
import com.card.manager.factory.util.DateUtil;
import com.card.manager.factory.util.FileUtil;
import com.card.manager.factory.util.MethodUtil;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.StringUtil;
import com.card.manager.factory.util.TreePackUtil;
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

	@Resource
	StatisticMngService statisticMngService;

	@Resource
	PurchaseService purchaseService;

	@Resource
	OrderService orderService;

	@Resource
	FinanceMngService financeMngService;

	private final String TITLE_DATA = "title_data";
	private final String ORDER_DATA_DIAGRAM_WEEK = "order_diagram_data_week";
	private final String ORDER_DATA_DIAGRAM_MONTH = "order_diagram_data_month";
	private final String FINANCE_DATA_DIAGRAM_WEEK = "finance_diagram_data_week";
	private final String FINANCE_DATA_DIAGRAM_MONTH = "finance_diagram_data_month";
	private static final Integer DEFAULT = 1;
	// private final String GOODS_DATA_DIAGRAM = "goods_diagram_data";

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
		List<AuthInfo> authInfos;
		if (operator.getRoleId() == AuthCommon.SUPER_ADMIN) {
			authInfos = funcMngService.queryFunc();
		} else {
			authInfos = funcMngService.queryFuncByOptId(operator.getOptid());
		}
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
						&& !".jpeg".equalsIgnoreCase(suffix) && !".gif".equalsIgnoreCase(suffix)) {
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
		try {

			StaffEntity operator = SessionUtils.getOperator(req);
			if (operator == null) {
				return forword("login", context);
			}

			String id = req.getParameter("id");

			List<AuthInfo> menuList = SessionUtils.getMenuList(req);
			if (menuList != null) {
				context.put("menuList", menuList);
				if (StringUtil.isEmpty(id)) {
					context.put("childList", menuList.get(0).getChildren());
					id = menuList.get(0).getFuncId();
				} else {
					for (AuthInfo auth : menuList) {
						if (id.equals(auth.getFuncId())) {
							context.put("childList", auth.getChildren());
						}
					}
				}
				context.put("id", id);
			}

			switch (id) {
			case AuthCommon.OPERATION_DIAGRAM:
				operationDiagram(operator, context);
				break;
			case AuthCommon.ORDER_DIAGRAM:
				orderDiagram(operator, context);
				break;
			case AuthCommon.FINANCIAL_DIAGRAM:
				financialDiagram(operator, context);
				break;
			case AuthCommon.PURCHASE_DIAGRAM:
				purchaseDiagram(operator, context);
				break;
			case AuthCommon.PERSONAL_DIAGRAM:
				personDiagram(operator, context);
				break;
			default:
				break;
			}

			context.put("operator", operator);
			return forword("main", context);
		} catch (Exception e) {
			context.put(MSG, e.getMessage());
			return forword("error", context);
		}

	}

	/**
	 * operationDiagram:运营中心. <br/>
	 * 
	 * @author hebin
	 * @param operator
	 * @param context
	 * @since JDK 1.7
	 */
	private void operationDiagram(StaffEntity operator, Map<String, Object> context) {
		List<GradeBO> list = new ArrayList<GradeBO>();
		Map<Integer, GradeBO> gradeMap = CachePoolComponent.getGrade(operator.getToken());
		Map<Integer, GradeTypeDTO> gradeTypeMap = CachePoolComponent.getGradeType(operator.getToken());

		for (Map.Entry<Integer, GradeBO> entry : gradeMap.entrySet()) {
			list.add(entry.getValue());
		}
		List<GradeBO> gradeTree = TreePackUtil.packGradeChildren(list, operator.getGradeId());

		List<DiagramPojo> diagramList = new ArrayList<DiagramPojo>();

		Map<Integer, Integer> gradeSumMap = new HashMap<Integer, Integer>();

		for (GradeBO gradeBO : gradeTree) {
			List<GradeBO> children = gradeBO.getChildren();
			staticGrade(gradeSumMap, children);
		}

		for (Map.Entry<Integer, Integer> entry : gradeSumMap.entrySet()) {
			if (gradeTypeMap.get(entry.getKey()) != null) {
				diagramList.add(new DiagramPojo(gradeTypeMap.get(entry.getKey()).getName(), entry.getValue()));
			}
		}

		context.put(TITLE_DATA, diagramList);

		try {
			context.put(ORDER_DATA_DIAGRAM_WEEK,
					statisticMngService.queryStaticDiagram(StatisticMngService.DATA_TYPE_CHART,
							StatisticMngService.TIME_MODE_WEEK, StatisticMngService.MODEL_TYPE_ORDER, operator));
		} catch (Exception e) {
			context.put(ORDER_DATA_DIAGRAM_WEEK, new StatisticPojo());
		}
		try {
			context.put(ORDER_DATA_DIAGRAM_MONTH,
					statisticMngService.queryStaticDiagram(StatisticMngService.DATA_TYPE_CHART,
							StatisticMngService.TIME_MODE_MONTH, StatisticMngService.MODEL_TYPE_ORDER, operator));
		} catch (Exception e) {
			context.put(ORDER_DATA_DIAGRAM_MONTH, new StatisticPojo());
		}
	}

	private void staticGrade(Map<Integer, Integer> gradeSumMap, List<GradeBO> children) {
		if (children == null || children.size() == 0) {
			return;
		}
		for (GradeBO child : children) {
			if (gradeSumMap.containsKey(child.getGradeType())) {
				gradeSumMap.put(child.getGradeType(), gradeSumMap.get(child.getGradeType()) + 1);
			} else {
				gradeSumMap.put(child.getGradeType(), 1);
			}
			staticGrade(gradeSumMap, child.getChildren());
		}
	}

	/**
	 * financialDiagram:财务中心图标. <br/>
	 * 
	 * @author hebin
	 * @param operator
	 * @param context
	 * @since JDK 1.7
	 */
	private void financialDiagram(StaffEntity operator, Map<String, Object> context) {
		try {
			context.put(TITLE_DATA, statisticMngService.queryStaticHead(StatisticMngService.DATA_TYPE_HEAD,
					StatisticMngService.MODEL_TYPE_FINANCE, operator));
		} catch (Exception e) {
			context.put(TITLE_DATA, new ArrayList<DiagramPojo>());
		}
		try {
			context.put(FINANCE_DATA_DIAGRAM_WEEK,
					statisticMngService.queryStaticDiagram(StatisticMngService.DATA_TYPE_CHART,
							StatisticMngService.TIME_MODE_WEEK, StatisticMngService.MODEL_TYPE_FINANCE, operator));
		} catch (Exception e) {
			context.put(FINANCE_DATA_DIAGRAM_WEEK, new StatisticPojo());
		}
		try {
			context.put(FINANCE_DATA_DIAGRAM_MONTH,
					statisticMngService.queryStaticDiagram(StatisticMngService.DATA_TYPE_CHART,
							StatisticMngService.TIME_MODE_MONTH, StatisticMngService.MODEL_TYPE_FINANCE, operator));
		} catch (Exception e) {
			context.put(FINANCE_DATA_DIAGRAM_MONTH, new StatisticPojo());
		}

	}

	/**
	 * orderDiagram:订单中心图标. <br/>
	 * 
	 * @author hebin
	 * @param operator
	 * @param context
	 * @since JDK 1.7
	 */
	private void orderDiagram(StaffEntity operator, Map<String, Object> context) {
		try {
			context.put(TITLE_DATA, statisticMngService.queryStaticHead(StatisticMngService.DATA_TYPE_HEAD,
					StatisticMngService.MODEL_TYPE_ORDER, operator));
		} catch (Exception e) {
			context.put(TITLE_DATA, new ArrayList<DiagramPojo>());
		}
		try {
			context.put(ORDER_DATA_DIAGRAM_WEEK,
					statisticMngService.queryStaticDiagram(StatisticMngService.DATA_TYPE_CHART,
							StatisticMngService.TIME_MODE_WEEK, StatisticMngService.MODEL_TYPE_ORDER, operator));
		} catch (Exception e) {
			context.put(ORDER_DATA_DIAGRAM_WEEK, new StatisticPojo());
		}
		try {
			context.put(ORDER_DATA_DIAGRAM_MONTH,
					statisticMngService.queryStaticDiagram(StatisticMngService.DATA_TYPE_CHART,
							StatisticMngService.TIME_MODE_MONTH, StatisticMngService.MODEL_TYPE_ORDER, operator));
		} catch (Exception e) {
			context.put(ORDER_DATA_DIAGRAM_MONTH, new StatisticPojo());
		}
	}

	/**
	 * purchaseDiagram:采购图标. <br/>
	 * 
	 * @author hebin
	 * @param operator
	 * @param context
	 * @since JDK 1.7
	 */
	@SuppressWarnings("unchecked")
	private void purchaseDiagram(StaffEntity operator, Map<String, Object> context) {
		try {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("userId", operator.getUserCenterId());
			params.put("gradeId", operator.getGradeId());
			params.put("platformSource", Constants.PLATFORMSOURCE);
			int countShoppingCart = purchaseService.getShoppingCartCount(params, operator.getToken());
			context.put("countShoppingCart", countShoppingCart);
		} catch (Exception e) {
			context.put("countShoppingCart", 0);
		}
		try {
			OrderInfo pagination = new OrderInfo();
			Map<String, Object> params = new HashMap<String, Object>();
			pagination.setUserId(operator.getUserCenterId());
			// 一般贸易&后台订单
			pagination.setOrderFlag(2);
			pagination.setOrderSource(Constants.PLATFORMSOURCE);
			pagination.setCurrentPage(1);
			pagination.setNumPerPage(1000);
			PageCallBack pcb = orderService.dataList(pagination, params, operator.getToken(),
					ServerCenterContants.ORDER_CENTER_QUERY_FOR_PAGE, OrderInfo.class);
			if (pcb != null) {
				List<OrderInfo> orderLIst = (List<OrderInfo>) pcb.getObj();
				int totalRow = 0;
				for (OrderInfo order : orderLIst) {
					if (order.getStatus() == 0) {
						totalRow++;
					}
				}
				context.put("countWaitPayOrder", totalRow);
				context.put("countAllOrder", orderLIst.size());
			} else {
				context.put("countWaitPayOrder", 0);
				context.put("countAllOrder", 0);
			}
		} catch (Exception e) {
			context.put("countWaitPayOrder", 0);
			context.put("countAllOrder", 0);
		}
	}

	/**
	 * personDiagram:个人中心图标. <br/>
	 * 
	 * @author hebin
	 * @param operator
	 * @param context
	 * @since JDK 1.7
	 */
	@SuppressWarnings("unchecked")
	private void personDiagram(StaffEntity operator, Map<String, Object> context) {
		context.put(OPT, operator);
		try {
			Map<Integer, GradeTypeDTO> gradeTypeMap = CachePoolComponent.getGradeType(operator.getToken());
			GradeTypeDTO tmpGradeType = gradeTypeMap.get(operator.getGradeType());
			context.put("optGradeType", tmpGradeType.getName());
		} catch (Exception e) {
			context.put("optGradeType", "区域中心");
		}
		try {
			OrderInfo pagination = new OrderInfo();
			Map<String, Object> params = new HashMap<String, Object>();
			pagination.setUserId(operator.getUserCenterId());
			// 一般贸易&后台订单
			pagination.setOrderFlag(2);
			pagination.setOrderSource(Constants.PLATFORMSOURCE);
			pagination.setCurrentPage(1);
			pagination.setNumPerPage(1000);
			PageCallBack pcb = orderService.dataList(pagination, params, operator.getToken(),
					ServerCenterContants.ORDER_CENTER_QUERY_FOR_PAGE, OrderInfo.class);
			if (pcb != null) {
				List<OrderInfo> orderLIst = (List<OrderInfo>) pcb.getObj();
				int totalRow = 0;
				for (OrderInfo order : orderLIst) {
					if (order.getStatus() == 0) {
						totalRow++;
					}
				}
				context.put("countWaitPayOrder", totalRow);
				context.put("countAllOrder", orderLIst.size());
			} else {
				context.put("countWaitPayOrder", 0);
				context.put("countAllOrder", 0);
			}
		} catch (Exception e) {
			context.put("countWaitPayOrder", 0);
			context.put("countAllOrder", 0);
		}
		try {
			Rebate rebate = financeMngService.queryRebate(operator.getGradeId(), operator.getToken());
			context.put("gradeRebateInfo", rebate);
		} catch (Exception e) {
			Rebate rebate = new Rebate();
			rebate.setAlreadyCheck(0.00);
			context.put("gradeRebateInfo", rebate);
		}
		try {
			CardEntity pagination = new CardEntity();
			Map<String, Object> params = new HashMap<String, Object>();
			pagination.setTypeId(operator.getGradeId());
			pagination.setType(operator.getGradeType());
			pagination.setCurrentPage(1);
			pagination.setNumPerPage(1000);
			PageCallBack pcb = financeMngService.dataList(pagination, params, operator.getToken(),
					ServerCenterContants.FINANCE_CENTER_QUERY_CARDINFO, CardEntity.class);
			String showCardInfo = "";
			if (pcb != null) {
				List<CardEntity> cardLIst = (List<CardEntity>) pcb.getObj();
				for (CardEntity card : cardLIst) {
					String tmpCardNo = card.getCardNo().toString();
					showCardInfo = card.getCardBank() + "("
							+ tmpCardNo.substring(tmpCardNo.length() - 5, tmpCardNo.length()) + ")";
				}
				context.put("showCardInfo", showCardInfo);
			} else {
				context.put("showCardInfo", "去绑定");
			}
		} catch (Exception e) {
			context.put("showCardInfo", "去绑定");
		}
		try {
			Map<String, Object> addressParams = new HashMap<String, Object>();
			addressParams.put("userId", operator.getUserCenterId());
			List<Address> addressList = purchaseService.getUserAddressInfo(addressParams, operator.getToken());
			String defaultAddressInfo = "";
			for (Address add : addressList) {
				if (DEFAULT.equals(add.getSetDefault())) {
					defaultAddressInfo = add.getProvince() + add.getCity() + add.getArea();
					break;
				}
			}
			if ("".equals(defaultAddressInfo)) {
				context.put("defaultAddressInfo", "去设置");
			} else {
				context.put("defaultAddressInfo", defaultAddressInfo);
			}
		} catch (Exception e) {
			context.put("defaultAddressInfo", "去设置");
		}
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
						&& !".jpeg".equalsIgnoreCase(suffix) && !".gif".equalsIgnoreCase(suffix)) {
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
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

	}

	@RequestMapping(value = "/uploadExcelFile", method = RequestMethod.POST)
	@Auth(verifyLogin = false, verifyURL = false)
	public void uploadExcelFile(@RequestParam("import") MultipartFile excel, HttpServletRequest req,
			HttpServletResponse resp) {
		StaffEntity entity = SessionUtils.getOperator(req);
		try {
			String path = req.getParameter("path");
			if (excel != null) {
				String fileName = excel.getOriginalFilename();
				// 当前上传文件的文件后缀
				String suffix = fileName.indexOf(".") != -1
						? fileName.substring(fileName.lastIndexOf("."), fileName.length()) : null;

				if (!".xlsx".equalsIgnoreCase(suffix) && !".xls".equalsIgnoreCase(suffix)) {
					sendFailureMessage(resp, "文件格式有误！");
					return;
				}

				WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
				ServletContext servletContext = webApplicationContext.getServletContext();

				String filePath = servletContext.getRealPath("/") + "UPLOADEXCEL/";
				String saveFileName;
				if (path != null) {
					filePath += path + "/";
					saveFileName = DateUtil.getNowLongTime() + "-" + entity.getOptName() + suffix;
				} else {
					saveFileName = UUID.randomUUID().toString() + suffix;
				}
				File obj = null;
				obj = new File(filePath);
				if (!obj.exists()) {
					obj.mkdirs();
				}

				fileName = filePath + "/" + saveFileName;

				FileOutputStream fos = null;
				byte[] fileData = excel.getBytes();
				fos = new FileOutputStream(fileName);
				fos.write(fileData);
				fos.close();

				sendSuccessMessage(resp, URLEncoder.encode(fileName, "UTF-8"));
			}

		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}

	}

	@RequestMapping(value = "/uploadFileWithType", method = RequestMethod.POST)
	@Auth(verifyLogin = false, verifyURL = false)
	public void uploadFileWithType(@RequestParam("pic") MultipartFile pic, HttpServletRequest req,
			HttpServletResponse resp) {
		try {
			if (pic != null) {
				String fileName = pic.getOriginalFilename();

				// 当前上传文件的文件后缀
				String suffix = fileName.indexOf(".") != -1
						? fileName.substring(fileName.lastIndexOf("."), fileName.length()) : null;

				if (!".png".equalsIgnoreCase(suffix) && !".jpg".equalsIgnoreCase(suffix)
						&& !".jpeg".equalsIgnoreCase(suffix) && !".gif".equalsIgnoreCase(suffix)) {
					sendFailureMessage(resp, "文件格式有误！");
					return;
				}
				// 重命名上传后的文件名
				String saveFileName = UUID.randomUUID().toString() + suffix;

				// 通过输入流的方式将选择的文件内容转为FILE文件，此时会生成一个临时文件
				String path = req.getSession().getServletContext().getRealPath("fileUpload");
				File tmpFile = null;
				InputStream ins = pic.getInputStream();
				File fd = new File(path);
				if (!fd.exists()) {
					fd.mkdirs();
				}
				tmpFile = new File(path + "/" + saveFileName);
				FileUtil.inputStreamToFile(ins, tmpFile);

				String type = req.getParameter("type");
				String key = req.getParameter("key");
				if (key.equals("") || key == null) {
					sendFailureMessage(resp, "文件上传失败，未获取到对应的key，请刷新页面重试！");
					return;
				}

				// 如果名称不为“”,说明该文件存在，否则说明该文件不存在
				if (!StringUtils.isBlank(fileName)) {
					// 定义上传路径
					String remotePath = "";
					String invitePath = "";
					if (type.equals(ResourceContants.GRADE)) {
						remotePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.GRADE + "/" + key
								+ "/" + ResourceContants.MASTER + "/" + ResourceContants.IMAGE + "/";
						invitePath = URLUtils.get("static") + "/" + ResourceContants.GRADE + "/" + key + "/"
								+ ResourceContants.MASTER + "/" + ResourceContants.IMAGE + "/" + saveFileName;
					} else if (type.equals(ResourceContants.GOODS)) {
						remotePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.GOODS + "/" + key
								+ "/" + ResourceContants.MASTER + "/" + ResourceContants.IMAGE + "/";
						invitePath = URLUtils.get("static") + "/" + ResourceContants.GOODS + "/" + key + "/"
								+ ResourceContants.MASTER + "/" + ResourceContants.IMAGE + "/" + saveFileName;
					} else if (type.equals(ResourceContants.MSHOP)) {
						remotePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.GRADE + "/" + key
								+ "/" + ResourceContants.MSHOP + "/" + ResourceContants.IMAGE + "/";
						invitePath = URLUtils.get("static") + "/" + ResourceContants.GRADE + "/" + key + "/"
								+ ResourceContants.MSHOP + "/" + ResourceContants.IMAGE + "/" + saveFileName;
					} else if (type.equals(ResourceContants.GOODS_EXTENSION)) {
						remotePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.GOODS + "/" + key
								+ "/" + ResourceContants.GOODS_EXTENSION + "/" + ResourceContants.IMAGE + "/";
						invitePath = URLUtils.get("static") + "/" + ResourceContants.GOODS + "/" + key + "/"
								+ ResourceContants.GOODS_EXTENSION + "/" + ResourceContants.IMAGE + "/" + saveFileName;
					} else if (type.equals(ResourceContants.PC_FLOOR)) {
						remotePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.PC + "/"
								+ ResourceContants.FLOOR + "/" + key + "/" + ResourceContants.IMAGE + "/";
						invitePath = URLUtils.get("static") + "/" + ResourceContants.PC + "/" + ResourceContants.FLOOR
								+ "/" + key + "/" + ResourceContants.IMAGE + "/" + saveFileName;
					} else if (type.equals(ResourceContants.H5_FLOOR)) {
						remotePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.H5 + "/"
								+ ResourceContants.FLOOR + "/" + key + "/" + ResourceContants.IMAGE + "/";
						invitePath = URLUtils.get("static") + "/" + ResourceContants.H5 + "/" + ResourceContants.FLOOR
								+ "/" + key + "/" + ResourceContants.IMAGE + "/" + saveFileName;
					} else if (type.equals(ResourceContants.PC_FLOORGOODS)) {
						remotePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.PC + "/"
								+ ResourceContants.FLOOR + "/" + key + "/" + ResourceContants.FLOORGOODS + "/"
								+ ResourceContants.IMAGE + "/";
						invitePath = URLUtils.get("static") + "/" + ResourceContants.PC + "/" + ResourceContants.FLOOR
								+ "/" + key + "/" + ResourceContants.FLOORGOODS + "/" + ResourceContants.IMAGE + "/"
								+ saveFileName;
					} else if (type.equals(ResourceContants.H5_FLOORGOODS)) {
						remotePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.H5 + "/"
								+ ResourceContants.FLOOR + "/" + key + "/" + ResourceContants.FLOORGOODS + "/"
								+ ResourceContants.IMAGE + "/";
						invitePath = URLUtils.get("static") + "/" + ResourceContants.H5 + "/" + ResourceContants.FLOOR
								+ "/" + key + "/" + ResourceContants.FLOORGOODS + "/" + ResourceContants.IMAGE + "/"
								+ saveFileName;
					} else if (type.equals(ResourceContants.PC_BANNER)) {
						remotePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.PC + "/"
								+ ResourceContants.BANNER + "/" + key + "/" + ResourceContants.IMAGE + "/";
						invitePath = URLUtils.get("static") + "/" + ResourceContants.PC + "/" + ResourceContants.BANNER
								+ "/" + key + "/" + ResourceContants.IMAGE + "/" + saveFileName;
					} else if (type.equals(ResourceContants.H5_BANNER)) {
						remotePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.H5 + "/"
								+ ResourceContants.BANNER + "/" + key + "/" + ResourceContants.IMAGE + "/";
						invitePath = URLUtils.get("static") + "/" + ResourceContants.H5 + "/" + ResourceContants.BANNER
								+ "/" + key + "/" + ResourceContants.IMAGE + "/" + saveFileName;
					} else if (type.equals(ResourceContants.PC_AD)) {
						remotePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.PC + "/"
								+ ResourceContants.AD + "/" + key + "/" + ResourceContants.IMAGE + "/";
						invitePath = URLUtils.get("static") + "/" + ResourceContants.PC + "/" + ResourceContants.AD
								+ "/" + key + "/" + ResourceContants.IMAGE + "/" + saveFileName;
					} else if (type.equals(ResourceContants.CATEGORY)) {
						remotePath = ResourceContants.RESOURCE_BASE_PATH + "/" + key + "/";
						invitePath = URLUtils.get("static") + "/" + key + "/" + saveFileName;
					} else if (type.equals(ResourceContants.H5_POPULARITY)) {
						remotePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.H5 + "/"
								+ ResourceContants.POPULARITY + "/" + ResourceContants.IMAGE + "/" + key + "/";
						invitePath = URLUtils.get("static") + "/" + ResourceContants.H5 + "/"
								+ ResourceContants.POPULARITY + "/" + ResourceContants.IMAGE + "/" + key + "/"
								+ saveFileName;
					} else if (type.equalsIgnoreCase(ResourceContants.INFO)) {
						String date = DateUtil.getNowShortDate();
						remotePath = ResourceContants.RESOURCE_BASE_PATH + "/" + ResourceContants.INFO + "/" + date
								+ "/";
						invitePath = URLUtils.get("static") + "/" + ResourceContants.INFO + "/" + date + "/"
								+ saveFileName;
					} else {
						sendFailureMessage(resp, "操作失败：没有文件处理类型信息");
						return;
					}

					SocketClient client = null;
					try {
						client = new SocketClient();
						client.sendFile(tmpFile.getPath(), remotePath);
						client.quit();
						client.close();
						sendSuccessMessage(resp, invitePath);
					} catch (Exception e) {
						e.printStackTrace();
						sendFailureMessage(resp, "操作失败：文件上传服务异常");
						return;
					} finally {
						if (client != null) {
							client.close();
						}
						// 将临时文件删除
						File del = new File(tmpFile.toURI());
						del.delete();
					}
					return;
				} else {
					sendFailureMessage(resp, "操作失败：没有文件信息");
					return;
				}
			}
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
	}

	@RequestMapping(value = "/uploadGoodsFile", method = RequestMethod.POST)
	@Auth(verifyLogin = false, verifyURL = false)
	public void uploadGoodsFile(@RequestParam("pic") MultipartFile pic, HttpServletRequest req,
			HttpServletResponse resp) {
		try {
			if (pic != null) {
				String fileName = pic.getOriginalFilename();

				// 当前上传文件的文件后缀
				String suffix = fileName.indexOf(".") != -1
						? fileName.substring(fileName.lastIndexOf("."), fileName.length()) : null;

				if (!".png".equalsIgnoreCase(suffix) && !".jpg".equalsIgnoreCase(suffix)
						&& !".jpeg".equalsIgnoreCase(suffix) && !".gif".equalsIgnoreCase(suffix)) {
					sendFailureMessage(resp, "文件格式有误！");
					return;
				}
				// 重命名上传后的文件名
				String saveFileName = UUID.randomUUID().toString() + suffix;

				// 通过输入流的方式将选择的文件内容转为FILE文件，此时会生成一个临时文件
				String path = req.getSession().getServletContext().getRealPath("fileUpload");
				File tmpFile = null;
				InputStream ins = pic.getInputStream();
				File fd = new File(path);
				if (!fd.exists()) {
					fd.mkdirs();
				}
				tmpFile = new File(path + "/" + saveFileName);
				FileUtil.inputStreamToFile(ins, tmpFile);

				String key = req.getParameter("key");
				if (key.equals("") || key == null) {
					sendFailureMessage(resp, "文件上传失败，未获取到对应的key，请刷新页面重试！");
					return;
				}

				// 如果名称不为“”,说明该文件存在，否则说明该文件不存在
				if (!StringUtils.isBlank(fileName)) {
					// 定义上传路径
					String invitePath = "";
					invitePath = URLUtils.get("static") + "/" + ResourceContants.GOODS + "/" + key + "/"
							+ ResourceContants.MASTER + "/" + ResourceContants.IMAGE + "/" + saveFileName;

					GoodsFileUploadComponentImpl fuc = new GoodsFileUploadComponentImpl(key);
					try {
						fuc.fileUpload(tmpFile.getPath(), fuc.createRemotePath(), URLUtils.get("socketServerIp"),
								URLUtils.get("socketServerPort"));
						sendSuccessMessage(resp, invitePath);
					} catch (UnknownHostException e) {
						e.printStackTrace();
						sendFailureMessage(resp, "操作失败：" + e.getMessage());
						return;
					} catch (IOException e) {
						e.printStackTrace();
						sendFailureMessage(resp, "操作失败：" + e.getMessage());
						return;
					} catch (ConnetionParamErrorException e) {
						e.printStackTrace();
						sendFailureMessage(resp, "操作失败：" + e.getMessage());
						return;
					} finally {
						// 将临时文件删除
						File del = new File(tmpFile.toURI());
						del.delete();
					}
				} else {
					sendFailureMessage(resp, "操作失败：没有文件信息");
					return;
				}
			}
		} catch (Exception e) {
			sendFailureMessage(resp, "操作失败：" + e.getMessage());
			return;
		}
	}
}
