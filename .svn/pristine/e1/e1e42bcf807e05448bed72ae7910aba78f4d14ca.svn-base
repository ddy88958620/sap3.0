<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!---登入表单的布局 --->
<html>
	<head>
        <title>用户管理</title>
        <link rel="stylesheet" type="text/css" href="${ctx }/css/ace/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/font-awesome.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/ace-fonts.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/ace-skins.css">
		<link rel="stylesheet" href="${ctx }/css/ace/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
		<link rel="stylesheet" type="text/css" href="${ctx }/css/datetimepicker/bootstrap-datetimepicker.min.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/button.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/select2/select2.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/zTree/metroStyle/metroStyle.css">
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
	
		.side{
			height:100%;
			padding-right:0px;
			padding-bottom:20px;
			overflow-y:hidden;
			margin-bottom: 0px;
		}

		.addTable tr{
			 line-height:22px;
		}
		
		.addTable td{
			padding:10px;
			text-align:center;
			width:130px;
			font-size:16px;
			color:#88878C;	
		}
		
		.addTable .input{
			height:30px
		}
		
		.addTable .select{
			width:160px;
			padding:2px;
			border-radius:3px;
		}
		
		#dataTable td,#dataTable th{
			white-space:nowrap;
		}
	</style>
		<!-- ace settings handler -->
		<script src="${ctx }/js/jquery-1.11.1.min.js"></script>	
	    <script src="${ctx }/js/ace/jquery.dataTables.js"></script>
		<script src="${ctx }/js/ace/bootstrap.js"></script>
        <script src="${ctx }/js/ace/jquery.dataTables.bootstrap.overflow.js"></script>
		<script src="${ctx }/js/ace/ace-extra.js"></script>
		<script src="${ctx }/js/ace/ace-elements.js"></script>
		<script src="${ctx }/js/ace/ace.js"></script>
		<script src="${ctx }/js/ace/date-time/bootstrap-datepicker.js"></script>
		<script src="${ctx }/js/select2/select2.js"></script>
		<script src="${ctx }/js/datetimepicker/bootstrap-datetimepicker.js"></script>
		<script src="${ctx }/js/datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"></script>
		<script type="text/javascript" src="${ctx }/js/respond.min.js"></script>
		<script src="${ctx }/js/ace/ace/elements.treeview.js"></script>
	    <script type="text/javascript" src="${ctx }/js/md5.js"></script>
	    <script src="${ctx }/js/jquery.ztree.core-3.5.min.js"></script>
        <script src="${ctx }/js/jquery.ztree.excheck-3.5.min.js"></script>
        <script src="${ctx }/js/jquery.ztree.exedit-3.5.min.js"></script>
        <script src="${ctx }/js/windowResize.js"></script>
        <!--[if lte IE 8]>
		<script src="${ctx }/js/ace/html5shiv.js"></script>
		<script src="${ctx }/js/ace/respond.js"></script>
		<![endif]-->
		<!--[if lte IE 9]>
		<link rel="stylesheet" href="${ctx }/css/ace/ace-part2.css" class="ace-main-stylesheet" />
		<![endif]-->

		<!--[if lte IE 9]>
		<link rel="stylesheet" href="${ctx }/css/ace/ace-ie.css" />
		<![endif]-->
