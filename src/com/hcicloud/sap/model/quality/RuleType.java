package com.hcicloud.sap.model.quality;

import java.util.Date;

import com.hcicloud.sap.model.admin.User;

/**
 * 用户
 * @author lixianji
 *
 */
public class RuleType{
	/**
	 * 主键
	 */
	private String uuid;
	/**
	 * 名称
	 */
	private String name;
	/**
	 * 宏命令
	 */
	private String code;
	/**
	 * 更新时间
	 */
	private Date updateTime;
	/**
	 * 更新人
	 */
	private User updateUser;
	/**
	 * 枚举类型取值
	 */
	private String enumValue;
	/**
	 * 取值类型
	 */
	private int valueType;
	/**
	 * 最小值
	 */
	private Long minValue;
	/**
	 * 最大值
	 */
	private Long maxValue;
	/**
	 * 数值类型
	 */
	private Integer numberType;
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
     * 获取code  
     * @return the code
     */
    public String getCode() {
        return code;
    }
    /**
     * 设置code  
     * @param code the code to set
     */
    public void setCode(String code) {
        this.code = code;
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
     * 获取updateUser  
     * @return the updateUser
     */
    public User getUpdateUser() {
        return updateUser;
    }
    /**
     * 设置updateUser  
     * @param updateUser the updateUser to set
     */
    public void setUpdateUser(User updateUser) {
        this.updateUser = updateUser;
    }
    /**
     * 获取enumValue  
     * @return the enumValue
     */
    public String getEnumValue() {
        return enumValue;
    }
    /**
     * 设置enumValue  
     * @param enumValue the enumValue to set
     */
    public void setEnumValue(String enumValue) {
        this.enumValue = enumValue;
    }
    /**
     * 获取valueType  
     * @return the valueType
     */
    public int getValueType() {
        return valueType;
    }
    /**
     * 设置valueType  
     * @param valueType the valueType to set
     */
    public void setValueType(int valueType) {
        this.valueType = valueType;
    }
    /**
     * 获取minValue
     * @return the minValue
     */
    public Long getMinValue() {
        return minValue;
    }
    /**
     * 设置minValue
     * @param minValue the minValue to set
     */
    public void setMinValue(Long minValue) {
        this.minValue = minValue;
    }
    /**
     * 获取maxValue
     * @return the maxValue
     */
    public Long getMaxValue() {
        return maxValue;
    }
    /**
     * 设置maxValue
     * @param maxValue the maxValue to set
     */
    public void setMaxValue(Long maxValue) {
        this.maxValue = maxValue;
    }
    /**
     * 获取numberType
     * @return the numberType
     */
    public Integer getNumberType() {
        return numberType;
    }
    /**
     * 设置numberType
     * @param numberType the numberType to set
     */
    public void setNumberType(Integer numberType) {
        this.numberType = numberType;
    }
	
}
