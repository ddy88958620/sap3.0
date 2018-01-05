<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!---登入表单的布局 --->

<html>
	<head>
        <title>登录</title>
<!-- <link rel="stylesheet" type="text/css" href="${ctx }/css//bootstrap.css"> -->
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/js/jquery-1.11.1.min.js"></script>	
<script type="text/javascript" src="${ctx }/js/md5.js"></script>
<script type="text/javascript" src="${ctx }/js/respond.min.js"></script>
<!-- <script src="js/cloud.js" type="text/javascript"></script> -->
<script src="${ctx }/js/ace/bootstrap.js"></script>
<script type="text/javascript">
	var userNameMaxLength = 64;
	var passwordMinLength = 4;
	var passwordMaxLength = 64;
	/* var preWidth=document.documentElement.clientWidth;
	var preHeight=document.documentElement.clientHeight; */
	

	$(function() {
		if(navigator.userAgent.indexOf("MSIE 8.0")>0) {  
			$(".loginbody").css("filter","progid:DXImageTransform.Microsoft.AlphaImageLoader(src='./images/login_bg.png', sizingMethod='scale')");
	    }else {
	    	$(".loginbody").css("background-size","100% 100%");
	    }   
		/* var fullHeight = document.documentElement.clientHeight;
		var fullWidth = document.documentElement.clientWidth;
		$("body>img").css({"width":fullWidth,"height":fullHeight});
		var loginboxLeft=(fullWidth-500)/2+7;
		var loginboxTop=(fullHeight-332)/2;
		var loginBody=((fullHeight-332)/2)-71-68;
		$(".loginbox").css("top",loginboxTop);
		$(".loginbody").css("top",loginBody);
		$(".loginbox").css("left",loginboxLeft); */
		$(".back_center").addClass("active");
		if (!((navigator.userAgent.indexOf('MSIE') >= 0)&& (navigator.userAgent.indexOf('Opera') < 0))){
			$("#passwordShow").css("display","none");
			$("#password").css("display","block");
			$("#password").attr("type","text");
			$("#password").val("password");
			/* $("#password").attr("onfocus","clearPwdContent()"); */
			/* $("#password").attr("onblur","onPwdBlur()"); */
		}else{
			$("#password").val("");
		}
		
		$("#errorMsg").on('show.bs.modal', function (e) {  
		    $(this).find('.modal-dialog').css({  
		        'margin-top': function () {  
		            var modalHeight = $('#errorMsg').find('.modal-dialog').height();  
		            return ($(window).height() / 2 - (modalHeight / 2)-200);  
		        }  
		    });      
		});  
 		$(window).resize(function() {
			var fullHeight = $(document).height();
			if(fullHeight<650){
				$(".systemlogo").hide();
			}else{
				$(".systemlogo").show();
			}
		}); 
		/* $(window).resize(function() {
			 var nextWidth=document.documentElement.clientWidth;
			 var fullHeight = document.documentElement.clientHeight;
			 var fullWidth = document.documentElement.clientWidth;
			 var loginboxLeft=(fullWidth-500)/2+7;
			 var nextHeight=document.documentElement.clientHeight;
			 var loginboxTop=(fullHeight-332)/2;
			 var loginBody=((fullHeight-332)/2)-71-68;
			 if(preWidth<nextWidth){
				$("body>img").css({"width":fullWidth,"height":fullHeight});
				$(".loginbox").css("left",loginboxLeft);
			 }else{
					$("body>img").css({"width":fullWidth,"height":fullHeight});
					$(".loginbox").css("left",loginboxLeft);
					$("body").css("overflow","hidden");
			 }
			 if(preHeight<nextHeight){
				$("body>img").css({"width":fullWidth,"height":fullHeight});
				$(".loginbox").css("top",loginboxTop);
				$(".loginbody").css("top",loginBody);
			 }else{
					$("body>img").css({"width":fullWidth,"height":fullHeight});
					$(".loginbox").css("top",loginboxTop);
					$("body").css("overflow","hidden");
					$(".loginbody").css("top",loginBody);
			 }
		});*/
	}); 
	function reSetPwd(){
		$("#userName").val("username");
		window.location.href=window.location.href;
		location.reload();
	}
	function loginCheck(name,userPassword){
		if(name == "username"){
			showError("用户名为空！");
			return false;
		}
		if (userPassword == "password"||userPassword == ""){
			showError("密码为空！");
			return false;
		}
		if (userPassword.length<6){
			showError("密码长度不能小于6！");
			return false;
		}
		return true;
	}
	
	function showError(msg){
		$("#modal-body").html("<br/><br/><span style='font-size:18px;color:rgb(115,115,115)'>"+msg+"</span><br/><br/><br/>");
		$("#errorMsg").modal();
	}
	
	function clearContent(){
		$("#userName").val("username");
		$("#password").val("");
		showFake();
	}
	$(function() {
		$("body").keydown(function(e){ 
			var curKey = e.which;
			if(curKey == 13){ 
				login(); 
				return false; 
			} 
		});
	})
	function login(){
		var name = $.trim($("#userName").val());
		var userPassword =$.trim($("#password").val());
		if(!loginCheck(name,userPassword))
			return;
		var hash = hex_md5(userPassword);
		$.post("dologin",{loginName:name,password:hash},function(data){
			var errorResult =data;
			if(errorResult.success){
				location.href="${ctx }/mainPage";
			}else{
				showError(errorResult.msg);
			}				
		},"json").error(function() { 
			showError("登录失败");
		});
		
	}
	function reset(){
		$("#userName").val("username");
		$("#userName").css("color","#B4B2BF");
		$("#password").val("");
		$("#password").css("display","none");
		$("#passwordShow").css("display","block");
	}
	function clearUserContent() {
		if (document.getElementById("userName").value == "username") {
			document.getElementById("userName").value = "";
			document.getElementById("userName").style.color = "black";
		}
	}
	function onUserBlur() {
		if (document.getElementById("userName").value == "") {
			document.getElementById("userName").value = "username";
			document.getElementById("userName").style.color = "#B4B2BF";
		}
	}
	function showReal() {
		tx = document.getElementById("passwordShow"); 
		if (tx.value != "password") 
			return; 
		tx.style.display = "none"; 
		pwd = document.getElementById("password"); 
		pwd.type = "password";
		pwd.style.color = "black"; 
		pwd.style.display = "block"; 
		pwd.value="";
		pwd.focus(); 
	}

	function showFake() {
		pwd = document.getElementById("password"); 
		if (pwd.value != "") 
			return; 
		pwd.style.display = "none"; 
		pwd.style.color = "#B4B2BF"; 
		tx = document.getElementById("passwordShow"); 
		tx.style.display = "block"; 
		tx.style.color = "#B4B2BF"; 
		tx.value = "password"; 
	}
	
	function clearPwdContent() {
		if (document.getElementById("password").value == "password") {
			document.getElementById("password").value = "";
		}

		document.getElementById("password").type = "password";
	}

	function onPwdBlur() {
		if (!+[ 1, ]) {
		} else {
			if (document.getElementById("password").value == "") {
				document.getElementById("password").value = "password";
				document.getElementById("password").type = "text";
			}
		}
	}

