package com.hcicloud.sap.service.quality;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.hcicloud.sap.common.utils.Combobox;
import com.hcicloud.sap.common.utils.ExcelHelp;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.common.utils.PropertiesLoader;
import com.hcicloud.sap.common.utils.SystemParamUtil;
import com.hcicloud.sap.dao.BaseDaoI;
import com.hcicloud.sap.model.admin.User;
import com.hcicloud.sap.model.quality.AutoLexicon;
import com.hcicloud.sap.model.quality.AutoLogic;
import com.hcicloud.sap.model.quality.AutoPhrase;
import com.hcicloud.sap.model.quality.AutoRule;
import com.hcicloud.sap.model.quality.AutoRules;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.base.SessionInfo;
import com.hcicloud.sap.pagemodel.quality.AutoLexiconModel;
import com.hcicloud.sap.pagemodel.quality.AutoLogicModal;
import com.hcicloud.sap.pagemodel.quality.AutoPhraseModel;
import com.hcicloud.sap.pagemodel.quality.AutoRuleModel;
import com.sinovoice.hcicloud.analyze.TextAnalyze;
import com.sinovoice.hcicloud.common.HttpHead;
import com.sinovoice.hcicloud.common.MD5;
import com.sinovoice.hcicloud.model.ResourceResp;

/**
 * @author wangya
 *
 */
@Service
public class AutoRuleServiceImpl implements AutoRuleServiceI{
	@Autowired
	private BaseDaoI<AutoRule> autoRuleDao;
	@Autowired
	private BaseDaoI<AutoRules> autoRulesDao;
	@Autowired
	private BaseDaoI<AutoLexicon> autoLexiconDao;
	@Autowired
	private BaseDaoI<User> userDao;
	@Autowired
	private BaseDaoI<AutoPhrase> autoPhraseDao;
	@Autowired
	private BaseDaoI<AutoLogic> autoLogicDao;
	/**
	 * 获取自动质检规则数据列表
	 * @return
	 */
	@Override
	public List<AutoRuleModel> dataGrid(AutoRuleModel autoRuleModel, PageFilter page) {
		List<AutoRuleModel> modelList = new ArrayList<AutoRuleModel>();
		String hql = "from AutoRule a where 1=1 ";
		Map<String,Object> paramMap = new HashMap<String,Object>();
		if(autoRuleModel.getName()!=null&&!"".equals(autoRuleModel.getName())){
			hql += " and a.name like :name";
			paramMap.put("name", "%"+autoRuleModel.getName() + "%");
		}
		if(autoRuleModel.getAutoRulesId()!=null&&!"".equals(autoRuleModel.getAutoRulesId())){
			hql += " and a.autoRules.uuid = :uuid";
			paramMap.put("uuid", autoRuleModel.getAutoRulesId());
		}
		List<AutoRule> dataList = autoRuleDao.find(hql,paramMap,page.getiDisplayStart(), page.getiDisplayLength());
		copy(modelList,dataList);
		return modelList;
	}
	
	/**
	 * 对象实体列表转换为分页模型列表
	 * @param modelList
	 * @param dataList
	 */
	private void copy(List<AutoRuleModel> modelList,
			List<AutoRule> dataList) {
		AutoRuleModel autoRuleModel = null;
		
		for(AutoRule autoRule : dataList) {
			autoRuleModel = new AutoRuleModel();
			transform(autoRule, autoRuleModel);
			modelList.add(autoRuleModel);
		}
		
	}

	/**
	 * 通过ID获取实例
	 * @param uuid
	 * @return
	 */
	@Override
	public AutoRuleModel get(String uuid) {
		AutoRule autoRule = this.autoRuleDao.get(AutoRule.class, uuid);
		AutoRuleModel autoRuleModel = new AutoRuleModel();
		transform(autoRule, autoRuleModel);
		return autoRuleModel;
	}
	
	/**
	 * 将实体对象转换为分页模型
	 * @param autoRule
	 * @param autoRuleModel
	 */
	private void transform(AutoRule autoRule, AutoRuleModel autoRuleModel) {
		/**-- 拷贝bean内容 --**/
		BeanUtils.copyProperties(autoRule, autoRuleModel);
		
		if(autoRule.getUpdateUser() != null) {
			autoRuleModel.setUpdateById(autoRule.getUpdateUser().getUuid());
			autoRuleModel.setUpdateByName(autoRule.getUpdateUser().getName());
		}
		
		if(autoRule.getAutoRules() !=null){
			autoRuleModel.setAutoRulesId(autoRule.getAutoRules().getUuid());
			autoRuleModel.setAutoRulesName(autoRule.getAutoRules().getName());
		}
	}

