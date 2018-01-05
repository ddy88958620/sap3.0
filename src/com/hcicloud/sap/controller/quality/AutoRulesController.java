package com.hcicloud.sap.controller.quality;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hcicloud.sap.common.constant.GlobalConstant;
import com.hcicloud.sap.common.utils.ErrorReturnMsg;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.controller.base.BaseController;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.base.SessionInfo;
import com.hcicloud.sap.service.quality.AutoRulesServiceI;
import com.hcicloud.sap.pagemodel.quality.AutoRulesModel;

@Controller
@RequestMapping({ "/autoRules" })
public class AutoRulesController extends BaseController{
	
	@Autowired
	AutoRulesServiceI autoRulesService;
	
	@RequestMapping({ "/manager" })
	public String manager(){
		return "/quality/autoRules";
	}
	
	@RequestMapping({ "dataGrid" })
	@ResponseBody
	public Grid dataGrid(AutoRulesModel autoRulesModel,PageFilter page) {
		Grid grid = new Grid();
		try {
			grid.setAaData(this.autoRulesService.dataGrid(autoRulesModel, page));
			long total = this.autoRulesService.count(autoRulesModel,page);
			grid.setiTotalDisplayRecords(total);
			grid.setiTotalRecords(total);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return grid;
	}
	
	/**
	 * 通过ID获取规则集实例
	 * @param request
	 * @param uuid
	 * @return
	 */
	@RequestMapping({ "/loadById" })
	@ResponseBody
	public Json loadById(HttpServletRequest request, String uuid) {
		Json json = new Json();
		
		try {
			AutoRulesModel autoRulesModel = this.autoRulesService.get(uuid);

			json.setObj(autoRulesModel);
			json.setSuccess(true);
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}
	
	/**
	 * 添加规则集
	 * @param request
	 * @param autoRulesModel
	 * @return
	 */
	@RequestMapping({ "/add" })
	@ResponseBody
	public Json add(AutoRulesModel autoRulesModel,HttpServletRequest request) {
		Json json = new Json();

		if (!this.autoRulesService.isRepeat(autoRulesModel.getName(), null, false)) {
			try {
				SessionInfo sessionInfo = (SessionInfo) request.getSession()
						.getAttribute(GlobalConstant.SESSION_INFO);
					
				autoRulesModel.setUpdateById(sessionInfo.getUuid());
				this.autoRulesService.add(autoRulesModel);
				json.setSuccess(true);
				json.setMsg(ErrorReturnMsg.ADDED_SUCCESSFULLY);
			} catch (Exception e) {
				json.setSuccess(false);
				json.setMsg(ErrorReturnMsg.ADD_OUT_SEARCH_CONDITION_LENGHT_LIMIT);
			}
		} else {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.AUTO_RULES_REPEATED);
		}
		return json;
	}
	
	/**
	 * 编辑规则集类型
	 * @param autoRulesModel
	 * @return
	 */
	@RequestMapping({ "/edit" })
	@ResponseBody
	public Json edit(AutoRulesModel autoRulesModel) {
		Json json = new Json();
		if (!this.autoRulesService.isRepeat(autoRulesModel.getName(),
				autoRulesModel.getUuid(), true)) {
			try {
				SessionInfo sessionInfo = (SessionInfo) request.getSession()
						.getAttribute(GlobalConstant.SESSION_INFO);
					
				autoRulesModel.setUpdateById(sessionInfo.getUuid());
				this.autoRulesService.update(autoRulesModel);
				
				json.setSuccess(true);
				json.setMsg(ErrorReturnMsg.UPDATED_SUCCESSFULLY);
			} catch (Exception e) {
				json.setSuccess(false);
				json.setMsg(ErrorReturnMsg.UPDATE_OUT_SEARCH_CONDITION_LENGHT_LIMIT);
			}
		} else {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.AUTO_RULES_REPEATED);
		}
		return json;
	}
	
	/**
	 * 删除规则集
	 * @param uuid
	 * @return
	 */
	@RequestMapping({ "/delete" })
	@ResponseBody
	public Json delete(String uuid) {
		Json json = new Json();
		try {
			this.autoRulesService.delete(uuid);
			json.setMsg(ErrorReturnMsg.DELETED_SUCCESSFULLY);
			json.setSuccess(true);
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}
	
}