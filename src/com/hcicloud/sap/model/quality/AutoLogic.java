package com.hcicloud.sap.model.quality;

/**
 * 自动质检规则逻辑
 * @author wangya
 *
 */
public class AutoLogic {
	/**-- 主键ID --**/
	private String uuid;
	/**-- 内容 --**/
	private String content;
	/**-- 关联的自动质检规则 --**/
	private AutoRule autoRule;
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public AutoRule getAutoRule() {
		return autoRule;
	}
	public void setAutoRule(AutoRule autoRule) {
		this.autoRule = autoRule;
	}
}
