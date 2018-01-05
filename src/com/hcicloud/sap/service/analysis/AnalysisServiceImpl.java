package com.hcicloud.sap.service.analysis;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.network.ESMethod;
import com.hcicloud.sap.common.utils.StringUtil;
import com.hcicloud.sap.common.utils.SystemParamUtil;
import com.hcicloud.sap.dao.BaseDaoI;
import com.hcicloud.sap.pagemodel.analysis.EchartModel;
import com.hcicloud.sap.pagemodel.analysis.HomeEchartModel;
import com.hcicloud.sap.pagemodel.quality.InspectorModel;

@Service
public class AnalysisServiceImpl implements AnalysisServiceI {

	// 时间格式转换
	private static Map<String, String> dataTypeMap;
	@Autowired
	private BaseDaoI<String> userIdDao;

	static {
		dataTypeMap = new HashMap<String, String>();
		dataTypeMap.put("1m", "HH:mm");
		dataTypeMap.put("1h", "yyyy-MM-dd HH点");
		dataTypeMap.put("1d", "yyyy-MM-dd");
		dataTypeMap.put("1M", "yyyy-MM");
	}

	/**
	 * 从es中获取趋势统计数据
	 * 
	 * @param keyword
	 * @param startTime
	 * @param endTime
	 * @param dataType
	 * @return
	 */
	@Override
	public EchartModel getTrendData(String condition, String startTime,
			String endTime, String dateType) {
		EchartModel resultModel = new EchartModel();
		List<String> xList = new ArrayList<String>();
		List<Float> yList = new ArrayList<Float>();
		String query = getSearchString(null, condition, startTime, endTime,
				dateType, 0, 0);
		System.out.println(query);
		JSONObject resultObject = ESMethod.find("*", query);
		if (resultObject != null) {
			JSONObject aggregations = resultObject
					.getJSONObject("aggregations");
			if (aggregations != null) {
				// 结果
				JSONArray resultArray = aggregations.getJSONObject("timeRange")
						.getJSONArray("buckets").getJSONObject(0)
						.getJSONObject("data").getJSONArray("buckets");
				// 解析数据
				if (resultArray != null && resultArray.size() > 0) {
					if (resultArray.size() > 1500) {
						resultModel.setDataCount(resultArray.size());
						resultModel.setSucess(false);
						return resultModel;
					}
					for (int i = 0; i < resultArray.size(); i++) {
						JSONObject oneObject = resultArray.getJSONObject(i);
						xList.add(StringUtil.StringFormataChange(
								oneObject.getString("key_as_string"),
								"yyyy-MM-dd HH:mm:ss",
								dataTypeMap.get(dateType)));
						yList.add(oneObject.getFloatValue("doc_count"));
					}
					resultModel.setxSeries(xList);
					resultModel.setySeries(yList);
					resultModel.setSucess(true);
					resultModel.setDataCount(xList.size());
					return resultModel;
				}
			}
		}
		resultModel.setDataCount(0);
		resultModel.setSucess(false);
		return resultModel;
	}
	/**
	 * 从es中获取分组主页数据
	 * @param condition
	 * @param startTime
	 * @param endTime
	 * @param dateType
	 * @return
	 */
	@Override
	public HomeEchartModel getHomeTrendData(String condition, String startTime,
			String endTime, String dateType) {
		HomeEchartModel resultModel = new HomeEchartModel();
		
		String query = getHomeSearchString(null, condition, startTime, endTime,
				dateType, 0, 0);
		System.out.println("查询语句："+query);
		JSONObject resultObject = ESMethod.find("*", query);
		if (resultObject != null) {
			JSONObject aggregations = resultObject
					.getJSONObject("aggregations");
			if (aggregations != null) {
				// 结果
				System.out.println("查询结果："+aggregations);
				JSONArray resultArray = aggregations.getJSONObject("timeRange")
						.getJSONArray("buckets").getJSONObject(0)
						.getJSONObject("userGroup").getJSONArray("buckets");
				List<List<Float>> yList = new ArrayList<List<Float>>();
				List<String> nameList = new ArrayList<String>();
				
				for (int i = 0; i < resultArray.size(); i++) {
					String userGroupId = resultArray.getJSONObject(i).getString("key");
					List<String> name = getUserGroupName(userGroupId);
					nameList.addAll(name);
					JSONArray dataArray = resultArray.getJSONObject(i).getJSONObject("data").getJSONArray("buckets");
					
					List<String> xList = new ArrayList<String>();
					List<Float> floatList = new ArrayList<Float>();
					if (dataArray != null && dataArray.size() > 0 ) {
						if (dataArray.size() > 1500) {
							resultModel.setDataCount(resultArray.size());
							resultModel.setSuccess(false);
							return resultModel;
						}
						for (int j = 0; j < dataArray.size(); j++) {
							JSONObject oneObject = dataArray.getJSONObject(j);
							xList.add(StringUtil.StringFormataChange(
									oneObject.getString("key_as_string"),
									"yyyy-MM-dd HH:mm:ss",
									dataTypeMap.get(dateType)));
							floatList.add(oneObject.getFloatValue("doc_count"));
							
						}
					}
					
					
					yList.add(floatList);
					resultModel.setxSeries(xList);
					resultModel.setDataCount(xList.size());
				}
				resultModel.setUserGroupName(nameList);
				resultModel.setyList(yList);;
			
				resultModel.setSuccess(true);
				return resultModel;
			}
		}
		resultModel.setDataCount(0);
		resultModel.setSuccess(false);
		return resultModel;
	}
	
