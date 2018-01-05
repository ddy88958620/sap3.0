<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

    <link rel="stylesheet" type="text/css" href="${ctx }/css/ace/bootstrap.css">
	<link rel="stylesheet" href="${ctx }/css/ace/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
	<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/font-awesome.css">
	<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/ace-fonts.css">
	<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/ace-skins.css">
	<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/datepicker.css">
	<link rel="stylesheet" type="text/css" href="${ctx }/css/button.css">
	<link rel="stylesheet" type="text/css" href="${ctx }/css/select2/select2.css">
	<link rel="stylesheet" type="text/css" href="${ctx }/css/zTree/zTreeStyle/zTreeStyle.css">
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
	<script src="${ctx }/js/ace/fuelux/fuelux.tree.js"></script>
	<script src="${ctx }/js/select2/select2.min.js"></script>
	<script src="${ctx }/js/ace/ace/elements.scroller.js"></script>
	<script src="${ctx }/js/ace/ace/elements.colorpicker.js"></script>
	<script src="${ctx }/js/ace/ace/elements.typeahead.js"></script>
	<script src="${ctx }/js/ace/ace/elements.wysiwyg.js"></script>
	<script src="${ctx }/js/ace/ace/elements.spinner.js"></script>
	<script src="${ctx }/js/ace/ace/elements.wizard.js"></script>
	<script src="${ctx }/js/ace/ace/elements.aside.js"></script>
	<script src="${ctx }/js/ace/ace/ace.ajax-content.js"></script>
	<script src="${ctx }/js/ace/ace/ace.touch-drag.js"></script>
	<script src="${ctx }/js/ace/ace/ace.sidebar-scroll-1.js"></script>
	<script src="${ctx }/js/ace/ace/ace.submenu-hover.js"></script>
	<script src="${ctx }/js/ace/ace/ace.widget-box.js"></script>
	<script src="${ctx }/js/ace/ace/ace.settings.js"></script>
	<script src="${ctx }/js/windowResize.js"></script>
	<script src="${ctx }/js/ace/ace/ace.settings-rtl.js"></script>
	<script src="${ctx }/js/ace/ace/ace.settings-skin.js"></script>
	<script src="${ctx }/js/ace/ace/ace.widget-on-reload.js"></script>
	<script src="${ctx }/js/ace/ace/ace.searchbox-autocomplete.js"></script>
	
	<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->
	<!--[if lte IE 8]>
		<script src="${ctx }/js/ace/html5shiv.js"></script>
		<script src="${ctx }/js/ace/respond.js"></script>
	<![endif]-->
	
	<style>
		#dataTable-wrapper div.dataTables-scroll {
			padding:0 10% 0 10%;
		}
	</style>
	
</head>
<body style="height:100%;weight:100%;" >
<img class="bg" src="../img/background.png" />
<div style="position:absolute;top:0px;bottom:0px;left:0px;right:0px;height:100%;overflow:scroll;padding:20px;" >
<div style="height:50px;">
	<div id="cesi" style="position: absolute;width:97%;padding: 10px;">
		<span style="font-size:20px;position:absolute;left:20px; top:-5px;">权限管理</span>
		<button type="button" id="search" class="btn btn-info btn-xs" style="margin-top:14px;margin-left:96%;" onClick="addRoleOpen()"><span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>&nbsp;添加</button>
	</div>
	<div id="nowPosition" style="position:absolute;right:5px;top:5px;"><span class="label label-xlg label-yellow arrowed-in">当前位置： 业务员管理 - <font  id="tabSelect">权限管理 </font></span></div>
	<div class="tab-content" style="width:97%;top:80px;bottom:0px;position:absolute;">
		<table id="dataTable"  class="table table-striped table-bordered table-hover">
			<thead id="thead">
			</thead>
			<tbody id="tbody">
			</tbody>
		</table>
	</div>
</div>
</div>
<div class="modal fade" id="roleEdit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
   <div class="modal-dialog">
      <div class="modal-content">
      	<div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
              	权限修改
            </h4>
         </div>
         <div class="modal-body" id="modal-body1" align="center">
			<div class="form-group">
					<label id="updateRoleLab" class="col-sm-2 control-label no-padding-right">权限名称</label>
					<div class="col-sm-9">
						<input type="hidden" id="updateRoleId" />
						<input type="text" id="updateRoleName" class="col-xs-10 col-sm-4" style="width:200px;height:25px;" disabled="disabled"/>
						<span id="updateRoleNameCheck" style="color:red;"></span>
					</div><br/><br/>
					<label id="roledesc" class="col-sm-2 control-label no-padding-right">权限描述 </label>
					<div class="col-sm-9">
						<textarea id="updateRoleDescription" rows="5" cols="25" class="col-xs-10 col-sm-4" style="width:200px;height:80px;" onblur="descCheck('update')"></textarea>
					</div>
				</div>
           </div><br/><br/><br/>
           <hr style="margin-bottom: 10px;"/>
            <div  align="right" style="padding-right: 10px;padding-bottom: 10px;">
            <button id="sureRelate" onclick="updateRole()" type="button" class="btn btn-info btn-sm"><i class="ace-icon fa fa-check bigger-110"></i>确 定</button> 
            <button type="reset" class="btn btn-sm" data-dismiss="modal"><i class="ace-icon fa fa-undo bigger-110"></i>取 消</button>
         </div>
      </div>
      </div>
