package com.hcicloud.sap.model.quality;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import com.hcicloud.sap.model.admin.User;

/**
 * 用户
 * @author lixianji
 *
 */
public class FreeQuality{
	/**
	 * 主键
	 */
	private String uuid;
	/**
	 * 更新时间
	 */
	private Date updateTime;
	/**
	 * 免检用户
	 */
	private User user;
	/**
	 * 更新人
	 */
	private User updateUser;
	/**
	 * 备注
	 */
	private String remark;
	/**
	 * 免检开始时间
	 */
	private Date startTime;
	/**
	 * 免检结束时间
	 */
	private Date endTime;
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
     * 获取user  
     * @return the user
     */
    public User getUser() {
        return user;
    }
    /**
     * 设置user  
     * @param user the user to set
     */
    public void setUser(User user) {
        this.user = user;
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
     * 获取startTime  
     * @return the startTime
     */
    public Date getStartTime() {
        return startTime;
    }
    /**
     * 设置startTime  
     * @param startTime the startTime to set
     */
    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }
    /**
     * 获取endTime  
     * @return the endTime
     */
    public Date getEndTime() {
        return endTime;
    }
    /**
     * 设置endTime  
     * @param endTime the endTime to set
     */
    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }
	
	
	
}
