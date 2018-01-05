package com.hcicloud.sap.service.region;


import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.region.RegionModel;

public interface RegionService {
	//获取查询数据
	Grid dataGrid(RegionModel regionModel, PageFilter ph)  throws Exception;
	//获取统计数据
	Grid reportGrid(RegionModel regionModel) throws Exception;
	
	Json  getProductType ();
	
	
	
	

}
