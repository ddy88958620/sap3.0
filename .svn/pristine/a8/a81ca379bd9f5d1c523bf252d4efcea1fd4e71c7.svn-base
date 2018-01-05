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
import com.hcicloud.sap.pagemodel.quality.RuleTypeModel;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.base.SessionInfo;
import com.hcicloud.sap.service.quality.RuleTypeServiceI;

/**
 * 字段设置
 * @author panxudong
 *
 */
@Controller
@RequestMapping({ "/ruleType" })
public class RuleTypeController extends BaseController {

	@Autowired
	private RuleTypeServiceI ruleTypeService;
	
	@RequestMapping({ "/manager" })
	public String manager(HttpServletRequest request) {
		return "/quality/ruleType";
	}

	/**
	 * 列表
	 * @param ruleTypeModel
	 * @param ph
	 * @return
	 */
	@RequestMapping({ "/dataGrid" })
	@ResponseBody
	public Grid dataGrid(RuleTypeModel ruleTypeModel, PageFilter ph) {
		Grid grid = new Grid();
		try {
			grid.setAaData(this.ruleTypeService.dataGrid(ruleTypeModel, ph));
			long total = this.ruleTypeService.count(ruleTypeModel, ph);
			grid.setiTotalDisplayRecords(total);
			grid.setiTotalRecords(total);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return grid;
	}
	
	/**
	 * 通过ID获取用户组实例
	 * @param request
	 * @param uuid
	 * @return
	 */
	@RequestMapping({ "/loadById" })
	@ResponseBody
	public Json loadById(HttpServletRequest request, String uuid) {
		Json json = new Json();
		
		try {
			RuleTypeModel ruleTypeModel = this.ruleTypeService.get(uuid);

			json.setObj(ruleTypeModel);
			json.setSuccess(true);
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}

	/**
	 * 添加规则集类型
	 * @param request
	 * @param ruleTypeModel
	 * @return
	 */
	@RequestMapping({ "/add" })
	@ResponseBody
	public Json add(RuleTypeModel ruleTypeModel,HttpServletRequest request) {
		Json j = new Json();

		try {
			if (!this.ruleTypeService.isRepeat(ruleTypeModel.getName(), null, false)) {
				SessionInfo sessionInfo = (SessionInfo) request.getSession()
						.getAttribute(GlobalConstant.SESSION_INFO);
				
				ruleTypeModel.setUpdateById(sessionInfo.getUuid());
				this.ruleTypeService.add(ruleTypeModel);
				
				j.setSuccess(true);
				j.setMsg(ErrorReturnMsg.ADDED_SUCCESSFULLY);
			} else {
				j.setSuccess(false);
				j.setMsg(ErrorReturnMsg.AUTO_RULE_REPEATED);
			}
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return j;
	}
	
	/**
	 * 编辑规则集类型
	 * @param ruleTypeModel
	 * @return
	 */
	@RequestMapping({ "/edit" })
	@ResponseBody
	public Json edit(RuleTypeModel ruleTypeModel) {
		Json j = new Json();
		try {
			if (!this.ruleTypeService.isRepeat(ruleTypeModel.getName(),
					ruleTypeModel.getUuid(), true)) {
				SessionInfo sessionInfo = (SessionInfo) request.getSession()
						.getAttribute(GlobalConstant.SESSION_INFO);
				
				ruleTypeModel.setUpdateById(sessionInfo.getUuid());
				this.ruleTypeService.update(ruleTypeModel);
				
				j.setSuccess(true);
				j.setMsg(ErrorReturnMsg.UPDATED_SUCCESSFULLY);
			} else {
				j.setSuccess(false);
				j.setMsg(ErrorReturnMsg.AUTO_RULE_REPEATED);
			}
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return j;
	}
	
}