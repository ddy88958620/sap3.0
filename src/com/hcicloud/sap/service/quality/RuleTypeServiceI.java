package com.hcicloud.sap.service.quality;

import java.util.List;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.pagemodel.quality.RuleTypeModel;

public abstract interface RuleTypeServiceI {
	
	public abstract List<RuleTypeModel> dataGrid(RuleTypeModel ruleTypeModel, PageFilter pageFilter);
	
	public abstract RuleTypeModel get(String uuid);
	
	public abstract Boolean isRepeat(String name, String uuid, Boolean flag);
	
	public abstract Long count(RuleTypeModel ruleTypeModel, PageFilter pageFilter);

	public abstract void add(RuleTypeModel ruleTypeModel);
	
	public abstract void update(RuleTypeModel ruleTypeModel);
	
}
