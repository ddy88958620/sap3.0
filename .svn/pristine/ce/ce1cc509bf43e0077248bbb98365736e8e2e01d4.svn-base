package com.hcicloud.sap.service.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.constant.GlobalConstant;
import com.hcicloud.sap.common.utils.Combobox;
import com.hcicloud.sap.common.utils.ErrorReturnMsg;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.common.utils.RedisOpr;
import com.hcicloud.sap.dao.BaseDaoI;
import com.hcicloud.sap.model.admin.Menu;
import com.hcicloud.sap.model.admin.Role;
import com.hcicloud.sap.model.admin.User;
import com.hcicloud.sap.model.admin.UserGroup;
import com.hcicloud.sap.model.admin.UserRoleRelation;
import com.hcicloud.sap.pagemodel.admin.UserModel;
import com.hcicloud.sap.pagemodel.base.Json;

@Service
public class UserServiceImpl implements UserServiceI {

	@Autowired
	private BaseDaoI<User> userDao;

	@Autowired
	private BaseDaoI<Role> roleDao;
	
	@Autowired
	private BaseDaoI<UserRoleRelation> relationDao;

	@Autowired
	private BaseDaoI<UserGroup> userGroupDao;
	
	@Autowired
	private BaseDaoI<Menu> menuDao;

	/**
	 * 获取分页列表
	 * @param userModel
	 * @param pageFilter
	 * @return
	 */
	@Override
	public List<UserModel> dataGrid(UserModel userModel, PageFilter pageFilter) {
		List<UserModel> userModelList = new ArrayList<UserModel>();
		
		String hql = "from User u where 1=1 and u.uuid<>'0' and u.isDelete <> '1' ";
		Map<String, Object> params = new HashMap<String, Object>();
		
		hql += hqlJoin(userModel, params);
		
		List<User> userList = this.userDao.find(hql, params, 
				pageFilter.getiDisplayStart(), pageFilter.getiDisplayLength());

		for(User user : userList) {
			userModel = new UserModel();
			transform(user, userModel);
			userModelList.add(userModel);
		}
		
		return userModelList;
	}
	
	/**
	 * 登陆
	 * @param userModel
	 * @return
	 */
	@Override
	public UserModel login(UserModel userModel) {
		if(userModel == null || userModel.getLoginName() == null
				||userModel.getPassword() == null){
			return null;
		}
		
		String hql = "from User u where u.isDelete <> 1 and u.loginName=:loginName and u.password=:password";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("loginName", userModel.getLoginName());
		params.put("password",  userModel.getPassword());
		
		User user = this.userDao.get(hql, params);
		
		if (user != null) {
		    UserModel u = new UserModel();
			BeanUtils.copyProperties(user, u);
			u.setUserGroupId(user.getUserGroup().getUuid());
			u.setUserGroupName(user.getUserGroup().getName());
			return u;
		}
		
		return null;
	}

	/**
	 * 通过ID获取实例
	 * @param uuid
	 * @return
	 */
	@Override
	public UserModel get(String uuid) {
		User user = this.userDao.get(User.class, uuid);
		UserModel userModel = new UserModel();
		transform(user, userModel);
		return userModel;
	}

	/**
	 * 用户登录名判重
	 * @param loginName
	 * @return
	 */
	@Override
	public Boolean isRepeat(String loginName, String uuid, Boolean flag) {
		String hql = "select count(*) from User u where u.isDelete <> '1' and u.loginName=:loginName";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("loginName", loginName);
		
		if(flag) {
			hql += " and u.uuid!=:uuid";
			params.put("uuid", uuid);
		}
		
		Long count = this.userDao.count(hql, params);
		if(count <= 0) {
			return false;
		} else {
			return true;
		}
	}

	/**
	 * 统计数量
	 * @param userModel
	 * @param pageFilter
	 * @return
	 */
	@Override
	public Long count(UserModel userModel, PageFilter pageFilter) {
		String hql = "select count(*) from User u where 1=1 and u.isDelete <> '1' and u.uuid<>'0' ";
		Map<String, Object> params = new HashMap<String, Object>();
		
		hql += hqlJoin(userModel, params);
		
		Long count = this.userDao.count(hql, params);
		
		return count;
	}

	/**
	 * 新增用户
	 * @param userModel
	 */
	@Override
	public void add(UserModel userModel) {
		User user = new User();
		transform(userModel, user);
		user.setIsDelete(0);
		this.userDao.save(user);
	}

	/**
	 * 编辑用户
	 * @param userModel
	 */
	@Override
	public void update(UserModel userModel) {
		User user = this.userDao.get(User.class, userModel.getUuid());
		userModel.setPassword(user.getPassword());
		transform(userModel, user);
		this.userDao.update(user);
	}
	
	/**
	 * 快速设置
	 * @param userModel
	 */
	@Override
	public void state(UserModel userModel) {
		User user = this.userDao.get(User.class, userModel.getUuid());
		user.setState(userModel.getState());
		user.setUpdateTime(new Date());
		user.setUpdateUser(this.userDao.get(User.class, userModel.getUpdateById()));
		this.userDao.update(user);
	}
	
