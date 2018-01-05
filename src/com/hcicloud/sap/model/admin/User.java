package com.hcicloud.sap.model.admin;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * 用户
 * @author lixianji
 *
 */
public class User{
	/**
	 * 主键
	 */
	private String uuid;
	/**
	 * 名称
	 */
	private String name;
	/**
	 * 登陆名称
	 */
	private String loginName;
	/**
	 * 密码
	 */
	private String password;
	/**
	 * 更新时间
	 */
	private Date updateTime;
	/**
	 * 更新人
	 */
	private User updateUser;
	/**
	 * 状态
	 */
	private Integer state;
	/**
	 * 是否已删除
	 */
	private Integer isDelete;
	/**
	 * 备注
	 */
	private String remark;
	/**
	 * 机构
	 */
	private UserGroup userGroup;
	/**
	 * 角色
	 */
	private Set<Role> roles = new HashSet<Role>(0);
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
     * 获取updateUser  
     * @return the updateUser
     */
    public User getUpdateUser() {
        return updateUser;
    }
    /**
     * 设置updateUser  
     * @param updateUser the updateUser to set
     */
    public void setUpdateUser(User updateUser) {
        this.updateUser = updateUser;
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
    /**
     * 获取userGroup  
     * @return the userGroup
     */
    public UserGroup getUserGroup() {
        return userGroup;
    }
    /**
     * 设置userGroup  
     * @param userGroup the userGroup to set
     */
    public void setUserGroup(UserGroup userGroup) {
        this.userGroup = userGroup;
    }
    /**
     * 获取roles  
     * @return the roles
     */
    public Set<Role> getRoles() {
        return roles;
    }
    /**
     * 设置roles  
     * @param roles the roles to set
     */
    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }
	public Integer getIsDelete() {
		return isDelete;
	}
	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}
}
