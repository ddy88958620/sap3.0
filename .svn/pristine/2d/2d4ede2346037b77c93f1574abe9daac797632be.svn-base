package com.hcicloud.sap.controller.online;



import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.constant.GlobalConstant;
import com.hcicloud.sap.controller.base.BaseController;
import com.hcicloud.sap.pagemodel.base.SessionInfo;
import com.hcicloud.sap.service.online.SeatServiceI;


/** 
 * @Package com.sinovoice.hcicloud.controller.monitor
 * @author liuxiang
 * @date 2015年8月24日 上午9:24:38
 */
@Controller
@RequestMapping({"/seat"})
public class SeatController  extends BaseController{

	@Autowired
	SeatServiceI seatService;
	
	Logger log = Logger.getLogger(SeatController.class);
	/**
	 * 跳转到坐席界面
	 */
	@RequestMapping({"/manager"})
	public String seatPage(){
		return "/online/seat";
	}

	@RequestMapping({ "/getMessage" })
	@ResponseBody
	public JSONObject getMessage(String callId,long callLength,long captainLength){
			SessionInfo sessionInfo = (SessionInfo)request.getSession().getAttribute(GlobalConstant.SESSION_INFO);
			String uuid = sessionInfo.getUuid();
			return this.seatService.getMessage(uuid,callId,callLength,captainLength);
	}
}
