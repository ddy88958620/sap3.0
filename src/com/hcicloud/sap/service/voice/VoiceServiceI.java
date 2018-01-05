package com.hcicloud.sap.service.voice;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;


public abstract interface VoiceServiceI {
	
	public void getAudioStream(String id, String platForm,HttpServletRequest request, HttpServletResponse response) ;
	JSONObject getVoiceByCon(String id);
}
