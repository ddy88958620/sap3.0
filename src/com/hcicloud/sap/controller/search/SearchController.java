package com.hcicloud.sap.controller.search;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.constant.GlobalConstant;
import com.hcicloud.sap.common.network.ESMethod;
import com.hcicloud.sap.common.utils.ErrorReturnMsg;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.common.utils.StringUtil;
import com.hcicloud.sap.controller.base.BaseController;
import com.hcicloud.sap.model.admin.UserRoleRelation;
import com.hcicloud.sap.model.quality.SearchInfo;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.base.SessionInfo;
import com.hcicloud.sap.pagemodel.voice.VoiceModel;
import com.hcicloud.sap.service.voice.SearchServiceI;

@Controller
@RequestMapping({ "/search" })
public class SearchController extends BaseController{

    @Autowired
    SearchServiceI searchService;
    
    @RequestMapping({ "/manager" })
    public String manager() {
        return "/search/fullTextSearch";
    }
    
    @RequestMapping({ "/flashWidget" })
    public String flash(String uuid, Model model) {
    	model.addAttribute("uuid", uuid);
    	model.addAttribute("time", System.currentTimeMillis());
        return "/search/flashWidget";
    }
    
    @RequestMapping({ "/getSearchFormInfo" })
    @ResponseBody
    public Json getSearchFormInfo() {
    	Json json = new Json();
    	try {
			json = searchService.getSearchFormInfo();
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
    	return json;
    }
    
/*    @RequestMapping({ "/getSearchInfo" })
    @ResponseBody
    public Json getSearchInfo() {
    	SessionInfo sessionInfo = (SessionInfo) request.getSession()
    			.getAttribute(GlobalConstant.SESSION_INFO);
    	
    	return searchService.getSearchInfo(sessionInfo.getUuid());
    }*/
    @RequestMapping({ "/getSearchInfo" })
    @ResponseBody
    public Grid getSearchInfoGrid(SearchInfo searchInfo, PageFilter ph) {
    	SessionInfo sessionInfo = (SessionInfo) request.getSession().getAttribute(GlobalConstant.SESSION_INFO);
        Grid grid = new Grid();
		try {
			grid.setAaData(this.searchService.getSearchInfo(searchInfo, ph,sessionInfo.getUuid()));
			long total = this.searchService.count(searchInfo,ph,sessionInfo.getUuid());
//		long total = 19;
			grid.setiTotalDisplayRecords(total);
			grid.setiTotalRecords(total);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return grid;
    }
    @RequestMapping({ "/deleteSearchInfo" })
    @ResponseBody
    public Json deleteSearchInfo(String uuid) {
    	
    	Json json = new Json();
    	try {
			json = searchService.deleteSearchInfo(uuid);
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
    	return json;
        
    }
    
    @RequestMapping({ "/addSearchInfo" })
    @ResponseBody
    public Json addSearchInfo(SearchInfo searchInfo) {
    	Json j = new Json();
    	
		try {
	    	SessionInfo sessionInfo = (SessionInfo) request.getSession()
	    			.getAttribute(GlobalConstant.SESSION_INFO);
			searchInfo.setUserId(sessionInfo.getUuid());
			
			searchService.addSearchInfo(searchInfo);
			
			j.setSuccess(true);
			j.setMsg(ErrorReturnMsg.ADDED_SUCCESSFULLY);
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		
 		return j;
    }
    /**
     * 查看检索名称是否存在
     * @param searchInfo
     * @return
     */
    @RequestMapping({ "/checkSearchInfo" })
    @ResponseBody
    public Json checkSearchInfo(String name) {
    	Json j = new Json(); 
    	try {
			j = this.searchService.checkSearchInfo(name);
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(ErrorReturnMsg.DB_ERROR);
		}
 		return j;
    } 
    @RequestMapping({ "/dataGrid" })
    @ResponseBody
    public Grid dataGrid(VoiceModel v, PageFilter ph) {
        SessionInfo sessionInfo = (SessionInfo) request.getSession()
                .getAttribute(GlobalConstant.SESSION_INFO);
        Grid grid = this.searchService.dataGrid(v, ph, sessionInfo.getUuid());
        return grid;
    }
    
    @RequestMapping({ "/getVoiceInfo" })
    @ResponseBody
    public Json getVoiceInfo(String uuid) {
        Json j = new Json();
        
        try {
            j.setObj(searchService.getVoiceInfo(uuid));
            j.setSuccess(true);
            j.setMsg(ErrorReturnMsg.ADDED_SUCCESSFULLY);
        } catch (Exception e) {
            j.setSuccess(false);
            j.setMsg(ErrorReturnMsg.DB_ERROR);
        }
        
        return j;
    }

}