</head>
<body style="height:100%;weight:100%;background:#f7f7f7;" >
	
	<div style="position:absolute;top:0px;bottom:0px;left:0px;right:0px;height:100%;overflow-x:hidden;overflow-y:hidden;padding:10px;" >
		<div id="cesi" style="position:absolute;width:100%;left:30px;">
			<table>
       			<tr>
       				<td>
	       				<a>
	       					<button type="button" id="add" class="btn btn-info btn-sm" style="z-index:1;" onClick="addFun()">
	       						<span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>&nbsp;添加
	       					</button>
	       				</a>
	       			</td>
	       			<td>
	       				<font style="font-size:14px; font-family:微软雅黑; color:#88878B;">
							&nbsp;&nbsp;&nbsp;用户组选择：
						</font>
	       			</td>
	       			<td>
	       				<select id="queryUserGroupId" name="queryUserGroupId" class="select" onchange="getAllRecord()"></select>
	       			
	       			</td>
	       			<td>
	       				<font style="font-size:14px; font-family:微软雅黑; color:#88878B;">
							&nbsp;&nbsp;&nbsp;用户名称：
						</font>
	       				<input id="queryName" name="queryName" class="input" type="text" onkeydown="enterSearch()"/>
	       			</td>
	       			<td>
	       				&nbsp;&nbsp;&nbsp;
	       				<a>
	       					<button type="button" id="search" class="btn btn-info btn-sm" style="z-index:1;" onClick="getAllRecord()">
	       						<span class="ace-icon fa fa-search icon-on-right bigger-110"></span>&nbsp;查询
	       					</button>
	       				</a>
	       			</td>
	    		</tr>
   			</table>
		</div>
		<!-- <div id="nowPosition" style="position:absolute;right:5px;top:15px;">
			<span class="label label-xlg label-yellow arrowed-in">当前位置： 权限管理 - 
				<font  id="tabSelect">用户管理</font>
			</span>
		</div> -->

	    <div style="width:100%;top:45px;bottom:0px;position:absolute;height:100%;">
	    	<div class="row" style="height:100%;">
		    	<div class="col-sm-6 side"  style="height:100%;width:100%;padding-top:0px;padding-right: 10px;" >
					<div class="tab-content" style="top:10px;bottom:0px;position:absolute;width:98%">
			  			<table id="dataTable" class="table table-striped table-bordered table-hover">
					    	<thead id="thead">
					    	</thead> 
					    	<tbody id="tbody">
					    	</tbody> 
						</table>
			 		</div>
		   		</div>
	    	</div>
		</div>
	</div>

 	<!-- 添加modal -->
 	<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   		<div class="modal-dialog">
      		<div class="modal-content" style="width:620px;">
         		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  		&times;
            		</button>
            		<h4 class="modal-title" id="myModalLabel" style="margin-top:0;font-size:22px;letter-spacing: 1.5px;width:100px">
              			添加
            		</h4>
         		</div>
         		<div class="modal-body" id="modal-body" align="center" >
	        		<table id="addTable" class="addTable">
	                	<tr>
	                  		<td>登录名:</td>
	                  		<td><input id="addLoginName" name="addLoginName" placeholder="请输入登录名称" class="input" type="text" onkeyup="value=value.replace(/\s/g,'')"/></td>
				        	<td>密码:</td>
		                  	<td><input id="addPassword" name="password" placeholder="请输入密码" type="password" class="input" type="text" onkeyup="value=value.replace(/\s/g,'')"/></td>
				       	</tr>
	                
		                <tr>
		                	<td>姓名:</td>
	                  		<td><input id="addName" name="addName" placeholder="请输入姓名" class="input" type="text" onkeyup="value=value.replace(/\s/g,'')"/></td>
		                    <td>确认密码:</td>
		                  	<td><input id="addRPassword" name="addRPassword" placeholder="请输入确认密码" type="password" class="input" type="text" onkeyup="value=value.replace(/\s/g,'')"></input></td>
		                </tr>
	                
		                <tr>
		                  	<td>用户组:</td>
		                  	<td><select id="addUserGroupId" name="addUserGroupId" class="select"></select></td>
		                  	<td>状态:</td>
		                  	<td><select id="addState" name="addState" class="select"></select></td>
		                </tr>
		                <tr>
		                	<td>角色:</td>
		                	<td id="addRolesTd" colspan="3"></td>
		                </tr>
		                <tr>
		                  	<td>备注:</td>
		                  	<td colspan="3"><input id="addRemark" name="addRemark" placeholder="请输入备注(选填)" class="input" type="text" style="float:left;width:100%;"/></td>
		                </tr>
	            	</table>
         		</div>
      	 		<hr style="color:#d0d0d0;margin:0"/>
	            <div align="center" style="padding-left:30px; padding-right:10px; padding-bottom:15px;">
	            	<button id="addButton" onclick="addUser()" type="button" class="btn btn-info btn-sm" style="width:75px;height:30px;margin-right:15px"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
	            	<button type="reset" class="btn btn-sm" data-dismiss="modal" style="width:75px;height:30px;margin-right:25px"><i class="ace-icon fa fa-undo bigger-110" ></i>取消</button>
	         	</div>
     		</div>
      	</div>
	</div>
	
	<!-- 删除modal -->
	 <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
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
		        <div class="modal-body" id="hint" align="center" style=" line-height: 161px; ">
						确定要删除当前用户？
		      		   
		        </div>
		        <input id="deleteUuid" name="deleteUuid" type="hidden" />
	        	<hr style="margin-bottom: 10px;"/>
			  	<div align="right" style="padding-right: 42px; padding-bottom: 22px;">
					<button id="deleteButton" onclick="deleteUser()" type="button" class="btn btn-info btn-sm" style=" padding-right: 10px "><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
		            <button type="reset" class="btn btn-sm" data-dismiss="modal"><i class="ace-icon fa fa-undo bigger-110"></i>取消</button>
		        </div>
      		</div>
		</div>
	</div>

 	<!-- 修改modal -->
 	<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    	<div class="modal-dialog">
      		<div class="modal-content" style="width:620px;">
         		<div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
		                  &times;
		            </button>
		            <h4 class="modal-title" id="myModalLabel" style="text-align:center;margin-top:0;font-size:22px;color:#429af1;letter-spacing: 1.5px;width:100px">
		              	编辑
		            </h4>
         		</div>
         		<div class="modal-body" id="modal-body" align="center" >
        			<table id="updateTable" class="addTable">
		                <tr>
	                  		<td>登录名:</td>
	                  		<td><input id="updateLoginName" name="updateLoginName" placeholder="请输入登录名称" class="input" type="text" onkeyup="value=value.replace(/\s/g,'')"/></td>
				       		<td>姓名:</td>
	                  		<td><input id="updateName" name="updateName" placeholder="请输入姓名" class="input" type="text" onkeyup="value=value.replace(/\s/g,'')"/></td>
				       	</tr>
	                
		                <tr>
		                  	<td>用户组:</td>
		                  	<td><select id="updateUserGroupId" name="updateUserGroupId" class="select"></select></td>
		                  	<td>状态:</td>
		                  	<td><select id="updateState" name="updateState" class="select"></select></td>
		                </tr>
		                <tr>
		                	<td>角色:</td>
		                	<td id="updateRolesTd" colspan="3"></td>
		                </tr>
		                <tr>
		                  	<td>备注:</td>
		                  	<td colspan="3"><input id="updateRemark" name="updateRemark" placeholder="请输入备注(选填)" class="input" type="text" style="float:left;width:100%;"/></td>
		                </tr>
            		</table>
            		<input id="updateUuid" name="updateUuid" type="hidden" />
         		</div>
       			<hr style="color:#d0d0d0;margin:0"/>
            	<div align="center" style="padding-left:30px; padding-right:10px; padding-bottom:15px;">
		            <button id="updateButton" onclick="updateUser()" type="button" class="btn btn-info btn-sm" style="width:75px;height:30px;margin-right:15px"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
		            <button type="reset" class="btn btn-sm" data-dismiss="modal" style="width:75px;height:30px;margin-right:25px"><i class="ace-icon fa fa-undo bigger-110" ></i>取消</button>
		        </div>
      		</div>
      	</div>
	</div>
	
	<!-- 快速设置modal -->
 	<div class="modal fade" id="stateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    	<div class="modal-dialog">
      		<div class="modal-content" style="width:460px; height: 300px; ">
         		<div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
		                  &times;
		            </button>
		            <h4 class="modal-title" id="myModalLabel" style="margin-top:0;font-size:22px;letter-spacing: 1.5px;width:100px">
		              	状态设置
		            </h4>
         		</div>
         		<div class="modal-body" id="modal-body" align="center" style=" min-height: 130px; " >
        			<table id="stateTable" class="addTable" style=" margin-top: 41px; ">
		                <tr>
		                  	<td>状态:</td>
		                  	<td><select id="stateState" name="stateState" class="select"></select></td>
		                </tr>
            		</table>
            		<input id="stateUuid" name="stateUuid" type="hidden" />
         		</div>
       			<hr style="color:#d0d0d0;margin-top:0px; "/>
            	<div align="right" style="padding-right:42px; padding-bottom:22px;position: absolute;right: 0px;bottom: 0px; ">
		            <button id="stateButton" onclick="stateUser()" type="button" class="btn btn-info btn-sm" style="margin-right:10px"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
		            <button type="reset" class="btn btn-sm" data-dismiss="modal" ><i class="ace-icon fa fa-undo bigger-110" ></i>取消</button>
		        </div>
      		</div>
      	</div>
	</div>
	
	<!-- 重置密码modal -->
 	<div class="modal fade" id="passwordModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    	<div class="modal-dialog">
      		<div class="modal-content" style="width:460px; height: 300px;">
         		<div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
		                  &times;
		            </button>
		            <h4 class="modal-title" id="myModalLabel" style="margin-top:0;font-size:22px;letter-spacing: 1.5px;width:100px">
		              	重置密码
		            </h4>
         		</div>
         		<div class="modal-body" id="modal-body" align="center" style=" min-height: 130px; " >
        			<table id="passwordTable" class="addTable" style=" margin-top: 31px; " >
		                <tr>
	                  		<td>密码:</td>
		                  	<td><input id="passwordPassword" name="passwordPassword" placeholder="请输入密码" type="password" class="input" type="text" onkeyup="value=value.replace(/\s/g,'')"/></td>
				       	</tr>
				       	<tr>
				       		<td>确认密码:</td>
		                  	<td><input id="passwordRPassword" name="passwordRPassword" placeholder="请输入确认密码" type="password" class="input" type="text" onkeyup="value=value.replace(/\s/g,'')"></input></td>
				       	</tr>
            		</table>
            		<input id="passwordUuid" name="passwordUuid" type="hidden" />
         		</div>
       			<hr style="color:#d0d0d0;margin-top:0"/>
            	<div align="right" style="padding-right:42px; padding-bottom:22px;position: absolute;right: 0px;bottom: 0px;">
		            <button id="passwordButton" onclick="passwordUser()" type="button" class="btn btn-info btn-sm" style="margin-right:10px"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
		            <button type="reset" class="btn btn-sm" data-dismiss="modal" ><i class="ace-icon fa fa-undo bigger-110" ></i>取消</button>
		        </div>
      		</div>
      	</div>
	</div>
