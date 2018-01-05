package com.hcicloud.sap.service.task;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.constant.GlobalConstant;
import com.hcicloud.sap.common.network.ESMethod;
import com.hcicloud.sap.common.utils.CommonMethod;
import com.hcicloud.sap.common.utils.DateConversion;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.common.utils.StringUtil;
import com.hcicloud.sap.dao.BaseDaoI;
import com.hcicloud.sap.model.admin.User;
import com.hcicloud.sap.model.admin.UserRoleRelation;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.quality.InspectorModel;
import com.hcicloud.sap.pagemodel.voice.VoiceModel;

@Service
public class TaskAssignServiceImpl implements TaskAssignServiceI{
	@Autowired
	private BaseDaoI<UserRoleRelation> userRoleDao;
	@Autowired
	private BaseDaoI<User> userDao;
	@Autowired
	private BaseDaoI<Long> userIdDao;
	@Autowired
	private BaseDaoI<InspectorModel> inspectorDao;
	
	@Override
	public Grid dataGrid(String startTime, String endTime, String status,VoiceModel paramVoice, PageFilter paramPageFilter,String userGroupId) {
		
		return dataGridFromIndexServer(startTime,endTime,status,paramVoice, paramPageFilter, userGroupId);
	}

	private Grid dataGridFromIndexServer(String startTime ,String endTime ,String status ,VoiceModel paramVoice, PageFilter ph,String userGroupId) {
		List<VoiceModel> voiceList = new ArrayList<VoiceModel>();
		long totalCountFromIndexServer = 0;
		try {
			String searchString = null;
			if(!"".equals(paramVoice.getSearchInfo())) {
				searchString = getSearchString(startTime, endTime, status, paramVoice.getSearchInfo(), ph,userGroupId);
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
	 * 获取查询的字符串
	 * @param searchKeyWord
	 * @param searchInfo
	 * @param ph
	 * @return
	 */
	private String getSearchString(String startTime, String endTime, String isChecked, String searchInfo, PageFilter ph,String userGroupId) {
		StringBuilder searchBuilder = new StringBuilder();
		searchBuilder.append("{\"_source\":[")
						.append("\"UUID\",")
						.append("\"relateData.ani\",")
						.append("\"relateData.dnis\",")
						.append("\"relateData.analysisTime\",")
						.append("\"relateData.callTime\",")
						.append("\"transData.duration\",")
						.append("\"transData.silenceDuration\",")
						.append("\"relateData.userName\",")
						.append("\"transData.silencePercent\",")
						.append("\"manualData.isChecked\",")
						.append("\"manualData.isAssigned\",")
						.append("\"manualData.inspectorId\",")
						.append("\"manualData.inspectorName\"")
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
				rangeBuilder.append("{\"range\":");
				int flagRangeNumber = 0;
		//拼接未质检的必须条件
		mustBuilder.append(getTermString("manualData.isChecked", "未质检"));
		//分配状态匹配
		if(isChecked != null && !"".equals(isChecked) && !"全部".equals(isChecked)) {
			mustBuilder.append(getTermString("manualData.isAssigned", isChecked));
		}
		//用户组id匹配 -1代表所有人都可以查看
		if(userGroupId != null && !"".equals(userGroupId)) {
			mustBuilder.append(getTermString("userGroupId", userGroupId));
			//mustBuilder.append(getMustTermsString(userGroupId+",-1", "userGroupId"));
		}
		//来电开始时间匹配
		if(startTime != null && !"".equals(startTime)) {
			rangeBuilder
						.append("{\"relateData.callTime\":{")
						.append("\"gte\":")
						.append("\"")
						.append(startTime)
						.append("\"")
						.append("}")
						.append("}")
						.append("},");
			flagRangeNumber++;
		}
		//结束时间匹配
		if(endTime != null && !"".equals(endTime)) {
			rangeBuilder
						.append("{\"range\":")
						.append("{\"relateData.callTime\":{")
						.append("\"lte\":")
						.append("\"")
						.append(endTime)
						.append("\"")
						.append("}")
						.append("}")
						.append("},");
			flagRangeNumber++;
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
				rangeBuilder.append("{\"range\":")
				.append("{\"")
				.append(searchI.getString("field"))
				.append("\":{")
				.append(getRangeString(searchI.getString("type"), 
						searchI.getString("minValue"), searchI.getString("maxValue")))
				.append("}")
				.append("}")
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
			
			
		
		
		//处理range字符串
		if(rangeBuilder.charAt(rangeBuilder.length() - 1) == ',') {
			rangeBuilder.deleteCharAt(rangeBuilder.length() - 1);
		}
		
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
		
		searchBuilder.append(mustBuilder.toString());
		searchBuilder.append("}")
						.append("}")
						.append("]")
						.append("}")
						.append("},");
		
	  //排序
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
		//分页
		searchBuilder.append("\"from\":")
						.append(ph.getiDisplayStart())
						.append(",");
		
		searchBuilder.append("\"size\":")
						.append(ph.getiDisplayLength());
		
		searchBuilder.append("}");
		
		return searchBuilder.toString();
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
	public static String getShouldString(String s, String field, Boolean flag) {
		String[] valueArray = s.split(",");
		
		StringBuilder sb = new StringBuilder();
		for(int i=0; i<valueArray.length; i++) {
			if(flag) {
				sb.append(getRegexpString(field, valueArray[i]));
			} else {
				sb.append(getTermString(field, valueArray[i]));
			}
		}
		
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
	
	/**
	 * 将返回的json数据转换为可视的voice数据
	 * @param json
	 * @param highObject
	 * @return
	 */
	public static VoiceModel JSON2Voice(JSONObject json,JSONObject highObject) {
		VoiceModel voice = new VoiceModel();
		JSONObject transJsonObject = json.getJSONObject("transData");
        JSONObject relateJsonObject = json.getJSONObject("relateData");
        JSONObject manualJsonObject = json.getJSONObject("manualData");
        voice.setUuid(json.getString("UUID"));
        voice.setCallTime(relateJsonObject.getString("callTime"));
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if(relateJsonObject.getDate("analysisTime")!=null){
        	voice.setAnalysisTime(sdf.format(relateJsonObject.getDate("analysisTime")));
        }
        voice.setUserName(relateJsonObject.getString("userName"));
        voice.setAni(relateJsonObject.getString("ani"));
        voice.setDnis(relateJsonObject.getString("dnis"));
        voice.setAssignStatus(manualJsonObject.getString("isAssigned"));
        voice.setInspectorName(manualJsonObject.getString("inspectorName"));
        voice.setSilencePercent(transJsonObject.getDouble("silencePercent"));
        
        Integer time = transJsonObject.getInteger("duration");
        voice.setDuration(time);
        if(time!=null){
        	voice.setDurationStr(DateConversion.formatTime(Long.valueOf(time)));
        }else{
        	voice.setDurationStr("0");
        }
        Integer timeSilence = transJsonObject.getInteger("silenceDuration");
        voice.setSilenceDuration(timeSilence);
        if(timeSilence!=null){
        	voice.setSilenceDurationStr(DateConversion.formatTime(Long.valueOf(timeSilence)));
        }else{
        	voice.setSilenceDurationStr("0");
        }
		return voice;
		
	}

	/**
	 * 获取质检员列表
	 * @param userRole
	 * @param ph
	 * @return
	 */
	@Override
	public List<InspectorModel> inspectorGrid(UserRoleRelation userRole, PageFilter ph,String userGroupId) {
		String hql = "select t.userId from UserRoleRelation t where t.roleId = :roleId ";
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("roleId", "2");
		List<Long> list = this.userIdDao.find(hql,paramMap);
		String hqlUser = "select new com.hcicloud.sap.pagemodel.quality.InspectorModel(t.uuid,t.name,t.loginName)"
				+ " from User t where t.isDelete <> '1' and t.uuid in(:IdList) and t.userGroup.uuid = :userGroupId and t.state = 1 order by t.uuid";
		paramMap.clear();
		paramMap.put("IdList", list);
		paramMap.put("userGroupId", userGroupId);
		List<InspectorModel> inspectorList = inspectorDao.find(hqlUser, paramMap,ph.getiDisplayStart(), ph.getiDisplayLength());
		return inspectorList;
	}

	/**
	 * 获取质检员总数
	 * @return
	 */
	@Override
	public long count(String userGroupId) {
		String hql = "select t.userId from UserRoleRelation t where t.roleId = :roleId ";
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("roleId", "2");
		List<Long> list = this.userIdDao.find(hql,paramMap);
		String hqlUser = "select count(*) "
				+ " from User t where t.isDelete <> '1' and t.uuid in(:IdList) and t.userGroup.uuid = :userGroupId and t.state = 1";
		paramMap.clear();
		paramMap.put("IdList", list);
		paramMap.put("userGroupId", userGroupId);
		long count = this.userIdDao.count(hqlUser, paramMap);
		return count;
	}

	/**
	 * 根据操作的工单id集合批量将状态置为不予分配
	 * @param ids
	 */
	@Override
	public void denyAssign(String ids) {
		//String type=ids.split("\\|")[3].split("-")[0]+"-"+ids.split("\\|")[3].split("-")[1];
		String type = StringUtil.dateToString(new Date(), "yyyy-MM");
		List<String> dataList = getJsonList(type, ids, GlobalConstant.NO_DISTRIBUTION,"");
		ESMethod.indexBatch(type, dataList);
	}

	/**
	 * 根据操作的工单id集合批量分配
	 * @param ids
	 * @param inspectorInfo
	 */
	@Override
	public void assignTask(String ids, String inspectorInfo) {
		/*String type=ids.split("\\|")[3].split("-")[0]+"-"+ids.split("\\|")[3].split("-")[1];*/
		String type = StringUtil.dateToString(new Date(), "yyyy-MM");
		List<String> dataList = getJsonList(type, ids, GlobalConstant.ALREADY_ASSIGNED,inspectorInfo);
		ESMethod.indexBatch(type, dataList);
	}
	
	/**
	 * 生成dataList
	 * @param type
	 * @param ids
	 * @param operation
	 * @param inspectorInfo
	 * @return
	 */
	public List<String> getJsonList(String type, String ids ,String operation,String inspectorInfo){
		
		String[] idsArr = ids.split(",");

			List<String> dataList = new ArrayList<String>();
			if(idsArr!=null){
				for(String id : idsArr){
					JSONObject jsonObject = ESMethod.get(type, id);
					//更新分配状态
					JSONObject manualObject = jsonObject.getJSONObject("manualData");
					manualObject.put("isAssigned", operation);
					//分配操作将质检员的ID更新至人工质检数据的inspectorId
					if(inspectorInfo!=null&&!"".equals(inspectorInfo)){
						String[] insInfo = inspectorInfo.split(",");
						manualObject.put("inspectorId", insInfo[0]);
						manualObject.put("inspectorName", insInfo[1]);
					}
					dataList.add(jsonObject.toJSONString());
				}
			}
			return dataList;
		} 
	
}