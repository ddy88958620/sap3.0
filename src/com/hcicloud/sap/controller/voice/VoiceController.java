package com.hcicloud.sap.controller.voice;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.constant.GlobalConstant;
import com.hcicloud.sap.common.network.ESMethod;
import com.hcicloud.sap.common.utils.PropertiesLoader;
import com.hcicloud.sap.common.utils.StringUtil;
import com.hcicloud.sap.common.utils.SystemParamUtil;
import com.hcicloud.sap.controller.base.BaseController;
import com.hcicloud.sap.model.quality.SearchInfo;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.base.SessionInfo;
import com.hcicloud.sap.service.admin.SystemParamServiceI;
import com.hcicloud.sap.service.voice.VoiceServiceI;

@Controller
@RequestMapping({ "/voice" })
public class VoiceController extends BaseController {
	private static Logger logger = Logger.getLogger(VoiceController.class);
	@Autowired
	private VoiceServiceI voiceServiceI;
	
	/**
	 * 通过url请求返回文件字节流
	 * @param id
	 * @param request
	 * @param response
	 */
    @RequestMapping("/play")
    public void loadAudioStream(String id, HttpServletRequest request, HttpServletResponse response) {
    	//String type=id.split("\\|")[3].split("-")[0]+"-"+id.split("\\|")[3].split("-")[1];
        /** -- 获取文档 -- */
    	//JSONObject documentObject = ESMethod.get(type, id);
    	JSONObject documentObject = getVoiceInfo(id);
        
        if(documentObject == null) {
        	logger.error("文档缺失，ID:" + id);
        	return;
        }
        
        /** -- 获取文件存储相对路径 -- */
        String relateData = documentObject.getString("relateData");
		JSONObject relateObject = JSONObject.parseObject(relateData);
		
		String pcmPath = relateObject.getString("path");
		
		/** -- 获取文件存储路径前缀 -- */
		//PropertiesLoader pLoader = new PropertiesLoader("system.properties");
        String pcmDir = SystemParamUtil.getValueByName("pcm_dir");//pLoader.getProperty("pcm_dir");

        /** -- 文件存储路径 -- */
        String path = pcmDir + pcmPath;
        
        /** -- 读取文件 -- */
        File file = new File(path);
        if(!file.exists() && !file.canRead()) {
        	logger.error("文件不存在或者不可读，ID:" + id);
        	return;
        }
        
        /** -- 输出到页面 -- */
        FileInputStream inputStream = null;
        OutputStream outputStream = null;
		try {
			/** -- 读取文件至内存 -- */
			inputStream = new FileInputStream(file);
			byte[] data = new byte[(int)file.length()];
			inputStream.read(data);
			
			/** -- 输出文件至页面 -- */
			response.setContentType("application/octet-stream");
			response.setContentLength(data.length);
			
			outputStream = response.getOutputStream();
			outputStream.write(data);
			outputStream.flush();
		} catch(Exception ex) {
			logger.error("输出录音文件错误,错误信息:" + ex.getMessage());
			ex.printStackTrace();
			return;
		} finally {
			if(inputStream != null) {
				try {
					inputStream.close();
				} catch (IOException e) {
					logger.error("关闭输入流失败,ID:" + id + " - 错误信息:" + e.getMessage());
					e.printStackTrace();
				}
			}
			if(outputStream != null) {
				try {
					outputStream.close();
				} catch (IOException e) {
					logger.error("关闭输出流失败,ID:" + id + " - 错误信息:" + e.getMessage());
					e.printStackTrace();
				}
			}
		}
    }
    /**
     * 通过url请求返回文件字节流
     * @param id
     * @param response
     */
    @RequestMapping("/queryTrans")
	public void loadXML(String id, HttpServletResponse response) {
    	//String type=id.split("\\|")[3].split("-")[0]+"-"+id.split("\\|")[3].split("-")[1];
    	/** -- 获取文档 -- */
    	//JSONObject documentObject = ESMethod.get(type, id);
    	
    	//JSONObject documentObject = getVoiceInfo(id);
    	JSONObject documentObject =voiceServiceI.getVoiceByCon(id);
        if(documentObject == null) {
        	logger.error("文档缺失，ID:" + id);
        	return;
        }
        
        /** -- 获取XML文件信息-- */
        String xmlData = documentObject.getString("xmlData");
        
        /** -- 输出到页面 -- */
        OutputStream outputStream = null;
		try {
			byte[] data = xmlData.getBytes("UTF-8");
			
			/** -- 输出XML文件信息至页面 -- */
			response.setContentType("text/xml; charset=UTF-8" );
			response.setHeader("Cache-Control", "no-cache" );
			
			outputStream = response.getOutputStream();
			outputStream.write(data);
			outputStream.flush();
		} catch(Exception ex) {
			logger.error("输出XML文件信息错误,错误信息:" + ex.getMessage());
			ex.printStackTrace();
			return;
		} finally {
			if(outputStream != null) {
				try {
					outputStream.close();
				} catch (IOException e) {
					logger.error("关闭输出流失败,ID:" + id + " - 错误信息:" + e.getMessage());
					e.printStackTrace();
				}
			}
		}
	}
    
    @RequestMapping("/playRecord")
    public void getAudioStream(String id, String platForm,HttpServletRequest request, HttpServletResponse response) {
    	 voiceServiceI.getAudioStream(id, platForm, request, response);
    }
    
    
    
    /**
     * 获取录音信息
     * @param uuid
     * @return
     */
    private static JSONObject getVoiceInfo(String uuid) {
        StringBuilder searchBuilder = new StringBuilder();
        searchBuilder.append("{\"query\":{")
                        .append("\"filtered\":{")
                        .append("\"query\":{")
                        .append("\"match\":{")
                        .append("\"UUID\":\"")
                        .append(uuid)
                        .append("\"}}}}}");
        JSONObject resultJObject = ESMethod.find("*", searchBuilder.toString());
        JSONArray voiceJObject = resultJObject.getJSONArray("voices");
        return voiceJObject.getJSONObject(0);
    }
    
    public static void main(String[] args) {
    	getVoiceInfo("NA|8d9c1c71-4e7c-46|959474099|2016-07-26");
	}
    
    
}