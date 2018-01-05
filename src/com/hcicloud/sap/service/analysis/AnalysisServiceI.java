package com.hcicloud.sap.service.analysis;

import com.hcicloud.sap.pagemodel.analysis.EchartModel;
import com.hcicloud.sap.pagemodel.analysis.HomeEchartModel;

public interface AnalysisServiceI {

    /**
     * 趋势统计获取数据
     * @param keyword
     * @param startTime
     * @param endTime
     * @param dataType
     * @return
     */
    public EchartModel getTrendData(String condition, String startTime, String endTime, String dateType);
    /**
     * 主页趋势统计获取数据
     * @param condition
     * @param startTime
     * @param endTime
     * @param dateType
     * @return
     */
    public HomeEchartModel getHomeTrendData(String condition, String startTime, String endTime, String dateType);
    /**
     * 获取交叉分析数据,统计总量
     * @param condition
     * @param dataType
     * @param xType
     * @param yType
     * @param xPeriod
     * @param ymult 
     * @param xmult 
     * @return
     */
    public EchartModel getCrossData(String searchInfoCommon,String searchKeyword,String dataType,String xType, String yType, String xPeriod,String yPeriod, String xmult, String ymult);
}
