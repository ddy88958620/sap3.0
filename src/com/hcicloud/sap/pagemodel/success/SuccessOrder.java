package com.hcicloud.sap.pagemodel.success;

public class SuccessOrder {

	private String orderId;
	private String voiceId;
	private String platForm;
	private String userPhone;
	private String callLength;
	private String callContent;
	private String qualityName;
	private String qualityDetail;
	private String qualityData;
	private String callStartTime;
	private String callEndTime;
	private String creatTime;
	
	public SuccessOrder() {
	}
	public SuccessOrder(String orderId, String voiceId, String platForm,
			String userPhone, String callLength, String callContent,
			String qualityName, String qualityDetail, String qualityData,
			String callStartTime, String callEndTime, String creatTime) {
		super();
		this.orderId = orderId;
		this.voiceId = voiceId;
		this.platForm = platForm;
		this.userPhone = userPhone;
		this.callLength = callLength;
		this.callContent = callContent;
		this.qualityName = qualityName;
		this.qualityDetail = qualityDetail;
		this.qualityData = qualityData;
		this.callStartTime = callStartTime;
		this.callEndTime = callEndTime;
		this.creatTime = creatTime;
	}

	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getVoiceId() {
		return voiceId;
	}
	public void setVoiceId(String voiceId) {
		this.voiceId = voiceId;
	}
	public String getPlatForm() {
		return platForm;
	}
	public void setPlatForm(String platForm) {
		this.platForm = platForm;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public String getCallLength() {
		return callLength;
	}
	public void setCallLength(String callLength) {
		this.callLength = callLength;
	}
	public String getCallContent() {
		return callContent;
	}
	public void setCallContent(String callContent) {
		this.callContent = callContent;
	}
	public String getQualityName() {
		return qualityName;
	}
	public void setQualityName(String qualityName) {
		this.qualityName = qualityName;
	}
	public String getQualityDetail() {
		return qualityDetail;
	}
	public void setQualityDetail(String qualityDetail) {
		this.qualityDetail = qualityDetail;
	}
	public String getQualityData() {
		return qualityData;
	}
	public void setQualityData(String qualityData) {
		this.qualityData = qualityData;
	}
	public String getCallStartTime() {
		return callStartTime;
	}
	public void setCallStartTime(String callStartTime) {
		this.callStartTime = callStartTime;
	}
	public String getCallEndTime() {
		return callEndTime;
	}
	public void setCallEndTime(String callEndTime) {
		this.callEndTime = callEndTime;
	}
	public String getCreatTime() {
		return creatTime;
	}
	public void setCreatTime(String creatTime) {
		this.creatTime = creatTime;
	}
}
