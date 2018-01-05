package com.hcicloud.sap.controller.admin;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.controller.base.BaseController;
import com.hcicloud.sap.pagemodel.admin.OperationLogModel;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.service.admin.OperationLogServiceI;

@Controller
@RequestMapping({ "/operationLog" })
public class OperationLogController extends BaseController{
    
    @Autowired
    OperationLogServiceI logService;
    
    @RequestMapping({ "/manager" })
    public String manager(HttpServletRequest request) {
        return "/admin/operationLog";
    }
    
    /**
     * 列表
     * @param userModel
     * @param ph
     * @return
     */
    @RequestMapping({ "/dataGrid" })
    @ResponseBody
    public Grid dataGrid(OperationLogModel logModel,String startTime,String endTime, PageFilter ph) {
        Grid grid = new Grid();
        try {
			grid.setAaData(this.logService.dataGrid(logModel, startTime, endTime, ph));
			long total = this.logService.count(logModel, startTime, endTime, ph);
			grid.setiTotalDisplayRecords(total);
			grid.setiTotalRecords(total);
		} catch (Exception e) {
			e.printStackTrace();
		}
        return grid;
    }
}
