package com.hcicloud.sap.service.admin;

import java.util.List;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.pagemodel.admin.HotwordModel;
import com.hcicloud.sap.pagemodel.base.Json;

public abstract interface HotwordI {
	
	public List<HotwordModel> dataGrid(HotwordModel hotwordModel, PageFilter pageFilter);
	
	public long count(HotwordModel hotwordModel, PageFilter pageFilter);
	
	public HotwordModel get(String uuid);
	
	public Boolean isRepeat(String name, String uuid, Boolean flag);
	
	public void add(HotwordModel hotwordModel);
	
	public void update(HotwordModel hotwordModel);
	
	public void delete(String uuid) throws Exception;
	
	public Json syncHotword() throws Exception;

}
