package com.hcicloud.sap.controller.quality;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hcicloud.sap.common.constant.GlobalConstant;
import com.hcicloud.sap.common.utils.ErrorReturnMsg;
import com.hcicloud.sap.controller.base.BaseController;
import com.hcicloud.sap.pagemodel.base.JQGrid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.base.SessionInfo;
import com.hcicloud.sap.pagemodel.quality.RuleModel;
import com.hcicloud.sap.pagemodel.quality.RulesModel;
import com.hcicloud.sap.service.quality.RulesServiceI;

/**
 * 规则集
 * @author lixianji
 *
 */
@Controller
@RequestMapping({ "/rules" })
public class RulesController extends BaseController {

	@Autowired
	private RulesServiceI rulesService;
	
	@RequestMapping({ "/manager" })
	public String manager(HttpServletRequest request) {
		return "/quality/rules";
	}
	
	@RequestMapping({ "/addPage" })
    public String addPage(HttpServletRequest request) {
        return "/quality/rulesAdd";
    }
	
	@RequestMapping({ "/editPage" })
    public String editPage(HttpServletRequest request) {
        return "/quality/rulesEdit";
    }

	/**
	 * 列表
	 * @param rulesModel
	 * @param rows
	 * @param page
	 * @return
	 */
	@RequestMapping({ "/dataGrid" })
	@ResponseBody
	public JQGrid<RulesModel> dataGrid(RulesModel rulesModel, int rows, int page) {
		JQGrid<RulesModel> grid = new JQGrid<RulesModel>(); 

		try {
			long count = rulesService.count(rulesModel);
			grid.setPage(page);
			grid.setRecords(count);
			grid.setRows(rulesService.dataGrid(rulesModel, rows, page));
			grid.setTotal((long)Math.ceil((double)count/(double)rows));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return grid;
	}
	
	/**
	 * 获取指定规则集下的规则
	 * @param uuid
	 * @return
	 */
	@RequestMapping({ "/getRuleByRulesId" })
	@ResponseBody
	public List<RuleModel> getRuleByRulesId(String uuid) {
		List<RuleModel> list = new ArrayList<RuleModel>();
		try {
			list = this.rulesService.getRuleByRulesId(uuid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
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
			RulesModel rulesModel = this.rulesService.get(uuid);

			json.setObj(rulesModel);
			json.setSuccess(true);
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}
	
	/**
	 * 获取规则集类型相关信息
	 * @param request
	 * @return
	 */
	@RequestMapping({"/getRulesTypeInfo"})
	@ResponseBody
	public Json getRulesTypeInfo(HttpServletRequest request) {
		Json json = new Json();
		try {
			json = this.rulesService.getRulesTypeInfo();
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}
	
	/**
	 * 获取表单相关信息
	 * @param request
	 * @return
	 */
	@RequestMapping({"/getFormInfo"})
	@ResponseBody
	public Json getFormInfo(HttpServletRequest request, String uuid) {
		Json json = new Json();
		try {
			json = this.rulesService.getFormInfo(uuid);
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}
	
	/**
	 * 添加规则集
	 * @param request
	 * @param rulesModel
	 * @return
	 */
	@RequestMapping({ "/add" })
	@ResponseBody
	public Json add(String json, HttpServletRequest request) {
		Json j = new Json();
		
		try {
			SessionInfo sessionInfo = (SessionInfo) request.getSession().getAttribute(GlobalConstant.SESSION_INFO);
			
			this.rulesService.add(json, sessionInfo);
			
			j.setSuccess(true);
			j.setMsg(ErrorReturnMsg.ADDED_SUCCESSFULLY);
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		
		return j;
	}
	
	/**
	 * 编辑规则集
	 * @param rulesModel
	 * @return
	 */
	@RequestMapping({ "/edit" })
	@ResponseBody
	public Json edit(RulesModel rulesModel) {
		Json j = new Json();
//		if (!this.rulesService.isRepeat(rulesModel.getName(),
//				rulesModel.getUuid(), true)) {
//			try {
//				SessionInfo sessionInfo = (SessionInfo) request.getSession()
//						.getAttribute(GlobalConstant.SESSION_INFO);
//					
//				rulesModel.setUpdateById(sessionInfo.getUuid());
//				this.rulesService.update(rulesModel);
//				
//				j.setSuccess(true);
//				j.setMsg(error);
//			} catch (Exception e) {
//				j.setSuccess(false);
//				j.setMsg(e.getMessage());
//			}
//		} else {
//			j.setSuccess(false);
//			j.setMsg("规则集名称重复，请重新输入！");
//		}
		return j;
	}
}