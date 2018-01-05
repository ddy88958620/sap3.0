package com.hcicloud.sap.pagemodel.base;

import java.io.Serializable;
import java.util.List;

import com.hcicloud.sap.model.admin.Menu;

public class SessionInfo implements Serializable {
	private String uuid;
	private String loginName;
	private String name;
	private String ip;
	private String userGroupId;
	private String userGroupName;
	List<Menu> menuList;
	private List<String> privilegeList;
	private List<String> privilegeAllList;
	private List<Tree> privilegeTree;
	private boolean isAdmin;

	public List<String> getPrivilegeList() {
		return this.privilegeList;
	}

	public void setPrivilegeList(List<String> privilegeList) {
		this.privilegeList = privilegeList;
	}
	
	public List<String> getPrivilegeAllList() {
		return this.privilegeAllList;
	}

	public void setPrivilegeAllList(List<String> privilegeAllList) {
		this.privilegeAllList = privilegeAllList;
	}
	
	public List<Tree> getPrivilegeTree() {
		return this.privilegeTree;
	}

	public void setPrivilegeTree(List<Tree> privilegeTree) {
		this.privilegeTree = privilegeTree;
	}
	
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIp() {
		return this.ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
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
     * 获取menuList  
     * @return the menuList
     */
    public List<Menu> getMenuList() {
        return menuList;
    }

    /**
     * 设置menuList  
     * @param menuList the menuList to set
     */
    public void setMenuList(List<Menu> menuList) {
        this.menuList = menuList;
    }

    public String getLoginName() {
		return this.loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}


	@Override
	public String toString() {
		return this.name;
	}

	public boolean isAdmin() {
		return isAdmin;
	}

	public void setAdmin(boolean isAdmin) {
		this.isAdmin = isAdmin;
	}

	public String getUserGroupId() {
		return userGroupId;
	}

	public void setUserGroupId(String userGroupId) {
		this.userGroupId = userGroupId;
	}

	public String getUserGroupName() {
		return userGroupName;
	}

	public void setUserGroupName(String userGroupName) {
		this.userGroupName = userGroupName;
	}
}
