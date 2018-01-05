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
import com.hcicloud.sap.model.quality.AutoRules;
import com.hcicloud.sap.pagemodel.quality.AutoRulesModel;

/**
 * @author wangya
 *
 */
@Service
public class AutoRulesServiceImpl implements AutoRulesServiceI{
	@Autowired
	private BaseDaoI<AutoRules> autoRulesDao;
	@Autowired
	private BaseDaoI<User> userDao;

	/**
	 * 获取自动质检规则数据列表
	 * @return
	 */
	@Override
	public List<AutoRulesModel> dataGrid(AutoRulesModel autoRulesModel, PageFilter page) {
		List<AutoRulesModel> modelList = new ArrayList<AutoRulesModel>();
		String hql = "from AutoRules a";
		Map<String,Object> paramMap = new HashMap<String,Object>();
		if(autoRulesModel.getName()!=null&&!"".equals(autoRulesModel.getName())){
			hql += "";
			hql += " where a.name like :name";
			paramMap.put("name", autoRulesModel.getName() + "%");
		}
		hql+=" order by a.updateTime desc";
		List<AutoRules> dataList = autoRulesDao.find(hql,paramMap,page.getiDisplayStart(), page.getiDisplayLength());
		copy(modelList,dataList);
		return modelList;
	}
	
	/**
	 * 对象实体列表转换为分页模型列表
	 * @param modelList
	 * @param dataList
	 */
	private void copy(List<AutoRulesModel> modelList,
			List<AutoRules> dataList) {
		AutoRulesModel autoRolesModel = null;
		
		for(AutoRules autoRules : dataList) {
			autoRolesModel = new AutoRulesModel();
			transform(autoRules, autoRolesModel);
			modelList.add(autoRolesModel);
		}
		
	}
	
	/**
	 * 将实体对象转换为分页模型
	 * @param autoRules
	 * @param autoRolesModel
	 */
	private void transform(AutoRules autoRules, AutoRulesModel autoRolesModel) {
		/**-- 拷贝bean内容 --**/
		BeanUtils.copyProperties(autoRules, autoRolesModel);
		
		if(autoRules.getUpdateUser() != null) {
			if(autoRules.getUpdateUser()!=null){
				if(autoRules.getUpdateUser().getUuid()==null){
					autoRolesModel.setUpdateById("");
				}else{
					autoRolesModel.setUpdateById(autoRules.getUpdateUser().getUuid());
				}
				if(autoRules.getUpdateUser().getName()==null){
					autoRolesModel.setUpdateByName("");
				}else{
					autoRolesModel.setUpdateByName(autoRules.getUpdateUser().getName());
				}
			}else{
				autoRolesModel.setUpdateById("");
				autoRolesModel.setUpdateByName("");

			}
		}
	}

	/**
	 * 统计数量
	 * @param rulesTypeModel
	 * @param pageFilter
	 * @return
	 */
	@Override
	public long count(AutoRulesModel autoRulesModel, PageFilter pageFilter) {
		String hql = "select count(*) from AutoRules a where 1=1 ";
		Map<String, Object> params = new HashMap<String, Object>();
		
		hql += hqlJoin(autoRulesModel, params);
		
		Long count = this.autoRulesDao.count(hql, params);
		
		return count;
	}
	
	/**
	 * hql语句拼接
	 * @param rulesTypeModel
	 * @param params
	 * @return
	 */
	private String hqlJoin(AutoRulesModel autoRulesModel, Map<String, Object> params) {
		String hql = "";
		
		if(autoRulesModel.getName() != null && !"".equals(autoRulesModel.getName())) {
			hql += " and a.name like :name";
			params.put("name", autoRulesModel.getName() + "%");
		}
		
		return hql;
	}

	/**
	 * 通过ID获取规则集实例
	 * @param uuid
	 * @return
	 */
	@Override
	public AutoRulesModel get(String uuid) {
		AutoRules autoRules = this.autoRulesDao.get(AutoRules.class, uuid);

		AutoRulesModel autoRulesModel = new AutoRulesModel();
		BeanUtils.copyProperties(autoRules, autoRulesModel);
		if (autoRules.getUpdateUser()!= null) {
			autoRulesModel.setUpdateById(autoRules.getUpdateUser().getUuid());
			autoRulesModel.setUpdateByName(autoRules.getUpdateUser().getName());
		}
		return autoRulesModel;
	}

	/**
	 * 规则集名判重
	 * @param name
	 * @return
	 */
	@Override
	public Boolean isRepeat(String name, String uuid, Boolean flag) {
		String hql = "select count(*) from AutoRules a where a.name=:name";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("name", name);
		
		if(flag) {
			hql += " and a.uuid!=:uuid";
			params.put("uuid", uuid);
		}
		
		Long count = this.autoRulesDao.count(hql, params);
		if(count <= 0) {
			return false;
		} else {
			return true;
		}
	}

	/**
	 * 新增规则集
	 * @param autoRulesModel
	 */
	@Override
	public void add(AutoRulesModel autoRulesModel) {
		AutoRules autoRules = new AutoRules();

		BeanUtils.copyProperties(autoRulesModel, autoRules);
		autoRules.setUpdateTime(new Date());
		autoRules.setUpdateUser(this.userDao.get(User.class, autoRulesModel.getUpdateById()));
		
		this.autoRulesDao.save(autoRules);
	}

	/**
	 * 更新规则集
	 * @param autoRulesModel
	 */
	@Override
	public void update(AutoRulesModel autoRulesModel) {
		AutoRules autoRules = new AutoRules();

		BeanUtils.copyProperties(autoRulesModel, autoRules);
		autoRules.setUpdateTime(new Date());
		autoRules.setUpdateUser(this.userDao.get(User.class, autoRulesModel.getUpdateById()));
		
		this.autoRulesDao.update(autoRules);
	}

	/**
	 * 删除规则集
	 * @param uuid
	 * @throws Exception
	 */
	@Override
	public void delete(String uuid) throws Exception {
		String hql = "select count(*) from AutoRule r where r.autoRules.uuid=:uuid";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("uuid", uuid);
		Long count = this.autoRulesDao.count(hql, params);
		
		if(count > 0) {
			throw new Exception("存在级联信息");
		}
		AutoRules autoRules = this.autoRulesDao.get(AutoRules.class, uuid);
		this.autoRulesDao.delete(autoRules);
	}
	
}