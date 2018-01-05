package com.hcicloud.sap.controller.upload;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.xml.namespace.QName;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import redis.clients.jedis.Jedis;

import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.constant.GlobalConstant;
import com.hcicloud.sap.common.utils.ErrorReturnMsg;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.common.utils.PropertiesLoader;
import com.hcicloud.sap.common.utils.RedisUtil;
import com.hcicloud.sap.common.utils.StringUtil;
import com.hcicloud.sap.common.utils.SystemParamUtil;
import com.hcicloud.sap.controller.base.BaseController;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.service.admin.UserServiceI;
import com.hcicloud.sap.service.task.ScanTransResult;
import com.hcicloud.sap.service.webservice.SaParams;
import com.hcicloud.sap.service.webservice.SpeechFile;
import com.hcicloud.sap.service.webservice.SpeechToTextDelegate;
import com.hcicloud.sap.service.webservice.SpeechToTextService;
import com.sun.istack.internal.logging.Logger;

/** 
 * 上传文件
 * @Title uploadController.java
 * @Package com.hcicloud.sap.controller.upload
 * @author wangya
 * @date 2015年2月9日 下午3:40:29
 */
@Controller
@RequestMapping({ "/upload" })
public class UploadController extends BaseController{
	
	private static Logger logger = Logger.getLogger(UploadController.class);
	
	@Autowired
	private UserServiceI UserService;
	
	@RequestMapping({ "/uploadPage" })
	public String uploadPage(){
		return "/upload/upload";
	}
	
	@RequestMapping({ "/result" })
	public String result(){
		return "/upload/result";
	} 
	
