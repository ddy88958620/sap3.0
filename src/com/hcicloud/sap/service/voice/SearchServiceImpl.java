package com.hcicloud.sap.service.voice;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.print.attribute.standard.Severity;

import net.sf.classifier4J.summariser.SimpleSummariser;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.network.ESMethod;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.dao.BaseDaoI;
import com.hcicloud.sap.model.admin.User;
import com.hcicloud.sap.model.admin.UserGroup;
import com.hcicloud.sap.model.quality.SearchInfo;
import com.hcicloud.sap.pagemodel.admin.UserModel;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.voice.VoiceModel;
import com.hcicloud.sap.service.quality.RulesServiceI;

@Service
public class SearchServiceImpl implements SearchServiceI {
	
	@Autowired
	private RulesServiceI rulesService;
	
	@Autowired
	private BaseDaoI<SearchInfo> searchInfoDao;
	
	private static SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	
	private static Logger logger = Logger.getLogger(SearchServiceImpl.class);

    @Override
    public Grid dataGrid(VoiceModel paramVoice, PageFilter paramPageFilter, String userId) {
        return dataGridFromIndexServer(paramVoice, userId, paramPageFilter);
    }
    
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
	
	/**
	 * 添加检索条件信息
	 * @param uuid
	 * @param searchInfoText
	 */
	@Override
	public void addSearchInfo(SearchInfo searchInfo) {
		searchInfo.setCreateTime(new Date());
		
		this.searchInfoDao.save(searchInfo);
	}
	
	/**
	 * 获取用户对应的高级检索信息
	 * @param uuid
	 * @return
	 */
	@Override
	public List<SearchInfo> getSearchInfo(SearchInfo searchInfo, PageFilter ph,String userId) {
		List<SearchInfo> searchInfoList = new ArrayList<SearchInfo>();
		
		String hql = "from SearchInfo  si where si.userId=:userId ";
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("userId", userId);
		
		 searchInfoList = this.searchInfoDao.find(hql, params, 
				ph.getiDisplayStart(), ph.getiDisplayLength());

		
		
		return searchInfoList;
	}
	
	public Long count(SearchInfo searchInfo, PageFilter pageFilter,String userId){
		String hql = "select count(*) from SearchInfo si where si.userId=:userId ";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		long count=this.searchInfoDao.count(hql, params);
		return count;
	}
    @Override
    public Json deleteSearchInfo(String uuid) {
        Json json = new Json();
        
               
        SearchInfo searchInfo = this.searchInfoDao.get(SearchInfo.class, uuid);
        this.searchInfoDao.delete(searchInfo);
        
        json.setSuccess(true);

        return json;
    }

