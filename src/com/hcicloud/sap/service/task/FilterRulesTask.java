package com.hcicloud.sap.service.task;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.network.ESMethod;
import com.hcicloud.sap.common.utils.PropertiesLoader;
import com.hcicloud.sap.common.utils.RedisUtil;
import com.hcicloud.sap.common.utils.StringUtil;
import com.hcicloud.sap.common.utils.SystemParamUtil;
import com.hcicloud.sap.model.quality.AutoRule;
import com.hcicloud.sap.model.quality.AutoRules;
import com.hcicloud.sap.model.quality.StandardSpeech;
import com.sinovoice.hcicloud.analyze.TextAnalyze;
import com.sinovoice.hcicloud.common.HttpHead;
import com.sinovoice.hcicloud.common.MD5;
import com.sinovoice.hcicloud.model.AnalyzeResp;

import redis.clients.jedis.Jedis;

public class FilterRulesTask implements TaskInterface{
	private String fromKey;
	private static Logger logger = Logger.getLogger(FilterRulesTask.class);
	
	private FilterRulesTask(String fromKey){
		super();
		this.fromKey = fromKey;
	}
	
	/**
	 * 自动检测生效的规则，过滤规则并标注
	 */
	@SuppressWarnings("unchecked")
	@Override
	public void run() {
		Jedis jedis = null;
		String data = null;
		JSONObject jsonObject = null;
		while(true){
			//System.out.println("FilterRulesTask开始");
			try{
				jedis = RedisUtil.getJedis();
				if(jedis == null){
					System.out.println("获取jedis失败");
					Thread.sleep(5000);
					continue;
				}

				if(jedis.llen(fromKey) <= 0) {
					Thread.sleep(5000);
					continue;
				}
				
				data = jedis.lpop(fromKey);
				if(data == null || "".equals(data)) {
					Thread.sleep(3000);
					continue;
				}
				System.out.println("FilterRulesTask开始查询数据库");
				jsonObject=JSONObject.parseObject(data);
				String hql = "from AutoRules a";
				String hql1="from AutoRule ar where ar.autoRules.uuid=:uuid";
				Session session=null;
				List<AutoRules> dataList=null;
				try {
					SessionFactory sessionFactory = TaskSessionFactory.getSessionFactory();
				    session =sessionFactory.openSession();
					 dataList = session.createQuery(hql).list();
				} catch (Exception e) {
					e.printStackTrace();
				}finally{
					if(session!=null){
						session.close();
					}

				}
				if(dataList == null ) {
					Thread.sleep(3000);
					continue;
				}
				String id=(String)jsonObject.get("UUID");
				JSONObject transData=jsonObject.getJSONObject("transData");
				JSONArray allContent=transData.getJSONArray("sentenceList");
				StringBuffer contentStr=new StringBuffer();
				contentStr.append("[");
				for(int i=0;i<allContent.size();i++){
					if(i<allContent.size()-1){
						contentStr.append("\""+allContent.getJSONObject(i).get("content")+"\",");
					}else{
						contentStr.append("\""+allContent.getJSONObject(i).get("content")+"\"");
					}
					
				}
				contentStr.append("]");
				System.out.println("contentStr.toString():"+contentStr.toString());
				//String analysisData="";
				
				JSONArray ruleNameList = new JSONArray();//规则名称
				JSONArray ruleScriptList = new JSONArray();//规则逻辑
				JSONArray hitPartList = new JSONArray();//命中语句
				JSONArray speechNameList = new JSONArray();//标准话术
				JSONArray confidenceList = new JSONArray();//命中语句
				List<String >list=new ArrayList<String>();
				for(int i=0;i<dataList.size();i++){
					String searchInfo=dataList.get(i).getSearchInfo();
					if(searchInfo!=null && !"".equals(searchInfo)){
						String searchString=getSearchString(searchInfo,id);
						JSONObject result = ESMethod.find("*", searchString);
						long total = Long.valueOf(result.getLongValue("total"));
						if(total>0){
							List<AutoRule> autoRuleList = null;
							try {
								SessionFactory sessionFactory = TaskSessionFactory.getSessionFactory();
							    session =sessionFactory.openSession();
							    autoRuleList = session.createQuery(hql1).setParameter("uuid", dataList.get(i).getUuid()).list();
							    System.out.println("autoRuleList.size(): "+autoRuleList.size());
							    System.out.println("autoRuleList:"+autoRuleList);
							} catch (Exception e) {
								e.printStackTrace();
							}finally{
								if(session!=null){
									session.close();
								}

							}
/*							if(autoRuleList == null||autoRuleList.size()==0 ) {
								Thread.sleep(3000);
								continue;
							}*/
							StringBuffer str=new StringBuffer();
							for(int k=0;k<autoRuleList.size();k++){
								System.out.println("autoRuleList.get(k).getUuid():"+autoRuleList.get(k).getUuid());
								if(k<autoRuleList.size()-1){
									str.append(autoRuleList.get(k).getUuid());
									str.append(";");
								}else{
									str.append(autoRuleList.get(k).getUuid());
								}
								
							}
							System.out.println("str.toString():"+str.toString());
							if("".equals(str.toString())){
								System.out.println("未查询到智能质检规则---------------");
							}else{
								AnalyzeResp res = analyze(str.toString(),contentStr.toString(),0);
								if(res!=null){
									if("0".equals(res.getErrorCode())){
										if(res.getResultText()!=null||res.getResultText().length()!=0){
											 
											JSONObject jsonObjectRule=JSONObject.parseObject(res.getResultText());
											Set<String> set=jsonObjectRule.keySet();
											Iterator<String> it = set.iterator();  
											while (it.hasNext()) {  
												  String key = it.next();  
												  System.out.println(str);  
												  JSONObject rule=jsonObjectRule.getJSONObject(key);
													JSONArray hitPart=rule.getJSONArray("hit_part");
													String script=rule.getString("script");
													ruleNameList.add(key);
													hitPartList.add(hitPart);
													ruleScriptList.add(script);
													System.out.println("key"+key+"hitPart:"+hitPart+"script:"+script);
												} 
		
									
										}
									}
								}
							}
						
					
						}
		
					}
				
				}
				JSONObject analysisData = new JSONObject();
				analysisData.put("ruleNameList", ruleNameList);
				analysisData.put("ruleScriptList", ruleScriptList);
				analysisData.put("hitPartList", hitPartList);
				jsonObject.put("analysisData", analysisData);
				System.out.println("analysisData:"+analysisData.getJSONArray("ruleNameList"));
				System.out.println("ruleScriptList:"+analysisData.getJSONArray("ruleScriptList"));
				System.out.println("hitPartList:"+analysisData.getJSONArray("hitPartList"));
				String type = StringUtil.dateToString(new Date(), "yyyy-MM");
				String hql2="from StandardSpeech ";
				List<StandardSpeech> standardSpeechList=null;
				try {
					SessionFactory sessionFactory = TaskSessionFactory.getSessionFactory();
				    session =sessionFactory.openSession();
				    standardSpeechList = session.createQuery(hql2).list();
				} catch (Exception e) {
					e.printStackTrace();
				}finally{
					if(session!=null){
						session.close();
					}

				}
				StringBuffer standardSpeechListStr=new StringBuffer();
				for(int k=0;k<standardSpeechList.size();k++){
					System.out.println("standardSpeechList.get(k).getUuid():"+standardSpeechList.get(k).getUuid());
					if(k<standardSpeechList.size()-1){
						standardSpeechListStr.append(standardSpeechList.get(k).getUuid());
						standardSpeechListStr.append(";");
					}else{
						standardSpeechListStr.append(standardSpeechList.get(k).getUuid());
					}
					
				}
				if ("".equals(standardSpeechListStr)){
					System.out.println("未查到标准话术-----------");
				}else{
					AnalyzeResp res = analyze(standardSpeechListStr.toString(),contentStr.toString(),1);
					if(res!=null){
						if("0".equals(res.getErrorCode())){
							if(res.getResultText()!=null||res.getResultText().length()!=0){
								 
								JSONObject jsonObjectSpeech=JSONObject.parseObject(res.getResultText());
								Set<String> set=jsonObjectSpeech.keySet();
								Iterator<String> it = set.iterator();  
								while (it.hasNext()) {  
									  String key = it.next();  
									  JSONObject speech=jsonObjectSpeech.getJSONObject(key);
										String confidence=speech.getString("confidence");
										speechNameList.add(key);
										confidenceList.add(confidence);
										System.out.println("key"+key+"confidence:"+confidence);
									} 

						
							}
						}
					}
				}
				
				JSONObject standardSpeech = new JSONObject();
				standardSpeech.put("speechNameList", speechNameList);
				standardSpeech.put("confidenceList", confidenceList);
				jsonObject.put("standardSpeech", standardSpeech);
				list.add(jsonObject.toJSONString());
				if(list.size()>0){
					ESMethod.indexBatch(type,list);
				}
				

			}catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				if(jedis != null) {
					RedisUtil.returnResource(jedis);
				}
			}
		}	
	}
