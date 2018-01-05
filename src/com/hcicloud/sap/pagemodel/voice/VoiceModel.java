package com.hcicloud.sap.pagemodel.voice;

import java.util.Date;

/**
 * Voice entity. @author MyEclipse Persistence Tools
 */
public class VoiceModel implements java.io.Serializable {

	private static final long serialVersionUID = 1L;

	/**
	 * Fields
	 */
	private String uuid;
	private String fileNo;
	private String audioFormat;
	private String ani;
	private String dnis;
	private Long userId;
	private String userName;
	private String userLoginName;
	private Long skillGroupId;
	private String skillGroupName;
	private Long businessId;
	private String businessName;
	private Integer channelType;
	private String callTime;
	private String callTime2;
	private Integer callType;
	private String extension;
	private Integer duration;
	//时长
	private String durationStr;
	
	private Integer duration2;
	//静音时长
	private Integer silenceDuration;
	private String silenceDurationStr;
	private Double silencePercent;
	private Double speed;
	//分配状态
	private String assignStatus;
	//质检员姓名
	private String inspectorName;

	//质检状态
	private String inspectionStatus;
	//private Float speed;
	private Integer emotion;
	private String analysisTime;
	private Date analyseTime2;
	private Date indexTime;
	private Long qualityResultFormId;
	private String searchKeyword;
	//摘要
	private String  remark;
	
	//高级检索数据
	private String searchInfo;

	// Constructors

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	/** default constructor */
	public VoiceModel() {
	}

	// Property accessors

	public String getFileNo() {
		return this.fileNo;
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

    public void setFileNo(String fileNo) {
		this.fileNo = fileNo;
	}

	public String getAudioFormat() {
		return this.audioFormat;
	}

	public void setAudioFormat(String audioFormat) {
		this.audioFormat = audioFormat;
	}

	public String getAni() {
		return this.ani;
	}

	public void setAni(String ani) {
		this.ani = ani;
	}

	public String getDnis() {
		return this.dnis;
	}

	public void setDnis(String dnis) {
		this.dnis = dnis;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserLoginName() {
		return userLoginName;
	}

	public void setUserLoginName(String userLoginName) {
		this.userLoginName = userLoginName;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Long getSkillGroupId() {
		return this.skillGroupId;
	}

	public void setSkillGroupId(Long skillGroupId) {
		this.skillGroupId = skillGroupId;
	}

	public String getSkillGroupName() {
		return skillGroupName;
	}

	public void setSkillGroupName(String skillGroupName) {
		this.skillGroupName = skillGroupName;
	}

	public Long getBusinessId() {
		return this.businessId;
	}
	
	public void setBusinessId(Long businessId) {
		this.businessId = businessId;
	}
	
	public String getBusinessName() {
		return businessName;
	}
	
	public void setBusinessName(String businessName) {
		this.businessName = businessName;
	}

	public Integer getChannelType() {
		return this.channelType;
	}

	public void setChannelType(Integer channelType) {
		this.channelType = channelType;
	}


	/**
     * 获取callTime
     * @return the callTime
     */
    public String getCallTime() {
        return callTime;
    }

    /**
     * 设置callTime
     * @param callTime the callTime to set
     */
    public void setCallTime(String callTime) {
        this.callTime = callTime;
    }

    /**
     * 获取callTime2
     * @return the callTime2
     */
    public String getCallTime2() {
        return callTime2;
    }

    /**
     * 设置callTime2
     * @param callTime2 the callTime2 to set
     */
    public void setCallTime2(String callTime2) {
        this.callTime2 = callTime2;
    }

    public Integer getCallType() {
		return callType;
	}

	public void setCallType(Integer callType) {
		this.callType = callType;
	}

	public String getExtension() {
		return extension;
	}

	public void setExtension(String extension) {
		this.extension = extension;
	}

	public Integer getDuration() {
		return this.duration;
	}

	public void setDuration(Integer duration) {
		this.duration = duration;
	}

	public Integer getDuration2() {
		return duration2;
	}

	public void setDuration2(Integer duration2) {
		this.duration2 = duration2;
	}

	public Integer getSilenceDuration() {
		return this.silenceDuration;
	}

	public void setSilenceDuration(Integer silenceDuration) {
		this.silenceDuration = silenceDuration;
	}

	

	public Double getSpeed() {
		return speed;
	}

	public void setSpeed(Double speed) {
		this.speed = speed;
	}

	public Integer getEmotion() {
		return this.emotion;
	}

	public void setEmotion(Integer emotion) {
		this.emotion = emotion;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	
	public Long getQualityResultFormId() {
		return qualityResultFormId;
	}

	public void setQualityResultFormId(Long qualityResultFormId) {
		this.qualityResultFormId = qualityResultFormId;
	}

    /**
     * 获取analyseTime
     * @return the analyseTime
     */
    public String getAnalysisTime() {
        return analysisTime;
    }

    /**
     * 设置analyseTime
     * @param analyseTime the analyseTime to set
     */
    public void setAnalysisTime(String analysisTime) {
        this.analysisTime =analysisTime;
    }

    /**
     * 获取analyseTime2
     * @return the analyseTime2
     */
    public Date getAnalyseTime2() {
        return analyseTime2;
    }

    /**
     * 设置analyseTime2
     * @param analyseTime2 the analyseTime2 to set
     */
    public void setAnalyseTime2(Date analyseTime2) {
        this.analyseTime2 = analyseTime2;
    }

    /**
     * 获取indexTime
     * @return the indexTime
     */
    public Date getIndexTime() {
        return indexTime;
    }

    /**
     * 设置indexTime
     * @param indexTime the indexTime to set
     */
    public void setIndexTime(Date indexTime) {
        this.indexTime = indexTime;
    }

	/**
	 * 获取searchInfo
	 * @return the searchInfo
	 */
	public String getSearchInfo() {
		return searchInfo;
	}

	/**
	 * 设置searchInfo
	 * @param searchInfo the searchInfo to set
	 */
	public void setSearchInfo(String searchInfo) {
		this.searchInfo = searchInfo;
	}

	public String getDurationStr() {
		return durationStr;
	}

	public void setDurationStr(String durationStr) {
		this.durationStr = durationStr;
	}

	public String getSilenceDurationStr() {
		return silenceDurationStr;
	}

	public void setSilenceDurationStr(String silenceDurationStr) {
		this.silenceDurationStr = silenceDurationStr;
	}
	
	/**
	 * 获取assignStatus
	 * @return the assignStatus
	 */
	public String getAssignStatus() {
		return assignStatus;
	}

	/**
	 * 设置assignStatus
	 * @param assignStatus the assignStatus to set
	 */
	public void setAssignStatus(String assignStatus) {
		this.assignStatus = assignStatus;
	}
	
	/**
	 * 获取inspectorName
	 * @return the inspectorName
	 */
	public String getInspectorName() {
		return inspectorName;
	}

	/**
	 * 设置inspectorName
	 * @param inspectorName the inspectorName to set
	 */
	public void setInspectorName(String inspectorName) {
		this.inspectorName = inspectorName;
	}

	public String getInspectionStatus() {
		return inspectionStatus;
	}

	public void setInspectionStatus(String inspectionStatus) {
		this.inspectionStatus = inspectionStatus;
	}

	public Double getSilencePercent() {
		return silencePercent;
	}

	public void setSilencePercent(Double silencePercent) {
		this.silencePercent = silencePercent;
	}
	
	
}