</body>
<script type="text/javascript">
$(function(){
	getAllRecord();
	$.post("../user/getUserGroupInfo",{},function(result) {
		setUserGroupIdInfo(result.obj, "query");
		$("#queryUserGroupId").val(-1);
	},"json").error(function(e) {
		Modal_Alert('用户管理','加载数据失败');
	});
});
var queryName = $("#queryName");
var queryUserGroupId = $("#queryUserGroupId");
var nowDataTable = null;

var aoColumns = [
					{  
				    	"mDataProp" : "index",  
				    	"sTitle" : "序号", 
				    	"bVisible": true,
				    	"sDefaultContent" : "",
				    	"sWidth": "5%",
				    	"sClass" : "center"  
					},
                    {  
                        "mDataProp" : "loginName",  
                        "sTitle" : "登录名", 
                        "sWidth": "10%",
                        "bVisible": true,
                        "sDefaultContent" : "",  
                        "sClass" : "center"  
                    },
					{  
                        "mDataProp" : "name",  
                        "sTitle" : "姓名",
                        "sWidth": "10%",
                        "bVisible": true,
                        "sDefaultContent" : "",  
                        "sClass" : "center"  
                    },
 	               	{  
  	                   "mDataProp" : "userGroupName",  
  	                   "sTitle" : "所属用户组", 
  	                   "sWidth": "10%",
  	                   "bVisible": true,
  	                   "sDefaultContent" : "",  
  	                   "sClass" : "center"  
  	               	},
 	               	{  
   	                   "mDataProp" : "roleNames",  
   	                   "sTitle" : "角色", 
   	                   "sWidth": "20%",
   	                   "bVisible": true,
   	                   "sDefaultContent" : "",  
   	                   "sClass" : "center"  
   	               	},
 	               	{  
                       "mDataProp" : "state",  
                       "sTitle" : "状态", 
                       "bVisible": true,
                       "sDefaultContent" : "",  
                       "sWidth": "5%",
                       "sClass" : "center",
                       "render": function (data, type, full, meta) {
               	     		switch(data){
		               	          case 1:
		               	            return '<span color="green">启用</span>';
		               	          case 0:
		               	            return '<span color="red">停用</span>';  
		               	          default:
		               	            return '';
               	     		}
               	    	} 
                    },
                    {  
  	                   "mDataProp" : "updateByName",  
  	                   "sTitle" : "编辑用户", 
  	                   "sWidth": "10%",
  	                   "bVisible": true,
  	                   "sDefaultContent" : "",  
  	                   "sClass" : "center"  
  	               	},
  	               	{  
  	                   "mDataProp" : "updateTime",  
  	                   "sTitle" : "编辑时间", 
  	                   "sWidth": "10%",
  	                   "bVisible": true,
  	                   "sDefaultContent" : "",  
  	                   "sClass" : "center"  
  	               	},
                    {  
 	                   "mDataProp" : "remark",  
 	                   "sTitle" : "备注", 
 	                   "sWidth": "10%",
 	                   "bVisible": true,
 	                   "sDefaultContent" : "",  
 	                   "sClass" : "center"  
 	               	},
 	               	{  
 	                   "mDataProp" : "action",  
 	                   "sTitle" : "操作", 
 	                   "sWidth": "10%",
 	                   "bVisible": true,
 	                   "sDefaultContent" : "",  
 	                   "sClass" : "center",
 	                   "render": function (data, type, full, meta) {
 	                   		var button = "";
 	                   		button += '<a href="javascript:void(0)" onclick="deleteFun(\''+full.uuid+'\')">删除</a>&nbsp;&nbsp;&nbsp;&nbsp;';
 	                   		button += '<a href="javascript:void(0)" onclick="editFun(\''+full.uuid+'\')">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;';
 	                   		button += '<a href="javascript:void(0)" onclick="passwordFun(\''+full.uuid+'\')">重置密码</a>';
 	               	        return button;
 	              		}
                   	}
                 ];

