package com.hcicloud.sap.service.quality;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.dao.BaseDaoI;
import com.hcicloud.sap.model.admin.User;
import com.hcicloud.sap.model.quality.RuleType;
import com.hcicloud.sap.pagemodel.quality.RuleTypeModel;

@Service
public class RuleTypeServiceImpl implements RuleTypeServiceI {
	
	@Autowired
	private BaseDaoI<User> userDao;
	
	@Autowired
	private BaseDaoI<RuleType> ruleTypeDao;

	/**
	 * 获取分页列表
	 * @param ruleTypeModel
	 * @param pageFilter
	 * @return
	 */
	@Override
	public List<RuleTypeModel> dataGrid(RuleTypeModel ruleTypeModel,
			PageFilter pageFilter) {
		List<RuleTypeModel> ruleTypeModelList = new ArrayList<RuleTypeModel>();
		
		String hql = "from RuleType rt where 1=1 ";
		Map<String, Object> params = new HashMap<String, Object>();
		
		hql += hqlJoin(ruleTypeModel, params);
		
		List<RuleType> ruleTypeList = this.ruleTypeDao.find(hql, params, 
				pageFilter.getiDisplayStart(), pageFilter.getiDisplayLength());

		copy(ruleTypeList, ruleTypeModelList);
		
		return ruleTypeModelList;
	}

	/**
	 * 通过ID获取实例
	 * @param uuid
	 * @return
	 */
	@Override
	public RuleTypeModel get(String uuid) {
		RuleType ruleType = this.ruleTypeDao.get(RuleType.class, uuid);

		RuleTypeModel ruleTypeModel = new RuleTypeModel();
		BeanUtils.copyProperties(ruleType, ruleTypeModel);
		if (ruleType.getUpdateUser()!= null) {
			ruleTypeModel.setUpdateById(ruleType.getUpdateUser().getUuid());
			ruleTypeModel.setUpdateByName(ruleType.getUpdateUser().getName());
		}
		
		return ruleTypeModel;
	}

	/**
	 * 规则类型名判重
	 * @param name
	 * @return
	 */
	@Override
	public Boolean isRepeat(String name, String uuid, Boolean flag) {
		String hql = "select count(*) from RuleType rt where rt.name=:name";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("name", name);
		
		if(flag) {
			hql += " and rt.uuid!=:uuid";
			params.put("uuid", uuid);
		}
		
		Long count = this.ruleTypeDao.count(hql, params);
		if(count <= 0) {
			return false;
		} else {
			return true;
		}
	}

	/**
	 * 统计数量
	 * @param ruleTypeModel
	 * @param pageFilter
	 * @return
	 */
	@Override
	public Long count(RuleTypeModel ruleTypeModel, PageFilter pageFilter) {
		String hql = "select count(*) from RuleType rt where 1=1 ";
		Map<String, Object> params = new HashMap<String, Object>();
		
		hql += hqlJoin(ruleTypeModel, params);
		
		Long count = this.ruleTypeDao.count(hql, params);
		
		return count;
	}

	/**
	 * 新增规则集类型
	 * @param ruleTypeModel
	 */
	@Override
	public void add(RuleTypeModel ruleTypeModel) {
		RuleType ruleType = new RuleType();

		BeanUtils.copyProperties(ruleTypeModel, ruleType);
		ruleType.setUpdateTime(new Date());
		ruleType.setUpdateUser(this.userDao.get(User.class, ruleTypeModel.getUpdateById()));
		
		this.ruleTypeDao.save(ruleType);
	}

	/**
	 * 更新规则集类型
	 * @param ruleTypeModel
	 */
	@Override
	public void update(RuleTypeModel ruleTypeModel) {
		RuleType ruleType = new RuleType();

		BeanUtils.copyProperties(ruleTypeModel, ruleType);
		ruleType.setUpdateTime(new Date());
		ruleType.setUpdateUser(this.userDao.get(User.class, ruleTypeModel.getUpdateById()));
		
		this.ruleTypeDao.update(ruleType);
	}


	private String hqlJoin(RuleTypeModel ruleTypeModel, Map<String, Object> params) {
		String hql = "";
		
		if(ruleTypeModel.getName() != null && !"".equals(ruleTypeModel.getName())) {
			hql += " and rt.name like :name";
			params.put("name", "%" + ruleTypeModel.getName() + "%");
		}
		
		return hql;
	}
	
	/**
	 * 复制属性
	 * @param ruleTypeList
	 * @param ruleTypeModelList
	 */
	private void copy(List<RuleType> ruleTypeList,
			List<RuleTypeModel> ruleTypeModelList) {
		RuleTypeModel ruleTypeModel = null;
		
		for(RuleType ruleType : ruleTypeList) {
			ruleTypeModel = new RuleTypeModel();
			
			BeanUtils.copyProperties(ruleType, ruleTypeModel);
			if(ruleType.getUpdateUser() != null) {
				ruleTypeModel.setUpdateById(ruleType.getUpdateUser().getUuid());
				ruleTypeModel.setUpdateByName(ruleType.getUpdateUser().getName());
			}
			
			ruleTypeModelList.add(ruleTypeModel);
		}
	}
}
