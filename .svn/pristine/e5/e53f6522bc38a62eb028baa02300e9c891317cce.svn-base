package com.hcicloud.sap.service.voice;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.network.EsUtil;
import com.hcicloud.sap.common.network.HTTPMethod;
import com.hcicloud.sap.service.admin.SystemParamServiceI;

@Service
public class VoiceServiceImpl implements VoiceServiceI {
	private static Logger logger = Logger.getLogger(VoiceServiceImpl.class);
	@Autowired
	private SystemParamServiceI systemParamService;

	@Override
	public void getAudioStream(String id, String platForm,
			HttpServletRequest request, HttpServletResponse response) {
		// 1、获取文件的存储路径
		JSONObject documentObject = getVoiceById(id);
		String sysPlaytFormName = "platFormUrl";
		if (documentObject == null) {
			logger.error("文档缺失，ID:" + id);
			return;
		}
		/** -- 获取文件存储相对路径 -- */
		String pcmPath = documentObject.getString("PATH");
		
		// 2、从数据库获取playForm地址集合
		String platFormString = systemParamService.getParamSystemByName(sysPlaytFormName);
		JSONObject platFormJsonObject = JSON.parseObject(platFormString);
		String platFormUrl = platFormJsonObject.getString(platForm)+"/loadAudio/readFile";
		
	/*	platFormUrl="http://localhost:8080/SSM/file1";
		pcmPath="D:/voice/22222.pcm";*/
		
		//3、包装pcmPath为json格式
		JSONObject pathJsonObject = new JSONObject();
		pathJsonObject.put("path",pcmPath );
		pcmPath = pathJsonObject.toString();
		
		// 4、向平台发送请求
		System.out.println("平台地址"+platFormUrl);
		System.out.println("录音文件地址"+pcmPath);
		InputStream  inputStream =HTTPMethod.doPost(platFormUrl, pcmPath,3000);
		
		OutputStream outputStream = null;
		 try {	/** -- 输出文件至页面 -- */
				response.setContentType("application/octet-stream");
				
				outputStream = response.getOutputStream();
				 byte[]bytes=new byte[2048];
		         int numReadByte=0;
		         if (inputStream!= null) {
					System.out.println("返回值不为空");
				}else {
					System.out.println("返回流为空故异常");
				}
			     while((numReadByte=inputStream.read(bytes,0,bytes.length))>0)
			            {
			    	 outputStream.write(bytes, 0, numReadByte);
			            }			
				/** -- 确保输出完成-- */
			     outputStream.flush();
	        } catch(Exception ex) {
				ex.printStackTrace();
				return;
			} finally {
				if(inputStream != null) {
					try {
						inputStream.close();
					} catch (IOException e) {
				
						e.printStackTrace();
					}
				}
				if(outputStream != null) {
					try {
						outputStream.close();
					} catch (IOException e) {
					
						e.printStackTrace();
					}
				}
			}
		
	}

	/*
	 * 获取录音信息方法
	 * 
	 * @param uuid
	 * 
	 * @return
	 */
	private static JSONObject getVoiceById(String id) {
		StringBuilder searchBuilder = new StringBuilder();

		searchBuilder.append("{\"query\":{").append("\"filtered\":{")
				.append("\"query\":{").append("\"match\":{")
				.append("\"VOICE_ID\":\"").append(id).append("\"}}}}}");

		String queryContent = searchBuilder.toString();
		logger.warn("索引的find方法中");
		JSONObject finalResult = new JSONObject();
		try {
			String result = HTTPMethod.doPostQuery(EsUtil.getContentQueryUrl(),
					queryContent, 30000);
			JSONObject resultObject = JSON.parseObject(result);
			JSONObject hitsObject = resultObject.getJSONObject("hits");
			JSONArray hitsArray = hitsObject.getJSONArray("hits");
			JSONObject hits = hitsArray.getJSONObject(0);
			finalResult = hits.getJSONObject("_source");

			return finalResult;
		} catch (Exception e) {
			logger.error("索引的find方法中,出现异常：" + e.getMessage());
			e.printStackTrace();
			return finalResult;
		}
	}

	@Override
	public JSONObject getVoiceByCon(String id) {
		
		return getVoiceById(id);
	}
}
