package com.hcicloud.sap.model.quality;

import java.util.Date;

/**
 * 
 * 人工质检条款
 *
 */
public class ArtificalItem{
	/**
	 * 主键
	 */
	private String uuid;
	/**
	 * 人工质检项名称
	 */
	private String name;
	
	/**
	 * 人工质检项内容
	 */
	private String content;
	/**
	 * 得分
	 */
	private String score;
	
	/**
	 * 得分类型
	 */
	private String type;
	/**
	 * 创建时间
	 */
	private Date createTime;
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
    
}
