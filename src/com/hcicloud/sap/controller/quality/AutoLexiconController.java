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
import com.hcicloud.sap.pagemodel.quality.AutoLexiconModel;
import com.hcicloud.sap.service.quality.AutoLexiconServiceI;

@Controller
@RequestMapping({ "/autoRuleLexicon" })
public class AutoLexiconController extends BaseController{
	@Autowired
	AutoLexiconServiceI autoLexiconService;
	
	@RequestMapping({ "/manager" })
	public String manager(){
		return "/quality/autoLexicon";
	}
	
	@RequestMapping({ "dataGrid" })
	@ResponseBody
	public Grid dataGrid(AutoLexiconModel autoLexiconModel,PageFilter page) {
		Grid grid = new Grid();
		try {
			grid.setAaData(this.autoLexiconService.dataGrid(autoLexiconModel, page));
			long total = this.autoLexiconService.count(autoLexiconModel,page);
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
			AutoLexiconModel autoLexiconModel = this.autoLexiconService.get(uuid);

			json.setObj(autoLexiconModel);
			json.setSuccess(true);
		} catch (Exception e) {
			json.setMsg(ErrorReturnMsg.DB_ERROR);
			json.setSuccess(false);
		}
		return json;
	}
	/**
	 * 添加规则集
	 * @param request
	 * @param autoLexiconModel
	 * @return
	 */
	@RequestMapping({ "/add" })
	@ResponseBody
	public Json add(AutoLexiconModel autoLexiconModel,HttpServletRequest request) {
		Json json = new Json();

		try {
			if (!this.autoLexiconService.isRepeat(autoLexiconModel.getName(), null, false)) {
				SessionInfo sessionInfo = (SessionInfo) request.getSession()
						.getAttribute(GlobalConstant.SESSION_INFO);
					
				autoLexiconModel.setUpdateUserId(sessionInfo.getUuid());
				this.autoLexiconService.add(autoLexiconModel);
				
				json.setSuccess(true);
				json.setMsg(ErrorReturnMsg.ADDED_SUCCESSFULLY);
			} else {
				json.setSuccess(false);
				json.setMsg(ErrorReturnMsg.AUTO_LEXICON_REPEATED);
			}
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}
	/**
	 * 编辑通用词组
	 * @param autoLexiconModel
	 * @return
	 */
	@RequestMapping({ "/edit" })
	@ResponseBody
	public Json edit(AutoLexiconModel autoLexiconModel) {
		Json json = new Json();
		try {
			if (!this.autoLexiconService.isRepeat(autoLexiconModel.getName(),
					autoLexiconModel.getUuid(), true)) {
				SessionInfo sessionInfo = (SessionInfo) request.getSession()
						.getAttribute(GlobalConstant.SESSION_INFO);
					
				autoLexiconModel.setUpdateUserId(sessionInfo.getUuid());
				this.autoLexiconService.update(autoLexiconModel);
				
				json.setSuccess(true);
				json.setMsg(ErrorReturnMsg.UPDATED_SUCCESSFULLY);
			} else {
				json.setSuccess(false);
				json.setMsg(ErrorReturnMsg.AUTO_LEXICON_REPEATED);
			}
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
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
			this.autoLexiconService.delete(uuid);
			json.setMsg(ErrorReturnMsg.DELETED_SUCCESSFULLY);
			json.setSuccess(true);
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}
}
