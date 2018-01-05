package com.hcicloud.sap.service.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.dao.BaseDaoI;
import com.hcicloud.sap.model.admin.User;
import com.hcicloud.sap.model.admin.UserGroup;
import com.hcicloud.sap.pagemodel.admin.UserGroupModel;

@Service
public class UserGroupServiceImpl implements UserGroupServiceI {
	
	@Autowired
	private BaseDaoI<User> userDao;
	
	@Autowired
	private BaseDaoI<UserGroup> userGroupDao;
	
	/**
	 * 获取分页列表
	 * @param userGroupModel
	 * @param pageFilter
	 * @return
	 */
	@Override
	public List<UserGroupModel> dataGrid(UserGroupModel userGroupModel, PageFilter pageFilter) {
		List<UserGroupModel> userGroupModelList = new ArrayList<UserGroupModel>();
		
		String hql = "from UserGroup ug where 1=1 and ug.uuid<>'0' ";
		Map<String, Object> params = new HashMap<String, Object>();
		
		hql += hqlJoin(userGroupModel, params);
		
		List<UserGroup> userGroupList = this.userGroupDao.find(hql, params, 
				pageFilter.getiDisplayStart(), pageFilter.getiDisplayLength());
		//打印日志
        /*for (UserGroup userGroup : userGroupList) {
    	   System.out.println(userGroup.getUuid()+"    "+userGroup.getName());
    	   System.out.println();
        }*/
		copy(userGroupList, userGroupModelList);
		
		return userGroupModelList;
	}
	
	/**
	 * 通过ID获取实例
	 * @param uuid
	 * @return
	 */
	@Override
	public UserGroupModel get(String uuid) {
		UserGroup userGroup = this.userGroupDao.get(UserGroup.class, uuid);

		UserGroupModel userGroupModel = new UserGroupModel();
		BeanUtils.copyProperties(userGroup, userGroupModel);
		if (userGroup.getUpdateUser()!= null) {
			userGroupModel.setUpdateById(userGroup.getUpdateUser().getUuid());
			userGroupModel.setUpdateByName(userGroup.getUpdateUser().getName());
		}
		
		return userGroupModel;
	}
	
	/**
	 * 用户组名判重
	 * @param name
	 * @return
	 */
	@Override
	public Boolean isRepeat(String name, String uuid, Boolean flag) {
		String hql = "select count(*) from UserGroup ug where ug.name=:name";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("name", name);
		
		if(flag) {
			hql += " and ug.uuid!=:uuid";
			params.put("uuid", uuid);
		}
		
		Long count = this.userGroupDao.count(hql, params);
		if(count <= 0) {
			return false;
		} else {
			return true;
		}
	}

	/**
	 * 统计数量
	 * @param userGroupModel
	 * @param pageFilter
	 * @return
	 */
	@Override
	public Long count(UserGroupModel userGroupModel, PageFilter pageFilter) {
		String hql = "select count(*) from UserGroup ug where 1=1 and ug.uuid<>'0' ";
		Map<String, Object> params = new HashMap<String, Object>();
		
		hql += hqlJoin(userGroupModel, params);
		
		Long count = this.userGroupDao.count(hql, params);
		
		return count;
	}

	/**
	 * 新增用户组
	 * @param userGroupModel
	 */
	@Override
	public void add(UserGroupModel userGroupModel) {
		UserGroup userGroup = new UserGroup();

		BeanUtils.copyProperties(userGroupModel, userGroup);
		userGroup.setUpdateTime(new Date());
		userGroup.setUpdateUser(this.userDao.get(User.class, userGroupModel.getUpdateById()));
		
		this.userGroupDao.save(userGroup);
	}
	
	/**
	 * 编辑用户组
	 * @param userGroupModel
	 */
	@Override
	public void update(UserGroupModel userGroupModel) {
		UserGroup userGroup = new UserGroup();

		BeanUtils.copyProperties(userGroupModel, userGroup);
		userGroup.setUpdateTime(new Date());
		userGroup.setUpdateUser(this.userDao.get(User.class, userGroupModel.getUpdateById()));
		
		this.userGroupDao.update(userGroup);
	}

	/**
	 * 删除用户组
	 * @param uuid
	 * @throws Exception 
	 */
	@Override
	public void delete(String uuid) throws Exception {
		String hql = "select count(*) from User u where u.userGroup.uuid=:uuid";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("uuid", uuid);
		Long count = this.userGroupDao.count(hql, params);
		
		if(count > 0) {
			throw new Exception("存在级联信息");
		}
		UserGroup userGroup = this.userGroupDao.get(UserGroup.class, uuid);
		this.userGroupDao.delete(userGroup);
	}
	
	/**
	 * hql语句拼接
	 * @param userGroupModel
	 * @param params
	 * @return
	 */
	private String hqlJoin(UserGroupModel userGroupModel, Map<String, Object> params) {
		String hql = "";
		
		if(userGroupModel.getName() != null && !"".equals(userGroupModel.getName())) {
			hql += " and ug.name like :name";
			params.put("name", "%" + userGroupModel.getName() + "%");
		}
		hql +=" order by ug.updateTime desc";
		return hql;
	}
	
	/**
	 * userGroupList转换为userGroupModelList
	 * @param userGroupList
	 * @param userGroupModelList
	 */
	private void copy(List<UserGroup> userGroupList,
			List<UserGroupModel> userGroupModelList) {
		UserGroupModel userGroupModel = null;
		
		for(UserGroup userGroup : userGroupList) {
			userGroupModel = new UserGroupModel();
			
			BeanUtils.copyProperties(userGroup, userGroupModel);
			if(userGroup.getUpdateUser() != null) {
				userGroupModel.setUpdateById(userGroup.getUpdateUser().getUuid());
				userGroupModel.setUpdateByName(userGroup.getUpdateUser().getName());
			}
			
			userGroupModelList.add(userGroupModel);
		}
	}
}
