package com.hcicloud.sap.service.region.impl;

import java.util.List;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.model.admin.SystemParam;
import com.hcicloud.sap.model.region.AgentInfo;

public interface AgentInfoService {
	
	public List<AgentInfo> agentInfoList ();
	
	/**
	 * 添加坐席
	 */
	public boolean addAgentInfo(AgentInfo agentInfo);
	
	
	/**
	 * 批量添加坐席
	 */
	public boolean addAgentInfoList(List<AgentInfo> agentInfoList);
	
	
	
	
	public abstract List<AgentInfo> dataGrid(AgentInfo agentInfo, PageFilter pageFilter);
	
	public abstract AgentInfo get(String uuid);
	
	public abstract Boolean isRepeat(String name, String uuid, Boolean flag);
	
	public abstract Long count(AgentInfo agentInfo, PageFilter pageFilter);

	public abstract void add(AgentInfo agentInfo);
	
	public abstract void update(AgentInfo agentInfo);
	
	public abstract void delete(String id);

	//public abstract String getParamSystemByName(String name);

}
