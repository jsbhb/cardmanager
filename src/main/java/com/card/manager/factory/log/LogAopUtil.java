package com.card.manager.factory.log;

import java.lang.reflect.Method;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.card.manager.factory.annotation.Log;
import com.card.manager.factory.common.RestCommonHelper;
import com.card.manager.factory.common.ServerCenterContants;
import com.card.manager.factory.log.model.ExceptionLog;
import com.card.manager.factory.log.model.LogInfo;
import com.card.manager.factory.log.model.ServerLogEnum;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.util.JSONUtil;
import com.card.manager.factory.util.SessionUtils;
import com.card.manager.factory.util.URLUtils;

@Component
@Aspect
public class LogAopUtil {

//	@Resource
//	LogFeignClient logFeignClient;

	Logger logger = LoggerFactory.getLogger(LogAopUtil.class);

	// 异常类日志
	@Pointcut("execution(* com.card.manager.factory.*.service.impl.*.*(..))")
	public void exceptionPointCut() {
	}

	@AfterThrowing(pointcut = "exceptionPointCut()", throwing = "e")
	public void afterThrowException(JoinPoint jp, Throwable e) {
		Class<?> clazz = jp.getTarget().getClass();
		MethodSignature signature = (MethodSignature) jp.getSignature();
		Method method = signature.getMethod(); // 获取被拦截的方法
		String methodName = method.getName(); // 获取被拦截的方法名
		String className = clazz.getName();
		StringBuilder sb = new StringBuilder();
		StackTraceElement[] stackTraceElementArr = e.getStackTrace();
		for (StackTraceElement stackTraceElement : stackTraceElementArr) {
			String ErrorMethodName = stackTraceElement.getMethodName();
			String ErrorClassName = stackTraceElement.getClassName();
			if (ErrorClassName.equals(className) && methodName.equals(ErrorMethodName)) {
				sb.append("类名：" + stackTraceElement.getFileName() + ";");
				sb.append("方法名：" + stackTraceElement.getMethodName() + ";");
				sb.append("错误描述：" + e.toString() + ";");
				sb.append("所在行：" + stackTraceElement.getLineNumber() + ";");
			}
		}

		if("".equals(sb.toString())){
			sb.append(e.toString());
		}
		ExceptionLog exceptionLog = new ExceptionLog(ServerLogEnum.COOP_BACK.getServerId(),
				ServerLogEnum.COOP_BACK.getServerName(), methodName, sb.toString());
		try {
//			logFeignClient.saveExceptionLog(Constants.FIRST_VERSION, exceptionLog);
			
			ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
			HttpServletRequest request = attributes.getRequest();
			StaffEntity staffEntity = SessionUtils.getOperator(request);
			RestCommonHelper helper = new RestCommonHelper();
			helper.request(URLUtils.get("gateway") + ServerCenterContants.LOG_CENTER_EXCEPTION_LOG, staffEntity.getToken(), true, exceptionLog,
					HttpMethod.POST);
		} catch (Exception e2) {
			logger.error("日志记录ERROR====", e2);
			logger.error("目标方法错误信息********", e);
		}
	}

//	// 开放接口调用日志
//	@Pointcut("execution(* com.card.manager.factory.*.service.impl.OrderOpenInterfaceServiceImpl.*(..))")
//	public void openInfPointCut() {
//	}
//
//	@Before("openInfPointCut()")
//	public void beforeOpenInfService(JoinPoint jp) {
//		MethodSignature signature = (MethodSignature) jp.getSignature();
//		Method method = signature.getMethod(); // 获取被拦截的方法
//		String methodName = method.getName(); // 获取被拦截的方法名
//		ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
//		HttpServletRequest request = attributes.getRequest();
//		String ip = getOriginIp(request);
////		String callIp = request.getRemoteAddr();
//		StringBuilder sb = new StringBuilder();
//		Enumeration<String> enu = request.getParameterNames();
//		String appKey = "";
//		while (enu.hasMoreElements()) {
//			String paraName = (String) enu.nextElement();
//			String value = request.getParameter(paraName);
//			if (paraName.equals("appKey")) {
//				appKey = value;
//			}
//			sb.append(paraName + ":" + value + ",");
//		}
//		
//		try {
//			Integer centerId = Integer.valueOf(appKey.split("_")[1]);
//			String parameter = sb.substring(0, sb.length() - 1);
//			OpenInfLog log = new OpenInfLog(centerId, ServerLogEnum.ORDER_CENTER.getServerId(),
//					ServerLogEnum.ORDER_CENTER.getServerName(), methodName, ip, parameter);
//			logFeignClient.saveOpenInfoLog(Constants.FIRST_VERSION, log);
//		} catch (NumberFormatException e) {
//			logger.error("区域中心ID转换错误============,appKey参数有误=" + appKey, e);
//		} catch (Exception e) {
//			logger.error("日志记录ERROR====", e);
//		}
//	}

