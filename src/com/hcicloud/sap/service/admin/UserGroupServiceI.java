package com.hcicloud.sap.service.admin;

import java.util.List;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.pagemodel.admin.UserGroupModel;

public abstract interface UserGroupServiceI {
	
	public abstract List<UserGroupModel> dataGrid(UserGroupModel userGroupModel, PageFilter pageFilter);
	
	public abstract UserGroupModel get(String uuid);
	
	public abstract Boolean isRepeat(String name, String uuid, Boolean flag);
	
	public abstract Long count(UserGroupModel userGroupModel, PageFilter pageFilter);

	public abstract void add(UserGroupModel userGroupModel);
	
	public abstract void update(UserGroupModel userGroupModel);
	
	public abstract void delete(String uuid) throws Exception;
}
