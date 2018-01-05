package com.hcicloud.sap.model.admin;

import java.util.Date;


/**
 * 标准话术
 * @author maguosheng
 *
 */
public class Hotword {
	//主键ID
	private String uuid;
	//标准话术名称
	private String content;
	//操作时间
	private Date updateTime;
	//操作用户
	private User updateUser;
	//状态
	private Integer state;
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
	 * 获得content
	 */
	public String getContent() {
		return content;
	}
	/**
	 * 设置content
	 * @param content
	 */
	public void setContent(String content) {
		this.content = content;
	}
	/**
	 * 获得操作时间
	 * @return
	 */
	public Date getUpdateTime() {
		return updateTime;
	}
	/**
	 * 设置操作时间
	 * @param updateTime
	 */
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	/**
	 * 获得操作用户
	 * @return
	 */
	public User getUpdateUser() {
		return updateUser;
	}
	/**
	 * 设置操作用户
	 * @param updateUser
	 */
	public void setUpdateUser(User updateUser) {
		this.updateUser = updateUser;
	}
	/**
	 * 获得state
	 * @return
	 */
	public Integer getState() {
		return state;
	}
	/**
	 * 设置state
	 * @param state
	 */
	public void setState(Integer state) {
		this.state = state;
	}
	
	
}
