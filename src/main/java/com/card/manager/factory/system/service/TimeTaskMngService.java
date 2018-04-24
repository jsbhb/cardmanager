/**  
 * Project Name:cardmanager  
 * File Name:GradeMngService.java  
 * Package Name:com.card.manager.factory.system.service  
 * Date:Sep 17, 20172:52:45 PM  
 *  
 */
package com.card.manager.factory.system.service;

import com.card.manager.factory.common.serivce.ServerCenterService;
import com.card.manager.factory.system.model.StaffEntity;
import com.card.manager.factory.system.model.TimeTaskModel;

public interface TimeTaskMngService extends ServerCenterService {
	
	TimeTaskModel queryTimeTaskById(Integer id, StaffEntity opt);
	
	void startTimeTaskById(Integer id, StaffEntity opt) throws Exception;
	
	void stopTimeTaskById(Integer id, StaffEntity opt) throws Exception;
	
	void updateTimeTask(TimeTaskModel entity, StaffEntity opt) throws Exception;
}
