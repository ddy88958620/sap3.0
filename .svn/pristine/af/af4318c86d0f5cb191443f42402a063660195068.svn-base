<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!---登入表单的布局 --->
<html>
	<head>
        <title>授权管理</title>
        <link rel="stylesheet" type="text/css" href="${ctx }/css/ace/bootstrap.css">
		<link rel="stylesheet" href="${ctx }/css/ace/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/font-awesome.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/ace-fonts.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/ace-skins.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/datepicker.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/button.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/select2/select2.css">
		
					<style type="text/css">
		.bg{
	    position: absolute;
	    top:0;
	    left:0;
	    bottom:0;
	    right:0;
	    z-index: -1;
	     width: 100%;
	    height: 100%;
	}
	</style>
		<!--[if lte IE 9]>
			<link rel="stylesheet" href="${ctx }/css/ace/ace-part2.css" class="ace-main-stylesheet" />
		<![endif]-->
		
		<!--[if lte IE 9]>
		  <link rel="stylesheet" href="${ctx }/css/ace/ace-ie.css" />
		<![endif]-->
		
		<!-- ace settings handler -->
		<script src="${ctx }/js/jquery-1.11.1.min.js"></script>	
	    <script src="${ctx }/js/ace/jquery.dataTables.js"></script>
		<script src="${ctx }/js/ace/bootstrap.js"></script>
        <script src="${ctx }/js/ace/jquery.dataTables.bootstrap.js"></script>
		<script src="${ctx }/js/ace/ace-extra.js"></script>
		<script src="${ctx }/js/ace/ace-elements.js"></script>
		<script src="${ctx }/js/ace/ace.js"></script>
		<script src="${ctx }/js/ace/date-time/bootstrap-datepicker.js"></script>
		<script src="${ctx }/js/select2/select2.js"></script>
		<script src="${ctx }/js/respond.min.js"></script>
		<script src="${ctx }/js/windowResize.js"></script>
		<script src="${ctx }/js/ace/ace/elements.treeview.js"></script>
	    <script src="${ctx }/js/md5.js"></script>
	    <script src="${ctx }/js/select2/select2.min.js"></script>
	    
		<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->
		
		<!--[if lte IE 8]>
		<script src="${ctx }/js/ace/html5shiv.js"></script>
		<script src="${ctx }/js/ace/respond.js"></script>
		<![endif]-->

</head>
<body style="height:100%;weight:100%;" >
<img class="bg" src="../img/background.png" />
<div style="position:absolute;top:0px;bottom:0px;left:0px;right:0px;height:100%;overflow:scroll;padding:20px;" >
<div style="height:50px;">
	<div id="cesi" style="position: absolute;width:100%;">
		<table style="float:left;width:100%;">
           	<tr style="height:75px">
           		<td class="systemInfo" style="width:747px;">&nbsp;<a class="systemInfo">登录名称:&nbsp;</a><input type="text" id="loginNameSearch" style="width:150px;height:30px;"/>
           		&nbsp;<a>用户名称:&nbsp;</a><input type="text" id="userNameSearch" style="width:150px;height:30px;"/>
           		&nbsp;<a>权限名称:&nbsp;</a><select id="roleSearch" class="js-example-basic-hide-search" style="width:100px;height:27px;"></select>
          			&nbsp;&nbsp;&nbsp;<a><button type="button" id="search" class="btn btn-info btn-xs" onClick="getAllUser()"><span class="ace-icon fa fa-search icon-on-right bigger-110"></span>&nbsp;搜索</button></a></td>
          			<td></td>
          			<td style="width:100px;"><a><button type="button" id="search" class="btn btn-info btn-xs" onClick="addUser()"><span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>&nbsp;添加</button></a></td>
       		</tr><!-- button button-primary button-pill button-small -->
       	</table>
	</div>
	<div id="nowPosition" style="position:absolute;right:5px;top:5px;"><span class="label label-xlg label-yellow arrowed-in">当前位置： 业务员管理 - <font  id="tabSelect">业务员管理 </font></span></div>
	<div class="tab-content" style="width:97%;top:80px;bottom:0px;position:absolute;">
	  		<table id="dataTable" class="table table-striped table-bordered table-hover">
			    <thead id="thead">
			    </thead> 
			    <tbody id="tbody">
			    </tbody> 
			</table>
	</div>