	/**
	 * 重置密码
	 * @param userModel
	 */
	@Override
	public void password(UserModel userModel) {
		User user = this.userDao.get(User.class, userModel.getUuid());
		user.setPassword(userModel.getPassword());
		user.setUpdateTime(new Date());
		user.setUpdateUser(this.userDao.get(User.class, userModel.getUpdateById()));
		this.userDao.update(user);
	}
	
	/**
	 * 用户修改密码
	 * @param uuid
	 * @param oldPassword
	 * @param newPassword
	 */
	@Override
	public Json changePassword(String uuid, String oldPassword,
			String newPassword) {
		Json json = new Json();
		User user = this.userDao.get(User.class, uuid);
		if(oldPassword.equals(user.getPassword())){
			user.setPassword(newPassword);
			user.setUpdateTime(new Date());
			user.setUpdateUser(this.userDao.get(User.class, uuid));
			this.userDao.update(user);
			json.setSuccess(true);
			json.setMsg(ErrorReturnMsg.RESET_PASSWORD_SUCCESSFULLY);
		}else{
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.ORIGINAL_PASSWORD_FAILED);
		}
		return json;
		
	}
	
	/**
	 * 获取表单相关信息 
	 * @param json
	 * @return
	 */
	@Override
	public Json getFormInfo(Json json) {
		json.setSuccess(true);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("stateList", GlobalConstant.statelist);
		
		jsonObject.put("userGroupList", getUserGroupInfo(false));
		
		List<Role> roleList = this.roleDao.find("from Role where uuid<>'0'");
		Map<String, String> roleMap = new HashMap<String, String>();
		for(Role role : roleList) {
			roleMap.put(role.getUuid(), role.getName());
		}
		jsonObject.put("roleList", roleMap);
		
		json.setObj(jsonObject);
		
		return json;
	}
	
	/**
	 * 获取用户组相关信息
	 * @param json
	 * @return
	 */
	@Override
	public Json getUserGroupInfo(Json json,boolean flag) {
		json.setSuccess(true);
		json.setObj(getUserGroupInfo(flag));
		return json;
	}
	/**
	 * 获取用户组相关信息
	 * @param json
	 * @param userGroupId
	 * @param flag
	 * @param role
	 * @return
	 */
	@Override
	public Json getUserInfoByGroupId(Json json,String userGroupId,boolean flag,String role) {
		json.setSuccess(true);
		json.setObj(getUserInfo(userGroupId,flag,role));
		return json;
	}
	/**
	 * 获取权限列表
	 * @param uuid
	 * @return
	 */
	@Override
	public List<String> getPrivilegeList(String uuid) {
		List<String> privilegeList = new ArrayList<String>();
		
		String hql = "from User u join fetch u.roles role join fetch role.menus m where u.uuid=:uuid";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("uuid", uuid);
		User user = this.userDao.get(hql, params);
		
		if (user != null) {
			Set<Role> roles = user.getRoles();
			Set<Menu> menus = null;
			
			if ((roles != null) && !roles.isEmpty()) {
				for (Role role : roles) {
					menus = role.getMenus();

					if (menus != null && !menus.isEmpty()) {
						for (Menu menu : menus) {
							if (menu != null && menu.getUrl() != null) {
								privilegeList.add(menu.getUrl());
							}
						}
					}
				}
			}
		}

		return privilegeList;
	}
	
	/**
	 * 获取用户菜单列表
	 * @param userUuid
	 * @param isAdmin
	 * @return
	 */
	@Override
	public Map<String, List<Menu>> getUserMenuMap(String userUuid, boolean isAdmin) {
		Map<String, List<Menu>> map = new HashMap<String, List<Menu>>();
		List<Menu> list = new ArrayList<Menu>();
		
		String hql = "select distinct(m) from User u right join u.roles r right join r.menus m where m.state=1 and u.uuid=:uuid order by m.orderNum";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("uuid", userUuid);
		list= this.menuDao.find(hql, params);
		if (list == null) {
			return map;
		}
		
		String parentId = null;
		List<Menu> tempList = null;
		for (Menu menu : list) {
			parentId = menu.getParentMenu()!=null ? menu.getParentMenu().getUuid() : null;
			
			if (map.containsKey(parentId)) {
				tempList = map.get(parentId);
			} else {
				tempList = new ArrayList<Menu>();
			}
			tempList.add(menu);
			
			map.put(parentId, tempList);
		}
		
		return map;
	}
	
	/**
	 * 获取redis中的消息
	 * @param uuid
	 * @return
	 */
	@Override
	public List<String> getMessages(String uuid){
		List<String> result = new ArrayList<String>(); 
		
		long length = RedisOpr.llen("sap_message_"+uuid);
		try {
			if (length>0) {
				List<byte[]> list = RedisOpr.lrange("sap_message_"+uuid, 0, length);
				
				for(byte[] message : list){
					result.add(new String(message,"UTF-8"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	/**
	 * 获取用户组信息
	 * @return
	 */
	private List<Combobox> getUserGroupInfo(Boolean flag) {
		List<UserGroup> userGroupList = this.userGroupDao.find("from UserGroup ug where 1=1 and ug.uuid<>'0' ");
		
		List<Combobox> userGroupComboboxList = new ArrayList<Combobox>();
		
		Combobox combobox = null;
		if(flag) {
			combobox = new Combobox();
			combobox.setId("-1");
			combobox.setText("全部用户组");
			userGroupComboboxList.add(combobox);
		}
		
		for(UserGroup userGroup : userGroupList) {
			combobox = new Combobox();
			combobox.setId(userGroup.getUuid());
			combobox.setText(userGroup.getName());
			
			userGroupComboboxList.add(combobox);
		}

		return userGroupComboboxList;
	}
	/**
	 * 获取用户组下的用户信息
	 * @return
	 */
	private List<Combobox> getUserInfo(String userGroupId,Boolean flag,String role) {
		String hql = "from User u where 1=1 and u.isDelete <> '1' and u.userGroup.uuid = :userGroupId ";
		Map<String,Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userGroupId", userGroupId);
		List<User> userList = this.userDao.find(hql, paramMap);
		
		List<Combobox> userGroupComboboxList = new ArrayList<Combobox>();
		
		Combobox combobox = null;
		if(flag) {
			combobox = new Combobox();
			combobox.setId("-1");
			combobox.setText("全部用户");
			userGroupComboboxList.add(combobox);
		}
		
		for(User user : userList) {
			 boolean isShow = false;
			if(!"-1".equals(role)){
				Set<Role> userRole = user.getRoles();
				 for (Role role2 : userRole) {
					 if(role.indexOf(role2.getUuid())!=-1){
						 isShow = true;
					 }
				}
			}
			if(!isShow){
				continue;
			}
			combobox = new Combobox();
			combobox.setId(user.getUuid());
			combobox.setText(user.getName());
			
			userGroupComboboxList.add(combobox);
		}

		return userGroupComboboxList;
	}
	
	/**
	 * hql语句拼接
	 * @param userModel
	 * @param params
	 * @return
	 */
	private String hqlJoin(UserModel userModel, Map<String, Object> params) {
		String hql = "";
		
		if(userModel.getLoginName() != null && !"".equals(userModel.getLoginName())) {
			hql += " and u.loginName like :loginName";
			params.put("loginName", "%" + userModel.getLoginName() + "%");
		}
		if(userModel.getUserGroupId() != null && !"".equals(userModel.getUserGroupId())) {
			hql += " and u.userGroup.uuid=:uuid";
			params.put("uuid", userModel.getUserGroupId());
		}
		   hql+=" order by u.updateTime desc";
		return hql;
	}
	
	/**
	 * 用户PageModel转换为用户Model
	 * @param userModel
	 * @param user
	 */
	private void transform(UserModel userModel, User user) {
		BeanUtils.copyProperties(userModel, user);
		user.setUpdateTime(new Date());
		user.setUpdateUser(this.userDao.get(User.class, userModel.getUpdateById()));
		user.setUserGroup(this.userGroupDao.get(UserGroup.class, userModel.getUserGroupId()));
		
		List<Role> roles = new ArrayList<Role>();
		if (userModel.getRoleIds() != null && !"".equals(userModel.getRoleIds())) {
			for (String roleId : userModel.getRoleIds().split(",")) {
				if (roleId != null && !"".equals(roleId)) {
					roles.add(this.roleDao.get(Role.class, roleId));
				}
				
			}
		}
		user.setRoles(new HashSet<Role>(roles));
	}
	
	/**
	 * 用户Model转换为用户PageModel
	 * @param userModel
	 * @param user
	 */
	private void transform(User user, UserModel userModel) {
		BeanUtils.copyProperties(user, userModel);
		
		Set<Role> roles = user.getRoles();
		if ((roles != null) && (!roles.isEmpty())) {
			String roleIds = "";
			String roleNames = "";

			int i = 0;
			for (Role role : roles) {
				roleIds += role.getUuid();
				roleNames += role.getName();
				
				if(i != roles.size() - 1) {
					roleIds += ",";
					roleNames += ",";
				}
				
				i++;
			}
			
			userModel.setRoleIds(roleIds);
			userModel.setRoleNames(roleNames);
		}
		
		if (user.getUserGroup() != null) {
		    userModel.setUserGroupId(user.getUserGroup().getUuid());
		    userModel.setUserGroupName(user.getUserGroup().getName());
		}
		
		if(user.getUpdateUser() != null) {
			userModel.setUpdateById(user.getUpdateUser().getUuid());
			userModel.setUpdateByName(user.getUpdateUser().getName());
		}
	}

	@Override
	public void delete(String uuid) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("uuid", uuid);
		User user = this.userDao.get(User.class, uuid);
		user.setUpdateTime(new Date());
		user.setIsDelete(1);
		this.userDao.update(user);
	}

}