	/**
	 * 获取用户组名称
	 * @param userGroupId
	 * @return
	 */
	public List<String> getUserGroupName(String userGroupId) {
		String hql = "select t.name from UserGroup t where t.uuid = :userGroupId ";
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userGroupId", userGroupId);
		List<String> list = this.userIdDao.find(hql, paramMap);
		//打印日志
		/*System.out.println(userGroupId+"    "+list);
		System.out.println();*/
		return list;
	}
	/**
	 * 获取搜索的字符串
	 * 
	 * @param searchInfo
	 * @param value1
	 * @param value2
	 * @param dateType
	 * @return
	 */
	private String getSearchString(String searchKeyWord, String searchInfo,
			String value1, String value2, String searchType, int type,
			int period) {
		StringBuilder searchBuilder = new StringBuilder();
		searchBuilder.append("{");
		// 关键字匹配
		if (searchKeyWord != null && !"".equals(searchKeyWord)) {
			searchKeyWord = searchKeyWord.replace("\"", "\\\"");
			searchBuilder.append("\"query\":{\"simple_query_string\":{")
					.append("\"query\":\"").append(searchKeyWord).append("\",")
					.append("\"fields\":").append("[\"transData.allContent\"]")
					.append("}},");
		}
		if (searchInfo != null && searchInfo.length() > 0
				&& !"null".equals(searchInfo)) {
			searchBuilder.append("\"query\":{").append("\"filtered\":{")
					.append("\"filter\":[").append("{").append("\"bool\":{");

			// must及should字符串
			StringBuilder mustBuilder = new StringBuilder();
			mustBuilder.append("\"must\":[");
			// range字符串
			/*StringBuilder rangeBuilder = new StringBuilder();
			rangeBuilder.append("{\"range\":{");
			int flagRangeNumber = 0;*/

			// 关键字匹配
			if (searchKeyWord != null && !"".equals(searchKeyWord)) {
				searchKeyWord = searchKeyWord.replace("\"", "\\\"");
				mustBuilder.append("{\"simple_query_string\":{")
						.append("\"query\":\"").append(searchKeyWord)
						.append("\",").append("\"fields\":")
						.append("[\"transData.allContent\"]").append("}},");
			}
			// 遍历拼接查询语句
			JSONArray searchArray = JSONArray.parseArray(searchInfo);
			JSONObject searchI = null;

			for (int i = 0; i < searchArray.size(); i++) {
				searchI = searchArray.getJSONObject(i);

				if (searchI.getString("field") == null
						|| "".equals(searchI.getString("field"))
						|| searchI.getString("type") == null
						|| "".equals(searchI.getString("type"))) {
					continue;
				}
				// 如果以后再写这种if，我选择死亡orz。。。 所以最好还是把映射信息放到数据库里。
				// 后面的人还是花点时间把这里改了吧，包括页面
				// 区间类型，时长区间，时间区间
				if ("2".equals(searchI.getString("type"))
						|| "5".equals(searchI.getString("type"))
						|| "6".equals(searchI.getString("type"))) {
					if ((searchI.getString("minValue") == null || ""
							.equals(searchI.getString("minValue")))
							&& (searchI.getString("maxValue") == null || ""
									.equals(searchI.getString("maxValue")))) {
						continue;
					}
					StringBuilder rangeBuilder = new StringBuilder();
					rangeBuilder.append("{\"range\":{");
					int flagRangeNumber = 0;
					rangeBuilder
							.append("\"")
							.append(searchI.getString("field"))
							.append("\":{")
							.append(getRangeString(searchI.getString("type"),
									searchI.getString("minValue"),
									searchI.getString("maxValue")))
							.append("},");
					// 处理range字符串
					if (rangeBuilder.charAt(rangeBuilder.length() - 1) == ',') {
						rangeBuilder.deleteCharAt(rangeBuilder.length() - 1);
					}
					rangeBuilder.append("}").append("},");
					mustBuilder.append(rangeBuilder.toString());
					//flagRangeNumber++;
					continue;
				}

				// 精确匹配
				if ("0".equals(searchI.getString("type"))) {
					if (searchI.getString("equalValue") == null
							|| "".equals(searchI.getString("equalValue"))) {
						continue;
					}

					mustBuilder.append(getTermString(
							searchI.getString("field"),
							searchI.getString("equalValue")));

					continue;
				}
				// 全文匹配
				if ("1".equals(searchI.getString("type"))) {
					if (searchI.getString("equalValue") == null
							|| "".equals(searchI.getString("equalValue"))) {
						continue;
					}
					mustBuilder.append(getMustRegexpString(
							searchI.getString("equalValue"),
							searchI.getString("field")));
					// shouldBuilder.append(getShouldString(searchI.getString("equalValue"),
					// searchI.getString("field"), true));

					// flagShouldNumber +=
					// searchI.getString("equalValue").split(",").length;
				}
				// 枚举类型
				if ("3".equals(searchI.getString("type"))) {
					if (searchI.getString("equalValueText") == null
							|| "".equals(searchI.getString("equalValueText"))) {
						continue;
					}
					mustBuilder.append(getMustTermsString(
							searchI.getString("equalValueText"),
							searchI.getString("field")));
					// shouldBuilder.append(getShouldString(searchI.getString("equalValueText"),
					// searchI.getString("field"), false));

					// flagShouldNumber +=
					// searchI.getString("equalValueText").split(",").length;
				}
				// 模糊匹配
				if ("4".equals(searchI.getString("type"))) {
					if (searchI.getString("equalValue") == null
							|| "".equals(searchI.getString("equalValue"))) {
						continue;
					}

					mustBuilder.append(getRegexpString(
							searchI.getString("field"),
							searchI.getString("equalValue")));
				}
			}

			// 处理must字符串
			
			if (mustBuilder.charAt(mustBuilder.length() - 1) == ',') {
				mustBuilder.deleteCharAt(mustBuilder.length() - 1);
			}
			mustBuilder.append("]");
			
			searchBuilder.append(mustBuilder.toString());
			searchBuilder.append("}").append("}").append("]").append("}")
					.append("},");

		}
		if (type == 0) {
			// 趋势分析
			searchBuilder
					.append(getTrendSeachString(value1, value2, searchType));
		} else if (type == 1) {
			// 交叉分析
			searchBuilder.append(getCrossSeachString(value1, value2,
					searchType, period));
		}
		searchBuilder.append(",\"size\":0");
		searchBuilder.append("}");								

		return searchBuilder.toString();
	}
	/**
	 * 主页面趋势图查询语句拼接(分组查询)
	 * @param searchKeyWord
	 * @param searchInfo
	 * @param value1
	 * @param value2
	 * @param searchType
	 * @param type
	 * @param period
	 * @return
	 */
	public String getHomeSearchString(String searchKeyWord, String searchInfo,
			String value1, String value2, String searchType, int type,
			int period) {
		StringBuilder searchBuilder = new StringBuilder();
		searchBuilder.append("{");
		if (type == 0) {
			searchBuilder.append("\"aggs\":{").append("\"timeRange\":{")
			.append("\"date_range\":{")
			.append("\"field\":\"relateData.analysisTime\",")
			.append("\"ranges\":[{").append("\"from\":\"")
			.append(value1).append("\",").append("\"to\":\"")
			.append(value2).append("\"").append("}").append("]")
			.append("},").append("\"aggs\":{").append("\"userGroup\":{")
			.append("\"terms\":{")
			.append("\"field\":\"userGroupId\"").append("},")
			.append("\"aggs\":{").append("\"data\":{")
			.append("\"date_histogram\":{")
			.append("\"field\":\"relateData.analysisTime\",")
			.append("\"interval\":\"").append(searchType).append("\",")
			.append("\"min_doc_count\":0,").append("\"extended_bounds\":{")
			.append("\"min\":\"").append(value1).append("\",")
			.append("\"max\":\"").append(value2).append("\"").append("}")
			.append("}").append("}").append("}").append("}").append("}").append("}").append("}");
		}
		
		searchBuilder.append(",\"size\":0");
		searchBuilder.append("}");

		return searchBuilder.toString();
	}
	
