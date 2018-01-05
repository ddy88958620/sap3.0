package com.hcicloud.sap.controller.region;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hcicloud.sap.common.utils.ErrorReturnMsg;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.model.region.AgentInfo;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.service.region.impl.AgentInfoService;



@Controller
@RequestMapping({ "/agentInfo" })
public class AgentInfoController {
	
	@Autowired
	private AgentInfoService  agentInfoService;
	
	
	
	@RequestMapping({ "/manager" })
	public String manager(HttpServletRequest request) {
		return "/regional/regionalAgent";
	}
	
	@RequestMapping({ "/getAgentInfo"})
	@ResponseBody
	private List<AgentInfo> getAgentInFo(){
		
	  List<AgentInfo>  agentInfoList=agentInfoService.agentInfoList();
	  return agentInfoList;
	  
	}
	
	@RequestMapping({ "/addAgentInfo"})
	@ResponseBody
	private boolean addAgentInfo(){
		AgentInfo agentInfo = new AgentInfo();
		agentInfo.setCallPhone("137656564654");
		agentInfo.setPlatForm("XQD-CCOD");
		agentInfo.setAgentId("65544");
	
		boolean result = agentInfoService.addAgentInfo(agentInfo);
		
		return result;
		
		
	}
	
	@RequestMapping({ "/addAgentInfoList"})
	@ResponseBody
	private boolean addAgentInfoList(){
		AgentInfo agentInfo = new AgentInfo();
		agentInfo.setCallPhone("0000003");
		agentInfo.setPlatForm("XQD-CCOD");
		agentInfo.setAgentId("0000003");
		
		AgentInfo agentInfo2 = new AgentInfo();
		agentInfo2.setAgentId("000002");
		agentInfo2.setPlatForm("XQD-ZX");
		agentInfo2.setCallPhone("110");
		
		List<AgentInfo>  agentInfoList = new ArrayList<AgentInfo>();
		agentInfoList.add(agentInfo);
		agentInfoList.add(agentInfo2);
		
		boolean result = agentInfoService.addAgentInfoList(agentInfoList);
		
		return result;
		
		
	}
	
	
	/**
	 * 开始
	 * 
	 */
	
	/**
	 * 获取分页
	 * @param agentInfo
	 * @param ph
	 * @return
	 */
	@RequestMapping({ "/dataGrid" })
	@ResponseBody
	public Grid dataGrid(AgentInfo agentInfo, PageFilter ph) {
		Grid grid = new Grid();
		try {
			grid.setAaData(this.agentInfoService.dataGrid(agentInfo, ph));
			long total = this.agentInfoService.count(agentInfo, ph);
			grid.setiTotalDisplayRecords(total);
			grid.setiTotalRecords(total);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return grid;
	}
	
	/**
	 * 添加坐席
	 * @param request
	 * @param systemParam
	 * @return
	 */
	@RequestMapping({ "/add" })
	@ResponseBody
	public Json add(AgentInfo agentInfo,HttpServletRequest request) {
		Json j = new Json();

		try {
			if (!this.agentInfoService.isRepeat(agentInfo.getAgentId(), null, false)) {
				this.agentInfoService.add(agentInfo);
				
				j.setSuccess(true);
				j.setMsg(ErrorReturnMsg.ADDED_SUCCESSFULLY);
			} else {
				j.setSuccess(false);
				j.setMsg(ErrorReturnMsg.SYSTEMPARAM_REPEATED);
			}
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return j;
	}
	
	/**
	 * 通过ID获取坐席实例
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping({ "/loadById" })
	@ResponseBody
	public Json loadById(HttpServletRequest request, String id) {
		Json json = new Json();
		try {
			AgentInfo agentInfo = this.agentInfoService.get(id);
			
			json.setSuccess(true);
			json.setObj(agentInfo);
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		
		return json;
	}
	
	
	/**
	 * 编辑坐席
	 * @param systemParam
	 * @return
	 */
	@RequestMapping({ "/edit" })
	@ResponseBody
	public Json edit(AgentInfo agentInfo) {
		Json j = new Json();
		try {
			if (!this.agentInfoService.isRepeat(agentInfo.getAgentId(),agentInfo.getId(), true)) {
				this.agentInfoService.update(agentInfo);
				
				j.setSuccess(true);
				j.setMsg(ErrorReturnMsg.UPDATED_SUCCESSFULLY);
			} else {
				j.setSuccess(false);
				j.setMsg(ErrorReturnMsg.SYSTEMPARAM_REPEATED);
			}
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return j;
	}
	
	/**
	 * 删除关键词
	 * @param uuid
	 * @return
	 */
	@RequestMapping({ "/delete" })
	@ResponseBody
	public Json delete(String id) { 
		Json json = new Json();
		try {
			this.agentInfoService.delete(id);
			json.setMsg(ErrorReturnMsg.DELETED_SUCCESSFULLY);
			json.setSuccess(true);
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}
	

}
