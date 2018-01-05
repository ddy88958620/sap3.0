package com.hcicloud.sap.service.success;

import java.io.File;
import java.io.InputStream;
import java.util.List;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.success.ContentGridData;
import com.hcicloud.sap.pagemodel.success.SuccessModal;
import com.hcicloud.sap.pagemodel.success.SuccessReportModel;
import com.hcicloud.sap.vo.SuccessVo;

public interface SuccessOrderService {

	Grid dataGrid(SuccessModal model, PageFilter pf);
	Grid reportGrid(SuccessReportModel model);
	List<ContentGridData> getContentListByVoiceId(String voiceId);
	File getFiles(InputStream inputStream, String uploadFileType)  throws Exception;
	File getFileTest(SuccessModal model)  throws Exception;
	File getSuccessFile(SuccessModal model);

}
