package com.hcicloud.sap.service.quality;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hcicloud.sap.common.utils.Combobox;
import com.hcicloud.sap.dao.BaseDaoI;
import com.hcicloud.sap.model.admin.User;
import com.hcicloud.sap.model.admin.UserGroup;
import com.hcicloud.sap.model.quality.Rule;
import com.hcicloud.sap.model.quality.RuleType;
import com.hcicloud.sap.model.quality.Rules;
import com.hcicloud.sap.model.quality.RulesType;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.base.SessionInfo;
import com.hcicloud.sap.pagemodel.quality.RuleModel;
import com.hcicloud.sap.pagemodel.quality.RulesModel;


@Service
public class RulesServiceImpl implements RulesServiceI {

	@Autowired
	private BaseDaoI<User> userDao;
	
	@Autowired
	private BaseDaoI<UserGroup> userGroupDao;
	
	@Autowired
	private BaseDaoI<RuleType> ruleTypeDao;
	
	@Autowired
	private BaseDaoI<RulesType> rulesTypeDao;
	
	@Autowired
	private BaseDaoI<Rules> rulesDao;
	
	@Autowired
	private BaseDaoI<Rule> ruleDao;

	/**
	 * 获取分页列表
	 * @param rulesModel
	 * @param pageFilter
	 * @return
	 */
	@Override
	public List<RulesModel> dataGrid(RulesModel rulesModel, int rows, int page) {
		List<RulesModel> rulesModelList = new ArrayList<RulesModel>();
		
		String hql = "from Rules r where 1=1 ";
		Map<String, Object> params = new HashMap<String, Object>();
		
		hql += hqlJoin(rulesModel, params);
		
		List<Rules> rulesList = this.rulesDao.find(hql, params, (page-1)*rows,rows);

		copy(rulesList, rulesModelList);
		
		return rulesModelList;
	}
	
	/**
	 * 获取指定规则集下的规则
	 * @param uuid
	 * @return
	 */
	@Override
	public List<RuleModel> getRuleByRulesId(String uuid) {
		if(uuid == null || "".equals(uuid)) {
			return new ArrayList<RuleModel>();
		}

		String hql = "from Rule r join fetch r.ruleType where r.rules.uuid=:uuid";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("uuid", uuid);
		
		List<Rule> ruleList = this.ruleDao.find(hql, params);
		
		List<RuleModel> ruleModelList = new ArrayList<RuleModel>();
		RuleModel ruleModel = null;
		for(Rule rule : ruleList) {
			ruleModel = new RuleModel();
			
			BeanUtils.copyProperties(rule, ruleModel);
			if(rule.getRuleType()!=null) {
				ruleModel.setRuleTypeId(rule.getRuleType().getUuid());
				ruleModel.setRuleTypeName(rule.getRuleType().getName());
			}
			if(6 == rule.getRuleType().getValueType()) {
				ruleModel.setMinValue(ruleModel.getMinValue() / 60 / 1000);
				ruleModel.setMaxValue(ruleModel.getMaxValue() / 60 / 1000);
			}
			
			ruleModel.setRuleTypeType(rule.getRuleType().getValueType());
			
			ruleModelList.add(ruleModel);
		}
		
		return ruleModelList;
	}

	/**
	 * 通过ID获取实例
	 * @param uuid
	 * @return
	 */
	@Override
	public RulesModel get(String uuid) {
		Rules rules = this.rulesDao.get(Rules.class, uuid);

		RulesModel rulesModel = new RulesModel();
		
		Map<String, String> userGroupMap =  getUserGroupMap();
		
		transform(rules, rulesModel);
		fillUserGroupName(rules, rulesModel, userGroupMap);
		
		return rulesModel;
	}

	/**
	 * 统计数量
	 * @param rulesModel
	 * @return
	 */
	@Override
	public Long count(RulesModel rulesModel) {
		String hql = "select count(*) from Rules r where 1=1 ";
		Map<String, Object> params = new HashMap<String, Object>();
		
		hql += hqlJoin(rulesModel, params);
		
		Long count = this.rulesDao.count(hql, params);
		
		return count;
	}
	
