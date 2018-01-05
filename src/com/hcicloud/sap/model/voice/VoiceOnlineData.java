package com.hcicloud.sap.model.voice;

/**
 * 用户
 * @author lixianji
 *
 */
public class VoiceOnlineData{
	/**
	 * 主键
	 */
	private String uuid;
	/**
	 * 名称
	 */
	private String onlineData;
	
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
     * 获取onlineData  
     * @return the onlineData
     */
    public String getOnlineData() {
        return onlineData;
    }
    /**
     * 设置onlineData  
     * @param onlineData the onlineData to set
     */
    public void setOnlineData(String onlineData) {
        this.onlineData = onlineData;
    }
}
