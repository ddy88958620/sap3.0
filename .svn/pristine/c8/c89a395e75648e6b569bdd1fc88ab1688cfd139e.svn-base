package com.hcicloud.sap.service.annoy;


import java.io.File;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.pagemodel.annoy.AnnoyModel;
import com.hcicloud.sap.pagemodel.base.Grid;

public interface AnnoyService {
	//获取查询数据
	Grid dataGrid(AnnoyModel model, PageFilter ph)  throws Exception;
	//获取统计数据
	Grid countDataGrid(AnnoyModel model) throws Exception;
	//导出转译文本
	File getAnnoyFile(AnnoyModel annoyModel,PageFilter pfFilter);

}
