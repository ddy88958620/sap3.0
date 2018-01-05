package com.hcicloud.sap.service.quality;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.utils.DateConversion;
import com.hcicloud.sap.common.utils.ErrorMsg;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.common.utils.SystemParamUtil;
import com.hcicloud.sap.dao.BaseDaoI;
import com.hcicloud.sap.model.admin.User;
import com.hcicloud.sap.model.quality.StandardSpeech;
import com.hcicloud.sap.pagemodel.base.SessionInfo;
import com.hcicloud.sap.pagemodel.quality.StandardSpeechModel;
import com.sinovoice.hcicloud.analyze.TextAnalyze;
import com.sinovoice.hcicloud.common.HttpHead;
import com.sinovoice.hcicloud.common.MD5;
import com.sinovoice.hcicloud.model.ResourceResp;

@Service
public class StandardSpeechImpl implements StandardSpeechI {
	
	@Autowired
	BaseDaoI<StandardSpeech> standardSpeechDao;
	@Autowired
	BaseDaoI<User> userDao;

	/**
	 * 获取标准话术集合
	 * @param standardSpeechModel
	 * @param pageFilter
	 * @return
	 */
	@Override
	public List<StandardSpeechModel> dataGrid(StandardSpeechModel standardSpeechModel, PageFilter pageFilter, SessionInfo sessionInfo) {
		List<StandardSpeechModel> modelList = new ArrayList<StandardSpeechModel>();
		String hql = "from StandardSpeech s where 1=1";
		Map<String,Object> paramMap = new HashMap<String,Object>();
		if(standardSpeechModel.getName() != null && !"".equals(standardSpeechModel.getName())) {
			hql += " and s.name like :name";
			paramMap.put("name",  standardSpeechModel.getName()+"%");
		}
		/*
		if(sessionInfo.getUserGroupId() != null && !"0".equals(sessionInfo.getUserGroupId())) {
			hql += " and s.updateUser.userGroup.uuid = :groupUserId";
			paramMap.put("groupUserId", sessionInfo.getUserGroupId());
		}*/
		List<StandardSpeech> standardSpeechList = standardSpeechDao.find(hql, paramMap, pageFilter.getiDisplayStart(), pageFilter.getiDisplayLength());
		copy(modelList, standardSpeechList);
		return modelList;
	}
	
	/**
	 * 对象实体列表转换为分页模型列表
	 * @param modelList
	 * @param dataList
	 */
	private void copy(List<StandardSpeechModel> modelList,
			List<StandardSpeech> dataList) {
		StandardSpeechModel autoRolesModel = null;
		
		for(StandardSpeech standardSpeech : dataList) {
			autoRolesModel = new StandardSpeechModel();
			transform(standardSpeech, autoRolesModel);
			modelList.add(autoRolesModel);
		}
		
	}
	
	/**
	 * 将实体对象转换为分页模型
	 * @param StandardSpeech
	 * @param StandardSpeechModel
	 */
	private void transform(StandardSpeech standardSpeech, StandardSpeechModel standardSpeechModel) {
		/**-- 拷贝bean内容 --**/
		BeanUtils.copyProperties(standardSpeech, standardSpeechModel);
		if(standardSpeech.getUpdateUser()!= null) {
			standardSpeechModel.setUpdateById(standardSpeech.getUpdateUser().getUuid());
			standardSpeechModel.setUpdateByName(standardSpeech.getUpdateUser().getName());
		}
	}
	
	/**
	 * 获取数量
	 * @param standardSpeechModel
	 * @param pageFilter
	 * @return
	 */
	@Override
	public long count(StandardSpeechModel standardSpeechModel,
			PageFilter pageFilter, SessionInfo sessionInfo) {
		String hql = "select count(*) from StandardSpeech s where 1=1";
		Map<String, Object> params = new HashMap<String, Object>();
		hql += hqlJoin(standardSpeechModel, params, sessionInfo);
		Long count = this.standardSpeechDao.count(hql, params);
		return count;
	}
	
	/**
	 * hql语句拼接
	 * @param rulesTypeModel
	 * @param params
	 * @return
	 */
	private String hqlJoin(StandardSpeechModel standardSpeechModel, Map<String, Object> params, SessionInfo sessionInfo) {
		String hql = "";
		if(standardSpeechModel.getName() != null && !"".equals(standardSpeechModel.getName())) {
			hql += " and s.name like :name";
			params.put("name", standardSpeechModel.getName() + "%");
		}
		/*
		if(sessionInfo.getUserGroupId() != null && !"0".equals(sessionInfo.getUserGroupId())) {
			hql += " and s.updateUser.userGroup.uuid = :groupUserId";
			params.put("groupUserId", sessionInfo.getUserGroupId());
		}*/
		
		return hql;
	}
	
	/**
	 * 通过ID获取标准话术实例
	 * @param uuid
	 * @return
	 */
	@Override
	public StandardSpeechModel get(String uuid) {
		StandardSpeech standardSpeech = this.standardSpeechDao.get(StandardSpeech.class, uuid);

		StandardSpeechModel standardSpeechModel = new StandardSpeechModel();
		BeanUtils.copyProperties(standardSpeech, standardSpeechModel);
		if (standardSpeech.getUpdateUser()!= null) {
			standardSpeechModel.setUpdateById(standardSpeech.getUpdateUser().getUuid());
			standardSpeechModel.setUpdateByName(standardSpeech.getUpdateUser().getName());
		}
		return standardSpeechModel;
	}
	
