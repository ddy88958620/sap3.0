package com.hcicloud.sap.controller.admin;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.constant.GlobalConstant;
import com.hcicloud.sap.common.utils.ErrorReturnMsg;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.controller.base.BaseController;
import com.hcicloud.sap.pagemodel.admin.UserModel;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.base.SessionInfo;
import com.hcicloud.sap.service.admin.UserServiceI;

@Controller
@RequestMapping({ "/user" })
public class UserController extends BaseController {

	@Autowired
	private UserServiceI userService;
	
	@RequestMapping({ "/manager" })
	public String manager(HttpServletRequest request) {
		return "/admin/user";
	}
	
	/**
	 * 列表
	 * @param userModel
	 * @param ph
	 * @return
	 */
	@RequestMapping({ "/dataGrid" })
	@ResponseBody
	public Grid dataGrid(UserModel userModel, PageFilter ph) {
		Grid grid = new Grid();
		try {
			grid.setAaData(this.userService.dataGrid(userModel, ph));
			long total = this.userService.count(userModel, ph);
			grid.setiTotalDisplayRecords(total);
			grid.setiTotalRecords(total);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return grid;
	}
	
	/**
	 * 通过ID获取用户实例
	 * @param request
	 * @param uuid
	 * @return
	 */
	@RequestMapping({ "/loadById" })
	@ResponseBody
	public Json loadById(HttpServletRequest request, String uuid) {
		Json json = new Json();
		try {
			UserModel userModel = this.userService.get(uuid);
			
			json = this.userService.getFormInfo(new Json());
			JSONObject jsonObject = (JSONObject) json.getObj();
			jsonObject.put("user", userModel);
			json.setObj(jsonObject);
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		
		return json;
	}
	
	/**
	 * 获取用户组相关信息
	 * @param request
	 * @return
	 */
	@RequestMapping({"/getUserGroupInfo"})
	@ResponseBody
	public Json getUserGroupInfo(HttpServletRequest request) {
		Json json = new Json();
		try {
			json = this.userService.getUserGroupInfo(new Json(),true);
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
	public Json getFormInfo(HttpServletRequest request) {
		Json json = new Json();
		try {
			json = this.userService.getFormInfo(new Json());
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}
	
	/**
	 * 获取状态相关信息
	 * @param request
	 * @return
	 */
	@RequestMapping({"/getStateInfo"})
	@ResponseBody
	public Json getStateInfo(HttpServletRequest request, String uuid) {
		Json json = new Json(); 
		try {
			json.setSuccess(true);
			
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("stateList", GlobalConstant.statelist);
			
			UserModel userModel = this.userService.get(uuid);
			jsonObject.put("state", userModel.getState());
			
			json.setObj(jsonObject);
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		
		return json;
	}
	
	/**
	 * 添加用户
	 * @param request
	 * @param userModel
	 * @return
	 */
	@RequestMapping({ "/add" })
	@ResponseBody
	public Json add( UserModel userModel,HttpServletRequest request) {
		Json j = new Json();

		try {
			if (!this.userService.isRepeat(userModel.getLoginName(), null, false)) {
				SessionInfo sessionInfo = (SessionInfo) request.getSession()
						.getAttribute(GlobalConstant.SESSION_INFO);
				
				userModel.setUpdateById(sessionInfo.getUuid());
				this.userService.add(userModel);
				
				j.setSuccess(true);
				j.setMsg(ErrorReturnMsg.ADDED_SUCCESSFULLY);
			} else {
				j.setSuccess(false);
				j.setMsg(ErrorReturnMsg.USERNAME_REPEATED);
			}
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return j;
	}
	
	/**
	 * 编辑用户
	 * @param userModel
	 * @return
	 */
	@RequestMapping({ "/edit" })
	@ResponseBody
	public Json edit(UserModel userModel) {
		Json j = new Json();
		try {
			if (!this.userService.isRepeat(userModel.getLoginName(),userModel.getUuid(), true)) {
				SessionInfo sessionInfo = (SessionInfo) request.getSession()
						.getAttribute(GlobalConstant.SESSION_INFO);
				
				userModel.setUpdateById(sessionInfo.getUuid());
				this.userService.update(userModel);
				j.setSuccess(true);
				j.setMsg(ErrorReturnMsg.UPDATED_SUCCESSFULLY);
			} else {
				j.setSuccess(false);
				j.setMsg(ErrorReturnMsg.USERNAME_REPEATED);
			}
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return j;
	}
	
	/**
	 * 删除用户
	 * @param uuid
	 * @return
	 */
	@RequestMapping({ "/delete" })
	@ResponseBody
	public Json delete(String uuid) {
		Json json = new Json();
		try {
			this.userService.delete(uuid);
			json.setSuccess(true);
			json.setMsg(ErrorReturnMsg.DELETED_SUCCESSFULLY);
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}
	
	
	/**
	 * 重置密码
	 * @param userModel
	 * @return
	 */
	@RequestMapping({ "/password" })
	@ResponseBody
	public Json password(UserModel userModel) {
		Json j = new Json();
		
		try {
			SessionInfo sessionInfo = (SessionInfo) request.getSession()
					.getAttribute(GlobalConstant.SESSION_INFO);
				
			userModel.setUpdateById(sessionInfo.getUuid());
			this.userService.password(userModel);
			
			j.setSuccess(true);
			j.setMsg(ErrorReturnMsg.RESET_PASSWORD_SUCCESSFULLY);
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		
		return j;
	}
	
	/**
	 * @Description: 用户修改密码 
	 * @param oldPassword
	 * @param newPassword
	 * @return CommonActionResult
	 * @throws
	 */
	@RequestMapping({ "/changePassword" })
	@ResponseBody
	public Json changePassword(String oldPassword,String newPassword) {
		Json json = new Json();
		
		try {
			SessionInfo sessionInfo = (SessionInfo) request.getSession().getAttribute(GlobalConstant.SESSION_INFO);
			json = this.userService.changePassword(sessionInfo.getUuid(),oldPassword,newPassword);
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		
		return json;
	}
}