	@RequestMapping({ "/" })
	public String upload(){
		return "/upload/result";
	}
	/**
	 * 获取用户组相关信息
	 * @param request
	 * @return
	 */
	@RequestMapping({"/getUserGroupInfo"})
	@ResponseBody
	public Json getUserGroupInfo(HttpServletRequest request) {
		Json json = new Json();
		try {
			json = this.UserService.getUserGroupInfo(new Json(),false);
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}
	
	/**
	 * 获取用户组下的用户相关信息
	 * @param request
	 * @return
	 */
	@RequestMapping({"/getUserInfoByGroupId"})
	@ResponseBody
	public Json getUserInfoByGroupId(HttpServletRequest request,String userGroupId) {
		Json json = new Json();
		try {
			json = this.UserService.getUserInfoByGroupId(new Json(),userGroupId,false,"3");
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}
	/**
	 * 已上传的录音文件列表
	 * @return
	 */
	@RequestMapping({ "/dataGrid" })
	@ResponseBody
	public Grid dataGrid(PageFilter page){
		Grid grid = new Grid();
		Jedis jedis = null;
		List<String> dataList = null;
		List<JSONObject> jsonList = new ArrayList<JSONObject>();
		long count = 0;
		try{
			jedis = RedisUtil.getJedis();
			dataList = jedis.lrange("pcmInfo", page.getiDisplayStart(), page.getiDisplayStart()+page.getiDisplayLength()-1);
			if(dataList != null){
				JSONObject jsonObject = new JSONObject();
				for(String data:dataList){
					jsonObject = JSONObject.parseObject(data);
					jsonList.add(jsonObject);
				}
				count = jedis.lrange("pcmInfo", 0, -1).size();
				grid.setAaData(jsonList);
				grid.setiTotalRecords(count);
				grid.setiTotalDisplayRecords(count);
			}
			
		}catch(Exception e ){
			e.printStackTrace();
		}finally{
			RedisUtil.returnResource(jedis);
		}
		return grid;
	}
	
	/**
	 * 刷新列表操作，调用扫描转写结果任务，将已完成转写的录音放到新目录下，删除原有的录音文件，更新redis里的状态
	 * @return
	 */
	@RequestMapping({" /refresh "})
	public String refresh(PageFilter page){
		ScanTransResult.scan();
		dataGrid(page);
		return "/upload/upload";
	}
	
	@RequestMapping({ "deleteFromRedis" })
	@ResponseBody
	public Json deleteFromRedis(String UUID){
		Json json = new Json();
		Jedis jedis = null;
		JSONObject jsonObject = new JSONObject();
		try{
			jedis = RedisUtil.getJedis();
			List<String> list = jedis.lrange("pcmInfo", 0, -1);
			for(int i=0;i<list.size();i++){
				jsonObject = JSONObject.parseObject(list.get(i));
				if(UUID.equals(jsonObject.getString("UUID"))){
					jedis.lrem("pcmInfo", i, list.get(i));
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			RedisUtil.returnResource(jedis);
		}
		json.setSuccess(true);
		json.setMsg(ErrorReturnMsg.DELETED_SUCCESSFULLY);
		return json;
	}
	
	@RequestMapping({ "bathDelete" })
	@ResponseBody
	public Json bathDelete(String insIds){
		Json json = new Json();
		Jedis jedis = null;
		String insIdsArray[] = insIds.split(",");
		if(insIdsArray!=null&&insIdsArray.length>0){
			JSONObject jsonObject = new JSONObject();
			try{
				Map<String ,String> map = new HashMap<String ,String>();
				for(String str:insIdsArray){
					map.put(str, "");
				}
				jedis = RedisUtil.getJedis();
				List<String> list = jedis.lrange("pcmInfo", 0, -1);
				for(int i=0;i<list.size();i++){
					jsonObject = JSONObject.parseObject(list.get(i));
					String uuid = jsonObject.getString("UUID");
					if(map.containsKey(uuid)){
						jedis.lrem("pcmInfo", i, list.get(i));
					}
				}
				json.setSuccess(true);
				json.setMsg(ErrorReturnMsg.DELETED_SUCCESSFULLY);
			}catch(Exception e){
				json.setSuccess(false);
				json.setMsg(ErrorReturnMsg.DELETED_FAILED);
				e.printStackTrace();
			}finally{
				RedisUtil.returnResource(jedis);
			}
		}
		
		return json;
	}
	
	/**
	 * 上传文件操作
	 * @param myfile
	 * @param request
	 * @param model
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value="/uploadFile",method = RequestMethod.POST)
	public String uploadFile(@RequestParam("myfile") MultipartFile myfile,HttpServletRequest request,Model model) throws IOException{
		//加载配置文件
		//PropertiesLoader propertiesLoader = new PropertiesLoader("system.properties");
		//webservice服务地址
		String SpeechToTextPort_address = SystemParamUtil.getValueByName("webserviceAddress");//propertiesLoader.getProperty("webserviceAddress");
		//输出文件的目录
		String outPath =  SystemParamUtil.getValueByName("outPath");//propertiesLoader.getProperty("outPath");
		//录音输入目录
		String voiceInPath = SystemParamUtil.getValueByName("voiceInPath");//propertiesLoader.getProperty("voiceInPath");
		//录音输出目录
		String voiceOutPath = SystemParamUtil.getValueByName("voiceOutPath");//propertiesLoader.getProperty("voiceOutPath");
		//录音后缀
		//String fileExtention = propertiesLoader.getProperty("fileExtention");
		//录音格式
		//String audioFormat = pLoader.getProperty("audioFormat");
		String audioFormat = request.getParameter("voiceType");
		String userGroupId = request.getParameter("userGroupId");
		String userId = request.getParameter("userId");
		String userName = request.getParameter("userName");
		//生成uuid
		UUID uuid = UUID.randomUUID();
		//如果只是上传一个文件，则只需要MultipartFile类型接收文件即可，而且无需显式指定@RequestParam注解  
        //如果想上传多个文件，那么这里就要用MultipartFile[]类型来接收文件，并且还要指定@RequestParam注解  
        //并且上传多个文件时，前台表单中的所有<input type="file"/>的name都应该是myfiles，否则参数里的myfiles无法获取到所有上传的文件 
		String errorMsg = "";
		String successMsg = "";
		//dictionary.setCode("VOICE_EXTRACT_WORK");
		PageFilter ph = new PageFilter();
		ph.setiDisplayStart(0);
		ph.setiDisplayLength(100);
		if(myfile.isEmpty()){  
			 errorMsg += ErrorReturnMsg.FILE_NOT_UPLOADED;  
       }else{
    	   //保存文件至输出文件的目录，文件名为带后缀的文件名
    	    String fileName = myfile.getOriginalFilename();
    	    fileName = fileName.replace(" ", "");
    	    String fileExtention = fileName.substring(fileName.lastIndexOf("."));
    	    FileUtils.copyInputStreamToFile(myfile.getInputStream(), new File(outPath, fileName));
	    	
    	  //开始转码文件
			String commond = initCommond(audioFormat,fileName);
			logger.info("开始转码,开始时间：" + StringUtil.dateToString(new Date(), "yyyy-MM-dd HH:mm:ss"));
			logger.info(commond);
			Process proc =null;
			try{
	            proc = Runtime.getRuntime().exec(new String[]{"/bin/bash", "-c", commond});
	            InputStream inputStream = proc.getInputStream();
	            InputStreamReader isr = new InputStreamReader(inputStream);
	            BufferedReader br = new BufferedReader(isr);
	            String line = null;
	            System.out.println("<INPUT>");
	            while ((line = br.readLine()) != null)
	            System.out.println(line);
	            System.out.println("</INPUT>");
	            int exitVal = proc.waitFor();
	            System.out.println("Process exitValue: " + exitVal);
			}catch(Exception e){
				logger.info("执行脚本发生奔溃了....");
				logger.info("执行控制台命令错误,错误信息:" + e.getMessage());
				e.printStackTrace();
			}
			logger.info("结束转码,结束时间：" + StringUtil.dateToString(new Date(), "yyyy-MM-dd HH:mm:ss"));
			logger.info("开始发送到webservice");
			//获取service
			SpeechToTextDelegate delegate = null;
			try {
				// 本示例中，WebService部署在10.0.1.9的8080端口上，需根据实际部署情况修改为实际的IP与端口
				URL url = new URL(SpeechToTextPort_address);
				QName name = new QName(
						"http://webservice.sap.hcicloud.com/", "SpeechToTextService");
				delegate = new SpeechToTextService(url, name).getSpeechToTextPort();
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			//配置参数
			if("5".equals(audioFormat)){
				audioFormat = "-1";
			}else if("6".equals(audioFormat)){
				fileExtention = ".wav";
				audioFormat = "0";
			}
			SaParams saParams = new SaParams();
			saParams.setAudioFormat(audioFormat);
			saParams.setFileExtention(fileExtention);
			//文件列表
			List<SpeechFile> speechFileList = new ArrayList<SpeechFile>();
			SpeechFile speechFile = new SpeechFile();
			speechFile.setFilename(fileName.substring(0, fileName.lastIndexOf(".")));
			speechFileList.add(speechFile);
			
			//向webservice发送转写请求，发送完成后不做处理
			String result = delegate.speechAnalysis(voiceInPath, voiceOutPath, saParams, speechFileList);
			logger.info("webservice结果:"+result);
			
			//放置录音的基本信息
			Jedis jedis = null;
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			try{
				jedis = RedisUtil.getJedis();
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("UUID", uuid);
				jsonObject.put("size", myfile.getSize());
				jsonObject.put("name", myfile.getOriginalFilename().replace(" ", ""));
				jsonObject.put("status", GlobalConstant.IS_TRANSFERRING);
				jsonObject.put("uploadTime", sdf.format(new Date()));
				jsonObject.put("userGroupId",userGroupId);//((SessionInfo)request.getSession().getAttribute(GlobalConstant.SESSION_INFO)).getUserGroupId();
				jsonObject.put("userId",userId);
				jsonObject.put("userName",userName);
				jedis.lpush("pcmInfo", jsonObject.toJSONString());
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				RedisUtil.returnResource(jedis);
			}
    	}
		
		model.addAttribute("error",errorMsg);
		model.addAttribute("success",successMsg);
		return "/upload/result";
	} 
	
	/**
	 * 根据上传的音频格式初始化转码命令字符串
	 * @param audioFormat
	 * @param fileName
	 * @return
	 */
	private String initCommond(String audioFormat,String fileName){
		PropertiesLoader propertiesLoader = new PropertiesLoader("system.properties");
		//转码pcm文件的脚本内容
		String shellName = propertiesLoader.getProperty("shellName");
		String formatShell = propertiesLoader.getProperty("formatShell");
		String outPath = SystemParamUtil.getValueByName("outPath");//propertiesLoader.getProperty("outPath");
		String tempDir = SystemParamUtil.getValueByName("temp_dir");//propertiesLoader.getProperty("temp_dir");
		String commond = "";
		String tempFileName = fileName.substring(0, fileName.lastIndexOf("."))+".pcm";
		String tempWavName = fileName.substring(0, fileName.lastIndexOf("."))+"old.wav";
		String wavFileName = fileName.substring(0, fileName.lastIndexOf("."))+".wav";
		
		//判断临时文件夹是否存在
		File tempPath = new File(tempDir);
		if(!tempPath.exists()){
			tempPath.mkdirs();
		}
		//上传文件的格式判断
		if("-1".equals(audioFormat)){
			//拼接ffmpeg -i + 文件名  -i + 文件名 <过滤器> + 临时pcm文件的命令字符串
			commond = "ffmpeg -y -i '" + outPath + fileName + "' -i '" + outPath + fileName + "' " + shellName + " '" + tempDir + tempFileName + "'";
		}else if("0".equals(audioFormat)){
			//拼接ffmpeg -i + 文件名  -i + 文件名 <过滤器> + 临时pcm文件的命令字符串
			commond =  "ffmpeg -y " + formatShell + " s16le -i '" + outPath + fileName + "' " + formatShell + " s16le -i '" + outPath + fileName + "' " + shellName + " '" + tempDir + tempFileName + "'";
		}else if("1".equals(audioFormat)){
			//vox文件先转为wav文件，再由wav文件转为pcm文件
			commond = "sndfile-convert -override-sample-rate=6000 -ima-adpcm '" + outPath + fileName + "' '" + tempDir + tempWavName + "';";
			commond += "ffmpeg -y -i '" + tempDir + tempWavName + "' -i '" + tempDir + tempWavName + "' " + shellName + " '" + tempDir + tempFileName + "'";
		}else if("2".equals(audioFormat)){
			commond = "sndfile-convert -override-sample-rate=8000 -ima-adpcm '" + outPath + fileName + "' '" + tempDir + tempWavName + "';";
			commond += "ffmpeg -y -i '" + tempDir + tempWavName + "' -i '" + tempDir + tempWavName + "' " + shellName + " '" + tempDir + tempFileName + "'";
		}else if("3".equals(audioFormat)){
			//拼接ffmpeg -i + 文件名  -i + 文件名 <过滤器> + 临时pcm文件的命令字符串
			commond =  "ffmpeg -y " + formatShell + " alaw -i '" + outPath + fileName + "' " + formatShell + " alaw -i '" + outPath + fileName + "' " + shellName + " '" + tempDir + tempFileName + "'";
		}else if("4".equals(audioFormat)){
			//拼接ffmpeg -i + 文件名  -i + 文件名 <过滤器> + 临时pcm文件的命令字符串
			commond =  "ffmpeg -y " + formatShell + " mulaw -i '" + outPath + fileName + "' " + formatShell + " mulaw -i '" + outPath + fileName + "' " + shellName + " '" + tempDir + tempFileName + "'";
		}else if("5".equals(audioFormat)){
			//拼接gsm610转换命令
			commond = "ffmpeg -y -c gsm_ms -i '" + outPath + fileName + "' '" + tempDir + tempWavName + "';";
			commond += "ffmpeg -y -i '" + tempDir + tempWavName + "' -i '" + tempDir + tempWavName + "' " + shellName + " '" + tempDir + tempFileName + "'";
		}else if("6".equals(audioFormat)){
			//拼接视频MOV转换命令
			commond = "ffmpeg -i '" + outPath + fileName + "' '" + outPath + wavFileName + "';";
			commond += "ffmpeg -y -i '" + outPath + wavFileName + "' -i '" + outPath + wavFileName + "' " + shellName + " '" + tempDir + tempFileName + "'";
		}else if("7".equals(audioFormat)){
			//拼接mp3转换命令
			commond = "ffmpeg -y -c mp3 -i '" + outPath + fileName + "' '" + tempDir + wavFileName + "';";
			commond += "ffmpeg -y -i '" + tempDir + wavFileName + "' -i '" + tempDir + wavFileName + "' " + shellName + " '" + tempDir + tempFileName + "'";
		}
		return commond;
	}
	
}
