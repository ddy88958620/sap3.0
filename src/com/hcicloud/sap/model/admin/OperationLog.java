package com.hcicloud.sap.model.admin;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * 操作日志
 * @author lixianji
 *
 */
public class OperationLog  {
	/**
	 * 主键
	 */
	private String uuid;
	/**
	 * 用户标识
	 */
	private String userId;
	/**
	 * 用户名称
	 */
	private String userName;
	/**
	 * 菜单
	 */
	private String operationMenu;
	/**
	 * 类型
	 */
	private String operationType;
	/**
	 * 数据名称
	 */
	private String operationData;
	/**
     * 操作时间
     */
    private Date operationTime;
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
     * 获取userId
     * @return the userId
     */
    public String getUserId() {
        return userId;
    }
    /**
     * 设置userId
     * @param userId the userId to set
     */
    public void setUserId(String userId) {
        this.userId = userId;
    }
    /**
     * 获取userName
     * @return the userName
     */
    public String getUserName() {
        return userName;
    }
    /**
     * 设置userName
     * @param userName the userName to set
     */
    public void setUserName(String userName) {
        this.userName = userName;
    }
    /**
     * 获取operationMenu
     * @return the operationMenu
     */
    public String getOperationMenu() {
        return operationMenu;
    }
    /**
     * 设置operationMenu
     * @param operationMenu the operationMenu to set
     */
    public void setOperationMenu(String operationMenu) {
        this.operationMenu = operationMenu;
    }
    /**
     * 获取operationType
     * @return the operationType
     */
    public String getOperationType() {
        return operationType;
    }
    /**
     * 设置operationType
     * @param operationType the operationType to set
     */
    public void setOperationType(String operationType) {
        this.operationType = operationType;
    }
    /**
     * 获取operationData
     * @return the operationData
     */
    public String getOperationData() {
        return operationData;
    }
    /**
     * 设置operationData
     * @param operationData the operationData to set
     */
    public void setOperationData(String operationData) {
        this.operationData = operationData;
    }
    /**
     * 获取operationTime
     * @return the operationTime
     */
    public Date getOperationTime() {
        return operationTime;
    }
    /**
     * 设置operationTime
     * @param operationTime the operationTime to set
     */
    public void setOperationTime(Date operationTime) {
        this.operationTime = operationTime;
    }
	
	
}
