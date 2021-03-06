package com.hcicloud.sap.pagemodel.analysis;

import java.util.List;

public class CrossModel {

    /**
     * 请求是否成功
     */
    public boolean isSucess;
    /**
     * 数据的数据量，
     */
    public long dataCount;
    /**
     * 坐标的取值
     */
    public List<List<Float>> xSeries;
   
    /**
     * 获取isSucess
     * @return the isSucess
     */
    public boolean isSucess() {
        return isSucess;
    }
    /**
     * 设置isSucess
     * @param isSucess the isSucess to set
     */
    public void setSucess(boolean isSucess) {
        this.isSucess = isSucess;
    }
    /**
     * 获取dataCount
     * @return the dataCount
     */
    public long getDataCount() {
        return dataCount;
    }
    /**
     * 设置dataCount
     * @param dataCount the dataCount to set
     */
    public void setDataCount(long dataCount) {
        this.dataCount = dataCount;
    }
    /**
     * 获取xSeries
     * @return the xSeries
     */
    public List<List<Float>> getxSeries() {
        return xSeries;
    }
    /**
     * 设置xSeries
     * @param xSeries the xSeries to set
     */
    public void setxSeries(List<List<Float>> xSeries) {
        this.xSeries = xSeries;
    }
    
}