</script>
</head>
<!-- <body>
 <img  src="images/login_bg.png" /> -->
 <body>
    <div class="loginbody" style="background-image:url(images/login_bg.png); background-repeat:no-repeat;)">
     <!-- <div class="systemlogo"> </div>
    <div class="loginbox" > -->
    <span class="systemlogo" style = "width:100%; height:71px; margin-top:10%;"></span>
    <div class="loginbox" style = "top:50%;left:50%;margin-top:-116px;margin-left:-300px;position:fixed;">
    

    <ul>
    <li><input id="userName" type="text" class="loginuser" style="font-size:22px" value="username" onfocus="clearUserContent()" onblur="onUserBlur()" /></li>
    <li>
    	<input id="password" type="password" class="loginpwd" onfocus="showReal()" value="password" onpaste="return false" onblur ="showFake()" style="display:none;font-size: 22px;">
	    <input class="loginpwd" type="text" id="passwordShow"  name="passwordShow" value="password" onfocus="showReal()" style="font-size:22px;color:#B4B2BF">
	</li>
    <li>
    <input name="" type="button" class="loginbtn" style="margin-left:25px" value=""  onClick="login()" style="margin-left:56px"/>
    <input name="" type="button" class="login_reset" style="margin-left:40px" value=""  onClick="reset()" style="margin-left:169px"/>
    </li>
    </ul>
    </div>
    </div>
    <div class="loginbm">Copyright &copy;2016 北京捷通华声科技股份有限公司&nbsp;&nbsp;&nbsp;灵云：www.hcicloud.com</div>

    <!-- 模态框（Modal） -->
<div class="modal fade" id="errorMsg" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
   <div class="modal-dialog">
      <div class="modal-content" style="width:460px;height:300px;margin-left:70px;">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel" style="font-size:22px;color:rgb(115,115,115)">
              	登录失败
            </h4>
         </div>
         <div class="modal-body" id="modal-body" align="center"  style="margin-top:40px">
         
         </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-warning" style="background-color:rgb(98,151,205);width:75px;" data-dismiss="modal">关闭</button>
         </div>
      </div>
</div><!-- /.modal -->
</div>
</body>

</html>
