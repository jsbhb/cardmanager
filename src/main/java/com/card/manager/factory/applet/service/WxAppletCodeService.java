package com.card.manager.factory.applet.service;

import com.card.manager.factory.applet.model.AppletCodeParameter;
import com.card.manager.factory.exception.WxCodeException;
import com.card.manager.factory.system.model.StaffEntity;

public interface WxAppletCodeService {

	/**
	 * 
	 * @fun 获取微信小程序二维码
	 * @param param
	 *            获取二维码必要参数
	 * @param needToCoverLogo
	 *            是否需要覆盖二维码中间的logo
	 * @param opt
	 * @return
	 * @throws WxCodeException
	 */
	public String getWxAppletCode(AppletCodeParameter param, boolean needToCoverLogo, StaffEntity opt)
			throws WxCodeException;
}
