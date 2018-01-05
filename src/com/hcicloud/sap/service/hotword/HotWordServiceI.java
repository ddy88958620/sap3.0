package com.hcicloud.sap.service.hotword;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.hotword.HotWordModel;


public interface HotWordServiceI {
	public abstract Json getSearchFormInfo();
	public abstract Grid dataGrid(HotWordModel param);
}
