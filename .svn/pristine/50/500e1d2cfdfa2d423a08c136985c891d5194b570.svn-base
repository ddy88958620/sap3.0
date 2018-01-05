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
import com.hcicloud.sap.pagemodel.admin.UserGroupModel;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.base.SessionInfo;
import com.hcicloud.sap.service.admin.UserGroupServiceI;

/**
 * 用户组管理
 * @author panxudong
 *
 */
@Controller
@RequestMapping({ "/userGroup" })
public class UserGroupController extends BaseController {

	@Autowired
	private UserGroupServiceI userGroupService;

	@RequestMapping({ "/manager" })
	public String manager(HttpServletRequest request) {
		return "/admin/userGroup";
	}

	/**
	 * 列表
	 * @param userGroupModel
	 * @param ph
	 * @return
	 */
	@RequestMapping({ "/dataGrid" })
	@ResponseBody
	public Grid dataGrid(UserGroupModel userGroupModel, PageFilter ph) {
		Grid grid = new Grid();
		try {
			grid.setAaData(this.userGroupService.dataGrid(userGroupModel, ph));
			long total = this.userGroupService.count(userGroupModel, ph);
			grid.setiTotalDisplayRecords(total);
			grid.setiTotalRecords(total);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return grid;
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
			UserGroupModel userGroupModel = this.userGroupService.get(uuid);

			json.setObj(userGroupModel);
			json.setSuccess(true);
		} catch (Exception e) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return json;
	}

	/**
	 * 添加用户组
	 * @param request
	 * @param userGroupModel
	 * @return
	 */
	@RequestMapping({ "/add" })
	@ResponseBody
	public Json add( UserGroupModel userGroupModel,HttpServletRequest request) {
		Json j = new Json();

		try {
			if (!this.userGroupService.isRepeat(userGroupModel.getName(), null, false)) {
				SessionInfo sessionInfo = (SessionInfo) request.getSession()
						.getAttribute(GlobalConstant.SESSION_INFO);
				
				userGroupModel.setUpdateById(sessionInfo.getUuid());
				this.userGroupService.add(userGroupModel);
				
				j.setSuccess(true);
				j.setMsg(ErrorReturnMsg.ADDED_SUCCESSFULLY);
			} else {
				j.setSuccess(false);
				j.setMsg(ErrorReturnMsg.USERGROUPNAME_REPEATED);
			}
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return j;
	}
	
	/**
	 * 编辑用户组
	 * @param userGroupModel
	 * @return
	 */
	@RequestMapping({ "/edit" })
	@ResponseBody
	public Json edit(UserGroupModel userGroupModel) {
		Json j = new Json();
		try {
			if (!this.userGroupService.isRepeat(userGroupModel.getName(),
					userGroupModel.getUuid(), true)) {
				SessionInfo sessionInfo = (SessionInfo) request.getSession()
						.getAttribute(GlobalConstant.SESSION_INFO);
				
				userGroupModel.setUpdateById(sessionInfo.getUuid());
				this.userGroupService.update(userGroupModel);
				
				j.setSuccess(true);
				j.setMsg(ErrorReturnMsg.UPDATED_SUCCESSFULLY);
			} else {
				j.setSuccess(false);
				j.setMsg(ErrorReturnMsg.USERGROUPNAME_REPEATED);
			}
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return j;
	}
	
	/**
	 * 删除用户组
	 * @param uuid
	 * @return
	 */
	@RequestMapping({ "/delete" })
	@ResponseBody
	public Json delete(String uuid) {
		Json j = new Json();
		try {
			this.userGroupService.delete(uuid);
			j.setMsg(ErrorReturnMsg.DELETED_SUCCESSFULLY);
			j.setSuccess(true);
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return j;
	}
}