</div>

<div class="modal fade" id="roleAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
   <div class="modal-dialog">
      <div class="modal-content" style="width:600px;">
      	<div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
              	权限添加
            </h4>
         </div>
         <div class="modal-body" id="modal-body2" align="center">
			<div class="form-group" style="padding-left: 17%;">
				<label id="addRoleLab" class="col-sm-2 control-label no-padding-right">权限名称</label>
				<div class="col-sm-9">
					<input type="text" id="addRoleName" class="col-xs-10 col-sm-4" style="width:200px;height:25px;" placeholder="此处添加角色名称" onblur="nameCheck('add')"/>
					<span id="addRoleNameCheck" style="color:red;"></span>
				</div><br/><br/>
				<label id="roledesc" class="col-sm-2 control-label no-padding-right">权限描述 </label>
				<div class="col-sm-9">
					<textarea id="addRoleDescription" rows="5" cols="25" class="col-xs-10 col-sm-4" style="width:200px;height:80px;" placeholder="此处添加角色描述" onblur="descCheck('add')"></textarea>
					<span id="addRoleDescCheck" style="color:red;"></span>
				</div>
			</div>
         </div><br/><br/><br/>
           <hr style="margin-bottom: 10px;"/>
         <div align="right" style="padding-right: 10px;padding-bottom: 10px;">
            <button id="sureRelate" onclick="addRoleSave()" type="button" class="btn btn-info btn-sm"><i class="ace-icon fa fa-check bigger-110"></i>确 定</button> 
            <button type="reset" class="btn btn-sm" data-dismiss="modal" onclick="dataClear('add')"><i class="ace-icon fa fa-undo bigger-110"></i>取 消</button>
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
         <input type="hidden" id="deleteRoleId" />
         <div class="modal-body" id="conte" align="center">
                                                确定删除该权限?
         </div>
        <hr style="margin-bottom: 10px;"/>
	  			<div align="right" style="padding-right: 10px;padding-bottom: 10px;">
			<button id="sureRelate" onclick="deleteRole()" type="button" class="btn btn-info btn-sm"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
            <button type="reset" class="btn btn-sm" data-dismiss="modal"><i class="ace-icon fa fa-undo bigger-110"></i>取消</button>
         </div>
      </div>
	</div>
</div>

<div class="modal fade" id="menuCon" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
   <div class="modal-dialog">
      <div class="modal-content">
      	<div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
              	菜单挂接
            </h4>
         </div>
         <div class="modal-body" id="modal-body3" align="center">
			<h5 id="currentRole" style="text-align:left;padding-left:2px;"></h5>
			<div class="form-group">
				<div class="col-sm-9">
					<input type="hidden" id="menuConRoleId" />
				</div>
				<div class="row">
					<div class="col-sm-6">
						<div class="widget-body">
							<div class="widget-main padding-8">
								<ul id="tree1"></ul>
							</div>
						</div>
					</div>
				</div>
			</div>
         </div>
         <hr style="margin-bottom: 10px;"/>
            <div  align="right" style="padding-right: 10px;padding-bottom: 10px;">
            <button id="sureRelate" onclick="updateRoleMenuRelation()" type="button" class="btn btn-info btn-sm"><i class="ace-icon fa fa-check bigger-110"></i>挂 接</button> 
            <button type="reset" class="btn btn-sm" data-dismiss="modal" onclick="tabReset()"><i class="ace-icon fa fa-undo bigger-110"></i>取 消</button>
         </div>
      </div>
      </div>
</div>
<script>

//角色列表
var nowDataTable = null;

//挂接菜单所需数据
var tree_data = null;

//页面加载初始化,包括数据和样式
$(function(){
	initData();
});

function initData() {
	getAllRole();
}

