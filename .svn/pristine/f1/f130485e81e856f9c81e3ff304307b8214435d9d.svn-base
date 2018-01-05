package com.hcicloud.sap.service.region.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.network.EsUtil;
import com.hcicloud.sap.common.network.HTTPMethod;
import com.hcicloud.sap.common.utils.Combobox;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.dao.BaseDaoI;
import com.hcicloud.sap.model.admin.SystemParam;
import com.hcicloud.sap.pagemodel.annoy.AnnoyGridData;
import com.hcicloud.sap.pagemodel.annoy.AnnoyModel;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.region.RegionGridData;
import com.hcicloud.sap.pagemodel.region.RegionModel;
import com.hcicloud.sap.service.annoy.AnnoyService;
import com.hcicloud.sap.service.region.RegionService;
@Service
public class RegionServiceImpl implements RegionService {
	
	private Logger logger = Logger.getLogger(RegionServiceImpl.class);
	@Autowired
	private BaseDaoI<SystemParam> systemParamDao;
	

	/**
	 * 根据条件查询es
	 * @param model 查询条件
	 * @param ph 分页条件
	 * @return
	 * @throws Exception 
	 */
	public Grid dataGrid(RegionModel model, PageFilter ph) throws Exception {
		String searchString = "{\"query\": {\"filtered\": {\"filter\": [{\"bool\": {\"must\": [";
		if(StringUtils.isNoneBlank(model.getStartTime()) && StringUtils.isNoneBlank(model.getEndTime()) ){
			searchString += "{\"range\":{\"CREATE_TIME\":{\"gte\":\""+model.getStartTime()+"\",\"lte\":\""+model.getEndTime()+"\"}}},";
		}	
		//精准查询产品类型
		/*if(StringUtils.isNoneBlank(model.getProductType())){
			searchString+="{\"term\":{\"PRODUCT_TYPE\": \""+model.getProductType()+"\"}},";
		}	
		*/
		/*
		 * 模糊通配符查询
		 */
		 if (StringUtils.isNoneBlank(model.getProductType())) {
			searchString += "{\"wildcard\":{\"PRODUCT_TYPE\": \"*"
					+ model.getProductType() + "*\"}},";
		}
		
		 if (StringUtils.isNoneBlank(model.getProductWord())) {
			 searchString += "{\"wildcard\":{\"PRODUCT_WORD\": \"*"
					 + model.getProductWord() + "*\"}},";
		 }

		if(StringUtils.isNoneBlank(model.getVoiceId())){
			searchString+="{\"term\":{\"VOICE_ID\": \""+model.getVoiceId()+"\"}},";
		}	
		if(StringUtils.isNoneBlank(model.getStaffId())){
			searchString+="{\"term\":{\"STAFF_ID\": \""+model.getStaffId()+"\"}},";
		}
		if(StringUtils.isNoneBlank(model.getPlatForm())){
			searchString+="{\"term\":{\"PLAT_FORM\": \""+model.getPlatForm()+"\"}},";
		}
		//去掉最后一个 ‘，’
		if(searchString.endsWith(",")){
			searchString = searchString.substring(0, searchString.length()-1);		
		}
		searchString+="]}}]}},\"sort\": {\"CREATE_TIME\": {\"order\": \"desc\",\"ignore_unmapped\":true}},"
				+ "\"from\": "+ph.getiDisplayStart()+",\"size\": "+ph.getiDisplayLength()+"}";
		
		List<RegionGridData> list = new ArrayList<RegionGridData>();
		long total = 0l;
		try {
			String result = HTTPMethod.doPostQuery(EsUtil.getProductQueryUrl(), searchString, 30000);
			JSONObject resultObject = JSON.parseObject(result);
			JSONObject hitsObject = resultObject.getJSONObject("hits");
			total = (Integer) hitsObject.get("total");
			JSONArray hitsArray = hitsObject.getJSONArray("hits");
			for (Object v : hitsArray) {
				JSONObject jsonObject = ((JSONObject)v).getJSONObject("_source");
				RegionGridData regionGridData = new RegionGridData();
				regionGridData.setVoiceId(jsonObject.getString("VOICE_ID"));
				regionGridData.setStaffId(jsonObject.getString("STAFF_ID"));
				regionGridData.setVoicePath(jsonObject.getString("VOICE_PATH"));
				regionGridData.setPlatForm(jsonObject.getString("PLAT_FORM"));
				regionGridData.setProductType(jsonObject.getString("PRODUCT_TYPE"));
				regionGridData.setProductWord(jsonObject.getString("PRODUCT_WORD"));
				
				regionGridData.setCallContent(jsonObject.getString("CALL_CONTENT"));
				regionGridData.setCallStartTime(jsonObject.getString("CALL_START_TIME"));
				//annoyGridData.setCallEndTime(jsonObject.getString("CALL_END_TIME"));
				regionGridData.setCreateTime(jsonObject.getString("CREATE_TIME"));
				regionGridData.setCallPhone(jsonObject.getString("CALL_PHONE"));
				
				list.add(regionGridData);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		Grid grid = new Grid();
		grid.setAaData(list);
		grid.setiTotalDisplayRecords(total);
		grid.setiTotalRecords(list.size());
		return grid;
	}

	/**
	 * 从数据库获取区拓业务的产品类型
	 * @return
	 */

	@Override
	public Json getProductType() {
			String name = "regionProductType";
			String hql = " from SystemParam where name='" + name + "'";
			List<SystemParam> resultList = systemParamDao.find(hql);
			String result = "";
			Json json = new Json();
			if (resultList != null && resultList.size() > 0) {
				result = resultList.get(0).getValue();
			}
			JSONObject resultObject = JSONObject.parseObject(result);
			Map<Object, Object> map = (Map) resultObject;
			Set keySet = map.keySet();
			Iterator it = keySet.iterator();

			List<Combobox> productList = new ArrayList<Combobox>();
			while (it.hasNext()) // 迭代方式取键值
			{
				Object key = it.next();
				Combobox combobox = new Combobox();
				combobox.setId(key.toString());
				combobox.setText(key.toString());
				productList.add(combobox);

			}
			if (productList != null && productList.size() > 0) {
				json.setSuccess(true);
				json.setObj(productList);
			} else {
				json.setSuccess(false);
			}
			return json;
	}

	/**
	 * 区拓业务报表统计列表
	 * @param regionModel
	 * @return
	 * @throws Exception
	 */
	@Override
	public Grid reportGrid(RegionModel regionModel) throws Exception {
		
		String searchString = "{\"query\":{\"bool\":{\"must\":[";
		
		if (StringUtils.isNoneBlank(regionModel.getStartTime())&& StringUtils.isNoneBlank(regionModel.getEndTime())) {
			searchString += "{\"range\":{\"CREATE_TIME\":{\"gte\":\""+ regionModel.getStartTime() + "\",\"lte\":\""+ regionModel.getEndTime() + "\"}}}";
		}
		if (searchString.endsWith(",")) {
			searchString = searchString.substring(0, searchString.length() - 1);
		}
		searchString += "]}},\"size\":0,\"aggs\":{\"quality\":{\"terms\":{\"field\":\"PRODUCT_WORD\",\"size\":1000},\"aggs\":{\"platform\":{\"terms\":{\"field\":\"PLAT_FORM\"}}}}}}";

		String result = HTTPMethod.doPostQuery(EsUtil.getProductQueryUrl(), searchString, 30000);
		System.out.println("报表显示查询地址" + EsUtil.getProductQueryUrl());
		System.out.println("查询语句" + searchString);
		logger.info("报表显示查询地址" + EsUtil.getProductQueryUrl());
		logger.info("查询语句" + searchString);
		logger.info("result:" + result);
		
		JSONObject object = JSON.parseObject(result);
		//查询条件该时间段内总数量
		Long total = object.getJSONObject("hits").getLong("total");
		
		JSONArray buckets = object.getJSONObject("aggregations").getJSONObject("quality").getJSONArray("buckets");
		Map<String, Map<String, Object>> map = new HashMap<String, Map<String, Object>>();
		
		for (int i = 0; i < buckets.size(); i++) {
			JSONObject item = buckets.getJSONObject(i);
			String key = item.getString("key");
			
			if (key.contains("|")) {
				String[] split = key.split("\\|");
				for (String splitKey : split) {
					splitKeyCount(splitKey, map, item);
				}
			} else {
				splitKeyCount(key, map, item);
			}
		}
		//排序
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Set<String> keySet = map.keySet();
		for (String string : keySet) {
			list.add(map.get(string));
		}
		Map<String, Object> temp = null;
		Map<String, Object> before = null;
		Map<String, Object> after = null;
		for (int i = list.size() - 1; i > 0; --i) {

			for (int j = 0; j < i; ++j) {
				before = list.get(j);
				after = list.get(j + 1);
				if ((Long) after.get("total") > (Long) before.get("total")) {
					temp = before;
					list.set(j, after);
					list.set(j + 1, temp);
				}
			}

		}
		
		//对产品分类关键词的包含率
		for (Map<String, Object> map2 : list) {
			Long countLong = (Long) map2.get("total");
			String violation = ((countLong * 1.0d / total) * 100 + "").substring(0, 4) + "%";
			map2.put("violation", violation);
		}
		//去除非选中数据||如果可以匹配查询删除次代码
		if (!"全部".equals(regionModel.getProductType())&&StringUtils.isNoneBlank(regionModel.getProductType())) {
			
			
			
			Set<String> wordSet = new HashSet<String>();
			
			String name = "regionProductWord";
			String hql = " from SystemParam where name='" + name + "'";
			List<SystemParam> resultList = systemParamDao.find(hql);
			JSONObject wordObject = JSONObject.parseObject(resultList.get(0).getValue());
			String wordString = wordObject.getString(regionModel.getProductType());
			String[] wordArray = wordString.split(",");
			for (int i = 0; i < wordArray.length; i++) {
				wordSet.add(wordArray[i]);
			}
			
			Iterator<Map<String, Object>> iterator = list.iterator();
			
			while (iterator.hasNext()) {
				Map<String, Object> next = iterator.next();
				String key = (String) next.get("key");
				if (!wordSet.contains(key) ||"".equals(key)) {
					iterator.remove();
				}
			}
			//最后将没有包含的关键词置为0显示
			//重新遍历list去除所有key
			
			Iterator<Map<String, Object>> reultIterator = list.iterator();
			Set<String> resultSet = new HashSet<String>();
			while (reultIterator.hasNext()) {
				Map<String, Object> resultnext = reultIterator.next();
			    resultSet.add((String)resultnext.get("key"));
			}
			//没有包含的加入并置为0显示
			Iterator<String> wordIterator =  wordSet.iterator();
			while (wordIterator.hasNext()) {
				String wordKey = wordIterator.next();
				if (!resultSet.contains(wordKey)) {
					Map<String, Object> regionMap = new HashMap<String, Object>();
					regionMap.put("violation", "0.00%");
					regionMap.put("total", 0);
					regionMap.put("key", wordKey);
					list.add(regionMap);
				}	
			}
		}
		//显示总数
		builReportCountList(list, regionModel);
		
		
		Grid grid = new Grid();
		grid.setAaData(list);
		grid.setiTotalDisplayRecords(list.size());
		grid.setiTotalRecords(list.size());
		return grid;
	}
	
	private void splitKeyCount(String key,Map<String, Map<String, Object>> map, JSONObject item) {
		Long total = item.getLong("doc_count");
		JSONArray platList = item.getJSONObject("platform").getJSONArray("buckets");
		if (map.containsKey(key)) {
			Map<String, Object> keyMap = map.get(key);
			keyMap.put("key", key);
			keyMap.put("total", (Long) keyMap.get("total") + total);
			for (int j = 0; j < platList.size(); j++) {
				JSONObject platform = platList.getJSONObject(j);
				String platformName = platform.getString("key");
				if (keyMap.containsKey(platformName)) {
					keyMap.put(platformName, (Long) keyMap.get(platformName)+ platform.getLong("doc_count"));
				} else {
					keyMap.put(platformName, platform.getLong("doc_count"));
				}
			}
			map.put(key, keyMap);
	  } else {
				Map<String, Object> sr = new HashMap<String, Object>();
				sr.put("key", key);
				sr.put("total", total);
				for (int j = 0; j < platList.size(); j++) {
					JSONObject platform = platList.getJSONObject(j);
					sr.put(platform.getString("key"), platform.getLong("doc_count"));
				}
				map.put(key, sr);
			}
		}
	
	
	private void builReportCountList(List<Map<String, Object>> list,RegionModel regionModel) {
		// 构建工单总数map{"total":10056,"violation":"99.8 %","XQD - HW":10056,key:"aaa"}

		Map<String, Object> regionSumMap = new HashMap<String, Object>();
		Map<String, Object> countMap = new HashMap<String, Object>();// 存储统计的各个平台数量
		// 查询工单总数total
		PageFilter ph = new PageFilter(0, 1);
		Grid regionGrid;
		try {
			if ("全部".equals(regionModel.getProductType())) {
				regionModel.setProductType("");
			}
			regionGrid = this.dataGrid(regionModel, ph);
		
			countMap.put("total", regionGrid.getiTotalDisplayRecords());
			// successModal.setqu
			String[] platForms = { "XQD-CCOD", "XQD-HW", "XQD-ZX", "XQD-ZHW","XQD-SHW" };
			for (String string : platForms) {
				regionModel.setPlatForm(string);
				countMap.put(string, this.dataGrid(regionModel, ph).getiTotalDisplayRecords());
			}
	
			regionSumMap.put("key", "通话总数");
			regionSumMap.put("total", countMap.get("total"));
			regionSumMap.put("XQD-CCOD", countMap.get("XQD-CCOD"));
			regionSumMap.put("XQD-HW", countMap.get("XQD-HW"));
			regionSumMap.put("XQD-ZX", countMap.get("XQD-ZX"));
			regionSumMap.put("XQD-ZHW", countMap.get("XQD-ZHW"));
			regionSumMap.put("XQD-SHW", countMap.get("XQD-SHW"));
			regionSumMap.put("violation", " ");
			list.add(regionSumMap);
		} catch (Exception e) {
				e.printStackTrace();
			}
		

	}
	
	
	
	


}
