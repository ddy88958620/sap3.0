package com.hcicloud.sap.pagemodel.quality;

public class AutoPhraseModel{
	/**-- 主键ID --**/
	private String uuid;
	/**-- 词组名称 --**/
	private String name;
	/**-- 词组内容 --**/
	private String content;
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
	
}