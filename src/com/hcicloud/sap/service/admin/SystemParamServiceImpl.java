package com.hcicloud.sap.service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.dao.BaseDaoI;
import com.hcicloud.sap.model.admin.SystemParam;

@Service
public class SystemParamServiceImpl implements SystemParamServiceI {

	@Autowired
	private BaseDaoI<SystemParam> systemParamDao;

	/**
	 * 获取分页列表
	 * @param systemParam
	 * @param pageFilter
	 * @return
	 */
	@Override
	public List<SystemParam> dataGrid(SystemParam systemParam, PageFilter pageFilter) {
		String hql = "from SystemParam sp where 1=1 ";
		Map<String, Object> params = new HashMap<String, Object>();
		
		hql += hqlJoin(systemParam, params);
		
		List<SystemParam> systemParamList = this.systemParamDao.find(hql, params, 
				pageFilter.getiDisplayStart(), pageFilter.getiDisplayLength());

		return systemParamList;
	}
	
	/**
	 * 通过ID获取实例
	 * @param uuid
	 * @return
	 */
	@Override
	public SystemParam get(String uuid) {
		return this.systemParamDao.get(SystemParam.class, uuid);
	}

	/**
	 * 系统参数名称判重
	 * @param name
	 * @return
	 */
	@Override
	public Boolean isRepeat(String name, String uuid, Boolean flag) {
		String hql = "select count(*) from SystemParam sp where sp.name=:name";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("name", name);
		
		if(flag) {
			hql += " and sp.uuid!=:uuid";
			params.put("uuid", uuid);
		}
		
		Long count = this.systemParamDao.count(hql, params);
		if(count <= 0) {
			return false;
		} else {
			return true;
		}
	}

	/**
	 * 统计数量
	 * @param systemParam
	 * @param pageFilter
	 * @return
	 */
	@Override
	public Long count(SystemParam systemParam, PageFilter pageFilter) {
		String hql = "select count(*) from SystemParam sp where 1=1 ";
		Map<String, Object> params = new HashMap<String, Object>();
		
		hql += hqlJoin(systemParam, params);
		
		Long count = this.systemParamDao.count(hql, params);
		
		return count;
	}

	/**
	 * 新增系统参数
	 * @param systemParam
	 */
	@Override
	public void add(SystemParam systemParam) {
		this.systemParamDao.save(systemParam);
	}

	/**
	 * 编辑系统参数
	 * @param systemParam
	 */
	@Override
	public void update(SystemParam systemParam) {
		this.systemParamDao.update(systemParam);
	}
	
	/**
	 * hql语句拼接
	 * @param systemParam
	 * @param params
	 * @return
	 */
	private String hqlJoin(SystemParam systemParam, Map<String, Object> params) {
		String hql = "";
		
		if(systemParam.getName() != null && !"".equals(systemParam.getName())) {
			hql += " and sp.name like :name";
			params.put("name", "%" + systemParam.getName() + "%");
		}
		
		return hql;
	}
	
	@Override
	public String getParamSystemByName(String name) {
		String hqlString=" from SystemParam where name='"+name+"'";
		List<SystemParam> paramSystemList = systemParamDao.find(hqlString);
		if(paramSystemList!=null&&paramSystemList.size()>0){
			return paramSystemList.get(0).getValue();
		}
		return null;
	}
}