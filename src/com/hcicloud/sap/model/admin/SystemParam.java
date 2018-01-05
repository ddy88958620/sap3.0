package com.hcicloud.sap.model.admin;

/**
 * 系统参数管理
 * @author panxudong
 *
 */
public class SystemParam{
	/**
	 * 主键
	 */
	private String uuid;
	/**
	 * 参数名称
	 */
	private String name;
	/**
	 * 备注
	 */
	private String remark;
	/**
	 * 参数值
	 */
	private String value;
	/**
	 * 参数类型
	 * 0为asr引擎参数，1为CTI接口参数，2为质检引擎参数，4为搜索引擎参数，5为其他参数
	 */
	private int type;
	/**
	 * 参数值正则校验
	 */
	private String regexp;
	/**
	 * 正则校验错误提示
	 */
	private String errorMsg;
	
	
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
	 * 获取value
	 * @return the value
	 */
	public String getValue() {
		return value;
	}
	/**
	 * 设置value
	 * @param value the value to set
	 */
	public void setValue(String value) {
		this.value = value;
	}
	/**
	 * 获取type
	 * @return the type
	 */
	public int getType() {
		return type;
	}
	/**
	 * 设置type
	 * @param type the type to set
	 */
	public void setType(int type) {
		this.type = type;
	}
	
	public String getRegexp() {
		return regexp;
	}
	public void setRegexp(String regexp) {
		this.regexp = regexp;
	}
	public String getErrorMsg() {
		return errorMsg;
	}
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
}
