package com.hcicloud.sap.service.interfaces;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import redis.clients.jedis.Jedis;

import com.hcicloud.sap.common.utils.ErrorReturnMsg;
import com.hcicloud.sap.common.utils.RedisUtil;
import com.hcicloud.sap.pagemodel.base.Json;

@Service
public class VoiceAnalysisServiceImpl implements VoiceAnalysisServiceI {
	
	private static final String key = "sap_voiceAnalysisData"; 
	
	@Override
	public Json setDataToRedis(JSONArray jsonArray) {
		Jedis jedis = null;
		try {
			jedis = RedisUtil.getJedis();

			JSONObject jsonObject = null;
			StringBuffer sbf = new StringBuffer();
			for(int i=0; i<jsonArray.size(); i++) {
				jsonObject = (JSONObject)jsonArray.get(i);
				
				if(!isExist(jsonObject, "UUID")) {
					continue;
				}
				/*if(!isExist(jsonObject, "relateData")) {
					sbf.append(jsonObject.getString("UUID") + ",");
					continue;
				}
				if(!isExist(jsonObject, "transData")) {
					sbf.append(jsonObject.getString("UUID") + ",");
					continue;
				}*/
				if(!isExist(jsonObject,"xmlData")) {
					sbf.append(jsonObject.getString("UUID") + ",");
					continue;
				}
				jsonObject.put("UUID", jsonObject.getString("UUID").replace(",", "|"));
				jedis.rpush(key, jsonObject.toString());
			}

			if(sbf.length() > 0) {
				sbf.deleteCharAt(sbf.length() - 1);
			}

			return new Json(true, sbf.toString(), null);
		} catch(Exception ex) {
			System.out.println(ex.getMessage());
			ex.printStackTrace();
			return new Json(false, ErrorReturnMsg.REQUEST_FAILED, null);
		} finally {
			if(jedis != null) {
				RedisUtil.returnResource(jedis);
			}
		}
	}
	
	private Boolean isExist(JSONObject jsonObject, String key) {
		try {
			if(jsonObject.getString(key) == null 
					|| "".equals(jsonObject.getString(key))
					|| "null".equals(jsonObject.getString(key))) {
				return false;
			}
			
			return true;
		} catch(Exception ex) {
			ex.printStackTrace();
			return false;
		}
	}
}
