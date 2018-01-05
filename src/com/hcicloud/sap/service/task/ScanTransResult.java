package com.hcicloud.sap.service.task;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;

import redis.clients.jedis.Jedis;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.constant.GlobalConstant;
import com.hcicloud.sap.common.network.HTTPMethod;
import com.hcicloud.sap.common.utils.PropertiesLoader;
import com.hcicloud.sap.common.utils.RedisUtil;
import com.hcicloud.sap.common.utils.StringUtil;
import com.hcicloud.sap.common.utils.SystemParamUtil;
import com.sun.org.apache.xml.internal.serialize.OutputFormat;
import com.sun.org.apache.xml.internal.serialize.XMLSerializer;

/**
 * 扫描转写结果任务
 * @author wangya
 *
 */
@Service
public class ScanTransResult{
	
	private static final Logger logger = Logger.getLogger(ScanTransResult.class);
	
	public void run() {
		try {
			while(true){
				Thread.sleep(1000*60);
				try {
					scan();
				} catch (Exception e) {
					logger.error(e.getMessage());
				}
			}
		} catch (InterruptedException e) {
			logger.error(e.getMessage());
		}
	}
	
	/**
	 * 扫描目标文件目录
	 */
	public static void scan(){
		/**-- 获取配置参数 --**/
		//PropertiesLoader propertiesLoader = new PropertiesLoader("system.properties");
		String outPath = SystemParamUtil.getValueByName("outPath");//propertiesLoader.getProperty("outPath");
		String transPath = SystemParamUtil.getValueByName("transPath");//propertiesLoader.getProperty("transPath");
		
		try{
			
			if(outPath == null){
				logger.error("扫描的录音目录不存在");
				return;
			}
			logger.error(outPath);
			File fileOutPath = new File(outPath);
			System.out.println("扫描pcm的目录是："+outPath);
			if(!fileOutPath.isDirectory()){
				logger.error("扫描的录音文件目录不是一个目录");
				return;
			}
			//获取目录下的文件列表
			String[] fileList = fileOutPath.list();
			if(fileList == null)System.out.println("找不到文件");
			int time = 0;
			for(String fullName:fileList){
				int lastIndexDot = fullName.lastIndexOf(".");
				if(lastIndexDot>-1){
					time++;
					System.out.println("开始第"+time+"次处理");
					String name = fullName.substring(0,lastIndexDot);
					System.out.println("寻找trans文件的目录是："+transPath);
					File transFile = new File(transPath + "/" + name + ".trans");
					if(transFile.exists()){
						System.out.println("这时还没报错呢");
						JSONArray voiceAnalysisData = generateEsData(outPath , transFile , name);
						operateFile(fullName);
						updateRedis(fullName);
						/** -- 调用接口向ES传入数据 -- **/
						sendVoiceAnalysisData(voiceAnalysisData);
					}else{
						System.out.println("找不到trans文件");
						continue;
					}
				}else{
					continue;
				}
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	/**
	 * 生成向ES添加的数据
	 * @param transPath
	 * @param transFile
	 * @param name
	 * @return
	 */
	private static JSONArray generateEsData(String outPath ,File transFile , String name){
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder;
		Document document = null;
		JSONArray voiceAnalysisData = new JSONArray();
		try {
			builder = factory.newDocumentBuilder();
			document = builder.parse(new FileInputStream(transFile));
			/** -- 拼接向ES传入的数据 -- */
			JSONObject qualityData = new JSONObject();
			JSONArray keyWordList = new JSONArray();//关键词
			JSONArray silenceList = new JSONArray();//静音
			JSONArray voiceOverlapList = new JSONArray();//语音重叠
			qualityData.put("keyWordList", keyWordList);
			qualityData.put("silenceList", silenceList);
			qualityData.put("voiceOverlapList", voiceOverlapList);
			
			Map<String,String> userInfoMap = getUserInfo(name);
			String userGroupId = null;
			String userId = null;
			String userName = null;
			if (userInfoMap != null) {
				userGroupId = userInfoMap.get("userGroupId");
				userId = userInfoMap.get("userId");
				userName = userInfoMap.get("userName");
			}
			
			/** -- 向voiceAnalysisData添加数据(sap3.0) -- */
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("UUID", name);
			jsonObject.put("userGroupId", userGroupId);
			jsonObject.put("relateData", getVoiceRelateData("/" + name,userId,userName));
			jsonObject.put("xmlData", getVoiceXMLData(document));
			voiceAnalysisData.add(jsonObject);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return voiceAnalysisData;
	}
	
	/**
	 * 移动文件到指定目录并删除源文件
	 * @param outPath
	 * @param pcmPath
	 * @param fullName
	 */
	private static void operateFile(String fullName){
		String fileName = fullName.substring(0, fullName.lastIndexOf("."));
		//PropertiesLoader propertiesLoader = new PropertiesLoader("system.properties");
		//转码临时文件存放目录
		String tempDir = SystemParamUtil.getValueByName("temp_dir");//propertiesLoader.getProperty("temp_dir");
		//调听录音存放目录
		String pcmDir = SystemParamUtil.getValueByName("pcm_dir");//propertiesLoader.getProperty("pcm_dir");
		//上传录音保存目录
		String outPath = SystemParamUtil.getValueByName("outPath");//propertiesLoader.getProperty("outPath");
		//转写文件保存目录
		String transPath = SystemParamUtil.getValueByName("transPath");//propertiesLoader.getProperty("transPath");
		File tempFile = new File (tempDir + fileName +".pcm");
		
		try {
			if(tempFile.exists() && !tempFile.isDirectory() && tempFile.isFile()){
				FileUtils.copyFile(tempFile, new File(pcmDir + "/" + fullName.substring(0, fullName.lastIndexOf("."))+".pcm" ));
			}else{
				FileUtils.copyFile(new File(outPath,fullName), new File(pcmDir + "/" + fullName.substring(0, fullName.lastIndexOf("."))+".pcm" ));
			}
			/** -- 删除上传文件 -- */
			deleteFile(outPath,fullName);
			/** -- 删除转写文件 -- */
			//deleteFile(transPath,fileName+".trans");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 更新redis里的文件状态
	 * @param fullName
	 */
	private static void updateRedis(String fullName){
		Jedis jedis = null;
		List<String> dataList = new ArrayList<String>();
		try{
			jedis = RedisUtil.getJedis();
			dataList = jedis.lrange("pcmInfo", 0, -1);
			if(dataList != null){
				JSONObject jsonObject = new JSONObject();
				for(int i=0;i<dataList.size();i++){
					jsonObject = JSONObject.parseObject(dataList.get(i));
					if(fullName.equals(jsonObject.getString("name"))){
						jsonObject.put("status", GlobalConstant.ALREADY_TRANSFERRED);
						jedis.lset("pcmInfo", i, jsonObject.toJSONString());
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			return;
		}finally{
			RedisUtil.returnResource(jedis);
		}
		
	}
	private static Map<String,String> getUserInfo(String name) {
		
		Jedis jedis = null;
		JSONObject jsonObject = new JSONObject();
		try{
			jedis = RedisUtil.getJedis();
			List<String> list = jedis.lrange("pcmInfo", 0, -1);
			for(int i=0;i<list.size();i++){
				jsonObject = JSONObject.parseObject(list.get(i));
				String fullName = jsonObject.getString("name");
				String uuidStr = fullName.substring(0, fullName.indexOf("."));
				if(name.equals(uuidStr)){
					Map<String,String> userInfo = new HashMap<String, String>();
					userInfo.put("userGroupId", jsonObject.getString("userGroupId"));
					userInfo.put("userId", jsonObject.getString("userId"));
					userInfo.put("userName", jsonObject.getString("userName"));
					return userInfo;
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			RedisUtil.returnResource(jedis);
		}
		return null ;
	}
	public static void main(String args[]){
		File hotword = new File("WebContent/resources/stopword.gbk");
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
				System.out.println(line);
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
	}
	
	/**
	 * 获取随录数据
	 * @author wangya
	 * @return
	 */
	private static JSONObject getVoiceRelateData(String path,String userId,String userName) {
		JSONObject voiceRelateData = new JSONObject();
		
		path = path.replaceAll("\\\\", "/");
		
		voiceRelateData.put("path", path + ".pcm");
		voiceRelateData.put("userId", userId);
		voiceRelateData.put("dnis", "13111111111");
		voiceRelateData.put("ani", "82826886");
		voiceRelateData.put("transTime", StringUtil.dateToString(new Date(), "yyyy-MM-dd HH:mm:ss"));
		voiceRelateData.put("indexTime", StringUtil.dateToString(new Date(), "yyyy-MM-dd HH:mm:ss"));
		voiceRelateData.put("analysisTime", StringUtil.dateToString(new Date(), "yyyy-MM-dd HH:mm:ss"));
		voiceRelateData.put("callTime", StringUtil.dateToString(new Date(), "yyyy-MM-dd HH:mm:ss"));
		voiceRelateData.put("userName", userName);
		voiceRelateData.put("others", "");
		
		return voiceRelateData;
	}
	
	/**
	 * 获取原生XML数据
	 * @author wangya
	 * @param document
	 * @return
	 */
	private static String getVoiceXMLData(Document document) {
		StringWriter stringWriter = null;
		try {
			stringWriter = new StringWriter();
			
			if(document != null){
				OutputFormat format = new OutputFormat(document, "UTF-8", true);
				XMLSerializer serializer = new XMLSerializer(stringWriter,format);
				serializer.asDOMSerializer();
				serializer.serialize(document);
				
				return stringWriter.toString();
			} else {
				return null;
			}
		} catch (Exception e) {
			return null;
		} finally {
			if(stringWriter != null){
				try {
					stringWriter.close();
				} catch (IOException e) {
					return null;
				}
			}
		}
	}
	
	/**
	 * 删除文件
	 * @param transPath
	 * @param name
	 */
	private static void deleteFile(String path , String name){
		File file = new File(path + name);
		//文件存在则删除
		if(file.exists()&&!file.isDirectory()&&file.isFile()){
			System.out.println("上传文件开始删除----------------------");
			file.delete();
		}
	}
	
	private static Boolean sendVoiceAnalysisData(JSONArray voiceAnalysisData) {
		//Debug
		System.out.println(StringUtil.dateToString(new Date(), "yyyy-MM-dd HH:mm:ss") 
				+ "向Sap3.0发送Http请求~");
		
		Boolean flag = false;
		
		try {
		    //PropertiesLoader propertiesLoader = new PropertiesLoader("system.properties");
	        String transPath = SystemParamUtil.getValueByName("transUrl");//propertiesLoader.getProperty("transUrl");
			String responseBody = HTTPMethod.doPostQuery(transPath , voiceAnalysisData.toJSONString() , 30 * 1000);
			System.out.println("请求路径："+transPath);
			System.out.println("传入字符串："+voiceAnalysisData.toJSONString());
			JSONObject jsonObject = JSONObject.parseObject(responseBody);
			
			//Debug
			System.out.println("响应报文体：" + responseBody);
			System.out.println("响应success:"+jsonObject.getString("success"));
			if(jsonObject.getString("success") == null 
					|| "".equals(jsonObject.getString("success"))
					|| "null".equals(jsonObject.getString("success"))) {
				throw new Exception("返回信息缺失");
			}
			String success = jsonObject.getString("success");
			if("true".equals(success)) {
				if(jsonObject.getString("msg") != null 
						&& !"".equals(jsonObject.getString("msg"))
						&& !"null".equals(jsonObject.getString("msg"))) {
					System.out.println("返回信息:" + jsonObject.getString("msg"));
				}
				flag = true;
			} else {
				if(jsonObject.getString("msg") == null 
						|| "".equals(jsonObject.getString("msg"))
						|| "null".equals(jsonObject.getString("msg"))) {
					throw new Exception("具体错误信息缺失");
				}
				throw new Exception(jsonObject.getString("msg"));
			}
		} catch (Exception e) {
			System.out.println("发送Http请求错误，错误信息：" + e.getMessage());
			e.printStackTrace();
			flag = false;
		}
		
		return flag;
	}
	
}