//识别请求
	public  AnalyzeResp analyze(String resourceId,String allContent,int flag){
		//加载配置文件
		//SystemParamUtil.getValueByName("");
		//PropertiesLoader propertiesLoader = new PropertiesLoader("system.properties");
		/*String appKey = propertiesLoader.getProperty("appKey");
		String analyzeUrl = propertiesLoader.getProperty("analyzeUrl");
		String sdkVersion = propertiesLoader.getProperty("sdkVersion");
		String developKey = propertiesLoader.getProperty("developKey");*/
		String appKey = SystemParamUtil.getValueByName("appkey");
		String analyzeUrl = SystemParamUtil.getValueByName("analyzeUrl");
		String sdkVersion = SystemParamUtil.getValueByName("sdkVersion");
		String developKey = SystemParamUtil.getValueByName("developKey");
		String capkey="";
		if(flag==0){
			 capkey=SystemParamUtil.getValueByName("capkey_aer");
		}else{
			 capkey=SystemParamUtil.getValueByName("capkey_aapc");
		}
		//String capkey= propertiesLoader.getProperty("capkey");
		/*String property = propertiesLoader.getProperty("property");
		String udid = propertiesLoader.getProperty("udid");*/
		String property = SystemParamUtil.getValueByName("property");
		TextAnalyze ta = new TextAnalyze();
		HttpHead httpHead = new HttpHead();
		httpHead.setAppkey(appKey);
		httpHead.setUrl(analyzeUrl);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		httpHead.setRequestDate(sdf.format(new Date()));
		httpHead.setSdkVersion(sdkVersion);
		developKey = MD5.getMD5Code(sdf.format(new Date())+developKey);
		httpHead.setSessionKey(developKey);
		httpHead.setUdid("101:1234567890");
		Map<String,String> taskConfig = new HashMap<String, String>();
		taskConfig.put("resourceid_list", resourceId);
		taskConfig.put("capkey", capkey);
		taskConfig.put("property", property);
		httpHead.setTaskConfig(taskConfig);
		System.out.println(resourceId+"resourceIdresourceId"+capkey+"capkeycapkeycapkey"+property);
		AnalyzeResp res = ta.textAnalyze(httpHead, allContent);
		if(res!=null){
			System.out.println(res.getErrorCode());
			System.out.println(res.getResultText());
		}

		return res;
	}
	/**
	 * 获得查询的字符串
	 * 写的很烂，但是懒得改
	 * @param searchKeyWord
	 * @param searchInfo
	 * @param page 分页参数
	 * @return
	 */
	private String getSearchString( String searchInfo,String uuid) {
		StringBuilder searchBuilder = new StringBuilder();
		searchBuilder.append("{\"_source\":[")
						.append("\"UUID\",")
						.append("\"relateData.userId\",")
						.append("\"relateData.ani\",")
						.append("\"relateData.dnis\",")
						.append("\"relateData.analysisTime\",")
						.append("\"relateData.callTime\",")
						.append("\"transData.duration\",")
						.append("\"transData.silenceDuration\",")
						.append("\"transData.allContent\"")
						.append("],");
		
		searchBuilder.append("\"query\":{")
						.append("\"filtered\":{")
						.append("\"filter\":[")
						.append("{")
						.append("\"bool\":{");
		//must及should字符串
		StringBuilder mustBuilder = new StringBuilder();
		//为什么用should？因为有同类型的好多条件，或者关系。如果你不懂，请去翻js
		//StringBuilder shouldBuilder = new StringBuilder();
		
		mustBuilder.append("\"must\":[");
		//shouldBuilder.append("\"should\":[");
		
		//int flagShouldNumber = 0;
		
		//range字符串
		StringBuilder rangeBuilder = new StringBuilder();
		rangeBuilder.append("{\"range\":{");
		int flagRangeNumber = 0;
		
		//遍历拼接查询语句
		JSONArray searchArray = JSONArray.parseArray(searchInfo);
		JSONObject searchI = null;
		if(searchArray!=null){
			for(int i=0; i< searchArray.size(); i++) {
				searchI = searchArray.getJSONObject(i);
				
				if(searchI.getString("field") == null || "".equals(searchI.getString("field")) ||
						searchI.getString("type") == null || "".equals(searchI.getString("type"))) {
					continue;
				}
				//如果以后再写这种if，我选择死亡orz。。。 所以最好还是把映射信息放到数据库里。
				//后面的人还是花点时间把这里改了吧，包括页面
				//区间类型，时长区间，时间区间
				if("2".equals(searchI.getString("type")) ||
						"5".equals(searchI.getString("type")) ||
						"6".equals(searchI.getString("type"))){
					if((searchI.getString("minValue") == null || "".equals(searchI.getString("minValue"))) &&
							(searchI.getString("maxValue") == null || "".equals(searchI.getString("maxValue")))) {
						continue;
					}
					rangeBuilder.append("\"")
					.append(searchI.getString("field"))
					.append("\":{")
					.append(getRangeString(searchI.getString("type"), 
							searchI.getString("minValue"), searchI.getString("maxValue")))
					.append("},");

					flagRangeNumber++;
					continue;
				}

				//精确匹配
				if("0".equals(searchI.getString("type"))) {
					if(searchI.getString("equalValue") == null || "".equals(searchI.getString("equalValue"))) {
						continue;
					}

					mustBuilder.append(getTermString(searchI.getString("field"), searchI.getString("equalValue")));

					continue;
				}


				//全文匹配
				if("1".equals(searchI.getString("type"))) {
					if(searchI.getString("equalValue") == null || "".equals(searchI.getString("equalValue"))) {
						continue;
					}
					mustBuilder.append(getMustRegexpString(searchI.getString("equalValue"), searchI.getString("field")));
				}
				//枚举类型
				if("3".equals(searchI.getString("type"))) {
					if(searchI.getString("equalValueText") == null || "".equals(searchI.getString("equalValueText"))) {
						continue;
					}
					mustBuilder.append(getMustTermsString(searchI.getString("equalValueText"), searchI.getString("field")));
				}
				
				//模糊匹配
				if("4".equals(searchI.getString("type"))) {
					if(searchI.getString("equalValue") == null || "".equals(searchI.getString("equalValue"))) {
						continue;
					}
		
					mustBuilder.append(getRegexpString(searchI.getString("field"), searchI.getString("equalValue")));
				}
			}
				
		}

		


		mustBuilder.append(getTermString("UUID",uuid));
			//处理range字符串
				if(rangeBuilder.charAt(rangeBuilder.length() - 1) == ',') {
					rangeBuilder.deleteCharAt(rangeBuilder.length() - 1);
				}
				rangeBuilder.append("}")
								.append("}");
				//处理must字符串
				if(flagRangeNumber <= 0) {
					if(mustBuilder.charAt(mustBuilder.length() - 1) == ',') {
						mustBuilder.deleteCharAt(mustBuilder.length() - 1);
					}
					mustBuilder.append("]");
				} else {
					mustBuilder.append(rangeBuilder.toString())
								.append("]");
				}
				//拼接must及should字符串
				searchBuilder.append(mustBuilder.toString());
			/*	if(flagShouldNumber > 0) {
					searchBuilder.append(",")
									.append(shouldBuilder.toString());
				}*/
				searchBuilder.append("}")
								.append("}")
								.append("]")
								.append("}")
								.append("},");
				//分页
				searchBuilder.append("\"from\":")
								.append(0)
								.append(",");
				
				searchBuilder.append("\"size\":")
								.append(100000000);
				
				searchBuilder.append("}");
				searchBuilder.append("}");
				
				return searchBuilder.toString();
			}
	
	public static String getRangeString(String type, String minValue, String maxValue) {
		StringBuilder s = new StringBuilder();
		
		if(minValue != null && !"".equals(minValue)) {
			s.append("\"gte\":").append(getRangeValueByType(type, minValue, "min")).append(",");
		}
		if(maxValue != null && !"".equals(maxValue)) {
			s.append("\"lte\":").append(getRangeValueByType(type, maxValue, "max"));
		}
		
		if(s.charAt(s.length() - 1) == ',') {
			s.deleteCharAt(s.length() - 1);
		}
		
		return s.toString();
	}
	public static String getRegexpString(String field, String value) {
		StringBuilder sb = new StringBuilder();
		sb.append("{\"regexp\":{")
			.append("\"")
			.append(field)
			.append("\":\"")
			.append(".*")
			.append(value)
			.append(".*")
			.append("\"")
			.append("}")
			.append("},");
		return sb.toString();
	}
	public static String getTermString(String field, String value) {
		StringBuilder sb = new StringBuilder();
		sb.append("{\"term\":{")
			.append("\"")
			.append(field)
			.append("\":\"")
			.append(value)
			.append("\"")
			.append("}")
			.append("},");
		return sb.toString();
	}
	public static String getMustTermsString(String s, String field) {
		String[] valueArray = s.split(",");
		StringBuilder sb = new StringBuilder();
		sb.append("{\"terms\":{")
		.append("\"")
		.append(field)
		.append("\":[");
		for(int i=0; i<valueArray.length; i++) {
			if(i==(valueArray.length-1)){
				sb.append("\"")
				.append(valueArray[i].replace("×", ""))
				.append("\"");
			}else{
				sb.append("\"")
				.append(valueArray[i].replace("×", ""))
				.append("\"")
				.append(",");
			}
				
		}
		sb.append("]")
		.append("}")
		.append("},");
		return sb.toString();
	}
	public static String getMustRegexpString(String s, String field) {
		String[] valueArray = s.split(",");
		StringBuilder sb = new StringBuilder();
		sb.append("{\"regexp\":{")
		.append("\"")
		.append(field)
		.append("\":\"");
		for(int i=0; i<valueArray.length; i++) {
			if(i==(valueArray.length-1)){
				sb.append(".*")
				  .append(valueArray[i].replace("×", ""))
				  .append(".*");
			}else{
				sb.append(".*")
				  .append(valueArray[i].replace("×", ""))
				  .append(".*")
				  .append("|");
			}
				
		}
		sb.append("\"")
		.append("}")
		.append("},");
		return sb.toString();
	}
	/**
	 * 无力吐槽
	 * @param type
	 * @param value
	 * @param numberType
	 * @return
	 */
	public static String getRangeValueByType(String type, String value, String numberType) {
		if("2".equals(type)) {
			return value;
		} else if("5".equals(type)) {
			if("max".equals(numberType)) {
				return "\"" + value + " 00:00:00||+1d\"";
			} else {
				return "\"" + value + " 00:00:00\"";
			}
		} else if("6".equals(type)) {
			return String.valueOf(Double.parseDouble(value) * 60 * 1000);
		} else {
			return "";
		}
	}
