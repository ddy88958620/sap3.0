package com.hcicloud.sap.service.annoy.impl;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.tools.zip.ZipOutputStream;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.network.EsUtil;
import com.hcicloud.sap.common.network.HTTPMethod;
import com.hcicloud.sap.common.utils.AntZipUtil;
import com.hcicloud.sap.common.utils.CommonMethod;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.pagemodel.annoy.AnnoyGridData;
import com.hcicloud.sap.pagemodel.annoy.AnnoyModel;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.service.annoy.AnnoyService;
import com.hcicloud.sap.service.success.successService;
@Service
public class AnnoyServiceImpl implements AnnoyService {
	
	private String txtDir = this.getClass().getClassLoader().getResource("/")
			.getPath()
			+ "/doc/fsrTxt/";
	private String zipDir = this.getClass().getClassLoader().getResource("/")
			.getPath()
			+ "/doc/zip/";
	
	//骚扰种类
    private static HashMap<Integer,String> createMap(){
    	HashMap<Integer,String> map = new  HashMap<Integer,String>();
    	map.put(0,"正常");
    	map.put(1,"骚扰");
    	map.put(2,"敏感");
    	map.put(3,"拒绝");
    	return map;
    }

	/**
	 * 根据条件查询es
	 * @param model 查询条件
	 * @param ph 分页条件
	 * @return
	 * @throws Exception 
	 */
    @Override
	public Grid dataGrid(AnnoyModel model, PageFilter ph) throws Exception {
		String searchString = "{\"query\": {\"filtered\": {\"filter\": [{\"bool\": {\"must\": [";
		if(StringUtils.isNoneBlank(model.getStartTime()) && StringUtils.isNoneBlank(model.getEndTime()) ){
			searchString += "{\"range\":{\"CREATE_TIME\":{\"gte\":\""+model.getStartTime()+"\",\"lte\":\""+model.getEndTime()+"\"}}},";
		}	
		if(StringUtils.isNoneBlank(model.getAnnoyType())){
			searchString+="{\"term\":{\"ANNOY_TYPE\": \""+model.getAnnoyType()+"\"}},";
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
		if(StringUtils.isNoneBlank(model.getCallPhone())){
			searchString+="{\"term\":{\"CALL_PHONE\": \""+model.getCallPhone()+"\"}},";
		}
		if(StringUtils.isNoneBlank(model.getSeatAttitude())){
			searchString+="{\"term\":{\"SEAT_ATTITUDE\": \""+model.getSeatAttitude()+"\"}},";
		}
		
		//去掉最后一个 ‘，’
		if(searchString.endsWith(",")){
			searchString = searchString.substring(0, searchString.length()-1);		
		}
		searchString+="]}}]}},\"sort\": {\"CREATE_TIME\": {\"order\": \"desc\",\"ignore_unmapped\":true}},"
				+ "\"from\": "+ph.getiDisplayStart()+",\"size\": "+ph.getiDisplayLength()+"}";
		
		List<AnnoyGridData> list = new ArrayList<AnnoyGridData>();
		long total = 0l;
		try {
			String result = HTTPMethod.doPostQuery(EsUtil.getAnnoyQueryUrl(), searchString, 30000);
			System.out.println("这里是防骚扰查询url："+EsUtil.getAnnoyQueryUrl());
			System.out.println("这里是输出的是防骚扰查询ES语句：" + searchString);
			JSONObject resultObject = JSON.parseObject(result);
			JSONObject hitsObject = resultObject.getJSONObject("hits");
			total = (Integer) hitsObject.get("total");
			JSONArray hitsArray = hitsObject.getJSONArray("hits");
			for (Object v : hitsArray) {
				JSONObject jsonObject = ((JSONObject)v).getJSONObject("_source");
				AnnoyGridData annoyGridData = new AnnoyGridData();
				annoyGridData.setVoiceId(jsonObject.getString("VOICE_ID"));
				annoyGridData.setStaffId(jsonObject.getString("STAFF_ID"));
				annoyGridData.setVoicePath(jsonObject.getString("VOICE_PATH"));
				annoyGridData.setPlatForm(jsonObject.getString("PLAT_FORM"));
				annoyGridData.setAnnoyType(jsonObject.getString("ANNOY_TYPE"));
				annoyGridData.setSeatAttitude(jsonObject.getString("SEAT_ATTITUDE"));
				annoyGridData.setAnnoyHistoryType(jsonObject.getString("ANNOY_HISTORY_TYPE"));
				annoyGridData.setAnnoyWord(jsonObject.getString("ANNOY_WORD"));
				annoyGridData.setCallStartTime(jsonObject.getString("CALL_START_TIME"));
				annoyGridData.setCreateTime(jsonObject.getString("CREATE_TIME"));
				annoyGridData.setCallPhone(jsonObject.getString("CALL_PHONE"));
				//话者分离格式文本
				String transContent = jsonObject.getString("TRANS_CONTENT");
				if (StringUtils.isNotBlank(transContent)) {
					String callContent = CommonMethod.transContent(transContent);
					if (StringUtils.isNotBlank(callContent)) {
						annoyGridData.setCallContent(callContent);
					}else {
						annoyGridData.setCallContent(jsonObject.getString("CALL_CONTENT"));
					}					
				}else {
					annoyGridData.setCallContent(jsonObject.getString("CALL_CONTENT"));
				}
				
				list.add(annoyGridData);
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
	 * 统计防骚扰数据
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	public Grid countDataGrid(AnnoyModel model) throws Exception {
		//定义骚扰种类
	    HashMap<Integer,String> map = createMap();
		
		String searchString = "{\"size\":0,";
		if(StringUtils.isNoneBlank(model.getStartTime()) && StringUtils.isNoneBlank(model.getEndTime()) ){
			searchString += "\"query\":{\"range\":{\"CREATE_TIME\":{\"gte\":\""+model.getStartTime()+"\",\"lte\":\""+model.getEndTime()+"\"}}},";
		}	
		searchString += "\"aggs\":{\"platform\":{\"terms\":{\"field\":\"PLAT_FORM\"}}}}";
		
		
		String searchString2 = "{\"query\":{\"bool\":{\"must\":[{\"terms\":{\"ANNOY_TYPE\":[\"骚扰\",\"拒绝\",\"敏感\"]}}";
		if(StringUtils.isNoneBlank(model.getStartTime()) && StringUtils.isNoneBlank(model.getEndTime()) ){
			searchString2 += ",{\"range\":{\"CREATE_TIME\":{\"gte\":\""+model.getStartTime()+"\",\"lte\":\""+model.getEndTime()+"\"}}}";
		}	
		searchString2 += "]}},\"size\":0,\"aggs\":{\"platform\":{\"terms\":{\"field\":\"PLAT_FORM\"}}}}";
		
		//两次聚合实现骚扰分类+平台分类，2017年6月29日 17:03:34
		String searchString3 = "{";
		if(StringUtils.isNoneBlank(model.getStartTime()) && StringUtils.isNoneBlank(model.getEndTime()) ){
			searchString3 += "\"query\":{\"bool\":{\"must\":[{\"range\":{\"CREATE_TIME\":{\"gte\":\""+model.getStartTime()+"\",\"lte\":\""+model.getEndTime()+"\"}}}]}},";
		}	
		searchString3 += "\"size\":0,\"aggs\":{\"annoytype\":{\"terms\":{\"field\":\"ANNOY_TYPE\"},\"aggs\":{\"platform\":{\"terms\":{\"field\":\"PLAT_FORM\"}}}}}}";
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		try {
			String result = HTTPMethod.doPostQuery(EsUtil.getAnnoyQueryUrl(), searchString, 30000);
			System.out.println("访问骚扰总数的地址为"+EsUtil.getAnnoyQueryUrl()+"\n"+searchString2);
			String result2 = HTTPMethod.doPostQuery(EsUtil.getAnnoyQueryUrl(), searchString2, 30000);
			System.out.println("访问骚扰种类的地址为"+"\n"+EsUtil.getAnnoyQueryUrl()+"\n"+searchString3);
			String result3 = HTTPMethod.doPostQuery(EsUtil.getAnnoyQueryUrl(), searchString3, 30000);
			
			Map<String, Object> totalMap = new HashMap<String, Object>();
			Map<String, Object> annoyMap = new HashMap<String, Object>();
			
			
			
			JSONObject resultObject = JSON.parseObject(result);
			JSONObject aggregationsObject = resultObject.getJSONObject("aggregations");
			JSONObject platform = aggregationsObject.getJSONObject("platform");
			JSONArray jsonArray = platform.getJSONArray("buckets");
			
			for (Object v : jsonArray) {
				JSONObject object = (JSONObject)v;
				totalMap.put(object.getString("key"), object.getLong("doc_count"));
				
			}
			
			JSONObject hitsObject = resultObject.getJSONObject("hits");
			totalMap.put("total", hitsObject.getLong("total"));
			totalMap.put("name", "通话总数");
			
			JSONObject resultObject2 = JSON.parseObject(result2);
			JSONObject aggregationsObject2 = resultObject2.getJSONObject("aggregations");
			JSONObject platform2 = aggregationsObject2.getJSONObject("platform");
			JSONArray jsonArray2 = platform2.getJSONArray("buckets");
			
			for (Object v : jsonArray2) {
				JSONObject object = (JSONObject)v;
				annoyMap.put(object.getString("key"), object.getLong("doc_count"));
			}
			
			annoyMap.put("total", resultObject2.getJSONObject("hits").getLong("total"));
			annoyMap.put("name", "违规总数");
			
			//骚扰种类的分类，2017年6月29日 16:39:08
			JSONObject resultObject3 = JSON.parseObject(result3);
			JSONObject aggregationsObject3 = resultObject3.getJSONObject("aggregations");
			JSONObject annoytype = aggregationsObject3.getJSONObject("annoytype");
			JSONArray annoytypeBucketArray = annoytype.getJSONArray("buckets");
			
			for (Object v : annoytypeBucketArray) {
				Map<String, Object> annoyTypeMap = new HashMap<String, Object>();
				JSONObject object = (JSONObject)v;
				
				annoyTypeMap.put("total", object.getLong("doc_count"));
				annoyTypeMap.put("name", object.getString("key")+"总数");
				
				for(Integer in : map.keySet()){
					if(object.getString("key").equals(map.get(in))){
						map.remove(in);
						break;
					}
				}
				
				JSONObject platform3 = object.getJSONObject("platform");
				JSONArray jsonArray3 = platform3.getJSONArray("buckets");
				for (Object v1 : jsonArray3) {
					JSONObject object1 = (JSONObject)v1;
					annoyTypeMap.put(object1.getString("key"), object1.getLong("doc_count"));
				}
				list.add(annoyTypeMap);
			}
			
			for(String value : map.values()){
				Map<String, Object> annoyTypeMapNull = new HashMap<String, Object>();
				annoyTypeMapNull.put("name", value+"总数");
				list.add(annoyTypeMapNull);
			}
			
			
			list.add(annoyMap);
			list.add(totalMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		Grid grid = new Grid();
		grid.setAaData(list);
		grid.setiTotalDisplayRecords(list.size());
		grid.setiTotalRecords(list.size());
		return grid;
	}
	/**
	 * 导出防骚扰转译文本
	 */
	
	@Override
	public File getAnnoyFile(AnnoyModel model,PageFilter ph) {
		
		List<File> fileList = new ArrayList<File>();

		String searchString = "{\"query\": {\"filtered\": {\"filter\": [{\"bool\": {\"must\": [";
		if(StringUtils.isNoneBlank(model.getStartTime()) && StringUtils.isNoneBlank(model.getEndTime()) ){
			searchString += "{\"range\":{\"CREATE_TIME\":{\"gte\":\""+model.getStartTime()+"\",\"lte\":\""+model.getEndTime()+"\"}}},";
		}	
		if(StringUtils.isNoneBlank(model.getAnnoyType())){
			searchString+="{\"term\":{\"ANNOY_TYPE\": \""+model.getAnnoyType()+"\"}},";
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
		if(StringUtils.isNoneBlank(model.getCallPhone())){
			searchString+="{\"term\":{\"CALL_PHONE\": \""+model.getCallPhone()+"\"}},";
		}
		if(StringUtils.isNoneBlank(model.getSeatAttitude())){
			searchString+="{\"term\":{\"SEAT_ATTITUDE\": \""+model.getSeatAttitude()+"\"}},";
		}
		//去掉最后一个 ‘，’
		if(searchString.endsWith(",")){
			searchString = searchString.substring(0, searchString.length()-1);		
		}
		searchString+="]}}]}},\"sort\": {\"CREATE_TIME\": {\"order\": \"desc\",\"ignore_unmapped\":true}}," + "\"from\": "+ph.getiDisplayStart()+",\"size\": "+ph.getiDisplayLength()+"}";
	
		File dirFile = new File(txtDir);
		if (!dirFile.exists()) {
			dirFile.mkdirs();
		}
		
		long total = 0l;
		try {
			String result = HTTPMethod.doPostQuery(EsUtil.getAnnoyQueryUrl(), searchString, 30000);
			System.out.println("这里是防骚扰查询url："+EsUtil.getAnnoyQueryUrl());
			System.out.println("这里是输出的是防骚扰查询ES语句：" + searchString);
			JSONObject resultObject = JSON.parseObject(result);
			JSONObject hitsObject = resultObject.getJSONObject("hits");
			total = (Integer) hitsObject.get("total");
			JSONArray hitsArray = hitsObject.getJSONArray("hits");
			if (hitsArray == null || hitsArray.size() == 0) {
				System.out.println("无数据需要导出");
				return null;
			}
			
			for (Object v : hitsArray) {
				JSONObject jsonObject = ((JSONObject)v).getJSONObject("_source");
			    String voiceId = jsonObject.getString("VOICE_ID");
			    String transContent = jsonObject.getString("TRANS_CONTENT");
				String callContent ="";
				//创建文件
				File file = new File(txtDir + voiceId + ".txt");
				if (!file.exists()) {
					file.createNewFile();
				}
				fileList.add(file);
				
				//向文本中写入话者分离的内容
				
				
				
				 FileWriter fw = null;
		         BufferedWriter writer = null;
		         fw = new FileWriter(file);
		         writer = new BufferedWriter(fw);

		         
		         if (StringUtils.isNotBlank(transContent)) {
						callContent=transContent;
					
		          JSONArray contaArray =  JSONObject.parseArray(callContent);
		          for (int j = 0; j < contaArray.size(); ++j) {
		            JSONObject transObject = contaArray.getJSONObject(j);
		            String contentResult = transObject.getString("content");
		            
		            String talkertype = transObject.getString("talkertype");
		            if ((contentResult != null) && (!"".equals(contentResult))) {
		              String speakContent = contentResult.substring(0,contentResult.indexOf(";"));
		              String timeStamp = contentResult.substring(contentResult.indexOf(";time=") + 6, contentResult.length());
		              String[] timeStampArray = timeStamp.split(" ");
		              timeStamp = "[" +CommonMethod.secToTime((int)(Long.parseLong(timeStampArray[0]) / 1000L)) +  "]";
		              if (("".equals(speakContent)) ||  (speakContent == null)){
		            	  continue;
		              }
		              if ("1".equals(talkertype))
		              {
		                speakContent = timeStamp + "[客服]" + speakContent;
		              } else if ("2".equals(talkertype)) {
		                speakContent = timeStamp + "[用户]" + speakContent;
		              }
		              
		              writer.write(speakContent);
		              writer.newLine();
		            }
		          }
		         }else {
						callContent = jsonObject.getString("CALL_CONTENT");
						
						
						String[] split = callContent.split("☆");
						
						for (int i = 0; i < split.length; i++) {
							writer.write("☆"+split[i]);
				            writer.newLine();
						}
						
						  
		         }
		          
		          
		          
		          writer.flush();
		          writer.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		File zip = new File(zipDir);
		if (!zip.exists()) {
			zip.mkdirs();
		}

		File fileZip = new File(zipDir + "防骚扰转译数据.zip");
		// 文件输出流
		FileOutputStream outStream;
		try {
			outStream = new FileOutputStream(fileZip);
		
		// 压缩流
		ZipOutputStream toClient = new ZipOutputStream(outStream);
		toClient.setEncoding("gbk");
		AntZipUtil.zipFile(fileList, toClient);
		toClient.close();
		outStream.close();
		File zipFile = new File(txtDir);
		zipFile.delete();
		} catch (Exception e) {
			System.out.println("annoyServiceImpl输出压缩流失败");
			e.printStackTrace();
		}
		
		return fileZip;
	}
	
	
	
	
	
	
	
}
