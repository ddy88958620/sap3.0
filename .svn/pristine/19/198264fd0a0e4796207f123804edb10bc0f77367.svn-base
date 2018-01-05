package com.hcicloud.sap.controller.admin;

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
import com.hcicloud.sap.pagemodel.admin.HotwordModel;
import com.hcicloud.sap.service.admin.HotwordI;

@Controller
@RequestMapping({ "/hotword" })
public class HotwordController extends BaseController {
	
	@Autowired
	HotwordI hotwordService;
	
	@RequestMapping({ "/manager" })
	public String manager(HttpServletRequest request){
		return "/admin/hotword";
	}
	
	@RequestMapping({ "dataGrid" })
	@ResponseBody
	public Grid dataGrid(HotwordModel hotwordModel,PageFilter page) {
		Grid grid = new Grid();
		try {
			grid.setAaData(this.hotwordService.dataGrid(hotwordModel, page));
			long total = this.hotwordService.count(hotwordModel,page);
			grid.setiTotalDisplayRecords(total);
			grid.setiTotalRecords(total);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return grid;
	}
	
	/**
	 * 通过ID获取关键词实例
	 * @param request
	 * @param uuid
	 * @return
	 */
	@RequestMapping({ "/loadById" })
	@ResponseBody
	public Json loadById(HttpServletRequest request, String uuid) {
		Json json = new Json();
		
		try {
			HotwordModel hotwordModel = this.hotwordService.get(uuid);

			json.setObj(hotwordModel);
			json.setSuccess(true);
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}
	
	/**
	 * 添加关键词
	 * @param request
	 * @param HotwordModel
	 * @return
	 */
	@RequestMapping({ "/add" })
	@ResponseBody
	public Json add(HotwordModel hotwordModel,HttpServletRequest request) {
		Json json = new Json();
		try {
			if (!this.hotwordService.isRepeat(hotwordModel.getContent(), null, false)) {
				SessionInfo sessionInfo = (SessionInfo) request.getSession()
						.getAttribute(GlobalConstant.SESSION_INFO);
				
				hotwordModel.setUpdateById(sessionInfo.getUuid());
				this.hotwordService.add(hotwordModel);
				
				json.setSuccess(true);
				json.setMsg(ErrorReturnMsg.ADDED_SUCCESSFULLY);
			} else {
				json.setSuccess(false);
				json.setMsg(ErrorReturnMsg.HOTWORD_REPEATED);
			}
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}
	
	/**
	 * 编辑关键词
	 * @param HotwordModel
	 * @return
	 */
	@RequestMapping({ "/edit" })
	@ResponseBody
	public Json edit(HotwordModel hotwordModel) {
		Json json = new Json();
		try {
			if (!this.hotwordService.isRepeat(hotwordModel.getContent(),
					hotwordModel.getUuid(), true)) {
				SessionInfo sessionInfo = (SessionInfo) request.getSession()
						.getAttribute(GlobalConstant.SESSION_INFO);
				
				hotwordModel.setUpdateById(sessionInfo.getUuid());
				this.hotwordService.update(hotwordModel);
				
				json.setSuccess(true);
				json.setMsg(ErrorReturnMsg.UPDATED_SUCCESSFULLY);
			} else {
				json.setSuccess(false);
				json.setMsg(ErrorReturnMsg.HOTWORD_REPEATED);
			}
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}
	
	/**
	 * 删除关键词
	 * @param uuid
	 * @return
	 */
	@RequestMapping({ "/delete" })
	@ResponseBody
	public Json delete(String uuid) { 
		Json json = new Json();
		try {
			this.hotwordService.delete(uuid);
			json.setMsg(ErrorReturnMsg.DELETED_SUCCESSFULLY);
			json.setSuccess(true);
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}
	
	@RequestMapping({ "/sync" })
	@ResponseBody
	public Json syncHotword() {
		Json json = new Json();
		try {
			json = this.hotwordService.syncHotword();
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}
}
