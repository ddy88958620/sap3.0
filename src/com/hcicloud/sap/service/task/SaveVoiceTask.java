package com.hcicloud.sap.service.task;

import java.util.Date;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import redis.clients.jedis.Jedis;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.constant.GlobalConstant;
import com.hcicloud.sap.common.utils.RedisUtil;
import com.hcicloud.sap.model.voice.Voice;
import com.hcicloud.sap.model.voice.VoiceManualQualityData;
import com.hcicloud.sap.model.voice.VoiceQualityData;
import com.hcicloud.sap.model.voice.VoiceRelateData;
import com.hcicloud.sap.model.voice.VoiceTransData;
import com.hcicloud.sap.pagemodel.base.Json;

/**
 * 保存录音数据服务
 * @author panxudong
 *
 */
public class SaveVoiceTask implements TaskInterface{
	
	private String fromKey;
	private String toKey;
	
	public SaveVoiceTask(String fromKey, String toKey) {
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
				//添加人工质检的数据，临时做法
				JSONObject manualJsonObject = new JSONObject();
				manualJsonObject.put("isAssigned", GlobalConstant.NOT_ASSIGNED);
				manualJsonObject.put("isChecked", GlobalConstant.NO_QUALITY_INSPECTION);
				jsonObject.put("manualData", manualJsonObject);
				insert(jsonObject);
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
	
	private void insert(JSONObject jsonObject) {
		//String uuid = null;
		
		Voice voice = new Voice();
		
		/** -- 转写数据 -- */
		VoiceTransData voiceTransData = new VoiceTransData();
		voiceTransData.setText(jsonObject.getString("transData"));
		
		voice.setTransData(voiceTransData);
		//voice.setUuid(jsonObject.getString("UUID"));
		//uuid = jsonObject.getString("UUID");
		
		/** -- 随录数据 -- */
		VoiceRelateData voiceRelateData = new VoiceRelateData();
		voiceRelateData.setRelateData(jsonObject.getString("relateData"));
		
		voice.setRelateData(voiceRelateData);
		
		/** -- 人工质检数据-- */
		VoiceManualQualityData voiceManualQualityData = new VoiceManualQualityData();
		voiceManualQualityData.setQualityManualData(jsonObject.getString("manualData"));
		
		voice.setQualityManualData(voiceManualQualityData);
		
		VoiceQualityData voiceQualityData = new VoiceQualityData();
		voiceQualityData.setQualityData(jsonObject.getString("qualityData"));
		voice.setQualityData(voiceQualityData);
		
		Date date = new Date();
		voice.setCreatime(date);
		/*
		VoiceQualityData voiceaQualityData = new VoiceQualityData();
		VoiceOnlineData voiceOnlineData = new VoiceOnlineData();
		VoiceAnalysisData voiceAnalysisData = new VoiceAnalysisData();
		*/
		
		SessionFactory sessionFactory = TaskSessionFactory.getSessionFactory();
		Session session = null;
		Transaction transaction = null;
		try {
			session = sessionFactory.openSession();
			transaction = session.beginTransaction();
			session.saveOrUpdate(voice);
			transaction.commit();
		} catch(Exception ex) {
			//uuid = null;
			if(transaction != null) {
				transaction.rollback();
			}
			ex.printStackTrace();
		} finally {
			if(session != null) {
				session.close();
			}
		}
		
		return ;
	}

}
