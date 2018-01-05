package com.hcicloud.sap.controller.result;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hcicloud.sap.common.constant.GlobalConstant;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.controller.base.BaseController;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.SessionInfo;
import com.hcicloud.sap.pagemodel.voice.VoiceModel;
import com.hcicloud.sap.service.inspection.InspectionServiceI;
import com.hcicloud.sap.service.result.QualityRusultServiceI;

@Controller
@RequestMapping({ "/qualityResult" })
public class QualityResultController extends BaseController {

//    @Autowired
//    InspectionServiceI inspectionService;
    @Autowired
    QualityRusultServiceI qualityRusultServiceI;
    @RequestMapping({ "/manager" })
    public String manager() {
        return "/result/qualityResult";
    }
    
    @RequestMapping({ "/dataGrid" })
    @ResponseBody
    public Grid dataGrid(String startTime,String endTime,String status,VoiceModel v, PageFilter page) {
    	SessionInfo sessionInfo = (SessionInfo)request.getSession().getAttribute(GlobalConstant.SESSION_INFO);
    	String uuid = sessionInfo.getUuid();
    	String userGroupId = sessionInfo.getUserGroupId();
        Grid grid = this.qualityRusultServiceI.dataGrid(uuid, page,startTime,endTime,GlobalConstant.HAVE_QUALITY_INSPECTION,userGroupId);
        return grid;
    }
    
}