	public static String getRegexpString(String field, String value) {
		StringBuilder sb = new StringBuilder();
		sb.append("{\"regexp\":{").append("\"").append(field).append("\":\"")
				.append(".*").append(value).append(".*").append("\"")
				.append("}").append("},");
		return sb.toString();
	}

	public static String getRangeString(String type, String minValue,
			String maxValue) {
		StringBuilder s = new StringBuilder();

		if (minValue != null && !"".equals(minValue)) {
			s.append("\"gte\":")
					.append(getRangeValueByType(type, minValue, "min"))
					.append(",");
		}
		if (maxValue != null && !"".equals(maxValue)) {
			s.append("\"lte\":").append(
					getRangeValueByType(type, maxValue, "max"));
		}

		if (s.charAt(s.length() - 1) == ',') {
			s.deleteCharAt(s.length() - 1);
		}

		return s.toString();
	}

	public static String getRangeValueByType(String type, String value,
			String numberType) {
		if ("2".equals(type)) {
			return value;
		} else if ("5".equals(type)) {
			if ("max".equals(numberType)) {
				return "\"" + value + "\"";
			} else {
				return "\"" + value + "\"";
			}
		} else if ("6".equals(type)) {
			return String.valueOf(Double.parseDouble(value) * 60 * 1000);
		} else {
			return "";
		}
	}

