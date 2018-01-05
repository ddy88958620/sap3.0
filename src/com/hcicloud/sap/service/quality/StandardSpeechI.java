package com.hcicloud.sap.service.quality;

import java.util.List;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.pagemodel.base.SessionInfo;
import com.hcicloud.sap.pagemodel.quality.StandardSpeechModel;

public abstract interface StandardSpeechI {
	
	public List<StandardSpeechModel> dataGrid(StandardSpeechModel standardSpeechModel, PageFilter pageFilter, SessionInfo sessionInfo);
	
	public long count(StandardSpeechModel standardSpeechModel, PageFilter pageFilter, SessionInfo sessionInfo);
	
	public StandardSpeechModel get(String uuid);
	
	public Boolean isRepeat(String name, String uuid, Boolean flag);
	
	public String add(StandardSpeechModel standardSpeechModel);
	
	public String update(StandardSpeechModel standardSpeechModel);
	
	public String delete(String uuid) throws Exception;

}