	/**
	 * 获取规则总数
	 * @param autoRuleModel
	 * @return
	 */
	@Override
	public long count(AutoRuleModel autoRuleModel) {
		List<AutoRuleModel> modelList = new ArrayList<AutoRuleModel>();
		String hql = "select count(*) from AutoRule a where 1=1 ";
		Map<String,Object> paramMap = new HashMap<String,Object>();
		if(autoRuleModel.getName()!=null&&!"".equals(autoRuleModel.getName())){
			hql += " and a.name like :name";
			paramMap.put("name", autoRuleModel.getName() + "%");
		}
		if(autoRuleModel.getAutoRulesId()!=null&&!"".equals(autoRuleModel.getAutoRulesId())){
			hql += " and a.autoRules.uuid = :uuid";
			paramMap.put("uuid", autoRuleModel.getAutoRulesId());
		}
		Long count = autoRuleDao.count(hql, paramMap);
		return count;
	}

	/**
	 * 添加自动质检规则
	 * @param json
	 * @param sessionInfo
	 */
	@Override
	public boolean add(String json, SessionInfo sessionInfo) {
		JSONObject jsonObject = JSONObject.fromObject(json);
		/** -- 拼装自动质检规则对象 -- **/
		AutoRule autoRule = null;
		if(jsonObject.containsKey("uuid")){
			autoRule = this.autoRuleDao.get(AutoRule.class, getValueFromJson(jsonObject,"uuid"));
		}else{
			autoRule = new AutoRule();
		}
		autoRule.setName(getValueFromJson(jsonObject,"name"));
		autoRule.setState(Integer.valueOf(getValueFromJson(jsonObject,"state")));
		autoRule.setRemark(getValueFromJson(jsonObject,"remark"));
		autoRule.setScript(getValueFromJson(jsonObject,"script"));
		
		AutoRules autoRules = new AutoRules();
		autoRules.setUuid(getValueFromJson(jsonObject,"autoRulesId"));
		autoRule.setAutoRules(autoRules);
		/**-- 拼接内容文本 --**/
		String content = spiltContent(jsonObject);
	

		autoRule.setContent(content);
		autoRule.setUpdateTime(new Date());
		autoRule.setUpdateUser(this.userDao.get(User.class, sessionInfo.getUuid()));
		this.autoRuleDao.saveOrUpdate(autoRule);
		
		/**-- 获取词组和短语的列表 --**/
		JSONArray lexiconArray = JSONArray.fromObject(jsonObject.getString("lexiconList"));
		JSONArray phraseArray = JSONArray.fromObject(jsonObject.getString("phraseList"));
		JSONArray logicArray = JSONArray.fromObject(jsonObject.getString("logicList"));
		/** -- 封装词组 -- */

		AutoLexicon autoLexicon = null;
		for(int i=0; i<lexiconArray.size();i++) {
			jsonObject = lexiconArray.getJSONObject(i);
			if(jsonObject.containsKey("uuid")){
				autoLexicon = this.autoLexiconDao.get(AutoLexicon.class, getValueFromJson(jsonObject, "uuid"));
				String autoRuleID=autoLexicon.getAutoRule().getUuid();
				String hql = " from AutoLexicon a where a.autoRule.uuid=:uuid";
				Map<String,Object> paramMap = new HashMap<String, Object>();
				paramMap.put("uuid", autoRuleID);
				List<AutoLexicon> autoLexiconList = this.autoLexiconDao.find(hql, paramMap);
				for(int j=0;j<autoLexiconList.size();j++){
					this.autoLexiconDao.delete(autoLexiconList.get(j));
				}
				break;
			}
		}
		for(int i=0; i<lexiconArray.size();i++) {
			jsonObject = lexiconArray.getJSONObject(i);
			autoLexicon = new AutoLexicon();

			autoLexicon.setName(getValueFromJson(jsonObject, "name"));
			autoLexicon.setContent(getValueFromJson(jsonObject, "content"));
			autoLexicon.setAutoRule(autoRule);
			this.autoLexiconDao.saveOrUpdate(autoLexicon);
		}
		
		/** -- 封装短语 -- */
		List<AutoPhrase> phraseList = new ArrayList<AutoPhrase>();
		AutoPhrase autophrase = null;
		for(int i=0; i<phraseArray.size();i++) {
			jsonObject = phraseArray.getJSONObject(i);
			if(jsonObject.containsKey("uuid")){
				autophrase = this.autoPhraseDao.get(AutoPhrase.class, getValueFromJson(jsonObject, "uuid"));
				String autoRuleID=autophrase.getAutoRule().getUuid();
				String hql = " from AutoPhrase a where a.autoRule.uuid=:uuid";
				Map<String,Object> paramMap = new HashMap<String, Object>();
				paramMap.put("uuid", autoRuleID);
				List<AutoPhrase> autoPhraseList = this.autoPhraseDao.find(hql, paramMap);
				for(int j=0;j<autoPhraseList.size();j++){
					this.autoPhraseDao.delete(autoPhraseList.get(j));
				}
				break;
			}
		}
		for(int i=0; i<phraseArray.size();i++) {
			jsonObject = phraseArray.getJSONObject(i);
				autophrase = new AutoPhrase();
			autophrase.setName(getValueFromJson(jsonObject, "name"));
			autophrase.setContent(getValueFromJson(jsonObject, "content"));
			autophrase.setAutoRule(autoRule);
			this.autoPhraseDao.saveOrUpdate(autophrase);
			phraseList.add(autophrase);
			}
		/** -- 保存短语 -- */
		//this.autoPhraseDao.saveList(phraseList);
		/** -- 封装逻辑 -- */
		AutoLogic autoLogic = null;
		for(int i=0; i<logicArray.size();i++) {
			jsonObject = logicArray.getJSONObject(i);
			if(jsonObject.containsKey("uuid")){
				autoLogic = this.autoLogicDao.get(AutoLogic.class, getValueFromJson(jsonObject, "uuid"));
				String autoRuleID=autoLogic.getAutoRule().getUuid();
				String hql = " from AutoLogic a where a.autoRule.uuid=:uuid";
				Map<String,Object> paramMap = new HashMap<String, Object>();
				paramMap.put("uuid", autoRuleID);
				List<AutoLogic> autoLogicList = this.autoLogicDao.find(hql, paramMap);
				for(int j=0;j<autoLogicList.size();j++){
					this.autoLogicDao.delete(autoLogicList.get(j));
				}
				break;
			}
		}
		for(int i=0; i<logicArray.size();i++) {
			jsonObject = logicArray.getJSONObject(i);
				autoLogic = new AutoLogic();
			autoLogic.setContent(getValueFromJson(jsonObject, "content"));
			autoLogic.setAutoRule(autoRule);
			this.autoLogicDao.saveOrUpdate(autoLogic);
		}
		System.out.println("content :"+content);
		ResourceResp res=addResource(autoRule.getUuid(),content);
		
		  if(res==null){
				System.out.println("TA加载资源为空--------");
				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				return false;
			}else{
				if("0".equals(res.getErrorCode())){
					System.out.println("加载资源成功");
					return true;
				}else{
					TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
					return false;
				}
			}
	}
	
	
	@Override
	public boolean quickAdd(String queryAutoRulesId, String ruleName,
			String ruleContent, SessionInfo sessionInfo) {
		boolean flag = false;
		if(StringUtils.isBlank(ruleName) || StringUtils.isBlank(ruleContent)){
			return flag;
		}
		
		User user = this.userDao.get(User.class, sessionInfo.getUuid());
		
		AutoRules autoRules = new AutoRules();
		autoRules.setUuid(queryAutoRulesId);

		String[] ruleNames = ruleName.split("☆");
		
		
		
		String[] ruleContents = ruleContent.split("☆");
		for(int i=0;i<ruleNames.length;i++){
			AutoRule autoRule = new AutoRule();
			//添加数据
			String uuid = UUID.randomUUID().toString().replace("-", "");
					
			autoRule.setUuid(uuid);
			autoRule.setName(ruleNames[i]);
			autoRule.setContent(ruleContents[i]);
			autoRule.setState(1);
			autoRule.setUpdateTime(new Date());
			autoRule.setUpdateUser(user);
			autoRule.setAutoRules(autoRules);
			
			ResourceResp res=quickAddResourceResp(autoRule.getUuid(),ruleContents[i]);
			
			  if(res==null){
					System.out.println("TA加载资源为空--------");
					TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
					return false;
				}else{
					if("0".equals(res.getErrorCode())){
						System.out.println("加载资源成功");
						autoRuleDao.save(autoRule);
						return true;
					}else{
						TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
						return false;
					}
				}
		}
		return flag;
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
	 * 拼接规则内容字符串
	 * @param jsonObject
	 * @return
	 */
	private String spiltContent(JSONObject jsonObject){
		JSONArray lexiconArray = JSONArray.fromObject(jsonObject.getString("lexiconList"));
		JSONArray phraseArray = JSONArray.fromObject(jsonObject.getString("phraseList"));
		JSONArray logicArray = JSONArray.fromObject(jsonObject.getString("logicList"));
		StringBuilder contentBuilder = new StringBuilder();
		JSONObject lexiconObject = new JSONObject();
		JSONObject praseObject = new JSONObject();
		JSONObject logicObject=new JSONObject();
		String content = "";
		
		//拼接规则名称
		contentBuilder.append("{\"pattern_")
						.append(getValueFromJson(jsonObject, "name"))
						.append("\":{");
		
		//循环拼接词组
		for(int i=0;i<lexiconArray.size();i++){
			lexiconObject = lexiconArray.getJSONObject(i);
			contentBuilder.append("\"lexicon_")
							.append(getValueFromJson(lexiconObject, "name"))
							.append("\":[");
			String[] contentArray = getValueFromJson(lexiconObject, "content").split(",");
			for(int j=0;j<contentArray.length;j++){
				contentBuilder.append("\"")
								.append(contentArray[j])
								.append("\",");
			}
			contentBuilder.setLength(contentBuilder.length()-1);
			contentBuilder.append("],");
		}
		
		//循环拼接短语
		for(int i=0;i<phraseArray.size();i++){
			praseObject = phraseArray.getJSONObject(i);
			contentBuilder.append("\"phrase_")
							.append(getValueFromJson(praseObject, "name"))
							.append("\":[");
			String autoPhrase=getValueFromJson(praseObject, "content");
			String[]phraseArr=autoPhrase.split(",");
			for(int j=0;j<phraseArr.length;j++){
				if(j<phraseArr.length-1){
					contentBuilder.append("\"");
					contentBuilder.append(phraseArr[j]);
					contentBuilder.append("\"");
					contentBuilder.append(",");
				}else{
					contentBuilder.append("\"");
					contentBuilder.append(phraseArr[j]);
					contentBuilder.append("\"");
				}
	
		}

			contentBuilder.append("],");
		}
		
		//拼接逻辑
		contentBuilder.append("\"script\":[");
		for(int i=0;i<logicArray.size();i++){
			logicObject = logicArray.getJSONObject(i);
			String autoLogic=getValueFromJson(logicObject, "content");
			String[]logicArr=autoLogic.split(",");
			for(int j=0;j<logicArr.length;j++){
					contentBuilder.append("\"");
					contentBuilder.append(logicArr[j]);
					contentBuilder.append("\"");
					contentBuilder.append(",");
			}


		}
		contentBuilder.setLength(contentBuilder.length()-1);
		contentBuilder.append("]}}");
		/*contentBuilder.append("\"script\":[\"")
						.append(getValueFromJson(jsonObject, "script"))
						.append("\"]}");*/
		
		content=contentBuilder.toString();
		return content;
	}

	/**
	 * 获取编辑的信息
	 * @param uuid
	 * @return
	 */
	@Override
	public Json getFormInfo(String uuid) {
		Json json = new Json();
		JSONObject jsonObject = new JSONObject();
		if(uuid != null && !"".equals(uuid)) {
			AutoRuleModel autoRuleModel = this.get(uuid);
			JSONObject autoRuleJsonObject = JSONObject.fromObject(autoRuleModel);
			jsonObject.put("rules", autoRuleJsonObject);
		}
		String hql="select a.uuid,a.name,a.content from AutoLexicon a where a.flag=1";
		List<AutoLexicon> autoCommonLexiconList = this.autoLexiconDao.find(hql);
		jsonObject.put("commonLexiconList", autoCommonLexiconList);
		jsonObject.put("lexiconList", this.getLexiconById(uuid));
		jsonObject.put("phraseList", this.getPhraseById(uuid));
		jsonObject.put("logicList", this.getLogicById(uuid));
		json.setSuccess(true);
		json.setObj(jsonObject);
		return json;
	}
	
	/**
	 * 根据规则Id找到词组
	 * @param uuid
	 * @return
	 */
	private List<AutoLexiconModel> getLexiconById(String uuid){
		if(uuid==null||"".equals(uuid)){
			return new ArrayList<AutoLexiconModel>();
		}
		String hql = " from AutoLexicon a where a.autoRule.uuid=:uuid";
		Map<String,Object> paramMap = new HashMap<String, Object>();
		paramMap.put("uuid", uuid);
		List<AutoLexicon> autoLexiconList = this.autoLexiconDao.find(hql, paramMap);
		List<AutoLexiconModel> autoLexiconModelList = new ArrayList<AutoLexiconModel>();
		AutoLexiconModel autoLexiconModel = null ;
		
		for(AutoLexicon autoLexicon : autoLexiconList){
			autoLexiconModel = new AutoLexiconModel();
			BeanUtils.copyProperties(autoLexicon, autoLexiconModel);
			if(autoLexiconModel.getUpdateTime()==null){
				autoLexiconModel.setUpdateTime(new Date());
			}
			autoLexiconModelList.add(autoLexiconModel);
		}
		return autoLexiconModelList;
	}
	
	/**
	 * 根据规则Id找到短语
	 * @param uuid
	 * @return
	 */
	private List<AutoPhraseModel> getPhraseById(String uuid){
		if(uuid==null||"".equals(uuid)){
			return new ArrayList<AutoPhraseModel>();
		}
		String hql = " from AutoPhrase a where a.autoRule.uuid=:uuid";
		Map<String,Object> paramMap = new HashMap<String, Object>();
		paramMap.put("uuid", uuid);
		List<AutoPhrase> autoPhraseList = this.autoPhraseDao.find(hql, paramMap);
		List<AutoPhraseModel> autoPhraseModelList = new ArrayList<AutoPhraseModel>();
		AutoPhraseModel autoPhraseModel = null ;
		
		for(AutoPhrase autoPhrase : autoPhraseList){
			autoPhraseModel = new AutoPhraseModel();
			BeanUtils.copyProperties(autoPhrase, autoPhraseModel);
			autoPhraseModelList.add(autoPhraseModel);
		}
		return autoPhraseModelList;
	}
	/**
	 * 根据规则Id找到逻辑
	 * @param uuid
	 * @return
	 */
	private List<AutoLogicModal> getLogicById(String uuid){
		if(uuid==null||"".equals(uuid)){
			return new ArrayList<AutoLogicModal>();
		}
		String hql = " from AutoLogic a where a.autoRule.uuid=:uuid";
		Map<String,Object> paramMap = new HashMap<String, Object>();
		paramMap.put("uuid", uuid);
		List<AutoLogic> autoLogicList = this.autoLogicDao.find(hql, paramMap);
		List<AutoLogicModal> AutoLogicModalList = new ArrayList<AutoLogicModal>();
		AutoLogicModal autoLogicModal = null ;
		
		for(AutoLogic autoLogic : autoLogicList){
			autoLogicModal = new AutoLogicModal();
			BeanUtils.copyProperties(autoLogic, autoLogicModal);
			AutoLogicModalList.add(autoLogicModal);
		}
		return AutoLogicModalList;
	}
	/**
	 * 加载自动质检规则集列表
	 * @return
	 */
	@Override
	public Json getAutoRules() {
		Json json = new Json();
		List<Combobox> comList = loadAutoRulesInfo();
		if(comList!=null&&comList.size()>0){
			json.setSuccess(true);
			json.setObj(comList);
		}else{
			json.setSuccess(false);
		}
		return json;
	}

	/**
	 * 加载规则集下拉列表
	 * @return
	 */
	private List<Combobox> loadAutoRulesInfo() {
		List<Combobox> autoRulesComList = new ArrayList<Combobox>();
		List<AutoRules> autoRulesList = this.autoRulesDao.find("from AutoRules a ");
		Combobox combobox = null ;
		for(AutoRules autoRules :autoRulesList){
			combobox = new Combobox();
			combobox.setId(autoRules.getUuid());
			combobox.setText(autoRules.getName());
			autoRulesComList.add(combobox);
		}
		return autoRulesComList;
	}

	/**
	 * 根据uuid删除规则
	 * @param uuid
	 */
	@Override
	public boolean delete(String uuid) {
		AutoRule autoRule = this.autoRuleDao.get(AutoRule.class, uuid);
		/*ResourceResp res=delResource(uuid);
		  if(res==null){
				System.out.println("TA加载资源为空--------");
				return false;
			}else{
				if("0".equals(res.getErrorCode())){
					System.out.println("删除资源成功");
				
				}else if("9".equals(res.getErrorCode())){
					System.out.println("资源ID不存在");
				}
				else{
					return false;
				}
			}*/
		this.autoRuleDao.delete(autoRule);
		return true;
	}
/*	//同步规则
	public	boolean synchronizedRule(){
		boolean flag=true;
		String hql="from AutoRule ar";
		List<AutoRule>list=this.autoRuleDao.find(hql);
			for(int i=0;i<list.size();i++){
				AutoRule autoRule=list.get(i);
				String resourceId=autoRule.getUuid();
				String content=autoRule.getContent();
				ResourceResp res=addResource(resourceId,content);
			   if(res==null){
					flag=false;
					System.out.println("TA加载资源为空--------");
				}
				if(!("0".equals(res.getErrorCode()))){
					flag=false;
				}
			}
			return flag;
	}*/
	//资源传入TA
	private  static ResourceResp addResource(String resourceId,String json){
	/*	PropertiesLoader propertiesLoader = new PropertiesLoader("system.properties");
		String appKey = propertiesLoader.getProperty("appKey");
		String add_resource = propertiesLoader.getProperty("add_resource");
		String sdkVersion = propertiesLoader.getProperty("sdkVersion");
		String developKey = propertiesLoader.getProperty("developKey");
		String capkey= propertiesLoader.getProperty("capkey");
		String property = propertiesLoader.getProperty("property");
		String udid = propertiesLoader.getProperty("udid");*/
		String appKey = SystemParamUtil.getValueByName("appkey");
		String add_resource = SystemParamUtil.getValueByName("add_resource");
		String sdkVersion = SystemParamUtil.getValueByName("sdkVersion");
		String developKey = SystemParamUtil.getValueByName("developKey");
		String  capkey=SystemParamUtil.getValueByName("capkey_aer");
		String property = SystemParamUtil.getValueByName("property");
		TextAnalyze ta = new TextAnalyze();
		HttpHead httpHead = new HttpHead();
		httpHead.setAppkey(appKey);
		httpHead.setUrl(add_resource);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		httpHead.setRequestDate(sdf.format(new Date()));
		httpHead.setSdkVersion(sdkVersion);
		developKey = MD5.getMD5Code(sdf.format(new Date())+developKey);
		httpHead.setSessionKey(developKey);
		httpHead.setUdid("101:1234567890");
		Map<String,String> taskConfig = new HashMap<String, String>();
		taskConfig.put("resourceid", resourceId);
		taskConfig.put("capkey", capkey);
		taskConfig.put("property", property);
		httpHead.setTaskConfig(taskConfig);
		ResourceResp res = ta.addResource(httpHead, json);
		if(res!=null){
			System.out.println(res.getErrorCode());
		}

		return res;
	}
	
	private static ResourceResp quickAddResourceResp(String uuid,String content){
		String taUrl = SystemParamUtil.getValueByName("add_resource");
		String sdkVersion = SystemParamUtil.getValueByName("sdkVersion");
		String developKey = SystemParamUtil.getValueByName("developKey");
		String appkey = SystemParamUtil.getValueByName("appkey");
		TextAnalyze ta = new TextAnalyze();
		HttpHead httpHead = new HttpHead();
		httpHead.setAppkey(appkey);
		httpHead.setUrl(taUrl);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		httpHead.setRequestDate(sdf.format(new Date()));
		httpHead.setSdkVersion(sdkVersion);
		developKey = MD5.getMD5Code(sdf.format(new Date())+developKey);
		httpHead.setSessionKey(developKey);
		
		httpHead.setUdid("101:1234567890");
		Map<String,String> taskConfig = new HashMap<String, String>();
		taskConfig.put("resourceid", uuid);
		taskConfig.put("capkey", "ta.cloud.sync");
		taskConfig.put("engkey", "ta.cloud.aer");
		taskConfig.put("property", "cn_common");
		httpHead.setTaskConfig(taskConfig);
		ResourceResp res = ta.addResource(httpHead, content);
		if(res!=null){
			System.out.println(res.getErrorCode());
		}
		return res;
	}
	
	//删除TA资源
	private  static ResourceResp delResource(String resourceId){
	/*	PropertiesLoader propertiesLoader = new PropertiesLoader("system.properties");
		String appKey = propertiesLoader.getProperty("appKey");
		String add_resource = propertiesLoader.getProperty("del_resource");
		String sdkVersion = propertiesLoader.getProperty("sdkVersion");
		String developKey = propertiesLoader.getProperty("developKey");
		String capkey= propertiesLoader.getProperty("capkey");
		String property = propertiesLoader.getProperty("property");
		String udid = propertiesLoader.getProperty("udid");*/

		String appKey = SystemParamUtil.getValueByName("appkey");
		String del_resource = SystemParamUtil.getValueByName("del_resource");
		String sdkVersion = SystemParamUtil.getValueByName("sdkVersion");
		String developKey = SystemParamUtil.getValueByName("developKey");
		String  capkey=SystemParamUtil.getValueByName("capkey_aer");
		String property = SystemParamUtil.getValueByName("property");
		TextAnalyze ta = new TextAnalyze();
		HttpHead httpHead = new HttpHead();
		httpHead.setAppkey(appKey);
		httpHead.setUrl(del_resource);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd 24hh:mm:ss");
		httpHead.setRequestDate(sdf.format(new Date()));
		httpHead.setSdkVersion(sdkVersion);
		developKey = MD5.getMD5Code(sdf.format(new Date())+developKey);
		httpHead.setSessionKey(developKey);
		httpHead.setUdid("101:1234567890");
		Map<String,String> taskConfig = new HashMap<String, String>();
		taskConfig.put("resourceid", resourceId);
		taskConfig.put("capkey", capkey);
		taskConfig.put("property", property);
		httpHead.setTaskConfig(taskConfig);
		//ResourceResp res = ta.addResource(httpHead, json);
		ResourceResp res =ta.delResource(httpHead, "");
		if(res!=null){
			System.out.println(res.getErrorCode());
		}

		return res;
	}
/*public static void main(String[] args) throws Exception {
	String json="{\"pattern_寿险电销:理财\":{\"lexicon_转到\":[\"转到\",\"转给\",\"转账\"],\"lexicon_账户\":[\"账户\",\"人寿账户\",\"人寿的账户\",\"中国人寿的金账户\"],\"lexicon_只是\":[\"只是\",\"仅仅是\",\"仅是\"],\"lexicon_激活\":[\"激活\",\"确认\"],\"lexicon_钱\":[\"钱\",\"人民币\"],\"lexicon_放在\":[\"放在\",\"在\",\"存在\"],\"lexicon_您的\":[\"您的\",\"你的\",\"您\",\"你\",\"您自己的\",\"你自己\"],\"lexicon_相当于\":[\"相当于\",\"就像\",\"类似\",\"一个概念\",\"另一种方式\",\"一样\"],\"lexicon_理财\":[\"理财\",\"储蓄\",\"积累财富\",\"存款\",\"存钱\",\"攒钱\",\"零存整取\",\"定期存储\"],\"lexicon_避税\":[\"避税\",\"避债\",\"逃避债务\",\"逃税\"],\"lexicon_保险\":[\"保险\",\"险种\",\"寿险\",\"财险\"],\"lexicon_这个是\":[\"这个\",\"这个是\",\"这是\"],\"lexicon_卡里\":[\"卡里\",\"银行卡\",\"卡中\",\"账户\"],\"lexicon_淘宝\":[\"淘宝\"],\"lexicon_买东西\":[\"购物\",\"买东西\"],\"lexicon_打给\":[\"打给\",\"划给\",\"给\",\"才给\",\"才会给\",\"才打给\"],\"lexicon_打钱给\":[\"打钱给\"],\"lexicon_卖家\":[\"卖家\",\"店家\"],\"lexicon_治疗\":[\"治疗\"],\"lexicon_赠送\":[\"赠你的\",\"送你的\",\"免费给你的\",\"白给\",\"送给你的\",\"送您的\",\"赠送\",\"是送给您的\"],\"lexicon_不用\":[\"不用\",\"不要\",\"不需要\",\"没需要\",\"不是\"],\"lexicon_花钱\":[\"花钱\",\"掏钱\",\"花钱买\",\"购买\",\"支付\",\"付款\",\"付钱\",\"您自己出\",\"额外花钱去购买\"],\"lexicon_不花钱\":[\"不花钱\"],\"lexicon_买\":[\"买\",\"购买\"],\"lexicon_保监法\":[\"保监法\",\"保险法\",\"保监局\",\"保监会\",\"保监协会\"],\"lexicon_规定\":[\"规定\",\"特批\",\"特定\",\"批准\",\"批定\"],\"lexicon_特别推出\":[\"特别\",\"特别推出\",\"针对\",\"推出\"],\"lexicon_老客户\":[\"老客户\",\"您这样的\",\"这类人群\"],\"lexicon_电话\":[\"电话\"],\"lexicon_支付\":[\"支付\",\"付款\",\"付钱\",\"付费\",\"支付后\"],\"lexicon_保费\":[\"保费\",\"保险单\",\"保险费\"],\"lexicon_冻结\":[\"冻结\",\"进行冻结\"],\"lexicon_保单\":[\"保单\",\"保险单\",\"投保\"],\"lexicon_签收\":[\"签收\",\"签收后\",\"收到\",\"签收成功\",\"成功签收\",\"签收成功后\",\"收货\",\"确认收货\"],\"lexicon_扣款\":[\"扣除\",\"扣费\",\"扣钱\",\"扣款\",\"扣掉\",\"才会扣\",\"才扣\"],\"lexicon_第三方\":[\"第三方\"],\"lexicon_代管\":[\"代管\",\"代为管理\",\"代办\",\"管理\"],\"phrase_相当于理财\":[\"lexicon_相当于#lexicon_理财\",\"lexicon_这个是>lexicon_赠送\",\"lexicon_避税\",\"lexicon_不用>lexicon_花钱\",\"lexicon_不花钱\"],\"phrase_买保险\":[\"lexicon_买>lexicon_保险\"],\"phrase_治疗\":[\"lexicon_治疗\"],\"phrase_冒用保监会\":[\"lexicon_保监法#lexicon_规定\"],\"phrase_针对老客户推出\":[\"lexicon_特别推出#lexicon_老客户\"],\"phrase_电话支付\":[\"lexicon_电话#lexicon_支付\"],\"phrase_对保费进行冻结\":[\"lexicon_保费#lexicon_冻结\"],\"phrase_保单签收后\":[\"lexicon_保单#lexicon_签收\"],\"phrase_确认收货后\":[\"lexicon_签收\"],\"phrase_扣款\":[\"lexicon_扣款\"],\"phrase_保费由第三方代管\":[\"lexicon_保费#lexicon_第三方#lexicon_代管\"],\"phrase_转到人寿账户\":[\"lexicon_转到#lexicon_账户\"],\"phrase_激活保单\":[\"lexicon_激活#lexicon_保单\"],\"phrase_钱还在您卡里\":[\"lexicon_钱>lexicon_放在>lexicon_您的>lexicon_卡里\"],\"phrase_相当于淘宝\":[\"lexicon_相当于#lexicon_淘宝\",\"lexicon_淘宝#lexicon_买东西\"],\"phrase_钱打给卖家\":[\"lexicon_钱>lexicon_打给>lexicon_卖家\",\"lexicon_打钱给>lexicon_卖家\"],\"script\":[\"(phrase_相当于理财&!phrase_买保险)&!phrase_治疗\",\"phrase_冒用保监会\",\"phrase_针对老客户推出&!phrase_买保险\",\"[phrase_对保费进行冻结&phrase_保单签收后]{2}\",\"[phrase_保费由第三方代管]{2}\",\"[phrase_激活保单&phrase_保单签收后&phrase_扣款]\",\"phrase_钱还在您卡里&!phrase_转到人寿账户\",\"[phrase_相当于淘宝&phrase_确认收货后&phrase_钱打给卖家]\"]}}";  
	addResource("11111111",json);
}*/

}