	/**
	 *标准话术重名判重
	 * @param name
	 * @return
	 */
	@Override
	public Boolean isRepeat(String name, String uuid, Boolean flag) {
		String hql = "select count(*) from StandardSpeech s where s.name=:name";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("name", name);
		
		if(flag) {
			hql += " and s.uuid!=:uuid";
			params.put("uuid", uuid);
		}
		
		Long count = this.standardSpeechDao.count(hql, params);
		if(count <= 0) {
			return false;
		} else {
			return true;
		}
	}
	
	/**
	 * 新增标准话术
	 * @param standardSpeechModel
	 * @throws Exception 
	 */
	@Override
	public String add(StandardSpeechModel standardSpeechModel){
		StandardSpeech standtandSpeech = new StandardSpeech();
		BeanUtils.copyProperties(standardSpeechModel, standtandSpeech);
		standtandSpeech.setUpdateTime(new Date());
		standtandSpeech.setUpdateUser(this.userDao.get(User.class, standardSpeechModel.getUpdateById()));
		this.standardSpeechDao.save(standtandSpeech);
		//发送http请求
		TextAnalyze text = new TextAnalyze();
		HttpHead httpHead = getHttpHead(SystemParamUtil.getValueByName("add_resource"), standtandSpeech.getUuid());
		//拼接内容
		JSONObject json = new JSONObject();
		JSONObject jsonName = new JSONObject();
		JSONArray arr = new JSONArray();
		String[] contentStr = standardSpeechModel.getContent().split("*");
		for(int i=0; i<contentStr.length; i++) {
			arr.add(contentStr[i]);
		}
		jsonName.put("phrase", arr);
		jsonName.put("threshold", Double.parseDouble(standardSpeechModel.getThreshold()));
		json.put("pattern_" + standardSpeechModel.getName(), jsonName);
		System.out.println(JSONObject.toJSONString(httpHead));
		System.out.println(json.toString());
		ResourceResp res = text.addResource(httpHead,json.toString());
		if(!"0".equals(res.getErrorCode())) {
			//事物回滚
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return ErrorMsg.getMsg(Integer.parseInt(res.getErrorCode()));
		}
		return "OK";
	}
	
	/**
	 * 更新标准话术
	 * @param standardSpeechModel
	 */
	@Override
	public String update(StandardSpeechModel standardSpeechModel) {
		StandardSpeech standtandSpeech = new StandardSpeech();
		BeanUtils.copyProperties(standardSpeechModel, standtandSpeech);
		standtandSpeech.setUpdateTime(new Date());
		standtandSpeech.setUpdateUser(this.userDao.get(User.class, standardSpeechModel.getUpdateById()));
		this.standardSpeechDao.update(standtandSpeech);
		//发送http请求
		TextAnalyze text = new TextAnalyze();
		HttpHead httpHead = getHttpHead(SystemParamUtil.getValueByName("add_resource"), standardSpeechModel.getUpdateById());
		//拼接内容
		JSONObject json = new JSONObject();
		JSONObject jsonName = new JSONObject();
		JSONArray arr = new JSONArray();
		arr.add(standardSpeechModel.getContent());
		jsonName.put("phrase", arr);
		jsonName.put("threshold", Double.parseDouble(standardSpeechModel.getThreshold()));
		json.put("pattern_" + standardSpeechModel.getName(), jsonName);
		System.out.println(JSONObject.toJSONString(httpHead));
		System.out.println(json.toString());
		ResourceResp res = text.addResource(httpHead,json.toString());
		if(!"0".equals(res.getErrorCode())) {
			//事物回滚
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return ErrorMsg.getMsg(Integer.parseInt(res.getErrorCode()));
		}
		return "OK";
	}

	/**
	 * 删除标准话术
	 * @param uuid
	 * @throws Exception
	 */
	@Override
	public String delete(String uuid) throws Exception {
		String hql = "delete from StandardSpeech s where s.uuid=:uuid";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("uuid", uuid);
		this.standardSpeechDao.executeHql(hql, params);
		//发送http请求
		TextAnalyze text = new TextAnalyze();
		HttpHead httpHead = getHttpHead(SystemParamUtil.getValueByName("del_resource"), uuid);
		System.out.println(JSONObject.toJSONString(httpHead));
		ResourceResp res = text.delResource(httpHead, "");
		if(!"0".equals(res.getErrorCode())) {
			//事物回滚
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return ErrorMsg.getMsg(Integer.parseInt(res.getErrorCode()));
		}
		return "OK";
	}
	
	/**获得http请求头*/
	public HttpHead getHttpHead(String url, String uuid) {
		HttpHead httpHead = new HttpHead();
		httpHead.setAppkey(SystemParamUtil.getValueByName("appkey"));
		httpHead.setUrl(url);
		String dateStr = DateConversion.getTimeString(new Date(), "yyyy-MM-dd hh:mm:ss");
		httpHead.setRequestDate(dateStr);
		httpHead.setSdkVersion(SystemParamUtil.getValueByName("sdkVersion"));
		String developKey = SystemParamUtil.getValueByName("developKey");
		developKey = MD5.getMD5Code(dateStr+developKey);
		httpHead.setSessionKey(developKey);
		httpHead.setUdid("101:1234567890");
		Map<String,String> taskConfig = new HashMap<String, String>();
		taskConfig.put("resourceid", uuid);
		taskConfig.put("capkey", SystemParamUtil.getValueByName("capkey_aapc"));
		taskConfig.put("property", SystemParamUtil.getValueByName("property"));
		httpHead.setTaskConfig(taskConfig);
		return httpHead;
	}
}
 