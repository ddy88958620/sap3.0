package com.hcicloud.sap.service.quality;

import java.util.List;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.pagemodel.quality.RulesTypeModel;

public abstract interface RulesTypeServiceI {
	
	public abstract List<RulesTypeModel> dataGrid(RulesTypeModel rulesTypeModel, PageFilter pageFilter);
	
	public abstract RulesTypeModel get(String uuid);
	
	public abstract Boolean isRepeat(String name, String uuid, Boolean flag);
	
	public abstract Long count(RulesTypeModel rulesTypeModel, PageFilter pageFilter);

	public abstract void add(RulesTypeModel rulesTypeModel);
	
	public abstract void update(RulesTypeModel rulesTypeModel);
	
	public abstract void delete(String uuid) throws Exception;
}
