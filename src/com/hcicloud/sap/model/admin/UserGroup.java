package com.hcicloud.sap.model.admin;

import java.util.Date;

/**
 * 机构管理
 * @author lixianji
 *
 */
public class UserGroup{
	/**
	 * 主键
	 */
	private String uuid;
	/**
	 * 部门名称
	 */
	private String name;
	/**
	 * 备注
	 */
	private String remark;
	/**
	 * 更新人
	 */
	private User updateUser;
	/**
	 * 更新时间
	 */
	private Date updateTime;
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
}
