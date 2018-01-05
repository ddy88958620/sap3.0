package com.hcicloud.sap.controller.quality;

import java.io.InputStream;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.hcicloud.sap.common.constant.GlobalConstant;
import com.hcicloud.sap.common.utils.ErrorReturnMsg;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.controller.base.BaseController;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.base.SessionInfo;
import com.hcicloud.sap.service.quality.AutoRuleServiceI;
import com.hcicloud.sap.pagemodel.quality.AutoRuleModel;

@Controller
@RequestMapping({ "/autoRule" })
public class AutoRuleController extends BaseController{
	
	@Autowired
	AutoRuleServiceI autoService;
	
	@RequestMapping({ "/manager" })
	public String manager(){
		return "/quality/autoRule";
	}
	
	/**
	 * 获取规则分页列表
	 * @param autoRuleModel
	 * @param page
	 * @return
	 */
	@RequestMapping({ "dataGrid" })
	@ResponseBody
	public Grid dataGrid(AutoRuleModel autoRuleModel,PageFilter page) {
		Grid grid = new Grid();
		try {
			grid.setAaData(this.autoService.dataGrid(autoRuleModel, page));
			long total = this.autoService.count(autoRuleModel);
			grid.setiTotalDisplayRecords(total);
			grid.setiTotalRecords(total);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return grid;
	}
	
	/**
	 * 跳转添加规则页面
	 * @return
	 */
	@RequestMapping({ "/addAutoRule" })
	public String addAutoRule(){
		return "/quality/autoRuleAdd";
	}
	
	/**
	 * 跳转快速添加规则页面
	 * @return
	 */
	@RequestMapping({ "/quickAddAutoRule" })
	public String quickAddAutoRule(){
		return "/quality/autoRuleQuickAdd";
	}
	
	/**
	 * 添加规则
	 * @param json
	 * @param request
	 * @return
	 */
	@RequestMapping({ "/add" })
	@ResponseBody
	public Json add(String json, HttpServletRequest request){
		Json j = new Json();
		try{
			SessionInfo sessionInfo = (SessionInfo) request.getSession().getAttribute(GlobalConstant.SESSION_INFO);
			boolean flag=this.autoService.add(json, sessionInfo);
			if(flag){
				j.setSuccess(true);
				j.setMsg(ErrorReturnMsg.ADDED_SUCCESSFULLY);
			}else{
				j.setSuccess(false);
				j.setMsg(ErrorReturnMsg.ADDED_FAILED);
			}
			
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return j;
	}
	/**
	 * 快速添加质检规则
	 * @param queryAutoRulesId
	 * @param wordsName
	 * @param wordsContent
	 * @return
	 */
	@RequestMapping({ "/qucikAdd" })
	@ResponseBody
	public Json quickAdd(String queryAutoRulesId,String wordsName,String wordsContent){
		Json j = new Json();
		try{
			SessionInfo sessionInfo = (SessionInfo) request.getSession().getAttribute(GlobalConstant.SESSION_INFO);
			boolean flag=this.autoService.quickAdd(queryAutoRulesId,wordsName,wordsContent, sessionInfo);
			if(flag){
				j.setSuccess(true);
				j.setMsg(ErrorReturnMsg.ADDED_SUCCESSFULLY);
			}else{
				j.setSuccess(false);
				j.setMsg(ErrorReturnMsg.ADDED_FAILED);
			}
			
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return j;
	}
	
	/**
	 * 根据uuid查询表单数据
	 * @param uuid
	 * @return
	 */
	@RequestMapping({ "getFormInfo" })
	@ResponseBody
	public Json getFomrInfo(String uuid){
		Json json = new Json();
		try {
			json= this.autoService.getFormInfo(uuid);
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}
	
	/**
	 * 获取所有的规则集
	 * @return
	 */
	@RequestMapping({ "getAutoRules" })
	@ResponseBody
	public Json getAutoRules(){
		Json json = new Json();
		try {
			json = this.autoService.getAutoRules();
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}
	
	/**
	 * 删除规则
	 * @param uuid
	 * @return
	 */
	@RequestMapping({ "/delete" })
	@ResponseBody
	public Json delete(String uuid) {
		Json json = new Json();
		try {
			boolean flag=this.autoService.delete(uuid);
			if(flag){
				json.setMsg(ErrorReturnMsg.DELETED_SUCCESSFULLY);
				json.setSuccess(true);
			}else{
				json.setMsg(ErrorReturnMsg.DELETED_FAILED);
				json.setSuccess(false);
			}
			
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}

	
	/**
	 * 同步规则
	 * @param 
	 * @return
	 */
/*	@RequestMapping({ "/synchronizedRule" })
	@ResponseBody
	public Json synchronizedRule() {
		Json json = new Json();
		try {
			boolean flag=this.autoService.synchronizedRule();
			if(flag){
				json.setMsg("同步成功！");
				json.setSuccess(true);
			}else{
				json.setMsg("同步失败！");
				json.setSuccess(false);
			}
			
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(e.getMessage());
		}
		return json;
	}*/
}