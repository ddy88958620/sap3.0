package com.hcicloud.sap.service.region;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.dao.BaseDaoI;
import com.hcicloud.sap.model.region.AgentInfo;
import com.hcicloud.sap.service.region.impl.AgentInfoService;

@Service
public class AgentInfoServiceImpl implements AgentInfoService{
	@Autowired
	private BaseDaoI<AgentInfo> agentInfoDao;

	
	@Override
	public  List<AgentInfo> agentInfoList() {
	   String hql ="from AgentInfo ai";
		
		List<AgentInfo> agentInfoList= agentInfoDao.find(hql);
		
		return agentInfoList;
	}


	@Override
	public boolean addAgentInfo(AgentInfo agentInfo) {
		try {
			agentInfoDao.save(agentInfo);
			return true;
		} catch (Exception e) {
			return false;
		}
		
		
	}


	@Override
	public boolean addAgentInfoList(List<AgentInfo> agentInfoList) {
		try {
			agentInfoDao.saveList(agentInfoList);
			return true;
		} catch (Exception e) {
			return false;
		}
		
	}

	/**
	 * 获取分页列表
	 * @param agentInfo
	 * @param pageFilter
	 * @return
	 */
	@Override
	public List<AgentInfo> dataGrid(AgentInfo agentInfo, PageFilter pageFilter) {
		
		String hql = "from AgentInfo ai where 1=1 ";
		Map<String, Object> params = new HashMap<String, Object>();
		
		if (agentInfo.getAgentId()!=null&&!"".equals(agentInfo.getAgentId())) {
			hql+=" and ai.agentId=:agentId";
			params.put("agentId", agentInfo.getAgentId());
		}
		if (agentInfo.getPlatForm()!=null&&!"".equals(agentInfo.getPlatForm())) {
			hql+=" and ai.platForm=:platForm";
			params.put("platForm",agentInfo.getPlatForm());
		}
		
		List<AgentInfo> agentInfoList = this.agentInfoDao.find(hql, params, pageFilter.getiDisplayStart(), pageFilter.getiDisplayLength());

		return agentInfoList;
		
	}
	
	@Override
	public Long count(AgentInfo agentInfo, PageFilter pageFilter) {
		
		String hql = "select count(*) from AgentInfo ai where 1=1 ";
		Map<String, Object> params = new HashMap<String, Object>();
		
		if (agentInfo.getAgentId()!=null&&!"".equals(agentInfo.getAgentId())) {
			hql+=" and ai.agentId=:agentId";
			params.put("agentId", agentInfo.getAgentId());
		}
		if (agentInfo.getPlatForm()!=null&&!"".equals(agentInfo.getPlatForm())) {
			hql+=" and ai.platForm=:platForm";
			params.put("platForm",agentInfo.getPlatForm());
		}
		Long count = this.agentInfoDao.count(hql, params);
		
		return count;
	}



	@Override
	public AgentInfo get(String id) {
		
		return this.agentInfoDao.get(AgentInfo.class, id);
	}


	/**
	 * 坐席ID判重
	 * @param name
	 * @return
	 */
	@Override
	public Boolean isRepeat(String agentId, String id, Boolean flag) {
		String hql = "select count(*) from AgentInfo ai where ai.agentId=:agentId";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("agentId", agentId);
		
		if(flag) {
			hql += " and ai.id!=:id";
			params.put("id", id);
		}
		
		Long count = this.agentInfoDao.count(hql, params);
		if(count <= 0) {
			return false;
		} else {
			return true;
		}
	}



	/**
	 * 添加坐席
	 * @param agentInfo
	 */

	@Override
	public void add(AgentInfo agentInfo) {
		
        this.agentInfoDao.save(agentInfo);
	}

	
	/**
	 * 修改坐席
	 * @param agentInfo
	 */

	@Override
	public void update(AgentInfo agentInfo) {
		this.agentInfoDao.update(agentInfo);
	}
	
	/**
	 * 删除坐席
	 * @param id
	 * @throws Exception
	 */
	@Override
	public void delete(String id) {
		String hql = "delete from AgentInfo ai where ai.id=:id";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		this.agentInfoDao.executeHql(hql, params);
	}
	
	
		
}