	public static String getTermString(String field, String value) {
		StringBuilder sb = new StringBuilder();
		sb.append("{\"term\":{").append("\"").append(field).append("\":\"")
				.append(value).append("\"").append("}").append("},");
		return sb.toString();
	}

	public static String getMustRegexpString(String s, String field) {
		String[] valueArray = s.split(",");
		StringBuilder sb = new StringBuilder();
		sb.append("{\"regexp\":{").append("\"").append(field).append("\":\"");
		for (int i = 0; i < valueArray.length; i++) {
			if (i == (valueArray.length - 1)) {
				sb.append(".*").append(valueArray[i].replace("×", ""))
						.append(".*");
			} else {
				sb.append(".*").append(valueArray[i].replace("×", ""))
						.append(".*").append("|");
			}

		}
		sb.append("\"").append("}").append("},");
		return sb.toString();
	}

	public static String getMustTermsString(String s, String field) {
		String[] valueArray = s.split(",");
		StringBuilder sb = new StringBuilder();
		sb.append("{\"terms\":{").append("\"").append(field).append("\":[");
		for (int i = 0; i < valueArray.length; i++) {
			if (i == (valueArray.length - 1)) {
				sb.append("\"").append(valueArray[i].replace("×", ""))
						.append("\"");
			} else {
				sb.append("\"").append(valueArray[i].replace("×", ""))
						.append("\"").append(",");
			}

		}
		sb.append("]").append("}").append("},");
		return sb.toString();
	}

	/**
	 * 获取趋势统计的聚合字符串
	 * 
	 * @param startTime
	 * @param endTime
	 * @param dateType
	 * @return
	 */
	public static String getTrendSeachString(String startTime, String endTime,
			String dateType) {
		StringBuilder searchBuilder = new StringBuilder();
		searchBuilder.append("\"aggs\":{").append("\"timeRange\":{")
				.append("\"date_range\":{")
				.append("\"field\":\"relateData.callTime\",")
				.append("\"ranges\":[{").append("\"from\":\"")
				.append(startTime).append("\",").append("\"to\":\"")
				.append(endTime).append("\"").append("}").append("]")
				.append("},").append("\"aggs\":{").append("\"data\":{")
				.append("\"date_histogram\":{")
				.append("\"field\":\"relateData.callTime\",")
				.append("\"interval\":\"").append(dateType).append("\",")
				.append("\"min_doc_count\":0,").append("\"extended_bounds\":{")
				.append("\"min\":\"").append(startTime).append("\",")
				.append("\"max\":\"").append(endTime).append("\"").append("}")
				.append("}").append("}").append("}").append("}").append("}");
		return searchBuilder.toString();
	}

