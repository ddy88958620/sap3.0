package com.hcicloud.sap.service.task;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import redis.clients.jedis.Jedis;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.network.HTTPMethod;
import com.hcicloud.sap.common.utils.CommonMethod;
import com.hcicloud.sap.common.utils.PropertiesLoader;
import com.hcicloud.sap.common.utils.RedisUtil;
import com.hcicloud.sap.common.utils.SystemParamUtil;
import com.sun.org.apache.xml.internal.serialize.OutputFormat;
import com.sun.org.apache.xml.internal.serialize.XMLSerializer;

/**
 * 解析xmlData服务
 * @author panxudong
 *
 */
public class AnalyseVoiceTask implements TaskInterface{
	
	private String fromKey;
	private String toKey;
	
	public AnalyseVoiceTask(String fromKey, String toKey) {
        super();
        this.fromKey = fromKey;
        this.toKey = toKey;
    }

	/**
	 * 
	 */
	@Override
	public void run() {
		Jedis jedis = null;
		String data = null;
		JSONObject jsonObject = null;
		
		while(true) {
			try {
				jedis = RedisUtil.getJedis();
				
				if(jedis == null) {
					System.out.println("获取Jedis失败");
					Thread.sleep(5000);
					continue;
				}
				
				if(jedis.llen(fromKey) <= 0) {
					Thread.sleep(5000);
					continue;
				}/* else {
					Thread.sleep(3000);
				}*/
				
				data = jedis.lpop(fromKey);
				if(data == null || "".equals(data)) {
					Thread.sleep(3000);
					continue;
				}
				jsonObject = JSONObject.parseObject(data);
				
				jsonObject = generateEsData(jsonObject);
				if(jsonObject!=null){
					jedis.rpush(toKey, jsonObject.toJSONString());
				}

			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				if(jedis != null) {
					RedisUtil.returnResource(jedis);
				}
			}
		}
	}
	
