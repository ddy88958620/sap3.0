package com.hcicloud.sap.pagemodel.quality;


public class RuleModel {
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
	 * 规则集Id
	 */
	private String rulesId;
	/**
	 * 规则集名称
	 */
	private String rulesName;
	/**
	 * 规则类型Id
	 */
	private String ruleTypeId;
	/**
	 * 规则类型名称
	 */
	private String ruleTypeName;
	/**
	 * 结果类型
	 */
	private Integer resultType;
	/**
	 * 预置条件
	 */
	private String preconditions;
	/**
	 * 规则类型类型
	 */
	private int ruleTypeType;
	
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
	 * 获取rulesId
	 * @return the rulesId
	 */
	public String getRulesId() {
		return rulesId;
	}
	/**
	 * 设置rulesId
	 * @param rulesId the rulesId to set
	 */
	public void setRulesId(String rulesId) {
		this.rulesId = rulesId;
	}
	/**
	 * 获取rulesName
	 * @return the rulesName
	 */
	public String getRulesName() {
		return rulesName;
	}
	/**
	 * 设置rulesName
	 * @param rulesName the rulesName to set
	 */
	public void setRulesName(String rulesName) {
		this.rulesName = rulesName;
	}
	/**
	 * 获取ruleTypeId
	 * @return the ruleTypeId
	 */
	public String getRuleTypeId() {
		return ruleTypeId;
	}
	/**
	 * 设置ruleTypeId
	 * @param ruleTypeId the ruleTypeId to set
	 */
	public void setRuleTypeId(String ruleTypeId) {
		this.ruleTypeId = ruleTypeId;
	}
	/**
	 * 获取ruleTypeName
	 * @return the ruleTypeName
	 */
	public String getRuleTypeName() {
		return ruleTypeName;
	}
	/**
	 * 设置ruleTypeName
	 * @param ruleTypeName the ruleTypeName to set
	 */
	public void setRuleTypeName(String ruleTypeName) {
		this.ruleTypeName = ruleTypeName;
	}
	/**
     * 获取resultType  
     * @return the resultType
     */
    public Integer getResultType() {
        return resultType;
    }
    /**
     * 设置resultType  
     * @param resultType the resultType to set
     */
    public void setResultType(Integer resultType) {
        this.resultType = resultType;
    }
    /**
     * 获取preconditions  
     * @return the preconditions
     */
    public String getPreconditions() {
        return preconditions;
    }
    /**
     * 设置preconditions  
     * @param preconditions the preconditions to set
     */
    public void setPreconditions(String preconditions) {
        this.preconditions = preconditions;
    }
	/**
	 * 获取ruleTypeType
	 * @return the ruleTypeType
	 */
	public int getRuleTypeType() {
		return ruleTypeType;
	}
	/**
	 * 设置ruleTypeType
	 * @param ruleTypeType the ruleTypeType to set
	 */
	public void setRuleTypeType(int ruleTypeType) {
		this.ruleTypeType = ruleTypeType;
	}
}
