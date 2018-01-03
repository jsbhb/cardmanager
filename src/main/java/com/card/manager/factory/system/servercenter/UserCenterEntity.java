/**  
 * Project Name:cardmanager  
 * File Name:UserCenterEntity.java  
 * Package Name:com.card.manager.factory.system.servercenter  
 * Date:Oct 26, 20174:53:38 PM  
 *  
 */
package com.card.manager.factory.system.servercenter;

import com.card.manager.factory.auth.model.PlatUserType;
import com.card.manager.factory.system.model.StaffEntity;

/**
 * ClassName: UserCenterEntity <br/>
 * Function: 服务中心-用户实体类. <br/>
 * date: Oct 26, 2017 4:53:38 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class UserCenterEntity {
	private String account;// badge
	private int platUserType;
	private int userType;
	private int centerId;
	private int shopId;
	private String phone;

	/**
	 * Creates a new instance of UserCenterEntity.
	 * 
	 * @param entity
	 * @param phone2
	 */

	public UserCenterEntity(StaffEntity entity, String phone) {
		this.platUserType = PlatUserType.CROSS_BORDER.getIndex();
		this.shopId = entity.getShopId();
		this.centerId = entity.getGradeId();
		this.phone = phone;
		this.userType = entity.getGradeLevel();
		this.account = entity.getBadge();
	}

	public int getUserType() {
		return userType;
	}

	public void setUserType(int userType) {
		this.userType = userType;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public int getPlatUserType() {
		return platUserType;
	}

	public void setPlatUserType(int platUserType) {
		this.platUserType = platUserType;
	}

	public int getCenterId() {
		return centerId;
	}

	public void setCenterId(int centerId) {
		this.centerId = centerId;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getShopId() {
		return shopId;
	}

	public void setShopId(int shopId) {
		this.shopId = shopId;
	}
	
	
}