    /**
     * 检索es
     * @param paramVoice
     * @param id
     * @param ph
     * @return
     */
	private Grid dataGridFromIndexServer(VoiceModel paramVoice, String id, PageFilter ph) {
		List<VoiceModel> voiceList = new ArrayList<VoiceModel>();
		
		long totalCountFromIndexServer = 0;
		try {
			String searchString = null;
			if(paramVoice.getSearchInfo() != null && !"".equals(paramVoice.getSearchInfo())) {
				searchString = getSearchString(paramVoice.getSearchKeyword(), paramVoice.getSearchInfo(), ph);
			}
			
			JSONObject result = ESMethod.find("*", searchString);
			JSONArray voiceJson = result.getJSONArray("voices");
			JSONArray highJson = result.getJSONArray("highlight");
			totalCountFromIndexServer = Long.valueOf(result.getLongValue("total"));
			for (int i=0;i<voiceJson.size();i++) {
			    JSONObject v = voiceJson.getJSONObject(i);
			    if(highJson!=null&&highJson.size()>0){
			        VoiceModel voice = JSON2Voice(v,highJson.getJSONObject(i));
	                voiceList.add(voice);
			    }else{
			        VoiceModel voice = JSON2Voice(v,null);
	                voiceList.add(voice);
			    }
			    
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		Grid grid = new Grid();
		grid.setAaData(voiceList);
		grid.setiTotalDisplayRecords(totalCountFromIndexServer);
		grid.setiTotalRecords(totalCountFromIndexServer);
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
	private String getSearchString(String searchKeyWord, String searchInfo, PageFilter page) {
		StringBuilder searchBuilder = new StringBuilder();
		searchBuilder.append("{\"_source\":[")
						.append("\"UUID\",")
						.append("\"relateData.userId\",")
						.append("\"relateData.ani\",")
						.append("\"relateData.dnis\",")
						.append("\"relateData.analysisTime\",")
						.append("\"relateData.callTime\",")
						.append("\"relateData.userName\",")
						.append("\"transData.silencePercent\",")
						.append("\"transData.duration\",")
						.append("\"transData.silenceDuration\",")
						.append("\"transData.speed\",")
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
		
		/*//range字符串
		StringBuilder rangeBuilder = new StringBuilder();
		rangeBuilder.append("{\"range\":{");*/
		//int flagRangeNumber = 0;
		
		//关键字匹配
		if(searchKeyWord != null && !"".equals(searchKeyWord)) {
		    searchKeyWord = searchKeyWord.replace("\"", "\\\"");
			mustBuilder.append("{\"simple_query_string\":{")
						.append("\"query\":\"")
						.append(searchKeyWord)
						.append("\",")
						.append("\"fields\":")
						.append("[\"transData.allContent\"]")
						.append("}},");
		}
		
		//遍历拼接查询语句
		JSONArray searchArray = JSONArray.parseArray(searchInfo);
		JSONObject searchI = null;
		
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
				//flagRangeNumber++;
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
				//shouldBuilder.append(getShouldString(searchI.getString("equalValue"), searchI.getString("field"), true));
				
				//flagShouldNumber += searchI.getString("equalValue").split(",").length;
			}
			
			//枚举类型
			if("3".equals(searchI.getString("type"))) {
				if(searchI.getString("equalValueText") == null || "".equals(searchI.getString("equalValueText"))) {
					continue;
				}
				mustBuilder.append(getMustTermsString(searchI.getString("equalValueText"), searchI.getString("field")));
				//shouldBuilder.append(getShouldString(searchI.getString("equalValueText"), searchI.getString("field"), false));
				
				//flagShouldNumber += searchI.getString("equalValueText").split(",").length;
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
		
		//高亮
		searchBuilder.append("\"highlight\":{")
						.append("\"fields\":{")
						.append("\"")
						.append("transData.allContent")
						.append("\":{")
						.append("\"no_match_size\": 150}}},");
		//排序
		if(!(searchArray.size()==0&&searchKeyWord != null && !"".equals(searchKeyWord))){
			searchBuilder.append("\"sort\":{")
			.append("\"")
			.append("relateData.callTime")
			.append("\":{")
			.append("\"order\":\"")
			.append("desc")
			.append("\",")
			.append("\"ignore_unmapped\":")
			.append("true")
			.append("}},");
		}
		
		//分页
		searchBuilder.append("\"from\":")
						.append(page.getiDisplayStart())
						.append(",");
		
		searchBuilder.append("\"size\":")
						.append(page.getiDisplayLength());
		
		searchBuilder.append("}");
		
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
	
	/**
     * @Description 该方法将查到的json格式索引数据转换成可显示的Voice数据
     * @param json
     * @return
     */
    public static VoiceModel JSON2Voice(JSONObject json,JSONObject highObject) {
        VoiceModel voice = new VoiceModel();
        voice.setUuid(json.getString("UUID"));
        voice.setUserName(json.getString("userId"));
        JSONObject transJsonObject = json.getJSONObject("transData");
        JSONObject relateJsonObject = json.getJSONObject("relateData");
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if(relateJsonObject.getDate("analysisTime")!=null){
        	voice.setAnalysisTime(sdf.format(relateJsonObject.getDate("analysisTime")));
        }
        voice.setUserName(relateJsonObject.getString("userName"));
        voice.setCallTime(relateJsonObject.getString("callTime"));
        voice.setAni(relateJsonObject.getString("ani"));
        voice.setDnis(relateJsonObject.getString("dnis"));
        voice.setDuration(transJsonObject.getInteger("duration"));
        voice.setSilenceDuration(transJsonObject.getInteger("silenceDuration"));
        voice.setSilencePercent(transJsonObject.getDouble("silencePercent"));
        voice.setSpeed(transJsonObject.getDouble("speed"));
        //获取摘要
        String allContent = "";
        if(highObject!=null){
            allContent = highObject.getJSONArray("transData.allContent").getString(0);
        }else{
            allContent = transJsonObject.getString("allContent");
        }
        int num = getIdolNum(allContent);
        String remark = null;
        if(num<10){//10句以上的只取前十句
        	  remark =new SimpleSummariser().summarise(allContent, num);
        }else{
        	  remark =new SimpleSummariser().summarise(allContent, 10);
        }
        
      
        voice.setRemark(remark);
        return voice;
    }

    /**
     * 获取字符串中含句号的个数
     * @param allContent
     * @return
     */
    public static int getIdolNum(String allContent){
    	if(allContent == null || allContent.length()==0){
    		return 0;
    	}
    	int count = 0;
        char[]  chars = allContent.toCharArray();
        
        for(char c:chars){
        	if ( c=='。') {
				count++;
			}
        }
        return count;
    }
    
    // 排序方法
    class SortVoice implements Comparator<VoiceModel> {
    	@Override
    	public int compare(VoiceModel v1, VoiceModel v2) {
    		if (v1.getCallTime() != null && v2.getCallTime() != null) {
    			return v1.getCallTime().compareTo(v2.getCallTime());
    		} else if (v1.getAnalysisTime() != null && v2.getAnalysisTime() != null) {
    			return v1.getAnalysisTime().compareTo(v2.getAnalysisTime());
    		} else
    		{
    			return v1.getFileNo().compareTo(v2.getFileNo());
    		}
    	}
    }

    /**
     * 获取录音信息
     * @param uuid
     * @return
     */
    @Override
    public JSONObject getVoiceInfo(String uuid) {
        StringBuilder searchBuilder = new StringBuilder();
        searchBuilder.append("{\"_source\":[")
                        .append("\"qualityData\"")
                        .append("],");
        searchBuilder.append("\"query\":{")
                        .append("\"filtered\":{")
                        .append("\"query\":{")
                        .append("\"match\":{")
                        .append("\"UUID\":\"")
                        .append(uuid)
                        .append("\"}}}}}");
        JSONObject resultJObject = ESMethod.find("*", searchBuilder.toString());
        JSONObject voiceObject = resultJObject.getJSONArray("voices").getJSONObject(0);
        JSONObject qualityObject = voiceObject.getJSONObject("qualityData");
        return qualityObject;
    }
	/**
	 * 查询检索名称是否存在
	 */
	public  Json checkSearchInfo(String name){
		Json json = new Json();
		String hql="from SearchInfo s where s.name='"+name+"'";
		List<SearchInfo> searchInfo =searchInfoDao.find(hql);
		if(searchInfo.size()>0){
			json.setObj("1");
			json.setMsg("检索名称已存在");
		}else{
			json.setObj("0");
		}
		return json;
	}
}