	/**
	 * 获取规则集类型信息
	 * @return
	 */
	@Override
	public Json getRulesTypeInfo() {
		Json json = new Json();
		json.setSuccess(true);
		json.setObj(loadRulesTypeInfo());
		return json;
	}
	
	/**
	 * 获取表单相关信息
	 * @return
	 */
	@Override
	public Json getFormInfo(String uuid) {
		Json json = new Json();

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("rulesTypeList", loadRulesTypeInfo());
		jsonObject.put("ruleTypeList", loadRuleTypeInfo("quality"));
		jsonObject.put("userGroupList", loadUserGroupInfo());
		if(uuid != null && !"".equals(uuid)) {
			RulesModel rulesModel = this.get(uuid);
			JSONObject rulesJsonObject = JSONObject.fromObject(rulesModel);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			if(rulesModel.getStartTime() == null || "".equals(rulesModel.getStartTime())) {
				rulesJsonObject.remove("startTime");
			} else {
				rulesJsonObject.put("startTime", sdf.format(rulesModel.getStartTime()));
			}
			if(rulesModel.getEndTime() == null || "".equals(rulesModel.getEndTime())) {
				rulesJsonObject.remove("endTime");
			} else {
				rulesJsonObject.put("endTime", sdf.format(rulesModel.getEndTime()));
			}
			
			jsonObject.put("rules", rulesJsonObject);
			jsonObject.put("ruleList", this.getRuleByRulesId(uuid));
		}
		
		json.setSuccess(true);
		json.setObj(jsonObject);
		
		return json;
	}
	
	/**
	 * 新增规则集
	 * @param json
	 * @param sessionInfo
	 * @throws Exception 
	 */
	@Override
	public void add(String json, SessionInfo sessionInfo) throws Exception {
		JSONObject jsonObject = JSONObject.fromObject(json);

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		/** -- 封装rules -- */
		Rules rules = new Rules();
		rules.setName(getValueFromJson(jsonObject, "name"));
		rules.setRemark(getValueFromJson(jsonObject, "remark"));
		rules.setPreconditions(getValueFromJson(jsonObject, "preconditions"));
		
		String rulesTypeId = getValueFromJson(jsonObject, "rulesTypeId");
		if(rulesTypeId != null) {
			rules.setRulesType(this.rulesTypeDao.get(RulesType.class, getValueFromJson(jsonObject, "rulesTypeId")));
		} else {
			throw new Exception("规则集类型不能为空，请重新操作！");
		}
		String startTime = getValueFromJson(jsonObject, "startTime");
		if(startTime != null) {
			rules.setStartTime(sdf.parse(startTime));
		}
		String endTime = getValueFromJson(jsonObject, "endTime");
		if(endTime != null) {
			rules.setEndTime(sdf.parse(endTime));
		}
		rules.setUserGroupSet(getValueFromJson(jsonObject, "userGroupSet"));
		
		rules.setState(1);
		rules.setUpdateTime(new Date());
		rules.setUpdateUser(this.userDao.get(User.class, sessionInfo.getUuid()));
		
		/** -- 将同一规则集类别下的生效规则集置为失效 -- */
		String hql = "update Rules a set a.state=0 where a.rulesType.uuid=:uuid and a.state=1";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("uuid", rulesTypeId);
		//int count = this.rulesDao.executeHql(hql, params);
		this.rulesDao.executeHql(hql, params);
		
		/** -- 保存规则集 -- */
		this.rulesDao.save(rules);
		
		/** -- 封装规则类型 -- */
		Map<String, RuleType> map = new HashMap<String, RuleType>();
		List<RuleType> ruleTypeList = this.ruleTypeDao.find("from RuleType rt");
		for(RuleType ruleType : ruleTypeList) {
			map.put(ruleType.getUuid(), ruleType);
		}
		
		/** -- 封装规则 -- */
		List<Rule> ruleList = new ArrayList<Rule>();
		Rule rule = null;
		
		JSONArray jsonArray = JSONArray.fromObject(jsonObject.getString("ruleList"));
		String minValue = null, maxValue = null, resultType = null, ruleTypeId = null;
		
		for(int i=0; i<jsonArray.size();i++) {
			jsonObject = jsonArray.getJSONObject(i);
			
			rule = new Rule();
			rule.setName(getValueFromJson(jsonObject, "name"));
			rule.setEqualValue(getValueFromJson(jsonObject, "equalValue"));
			rule.setRules(rules);
			
			maxValue = getValueFromJson(jsonObject, "maxValue");
			if(maxValue != null) {
				rule.setMaxValue(Float.valueOf(maxValue));
			}
			minValue = getValueFromJson(jsonObject, "minValue");
			if(minValue != null) {
				rule.setMinValue(Float.valueOf(minValue));
			}
			resultType = getValueFromJson(jsonObject, "resultType");
			if(resultType != null) {
				rule.setResultType(Integer.parseInt(resultType));
			} else {
				throw new Exception("规则结果类型信息缺失，请重新操作！");
			}
			ruleTypeId = getValueFromJson(jsonObject, "ruleTypeId");
			if(ruleTypeId != null) {
				rule.setRuleType(map.get(ruleTypeId));
			} else {
				throw new Exception("规则类型信息缺失，请重新操作！");
			}
			
			ruleList.add(rule);
		}

		/** -- 保存规则 -- */
		this.ruleDao.saveList(ruleList);
	}
	
