package com.hcicloud.sap.service.quality;

import java.util.List;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.pagemodel.quality.AutoRulesModel;

public interface AutoRulesServiceI{

	public abstract List<AutoRulesModel> dataGrid(AutoRulesModel autoRulesModel, PageFilter page);

	public abstract AutoRulesModel get(String uuid);
	
	public abstract void add(AutoRulesModel autoRulesModel);

	public abstract void update(AutoRulesModel autoRulesModel);

	public abstract void delete(String uuid) throws Exception;

	Boolean isRepeat(String name, String uuid, Boolean flag);

	long count(AutoRulesModel autoRulesModel, PageFilter pageFilter);


}