</div>
</div>
<div class="modal fade" id="errorMsg" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
              	业务员修改
            </h4>
         </div>
         <div class="modal-body" id="modal-body" align="center">
			<div class="form-group">
					<label id="nameUpdateLab" class="col-sm-2 control-label no-padding-right">用户名称</label>
					<div class="col-sm-9">
						<input type="hidden" id="updateUserId" />
						<input type="text" id="nameUpdate" placeholder="此处填写姓名" class="col-xs-10 col-sm-4" style="width:150px;height:25px;"/>
					</div>
					<br/><br/>
					<label id="roleUpdateLab" class="col-sm-2 control-label no-padding-right">权　　限</label>
					<div class="col-sm-9" style="width:170px">
						<select id="roleUpdate" class="js-example-basic-hide-search" style="width:150px;height:25px;"></select>
					</div>
					<br/><br/>
					<label id="passw" class="col-sm-2 control-label no-padding-right">新 密 码 </label>
					<div class="col-sm-9">
						<input type="password" id="passwo" placeholder="新密码" class="col-xs-10 col-sm-4" style="width:150px;height:25px;"/>
						<span class="help-inline col-xs-12 col-sm-7">
							<span class="middle"><font color="red">*密码长度要求至少8位</font></span>
						</span>
					</div>
					<br/><br/>
					<label id="passw2" class="col-sm-2 control-label no-padding-right"> 确认密码 </label>
					<div class="col-sm-9">
					<input type="password" id="passwo2" placeholder="确认密码" class="col-xs-10 col-sm-4" style="width:150px;height:25px;"/>
						<span class="help-inline col-xs-12 col-sm-7">
							<span class="middle"><font color="red">*两次密码要一致</font></span>
						</span>
					</div>
				</div>
           </div>
  		<hr style="margin-bottom: 10px;"/>
            <div  align="right" style="padding-right: 10px;padding-bottom: 10px;">
            <button id="sureRelate" onclick="userUpdate()" type="button" class="btn btn-info btn-sm"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
            <button type="reset" class="btn btn-sm" data-dismiss="modal"><i class="ace-icon fa fa-undo bigger-110"></i>取消</button>
         </div>
      </div>
      </div>
</div>
<div class="modal fade" id="userAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
              	业务员增加
            </h4>
         </div>
         <div class="modal-body" id="modal-body" align="center">
			<div class="form-group">
					<label id="loginNameAddLab" class="col-sm-2 control-label no-padding-right">登录名称</label>
					<div class="col-sm-9">
						<input type="text" id="loginNameAdd" placeholder="此处填写登陆名" class="col-xs-10 col-sm-4" style="width:150px;height:25px;"/>
					</div>
					<br/><br/>
					<label id="userNameAddLab" class="col-sm-2 control-label no-padding-right">用户名称</label>
					<div class="col-sm-9">
						<input type="text" id="userNameAdd" placeholder="此处填写姓名" class="col-xs-10 col-sm-4" style="width:150px;height:25px;"/>
					</div>
					<br/><br/>
					<label id="roleAddLab" class="col-sm-2 control-label no-padding-right">权　　限</label>
					<div class="col-sm-9" style="width:170px">
						<select id="roleAdd" class="js-example-basic-hide-search" style="width:150px;height:25px;"></select>
					</div>
					<br/><br/>
					<label id="passwAdd" class="col-sm-2 control-label no-padding-right">密　　码 </label>
					<div class="col-sm-9">
						<input type="password" id="passwoAdd" placeholder="新密码" class="col-xs-10 col-sm-4" style="width:150px;height:25px;"/>
						<span class="help-inline col-xs-12 col-sm-7">
							<span class="middle"><font color="red">*密码长度要求至少8位</font></span>
						</span>
					</div>
					<br/><br/>
					<label id="passw2" class="col-sm-2 control-label no-padding-right"> 确认密码 </label>
					<div class="col-sm-9">
					<input type="password" id="passwo2Add" placeholder="确认密码" class="col-xs-10 col-sm-4" style="width:150px;height:25px;"/>
						<span class="help-inline col-xs-12 col-sm-7">
							<span class="middle"><font color="red">*两次密码要一致</font></span>
						</span>
					</div>
				</div>
           </div>
  		<hr style="margin-bottom: 10px;"/>
            <div  align="right" style="padding-right: 10px;padding-bottom: 10px;">
            <button id="sureRelate" onclick="userAddSave()" type="button" class="btn btn-info btn-sm"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
            <button type="reset" class="btn btn-sm" data-dismiss="modal" onclick="userAddClear()"><i class="ace-icon fa fa-undo bigger-110"></i>取消</button>
         </div>
      </div>
      </div>