/*public static void main(String[] args) {
	TextAnalyze ta = new TextAnalyze();
	HttpHead httpHead = new HttpHead();
	httpHead.setAppkey("5c5d5400");
	httpHead.setUrl("http://10.0.1.57:8880/ta/analyze");
	httpHead.setRequestDate("2016-08-09 15:23:23");
	httpHead.setSdkVersion("3.8");
	String developKey = "developer_key";
	developKey = MD5.getMD5Code("2016-08-09 15:23:23"+developKey);
	httpHead.setSessionKey(developKey);
	httpHead.setUdid("101:1234567890");
	Map<String,String> taskConfig = new HashMap<String, String>();
	taskConfig.put("resourceid_list", "8a80803257077d8d015707853b360001");
	taskConfig.put("capkey", "ta.cloud.aapc");
	taskConfig.put("property", "cn_common");
	httpHead.setTaskConfig(taskConfig);
	String json = "[\"对嗯嗯嗯好\",\"嗯\",\"嗯\",\"嗯好的\",\"嗯哎嗯\",\"嗯\",\"嗯嗯\",\"哦\",\"嗯\"]";
	AnalyzeResp res = ta.textAnalyze(httpHead, json);
	System.out.println(res.getErrorCode());
	System.out.println(res.getResultText());
	JSONObject jsonObject = new JSONObject();
	JSONObject jsonObjectRule=JSONObject.parseObject(res.getResultText());
	Set set=jsonObjectRule.keySet();
	Iterator<String> it = set.iterator();  
	while (it.hasNext()) {  
		  String key = it.next();  
		  JSONObject speech=jsonObjectRule.getJSONObject(key);
			String confidence=speech.getString("confidence");
			System.out.println("key"+key+"confidence:"+confidence);
		}  
}*/
}