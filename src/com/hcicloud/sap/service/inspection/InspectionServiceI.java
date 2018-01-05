package com.hcicloud.sap.service.inspection;

import java.util.List;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.model.quality.ArtificalItem;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;


public abstract interface InspectionServiceI {

	Grid dataGrid(String uuid, PageFilter page, String startTime,String endTime,String status,String userGroupId);

	List<ArtificalItem> findRules(PageFilter ph);

	Json getInfoById(String id);

	Json inspect(String id, String content, int generalNum, int seriousNum, int score);

	
}
