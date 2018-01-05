<%@page import="com.hcicloud.sap.model.admin.Menu"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html  lang="en">
<%
	String userName = (String) request.getAttribute("userName");
	userName = userName.length()>10?userName.substring(0, 10):userName;
	Map<String,List<Menu>> menuobj = (Map<String, List<Menu>>)request.getAttribute("menuMap");
	//String countLineNum = (String) request.getAttribute("countLineNum");
%>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<title>灵云智能语音分析系统</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/bootstrap.css">
<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/font-awesome.css">
<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/ace-fonts.css">
<link rel="stylesheet" href="${ctx }/css/ace/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
<!--[if lte IE 9]>
	<link rel="stylesheet" href="${ctx }/css/ace/ace-part2.css" class="ace-main-stylesheet" />
<![endif]-->

<!--[if lte IE 9]>
  <link rel="stylesheet" href="${ctx }/css/ace/ace-ie.css" />
<![endif]-->


<!-- ace settings handler -->
<script src="${ctx }/js/jquery-1.11.1.min.js"></script>	
<script src="${ctx }/js/ace/ace-extra.js"></script>
<script src="${ctx }/js/ace/bootstrap.js"></script>
<script type="text/javascript" src="${ctx }/js/md5.js"></script>
<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->

<!--[if lte IE 8]>
<script src="${ctx }/js/ace/html5shiv.js"></script>
<script src="${ctx }/js/ace/respond.js"></script>
<![endif]-->
	<style type="text/css">

	</style>