/** -- 回车查询 -- */
function enterSearch(e) {
	var e = e || window.event; 
	var code = e.keyCode||e.which||e.charCode;
	if(code == 13){
		getAllRecord();
	} 
}

/** -- 查询条件 -- */
function addSearchInfo(aoData) {
	aoData.push({"name":"loginName","value":queryName.val()});
	if(queryUserGroupId.val() != -1) {
		aoData.push({"name":"userGroupId","value":queryUserGroupId.val()});
	}
}
     
/** -- 获取分页列表 -- */
function getAllRecord(){
	var pageNum=$("#dataTable_length").find("select").val();
	if(typeof(pageNum) != "undefined") {
		pageNum = Number(pageNum);
	}
	
	if(nowDataTable!=null){
		nowDataTable.fnClearTable(0); //清空数据
		nowDataTable.fnDestroy();
	}
	$("#thead").html("");
	$("#tbody").html("");
	
	var tabContent = $(".tab-content").height()-34-58-40;
	nowDataTable = $('#dataTable').dataTable({
		"bAutoWidth": false,//for better responsiveness
		"bProcessing": true,
		"bServerSide": true,
		"showRowNumber":false,
	    "bPaginate" : true,// 分页按钮
		"bLengthChange" : true,// 每行显示记录数
		"bSort" : false,// 排序
		"bInfo":true,
		"bStateSave":false, //是否开启cookies保存当前状态信息
		"sPaginationType": "full_numbers", //显示首页和尾页
	    "scrollY": tabContent,
	    "scrollX": $(".tab-content").width(),
		"order": [[ 0, 'asc' ]],
		"iDisplayLength": pageNum,
		"sAjaxSource": "../user/dataGrid",//请求内容为退一步请求的内容
		"aoColumns":aoColumns,
		"fnServerData": function (sSource, aoData, fnCallback ) {
			addSearchInfo(aoData);
			
			loadmask();
			$.ajax( {
				"dataType": 'json',
			 	"type": "POST",
			 	"url": sSource,
			 	"data": aoData,
			 	"success": function(resp) {
			 		disloadmask();
				 	if(resp.aaData!=null&&resp.aaData.length>0) {
				 		for(var i=0;i<resp.aaData.length;i++) {
				 			resp.aaData[i].index = i+1;
				 		}
				 	}
		            fnCallback(resp);   
		        },
				"error": function(XMLHttpRequest, textStatus, errorThrown) {
					disloadmask();
					Modal_Alert('用户管理','加载数据失败');
				}    
			});
		},
	});
}