	private String getOriginIp(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		if(ip != null){
			ip = ip.split(",")[0];
		}
		return ip;
	}

	// 自定义注解日志
	@Pointcut("@annotation(com.card.manager.factory.annotation.Log)")
	public void customPointCut() {
	}

	@SuppressWarnings("rawtypes")
	@Before("customPointCut()")
	public void beforeCustomPointCut(JoinPoint jp) {
		StringBuilder param = new StringBuilder();
		String targetName = jp.getTarget().getClass().getName();
		String methodName = jp.getSignature().getName();
		Object[] arguments = jp.getArgs();
		try {
			if (arguments != null && arguments.length > 0) {
				for (Object obj : arguments) {
					if(obj.getClass().getName().contains("com.card.manager.factory")){
						param.append(JSONUtil.toJson(obj) + ";");// 获取目标方法参数
					} else {
						param.append(obj.toString() + ";");// 获取目标方法参数
					}
				}
			}
		} catch (Exception e) {
			logger.error("参数获取出错======", e);
		}
		Class targetClass = null;
		try {
			targetClass = Class.forName(targetName);
		} catch (ClassNotFoundException e) {
			logger.error("实例化类出错======", e);
			return;
		}
		Integer source = null;
		Integer type = null;
		String content = null;
		Method[] methods = targetClass.getMethods();
		for (Method method : methods) {// 获取目标方法自定义注解
			if (method.getName().equals(methodName)) {
				Class[] clazzs = method.getParameterTypes();
				if ((clazzs == null && arguments == null) || clazzs.length == arguments.length) {
					source = method.getAnnotation(Log.class).source();
					type = method.getAnnotation(Log.class).type();
					content = method.getAnnotation(Log.class).content();
					break;
				}
			}
		}
		ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = attributes.getRequest();
		String ip = getOriginIp(request);
//		String callIp = request.getRemoteAddr();
		String parameter = "";
		if(param.length() > 2000){
			parameter = param.substring(0, 1990);
		}else{
			parameter = param.toString();
		}
		LogInfo logInfo = new LogInfo(parameter, source, type, ip, methodName, content,
				ServerLogEnum.COOP_BACK.getServerId());
		try {
			//logFeignClient.saveLogInfo(Constants.FIRST_VERSION, logInfo);
			
			StaffEntity staffEntity = SessionUtils.getOperator(request);
			if (staffEntity.getGradeLevel() == 1) {
				logInfo.setCenterId(staffEntity.getGradeId());
				logInfo.setShopId(staffEntity.getShopId());
			} else if (staffEntity.getGradeLevel() == 2) {
				logInfo.setCenterId(staffEntity.getGradeId());
				logInfo.setShopId(staffEntity.getShopId());
			} else if (staffEntity.getGradeLevel() == 3) {
				logInfo.setCenterId(staffEntity.getParentGradeId());
				logInfo.setShopId(staffEntity.getShopId());
			}
			logInfo.setOpt(staffEntity.getOptName());
			RestCommonHelper helper = new RestCommonHelper();
			helper.request(URLUtils.get("gateway") + ServerCenterContants.LOG_CENTER_LOGINFO_LOG, staffEntity.getToken(), true, logInfo,
					HttpMethod.POST);
		} catch (Exception e) {
			logger.error("日志记录ERROR====", e);
		}
	}
}