<script type="text/javascript">
	
	function mouseEnter(id){
		if ((id<10 && id>0) || (id>10000 && id<30000)) {
			$("#a000"+id).css("background","url(./img/button_pressed.png) no-repeat");
			$("#a000"+id).css("color","#1876C9");
		}else{
			$("#a"+id).css("background","url(./img/button_pressed.png) no-repeat");
			$("#a"+id).css("color","#1876C9");
		}
		
	}
	function mouseLeave(id){
		if ((id<10 && id>0) || (id>10000 && id<30000)) {
			if($("#a000"+id).hasClass("select")){
				$("#a000"+id).css("background","url(./img/button_pressed.png) no-repeat");
				$("#a000"+id).css("color","#1876C9");
			}else{
				$("#a000"+id).css("background","url(./img/button_normal.png) no-repeat");
				$("#a000"+id).css("color","#ECEEED");
			}
		}else{
			if($("#a"+id).hasClass("select")){
				$("#a"+id).css("background","url(./img/button_pressed.png) no-repeat");
				$("#a"+id).css("color","#1876C9");
			}else{
				$("#a"+id).css("background","url(./img/button_normal.png) no-repeat");
				$("#a"+id).css("color","#ECEEED");
			}
		}
		
	}
	 $(function(){
		 $(".submenu").each(function(){
			var liCount= $(this).find("li").length;
			$(this).css("height",liCount*40);
		 })
 
		if((navigator.userAgent.indexOf('MSIE') >= 0)){
			$(".navbar-nav>li").each(function(){
				$(this).css("border-left","1px solid #004266");
			});
			$(".navbar-nav>li:last-child").css("border-right","1px solid #004266");
		} 

		 fixHeight();
		 setTimeout(function(){fixHeight();}, 1000);
			$("#exitSystem").on('show.bs.modal', function (e) {  
			    $(this).find('.modal-dialog').css({  
			        'margin-top': function () {  
			            var modalHeight = $('#exitSystem').find('.modal-dialog').height();  
			            return ($(window).height() / 2 - (modalHeight / 2)-200);  
			        }  
			    });      
			}); 
			 var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
			 var isOpera = userAgent.indexOf("Opera") > -1;
			 if (!(userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera)){
				 $("#navbar").css("z-index","0");
			 }
		});	
	 var preWidth=document.documentElement.clientWidth;
	 $(window).resize(function() {
		 var nextWidth=document.documentElement.clientWidth;
		 if(preWidth<nextWidth){
			 fixHeight();
		 }
	
		});
	function openPage(url,pid){
		var checkUrl = url.substring(url.lastIndexOf("/"),url.length);
		if(checkUrl.length>3){
			if ((pid<10 && pid>0) || (pid>10000 && pid<30000)) {
				$(".select").css("background","url(./img/button_normal.png) no-repeat");
				$(".select").css("color","#ECEEED");
				$(".select").css("font-weight","normal");
				$(".select").removeClass("select");
				$("#a000"+pid).css("background","url(./img/button_pressed.png) no-repeat");
				$("#a000"+pid).css("color","#1876C9");
				$("#a000"+pid).css("font-weight","bolder");
				$("#a000"+pid).addClass("select");
				$("#page-content-area").attr("src",url);
			}else{
				$(".select").css("background","url(./img/button_normal.png) no-repeat");
				$(".select").css("color","#ECEEED");
				$(".select").css("font-weight","normal");
				$(".select").removeClass("select");
				$("#a"+pid).css("background","url(./img/button_pressed.png) no-repeat");
				$("#a"+pid).css("color","#1876C9");
				$("#a"+pid).css("font-weight","bolder");
				$("#a"+pid).addClass("select");
				$("#page-content-area").attr("src",url);
			}
		}
	}
	function fixHeight(){
		var fullHeight = document.documentElement.clientHeight;
		var fullWidth = document.documentElement.clientWidth;
		var navHeight = $("#navbar").height();
		var sidebarHeight = $("#sidebar").height();
		var fixHeight = fullHeight - navHeight - sidebarHeight;
		var navWidth = $("#navbar").width();
		var subNavWidth = $("#sub-navbar").width();
		var sidebarWidth = $("#sidebar").width();
		var fixWidth = fullWidth - navWidth - sidebarWidth;
		$("#page-content-area").css("height",fixHeight+"px");
		$("#page-content-area").css("width",(fullWidth)+"px");
		$("#sidebar").css("width",(fullWidth)+"px");
		$("#navbar").css("width",(fullWidth)+"px");
		
	}
	function exitSystem(){
		$("#exitSystem").modal();
	}
	function loginOut(){
				window.location.href="${ctx }/logout";
	}
	function updatePassword(){
		$("#updatePwd").css({
			"position" : "absolute",
			"align" : "center"
		});
		$("#updatePwd").modal();
	 	$("#updatePwd input[type=text]").val('');
	 	$("#updatePwd input[type=password]").val('');
	}
	function resetPassword(){
			$('#updatePwdButton').attr("disabled", true);
			var oldPwd = $('#oldPwd').val();
			var newPwd = $('#newPwd').val();
			var newPwdConfirm = $('#confirmPwd').val();
			var message = checkPassword(oldPwd, newPwd, newPwdConfirm);
			if(!message){
				$('#updatePwdButton').attr("disabled", false);
				return;
			}
			var params = {oldPassword: hex_md5(oldPwd), newPassword: hex_md5(newPwd)};
			$.post('${ctx }' + '/user/changePassword', params, function (data) {
				var errorResult =data;
				if(errorResult.success){
					$('#updatePwdButton').attr("disabled", false);
					$("#updatePwd").modal('hide');
					Modal_Alert('密码修改','更新密码成功！');
				}else{
					$('#updatePwdButton').attr("disabled", false);
					Modal_Alert('密码修改',data.msg);
				}
			},"json").error(function(e) {
				$('#updatePwdButton').attr("disabled", false);
				Modal_Alert('密码修改','更新密码失败！');
			});
	}
	
	function checkPassword(oldPwd, newPwd, newPwdConfirm){
		if(oldPwd.length>64 || oldPwd.length <1){
			 Modal_Alert('密码修改','原密码长度不能为空！');
			 return false;
		}
		if(newPwd.length>64 || newPwd.length <6){
			 Modal_Alert('密码修改','新密码长度不能小于6或大于64！');
			 return false;
		}
		if(oldPwd == newPwd) {
			Modal_Alert('密码修改','新密码不能与原密码一致！');
			return false;
		}
		var pattern = new RegExp("[`~!@#$%^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？]");
		if(pattern.test(newPwd)){
			Modal_Alert('密码修改','新密码含有特殊字符！');
			return false;
		}
		if(pattern.test(newPwdConfirm)){
			Modal_Alert('密码修改','密码含有特殊字符！');
			return false;
		}
		if(newPwd != newPwdConfirm) {
			Modal_Alert('密码修改','两次密码输入不一致！');
			return false;
		}
		return true;
	}
	function goPage(pageName){
		if(pageName=="auth")
			{$("#a3").click();}
		else if(pageName=="regist")
		{$("#a1").click();}
		else if(pageName=="search")
		{$("#a2").click();}
		
	}
</script>

</head>
<body class="no-skin" style="overflow:auto;">
<!-- #section:basics/navbar.layout -->
<!-- <div id="parent_navbar" style=" background: url(./img/top_gradient_bar.png) repeat-x fixed; height: 104px; ">
		<div id="sub-navbar" class="sub-navbar"  style=" background: url(./img/logo_hicloud_speech_analyse.png) no-repeat center;width: 300px; height: 70px; float: left; " ></div>
	<div id="navbar" class="navbar navbar-default navbar-collapse h-navbar" style="width: 100%;">
	
	</div>