/** -- 添加页面 -- */
function addFun() {
	var inputList=$("#addModal").find("input");
	for(var i=0;i<inputList.length;i++){
		inputList[i].value="";
	}
	var selectList=$("#addModal").find("select");
	for(var i=0;i<selectList.length;i++){
		$(selectList[i]).find("option").eq(0).attr("selected",true);
	}
	$.post("../user/getFormInfo",{},function(result) {
		setFormInfo(result, "add");
	},"json").error(function(e) {
		Modal_Alert('用户管理','加载数据失败');
	});
	$("#addModal").modal("show");
	placeHolderBug();
	$("#addPassword").val("");
	$("#addRPassword").val("");
}

/** -- 编辑页面 -- */
function editFun(uuid) {
	$.post("../user/loadById",{uuid:uuid},function(result) {
		setFormInfo(result, "update");
		$("#updateState").select2("val",result.obj.user.state);
		setData(result.obj.user);
		placeHolderBug();
	},"json").error(function(e) {
		Modal_Alert('用户管理','加载数据失败');
	});
	$("#updateModal").modal("show");
}

/** -- 删除页面 -- */
function deleteFun(uuid) {
	$("#deleteModal").css({
		"position" : "absolute",
		"top" : "15%"
	});
	$("#deleteUuid").val(uuid);
	$("#deleteModal").modal("show");
}

/** -- 删除用户 -- */
function deleteUser() {
	var uuid = $("#deleteUuid").val();
	loadmask();
	$.post("../user/delete", {uuid:uuid}, function(result){
		var success = result.success;
		if(success) {
			disloadmask();
			$("#deleteModal").modal("hide");
			setTimeout(getAllRecord(),2000);
		} else {
			disloadmask();
			Modal_Alert('用户管理', result.msg);
		}
	},"json").error(function(e) {
		disloadmask();
		Modal_Alert('用户管理','通讯失败，请重新发起请求！');
	});
}

