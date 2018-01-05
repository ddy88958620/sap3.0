package com.hcicloud.sap.model.quality;

import java.util.Date;

import com.hcicloud.sap.model.admin.User;

/**
 * 标准话术
 * @author maguosheng
 *
 */
public class StandardSpeech {
	//主键ID
	private String uuid;
	//标准话术名称
	private String name;
	//编辑用户ID
	private User updateUser;
	//标准话术内容
	private String content;
	//状态 
	private Integer state;
	//编辑时间
	private Date updateTime;
	//阈值
	private String threshold;
	/**
	 * 获得UUID
	 * @return
	 */
	public String getUuid() {
		return uuid;
	}
	/**
	 * 设置UUID
	 * @param uuid
	 */
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	/**
	 * 获得name
	 * @return
	 */
	public String getName() {
		return name;
	}
	/**
	 * 设置name
	 * @param uuid
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * 获得updateUserId
	 * @return
	 */
	public User getUpdateUser() {
		return updateUser;
	}
	/**
	 * 设置updateUserId
	 * @param uuid
	 */
	public void setUpdateUser(User updateUser) {
		this.updateUser = updateUser;
	}
	/**
	 * 获得context
	 * @return
	 */
	public String getContent() {
		return content;
	}
	/**
	 * 设置context
	 * @param uuid
	 */
	public void setContent(String content) {
		this.content = content;
	}
	/**
	 * 获得status
	 * @return
	 */
	public Integer getState() {
		return state;
	}
	/**
	 * 设置status
	 * @param uuid
	 */
	public void setState(Integer state) {
		this.state = state;
	}
	/**
	 * 获得updateTime
	 * @return
	 */
	public Date getUpdateTime() {
		return updateTime;
	}
	/**
	 * 设置updateTime
	 * @param uuid
	 */
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public String getThreshold() {
		return threshold;
	}
	public void setThreshold(String threshold) {
		this.threshold = threshold;
	}
}
