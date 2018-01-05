package com.hcicloud.sap.controller.inspection;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.constant.GlobalConstant;
import com.hcicloud.sap.common.network.ESMethod;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.common.utils.StringUtil;
import com.hcicloud.sap.controller.base.BaseController;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.base.SessionInfo;
import com.hcicloud.sap.service.inspection.InspectionServiceI;
import com.hcicloud.sap.service.voice.SearchServiceI;

@Controller
@RequestMapping({ "/inspection" })
public class InspectionController extends BaseController {

    @Autowired
    InspectionServiceI inspectionService;
    @Autowired
    SearchServiceI searchService;
    
    @RequestMapping({ "/manager" })
    public String manager() {
        return "/inspection/inspectionVoice";
    }
    
    @RequestMapping({ "/dataGrid" })
    @ResponseBody
    public Grid dataGrid(String startTime,String endTime,String status, PageFilter page) {
    	SessionInfo session = (SessionInfo)request.getSession().getAttribute(GlobalConstant.SESSION_INFO);
    	String uuid = session.getUuid();
    	String userGroupId = session.getUserGroupId();
        Grid grid = this.inspectionService.dataGrid(uuid, page,startTime,endTime,status,userGroupId);
        return grid;
    }
    
    /**
     * 跳转开始质检页面
     * @param id
     * @return
     */
    @RequestMapping({ "/inspectionPage" })
    public String inspectionPage(String id) {
    	request.setAttribute("id", id);
        return "/inspection/inspectionPage";
    }
    
    /**
     * 初始化质检规则
     * @param ph
     * @return
     */
    @RequestMapping({ "/findRules" })
    @ResponseBody
    public Grid findRules(PageFilter ph){
    	Grid grid = new Grid();
    	try {
			grid.setAaData(this.inspectionService.findRules(ph));
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return grid;
    }
    
    /**
     * 根据uuid查询工单基本信息
     * @param id
     * @return
     */
    @RequestMapping({ "/getInfoById" })
    @ResponseBody
    public Json getInfoById(String id){
    	Json json = new Json();
    	json = this.inspectionService.getInfoById(id);
    	return json;
    }
    
    @RequestMapping({ "/inspect" })
    @ResponseBody
    public Json inspect(String id, String content, int generalNum, int seriousNum, int score){
    	Json json = new Json();
    	json = this.inspectionService.inspect(id,content,generalNum,seriousNum,score);
    	return json;
    }
    @RequestMapping({ "/getAnalysisData" })
    @ResponseBody
    public Json getAnalysisData(String uuid) {
    	Json j = new Json();
    	
		try {
			String type = StringUtil.dateToString(new Date(), "yyyy-MM");
			JSONObject resultJObject = ESMethod.get(type, uuid);
			if(resultJObject!=null){
				String obj=resultJObject.getString("analysisData");
				obj="["+obj+"]";
				j.setObj(obj);
			}else{
				j.setObj(null);
			}
		
		} catch (Exception e) {
			j.setObj(null);
		}
		
 		return j;
    }
    @RequestMapping({ "/getStandardSpeech" })
    @ResponseBody
    public Json getStandardSpeech(String uuid) {
    	Json j = new Json();
    	
		try {
			String type = StringUtil.dateToString(new Date(), "yyyy-MM");
			JSONObject resultJObject = ESMethod.get(type, uuid);
			if(resultJObject!=null){
				String obj=resultJObject.getString("standardSpeech");
				obj="["+obj+"]";
				j.setObj(obj);
			}else{
				j.setObj(null);
			}
		
		} catch (Exception e) {
			j.setObj(null);
		}
		
 		return j;
    }
    @RequestMapping({ "/flashWidget" })
    public String flash(String uuid, String width,Model model) {
    	model.addAttribute("uuid", uuid);
    	model.addAttribute("time", System.currentTimeMillis());
    	model.addAttribute("width", width);
    	
    	model.addAttribute("height",Integer.parseInt(width)*137/860);
        return "/inspection/flashWidget";
    }
    
}