/** -- 快速设置页面 -- */
function stateFun(uuid) {
	$("#stateModal").css({
		"position" : "absolute",
		"top" : "11%"
		// "left" : "30%"
	});
	$.post("../user/getStateInfo",{uuid:uuid},function(result) {
		setStateInfo(result.obj.stateList, "state");
		$("#stateState").select2("val",result.obj.state);
		$("#stateUuid").val(uuid);
	},"json").error(function(e) {
		Modal_Alert('用户管理','加载数据失败');
	});
	$("#stateModal").modal("show");
}

/** -- 重置密码页面 -- */
function passwordFun(uuid) {
	$("#passwordPassword").val("");
	$("#passwordRPassword").val("");
	$("#passwordModal").css({
		"position" : "absolute",
		"top" : "11%"
		// "left" : "21%"
	});
	$("#passwordUuid").val(uuid);
	$("#passwordModal").modal("show");
}
//IE低版本兼容HTML5 placeHolder属性
function placeHolderBug(){
	$("input").each(function(){
		if($(this).val()!=$(this).attr('placeholder')){
			$(this).css("color","#393939");
		}else{
			$(this).css("color","#c0c0c0");
		}
	});
	if(!placeholderSupport()){   // 判断浏览器是否支持 placeholder 
	    $('[placeholder]').focus(function() { 
	        var input = $(this); 
	        if (input.val() == input.attr('placeholder')) { 
	            input.val(''); 
	            input.removeClass('placeholder'); 
	            input.css("color","#393939");
	        } 
	    }).blur(function() { 
	        var input = $(this); 
	        if (input.val() == '' || input.val() == input.attr('placeholder')) { 
	            input.addClass('placeholder'); 
	            input.val(input.attr('placeholder')); 
	            input.css("color","#c0c0c0");
	        } 
	    }).blur(); 
	}; 
}
function placeholderSupport() { 
    return 'placeholder' in document.createElement('input'); 
}
/** -- 添加用户 -- */
function addUser() {
	var loginNameCheck = $("#addLoginName").val();
	
	var pattern = new RegExp("[`~!@#$%^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？]");
	if(pattern.test(loginNameCheck)){
		Modal_Alert('添加用户','登录名含有特殊字符！');
		return false;
	}
	var reg = new RegExp("[\u4E00-\u9FA5]"); 
	if(reg.test(loginNameCheck)){
		
		Modal_Alert('添加用户','登录名含有中文！');
		return false;
	}
	
	var data = getData("add");
	
	if(!validation(data)) {
		return false;
	}
	if(!validatePassword(data)) {
		return false;
	}
	if(!validateState(data)) {
		return false;
	}

	md5Password(data);
	var checkPassWord=checkPassword();
	if(!checkPassWord){
		return;
	}
	loadmask();
	$.post("../user/add", data, function(result){
		disloadmask();
		var success = result.success;
		if(success) {
			$("#addModal").modal("hide");
			getAllRecord();
		} else {
			Modal_Alert('用户管理', result.msg);
		}
	},"json").error(function(e) {
		disloadmask();
		Modal_Alert('用户管理','通讯失败，请重新发起请求！');
	});
}
 //验证密码的合法性
 	function checkPassword(){
	 var newPwd=$("#addPassword").val();
	 var  newPwdConfirm=$("#addRPassword").val();
		if(newPwd.length>64 || newPwd.length <6){
			 Modal_Alert('密码输入','新密码长度不能小于6或大于64！');
			 return false;
		}
		var pattern = new RegExp("[`~!@#$%^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？]");
		if(pattern.test(newPwd)){
			Modal_Alert('密码输入','新密码含有特殊字符！');
			return false;
		}
		if(pattern.test(newPwdConfirm)){
			Modal_Alert('密码输入','密码含有特殊字符！');
			return false;
		}
		if(newPwd != newPwdConfirm) {
			Modal_Alert('密码输入','两次密码输入不一致！');
			return false;
		}
		return true;
	}
