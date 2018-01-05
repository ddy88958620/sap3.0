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
import com.hcicloud.sap.model.quality.AutoLexicon;
import com.hcicloud.sap.pagemodel.quality.AutoLexiconModel;
@Service
public class AutoLexiconServiceImpl implements AutoLexiconServiceI{
	@Autowired
	private BaseDaoI<AutoLexicon> autoLexiconDao;
	@Autowired
	private BaseDaoI<User> userDao;

	/**
	 * 获取自动质检规则数据列表
	 * @return
	 */
	@Override
	public List<AutoLexiconModel> dataGrid(AutoLexiconModel autoLexiconModel, PageFilter page) {
		List<AutoLexiconModel> modelList = new ArrayList<AutoLexiconModel>();
		String hql = "from AutoLexicon a where a.flag=1 ";
		Map<String,Object> paramMap = new HashMap<String,Object>();
		if(autoLexiconModel.getName()!=null&&!"".equals(autoLexiconModel.getName())){
			hql += "  and a.name like :name";
			paramMap.put("name", "%"+autoLexiconModel.getName() + "%");
		}
		hql+=" order by a.updateTime desc";
		List<AutoLexicon> dataList = autoLexiconDao.find(hql,paramMap);
		copy(modelList,dataList);
		return modelList;
	}
	/**
	 * 对象实体列表转换为分页模型列表
	 * @param modelList
	 * @param dataList
	 */
	private void copy(List<AutoLexiconModel> modelList,
			List<AutoLexicon> dataList) {
		AutoLexiconModel autoLexiconModel = null;
		
		for(AutoLexicon autoLexicon : dataList) {
			autoLexiconModel = new AutoLexiconModel();
			transform(autoLexicon, autoLexiconModel);
			modelList.add(autoLexiconModel);
		}
		
	}
	
	/**
	 * 将实体对象转换为分页模型
	 * @param autoLexicon
	 * @param autoRolesModel
	 */
	private void transform(AutoLexicon autoLexicon, AutoLexiconModel autoLexiconModel) {
		/**-- 拷贝bean内容 --**/
		BeanUtils.copyProperties(autoLexicon, autoLexiconModel);
		
		if(autoLexicon.getUpdateUser() != null) {
			autoLexiconModel.setUpdateUserId(autoLexicon.getUpdateUser().getUuid());
			autoLexiconModel.setUpdateUserName(autoLexicon.getUpdateUser().getName());
		}
	}
	/**
	 * 统计数量
	 * @param LexiconTypeModel
	 * @param pageFilter
	 * @return
	 */
	@Override
	public long count(AutoLexiconModel autoLexiconModel, PageFilter pageFilter) {
		String hql = "select count(*) from AutoLexicon a where 1=1 ";
		Map<String, Object> params = new HashMap<String, Object>();
		
		hql += hqlJoin(autoLexiconModel, params);
		
		Long count = this.autoLexiconDao.count(hql, params);
		
		return count;
	}
	
	/**
	 * hql语句拼接
	 * @param LexiconTypeModel
	 * @param params
	 * @return
	 */
	private String hqlJoin(AutoLexiconModel autoLexiconModel, Map<String, Object> params) {
		String hql = "";
		
		if(autoLexiconModel.getName() != null && !"".equals(autoLexiconModel.getName())) {
			hql += " and a.name like :name";
			params.put("name", "%"+autoLexiconModel.getName() + "%");
		}
		
		return hql;
	}

	/**
	 * 通过ID获取通用词组实例
	 * @param uuid
	 * @return
	 */
	@Override
	public AutoLexiconModel get(String uuid) {
		AutoLexicon autoLexicon = this.autoLexiconDao.get(AutoLexicon.class, uuid);

		AutoLexiconModel autoLexiconModel = new AutoLexiconModel();
		BeanUtils.copyProperties(autoLexicon, autoLexiconModel);
		if (autoLexicon.getUpdateUser()!= null) {
			autoLexiconModel.setUpdateUserId(autoLexicon.getUpdateUser().getUuid());
			autoLexiconModel.setUpdateUserName(autoLexicon.getUpdateUser().getName());
		}
		return autoLexiconModel;
	}
	/**
	 * 通用词组名判重
	 * @param name
	 * @return
	 */
	@Override
	public Boolean isRepeat(String name, String uuid, Boolean flag) {
		String hql = "select count(*) from AutoLexicon a where a.name=:name and a.flag=1";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("name", name);
		
		if(flag) {
			hql += " and a.uuid!=:uuid";
			params.put("uuid", uuid);
		}
		
		Long count = this.autoLexiconDao.count(hql, params);
		if(count <= 0) {
			return false;
		} else {
			return true;
		}
	}
	/**
	 * 新增通用词组
	 * @param autoLexiconModel
	 */
	@Override
	public void add(AutoLexiconModel autoLexiconModel) {
		AutoLexicon autoLexicon = new AutoLexicon();

		BeanUtils.copyProperties(autoLexiconModel, autoLexicon);
		autoLexicon.setUpdateTime(new Date());
		autoLexicon.setUpdateUser(this.userDao.get(User.class, autoLexiconModel.getUpdateUserId()));
		autoLexicon.setFlag(1);
		this.autoLexiconDao.save(autoLexicon);
	}

	/**
	 * 更新通用词组
	 * @param autoLexiconModel
	 */
	@Override
	public void update(AutoLexiconModel autoLexiconModel) {
		AutoLexicon autoLexicon = new AutoLexicon();

		BeanUtils.copyProperties(autoLexiconModel, autoLexicon);
		autoLexicon.setUpdateTime(new Date());
		autoLexicon.setUpdateUser(this.userDao.get(User.class, autoLexiconModel.getUpdateUserId()));
		autoLexicon.setFlag(1);
		this.autoLexiconDao.update(autoLexicon);
	}
	
	/**
	 * 删除通用词组
	 * @param uuid
	 * @throws Exception
	 */
	@Override
	public void delete(String uuid) throws Exception {
		AutoLexicon autoLexicon = this.autoLexiconDao.get(AutoLexicon.class, uuid);
		this.autoLexiconDao.delete(autoLexicon);
	}
	
	
}
