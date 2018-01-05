package com.hcicloud.sap.service.admin;

import java.util.List;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.pagemodel.admin.OperationLogModel;


public interface OperationLogServiceI {
    
    public void add(String annotion,String type,Object dataObject,String ip);
    
    public abstract List<OperationLogModel> dataGrid(OperationLogModel operationLogModel, String startTime, String endTime, PageFilter pageFilter);
    
    public abstract Long count(OperationLogModel operationLogModel, String startTime, String endTime, PageFilter pageFilter);
}
