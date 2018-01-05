package com.hcicloud.sap.model.quality;

import java.util.Date;

import com.hcicloud.sap.model.admin.User;


/**
 * 自动质检规则词组
 * @author wangya
 *
 */
public class AutoLexicon{
	/**-- 主键ID --**/
	private String uuid;
	/**-- 名称 --**/
	private String name;
	/**-- 内容 --**/
	private String content;
	/**-- 关联的自动质检规则 --**/
	private AutoRule autoRule;
	//最后更新用户
	private User updateUser;
	//最后更新时间
	private Date updateTime;
	//状态
	private Integer state;
	//是否是通用词组
	private Integer flag;
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
	 * 获取content
	 * @return the content
	 */
	public String getContent() {
		return content;
	}
	/**
	 * 设置content
	 * @param content the content to set
	 */
	public void setContent(String content) {
		this.content = content;
	}
	/**
	 * 获取autoRule
	 * @return the autoRule
	 */
	public AutoRule getAutoRule() {
		return autoRule;
	}
	/**
	 * 设置autoRule
	 * @param autoRule the autoRule to set
	 */
	public void setAutoRule(AutoRule autoRule) {
		this.autoRule = autoRule;
	}
	public User getUpdateUser() {
		return updateUser;
	}
	public void setUpdateUser(User updateUser) {
		this.updateUser = updateUser;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public Integer getFlag() {
		return flag;
	}
	public void setFlag(Integer flag) {
		this.flag = flag;
	}
	
	
}