package com.hcicloud.sap.service.success;



import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.success.SuccessRecordModel;

public interface SuccessRecordService {

	Grid getSuccessListOld(SuccessRecordModel model, PageFilter pf);
	
	Json  getPlaytForms();
	Grid getSuccessList(SuccessRecordModel model, PageFilter pf);
	
	//Json getVoiceIdByOrder(String orderId);
	
	
	
}
