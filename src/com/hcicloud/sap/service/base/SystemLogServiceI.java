package com.hcicloud.sap.service.base;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.model.admin.SystemLog;
import com.hcicloud.sap.pagemodel.base.SystemLogModel;

import java.util.List;

public abstract interface SystemLogServiceI {

    public abstract List<SystemLog> dataGrid(SystemLogModel systemLogModel, String startTime, String endTime, PageFilter pageFilter);

    public abstract void add(SystemLog systemLog);

    public abstract void update(SystemLogModel systemLogModel);

    public abstract Long count(SystemLogModel systemLogModel, String startTime, String endTime, PageFilter pageFilter);

    public abstract List<SystemLog> getSystemLogList(SystemLogModel systemLogModel);
}