/** -- 编辑用户 -- */
function updateUser(){
    var loginNameCheck = $("#updateLoginName").val();
	
    var pattern = new RegExp("[`~!@#$%^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？]");
	if(pattern.test(loginNameCheck)){
		Modal_Alert('添加用户','登录名含有特殊字符！');
		return false;
	}
	var reg = new RegExp("[\u4E00-\u9FA5]"); 
	if(reg.test(loginNameCheck)){
		
		Modal_Alert('添加用户','登录名含有中文！');
		return false;
	}
	var data = getData("update");

	if(!validation(data)) {
		return false;
	}
	if(!validateState(data)) {
		return false;
	}
	if(!validateUuid(data)) {
		return false;
	}
	
	loadmask();
	$.post("../user/edit", data, function(result){
		disloadmask();
		var success = result.success;
		if(success) {
			$("#updateModal").modal("hide");
			getAllRecord();
		} else {
			Modal_Alert('用户管理', result.msg);
		}
	},"json").error(function(e) {
		disloadmask();
		Modal_Alert('用户管理','通讯失败，请重新发起请求！');
	});
}

/** -- 快速设置 -- */
function stateUser() {
	var data = new Object();
	getUuidData(data, "state");
	getStateData(data, "state");
	
	if(!validateState(data)) {
		return false;
	}
	if(!validateUuid(data)) {
		return false;
	}
	
	loadmask();
	$.post("../user/state", data, function(result){
		disloadmask();
		var success = result.success;
		if(success) {
			$("#stateModal").modal("hide");
			getAllRecord();
		} else {
			Modal_Alert('用户管理', result.msg);
		}
	},"json").error(function(e) {
		disloadmask();
		Modal_Alert('用户管理','通讯失败，请重新发起请求！');
	});
}

/** -- 重置密码 -- */
function passwordUser() {
	var passwordRPassword=$("#passwordRPassword").val();
	var passwordPassword=$("#passwordPassword").val();
	var pattern = new RegExp("[`~!@#$%^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？]");
	if(pattern.test(passwordRPassword)){
		Modal_Alert('重置密码','密码含有特殊字符！');
		return false;
	}
	if(pattern.test(passwordPassword)){
		Modal_Alert('重置密码','密码含有特殊字符！');
		return false;
	}
	var data = new Object();
	getUuidData(data, "password");
	getPasswordData(data, "password");

	if(!validatePassword(data)) {
		return false;
	}
	if(!validateUuid(data)) {
		return false;
	}
	
	md5Password(data);
	
	loadmask();
	$.post("../user/password", data, function(result){
		disloadmask();
		var success = result.success;
		if(success) {
			$("#passwordModal").modal("hide");
			Modal_Alert('用户管理', result.msg);
		} else {
			Modal_Alert('用户管理', result.msg);
		}
	},"json").error(function(e) {
		disloadmask();
		Modal_Alert('用户管理','通讯失败，请重新发起请求！');
	});
}

/** -- 编辑页面填充数据 -- */
function setData(data) {
	$("#updateLoginName").val(data.loginName);
	$("#updateName").val(data.name);
	$("#updateUserGroupId").select2("val", data.userGroupId);
	$("#updateState").val(data.state);
	$("#updateRemark").val(data.remark);
	$("#updateUuid").val(data.uuid);
	
	var roleIds = data.roleIds;
	$('input[name="updateRoleIds"]').each(function(){
		var value = $(this).val();
		if(roleIds.indexOf(value) >= 0) {
			$(this).attr("checked", true); 
		}
	});
}

/** -- 获取数据 -- */
function getData(prefix) {
	var data = new Object();
	
	data.loginName = $("#" + prefix + "LoginName").val();
	data.name = $("#" + prefix + "Name").val();
	data.userGroupId = $("#" + prefix + "UserGroupId").val();
	data.remark = $("#" + prefix + "Remark").val();
	
	getStateData(data, prefix);
	
	if(prefix == "add") {
		getPasswordData(data, prefix);
	}
	if(prefix == "update") {
		getUuidData(data, prefix);
	}
	
	var roleIds = "";
	$('input[name="' + prefix + 'RoleIds"]:checked').each(function(){
		roleIds += $(this).val() + ",";
	});
	if(roleIds.length > 0) {
		roleIds = roleIds.substr(0, roleIds.length - 1);
	}
	data.roleIds = roleIds;
	
	return data;
}

/** -- 获取UUID -- */
function getUuidData(data, prefix) {
	data.uuid = $("#" + prefix + "Uuid").val();
}

/** -- 获取状态 -- */
function getStateData(data, prefix) {
	data.state = $("#" + prefix + "State").val();
}

/** -- 获取密码 -- */
function getPasswordData(data, prefix) {
	data.password = $("#" + prefix + "Password").val();
	data.rpassword = $("#" + prefix + "RPassword").val();
}

/** -- md5加密密码 -- */
function md5Password(data) {
	data.password = hex_md5(data.password);
	data.rpassword = hex_md5(data.rpassword);
}