</div> -->

<div id="navbar" class="navbar navbar-default navbar-collapse h-navbar" style="width: 100%; height: 60px;
background: url(./img/top_gradient_bar_top.png) repeat-x fixed; z-index:1">
	<div id="sub-navbar" class="sub-navbar"  style=" background: url(./img/logo_hicloud_speech_analyse.png) no-repeat center;width: 300px; height: 60px; float: left; z-index:10" ></div>
	<!-- <div id="sub2-navbar" style=" background: url(./img/real_traffic_statistics.png) no-repeat center 65% ; float: left; width: 800px;height: 60px; "></div> -->
	<script type="text/javascript">
		try{ace.settings.check('navbar' , 'fixed')}catch(e){
		}
	</script>

	<div class="navbar-container" id="navbar-container">
		<!-- /section:basics/navbar.dropdown -->
		<nav role="navigation" class="navbar-menu pull-right collapse navbar-collapse" style=" padding-right: 0px; ">
			<ul class="nav navbar-nav" >
				<li>
					<a href="#" style=" height: 57px; ">
						<div style=" background: url(./img/icon_user.png) center no-repeat; height: 14px; width: 74px; z-index:10"></div>
							<span style=" display: inline-block; margin-top: 5px; line-height: 16px; width: 74px; text-align: center; "><%=userName%></span>
						
					</a>
				</li>
						
				<li>
					<a href="#" onclick="updatePassword()" class="dropdown-toggle" data-toggle="dropdown" style=" height: 57px; line-height: 16px;">
						<div style=" background: url(./img/icon_updatePassword.png) center no-repeat; height: 14px; width: 74px; "></div>
						<span style=" display: inline-block; margin-top: 5px; line-height: 16px; width: 74px; text-align: center; ">修改密码</span>
						
					</a>
				</li>
				<li>
					<a href="#" onclick="exitSystem()" class="dropdown-toggle" data-toggle="dropdown" style=" height: 57px; line-height: 16px; ">
					<div style=" background: url(./img/icon_exit.png) center no-repeat; height: 14px; width: 74px; "></div>
					<span style=" display: inline-block; margin-top: 5px; line-height: 16px; width: 74px; text-align: center; ">退出</span>
					</a>
				</li>
			</ul>
		</nav>
	</div><!-- /.navbar-container -->
</div>
<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container"  >
	<script type="text/javascript">
		try{ace.settings.check('main-container' , 'fixed')}catch(e){}
	</script>

	<!-- #section:basics/sidebar.horizontal -->
	<div id="sidebar" class="sidebar      h-sidebar navbar-collapse collapse">
		<script type="text/javascript">
			try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
		</script>

		<ul class="nav nav-list" style="background:url(./img/top_gradient_bar_bottom.png) repeat-x;">
			<li class="hover active open " id='topMenu0' style="cursor:pointer;">
				<a id='a0' class="select hover"  onClick="openPage('${ctx }/home',0)" onmouseenter="mouseEnter(0)" onmouseleave="mouseLeave(0)" style="float:left;width:110px; background: url(./img/button_pressed.png) no-repeat; margin-right: 4px;">
					<!-- <i class="menu-icon fa fa-tachometer"></i> -->
					<span class="menu-text" style=" display: inline-block; width: 64px; text-align: center; ">主页</span>
				</a>
				<b class="arrow"></b>
			</li>	
			<%
				boolean isFirst = true;
		    	List<Menu> topmenus= menuobj.get(null);
		    	if(topmenus != null){
			    	for(Menu topMenu:topmenus){
			    		List<Menu> childmenus=menuobj.get(topMenu.getUuid());
			%>
			<li class="hover" id='topMenu<%=topMenu.getUuid()%>' style="cursor:pointer;background:url(./img/button_normal.png) no-repeat ;border-right:0px;border-left:0px; ">
				<a id='a<%=topMenu.getUuid()%>' onmouseenter="mouseEnter(<%=topMenu.getUuid()%>)" onmouseleave="mouseLeave(<%=topMenu.getUuid()%>)" style="float:left; width:110px; margin-right: 4px; color: #ECEEED; " <% if(topMenu.getUrl()!=null){%>onClick="openPage('${ctx }<%=topMenu.getUrl()%>',<%=topMenu.getUuid()%>)" <%} %>>
					<span class="menu-text"><%=topMenu.getName()%></span>

				</a>
				<% if(childmenus!=null && childmenus.size() > 0){%>
					<b class="arrow"></b>
					<ul class="submenu" style="background-color: #f7f7f7; 
					width:160px;border-style:solid;border-width:1px;border-color:#6297cd">
					<%
				    	for(Menu childmenu:childmenus){
					%>
						<li class="hover" style="cursor:pointer; background-color: #f7f7f7; height:36px; font-size:15px; ">
							<a  style="background-color: #f7f7f7;"  class="dropdown-toggle"  onClick="openPage('${ctx }<%=childmenu.getUrl()%>',<%=childmenu.getParentMenu().getUuid()%>)"   >
								<i class="menu-icon fa fa-caret-right"></i>
								<%=childmenu.getName()%>
								<b class="arrow fa fa-angle-down"></b>
							</a>
	
						</li>
					<%
						}
					%>  
					</ul>
				<% }%>	
			</li>
			<% 
				}
			}
			%>
		</ul><!-- /.nav-list -->

				<!-- <script type="text/javascript">
					try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
				</script> -->
	</div>

	<!-- /section:basics/sidebar.horizontal -->
	<div class="main-content" id="main-content">
		<iframe id="page-content-area"  src="${ctx }/home" style="width:100%;top:104px;bottom:0px;position: absolute;overflow:auto" scrolling=no frameborder=0>
		</iframe>
		<!--<div class="page-content">
		
			 <div class="page-content-area" data-ajax-content="true">
					ajax content goes here
				</div>/.page-content-area
			</div>/.page-content -->
	</div><!-- /.main-content -->


