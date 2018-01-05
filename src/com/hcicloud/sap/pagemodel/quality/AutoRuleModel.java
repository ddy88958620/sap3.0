package com.hcicloud.sap.pagemodel.quality;

import java.util.Date;

public class AutoRuleModel{
	/**
	 * 主键ID
	 */
	private String uuid;
	/**
	 * 规则名称
	 */
	private String name;
	/**
	 * 规则内容
	 */
	private String content;
	/**
	 * 规则逻辑
	 */
	private String script;
	/**
	 * 备注
	 */
	private String remark;
	/**
	 * 最后编辑用户ID
	 */
	private String updateById;
	/**
	 * 最后编辑用户姓名
	 */
	private String updateByName;
	/**
	 * 最后编辑时间
	 */
	private Date updateTime;
	/**
	 * 所属规则集ID
	 */
	private String autoRulesId;
	/**
	 * 所属规则集名称
	 */
	private String autoRulesName;
	/**
	 * 状态	0为停用	1为启用
	 */
	private Integer state;
	
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
	 * 获取script
	 * @return the script
	 */
	public String getScript() {
		return script;
	}
	/**
	 * 设置script
	 * @param script the script to set
	 */
	public void setScript(String script) {
		this.script = script;
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
	 * 获取autoRulesId
	 * @return the autoRulesId
	 */
	public String getAutoRulesId() {
		return autoRulesId;
	}
	/**
	 * 设置autoRulesId
	 * @param autoRulesId the autoRulesId to set
	 */
	public void setAutoRulesId(String autoRulesId) {
		this.autoRulesId = autoRulesId;
	}
	/**
	 * 获取autoRulesName
	 * @return the autoRulesName
	 */
	public String getAutoRulesName() {
		return autoRulesName;
	}
	/**
	 * 设置autoRulesName
	 * @param autoRulesName the autoRulesName to set
	 */
	public void setAutoRulesName(String autoRulesName) {
		this.autoRulesName = autoRulesName;
	}
	
	
}