	/**
	 * 获取交叉分析的字符串
	 * 
	 * @return
	 */
	public static String getCrossSeachString(String xType, String yType,
			String searchType, int period) {
		StringBuilder searchBuilder = new StringBuilder();
		searchBuilder.append("\"aggs\":{").append("\"1\":{")
				.append("\"histogram\":{")
				.append("\"field\":\"" + xType + "\",")
				.append("\"interval\":" + period + ",")
				.append("\"min_doc_count\":0").append("}");
		if (!"count".equals(searchType)) {
			searchBuilder.append(",\"aggs\":{").append("\"2\":{")
					.append("\"" + searchType + "\":{")
					.append("\"field\":\"" + yType + "\"").append("}")
					.append("}").append("}");
		}
		searchBuilder.append("}").append("}");
		return searchBuilder.toString();
	}

	@Override
	public EchartModel getCrossData(String searchInfoCommon,String searchKeyword, String dataType, String xType, String yType,
			String xPeriod, String yPeriod, String xmult, String ymult) {
		EchartModel echartModel = new EchartModel();
		String query = getCrossSearchString(searchInfoCommon, searchKeyword,dataType, xType, yType, xPeriod, yPeriod, xmult, ymult);
		System.out.println(query);
		try {
			JSONObject resultObject = ESMethod.find("*", query);
			if (resultObject != null) {
				JSONObject aggregations = resultObject
						.getJSONObject("aggregations");
				if (aggregations != null) {
					// 结果
					JSONArray resultArray = aggregations.getJSONObject("1")
							.getJSONArray("buckets");
					// 解析数据
					if (resultArray != null && resultArray.size() > 0) {
						int maxNum = 200;
						String tempNum  = SystemParamUtil.getValueByName("crossAnalysisMaxNum");
						if(tempNum!=null){
							try {
								maxNum = Integer.parseInt(tempNum);
							} catch (Exception e) {
							}
						}
						if(resultArray.size() > maxNum){
							echartModel.setDataCount(1);
							echartModel.setSucess(false);
							return echartModel;
						}
						List<String> xData = new ArrayList<String>();
						JSONArray yArray = new JSONArray();
						List<String> yList = new ArrayList<String>();
						Map<String, String> mapList = new LinkedHashMap<String, String>();
						for (int i = 0; i < resultArray.size(); i++) {
							JSONObject obj = resultArray.getJSONObject(i);
							String name = "";
							if (obj.containsKey("key_as_string")) {
								name = obj.getString("key_as_string");
							} else {
								name = obj.getString("key");
							}
							JSONArray buckets = obj.getJSONObject("3")
									.getJSONArray("buckets");
							xData.add(name);
							if(buckets.size() > maxNum){
								echartModel.setDataCount(1);
								echartModel.setSucess(false);
								return echartModel;
							}
							for (int j = 0; j < buckets.size(); j++) {
								String tempName = "";
								JSONObject objTemp = buckets.getJSONObject(j);
								if (objTemp.containsKey("key_as_string")) {
									tempName = objTemp
											.getString("key_as_string");
								} else {
									tempName = objTemp.getString("key");
								}
								if (!mapList.containsKey(tempName)) {
									mapList.put(tempName, "");
								}
							}
						}
						if(mapList.size() > maxNum){
							echartModel.setDataCount(1);
							echartModel.setSucess(false);
							return echartModel;
						}
						Map<String,Map<String,Long>> mapData = new LinkedHashMap<String, Map<String,Long>>();
						for (int i = 0; i < resultArray.size(); i++) {
							JSONObject obj = resultArray.getJSONObject(i);
							JSONArray buckets = obj.getJSONObject("3")
									.getJSONArray("buckets");
							String name = "";
							if (obj.containsKey("key_as_string")) {
								name = obj.getString("key_as_string");
							} else {
								name = obj.getString("key");
							}
							Map<String,Long> ktMap = new LinkedHashMap<String, Long>();
							for (int j = 0; j < buckets.size(); j++) {
								JSONObject objTemp = buckets.getJSONObject(j);
								String tempName = "";
								if (objTemp.containsKey("key_as_string")) {
									tempName = objTemp
											.getString("key_as_string");
								} else {
									tempName = objTemp.getString("key");
								}
								Long count = objTemp.getLong("doc_count");
								ktMap.put(tempName, count);
							}
							mapData.put(name, ktMap);
						}
						Set<Map.Entry<String,String>> set = mapList
								.entrySet();
						// 遍历键值对对象的集合，得到每一个键值对对象
						for (Map.Entry<String, String> me : set) {
							// 根据键值对对象获取键和值
							String key = me.getKey();
							JSONObject job = new JSONObject();
							job.put("name", key);
							job.put("type", "bar");
							List<Long> dataList = new ArrayList<Long>();
							for(String str:xData){
								if(mapData.get(str).get(key)==null){
									dataList.add(0l);
								}else{
									dataList.add(mapData.get(str).get(key));
								}
							}
							job.put("data", dataList);
							yArray.add(job);
							yList.add(key);
						}
						boolean isDate = false;
						List<String> xDataNew = new ArrayList<String>();
						if("5".equals(xmult)){
							isDate = true;
							for(String str:xData){
								String formatStr = "";
								if("1m".endsWith(xPeriod)){
									formatStr = str.substring(0,str.length()-3);
								}else if("1h".endsWith(xPeriod)){
									formatStr = str.substring(0,str.length()-6);
								}else if("1d".endsWith(xPeriod)){
									formatStr = str.substring(0,str.length()-9);
								}else {
									formatStr = str.substring(0,str.length()-15);
								}
								xDataNew.add(formatStr);
							}
						}else if("2".equals(xmult)){
							isDate = true;
							try {
								for(String str:xData){
									String formatStr = "";
									long temp = Long.parseLong(str)+Long.parseLong(xPeriod);
									formatStr = str+"-"+temp;
									xDataNew.add(formatStr);
								}
							} catch (Exception e) {
								isDate = false;
							}
						}
						echartModel.setyJsonArray(yArray);
						if(isDate){
							echartModel.setxSeries(xDataNew);
						}else{
							echartModel.setxSeries(xData);
						}
						echartModel.setyList(yList);
						echartModel.setSucess(true);
						return echartModel;
					}
				}
			}
		} catch (Exception e) {
			echartModel.setDataCount(1);
			echartModel.setSucess(false);
		}
		echartModel.setDataCount(0);
		echartModel.setSucess(false);
		return echartModel;
	}

