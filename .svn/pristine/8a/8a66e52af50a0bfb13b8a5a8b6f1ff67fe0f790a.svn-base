package com.hcicloud.sap.controller.interfaces;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hcicloud.sap.service.interfaces.SapInterfaceService;
/**
 * @author dingzhaokai
 * 接口
 */
@Controller
public class SapInterfaceController {

	@Autowired
	private SapInterfaceService sapInterfaceService;
	
	@RequestMapping("/speechPlayer.do")
	@ResponseBody
	public List<Map<String, Object>> getContentById(String callid,HttpServletResponse response){
		response.setHeader("Content-Type", "text/html;charset=utf-8"); 
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			list = sapInterfaceService.getContentById(callid);
			if(list == null || list.size() == 0){
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
