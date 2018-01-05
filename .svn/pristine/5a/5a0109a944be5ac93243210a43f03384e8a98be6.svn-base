package com.hcicloud.sap.controller.success;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hcicloud.sap.common.utils.ErrorReturnMsg;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.success.SuccessModal;
import com.hcicloud.sap.pagemodel.success.SuccessRecordModel;
import com.hcicloud.sap.service.success.SuccessRecordService;


@Controller
@RequestMapping("/record")
public class SuccessRecordController {
	
	@Autowired
	private  SuccessRecordService successRecordService;
	
    @RequestMapping("/getSuccessList")
    @ResponseBody
    public Grid getSuccessList(SuccessRecordModel model, PageFilter pf) {
    	Grid grid = new Grid();
		try {
	        grid = successRecordService.getSuccessList(model, pf);
			
		} catch (Exception e) {
			grid.setMessage(e.getMessage());
		}
		return grid;
    }

    
	/**
	 * 获取所有平台
	 * @return
	 */
	@RequestMapping({ "getPlaytForms" })
	@ResponseBody
	public Json getPlaytForms(){
		Json json = new Json();
		try {
			json =successRecordService.getPlaytForms();
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}
  
}
