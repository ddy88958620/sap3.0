package com.hcicloud.sap.model.quality;


/**
 * 自动质检规则词组
 * @author wangya
 *
 */
public class AutoPhrase{
	/**-- 主键ID --**/
	private String uuid;
	/**-- 名称 --**/
	private String name;
	/**-- 内容 --**/
	private String content;
	/**-- 关联的自动质检规则 --**/
	private AutoRule autoRule;
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
	
	
}