package com.hcicloud.sap.service.success.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;



import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.network.ESMethod;
import com.hcicloud.sap.common.network.EsUtil;
import com.hcicloud.sap.common.network.HTTPMethod;
import com.hcicloud.sap.common.utils.Combobox;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.dao.BaseDaoI;
import com.hcicloud.sap.model.admin.SystemParam;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.success.SuccessModal;
import com.hcicloud.sap.pagemodel.success.SuccessRecordModel;
import com.hcicloud.sap.service.success.SuccessOrderService;
import com.hcicloud.sap.service.success.SuccessRecordService;

@Service
public class SuccessRecordServiceImpl implements SuccessRecordService {
	@Autowired
	private BaseDaoI<SystemParam> systemParamDao;

	@Autowired
	private SuccessOrderService successOrderService;

	/**
	 * 获取成功单列表 从pa_success中取得
	 * 
	 * @param model
	 * @param pf
	 * @return
	 */
	@Override
	public Grid getSuccessListOld(SuccessRecordModel model, PageFilter pf) {

		String searchString = "{\"query\": {\"filtered\": {\"filter\": [{\"bool\": {\"must\": [";
		// 时间范围
		if (StringUtils.isNoneBlank(model.getStartTime())
				&& StringUtils.isNoneBlank(model.getEndTime())) {
			searchString += "{\"range\":{\"CREATE_TIME\":{\"gte\":\""
					+ model.getStartTime() + "\",\"lte\":\""
					+ model.getEndTime() + "\"}}},";
		}
		// 工单号
		if (StringUtils.isNoneBlank(model.getOrderId())) {
			searchString += "{\"term\":{\"dnis\": \"" + model.getOrderId()
					+ "\"}},";
		}
		// 平台编号
		if (StringUtils.isNoneBlank(model.getPlatForm())) {
			searchString += "{\"term\":{\"PLAT_FORM\": \""
					+ model.getPlatForm() + "\"}},";
		}
		// 违规点/质检点
		if (StringUtils.isNoneBlank(model.getQualityName())) {
			searchString += "{\"wildcard\":{\"QUALITY_NAME\": \"*"
					+ model.getQualityName() + "*\"}},";
		}
		// 关键字
		if (StringUtils.isNoneBlank(model.getSearchKeyword())) {
			searchString += "{\"query_string\":{\"default_field\": \"ALL_CONTENT\",\"query\":\"*"
					+ model.getSearchKeyword() + "*\"}},";
		}

		if (searchString.endsWith(",")) {
			searchString = searchString.substring(0, searchString.length() - 1);
		}
		searchString += "]}}]}},";
		// 高亮
		searchString += "\"highlight\":{\"fields\":{\"ALL_CONTENT\":{}}},";

		searchString += "\"sort\": {\"CREATE_TIME\": {\"order\": \"desc\",\"ignore_unmapped\":true}},";

		searchString += "\"from\": " + pf.getiDisplayStart() + ",\"size\": "
				+ pf.getiDisplayLength() + "}";
		long total = 0l;
		List<SuccessModal> list = new ArrayList<SuccessModal>();
		try {
			String result = HTTPMethod.doPostQuery(EsUtil.successUrl()
					+ "/_search", searchString, 30000);
			System.out.println(EsUtil.successUrl() + "/_search");
			System.out.println(searchString);
			JSONObject resultObject = JSONObject.parseObject(result);
			JSONObject hitsObject = resultObject.getJSONObject("hits");
			total = (Integer) hitsObject.get("total");
			JSONArray hitsArray = hitsObject.getJSONArray("hits");

			for (Object sourceObject : hitsArray) {
				JSONObject jsonObject = ((JSONObject) sourceObject)
						.getJSONObject("_source");
				JSONObject highlightObject = ((JSONObject) sourceObject)
						.getJSONObject("highlight");

				SuccessRecordModel sm = new SuccessRecordModel();
				sm.setOrderId(jsonObject.getString("ORDER_ID"));
				sm.setVoiceId(jsonObject.getString("VOICE_ID"));
				sm.setPlatForm(jsonObject.getString("PLAT_FORM"));
				sm.setUserPhone(jsonObject.getString("USER_PHONE"));
				String callLength = jsonObject.getString("CALL_LENGTH");
				if (StringUtils.isNotBlank(callLength)) {
					int second = Integer.parseInt(callLength);
					callLength = transSecToHour(second);
				}
				sm.setCallLength(callLength);
				sm.setQualityName(jsonObject.getString("QUALITY_NAME"));
				sm.setQualityDetail(jsonObject.getString("QUALITY_DETAIL"));
				sm.setCreateTime(jsonObject.getString("CREATE_TIME"));
				String ALL_CONTENT = "";

				if (highlightObject != null) {
					// ALL_CONTENT=highlightObject.
					ALL_CONTENT = highlightObject.getJSONArray("ALL_CONTENT")
							.getString(0);
					sm.setRemark(ALL_CONTENT);
				} else {
					ALL_CONTENT = jsonObject.getString("ALL_CONTENT");
					if (StringUtils.isNoneBlank(ALL_CONTENT)) {
						sm.setRemark(ALL_CONTENT);
					} else {
						sm.setRemark("");
					}
				}

				// 添加录音文本

				/*
				 * String orderId = jsonObject.getString("ORDER_ID");
				 * List<ContentGridData> contentListByVoiceId =
				 * successOrderService.getContentListByVoiceId(orderId); String
				 * remark=""; for (ContentGridData contentGridData :
				 * contentListByVoiceId) {
				 * remark+=contentGridData.getVoiceId()+" :"
				 * +contentGridData.getCallContent()+";"; }
				 * sm.setRemark(remark);
				 */
				list.add(sm);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		Grid grid = new Grid();
		grid.setAaData(list);// 数据
		grid.setiTotalDisplayRecords(total);// 数据总条数
		grid.setiTotalRecords(list.size());//
		return grid;
	}
	/**
	 * 从sap*,trans中获取成功件列表
	 * @param model
	 * @param pf
	 * @return
	 */

	@Override
	public Grid getSuccessList(SuccessRecordModel model, PageFilter pf) {
		String searchString = "{\"query\": {\"filtered\": {\"filter\": [{\"bool\": {\"must\": [";
		// 时间范围
		if (StringUtils.isNoneBlank(model.getStartTime())
				&& StringUtils.isNoneBlank(model.getEndTime())) {
			searchString += "{\"range\":{\"relateData.indexTime\":{\"gte\":\""
					+ model.getStartTime() + "\",\"lte\":\""
					+ model.getEndTime() + "\"}}},";
		}
		// 工单号
		if (StringUtils.isNoneBlank(model.getOrderId())) {
			searchString += "{\"term\":{\"relateData.dnis\": \""
					+ model.getOrderId() + "\"}},";
		}
		// 平台编号
		if (StringUtils.isNoneBlank(model.getPlatForm())) {
			searchString += "{\"term\":{\"relateData.userName\": \""
					+ model.getPlatForm() + "\"}},";
		}
		// 违规点/质检点
		if (StringUtils.isNoneBlank(model.getQualityName())) {
			searchString += "{\"wildcard\":{\"relateData.ani\": \"*"
					+ model.getQualityName() + "*\"}},";
		}
		// 关键字

		if (StringUtils.isNoneBlank(model.getSearchKeyword())) {
			searchString += "{\"simple_query_string\": {\"query\": \""
					+ model.getSearchKeyword()
					+ "\" ,\"fields\": [ \"transData.allContent\"]}},";
		}

		if (searchString.endsWith(",")) {
			searchString = searchString.substring(0, searchString.length() - 1);
		}
		searchString += "]}}]}},";

		// 高亮
		searchString += "\"highlight\":{\"fields\":{\"transData.allContent\":{}}},";
		searchString += "\"sort\": {\"relateData.indexTime\": {\"order\": \"desc\",\"ignore_unmapped\":true}},";
		searchString += "\"from\": " + pf.getiDisplayStart() + ",\"size\": "
				+ pf.getiDisplayLength() + "}";

		long total = 0l;
		List<SuccessModal> list = new ArrayList<SuccessModal>();
		try {

			JSONObject result = ESMethod.find("*", searchString);
			JSONArray voiceJson = result.getJSONArray("voices");
			JSONArray highJson = result.getJSONArray("highlight");
			total = Long.valueOf(result.getLongValue("total"));
			for (int i = 0; i < voiceJson.size(); i++) {
				JSONObject sourceObject = voiceJson.getJSONObject(i);
				JSONObject transJsonObject = sourceObject
						.getJSONObject("transData");
				JSONObject relateJsonObject = sourceObject
						.getJSONObject("relateData");

				SuccessRecordModel sm = new SuccessRecordModel();
				sm.setOrderId(relateJsonObject.getString("dnis"));// 工单号
				sm.setVoiceId(relateJsonObject.getString("userId"));//录音流水号		
				sm.setPlatForm(relateJsonObject.getString("userName"));// 平台编号
				sm.setCreateTime(relateJsonObject.getString("indexTime"));//创建时间
				sm.setCallTime(relateJsonObject.getString("callTime"));// 通话时间
				sm.setQualityName(relateJsonObject.getString("ani"));// 违规点
				// 添加文本
				String allContent = "";
				if (highJson != null && highJson.size() > 0) {
					// ALL_CONTENT=highlightObject.
					allContent = highJson.getJSONObject(i)
							.getJSONArray("transData.allContent").getString(0);
				} else {
					allContent = transJsonObject.getString("allContent");
				}
				allContent =subContent(allContent, 500);
				sm.setRemark(allContent);
				list.add(sm);
			}

		}
		catch (Exception e) {
			e.printStackTrace();
		}
		Grid grid = new Grid();
		grid.setAaData(list);// 数据
		grid.setiTotalDisplayRecords(total);// 数据总条数
		grid.setiTotalRecords(list.size());//
		return grid;

	}
	
     /**
      * 从数据库获取平台集合
      * @return
      */
	@Override
	public Json getPlaytForms() {
		String name = "platFormUrl";
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

		List<Combobox> platFormList = new ArrayList<Combobox>();
		while (it.hasNext()) // 迭代方式取键值
		{
			Object key = it.next();
			Combobox combobox = new Combobox();
			combobox.setId(key.toString());
			combobox.setText(key.toString());
			platFormList.add(combobox);

		}
		if (platFormList != null && platFormList.size() > 0) {
			json.setSuccess(true);
			json.setObj(platFormList);
		} else {
			json.setSuccess(false);
		}
		return json;

	}
	
	/**
	 * 秒转换时分秒
	 * @param second
	 * @return
	 */

	private String transSecToHour(int second) {
		int h = 0;
		int d = 0;
		int s = 0;
		int temp = second % 3600;
		if (second > 3600) {
			h = second / 3600;
			if (temp != 0) {
				if (temp > 60) {
					d = temp / 60;
					if (temp % 60 != 0) {
						s = temp % 60;
					}
				} else {
					s = temp;
				}
			}
		} else {
			d = second / 60;
			if (second % 60 != 0) {
				s = second % 60;
			}
		}

		return h + "时" + d + "分" + s + "秒";
	}

	/**
	 * 获取字符串中含句号的个数
	 * 
	 * @param allContent
	 * @return
	 */
	public static int getIdolNum(String allContent) {
		if (allContent == null || allContent.length() == 0) {
			return 0;
		}
		int count = 0;
		char[] chars = allContent.toCharArray();

		for (char c : chars) {
			if (c == '。') {
				count++;
			}
		}
		return count;
	}

	public static String subContent(String allContent,int length){
		if (allContent == null || allContent.length() == 0) {
			return "";
		}
		if (allContent.length()>length){
			allContent=allContent.substring(0, length);
		}
		return allContent;
		
	}

}