	private String getCrossSearchString(String searchInfoCommon,String searchKeyword,String dataType, String xType,
			String yType, String xPeriod, String yPeriod, String xmult,
			String ymult) {
		StringBuilder searchBuilder = new StringBuilder();
		if ((searchInfoCommon != null && searchInfoCommon.length() > 0
				&& !"null".equals(searchInfoCommon))||(searchKeyword!=null&&searchKeyword.trim().length()>0)) {
			searchBuilder.append("{\"size\": 0,\"query\": {\"filtered\":{")
			.append("\"filter\":[").append("{").append("\"bool\":{");
			StringBuilder mustBuilder = new StringBuilder();
			mustBuilder.append("\"must\":[");//range字符串
			StringBuilder rangeBuilder = new StringBuilder();
			rangeBuilder.append("{\"range\":{");
			int flagRangeNumber = 0;
			//关键字匹配
			if(searchKeyword != null && !"".equals(searchKeyword)) {
				searchKeyword = searchKeyword.replace("\"", "\\\"");
				mustBuilder.append("{\"simple_query_string\":{")
							.append("\"query\":\"")
							.append(searchKeyword)
							.append("\",")
							.append("\"fields\":")
							.append("[\"transData.allContent\"]")
							.append("}},");
			}
			// 遍历拼接查询语句
			if((searchInfoCommon != null && searchInfoCommon.length() > 0
				&& !"null".equals(searchInfoCommon))){
				JSONArray searchArray = JSONArray.parseArray(searchInfoCommon);
				JSONObject searchI = null;
				for (int i = 0; i < searchArray.size(); i++) {
					searchI = searchArray.getJSONObject(i);
					if (searchI.getString("field") == null
							|| "".equals(searchI.getString("field"))
							|| searchI.getString("type") == null
							|| "".equals(searchI.getString("type"))) {
						continue;
					}
					if ("2".equals(searchI.getString("type"))
							|| "5".equals(searchI.getString("type"))
							|| "6".equals(searchI.getString("type"))) {
						if ((searchI.getString("minValue") == null || ""
								.equals(searchI.getString("minValue")))
								&& (searchI.getString("maxValue") == null || ""
										.equals(searchI.getString("maxValue")))) {
							continue;
						}
						rangeBuilder
								.append("\"")
								.append(searchI.getString("field"))
								.append("\":{")
								.append(getRangeString(searchI.getString("type"),
										searchI.getString("minValue"),
										searchI.getString("maxValue")))
								.append("},");

						flagRangeNumber++;
						continue;
					}

					// 精确匹配
					if ("0".equals(searchI.getString("type"))) {
						if (searchI.getString("equalValue") == null
								|| "".equals(searchI.getString("equalValue"))) {
							continue;
						}

						mustBuilder.append(getTermString(
								searchI.getString("field"),
								searchI.getString("equalValue")));

						continue;
					}
					// 全文匹配
					if ("1".equals(searchI.getString("type"))) {
						if (searchI.getString("equalValue") == null
								|| "".equals(searchI.getString("equalValue"))) {
							continue;
						}
						mustBuilder.append(getMustRegexpString(
								searchI.getString("equalValue"),
								searchI.getString("field")));
					}
					// 枚举类型
					if ("3".equals(searchI.getString("type"))) {
						if (searchI.getString("equalValueText") == null
								|| "".equals(searchI.getString("equalValueText"))) {
							continue;
						}
						mustBuilder.append(getMustTermsString(
								searchI.getString("equalValueText"),
								searchI.getString("field")));
					}
					// 模糊匹配
					if ("4".equals(searchI.getString("type"))) {
						if (searchI.getString("equalValue") == null
								|| "".equals(searchI.getString("equalValue"))) {
							continue;
						}
						mustBuilder.append(getRegexpString(
								searchI.getString("field"),
								searchI.getString("equalValue")));
					}
				}
			}
			// 处理range字符串
			if (rangeBuilder.charAt(rangeBuilder.length() - 1) == ',') {
				rangeBuilder.deleteCharAt(rangeBuilder.length() - 1);
			}
			rangeBuilder.append("}").append("}");

			// 处理must字符串
			if (flagRangeNumber <= 0) {
				if (mustBuilder.charAt(mustBuilder.length() - 1) == ',') {
					mustBuilder.deleteCharAt(mustBuilder.length() - 1);
				}
				mustBuilder.append("]");
			} else {
				mustBuilder.append(rangeBuilder.toString()).append("]");
			}
			searchBuilder.append(mustBuilder.toString());
			searchBuilder.append("}").append("}").append("]").append("}")
					.append("},");

		}else{
			searchBuilder.append("{\"size\": 0,");
		}
		// 交叉分析枚举对枚举
		if ("3".equals(xmult) && "3".equals(ymult)) {
			searchBuilder.append("\"aggs\":{").append("\"1\":{")
					.append("\"terms\":{")
					.append("\"field\":\"" + xType + "\",")
					.append("\"size\":10,").append("\"order\":{")
					.append("\"_count\":\"desc\"").append("}").append("},")
					.append("\"aggs\":{").append("\"3\":{")
					.append("\"terms\":{")
					.append("\"field\":\"" + yType + "\",")
					.append("\"size\":10,").append("\"order\":{")
					.append("\"_count\":\"desc\"").append("}").append("}")
					.append("}").append("}").append("}").append("}")
					.append("}");
		} else if ("3".equals(xmult) && "2".equals(ymult)) {
			searchBuilder.append("\"aggs\":{").append("\"1\":{")
					.append("\"terms\":{")
					.append("\"field\":\"" + xType + "\",")
					.append("\"size\":10,").append("\"order\":{")
					.append("\"_count\":\"desc\"").append("}").append("},")
					.append("\"aggs\":{").append("\"3\":{")
					.append("\"histogram\":{")
					.append("\"field\":\"" + yType + "\",")
					.append("\"interval\":" + yPeriod).append("}").append("}")
					.append("}").append("}").append("}").append("}");
		} else if ("2".equals(xmult) && "3".equals(ymult)) {
			searchBuilder.append("\"aggs\":{").append("\"1\":{")
					.append("\"histogram\":{")
					.append("\"field\":\"" + xType + "\",")
					.append("\"interval\":" + xPeriod).append("},")
					.append("\"aggs\":{").append("\"3\":{")
					.append("\"terms\":{")
					.append("\"field\":\"" + yType + "\",")
					.append("\"size\":10,").append("\"order\":{")
					.append("\"_count\":\"desc\"").append("}").append("}")
					.append("}").append("}").append("}").append("}")
					.append("}");
		} else if (("2".equals(xmult) && "2".equals(ymult))) {
			searchBuilder.append("\"aggs\":{").append("\"1\":{")
					.append("\"histogram\":{")
					.append("\"field\":\"" + xType + "\",")
					.append("\"interval\":" + xPeriod).append("},")
					.append("\"aggs\":{").append("\"3\":{")
					.append("\"histogram\":{")
					.append("\"field\":\"" + yType + "\",")
					.append("\"interval\":" + yPeriod).append("}").append("}")
					.append("}").append("}").append("}").append("}");
		} else if (("3".equals(xmult) && "5".equals(ymult))) {
			searchBuilder.append("\"aggs\":{").append("\"1\":{")
					.append("\"terms\":{")
					.append("\"field\":\"" + xType + "\",")
					.append("\"size\":10,").append("\"order\":{")
					.append("\"_count\":\"desc\"").append("}").append("},")
					.append("\"aggs\":{").append("\"3\":{")
					.append("\"date_histogram\":{")
					.append("\"field\":\"" + yType + "\",")
					.append("\"interval\":\"" + yPeriod + "\",")
					.append("\"min_doc_count\":1").append("}").append("}")
					.append("}").append("}").append("}").append("}");
		} else if (("5".equals(xmult) && "3".equals(ymult))) {
			searchBuilder.append("\"aggs\":{").append("\"1\":{")
					.append("\"date_histogram\":{")
					.append("\"field\":\"" + xType + "\",")
					.append("\"interval\":\"" + xPeriod + "\",")
					.append("\"min_doc_count\":1").append("},")
					.append("\"aggs\":{").append("\"3\":{")
					.append("\"terms\":{")
					.append("\"field\":\"" + yType + "\",")
					.append("\"size\":10,").append("\"order\":{")
					.append("\"_count\":\"desc\"").append("}").append("}")
					.append("}").append("}").append("}").append("}")
					.append("}");
		} else if (("2".equals(xmult) && "5".equals(ymult))) {
			searchBuilder.append("\"aggs\":{").append("\"1\":{")
					.append("\"histogram\":{")
					.append("\"field\":\"" + xType + "\",")
					.append("\"interval\":" + xPeriod + "").append("},")
					.append("\"aggs\":{").append("\"3\":{")
					.append("\"date_histogram\":{")
					.append("\"field\":\"" + yType + "\",")
					.append("\"interval\":\"" + yPeriod + "\",")
					.append("\"min_doc_count\":1").append("}").append("}")
					.append("}").append("}").append("}").append("}");
		} else if (("5".equals(xmult) && "2".equals(ymult))) {
			searchBuilder.append("\"aggs\":{").append("\"1\":{")
					.append("\"date_histogram\":{")
					.append("\"field\":\"" + xType + "\",")
					.append("\"interval\":\"" + xPeriod + "\",")
					.append("\"min_doc_count\":1").append("},")
					.append("\"aggs\":{").append("\"3\":{")
					.append("\"histogram\":{")
					.append("\"field\":\"" + yType + "\",")
					.append("\"interval\":" + yPeriod).append("}").append("}")
					.append("}").append("}").append("}").append("}");
		} else if (("5".equals(xmult) && "5".equals(ymult))) {
			searchBuilder.append("\"aggs\":{").append("\"1\":{")
					.append("\"date_histogram\":{")
					.append("\"field\":\"" + xType + "\",")
					.append("\"interval\":\"" + yPeriod + "\",")
					.append("\"min_doc_count\":1").append("},")
					.append("\"aggs\":{").append("\"3\":{")
					.append("\"date_histogram\":{")
					.append("\"field\":\"" + xType + "\",")
					.append("\"interval\":\"" + yPeriod + "\",")
					.append("\"min_doc_count\":1").append("}").append("}")
					.append("}").append("}").append("}").append("}");
		}
		return searchBuilder.toString();

	}
}
