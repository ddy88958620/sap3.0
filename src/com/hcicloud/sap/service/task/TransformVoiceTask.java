package com.hcicloud.sap.service.task;

import java.io.File;
import java.io.IOException;
import java.util.Date;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import redis.clients.jedis.Jedis;

import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.utils.PropertiesLoader;
import com.hcicloud.sap.common.utils.RedisUtil;
import com.hcicloud.sap.common.utils.StringUtil;
import com.hcicloud.sap.common.utils.SystemParamUtil;
import com.hcicloud.sap.service.admin.SystemParamServiceI;

/**
 * 转换录音服务
 * @author panxudong
 *
 */
public class TransformVoiceTask implements TaskInterface{
	private String fromKey;
	private String toKey;
	private String fromDir;
	private String toDir;
	private String transfromLogDir;
	private String tempDir;
	
	public TransformVoiceTask(String fromKey, String toKey, String fromDir) {
        super();
        this.fromKey = fromKey;
        this.toKey = toKey;
        this.fromDir = fromDir;
        
        PropertiesLoader pLoader = new PropertiesLoader("system.properties");
        toDir = SystemParamUtil.getValueByName("pcm_dir");//pLoader.getProperty("pcm_dir");//
        transfromLogDir = pLoader.getProperty("transform_log");
        tempDir = SystemParamUtil.getValueByName("temp_dir");//pLoader.getProperty("temp_dir");//
    }

	/**
	 * 
	 */
	@Override
	public void run() {
		Jedis jedis = null;
		String data = null, relateData = null;
		String pcmPath = null, from = null, to = null;
		JSONObject jsonObject = null, relateObject = null;
		
		File transformLogFile = new File(transfromLogDir);
		if(!transformLogFile.exists()) {
			try {
				transformLogFile.createNewFile();
			} catch (IOException e) {
				System.out.println("创建文件错误，错误信息：" + e.getMessage());
				e.printStackTrace();
			}
		}
		
		while(true) {
			try {
				jedis = RedisUtil.getJedis();

				if(jedis == null) {
					System.out.println("获取Jedis失败");
					Thread.sleep(10000);
					continue;
				}

				if(jedis.llen(fromKey) <= 0) {
					Thread.sleep(10000);
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

				/** -- 获取随录数据 -- */
				relateData = jsonObject.getString("relateData");
				relateObject = JSONObject.parseObject(relateData);

				/** -- 获取pcm文件源存储位置及目标存放位置 -- */
				pcmPath = relateObject.getString("path");
				
				from = fromDir + pcmPath;
				to = toDir + pcmPath;

				/** -- 转码 -- */
				/*file = new File(toDir + "/" + pcmPath.split("/")[1]);
				if(!file.exists()) {
					file.mkdirs();
				}*/

				System.out.println("=========来源目录"+fromDir);
				System.out.println("=========目标目录"+toDir);
				
				String tempFileName = transform(from, to);
				FileUtils.copyFile(new File(tempDir+tempFileName), new File(toDir+tempFileName.substring(0, tempFileName.lastIndexOf(".")) + ".pcm"));
				
				/** -- 删除源文件 -- */
				deletePcmOldFile(from);

				jedis.rpush(toKey, jsonObject.toJSONString());
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				if(jedis != null) {
					RedisUtil.returnResource(jedis);
				}
			}
		}
	}
	
	private void deletePcmOldFile(String path) {
		File file = new File(path);
		if(file.exists() && !file.isDirectory() && file.isFile()) {
			file.delete();
		}
	}
	
	private String transform(String from, String to) {
		PropertiesLoader propertiesLoader = new PropertiesLoader("system.properties");
		String shellName = propertiesLoader.getProperty("shellName");
		String tempFileName = to.substring(to.lastIndexOf("/"), to.lastIndexOf("."))+".wav";
		System.out.println("临时文件名："+tempFileName);
		File tempFile = new File(tempDir);
		//创建临时文件夹保存.wav转码文件
		if(!tempFile.exists()) {
			tempFile.mkdirs();
		}
		System.out.println("开始转码,开始时间：" + StringUtil.dateToString(new Date(), "yyyy-MM-dd HH:mm:ss"));
		/*String command = "/usr/local/bin/ffmpeg -y -ac 2 -ar 8000 -f s16le  -i " + from + " "
				+ "-ac 1 -ar 8000 -f s16le " + to;*/
		String command = "ffmpeg -i " + from + " " + "-i " + from + " " + shellName + " " + tempDir + tempFileName; 
		System.out.println(command);

//		String[] commandArray = new String[]{"ffmpeg","-y","-ac","2","-ar","8000","-f","s16le","-i",from,"-ac","1","-ar","8000","-f","s16le",to};
		String[] commandArray = new String[]{"sh", "-c", command};
		
		Runtime rt = Runtime.getRuntime();
		Process p = null;
		
		try {
			p = rt.exec(commandArray);
			
			//获取执行命令错误信息
			OutputStreamTask errorReader = new OutputStreamTask(p.getErrorStream(),  "ERROR", transfromLogDir, true, false);  
			errorReader.start();
			
            //获取执行命令结果信息
			OutputStreamTask infoReader = new OutputStreamTask(p.getErrorStream(),  "INFO", transfromLogDir, true, false);  
			infoReader.start();
            
            p.waitFor();
            p.destroy();
		} catch(Exception ex) {
			System.out.println("执行控制台命令错误,错误信息:" + ex.getMessage());
			ex.printStackTrace();
		}
		System.out.println("结束转码,结束时间：" + StringUtil.dateToString(new Date(), "yyyy-MM-dd HH:mm:ss"));
		return tempFileName;
	}
}
