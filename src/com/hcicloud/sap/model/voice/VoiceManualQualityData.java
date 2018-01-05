package com.hcicloud.sap.model.voice;

/**
 * 人工质检数据
 * @author lixianji
 *
 */
public class VoiceManualQualityData{
	/**
	 * 主键
	 */
	private String uuid;
	/**
	 * 名称
	 */
	private String qualityManualData;
	
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
     * 获取qualityManualData  
     * @return the qualityManualData
     */
	public String getQualityManualData() {
		return qualityManualData;
	}
	/**
     * 设置qualityManualData  
     * @param qualityManualData the qualityManualData to set
     */
	public void setQualityManualData(String qualityManualData) {
		this.qualityManualData = qualityManualData;
	}
    
}
