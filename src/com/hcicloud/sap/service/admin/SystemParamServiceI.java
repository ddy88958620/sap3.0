package com.hcicloud.sap.service.admin;

import java.util.List;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.model.admin.SystemParam;

public abstract interface SystemParamServiceI {
	
	public abstract List<SystemParam> dataGrid(SystemParam systemParam, PageFilter pageFilter);
	
	public abstract SystemParam get(String uuid);
	
	public abstract Boolean isRepeat(String name, String uuid, Boolean flag);
	
	public abstract Long count(SystemParam systemParam, PageFilter pageFilter);

	public abstract void add(SystemParam systemParam);
	
	public abstract void update(SystemParam systemParam);

	public abstract String getParamSystemByName(String name);
}