</div>
<div class="modal fade" id="erMsg" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
              	  信息提示
            </h4>
         </div>
         <input type="hidden" id="deleteUserId" />
         <div class="modal-body" id="conte" align="center">
      			   确定删除该业务员?
         </div>
        <hr style="margin-bottom: 10px;"/>
	  			<div align="right" style="padding-right: 10px;padding-bottom: 10px;">
			<button id="sureRelate" onclick="deleteUser()" type="button" class="btn btn-info btn-sm"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
            <button type="reset" class="btn btn-sm" data-dismiss="modal"><i class="ace-icon fa fa-undo bigger-110"></i>取消</button>
         </div>
      </div>
	</div><!-- /.modal -->
</div>
<script type="text/javascript">

<%-- 
var isHaveRelation=0;
var redirectHref = "${ctx }/user/userManager";//访问菜单树超时 
var searchCondition = {};
--%>
var nowDataTable = null;
$(function(){
	//初始化数据
	initRoleSearch("roleSearch", 1, true);
	initRoleSearch("roleUpdate", 0, false);
	initRoleSearch("roleAdd", 0, false);
});

//初始化数据
function initData(){
	getAllUser();
}

/**
 * 初始化操作类型
 * needAll指是否需要"全部"选项,1表示需要, 0表示不需要
 */
function initRoleSearch(roleSelect, needAll, needRefreshTable){
	$.post('${ctx }/role/getRoleCombobox', {needAll: needAll}, function (data) {
		$("#" + roleSelect).select2({
			minimumResultsForSearch: -1,
			data: data
		});
		if (needRefreshTable) {
			initData();
		}
	},"json").error(function() { 
		$("#" + roleSelect).select2({
			minimumResultsForSearch: -1
		});
			});
	
}

//获取查询条件
function addSearchInfo(aoData){
	aoData.push({"name":"loginName","value":$.trim($("#loginNameSearch").val())});
	aoData.push({"name":"userName","value":$.trim($("#userNameSearch").val())});
	aoData.push({"name":"roleId","value":$("#roleSearch").select2("data")[0].id});
}

function getAllUser(){
	var aoColumns = [
	                       {  
		                        "mDataProp" : "index",  
		                        "sTitle" : "序列号", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center"
		                    },
	                       {  
		                    	"render" : function(data, type, full, meta) {
		                        	return full.user.loginName;  
		                    	},
		                        "sTitle" : "登录名称", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center"
		                    },
		                    {  
		                    	"render" : function(data, type, full, meta) {
		                        	return full.user.userName;  
		                    	},  
		                        "sTitle" : "用户名称", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center"
		                    },
	                        {  
		                        "render" : function(data, type, full, meta) {
		                        	return full.role.name;
		                        },
		                        "sTitle" : "权限",  
		                        "sDefaultContent" : "",  
		                        "sClass" : "center"
		                    },
	                        {  
		                    	"render" : function(data, type, full, meta) {
		                        	return full.user.updateTime;  
		                    	},  
		                        "sTitle" : "修改时间",  
		                        "sDefaultContent" : "",  
		                        "sClass" : "center"
		                    },
		                    {  
		                       "sTitle" : "操作",  
		                       "sDefaultContent" : "",
		                       "bSearchable": false,
		                       "bStorable": false,
		                       "sClass" : "center",
		                       "render": function ( data, type, full, meta ) {
		                    	      return '<a  onclick=\"findOneUser('+full.user.id+')\">修改</a>&nbsp;|&nbsp<a  onclick=\"deleteConfirm('+full.user.id+')\">删除</a>';
		                        }
		                   }
		];
	if(nowDataTable!=null){
		nowDataTable.fnClearTable(0); //清空数据
		nowDataTable.fnDestroy();
	}
	$("#thead").html("");
	$("#tbody").html("");
	var tabContent = $(".tab-content").height()-34-58;
	nowDataTable = $('#dataTable').dataTable({
		 bAutoWidth: false,//for better responsiveness
		"bProcessing": true,
		"bServerSide": true,
		showRowNumber:true,
         "bPaginate" : true,// 分页按钮
		"bLengthChange" : true,// 每行显示记录数
		"bSort" : false,// 排序
		"bStateSave":false, //是否开启cookies保存当前状态信息
		bInfo:true,
	    scrollY: tabContent,
		 "order": [[ 0, 'asc' ]],
		 "sAjaxSource": "./getAllUser",//请求内容为退一步请求的内容
		 "fnServerData": function ( sSource, aoData, fnCallback ) {
            addSearchInfo(aoData);
			 $.ajax( {
			 "dataType": 'json',
			 "type": "POST",
			 "url": sSource,
			 "data": aoData,
			 "success": function(resp) {
				 	if(resp.aaData!=null&&resp.aaData.length>0){
				 		for(var i=0;i<resp.aaData.length;i++){
				 			resp.aaData[i].index = i+1;
				 		}
				 	}
		            fnCallback(resp);   
		        }    
			 } );
		 },
		 "aoColumns":aoColumns
	});
}

