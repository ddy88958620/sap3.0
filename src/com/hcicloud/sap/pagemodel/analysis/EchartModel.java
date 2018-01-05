package com.hcicloud.sap.pagemodel.analysis;

import java.util.List;

import com.alibaba.fastjson.JSONArray;

public class EchartModel {

    /**
     * 请求是否成功
     */
    public boolean isSucess;
    /**
     * 数据的数据量，
     */
    public long dataCount;
    /**
     * x坐标的取值
     */
    public List<String> xSeries;
    /**
     * y坐标的取值
     */
    public List<Float> ySeries;
    
    /**
     * y坐标的jsonArray
     */
    private JSONArray yJsonArray;
    private List<String> yList;
    
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
    public List<String> getxSeries() {
        return xSeries;
    }
    /**
     * 设置xSeries
     * @param xSeries the xSeries to set
     */
    public void setxSeries(List<String> xSeries) {
        this.xSeries = xSeries;
    }
    /**
     * 获取ySeries
     * @return the ySeries
     */
    public List<Float> getySeries() {
        return ySeries;
    }
    /**
     * 设置ySeries
     * @param ySeries the ySeries to set
     */
    public void setySeries(List<Float> ySeries) {
        this.ySeries = ySeries;
    }
	public JSONArray getyJsonArray() {
		return yJsonArray;
	}
	public void setyJsonArray(JSONArray yJsonArray) {
		this.yJsonArray = yJsonArray;
	}
	public List<String> getyList() {
		return yList;
	}
	public void setyList(List<String> yList) {
		this.yList = yList;
	}
    
}
