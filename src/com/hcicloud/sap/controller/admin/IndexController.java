package com.hcicloud.sap.controller.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.hcicloud.sap.common.constant.GlobalConstant;
import com.hcicloud.sap.common.utils.ErrorReturnMsg;
import com.hcicloud.sap.common.utils.ListSort;
import com.hcicloud.sap.controller.base.BaseController;
import com.hcicloud.sap.model.admin.Menu;
import com.hcicloud.sap.pagemodel.admin.UserModel;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.base.SessionInfo;
import com.hcicloud.sap.service.admin.UserServiceI;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping({ "/" })
public class IndexController extends BaseController {

	@Autowired
	private UserServiceI userService;


	@RequestMapping({ "/mainPage" })
	public String mainPage(HttpServletRequest request) {
		SessionInfo sessionInfo = (SessionInfo) request.getSession()
				.getAttribute(GlobalConstant.SESSION_INFO);
		boolean isAdmin = sessionInfo.isAdmin();
		try {
			if ((sessionInfo != null) && (sessionInfo.getUuid() != null)) {
				Map<String, List<Menu>> menuMap = userService.getUserMenuMap(sessionInfo.getUuid(),isAdmin);
				ListSort<Menu> listSort= new ListSort<Menu>();  
				List<Menu> listMenu = menuMap.get(null);
				if(listMenu!=null){
					//排序权限菜单
				    listSort.Sort(listMenu, "getPindex", "asc");
				}
				Set<String> menuSet = menuMap.keySet();
				List<Menu> menuNamelList = new ArrayList<Menu>();
				for(String menuPid:menuSet){
					List<Menu> menuList = menuMap.get(menuPid);
					for(Menu menu:menuList){
						if(menu.getUrl()!=null && menu.getUrl().trim().length()>1){
							menuNamelList.add(menu);
						}
					}
				}
				sessionInfo.setMenuList(menuNamelList);
				request.setAttribute("menuMap",menuMap);
				request.setAttribute("userName", sessionInfo.getName());
				return "/main/mainPage";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/dologin";
	}

	@RequestMapping({ "/login" })
	public String login(HttpServletRequest request) {
		return "/login";
	}
	
	@ResponseBody
	@RequestMapping({ "/dologin" })
	public Json dologin(UserModel userModel, HttpSession session) {
		Json j = new Json();
		try {
			UserModel sysuser = this.userService.login(userModel);
			if (sysuser != null) {
				if (sysuser.getState() == 1) {
					j.setSuccess(true);
					j.setMsg(ErrorReturnMsg.LOGIN_SUCCESSFUL);
				}
				else {
					j.setSuccess(false);
					j.setMsg(ErrorReturnMsg.DISABLE_USER);
				}

				SessionInfo sessionInfo = new SessionInfo();
				sessionInfo.setUuid(sysuser.getUuid());
				sessionInfo.setLoginName(sysuser.getLoginName());
				sessionInfo.setName(sysuser.getName());
				sessionInfo.setUserGroupId(sysuser.getUserGroupId());
				sessionInfo.setUserGroupName(sysuser.getUserGroupName());
				if(sysuser.getLoginName().compareToIgnoreCase("admin") == 0){
					sessionInfo.setAdmin(true);
				}
				sessionInfo.setPrivilegeList(this.userService.getPrivilegeList(sysuser.getUuid()));
				/*sessionInfo.setPrivilegeAllList(this.privilegeService.privilegeAllList());
				sessionInfo.setPrivilegeTree(this.privilegeService.tree(sessionInfo));*/

				session.setAttribute(GlobalConstant.SESSION_INFO, sessionInfo);
			} else {
				j.setMsg(ErrorReturnMsg.WRONG_USERNAME_OR_PASSWORD);
			}
		} catch (Exception e) {
			j.setMsg(ErrorReturnMsg.DB_ERROR);
		}
		return j;
	}

	@RequestMapping({ "/logout" })
	public String logout(HttpSession session) {
//		Json j = new Json();
		if (session != null) {
			session.invalidate();
		}
//		j.setSuccess(true);
//		j.setMsg(ErrorReturnMsg.LOGOUT_SUCCESSFUL);
		return "login";
	}
	
	@RequestMapping({ "/home" })
	public String goHomePage() {
		return "/main/home";
	}
	
	
	@RequestMapping({"/getMessages"})
	@ResponseBody
	public Json getMessages(HttpSession session){
		Json json  =  new Json();
		SessionInfo sessionInfo = (SessionInfo) request.getSession()
				.getAttribute(GlobalConstant.SESSION_INFO);
		String uuid = sessionInfo.getUuid();
		List<String> list = userService.getMessages(uuid);
		
		return json;
	}

		
}