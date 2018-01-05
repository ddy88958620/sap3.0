package com.hcicloud.sap.controller.analysis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hcicloud.sap.controller.base.BaseController;
import com.hcicloud.sap.pagemodel.analysis.CrossModel;
import com.hcicloud.sap.pagemodel.analysis.EchartModel;
import com.hcicloud.sap.pagemodel.analysis.HomeEchartModel;
import com.hcicloud.sap.service.analysis.AnalysisServiceI;

@Controller
@RequestMapping({"/analysis"})
public class AnalysisController extends BaseController {

    @Autowired
    AnalysisServiceI analysisService;
    /**
     * 趋势统计页面
     * @return
     */
    @RequestMapping({"/trend"})
    public String trendPage(){
        return "/analysis/trend";
    }
    
    /**
     * 交叉分析页面
     * @return
     */
    @RequestMapping({"/cross"})
    public String crossPage(){
        return "/analysis/cross";
    }
    
    @RequestMapping({ "/getTrendData" })
    @ResponseBody
    public EchartModel getTrendData(String condition, String startTime, String endTime, String dateType){
        return analysisService.getTrendData(condition, startTime, endTime, dateType);
    }
    /**
     * 获取主页折线图信息
     * @param condition
     * @param startTime
     * @param endTime
     * @param dateType
     * @return
     */
    @RequestMapping({ "/getHomeTrendData" })
    @ResponseBody
    public HomeEchartModel getHomeTrendData(String condition, String startTime, String endTime, String dateType){
        return analysisService.getHomeTrendData(condition, startTime, endTime, dateType);
    }
    
    @RequestMapping({ "/getCrossData" })
    @ResponseBody
    public Object getCrossData(String searchInfoCommon,String searchKeyword,String dataType,String xType, String yType, String xPeriod,String yPeriod,String xmult,String ymult){
        return analysisService.getCrossData(searchInfoCommon,searchKeyword,dataType,xType,yType,xPeriod,yPeriod,xmult,ymult);
    }
}
