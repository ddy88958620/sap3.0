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
import com.hcicloud.sap.pagemodel.quality.StandardSpeechModel;
import com.hcicloud.sap.service.quality.StandardSpeechI;

@Controller
@RequestMapping({ "/standardSpeech" })
public class StandardSpeechController extends BaseController {
	
	@Autowired
	StandardSpeechI standardSpeechService;
	
	@RequestMapping({ "/manager" })
	public String manager(){
		return "/quality/standardSpeech";
	}
	
	@RequestMapping({ "dataGrid" })
	@ResponseBody
	public Grid dataGrid(StandardSpeechModel standardSpeechModel,PageFilter page) {
		SessionInfo sessionInfo = (SessionInfo) request.getSession()
				.getAttribute(GlobalConstant.SESSION_INFO);
		Grid grid = new Grid();
		try {
			grid.setAaData(this.standardSpeechService.dataGrid(standardSpeechModel, page, sessionInfo));
			long total = this.standardSpeechService.count(standardSpeechModel,page, sessionInfo);
			grid.setiTotalDisplayRecords(total);
			grid.setiTotalRecords(total);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return grid;
	}
	
	/**
	 * 通过ID获取标准话术实例
	 * @param request
	 * @param uuid
	 * @return
	 */
	@RequestMapping({ "/loadById" })
	@ResponseBody
	public Json loadById(HttpServletRequest request, String uuid) {
		Json json = new Json();
		
		try {
			StandardSpeechModel standardSpeechModel = this.standardSpeechService.get(uuid);

			json.setObj(standardSpeechModel);
			json.setSuccess(true);
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}
	
	/**
	 * 添加标准话术
	 * @param request
	 * @param standardSpeechModel
	 * @return
	 */
	@RequestMapping({ "/add" })
	@ResponseBody
	public Json add(StandardSpeechModel standardSpeechModel,HttpServletRequest request) {
		Json json = new Json();
		try {
			if (!this.standardSpeechService.isRepeat(standardSpeechModel.getName(), null, false)) {
				SessionInfo sessionInfo = (SessionInfo) request.getSession()
						.getAttribute(GlobalConstant.SESSION_INFO);
				
				standardSpeechModel.setUpdateById(sessionInfo.getUuid());
				String msg = this.standardSpeechService.add(standardSpeechModel);
				if("OK".equals(msg)) {
					json.setSuccess(true);
					json.setMsg(ErrorReturnMsg.ADDED_SUCCESSFULLY);
				}else {
					json.setSuccess(false);
					json.setMsg(msg);
				}
			} else {
				json.setSuccess(false);
				json.setMsg(ErrorReturnMsg.STANDAR_SPEECH_REPEATED);
			}
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}
	
	/**
	 * 编辑标准话术
	 * @param standardSpeechModel
	 * @return
	 */
	@RequestMapping({ "/edit" })
	@ResponseBody
	public Json edit(StandardSpeechModel standardSpeechModel) {
		Json json = new Json();
		try {
			if (!this.standardSpeechService.isRepeat(standardSpeechModel.getName(),
					standardSpeechModel.getUuid(), true)) {
				SessionInfo sessionInfo = (SessionInfo) request.getSession()
						.getAttribute(GlobalConstant.SESSION_INFO);
				
				standardSpeechModel.setUpdateById(sessionInfo.getUuid());
				String msg = this.standardSpeechService.update(standardSpeechModel);
				if("OK".equals(msg)) {
					json.setSuccess(true);
					json.setMsg(ErrorReturnMsg.ADDED_SUCCESSFULLY);
				}else {
					json.setSuccess(false);
					json.setMsg(msg);
				}
			} else {
				json.setSuccess(false);
				json.setMsg(ErrorReturnMsg.STANDAR_SPEECH_REPEATED);
			}
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}
	
	/**
	 * 删除标准话术
	 * @param uuid
	 * @return
	 */
	@RequestMapping({ "/delete" })
	@ResponseBody
	public Json delete(String uuid) {
		Json json = new Json();
		try {
			String msg = this.standardSpeechService.delete(uuid);
			if("OK".equals(msg)) {
				json.setSuccess(true);
				json.setMsg(ErrorReturnMsg.DELETED_SUCCESSFULLY);
			}else {
				json.setSuccess(false);
				json.setMsg(msg);
			}
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}
}
