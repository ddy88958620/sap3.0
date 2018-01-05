package com.hcicloud.sap.model.quality;

import java.util.Date;

import com.hcicloud.sap.model.admin.User;

/**
 * 用户
 * @author lixianji
 *
 */
public class Rules {
	
	/**
	 * 主键
	 */
	private String uuid;
	/**
	 * 名称
	 */
	private String name;
	/**
	 * 备注
	 */
	private String remark;
	/**
	 * 状态
	 */
	private Integer state;
	/**
	 * 预置条件
	 */
	private String preconditions;
	/**
	 * 更新时间
	 */
	private Date updateTime;
	/**
	 * 更新人
	 */
	private User updateUser;
	/**
	 * 规则集类型
	 */
	private RulesType rulesType;
	/**
	 * 生效开始时间
	 */
	private Date startTime;
	/**
	 * 生效结束时间
	 */
	private Date endTime;
	/**
	 * 生效用户组集合
	 */
	private String userGroupSet;
    
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
     * 获取preconditions  
     * @return the preconditions
     */
    public String getPreconditions() {
        return preconditions;
    }
    /**
     * 设置preconditions  
     * @param preconditions the preconditions to set
     */
    public void setPreconditions(String preconditions) {
        this.preconditions = preconditions;
    }
    /**
     * 获取rulesType  
     * @return the rulesType
     */
	public RulesType getRulesType() {
		return rulesType;
	}
    /**
     * 设置rulesType  
     * @param rulesType the rulesType to set
     */
	public void setRulesType(RulesType rulesType) {
		this.rulesType = rulesType;
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
    /**
     * 获取userGroupSet  
     * @return the userGroupSet
     */
	public String getUserGroupSet() {
		return userGroupSet;
	}
	/**
	 * 设置userGroupSet 
	 * @param userGroupSet the userGroupSet to set
	 */
	public void setUserGroupSet(String userGroupSet) {
		this.userGroupSet = userGroupSet;
	}
}
