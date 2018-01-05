package com.hcicloud.sap.pagemodel.base;
/**
 * 
    
 * @Description:ztree节点封装

 * @author:liuxiang

 * @time:2016年3月2日 下午3:45:21
 */
public class ZTree {

	private long id;
	//父节点id
	private long pId;
	private String name;
	//不可拖拽
	private boolean noRemoveBtn = true;
	//不可编辑
	private boolean noEditBtn = true;
	//是否是父节点
	private boolean isParent = false;
	
	
	public ZTree() {
		super();
	}
	
	public ZTree(long id, long pId, String name, boolean noRemoveBtn,
			boolean noEditBtn, boolean isParent) {
		super();
		this.id = id;
		this.pId = pId;
		this.name = name;
		this.noRemoveBtn = noRemoveBtn;
		this.noEditBtn = noEditBtn;
		this.isParent = isParent;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getpId() {
		return pId;
	}
	public void setpId(long pId) {
		this.pId = pId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public boolean isNoRemoveBtn() {
		return noRemoveBtn;
	}
	public void setNoRemoveBtn(boolean noRemoveBtn) {
		this.noRemoveBtn = noRemoveBtn;
	}
	public boolean isNoEditBtn() {
		return noEditBtn;
	}
	public void setNoEditBtn(boolean noEditBtn) {
		this.noEditBtn = noEditBtn;
	}
	public boolean isParent() {
		return isParent;
	}
	public void setParent(boolean isParent) {
		this.isParent = isParent;
	}
	
}
