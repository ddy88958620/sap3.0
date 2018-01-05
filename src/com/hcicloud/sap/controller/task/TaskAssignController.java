package com.hcicloud.sap.controller.task;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hcicloud.sap.pagemodel.base.SessionInfo;
import com.hcicloud.sap.common.constant.GlobalConstant;
import com.hcicloud.sap.common.utils.ErrorReturnMsg;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.controller.base.BaseController;
import com.hcicloud.sap.model.admin.UserRoleRelation;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.voice.VoiceModel;
import com.hcicloud.sap.service.task.TaskAssignServiceI;

@Controller
@RequestMapping({ "/taskAssign" })
public class TaskAssignController extends BaseController{
	
	@Autowired
	TaskAssignServiceI taskAssignService;
	
	@RequestMapping({ "/manager" })
	public String manager(){
		return "/taskAssign/assign";
	}
	
	/**
	 * 加载数据列表
	 * @param startTime
	 * @param endTime
	 * @param status
	 * @param v
	 * @param ph
	 * @return
	 */
    @RequestMapping({ "/dataGrid" })
    @ResponseBody
    public Grid dataGrid(String startTime,String endTime ,String status,VoiceModel v, PageFilter page,HttpServletRequest request) {
    	SessionInfo sessionInfo = (SessionInfo) request.getSession().getAttribute(GlobalConstant.SESSION_INFO);
    	String userGroupId = sessionInfo.getUserGroupId();
        Grid grid = this.taskAssignService.dataGrid(startTime,endTime,status,v, page,userGroupId);
        return grid;
    }
    
    /**
     * 查找质检员
     * @param userRole
     * @param ph分页
     * @return
     */
    @RequestMapping({ "/findInspector" })
    @ResponseBody
    public Grid inspectorGrid(UserRoleRelation userRole, PageFilter ph) {
    	Grid grid = new Grid();
    	try {
			SessionInfo sessionInfo = (SessionInfo) request.getSession().getAttribute(GlobalConstant.SESSION_INFO);
			String userGroupId = sessionInfo.getUserGroupId();
			grid.setAaData(this.taskAssignService.inspectorGrid(userRole, ph,userGroupId));
			long total = this.taskAssignService.count(userGroupId);
			grid.setiTotalDisplayRecords(total);
			grid.setiTotalRecords(total);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return grid;
    }
    
    /**
     * 分配任务
     * @param ids
     * @return
     */
    @RequestMapping({ "assignTask" })
    @ResponseBody
    public Json assignTask(String ids,String inspectorInfo){
    	
    	String[] insStrings = inspectorInfo.split(";");
    	String[] idsStr = ids.split(",");
    	String[] idStr = new String[insStrings.length];
    	Random random = new Random();
    	for (int i = 0; i < idsStr.length; i++) {
    		int j = random.nextInt(insStrings.length);
    		if (StringUtils.isBlank(idStr[j])) {
    			idStr[j] = idsStr[i];
			}else {
				idStr[j] = idStr[j] + "," + idsStr[i];
			}
    		
		}
    	
    	Json json = new Json();
    	for (int j = 0; j < insStrings.length; j++) {
			try {
				if (idStr[j] == null) {
					continue;
				}
				this.taskAssignService.assignTask(idStr[j],insStrings[j]);
				json.setMsg(ErrorReturnMsg.ASSIGNED_SUCCESSFULLY);
				json.setSuccess(true);
			} catch (Exception e) {
				json.setSuccess(false);
				json.setMsg(ErrorReturnMsg.ASSIGNED_FAILED);
			}
		}
    	
		return json;
    }
    
    /**
     * 不予分配
     * @param ids
     * @return
     */
    @RequestMapping({ "denyAssign" })
    @ResponseBody
    public Json denyAssign(String ids){
    	Json json = new Json();
		try {
			this.taskAssignService.denyAssign(ids);
			json.setMsg(ErrorReturnMsg.DENY_ASSIGNED_SUCCESSFULLY);
			json.setSuccess(true);
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DENY_ASSIGNED_FAILED);
		}
		return json;
    }
}