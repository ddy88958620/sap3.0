package com.hcicloud.sap.controller.admin;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hcicloud.sap.common.utils.ErrorReturnMsg;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.controller.base.BaseController;
import com.hcicloud.sap.model.admin.SystemParam;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.service.admin.SystemParamServiceI;

@Controller
@RequestMapping({ "/systemParam" })
public class SystemParamController extends BaseController {

	@Autowired
	private SystemParamServiceI systemParamService;
	
	@RequestMapping({ "/manager" })
	public String manager(HttpServletRequest request) {
		return "/admin/systemParam";
	}
	
	/**
	 * 列表
	 * @param systemParam
	 * @param ph
	 * @return
	 */
	@RequestMapping({ "/dataGrid" })
	@ResponseBody
	public Grid dataGrid(SystemParam systemParam, PageFilter ph) {
		Grid grid = new Grid();
		try {
			grid.setAaData(this.systemParamService.dataGrid(systemParam, ph));
			long total = this.systemParamService.count(systemParam, ph);
			grid.setiTotalDisplayRecords(total);
			grid.setiTotalRecords(total);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return grid;
	}
	
	/**
	 * 通过ID获取系统参数实例
	 * @param request
	 * @param uuid
	 * @return
	 */
	@RequestMapping({ "/loadById" })
	@ResponseBody
	public Json loadById(HttpServletRequest request, String uuid) {
		Json json = new Json();
		try {
			SystemParam systemParam = this.systemParamService.get(uuid);
			
			json.setSuccess(true);
			json.setObj(systemParam);
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		
		return json;
	}
	
	/**
	 * 添加系统参数
	 * @param request
	 * @param systemParam
	 * @return
	 */
	@RequestMapping({ "/add" })
	@ResponseBody
	public Json add(SystemParam systemParam,HttpServletRequest request) {
		Json j = new Json();

		try {
			if (!this.systemParamService.isRepeat(systemParam.getName(), null, false)) {
				this.systemParamService.add(systemParam);
				
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
	 * 编辑系统参数
	 * @param systemParam
	 * @return
	 */
	@RequestMapping({ "/edit" })
	@ResponseBody
	public Json edit(SystemParam systemParam) {
		Json j = new Json();
		try {
			if (!this.systemParamService.isRepeat(systemParam.getName(),systemParam.getUuid(), true)) {
				this.systemParamService.update(systemParam);
				
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
}