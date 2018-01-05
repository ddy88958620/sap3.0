package com.hcicloud.sap.service.inspection;

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
import com.hcicloud.sap.model.admin.UserRoleRelation;
import com.hcicloud.sap.model.quality.ArtificalItem;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.quality.InspectorModel;
import com.hcicloud.sap.pagemodel.voice.VoiceModel;

@Service
public class InspectionServiceImpl implements InspectionServiceI {
	@Autowired
	BaseDaoI<ArtificalItem> itemDao;
	@Autowired
	private BaseDaoI<String> userIdDao;

	@Override
	public Grid dataGrid(String uuid, PageFilter page,String startTime,String endTime,String status,String userGroupId) {
		List<VoiceModel> voiceList = new ArrayList<VoiceModel>();
		
		long totalCountFromIndexServer = 0;
		try {
			String searchString = null;
			searchString = getSearchString(uuid,status,page,startTime,endTime,userGroupId);
			JSONObject result = ESMethod.find("*", searchString);
			JSONArray voiceJson = result.getJSONArray("voices");
			totalCountFromIndexServer = Long.valueOf(result.getLongValue("total"));
			for (int i=0;i<voiceJson.size();i++) {
			    JSONObject v = voiceJson.getJSONObject(i);
		        VoiceModel voice = JSON2Voice(v,null);
                voiceList.add(voice);
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
	 * 
	 * @param uuid 当前登录人ID
	 * @param qualityStatus 质检状态
	 * @param page 分页
	 * @param startTime 来电开始时间
	 * @param endTime 来电结束时间
	 * @return
	 */
	private String getSearchString(String uuid, String qualityStatus, PageFilter page,String startTime,String endTime,String userGroupId) {
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
						.append("\"manualData.isChecked\"")
						.append("],");
		
		searchBuilder.append("\"query\":{")
						.append("\"filtered\":{")
						.append("\"filter\":[")
						.append("{")
						.append("\"bool\":{");
		
		//must及should字符串
		StringBuilder mustBuilder = new StringBuilder();
		mustBuilder.append("\"must\":[");
		int flagRangeNumber = 0;
		//查询状态为已分配的工单
		mustBuilder.append(getTermString("manualData.isAssigned", GlobalConstant.ALREADY_ASSIGNED));
		if(!"全部".equals(qualityStatus)){
			mustBuilder.append(getTermString("manualData.isChecked", qualityStatus));
		}
		/**
		 * 如果是业务管理员(roleId为1)，则可以看到同组质检结果；
		 * 如果是质检员(roleId为2),只能看到自己质检的结果；
		 * 如果是坐席(roleId为3),只能看到自己被质检的结果
		 */
		//质检员只能看到分配给自己的录音
		mustBuilder.append(getTermString("manualData.inspectorId", uuid));
		/*String roleCode = getRoleCode(uuid);
		if(roleCode.indexOf("1")!=-1){
			mustBuilder.append(getTermString("userGroupId", userGroupId));
		}else if(roleCode.indexOf("2")!=-1){
			mustBuilder.append(getTermString("manualData.inspectorId", uuid));
		}else if(roleCode.indexOf("3")!=-1){
			mustBuilder.append(getTermString("relateData.userId", uuid));
		}*/
		StringBuilder rangeBuilder = new StringBuilder();
		rangeBuilder.append("{\"range\":{");
		//来电开始时间匹配
		if(startTime != null && !"".equals(startTime)) {
			rangeBuilder
						.append("\"relateData.callTime\":{")
						.append("\"gte\":")
						.append("\"")
						.append(startTime)
						.append("\"")
						.append("},");
			flagRangeNumber++;
		}
		//结束时间匹配
		if(endTime != null && !"".equals(endTime)) {
			rangeBuilder
						.append("\"relateData.callTime\":{")
						.append("\"lte\":")
						.append("\"")
						.append(endTime)
						.append("\"")
						.append("},");
			flagRangeNumber++;
		}
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
	                        .append("\"")
	                        .append("}},");
		//分页
		searchBuilder.append("\"from\":")
						.append(page.getiDisplayStart())
						.append(",");
		searchBuilder.append("\"size\":")
						.append(page.getiDisplayLength());
		searchBuilder.append("}");
		return searchBuilder.toString();
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
	
	/**
     * @Description 该方法将查到的json格式索引数据转换成可显示的Voice数据
     * @param json
     * @return
     */
    public static VoiceModel JSON2Voice(JSONObject json,JSONObject highObject) {
        VoiceModel voice = new VoiceModel();
        voice.setUuid(json.getString("UUID"));
        voice.setCallTime(json.getJSONObject("relateData").getString("callTime"));
        JSONObject transJsonObject = json.getJSONObject("transData");
        JSONObject relateJsonObject = json.getJSONObject("relateData");
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if(relateJsonObject.getDate("analysisTime")!=null){
        	voice.setAnalysisTime(sdf.format(relateJsonObject.getDate("analysisTime")));
        }
        voice.setAni(relateJsonObject.getString("ani"));
        voice.setDnis(relateJsonObject.getString("dnis"));
        JSONObject manualDataObject = json.getJSONObject("manualData");
        if(manualDataObject!=null)
        voice.setInspectionStatus(manualDataObject.getString("isChecked"));
        Integer time = transJsonObject.getInteger("duration");
        voice.setDuration(time);
        if(time!=null){
        	voice.setDurationStr(DateConversion.formatTime(Long.valueOf(time)));
        }else{
        	voice.setDurationStr("0");
        }
        Integer timeSilence = transJsonObject.getInteger("silenceDuration");
        if(timeSilence!=null){
        	voice.setSilenceDurationStr(DateConversion.formatTime(Long.valueOf(timeSilence)));
        }else{
        	voice.setSilenceDurationStr("0");
        }
        return voice;
    }
    
    /**
     * 查询所有质检规则
     * @param page 分页
     * @return
     */
	@Override
	public List<ArtificalItem> findRules(PageFilter page) {
		String hql = " from ArtificalItem ";
		List<ArtificalItem> dataList = itemDao.find(hql,null,page.getiDisplayStart(),page.getiDisplayLength());
		return dataList;
	}
	
	/**
	 * 根据uuid查询工单基本信息
	 * @param id
	 * @return
	 */
	@Override
	public Json getInfoById(String id) {
		Json json = new Json();
		/*String type=id.split("\\|")[3].split("-")[0]+"-"+id.split("\\|")[3].split("-")[1];
		JSONObject jsonObject = ESMethod.get(type, id);*/
		JSONObject jsonObject = CommonMethod.getVoiceInfo(id);
		JSONObject transObject = jsonObject.getJSONObject("transData");
		Integer time = transObject.getInteger("duration");
		//格式化时长
		if(time!=null){
			transObject.put("duration", DateConversion.formatTime(Long.valueOf(time)));
		}
		Integer timeSilence = transObject.getInteger("silenceDuration");
		if(timeSilence!=null){
			transObject.put("silenceDuration", DateConversion.formatTime(Long.valueOf(timeSilence)));
		}
		json.setSuccess(true);
		json.setObj(jsonObject);
		return json;
	}
	
	/**
	 * 质检操作
	 * @param id
	 * @param content
	 * @param generalNum
	 * @param seriousNum
	 * @param score
	 * @return
	 */
	@Override
	public Json inspect(String id, String content, int generalNum,
			int seriousNum, int score) {
		Json json = new Json();
		try{
			List<String> dataList = new ArrayList<String>();
			String type = StringUtil.dateToString(new Date(), "yyyy-MM");
			/*String type=id.split("\\|")[3].split("-")[0]+"-"+id.split("\\|")[3].split("-")[1];
			JSONObject jsonObject = ESMethod.get(type, id);*/
			JSONObject jsonObject = CommonMethod.getVoiceInfo(id);
			JSONObject manualObject = jsonObject.getJSONObject("manualData");
			JSONObject resultObject = new JSONObject();
			resultObject.put("content", content);
			resultObject.put("generalNum", generalNum);
			resultObject.put("seriousNum", seriousNum);
			resultObject.put("score", score);
			manualObject.put("inspectResult", resultObject);
			manualObject.put("isChecked", GlobalConstant.HAVE_QUALITY_INSPECTION);
			jsonObject.put("manualData", manualObject);
			dataList.add(jsonObject.toJSONString());
			ESMethod.indexBatch(type, dataList);
			json.setSuccess(true);
		}catch(Exception e){
			e.printStackTrace();
		}
		return json;
	}
	
	/**
	 * 获取质检员列表
	 * @param userRole
	 * @param ph
	 * @return
	 */
	public String getRoleCode(String uuid) {
		String hql = "select t.roleId from UserRoleRelation t where t.userId = :userId ";
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userId", uuid);
		List<String> list = this.userIdDao.find(hql,paramMap);
		String code = "";
		if(list!=null){
			for(String id :list){
				code += String.valueOf(id)+"";
			}
		}
		return code;
	}
}
