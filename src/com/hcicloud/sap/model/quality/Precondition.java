package com.hcicloud.sap.model.quality;

import java.util.Date;

import com.hcicloud.sap.model.admin.User;

/**
 * 用户
 * @author lixianji
 *
 */
public class Precondition{
	/**
	 * 主键
	 */
	private String uuid;
	/**
	 * 名称
	 */
	private String name;
	/**
	 * 最大值
	 */
	private float maxValue;
	/**
     * 最小值
     */
    private float minValue;
    /**
     * 精确值
     */
    private String equalValue;
    /**
     * 预置条件类型
     */
    private PreconditionType preconditionType;
    /**
     * 规则集
     */
    private Rules rules;
    /**
     * 规则
     */
    private Rule rule;
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
     * 获取maxValue  
     * @return the maxValue
     */
    public float getMaxValue() {
        return maxValue;
    }
    /**
     * 设置maxValue  
     * @param maxValue the maxValue to set
     */
    public void setMaxValue(float maxValue) {
        this.maxValue = maxValue;
    }
    /**
     * 获取minValue  
     * @return the minValue
     */
    public float getMinValue() {
        return minValue;
    }
    /**
     * 设置minValue  
     * @param minValue the minValue to set
     */
    public void setMinValue(float minValue) {
        this.minValue = minValue;
    }
    /**
     * 获取equalValue  
     * @return the equalValue
     */
    public String getEqualValue() {
        return equalValue;
    }
    /**
     * 设置equalValue  
     * @param equalValue the equalValue to set
     */
    public void setEqualValue(String equalValue) {
        this.equalValue = equalValue;
    }
    /**
     * 获取preconditionType  
     * @return the preconditionType
     */
    public PreconditionType getPreconditionType() {
        return preconditionType;
    }
    /**
     * 设置preconditionType  
     * @param preconditionType the preconditionType to set
     */
    public void setPreconditionType(PreconditionType preconditionType) {
        this.preconditionType = preconditionType;
    }
    /**
     * 获取rules  
     * @return the rules
     */
    public Rules getRules() {
        return rules;
    }
    /**
     * 设置rules  
     * @param rules the rules to set
     */
    public void setRules(Rules rules) {
        this.rules = rules;
    }
    /**
     * 获取rule  
     * @return the rule
     */
    public Rule getRule() {
        return rule;
    }
    /**
     * 设置rule  
     * @param rule the rule to set
     */
    public void setRule(Rule rule) {
        this.rule = rule;
    }
	
	
}
