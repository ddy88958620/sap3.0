package com.hcicloud.sap.model.quality;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import com.hcicloud.sap.model.admin.User;

/**
 * 用户
 * @author lixianji
 *
 */
public class Keyword{
	/**
	 * 主键
	 */
	private String uuid;
	/**
	 * 关键词
	 */
	private String keyword;
	/**
	 * 关键词类别
	 */
	private KeywordType keywordType;
	/**
	 * 更新时间
	 */
	private Date updateTime;
	/**
	 * 更新人
	 */
	private User updateUser;
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
     * 获取keyword  
     * @return the keyword
     */
    public String getKeyword() {
        return keyword;
    }
    /**
     * 设置keyword  
     * @param keyword the keyword to set
     */
    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }
    /**
     * 获取keywordType  
     * @return the keywordType
     */
    public KeywordType getKeywordType() {
        return keywordType;
    }
    /**
     * 设置keywordType  
     * @param keywordType the keywordType to set
     */
    public void setKeywordType(KeywordType keywordType) {
        this.keywordType = keywordType;
    }
    /**
     * 获取updateTime  
     * @return the updateTime
     */
    public Date getUpdateTime() {
        return updateTime;
    }
    /**
     * 设置updateTime  
     * @param updateTime the updateTime to set
     */
    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
    /**
     * 获取updateUser  
     * @return the updateUser
     */
    public User getUpdateUser() {
        return updateUser;
    }
    /**
     * 设置updateUser  
     * @param updateUser the updateUser to set
     */
    public void setUpdateUser(User updateUser) {
        this.updateUser = updateUser;
    }
		
}
