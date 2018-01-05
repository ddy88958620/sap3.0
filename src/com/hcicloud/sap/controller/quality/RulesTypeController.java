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
import com.hcicloud.sap.pagemodel.quality.RulesTypeModel;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.base.SessionInfo;
import com.hcicloud.sap.service.quality.RulesTypeServiceI;

/**
 * 规则集类型
 * @author panxudong
 *
 */
@Controller
@RequestMapping({ "/rulesType" })
public class RulesTypeController extends BaseController {

	@Autowired
	private RulesTypeServiceI rulesTypeService;
	
	@RequestMapping({ "/manager" })
	public String manager(HttpServletRequest request) {
		return "/quality/rulesType";
	}

	/**
	 * 列表
	 * @param rulesTypeModel
	 * @param ph
	 * @return
	 */
	@RequestMapping({ "/dataGrid" })
	@ResponseBody
	public Grid dataGrid(RulesTypeModel rulesTypeModel, PageFilter ph) {
		Grid grid = new Grid();
		try {
			grid.setAaData(this.rulesTypeService.dataGrid(rulesTypeModel, ph));
			long total = this.rulesTypeService.count(rulesTypeModel, ph);
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
			RulesTypeModel rulesTypeModel = this.rulesTypeService.get(uuid);

			json.setObj(rulesTypeModel);
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
	 * @param rulesTypeModel
	 * @return
	 */
	@RequestMapping({ "/add" })
	@ResponseBody
	public Json add(RulesTypeModel rulesTypeModel,HttpServletRequest request) {
		Json j = new Json();

		try {
			if (!this.rulesTypeService.isRepeat(rulesTypeModel.getName(), null, false)) {
				SessionInfo sessionInfo = (SessionInfo) request.getSession()
						.getAttribute(GlobalConstant.SESSION_INFO);
				
				rulesTypeModel.setUpdateById(sessionInfo.getUuid());
				this.rulesTypeService.add(rulesTypeModel);
				
				j.setSuccess(true);
				j.setMsg(ErrorReturnMsg.ADDED_SUCCESSFULLY);
			} else {
				j.setSuccess(false);
				j.setMsg(ErrorReturnMsg.AUTO_RULES_REPEATED);
			}
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return j;
	}
	
	/**
	 * 编辑规则集类型
	 * @param rulesTypeModel
	 * @return
	 */
	@RequestMapping({ "/edit" })
	@ResponseBody
	public Json edit(RulesTypeModel rulesTypeModel) {
		Json j = new Json();
		try {
			if (!this.rulesTypeService.isRepeat(rulesTypeModel.getName(),
					rulesTypeModel.getUuid(), true)) {
				SessionInfo sessionInfo = (SessionInfo) request.getSession()
						.getAttribute(GlobalConstant.SESSION_INFO);
				
				rulesTypeModel.setUpdateById(sessionInfo.getUuid());
				this.rulesTypeService.update(rulesTypeModel);
				
				j.setSuccess(true);
				j.setMsg(ErrorReturnMsg.UPDATED_SUCCESSFULLY);
			} else {
				j.setSuccess(false);
				j.setMsg(ErrorReturnMsg.AUTO_RULES_REPEATED);
			}
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return j;
	}
	
	/**
	 * 删除规则集类型
	 * @param uuid
	 * @return
	 */
	@RequestMapping({ "/delete" })
	@ResponseBody
	public Json delete(String uuid) {
		Json j = new Json();
		try {
			this.rulesTypeService.delete(uuid);
			j.setMsg(ErrorReturnMsg.DELETED_SUCCESSFULLY);
			j.setSuccess(true);
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return j;
	}
}