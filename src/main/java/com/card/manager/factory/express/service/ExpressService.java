package com.card.manager.factory.express.service;

import java.util.List;

import com.card.manager.factory.common.serivce.ServerCenterService;
import com.card.manager.factory.express.model.ExpressRule;
import com.card.manager.factory.express.model.ExpressTemplateBO;
import com.card.manager.factory.express.model.RuleParameter;
import com.card.manager.factory.system.model.StaffEntity;

public interface ExpressService extends ServerCenterService{

	void enable(StaffEntity staffEntity, Integer id);

	ExpressTemplateBO getExpressTemplate(String token, String id);

	void save(StaffEntity staffEntity, ExpressTemplateBO template);

	void del(StaffEntity staffEntity, Integer id);

	void delRule(StaffEntity staffEntity, Integer id);

	List<ExpressRule> listRule(StaffEntity staffEntity);

	List<RuleParameter> listRuleParam(StaffEntity staffEntity, Integer id, String param);

	void addRuleParam(StaffEntity staffEntity, RuleParameter ruleParameter);
}