	/**
	 * 根据key获取Json字符串中的value
	 * @param jsonObject
	 * @param key
	 * @return
	 */
	private String getValueFromJson(JSONObject jsonObject, String key) {
		if(jsonObject.getString(key) != null && !"".equals(jsonObject.getString(key))
				&& !"null".equals(jsonObject.getString(key))) {
			return jsonObject.getString(key);
		}
		return null;
	}

	/**
	 * hql语句拼接
	 * @param rulesModel
	 * @param params
	 * @return
	 */
	private String hqlJoin(RulesModel rulesModel, Map<String, Object> params) {
		String hql = "";
		
		if(rulesModel.getName() != null && !"".equals(rulesModel.getName())) {
			hql += " and r.name like :name";
			params.put("name", "%" + rulesModel.getName() + "%");
		}
		
		if(rulesModel.getRulesTypeId() != null && !"".equals(rulesModel.getRulesTypeId())) {
			hql += " and r.rulesType.uuid=:rulesTypeId";
			params.put("rulesTypeId", rulesModel.getRulesTypeId());
		}
		
		hql += " order by r.updateTime desc";
		
		return hql;
	}
	
	/**
	 * 加载规则集类型相关信息
	 * @return
	 */
	private List<Combobox> loadRulesTypeInfo() {
		List<Combobox> rulesTypeComboboxList = new ArrayList<Combobox>();
		
		List<RulesType> rulesTypeList = this.rulesTypeDao.find("from RulesType rt");
		
		Combobox combobox = null;
		for(RulesType rulesType : rulesTypeList) {
			combobox = new Combobox();
			combobox.setId(rulesType.getUuid());
			combobox.setText(rulesType.getName());
			
			rulesTypeComboboxList.add(combobox);
		}
		
		return rulesTypeComboboxList;
	}
	
