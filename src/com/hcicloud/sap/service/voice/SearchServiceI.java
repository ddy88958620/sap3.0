package com.hcicloud.sap.service.voice;

import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.model.quality.SearchInfo;
import com.hcicloud.sap.pagemodel.admin.UserModel;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.voice.VoiceModel;


public abstract interface SearchServiceI {
	
	public abstract Grid dataGrid(VoiceModel paramVoice, PageFilter paramPageFilter,String userId);

	public abstract Json getSearchFormInfo();
	
	public abstract List<SearchInfo> getSearchInfo(SearchInfo searchInfo, PageFilter ph,String userId);
	
	public abstract Json deleteSearchInfo(String uuid);
	
	public abstract void addSearchInfo(SearchInfo searchInfo);
	
	public JSONObject getVoiceInfo(String uuid);
	/**
	 * 查询检索名称是否存在
	 */
	public abstract Json checkSearchInfo(String name);
	public abstract Long count(SearchInfo SearchInfo, PageFilter pageFilter,String userId);
}
