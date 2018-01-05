package com.hcicloud.sap.model.voice;

import java.util.Date;


/**
 * 用户
 * @author lixianji
 *
 */
public class Voice {

	/**
	 * 主键
	 */
	private String uuid;
	/**
	 * 转写数据
	 */
	private VoiceTransData transData;
	/**
	 * 随路数据
	 */
	private VoiceRelateData relateData;
	/**
	 * 自动质检数据
	 */
	private VoiceQualityData qualityData;
	/**
	 * 人工质检数据
	 */
	private VoiceManualQualityData qualityManualData;
	/**
	 * 分析数据
	 */
	private VoiceAnalysisData analysisData;
	/**
	 * 在线数据
	 */
	private VoiceOnlineData onlineData;
	/**
	 * 创建
	 */
	private Date creatime;
	/**
	 * 获取creatime
	 * @return the creatime
	 */
	public Date getCreatime() {
		return creatime;
	}
	/**
	 * 设置creatime
	 * @param creatime the creatime to set
	 */
	public void setCreatime(Date creatime) {
		this.creatime = creatime;
	}
	/**
     * 获取uuid  
     * @return the uuid
     */
    public String getUuid() {
        return uuid;
    }
    /**
     * 设置uuid  
     * @param uuid the uuid to set
     */
    public void setUuid(String uuid) {
        this.uuid = uuid;
    }
    /**
     * 获取transData  
     * @return the transData
     */
    public VoiceTransData getTransData() {
        return transData;
    }
    /**
     * 设置transData  
     * @param transData the transData to set
     */
    public void setTransData(VoiceTransData transData) {
        this.transData = transData;
    }
    /**
     * 获取relateData  
     * @return the relateData
     */
    public VoiceRelateData getRelateData() {
        return relateData;
    }
    /**
     * 设置relateData  
     * @param relateData the relateData to set
     */
    public void setRelateData(VoiceRelateData relateData) {
        this.relateData = relateData;
    }
    /**
     * 获取qualityData  
     * @return the qualityData
     */
    public VoiceQualityData getQualityData() {
        return qualityData;
    }
    /**
     * 设置qualityData  
     * @param qualityData the qualityData to set
     */
    public void setQualityData(VoiceQualityData qualityData) {
        this.qualityData = qualityData;
    }
    /**
     * 获取qualityManualData  
     * @return the qualityManualData
     */
    public VoiceManualQualityData getQualityManualData() {
		return qualityManualData;
	}
    /**
     * 设置qualityManualData  
     * @param qualityManualData the qualityManualData to set
     */
	public void setQualityManualData(VoiceManualQualityData qualityManualData) {
		this.qualityManualData = qualityManualData;
	}
    /**
     * 获取analysisData  
     * @return the analysisData
     */
    public VoiceAnalysisData getAnalysisData() {
        return analysisData;
    }
    /**
     * 设置analysisData  
     * @param analysisData the analysisData to set
     */
    public void setAnalysisData(VoiceAnalysisData analysisData) {
        this.analysisData = analysisData;
    }
    /**
     * 获取onlineData  
     * @return the onlineData
     */
    public VoiceOnlineData getOnlineData() {
        return onlineData;
    }
    /**
     * 设置onlineData  
     * @param onlineData the onlineData to set
     */
    public void setOnlineData(VoiceOnlineData onlineData) {
        this.onlineData = onlineData;
    }
	
}
