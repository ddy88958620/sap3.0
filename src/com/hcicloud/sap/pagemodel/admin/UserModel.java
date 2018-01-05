package com.hcicloud.sap.pagemodel.admin;

import java.io.Serializable;
import java.util.Date;

public class UserModel implements Serializable {
	/**
     * 
     */
    private static final long serialVersionUID = 6004892180441339261L;
    
    /**
     * 主键
     */
    private String uuid;
    /**
     * 登录名
     */
	private String loginName;
	/**
	 * 密码
	 */
	private String password;
	/**
	 * 姓名
	 */
	private String name;
	/**
	 * 最后编辑时间
	 */
	private Date updateTime;
	/**
	 * 最后编辑用户ID
	 */
	private String updateById;
	/**
	 * 最后编辑用户姓名
	 */
	private String updateByName;
	/**
	 * 状态	0为停用	1为启用
	 */
	private Integer state;
	/**
	 * 所属用户组ID
	 */
	private String userGroupId;
	/**
	 * 所属用户组名称
	 */
	private String userGroupName;
	/**
	 * 角色ID集合
	 */
	private String roleIds;
	/**
	 * 角色名称集合
	 */
	private String roleNames;
	/**
	 * 备注
	 */
	private String remark;
	
	/**
	 * 获取uuid
	 * @return the uuid
	 */
	public String getUuid() {
		return uuid;
	}
	/**
	 * 设置uuid
	 * @param uuid the uuid to set
	 */
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	/**
	 * 获取loginName
	 * @return the loginName
	 */
	public String getLoginName() {
		return loginName;
	}
	/**
	 * 设置loginName
	 * @param loginName the loginName to set
	 */
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	/**
	 * 获取password
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}
	/**
	 * 设置password
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	/**
	 * 获取name
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * 设置name
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * 获取updateTime
	 * @return the updateTime
	 */
	public Date getUpdateTime() {
		return updateTime;
	}
	/**
	 * 设置updateTime
	 * @param updateTime the updateTime to set
	 */
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	/**
	 * 获取updateById
	 * @return the updateById
	 */
	public String getUpdateById() {
		return updateById;
	}
	/**
	 * 设置updateById
	 * @param updateById the updateById to set
	 */
	public void setUpdateById(String updateById) {
		this.updateById = updateById;
	}
	/**
	 * 获取updateByName
	 * @return the updateByName
	 */
	public String getUpdateByName() {
		return updateByName;
	}
	/**
	 * 设置updateByName
	 * @param updateByName the updateByName to set
	 */
	public void setUpdateByName(String updateByName) {
		this.updateByName = updateByName;
	}
	/**
	 * 获取state
	 * @return the state
	 */
	public Integer getState() {
		return state;
	}
	/**
	 * 设置state
	 * @param state the state to set
	 */
	public void setState(Integer state) {
		this.state = state;
	}
	/**
	 * 获取userGroupId
	 * @return the userGroupId
	 */
	public String getUserGroupId() {
		return userGroupId;
	}
	/**
	 * 设置userGroupId
	 * @param userGroupId the userGroupId to set
	 */
	public void setUserGroupId(String userGroupId) {
		this.userGroupId = userGroupId;
	}
	/**
	 * 获取userGroupName
	 * @return the userGroupName
	 */
	public String getUserGroupName() {
		return userGroupName;
	}
	/**
	 * 设置userGroupName
	 * @param userGroupName the userGroupName to set
	 */
	public void setUserGroupName(String userGroupName) {
		this.userGroupName = userGroupName;
	}
	/**
	 * 获取roleIds
	 * @return the roleIds
	 */
	public String getRoleIds() {
		return roleIds;
	}
	/**
	 * 设置roleIds
	 * @param roleIds the roleIds to set
	 */
	public void setRoleIds(String roleIds) {
		this.roleIds = roleIds;
	}
	/**
	 * 获取roleNames
	 * @return the roleNames
	 */
	public String getRoleNames() {
		return roleNames;
	}
	/**
	 * 设置roleNames
	 * @param roleNames the roleNames to set
	 */
	public void setRoleNames(String roleNames) {
		this.roleNames = roleNames;
	}
	/**
	 * 获取remark
	 * @return the remark
	 */
	public String getRemark() {
		return remark;
	}
	/**
	 * 设置remark
	 * @param remark the remark to set
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}
}
