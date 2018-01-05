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
import com.hcicloud.sap.model.quality.Rules;
import com.hcicloud.sap.model.quality.RulesType;
import com.hcicloud.sap.pagemodel.quality.RulesTypeModel;

@Service
public class RulesTypeServiceImpl implements RulesTypeServiceI {
	
	@Autowired
	private BaseDaoI<User> userDao;
	
	@Autowired
	private BaseDaoI<Rules> rulesDao;
	
	@Autowired
	private BaseDaoI<RulesType> rulesTypeDao;

	/**
	 * 获取分页列表
	 * @param rulesTypeModel
	 * @param pageFilter
	 * @return
	 */
	@Override
	public List<RulesTypeModel> dataGrid(RulesTypeModel rulesTypeModel,
			PageFilter pageFilter) {
		List<RulesTypeModel> rulesTypeModelList = new ArrayList<RulesTypeModel>();
		
		String hql = "from RulesType rt where 1=1 ";
		Map<String, Object> params = new HashMap<String, Object>();
		
		hql += hqlJoin(rulesTypeModel, params);
		
		List<RulesType> rulesTypeList = this.rulesTypeDao.find(hql, params, 
				pageFilter.getiDisplayStart(), pageFilter.getiDisplayLength());

		copy(rulesTypeList, rulesTypeModelList);
		
		return rulesTypeModelList;
	}

	/**
	 * 通过ID获取实例
	 * @param uuid
	 * @return
	 */
	@Override
	public RulesTypeModel get(String uuid) {
		RulesType rulesType = this.rulesTypeDao.get(RulesType.class, uuid);

		RulesTypeModel rulesTypeModel = new RulesTypeModel();
		BeanUtils.copyProperties(rulesType, rulesTypeModel);
		if (rulesType.getUpdateUser()!= null) {
			rulesTypeModel.setUpdateById(rulesType.getUpdateUser().getUuid());
			rulesTypeModel.setUpdateByName(rulesType.getUpdateUser().getName());
		}
		
		return rulesTypeModel;
	}

	/**
	 * 规则集类型名判重
	 * @param name
	 * @return
	 */
	@Override
	public Boolean isRepeat(String name, String uuid, Boolean flag) {
		String hql = "select count(*) from RulesType rt where rt.name=:name";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("name", name);
		
		if(flag) {
			hql += " and rt.uuid!=:uuid";
			params.put("uuid", uuid);
		}
		
		Long count = this.rulesTypeDao.count(hql, params);
		if(count <= 0) {
			return false;
		} else {
			return true;
		}
	}

	/**
	 * 统计数量
	 * @param rulesTypeModel
	 * @param pageFilter
	 * @return
	 */
	@Override
	public Long count(RulesTypeModel rulesTypeModel, PageFilter pageFilter) {
		String hql = "select count(*) from RulesType rt where 1=1 ";
		Map<String, Object> params = new HashMap<String, Object>();
		
		hql += hqlJoin(rulesTypeModel, params);
		
		Long count = this.rulesTypeDao.count(hql, params);
		
		return count;
	}

	/**
	 * 新增规则集类型
	 * @param rulesTypeModel
	 */
	@Override
	public void add(RulesTypeModel rulesTypeModel) {
		RulesType rulesType = new RulesType();

		BeanUtils.copyProperties(rulesTypeModel, rulesType);
		rulesType.setUpdateTime(new Date());
		rulesType.setUpdateUser(this.userDao.get(User.class, rulesTypeModel.getUpdateById()));
		
		this.rulesTypeDao.save(rulesType);
	}

	/**
	 * 更新规则集类型
	 * @param rulesTypeModel
	 */
	@Override
	public void update(RulesTypeModel rulesTypeModel) {
		RulesType rulesType = new RulesType();

		BeanUtils.copyProperties(rulesTypeModel, rulesType);
		rulesType.setUpdateTime(new Date());
		rulesType.setUpdateUser(this.userDao.get(User.class, rulesTypeModel.getUpdateById()));
		
		this.rulesTypeDao.update(rulesType);
	}

	/**
	 * 删除规则集类型
	 * @param uuid
	 * @throws Exception
	 */
	@Override
	public void delete(String uuid) throws Exception {
		String hql = "select count(*) from Rules r where r.rulesType.uuid=:uuid";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("uuid", uuid);
		Long count = this.rulesTypeDao.count(hql, params);
		
		if(count > 0) {
			throw new Exception("存在级联信息");
		}
		RulesType rulesType = this.rulesTypeDao.get(RulesType.class, uuid);
		this.rulesTypeDao.delete(rulesType);
	}

	/**
	 * hql语句拼接
	 * @param rulesTypeModel
	 * @param params
	 * @return
	 */
	private String hqlJoin(RulesTypeModel rulesTypeModel, Map<String, Object> params) {
		String hql = "";
		
		if(rulesTypeModel.getName() != null && !"".equals(rulesTypeModel.getName())) {
			hql += " and rt.name like :name";
			params.put("name", "%" + rulesTypeModel.getName() + "%");
		}
		
		return hql;
	}
	
	/**
	 * rulesTypeList转换为rulesTypeModelList
	 * @param rulesTypeList
	 * @param rulesTypeModelList
	 */
	private void copy(List<RulesType> rulesTypeList,
			List<RulesTypeModel> rulesTypeModelList) {
		RulesTypeModel rulesTypeModel = null;
		
		for(RulesType rulesType : rulesTypeList) {
			rulesTypeModel = new RulesTypeModel();
			
			BeanUtils.copyProperties(rulesType, rulesTypeModel);
			if(rulesType.getUpdateUser() != null) {
				rulesTypeModel.setUpdateById(rulesType.getUpdateUser().getUuid());
				rulesTypeModel.setUpdateByName(rulesType.getUpdateUser().getName());
			}
			
			rulesTypeModelList.add(rulesTypeModel);
		}
	}
}