</div><!-- /.main-container -->
   
<div class="modal fade" id="exitSystem" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel" >
              	退出系统
            </h4>
         </div>
         <div class="modal-body" id="modal-body" align="center" style="font-size:18px;line-height:161px;">
         
         		确认退出系统?
         		
         </div>
         <hr style="margin-bottom: 10px;"/>
	  <div align="right" style="padding-right: 42px;padding-bottom: 22px;">
            <button type="button" class="btn btn-default btn-sm" onclick="loginOut()" style=" margin-right:10px; "> 退 出 </button>
            <button type="button" class="btn btn-info btn-sm" data-dismiss="modal"> 取 消 </button>
         </div>
      </div>
</div><!-- /.modal -->
</div>
<div class="modal fade" id="updatePwd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
   <div class="modal-dialog">
      <div class="modal-content" style="width:600px;height:360px;">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
              	修改密码
            </h4>
         </div>
         <div class="modal-body" id="modal-body" align="center">
         	<div class="form-group">
         			<label id="passw" class="col-sm-2 control-label no-padding-right">原密码 </label>
					<div class="col-sm-9">
						<input type="password" id="oldPwd" placeholder="原密码" class="col-xs-10 col-sm-4" style="width:150px;height:25px;"/>
						<span class="help-inline col-xs-12 col-sm-7">
							<span class="middle"><font color="red"></font></span>
						</span>
					</div>
					<br/><br/><br/>
					<label id="passw" class="col-sm-2 control-label no-padding-right">新密码 </label>
					<div class="col-sm-9">
						<input type="password" id="newPwd" placeholder="新密码" class="col-xs-10 col-sm-4"  style="width:150px;height:25px;"/>
						<span class="help-inline col-xs-12 col-sm-7">
							<span class="middle"><font color="red">*密码长度要求至少6位，</font><font color="red">不允许输入特殊字符</font></span>
						</span>
					</div>
					<br/><br/><br/>
					<label id="passw2" class="col-sm-2 control-label no-padding-right"> 确认密码 </label>
					<div class="col-sm-9">
					<input type="password" id="confirmPwd" placeholder="确认密码" class="col-xs-10 col-sm-4"  style="width:150px;height:25px;"/>
						<span class="help-inline col-xs-12 col-sm-7">
							<span class="middle"><font color="red">*两次密码要一致</font></span>
						</span>
					</div>
				</div>
           </div>
         <hr style="margin-top:12px;"/>
	  <div align="right" style="padding-right: 42px;padding-bottom: 22px;">
            <button id="updatePwdButton" onclick="resetPassword()" type="button" class="btn btn-info btn-sm" style=" margin-right:10px; "><i class="ace-icon fa fa-check bigger-110"></i>修改</button> 
            <button type="reset" class="btn btn-sm" data-dismiss="modal"><i class="ace-icon fa fa-undo bigger-110"></i>取消</button>
         </div>
      </div>
	</div>
</div>
<!-- /.modal -->
</body>
</html>