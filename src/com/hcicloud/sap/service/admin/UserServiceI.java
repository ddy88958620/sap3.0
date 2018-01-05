package com.hcicloud.sap.service.admin;

import java.util.List;
import java.util.Map;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.model.admin.Menu;
import com.hcicloud.sap.pagemodel.admin.UserModel;
import com.hcicloud.sap.pagemodel.base.Json;

public abstract interface UserServiceI {
	
	public abstract List<UserModel> dataGrid(UserModel userModel, PageFilter pageFilter);
	
	public abstract UserModel login(UserModel userModel);
	
	public abstract UserModel get(String uuid);
	
	public abstract Boolean isRepeat(String loginName, String uuid, Boolean flag);
	
	public abstract Long count(UserModel userModel, PageFilter pageFilter);

	public abstract void add(UserModel userModel);
	
	public abstract void update(UserModel userModel);
	
	public abstract void state(UserModel userModel);
	
	public abstract void password(UserModel userModel);
	
	public abstract Json getFormInfo(Json json);
	
	public abstract Json getUserGroupInfo(Json json,boolean flag);
	
	public abstract Json getUserInfoByGroupId(Json json,String userGroupId,boolean flag,String role);
	
	public abstract List<String> getPrivilegeList(String uuid);
	
	public Map<String, List<Menu>> getUserMenuMap(String userUuid, boolean isAdmin);
	  
	public List<String> getMessages(String uuid);

	public abstract Json changePassword(String uuid, String oldPassword,
			String newPassword);
	
	public void delete(String uuid);
}