//密码合法性验证
function validaPassw(passw,passw2){
	//长度
	if(passw.length>64 || passw.length <8){
		 Modal_Alert('业务员管理','密码长度不能小于8或大于64！');
		 return false;
	}
	//一致性
	if(passw!=passw2){
		Modal_Alert('业务员管理','两次输入密码必须一致!');
		return false;
	}
	return true;
}

//user修改时的密码验证,增加空密码验证
function pwdCheckForUpdate(pwd1, pwd2) {
	if (pwd1 == "" && pwd2 == "") {
		return true;
	}
	return validaPassw(pwd1,pwd2);
}

//获得一个User,用于修改
function findOneUser(id) {
	$.ajax({
		url: "${ctx }/user/findOneUser",
		type: "POST",
		dataType: "json",
		data: {"id": id},
		success: function(data) {
			if (data.errorCode == 0) {
				$("#errorMsg").modal();
				$("#updateUserId").val(id);
				$("#nameUpdate").val(data.retMsg.user.userName);
				var roleId = data.retMsg.role.id;
				$("#roleUpdate").select2("val", roleId);
			}
			else {
				Modal_Alert('业务员管理',data.errorMsg);
			}
		}
	});
}

//业务员删除提示
function deleteConfirm(id) {
	$("#erMsg").modal();
	$("#deleteUserId").val(id);
}

//删除业务员
function deleteUser() {
	var id = $("#deleteUserId").val();
	$("#erMsg").modal("hide");
	$.ajax({
		url: "${ctx }/user/deleteUser",
		type: "POST",
		dataType: "json",
		data: {"id": id},
		success: function(data) {
			Modal_Alert('业务员删除',data.errorMsg);
			if (data.errorCode == 0) {
				initData();
			}
		}
	});
}

//user提交更新
function userUpdate() {
	var passw= $("#passwo").val();
	var passw2= $("#passwo2").val();
	if(!pwdCheckForUpdate(passw,passw2)){
		$('#sureRelate').attr("disabled", false);
		return;//不再向下执行
	}
	var userName = $("#nameUpdate").val();
	var roleId = $("#roleUpdate").select2("data")[0].id;
	var id = $("#updateUserId").val();
	$.ajax({
		url: "${ctx }/user/updateUser",
		type: "POST",
		dataType: "json",
		data: {"userName": userName, "roleId": roleId, "id": id, "pwd": passw == "" ? "" : hex_md5(passw)},
		success: function(data) {
			$("#errorMsg").modal("hide");
			Modal_Alert('业务员修改',data);
			initData();
		}
	});
}

//user增加
function addUser() {
	$.ajax({
		url: "${ctx }/role/roleCount",
		type: "POST",
		dataType: "json",
		success: function(data) {
			if (data > 0) {
				userAddClear();
				$("#userAddModal").modal();
			}
			else {
				Modal_Alert("业务员增加", "权限列表为空,请先增加权限!");
			}
		}
	})

}

//user增加时的用户名和姓名验证
function nameCheck(loginName, userName) {
	if (loginName.length > 3 && userName != "") {
		return true;
	}
	else if (loginName.length == 0) {
		Modal_Alert('业务员增加', "登录名称不能为空!");
		return false;
	}
	else if (loginName.length <= 3) {
		Modal_Alert('业务员增加', "登录名称长度必须大于3!");
		return false;
	}
	else if(userName == "") {
		Modal_Alert('业务员增加', "用户名称不能为空!");
		return false;
	}
	
}

//user增加提交保存
function userAddSave() {
	var loginName = $("#loginNameAdd").val();
	var userName = $("#userNameAdd").val();
	var roleId = $("#roleAdd").select2("data")[0].id;
	var pwd = $("#passwoAdd").val();
	var pwd2 = $("#passwo2Add").val();
	if (nameCheck(loginName, userName) && validaPassw(pwd, pwd2)) {
		$.ajax({
			url: "${ctx }/user/addOneUser",
			dataType: "json",
			type: "POST",
			data: {"loginName": loginName, "userName": userName, "pwd": hex_md5(pwd), "roleId": roleId},
			success: function(data) {
				if (data.errorCode == 0) {
					$("#userAddModal").modal("hide");
					initData();
				}
				Modal_Alert('业务员增加',data.errorMsg);
			}
		});
	}
}

//清空增加数据
function userAddClear() {
	$("#loginNameAdd").val("");
	$("#userNameAdd").val("");
	$("#passwoAdd").val("");
	$("#passwo2Add").val("");
}

</script>
</body>
</html>