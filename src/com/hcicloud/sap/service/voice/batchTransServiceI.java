package com.hcicloud.sap.service.voice;


import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.vo.BatchTransVo;

import java.io.File;


public abstract interface batchTransServiceI {
	
	public abstract Grid dataGrid(PageFilter paramPageFilter);
	
	boolean receiveUploadNoifyResult(JSONObject jsonObj);

	/**
	 * 批量转写模块的 批量删除操作
	 * @return
	 */
	boolean delectBulk(String idSArray);

	/**
	 * 转译文本导出
	 * @param model 这里是借用两个字段
	 * @param pf 指定导出条目数
	 * @return
	 */
	Grid dataGrid(BatchTransVo model, PageFilter pf);

	/**
	 * 保存为zip格式文件
	 * @param model
	 * @return
	 */
	File getSuccessFile(BatchTransVo model);

}
