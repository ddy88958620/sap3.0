package com.hcicloud.sap.controller.interfaces;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hcicloud.sap.common.utils.ErrorReturnMsg;
import com.hcicloud.sap.controller.base.BaseController;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.service.interfaces.VoiceAnalysisServiceI;

@Controller
@RequestMapping({ "/interfaces" })
public class VoiceAnalysisController extends BaseController {

	@Autowired
	private VoiceAnalysisServiceI voiceAnalysisService;
	
	@RequestMapping({ "/voiceAnalysis" })
	@ResponseBody
	public Json manager(@RequestBody String voiceAnalysisData) {
		if(voiceAnalysisData == null || "".equals(voiceAnalysisData)) {
			return new Json(false, ErrorReturnMsg.MISSING_INFO, null);
		}
		
		JSONArray jsonArray = JSONArray.fromObject(voiceAnalysisData);
		if(jsonArray.size() <= 0) {
			return new Json(false, ErrorReturnMsg.MISSING_INFO, null);
		}

		return voiceAnalysisService.setDataToRedis(jsonArray);
	}
}