	/**
	 * 生成向ES添加的数据
	 * @param transPath
	 * @param transFile
	 * @param name
	 * @return
	 */
	private static JSONObject generateEsData(JSONObject jsonObject){
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder;
		Document document = null;
		String xmlData = "";
		System.out.println("xmlData是否为空xmlData是否为空xmlData是否为空xmlData是否为空"+jsonObject.getString("xmlData"));
		if(jsonObject.containsKey("xmlData")&&!jsonObject.getString("xmlData").equals("")){
			xmlData = jsonObject.getString("xmlData");
			try {
				builder = factory.newDocumentBuilder();
				StringReader stringReader = new StringReader(xmlData);
				InputSource inputSource = new InputSource(stringReader);
				document = builder.parse(inputSource);
				/** -- 拼接向ES传入的数据 -- */
				JSONObject qualityData = new JSONObject();
				JSONArray keyWordList = new JSONArray();//关键词
				JSONArray silenceList = new JSONArray();//静音
				JSONArray voiceOverlapList = new JSONArray();//语音重叠
				qualityData.put("keyWordList", keyWordList);
				qualityData.put("silenceList", silenceList);
				qualityData.put("voiceOverlapList", voiceOverlapList);
				/** -- 关键词、静音、语音重叠 -- */
				getVoiceList(document,qualityData);
				/** -- 向voiceAnalysisData添加数据(sap3.0) -- */
				jsonObject.put("transData", getVoiceTransData(document));
				jsonObject.put("qualityData", qualityData);
				jsonObject.put("xmlData", getVoiceXMLData(document));
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			return jsonObject;
		}
			return null;
}
	
	/**
	 * 拼接文档里的关键词列表、语音重叠和静默时间
	 * @param document
	 * @param qualityData
	 * @throws UnsupportedEncodingException 
	 */
	private static void getVoiceList(Document document, JSONObject qualityData){
		/**--读取关键词文件，获取关键词列表--*/
		File hotword = new File(CommonMethod.getPath()+"/resources/hotword.gbk");
		/**--获取ES的请求链接--**/
		DateFormat sdf = new SimpleDateFormat("yyyy-MM");
		//PropertiesLoader pLoader = new PropertiesLoader("system.properties");
		String indexUrl = SystemParamUtil.getValueByName("index_url");//pLoader.getProperty("index_url");
		String type = sdf.format(new Date());
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
				//System.out.println(line);
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
		/**获取文档中的句子列表，循环匹配关键词*/
		DecimalFormat df=new DecimalFormat("0.00"); 
		NodeList sentenceList = document.getElementsByTagName("sentence");
		JSONArray keyWordList = qualityData.getJSONArray("keyWordList");
		for(int i = 0; i < sentenceList.getLength(); i++){
			Element sentence = (Element)sentenceList.item(i);
			String text = sentence.getElementsByTagName("text").item(0).getFirstChild().getNodeValue();
			if(text.length()==0){
				continue;
			}
			if(words.size()!=0){
				for(int j=0;j<words.size();j++){
					String keyWord = words.get(j);
					if(keyWord!=null&&text.contains(keyWord)){
						int startIndex = text.indexOf(keyWord)+1;
						int endIndex = startIndex + keyWord.length()-1;
						NodeList  word_list = sentence.getElementsByTagName("word");
						int length = 0;
						double start = 0;
						double end = 0;
						int startflag = 0;
						int endflag = 0;
						for(int k = 0; k<word_list.getLength();k++){
							Element word = (Element)word_list.item(k);
							String wordStr = word.getFirstChild().getNodeValue();
							if(wordStr == null||"".equals(wordStr)){
								continue;
							}
							length += wordStr.length();
							if(length>=startIndex&&startflag == 0){//第一次大于起始位置
								double start_time = Double.valueOf(word.getAttribute("start"));
								double end_time = Double.valueOf(word.getAttribute("end"));
								start = end_time - (end_time - start_time)*(length-startIndex)/wordStr.length();
								startflag = 1;
							}
							if(length>=endIndex&&endflag == 0){//第一次大于结束位置
								double start_time = Double.valueOf(word.getAttribute("start"));
								double end_time = Double.valueOf(word.getAttribute("end"));
								end = end_time - (end_time - start_time)*(length-endIndex)/wordStr.length();
								endflag = 1;
							}
						}
						String role =  sentence.getAttribute("role");
						JSONObject keyWordJson = new JSONObject();
						keyWordJson.put("keyWord", keyWord);//关键词
						keyWordJson.put("beginDate", df.format(Double.valueOf(start)/1000));
						keyWordJson.put("endDate", df.format(Double.valueOf(end)/1000));
						keyWordJson.put("role", role);
						
						keyWordList.add(keyWordJson);
						
					}
				}
			}
			
			/**--解析sentence,调取分词语句--**/
			String newText = "";
			try {
				text = URLEncoder.encode(text,"utf-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			String resultJson = HTTPMethod.doGetQuery(indexUrl+type+"/_analyze?pretty&analyzer=mmseg_simple&text="+text, 30 * 1000);
			System.out.println("==================得到的结果JSON是"+resultJson);
			JSONObject resultObject = JSON.parseObject(resultJson);
			JSONArray tokensArray = resultObject.getJSONArray("tokens");
			for (Object v : tokensArray) {
				String token = ((JSONObject)v).getString("token");
				newText += token + " ";
				System.out.println(token);
			}
			System.out.println(newText);
			sentence.getElementsByTagName("text").item(0).getFirstChild().setNodeValue(newText);
		}
		System.out.println("keyWordList.size()="+keyWordList.size());
		
		/**-- 静默时长 --**/
		JSONArray silenceJsonArray = qualityData.getJSONArray("silenceList");
		NodeList silenceList = document.getElementsByTagName("silence");  
		System.out.println(silenceList.getLength());
		for(int j=0;j<silenceList.getLength();j++){  
			Element silence = (Element)silenceList.item(j);
			String beginDate = silence.getAttribute("start");
			String endDate = silence.getAttribute("end");
			Double time = Double.valueOf(endDate)-Double.valueOf(beginDate);
			if(time>5000){//静默超过5秒	
				JSONObject silenceJson = new JSONObject();
				silenceJson.put("value", String.valueOf(time/1000));
				silenceJson.put("beginDate", df.format(Double.valueOf(beginDate)/1000));
				silenceJson.put("endDate", df.format(Double.valueOf(endDate)/1000));
				silenceJsonArray.add(silenceJson);
			}
		}
		/**--语音重叠--*/
		JSONArray voiceOverlapList = qualityData.getJSONArray("silenceList");
		for (int i = 1; i < sentenceList.getLength(); i++) {
			Element sentence = (Element)sentenceList.item(i); 
			Element sentenceBefore = (Element)sentenceList.item(i-1);
			double time =Double.valueOf(sentenceBefore.getAttribute("end"))- Double.valueOf(sentence.getAttribute("start"));
			double endTime =Double.valueOf(sentence.getAttribute("end"))- Double.valueOf(sentence.getAttribute("start"));
			String beginDate = sentence.getAttribute("start");
			String endDate = sentenceBefore.getAttribute("end");
			if(time>3000&&endTime>3000){//重叠超过3秒
				JSONObject voiceOverlapJson = new JSONObject();
				voiceOverlapJson.put("value", String.valueOf(time/1000));
				voiceOverlapJson.put("beginDate", df.format(Double.valueOf(beginDate)/1000));
				voiceOverlapJson.put("endDate", df.format(Double.valueOf(endDate)/1000));
				voiceOverlapList.add(voiceOverlapJson);
				
			}
		}
		
	}
	
	/**
	 * 获取转写数据
	 * @author wangya
	 * @param document
	 * @return
	 */
	private static JSONObject getVoiceTransData(Document document) {
		/** -- 解析Trans文件,生成转写数据 -- */
		JSONObject voiceTransData = new JSONObject();
		JSONObject jsonObject = null;
		
		NodeList list = null;
		Element element = null;
		DecimalFormat df = new DecimalFormat("0.00");
		
		StringBuffer allContent = new StringBuffer();
		StringBuffer userContent = new StringBuffer();
		StringBuffer agentContent = new StringBuffer();
		/** -- 通话总时长 -- */
		list = document.getElementsByTagName("duration");
		element = (Element) list.item(0);
		voiceTransData.put("duration", element.getFirstChild().getNodeValue());
		/** -- 静音总时长 -- */
		list = document.getElementsByTagName("silence_list");
		if(list.getLength() > 0) {
			element = (Element) list.item(0);
			voiceTransData.put("silenceDuration", element.getAttribute("total_time"));
		} else {
			voiceTransData.put("silenceDuration", "0");
		}
		
		/** -- 静音比 -- */
		if("0".equals(voiceTransData.getString("duration"))) {
			voiceTransData.put("silencePercent", "0");
		} else {
			voiceTransData.put("silencePercent", 
				df.format(Double.valueOf(voiceTransData.getString("silenceDuration")) / 
						Double.valueOf(voiceTransData.getString("duration")) * 100));
		}
		/** -- 静音列表 -- */
		list = document.getElementsByTagName("silence");
		JSONArray silenceList = new JSONArray();
		for(int i=0; i<list.getLength(); i++) {
			element = (Element) list.item(i);
			
			jsonObject = new JSONObject();
			jsonObject.put("startTime", element.getAttribute("start"));
			jsonObject.put("endTime", element.getAttribute("end"));

			silenceList.add(jsonObject);
		}
		
		voiceTransData.put("silenceList", silenceList);
		
		/** -- 通话列表  -- */
		list = document.getElementsByTagName("sentence");
		JSONArray sentenceList = new JSONArray();
		JSONArray sentenceSpeed = new JSONArray();
		String content = null;
		for(int i=0; i<list.getLength(); i++) {
			element = (Element) list.item(i);
			
			if(element.getElementsByTagName("text").getLength() > 0) {
				if(element.getElementsByTagName("text").item(0).getFirstChild() != null) {
					jsonObject = new JSONObject();
					jsonObject.put("startTime", element.getAttribute("start"));
					jsonObject.put("endTime", element.getAttribute("end"));
					jsonObject.put("speed", element.getAttribute("speed"));
					jsonObject.put("role", element.getAttribute("role"));
					
					content = element.getElementsByTagName("text").item(0).getFirstChild().getNodeValue().replaceAll(" ", "");
					jsonObject.put("content", content);
					
					if("AGENT".equals(element.getAttribute("role"))) {
						agentContent.append(content + "。");
						sentenceSpeed.add(element.getAttribute("speed"));
					} else {
						userContent.append(content + "。");
					}
					
					allContent.append(content + "。");
					
					sentenceList.add(jsonObject);
				}
			}
		}
		double total=0;
		for(int i=0;i<sentenceSpeed.size();i++){
			double speed=Double.parseDouble((String)sentenceSpeed.get(i)) ;
			total+=speed;
		}
		double speed=total/(sentenceSpeed.size());
		voiceTransData.put("speed", speed);
		System.out.println("-------------------------speed:"+speed);
		voiceTransData.put("sentenceList", sentenceList);
		
		/** -- 情绪列表 -- */
		list = document.getElementsByTagName("emotion");
		JSONArray emotionList = new JSONArray();
		for(int i=0; i<list.getLength(); i++) {
			element = (Element) list.item(i);
			
			if(element.getFirstChild() != null) {
				jsonObject = new JSONObject();
				jsonObject.put("startTime", element.getAttribute("start"));
				jsonObject.put("endTime", element.getAttribute("end"));
				jsonObject.put("emtionType", element.getFirstChild().getNodeValue());
				
				emotionList.add(jsonObject);
			}
		}
		
		voiceTransData.put("emotionList", emotionList);
		
		/** -- 用户,坐席对话信息 & 全部通话 -- */
		voiceTransData.put("allContent", allContent.toString());
		voiceTransData.put("userContent", userContent.toString());
		voiceTransData.put("agentContent", agentContent.toString());
		
		return voiceTransData;
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
		
}
