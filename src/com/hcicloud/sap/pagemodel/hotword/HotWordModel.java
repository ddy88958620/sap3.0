package com.hcicloud.sap.pagemodel.hotword;

public class HotWordModel {
	//热词名称
	private String name;
	//词出现次数
	private int count;
	//高级检索数据
	private String searchInfo;
	//关键字
	private String searchKeyword;
	//对话目标选择
	private String content;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getSearchInfo() {
		return searchInfo;
	}
	public void setSearchInfo(String searchInfo) {
		this.searchInfo = searchInfo;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
}
