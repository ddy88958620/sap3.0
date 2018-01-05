package com.hcicloud.sap.controller.hotword;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.constant.GlobalConstant;
import com.hcicloud.sap.common.network.ESMethod;
import com.hcicloud.sap.common.utils.ErrorReturnMsg;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.common.utils.StringUtil;
import com.hcicloud.sap.controller.base.BaseController;
import com.hcicloud.sap.model.admin.UserRoleRelation;
import com.hcicloud.sap.model.quality.SearchInfo;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.base.SessionInfo;
import com.hcicloud.sap.pagemodel.hotword.HotWordModel;
import com.hcicloud.sap.pagemodel.voice.VoiceModel;
import com.hcicloud.sap.service.hotword.HotWordServiceI;
import com.hcicloud.sap.service.voice.SearchServiceI;
@Controller
@RequestMapping({ "/topic" })
public class HotWordController extends BaseController{
	    @Autowired
	    HotWordServiceI hotWordService;
	    
	    @RequestMapping({ "/hotword" })
	    public String manager() {
	        return "/hotword/hotword";
	    }
	    @RequestMapping({ "/getSearchFormInfo" })
	    @ResponseBody
	    public Json getSearchFormInfo() {
	    	Json json = new Json();
	    	try {
				json = hotWordService.getSearchFormInfo();
			} catch (Exception e) {
				json.setSuccess(false);
				json.setMsg(ErrorReturnMsg.DB_ERROR);
			}
	    	return json;
	    }
	    @RequestMapping({ "/dataGrid" })
	    @ResponseBody
	    public Grid dataGrid(HotWordModel v) {
	        Grid grid = this.hotWordService.dataGrid(v);
	        return grid;
	    }

}