/** -- 验证 -- */
function validation(data) {
	if(isNull(data.loginName, "登录名")) {
		return false;
	}
	if(data.loginName==$("#addLoginName").attr("placeholder")){
		Modal_Alert('用户管理', "请填写用户登录名");
		return false;
	}
	if(isExceed(data.loginName, 64, "登录名")) {
		return false;
	}
	if(isNull(data.name, "姓名")) {
		return false;
	}
	if(data.name==$("#addName").attr("placeholder")){
		Modal_Alert('用户管理', "请填写用户姓名");
		return false;
	}
	if(isExceed(data.name, 64, "姓名")) {
		return false;
	}
	if(isNull(data.userGroupId, "所属用户组")) {
		return false;
	}
	if(isExceed(data.userGroupId, 32, "所属用户组")) {
		return false;
	}
	if(data.roleIds.length<=0 || data.roleIds.length>7) {
		Modal_Alert('用户管理', "请选择用户角色！");
		return false;
	}

	var roleArray = data.roleIds.split(",");
	var array = ['1','2','3','4'];
	for(var i=0;i<roleArray.length;i++) {
		if($.inArray(roleArray[i], array) < 0) {
			Modal_Alert('用户管理', "用户角色不合法，请重新选择！");
			return false;
		}
	}

	if(data.remark != null && data.remark != '') {
		if(data.remark==$("#addRemark").attr("placeholder")){
			data.remark='';
		}
		if(isExceed(data.remark, 128, "备注")) {
			return false;
		}
	}
	
	return true;
}

/** -- 验证UUID -- */
function validateUuid(data) {
	if(isNull(data.uuid, "标识")) {
		return false;
	}
	if(isExceed(data.uuid, 32, "标识")) {
		return false;
	}
	return true;
}

/** -- 验证状态 -- */
function validateState(data) {
	if(isNull(data.state, "状态")) {
		return false;
	}
	if(data.state != 0 && data.state != 1) {
		Modal_Alert('用户管理', "状态不合法，请重新选择！");
		return false;
	}
	return true;
}

/** -- 验证密码 -- */
function validatePassword(data) {
	if(isNull(data.password, "密码")) {
		return false;
	}
	if(isExceed(data.password, 128, "密码")) {
		return false;
	}
	if(isLess(data.password, 6, "密码")) {
		return false;
	}
	if(isNull(data.rpassword, "确认密码")) {
		return false;
	}
	if(isExceed(data.rpassword, 128, "确认密码")) {
		return false;
	}
	if(isLess(data.rpassword, 6, "密码")) {
		return false;
	}
	if(data.password != data.rpassword) {
		Modal_Alert('用户管理', "两次密码输入不一致，请重新输入！");
		return false;
	}
	return true;
}

/** -- 填充页面数据 -- */
function setFormInfo(result, prefix) {
	var stateList = result.obj.stateList;
	var userGroupList = result.obj.userGroupList;
	var roleList = result.obj.roleList;
	
	setStateInfo(stateList, prefix);
	setUserGroupIdInfo(userGroupList, prefix);
	
	var html = "<table style='width:100%;'><tr style='width:100%;'>";
	for(var key in roleList) {
		html += '<td width="20%"><input name="' + prefix + 'RoleIds" type="checkBox" style="margin-left:0px;" value="' + key + '">' + roleList[key] + '</input></td>';
	}
	html += "</tr></table>";
	$("#" + prefix + "RolesTd").html(html);
}

/** -- 填充页面用户组信息 -- */
function setUserGroupIdInfo(userGroupList, prefix) {
	$("#" + prefix + "UserGroupId").select2({
		minimumResultsForSearch: -1,
		 data: userGroupList
	});
}

/** -- 填充页面状态信息 -- */
function setStateInfo(stateList, prefix) {
	var stateArr = new Array();
	for(var key in stateList) {
		stateArr.push({'id':key,'text':stateList[key]});
	}
	$("#" + prefix + "State").select2({
		minimumResultsForSearch: -1,
		 data: stateArr
	});
	
}

/** -- 判断是否为空 -- */
function isNull(value, name) {
	if(value == null || value == '') {
		Modal_Alert('用户管理', "请填写用户" + name);
		return true;
	}
	return false;
}

/** -- 判断是否超过规定长度 -- */
function isExceed(value, length, name) {
	if(value.length > length) {
		Modal_Alert('用户管理', "用户" + name + "过长");
		return true;
	}
	return false;
}

/** -- 判断是否小于规定长度 -- */
function isLess(value, length, name) {
	if(value.length < length) {
		Modal_Alert('用户管理', "用户" + name + "不能小于" + length + "字符");
		return true;
	}
	return false;
}
</script>
</html>