	/**
	 * 加载规则类型相关信息
	 * @return
	 */
	@Override
	public List<Map<String, String>> loadRuleTypeInfo(String type) {
		List<Map<String, String>> ruleTypeMapList = new ArrayList<Map<String,String>>();
		
		String hql = "from RuleType rt";
		/*if("search".equals(type)) {
			hql += " where rt.isSearch='1'";
		} else if("quality".equals(type)) {
			hql += " where rt.isQuality='1'";
		}*/
		List<RuleType> ruleTypeList = this.ruleTypeDao.find(hql);
		
		Map<String, String> map = null;
		for(RuleType ruleType : ruleTypeList) {
			map = new HashMap<String, String>();
			map.put("id", ruleType.getUuid());
			map.put("text", ruleType.getName());
			map.put("code", ruleType.getCode());
			map.put("numberType", String.valueOf(ruleType.getNumberType()));
			map.put("minValue", String.valueOf(ruleType.getMinValue()));
			map.put("maxValue", String.valueOf(ruleType.getMaxValue()));
			map.put("type", String.valueOf(ruleType.getValueType()));
			
			if(ruleType.getEnumValue() != null && !"".equals(ruleType.getEnumValue())) {
				map.put("value", ruleType.getEnumValue());
			} else {
				map.put("value", "");
			}
			
			ruleTypeMapList.add(map);
		}
		
		return ruleTypeMapList;
	}
	
	/**
	 * 加载用户组相关信息
	 * @return
	 */
	private List<Combobox> loadUserGroupInfo() {
		List<Combobox> userGroupComboboxList = new ArrayList<Combobox>();
		
		List<UserGroup> userGroupList = this.userGroupDao.find("from UserGroup ug where 1=1 and ug.uuid<>'0' ");
		
		Combobox combobox = null;
		for(UserGroup userGroup : userGroupList) {
			combobox = new Combobox();
			combobox.setId(userGroup.getUuid());
			combobox.setText(userGroup.getName());
			
			userGroupComboboxList.add(combobox);
		}
		
		return userGroupComboboxList;
	}
	
	/**
	 * rulesList转换为rulesModelList
	 * @param rulesList
	 * @param rulesModelList
	 */
	private void copy(List<Rules> rulesList,
			List<RulesModel> rulesModelList) {
		RulesModel rulesModel = null;
		
		Map<String, String> userGroupMap = getUserGroupMap();
		
		for(Rules rules : rulesList) {
			rulesModel = new RulesModel();
			
			transform(rules, rulesModel);
			fillUserGroupName(rules, rulesModel, userGroupMap);
			
			rulesModelList.add(rulesModel);
		}
	}
	
	/**
	 * 填充rules中的生效用户组名称集合
	 * @param rules
	 * @param rulesModel
	 * @param userGroupMap
	 */
	private void fillUserGroupName(Rules rules, RulesModel rulesModel, 
			Map<String,String> userGroupMap){
		if(rules.getUserGroupSet() == null || "".equals(rules.getUserGroupSet())) {
			return;
		}
		
		StringBuffer sbf = new StringBuffer();
		
		String[] userGroupIdArray = rules.getUserGroupSet().split(",");
		int flag = 0;
		for(String key : userGroupIdArray) {
			if(userGroupMap.get(key) != null && !"".equals(userGroupMap.get(key))) {
				sbf.append(userGroupMap.get(key));
			}
			if(flag != userGroupIdArray.length - 1) {
				sbf.append("  ");
			}
			flag ++;
		}
		
		rulesModel.setUserGroupNameSet(sbf.toString());
	}
	
	/**
	 * rules转换为rulesModel
	 * @param rules
	 * @param rulesModel
	 */
	private void transform(Rules rules, RulesModel rulesModel) {
		BeanUtils.copyProperties(rules, rulesModel);
		
		if(rules.getUpdateUser() != null) {
			rulesModel.setUpdateById(rules.getUpdateUser().getUuid());
			rulesModel.setUpdateByName(rules.getUpdateUser().getName());
		}
		
		if(rules.getRulesType() != null) {
			rulesModel.setRulesTypeId(rules.getRulesType().getUuid());
			rulesModel.setRulesTypeName(rules.getRulesType().getName());
		}
	}
	
	private Map<String, String> getUserGroupMap() {
		List<UserGroup> userGroupList = this.userGroupDao.find("from UserGroup ug");
		Map<String, String> userGroupMap = new HashMap<String, String>();
		for(UserGroup ug : userGroupList) {
			userGroupMap.put(ug.getUuid(), ug.getName());
		}
		
		return userGroupMap;
	}
}