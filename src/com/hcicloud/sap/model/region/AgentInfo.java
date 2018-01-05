package com.hcicloud.sap.model.region;

/**
 * @Title: AgentInfo.java
 * @Package com.hcicloud.sap.model.region
 * @Description: 区拓产品需上报坐席表实体
 * @author wudong
 * @date 2015年8月14日 上午10:28:05
 */
public class AgentInfo {

	/**
	 * 主键
	 */
	private String id;
	
	/**
	 * 坐席工号
	 */
	private String agentId;
	
	/**
	 * 所属平台
	 */
	private String  platForm;
	
	/**
	 * 呼叫电话
	 */
	private String  callPhone;

	

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	

	public String getAgentId() {
		return agentId;
	}

	public void setAgentId(String agentId) {
		this.agentId = agentId;
	}

	public String getPlatForm() {
		return platForm;
	}

	public void setPlatForm(String platForm) {
		this.platForm = platForm;
	}

	public String getCallPhone() {
		return callPhone;
	}

	public void setCallPhone(String callPhone) {
		this.callPhone = callPhone;
	}
	
}
