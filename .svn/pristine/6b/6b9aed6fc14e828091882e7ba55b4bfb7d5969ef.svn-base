package com.hcicloud.sap.service.quality;

import java.io.InputStream;
import java.util.List;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.base.SessionInfo;
import com.hcicloud.sap.pagemodel.quality.AutoRuleModel;

public interface AutoRuleServiceI{

	List<AutoRuleModel> dataGrid(AutoRuleModel autoRuleModel, PageFilter page);

	long count(AutoRuleModel autoRuleModel);

	boolean add(String json, SessionInfo sessionInfo);

	Json getFormInfo(String uuid);

	AutoRuleModel get(String uuid);

	Json getAutoRules();

	boolean delete(String uuid);
	/*//同步规则
	boolean synchronizedRule();*/
	
    //快速添加质检规则
	boolean quickAdd(String queryAutoRulesId, String wordsName,
			String wordsContent, SessionInfo sessionInfo);
	
}