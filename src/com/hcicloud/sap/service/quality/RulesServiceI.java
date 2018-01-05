package com.hcicloud.sap.service.quality;

import java.util.List;
import java.util.Map;

import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.base.SessionInfo;
import com.hcicloud.sap.pagemodel.quality.RuleModel;
import com.hcicloud.sap.pagemodel.quality.RulesModel;


public abstract interface RulesServiceI {
	
	public abstract List<RulesModel> dataGrid(RulesModel rulesModel, int rows, int page);
	
	public abstract List<RuleModel> getRuleByRulesId(String uuid);
	
	public abstract RulesModel get(String uuid);
	
	public abstract Long count(RulesModel rulesModel);
	
	public abstract Json getFormInfo(String uuid);
	
	public abstract Json getRulesTypeInfo();
	
	public abstract void add(String json, SessionInfo sessionInfo) throws Exception;
	
	public abstract List<Map<String, String>> loadRuleTypeInfo(String type);
}