//获得角色清单并展示之
function getAllRole(){
	var aoColumns = [
						 {  
	                        "mDataProp" : "index",  
	                        "sTitle" : "序列号", 
	                        "bVisible": true,
	                        "sDefaultContent" : "",  
	                        "sClass" : "center"
	                     },
	                     {  
	                        "mDataProp" : "name",  
	                        "sTitle" : "权限名称", 
	                        "bVisible": true,
	                        "sDefaultContent" : "",  
	                        "sClass" : "center"
	                    },
	                    {  
	                        "mDataProp" : "description",  
	                        "sTitle" : "权限描述", 
	                        "bVisible": true,
	                        "sDefaultContent" : "",  
	                        "sClass" : "center"
	                    },
	                    {  
	                        "mDataProp" : "updateTime",  
	                        "sTitle" : "更改时间", 
	                        "bVisible": true,
	                        "sDefaultContent" : "",  
	                        "sClass" : "center"
	                    },
	                    {  
	                        "mDataProp" : "createTime",  
	                        "sTitle" : "创建时间",  
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
	                    	      return '<a onclick=\"findRole('+full.id+')\">修改</a>&nbsp;|&nbsp;<a onclick=\"findMenu('+full.id+')\">菜单挂接</a>&nbsp;|&nbsp;<a onclick=\"deleteConfirm('+full.id+')\">删除</a>';
	                    	}
	                    }
		];
	if(nowDataTable != null){
		nowDataTable.fnClearTable(0); //清空数据
		nowDataTable.fnDestroy();
	}
	$("#thead").html("");
	$("#tbody").html("");
	var tabContent = $(".tab-content").height()-34-58;
	nowDataTable = $('#dataTable').dataTable({
		 bAutoWidth: false,		//for better responsiveness
		 "bProcessing": true,
		 "bServerSide": true,
		 showRowNumber: true,
         "bPaginate": true,  	// 分页按钮
		 "bLengthChange": true, // 每行显示记录数
		 "bSort": false,		// 排序
		 "bStateSave":false, //是否开启cookies保存当前状态信息
		 bInfo:true,
		 scrollY: tabContent,
		 "order": [[0, 'asc']],
		 "sAjaxSource": "./getAllRole",//获得所有role请求
		 "fnServerData": function ( sSource, aoData, fnCallback ) {
			 $.ajax( {
			 "dataType": 'json',
			 "type": "POST",
			 "url": sSource,
			 "data": aoData,
			 "success": function(resp) {
				 	if(resp.aaData!=null && resp.aaData.length>0){
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

//更改角色前的查询动作,获得要更新的角色信息
function findRole(id) {
	$.ajax({
		url: "${ctx }/role/getRoleInfo",
		type: "post",
		data: {"id": id},
		dataType: "json",
		success: function(data) {
			if (data.errorCode == 0) {
				$("#roleEdit").modal();
				$("#updateRoleName").val(data.retMsg.name);
				$("#updateRoleDescription").val(data.retMsg.description);
				$("#updateRoleId").val(data.retMsg.id);
			}
			else {
				Modal_Alert('权限管理',data.errorMsg);
			}
		}
	});
}

//权限删除提示
function deleteConfirm(id) {
	$("#erMsg").modal();
	$("#deleteRoleId").val(id);
}

//权限删除
function deleteRole() {
	var id = $("#deleteRoleId").val();
	$("#erMsg").modal("hide");
	$.ajax({
		url: "${ctx }/role/deleteRole",
		type: "post",
		dataType: "json",
		data: {"id": id},
		success: function(data) {
			Modal_Alert('权限管理',data.errorMsg);
			if (data.errorCode == 0) {
				initData();
			}
		}
	});
}

//角色更新,包括名称和描述更新
function updateRole() {
	var id = $("#updateRoleId").val();
	var name = $("#updateRoleName").val();
	var description = $("#updateRoleDescription").val();
	if (descCheck("update")) {
		$.ajax({
			url: "${ctx }/role/updateRole",
			type: "post",
			dataType: "json",
			data: {"id": id, "name": name, "description": description},
			success: function(data) {
				Modal_Alert('权限管理',data.errorMsg);
				if (data.errorCode == 0) {
					$("#roleEdit").modal("hide");
					dataClear("update");
					initData();
				}
			}
		});
	}
}

//打开角色添加页面
function addRoleOpen() {
	dataClear("add");
	$("#roleAdd").modal();
}

//添加角色,手动项为角色描述
function addRoleSave() {
	var name = $("#addRoleName").val();
	var description = $("#addRoleDescription").val();
	if (nameCheck("add") & descCheck("add")) {
		$.ajax({
			url: "${ctx }/role/addRole",
			type: "post",
			dataType: "json",
			data: {name:name,description:description},
			success: function(data) {
				if (data.errorCode == 0) {
					$("#roleAdd").modal("hide");
					initData();
				}
				Modal_Alert('权限管理',data.errorMsg);
			}
		});
	}
}

//角色名输入检查
function nameCheck(idpre) {
	var name = $("#" + idpre + "RoleName").val();
	if (name == "") {
		$("#" + idpre + "RoleNameCheck").html("权限名不能为空!")
		return false;
	}
	$("#" + idpre + "RoleNameCheck").html("")
	return true
}

//角色描述输入检查
function descCheck(idpre) {
	var desc = $("#" + idpre + "RoleDescription").val();
	if (desc == "") {
		$("#" + idpre + "RoleDescCheck").html("权限描述不能为空!")
		return false;
	}
	$("#" + idpre + "RoleDescCheck").html("")
	return true;
}

//清空role添加修改页面的输入框
function dataClear(idpre) {
	$("#" + idpre + "RoleId").val(0);
	$("#" + idpre + "RoleName").val("");
	$("#" + idpre + "RoleDescription").val("");
	$("#" + idpre + "RoleNameCheck").html("");
	$("#" + idpre + "RoleDescCheck").html("");
}

//菜单挂接部分
function findMenu(id) {
	var menu = [];
	$("#menuCon").modal();
	$("#menuConRoleId").val(id);
	//显示当前角色
	$.ajax({
		url: "${ctx }/role/getRoleInfo?id=" + id,
		type: "post",
		dataType: "json",
		success: function(data) {
			$("#currentRole").html("当前权限-" + data.retMsg.name);
			$.ajax({
				url: "${ctx }/roleMenuAuthorization/getMenuTree",
				data: {"roleId": id},
				type: "POST",
				dataType: "json",
				success: function (data) {
					if (data != null) {
						tree_data = data.retMsg;
						var menuData = initiateData();
						$("#tree1").ace_tree({
							dataSource: menuData,
							multiSelect:true,
							cacheItems:true,
							'open-icon': 'ace-icon tree-minus',
							'close-icon': 'ace-icon tree-plus',
							'selectable': true,
							'selected-icon': 'ace-icon fa fa-check',
							'unselected-icon': 'ace-icon fa fa-times',
							'loadingHTML': '<div class="tree-loading"><i class="ace-icon fa fa-refresh fa-spin blue"></i></div>',
							cacheItems : false,
			                folderSelect : true
						});
					}
				}
			});
		}
	});
}

//初始化菜单树数据
function initiateData() {
	var dataSource = function(options, callback) {
		var $data = null;
		if(!("text" in options) && !("type" in options)) {
			$data = tree_data;
			callback({ data: $data });
			return;
		} else if("type" in options && options.type == "folder") {
			if("additionalParameters" in options && "children" in options.additionalParameters)
				$data = options.additionalParameters.children;
			else $data = {}
		}
		
		if($data != null)
			setTimeout(function(){callback({ data: $data });} , parseInt(Math.random() * 500) + 200);
	}
	return dataSource;
}

//--------------------------菜单挂接示例----------------------------
//如何获取树结构中选中的项:
/* 	var  tres=$("#tree1").tree('selectedItems');
	 for(var i=0;i<tres.length;i++){
		// tres[i].id
	    ids+=tres[i].attr.id+",";	
	    	  
	    }
		//ids构成了子节点和父节点没有被选择的那些节点的集合
		if(ids.length>0){
			ids = ids.substr(0,ids.length-1);
		} */
//--------------------------------------------------------------
//菜单挂接页面点击挂接按钮时,提交挂接结果并清空树结构
function updateRoleMenuRelation() {
	var trees = $("#tree1").tree("selectedItems");
	var ids = "";
	for (var i = 0; i < trees.length; i++) {
		ids += trees[i].attr.id + ",";
	}
	ids = ids.substr(0, ids.length - 1);
	$.ajax({
		url: "${ctx }/roleMenuAuthorization/authorize",
		dataType: "json",
		type: "POST",
		data: {ids: ids, roleId:$("#menuConRoleId").val()},
		success: function(data) {
			Modal_Alert('权限管理',data.errorMsg);
			menuTreeClear();
			$("#menuCon").modal("hide");
			initData();
		}
	});
}

//菜单挂接页面点击取消按钮时,清空树结构
function tabReset() {
	menuTreeClear();
}

//菜单挂接页面点击关闭按钮时,清空树结构
$("#menuCon div div div button.close").on("click", function() {
	menuTreeClear();
});

//菜单树清空
function menuTreeClear() {
	$("#tree1").removeData("fu.tree");
    $("#tree1").unbind('click.fu.tree');
}

</script>
</body>
</html>