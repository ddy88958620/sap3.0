package com.hcicloud.sap.service.hotword;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.network.ESMethod;
import com.hcicloud.sap.common.utils.CommonMethod;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.common.utils.SystemParamUtil;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.hotword.HotWordModel;
import com.hcicloud.sap.pagemodel.hotword.Link;
import com.hcicloud.sap.pagemodel.hotword.Node;
import com.hcicloud.sap.pagemodel.voice.VoiceModel;
import com.hcicloud.sap.service.quality.RulesServiceI;
@Service
public class HotWordServiceImpl implements HotWordServiceI{
	@Autowired
	private RulesServiceI rulesService;

    /**
     * 获取检索条件信息
     * @return
     */
	@Override
	public Json getSearchFormInfo() {
		Json json = new Json(true, null, null);
		
		JSONObject searchObject = new JSONObject();
		
		//获取规则类型集合
		searchObject.put("ruleTypeList", rulesService.loadRuleTypeInfo("search"));
		
		json.setObj(searchObject);
		
		return json;
	}
	public void getNodes(HotWordModel param,List<Node> nodeList,List<Link> linkList,List<String> words,List<HotWordModel> hotWordList,int perCount,int retainCount,int allCount,int category){
		String searchString = null;
		if(param.getSearchInfo() != null && !"".equals(param.getSearchInfo())) {
			searchString = getSearchString(param.getSearchKeyword(),param.getContent(), param.getSearchInfo(),perCount);
		}
		
		JSONObject result = ESMethod.findHotWord("*", searchString);
		JSONArray bucketsArray =result.getJSONArray("bucketsArray");
		JSONArray bucketsArray1=new JSONArray();
		
		for(int j=0;j<words.size();j++){
			for(int i=0;i<bucketsArray.size();i++){
				if(bucketsArray.getJSONObject(i).get("key").equals(words.get(j))){
					bucketsArray.remove(i);
					i--;
				}
			}
			
		}
		for(int i=0;i<bucketsArray.size();i++){
			if(param.getSearchKeyword()!=null){
				if(param.getSearchKeyword().indexOf(bucketsArray.getJSONObject(i).get("key")+"")>-1){
					bucketsArray.remove(i);
					i--;
				}
			}
	
		}
		for(int k=0;k<nodeList.size();k++){
			for(int i=0;i<bucketsArray.size();i++){
				if(nodeList.get(k).getName().equals(bucketsArray.getJSONObject(i).get("key"))){
					bucketsArray.remove(i);
					i--;
				}
			}
		}

		if(bucketsArray.size()>retainCount){
			bucketsArray1.addAll(bucketsArray.subList(0, retainCount)) ;
		}else{
			bucketsArray1.addAll(bucketsArray);
		}
		for(int i=0;i<bucketsArray1.size();i++){
			if(hotWordList.size()==allCount){
				break ;
			}
			JSONObject v = bucketsArray1.getJSONObject(i);
			HotWordModel hotWord=new HotWordModel();
			hotWord.setCount(v.getInteger("bg_count"));
			hotWord.setName(v.getString("key"));
			hotWordList.add(hotWord);
		/*	if((hotWordList.size())%retainCount==0){
				category++;
			}*/
			Node node=new Node();
			node.setCategory(category);
			node.setName(v.getString("key"));
			node.setValue(v.getInteger("bg_count"));
			nodeList.add(node);
			
			if(!"".equals(param.getSearchKeyword())){
				Link link=new Link();
				link.setSource(v.getString("key"));
				link.setTarget(param.getSearchKeyword());
				linkList.add(link);
			}
	
		}
		
		if(hotWordList.size()<allCount){
			for(int i=0;i<bucketsArray1.size();i++){
			JSONObject v = bucketsArray1.getJSONObject(i);
			param.setSearchKeyword(v.getString("key"));
			if(hotWordList.size()==allCount){
				break ;
			}
			getNodes( param, nodeList, linkList, words, hotWordList, perCount, retainCount,allCount,category);
		}
		}
	}
	public  Grid dataGrid(HotWordModel param){
		int category=1;
		List<HotWordModel> hotWordList = new ArrayList<HotWordModel>();
		List<Node> nodeList = new ArrayList<Node>();
		if(!"".equals(param.getSearchKeyword())&&null!=param.getSearchKeyword()){
			Node node=new Node();
			node.setCategory(category);
			node.setName(param.getSearchKeyword());
			node.setValue(100);
			nodeList.add(node);
		}

		List<Link> linkList = new ArrayList<Link>();
		String topicHotWord = SystemParamUtil.getValueByName("topic_hotword");
	    String[] hotwordParam=topicHotWord.split(",");
	    int perCount=Integer.parseInt(hotwordParam[0]);
	    int retainCount=Integer.parseInt(hotwordParam[1]);
	    int allCount=Integer.parseInt(hotwordParam[2]);
		try {
			/**--读取停用词文件，获取停用词列表--*/
			File hotword = new File(CommonMethod.getPath()+"/resources/stopword.gbk");
			List<String> words = new ArrayList<String>();
			FileInputStream fileInputStream = null;
			InputStreamReader inputStreamReader = null;
			BufferedReader bufferedReader = null;
			try {
				fileInputStream = new FileInputStream(hotword);
				inputStreamReader = new InputStreamReader(fileInputStream,"gbk");
				bufferedReader = new BufferedReader(inputStreamReader);
				String line = null;
				while ((line = bufferedReader.readLine()) != null){
					words.add(line);
				}
			
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}finally{
				try {
					bufferedReader.close();
					inputStreamReader.close();
					fileInputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

			getNodes( param, nodeList, linkList, words, hotWordList, perCount, retainCount,allCount,category);
		} catch (Exception e) {
			e.printStackTrace();
		}
	

		
		Grid grid = new Grid();
		grid.setAaData(hotWordList);
		grid.setLinks(linkList);
		grid.setNodes(nodeList);
		return grid;
	}
	/**
	 * 获得查询的字符串
	 * 写的很烂，但是懒得改
	 * @param searchKeyWord
	 * @param searchInfo
	 * @param page 分页参数
	 * @return
	 */
	private String getSearchString(String searchKeyWord,String content, String searchInfo, int perCount) {
		StringBuilder searchBuilder = new StringBuilder();
		searchBuilder.append("{\"query\":{")
		.append("\"filtered\":{");
		//关键字匹配
		if(searchKeyWord == null || "".equals(searchKeyWord)){
			searchBuilder.append("\"query\":{")
			.append("\"match_all\":{}")
			.append("},");
		}else{
			if("双方对话".equals(content)){
				searchBuilder.append("\"query\":{")
				.append("\"term\":{\"transData.allContent\":\"")
				.append(searchKeyWord)
				.append("\"}},");
			}else if("坐席".equals(content)){
				searchBuilder.append("\"query\":{")
				.append("\"term\":{\"transData.agentContent\":\"")
				.append(searchKeyWord)
				.append("\"}},");
			}else if("客户".equals(content)){
				searchBuilder.append("\"query\":{")
				.append("\"term\":{\"transData.userContent\":\"")
				.append(searchKeyWord)
				.append("\"}},");
			}
		}
		searchBuilder.append("\"filter\":[")
		.append("{")
		.append("\"bool\":{");
		StringBuilder mustBuilder = new StringBuilder();
		mustBuilder.append("\"must\":[");

	//遍历拼接查询语句
	JSONArray searchArray = JSONArray.parseArray(searchInfo);
	JSONObject searchI = null;
	for(int i=0; i< searchArray.size(); i++) {
		searchI = searchArray.getJSONObject(i);
		
		if(searchI.getString("field") == null || "".equals(searchI.getString("field")) ||
				searchI.getString("type") == null || "".equals(searchI.getString("type"))) {
			continue;
		}
	if("2".equals(searchI.getString("type")) ||
			"5".equals(searchI.getString("type")) ||
			"6".equals(searchI.getString("type"))){
		if((searchI.getString("minValue") == null || "".equals(searchI.getString("minValue"))) &&
				(searchI.getString("maxValue") == null || "".equals(searchI.getString("maxValue")))) {
			continue;
		}
		//range字符串
		StringBuilder rangeBuilder = new StringBuilder();
		rangeBuilder.append("{\"range\":{");
		rangeBuilder.append("\"")
						.append(searchI.getString("field"))
						.append("\":{")
						.append(getRangeString(searchI.getString("type"), 
								searchI.getString("minValue"), searchI.getString("maxValue")))
						.append("}");
		//处理range字符串
		if(rangeBuilder.charAt(rangeBuilder.length() - 1) == ',') {
			rangeBuilder.deleteCharAt(rangeBuilder.length() - 1);
		}
		rangeBuilder.append("}")
						.append("},");
		mustBuilder.append(rangeBuilder.toString());
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
	//处理must字符串
	if(mustBuilder.charAt(mustBuilder.length() - 1) == ',') {
		mustBuilder.deleteCharAt(mustBuilder.length() - 1);
	}
	mustBuilder.append("]");
	searchBuilder.append(mustBuilder.toString());

	searchBuilder.append("}")
					.append("}")
					.append("]")
					.append("}")
					.append("},");

				searchBuilder.append("\"size\":0,")
				.append("\"aggregations\":{")
				.append("\"significantWords\":{")
				.append("\"significant_terms\": {")
				.append("\"field\":");
				if("双方对话".equals(content)){
					searchBuilder.append("\"transData.allContent\",");

				}else if("坐席".equals(content)){
					searchBuilder.append("\"transData.agentContent\",");
				}else if("客户".equals(content)){
					searchBuilder.append("\"transData.userContent\",");
				}
				searchBuilder.append("\"size\":")
				.append(perCount);
				searchBuilder.append("}}}}");
				
				return searchBuilder.toString();
			}
	public static String getShouldString(String s, String field, Boolean flag) {
		String[] valueArray = s.split(",");
		
		StringBuilder sb = new StringBuilder();
		for(int i=0; i<valueArray.length; i++) {
			if(flag) {
				sb.append(getRegexpString(field, valueArray[i].replace("×", "")));
			} else {
				sb.append(getTermString(field, valueArray[i].replace("×", "")));
			}
		}
		
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
				return "\"" + value + "\"";//" 00:00:00||+1d\"";
			} else {
				return "\"" + value + "\"";//" 00:00:00\"";
			}
		} else if("6".equals(type)) {
			return String.valueOf(Double.parseDouble(value) * 60 * 1000);
		} else {
			return "";
		}
	}
	
}
