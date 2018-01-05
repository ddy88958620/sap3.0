package com.hcicloud.sap.service.online;


import java.util.Date;
import java.util.List;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.constant.GlobalConstant;
import com.hcicloud.sap.common.utils.DateConversion;
import com.hcicloud.sap.common.utils.RedisOpr;

@Service
public class SeatServiceImpl implements SeatServiceI{

	Logger log = Logger.getLogger(SeatServiceImpl.class);
	
    /**
     * 获取实时通话和团队长消息
     */
	public JSONObject getMessage(String uuid,String callId,long callLength,long captainLength) {
		JSONObject obj = new JSONObject();
		JSONArray historyArray = null;
		//获取坐席最新通话
		byte[] dataObj = RedisOpr.lindex(GlobalConstant.RECORDDATA+"_"+uuid, 0);
		String jsonStr = null;
		try {
			if(dataObj!=null){//存在最新消息
				historyArray=new JSONArray();
				jsonStr = new String(dataObj,"UTF-8");
			}
			if(jsonStr!=null&&jsonStr!=""){
				JSONObject json = JSONObject.parseObject(jsonStr);
				String newCallId = json.getString("callid");
				String userPhone = json.getString("userphone"); 
				if(newCallId!=null&&newCallId.length()>0){//获取当前通话消息列表
					List<byte[]>  currentCallList = null;
					String key = GlobalConstant.HISTORY+"_"+uuid+"_"+newCallId;
					long length=RedisOpr.llen(key)-callLength;
					if(!newCallId.equals(callId)){//有新通话产生
						currentCallList = RedisOpr.lrange(key,0,-1);
					}else if(length>0){//当前通话有新纪录产生
						currentCallList = RedisOpr.lrange(key,0,length-1);
					}
					if(currentCallList!=null){//产生了新的通话记录
						for(byte[] historys:currentCallList){
							String historyStr = new String(historys,"UTF-8");
							if(historyStr!=null&&historyStr.length()>0){
								JSONObject  history = JSONObject.parseObject(historyStr);
								String content = history.getString("content");
								//去掉每句话的时间戳
								int beginIndexTime = content.indexOf(";time=");
								// 如果格式不正确
								if (beginIndexTime > 0) {
									content = content.substring(0,beginIndexTime);
									content =content.replaceAll(" ", "");
								}
								history.put("content", content);
								history.put("time", DateConversion.getTimeString(new Date(Long.valueOf(history.getLong("timestamp"))),"HH:mm:ss"));
								historyArray.add(history);
							}
						}
					}		
					obj.put("callId",newCallId);
					obj.put("historyList",historyArray);
					obj.put("userphone", userPhone);
				}
			}
		} 
		catch (Exception e) {
			log.error(e.getMessage());
		}
		return obj;			
	}
}
