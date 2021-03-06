<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!---登入表单的布局 --->
<html>
	<head>
        <title>评分表类别管理</title>
        <link rel="stylesheet" type="text/css" href="${ctx }/css/ace/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/font-awesome.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/ace-fonts.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/ace-skins.css">
		<link rel="stylesheet" href="${ctx }/css/ace/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
		<link rel="stylesheet" type="text/css" href="${ctx }/css/datetimepicker/bootstrap-datetimepicker.min.css">
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
		
		
		<script src="${ctx }/js/jquery-1.11.1.min.js"></script>	
	    <script src="${ctx }/js/ace/jquery.dataTables.js"></script>
		<script src="${ctx }/js/ace/bootstrap.js"></script>
        <script src="${ctx }/js/ace/jquery.dataTables.bootstrap.js"></script>
		<script src="${ctx }/js/ace/ace-extra.js"></script>
		<script src="${ctx }/js/ace/ace-elements.js"></script>
		<script src="${ctx }/js/ace/ace.js"></script>
		<script src="${ctx }/js/ace/date-time/bootstrap-datepicker.js"></script>
		<script src="${ctx }/js/select2/select2.js"></script>
		<script src="${ctx }/js/datetimepicker/bootstrap-datetimepicker.js"></script>
		<script src="${ctx }/js/datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"></script>
		<script src="${ctx }/js/respond.min.js"></script>
		<script src="${ctx }/js/ace/ace/elements.treeview.js"></script>
	    <script src="${ctx }/js/md5.js"></script>
	    
	    <c:if test="${fn:contains(sessionInfo.privilegeList, '/category/edit')}">
			<script type="text/javascript">
				$.canEdit = true;
			</script>
		</c:if>
		<c:if test="${fn:contains(sessionInfo.privilegeList, '/category/delete')}">
			<script type="text/javascript">
				$.canDelete = true;
			</script>
		</c:if>
	    
</head>

<body style="height:100%;weight:100%;" >
<!-- 主页面 -->
<img class="bg" src="../img/background.png" />
<div style="position:absolute;top:0px;bottom:0px;left:0px;right:0px;height:100%;overflow-x:hidden;overflow-y:hidden;padding:20px;" >
<div style="height:50px;">
		<div id="cesi" style="position: absolute;width:100%;margin-top:-10px">
			<table>
            	<tr>
            		<td >&nbsp;&nbsp;&nbsp;<a><button type="button" id="search" class="btn btn-info btn-sm" onClick="addFun()"><span class="fa icon-on-right bigger-110"></span>&nbsp;添加</button></a></td><td></td>
        		</tr>
        	</table>
		</div>
		<div id="nowPosition" style="position:absolute;right:5px;top:5px;"><span class="label label-xlg label-yellow arrowed-in">当前位置： 质检评分管理 - <font  id="tabSelect">评分表类别管理 </font></span></div>
	 <div class="tab-content" style="width:99%;top:52px;bottom:0px;right:10px;position:absolute;">
	  		<table id="dataTable" class="table table-striped table-bordered table-hover">
			   <thead id="thead">
			    </thead> 
			    <tbody id="tbody">
			    </tbody> 
			</table>
	 </div>
 </div>
 </div>
 
 <!-- 添加modal -->
 <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content" style="width:600px;">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel" style="text-align:center;margin-top:0;font-size:22px;color:#429af1;letter-spacing: 1.5px;width:100px">
              	添加
            </h4>
         </div>
         <div class="modal-body" id="modal-body" align="center" >
         <br/>
            <div class="form-group">
            		<label id="passw" class="col-sm-2 control-label no-padding-right" style="text-align:right;letter-spacing: 1.5px;font-size:16px;color:#666;width:100px">评分表类别 </label>
					<div class="col-sm-9" >
						<input type="text" id="addFormType" name="formType" placeholder="请输入评分表类别" class="col-xs-10 col-sm-4" style="width:190px;height:28px;"/>
						<span class="help-inline col-xs-12 col-sm-7">
							<span class="middle"><font color="red"></font></span>
						</span>
					</div>
					<br/><br/><br/>
					<label id="passw2" class="col-sm-2 control-label no-padding-right" style="text-align:right;letter-spacing: 1.5px;font-size:16px;color:#666;width:100px"> 备注</label>
					<div class="col-sm-9" >
					<textarea id="addRemark" name="remark" placeholder="备注" class="col-xs-10 col-sm-4" style="width:190px;height:80px;"></textarea>
					</div>
				</div>
         	</div>
       <hr style="color:#d0d0d0;margin:0"/>
       		<br/>
            <div align="right" style="padding-right: 10px;padding-bottom: 15px;">
            
            <button id="addButton" onclick="addFormType()" type="button" class="btn btn-info btn-sm" style="width:75px;height:30px;margin-right:15px"><i class="ace-icon fa fa-check bigger-110"></i>修改</button> 
            <button type="reset" class="btn btn-sm" data-dismiss="modal" style="width:75px;height:30px;margin-right:25px"><i class="ace-icon fa fa-undo bigger-110" ></i>取消</button>
         </div>
      </div>
      </div>
</div>
 
 <!-- 修改modal -->
 <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content" style="width:600px;">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel" style="text-align:center;margin-top:0;font-size:22px;color:#429af1;letter-spacing: 1.5px;width:100px">
              	编辑
            </h4>
         </div>
         <div class="modal-body" id="modal-body" align="center" >
         <br/>
            <div class="form-group">
            		<input id="idmesg" type="hidden" />
            		<label id="passw" class="col-sm-2 control-label no-padding-right" style="text-align:right;letter-spacing: 1.5px;font-size:16px;color:#666;width:100px">评分表类别 </label>
					<div class="col-sm-9" >
						<input type="text" id="formType" name="formType" placeholder="请输入评分表类别" class="col-xs-10 col-sm-4" style="width:190px;height:28px;"/>
						<span class="help-inline col-xs-12 col-sm-7">
							<span class="middle"><font color="red"></font></span>
						</span>
					</div>
					<br/><br/><br/>
					<label id="passw2" class="col-sm-2 control-label no-padding-right" style="text-align:right;letter-spacing: 1.5px;font-size:16px;color:#666;width:100px"> 备注</label>
					<div class="col-sm-9" >
					<textarea id="remark" name="remark" placeholder="备注" class="col-xs-10 col-sm-4" style="width:190px;height:80px;"></textarea>
					</div>
				</div>
         	</div>
       <hr style="color:#d0d0d0;margin:0"/>
       		<br/>
            <div align="right" style="padding-right: 10px;padding-bottom: 15px;">
            
            <button id="updateButton" onclick="updateFormType()" type="button" class="btn btn-info btn-sm" style="width:75px;height:30px;margin-right:15px"><i class="ace-icon fa fa-check bigger-110"></i>修改</button> 
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
         <input type="hidden" id="formTypeId" />
         <div class="modal-body" id="hint" align="center">
      			   确定要删除当前评分表类别？该类别下处于建设中和未发布状态的评分表都将被删除！
         </div>
        <hr style="margin-bottom: 10px;"/>
	  			<div align="right" style="padding-right: 10px;padding-bottom: 10px;">
			<button id="deleteButton" onclick="deleteFormType()" type="button" class="btn btn-info btn-sm"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
            <button type="reset" class="btn btn-sm" data-dismiss="modal"><i class="ace-icon fa fa-undo bigger-110"></i>取消</button>
         </div>
      </div>
	</div>
</div>


<script type="text/javascript">
var nowDataTable=null;
$(function(){
	initData();
	setTimeout("getAllRecord()",100);
});

function initData(){
	$('#dataTable tbody').on( 'click', 'tr', function () {
        $(this).toggleClass('selected');
    } );
}

function getAllRecord(){
	var pageNum=$("#dataTable_length").find("select").val();
	var aoColumns = [
	                   {  
	                        "mDataProp" : "index",  
	                        "sTitle" : "序号", 
	                        "bVisible": true,
	                        "sDefaultContent" : "",  
	                        "sClass" : "center" ,
	                        "sWidth":"150px"
	                    },
	                      {  
		                        "mDataProp" : "formType",  
		                        "sTitle" : "评分表类别", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center" ,
		                        "sWidth":"250px"
		                    },
	                      {  
		                        "mDataProp" : "remark",  
		                        "sTitle" : "描述", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center" ,
		                        "sWidth":"250px"
		                    },
		                    {  
		                        "mDataProp" : "action",  
		                        "sTitle" : "操作", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center",
		                        "sWidth":"250px",
		                        "render": function ( data, type, full, meta ) {
	                        		var button = "";
	                        		if($.canEdit){
	                        			button += "<a href='javascript:void(0)' onclick='editFun("+full.id+")'>编辑</a>&nbsp;|&nbsp;";
	                        		}
	                        		if($.canDelete){
	                        			button += "<a href='javascript:void(0)' onclick='deleteFun("+full.id+")'>删除</a>";
	                        		}
	                    	        return button;
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
		 "bAutoWidth": false,//for better responsiveness
		"bProcessing": true,
		"bServerSide": true,
		"showRowNumber":false,
         "bPaginate" : true,// 分页按钮
		"bLengthChange" : true,// 每行显示记录数
		"bSort" : false,// 排序
		"bInfo":true,
		"bStateSave":false, //是否开启cookies保存当前状态信息
		"iDisplayLength": pageNum,
	    "scrollY": tabContent,
		 "order": [[ 0, 'asc' ]],
		 "sAjaxSource": "${ctx }/formType/dataGrid",//请求内容为退一步请求的内容
		 "fnServerData": function ( sSource, aoData, fnCallback ) {
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

function addFun() {
	$("#addModal").modal("show");
}

function addFormType(){
	$('#addButton').attr("disabled", true);
	var formType = $.trim($("#addFormType").val());
	var remark = $("#addRemark").val();
	var flag = checkData(formType);
	if(!flag){
		$('#addButton').attr("disabled", false);
		return;
	}
	$.post('${ctx }' + '/formType/add', {formType:formType,remark:remark}, function (data) {
		if(data.success){
			$("#addModal").modal('hide');
			Modal_Alert('评分表类别管理','操作成功：'+data.msg + "<br/>");
			nowDataTable.fnDraw();
		}else{
			Modal_Alert('评分表类别管理','操作失败：'+data.msg);
		}
		$("#addFormType").val("");
		$('#addButton').attr("disabled", false);
	},"json").error(function() { 
		$('#addButton').attr("disabled", false);
		Modal_Alert('评分表类别管理','操作失败：'+data.msg);
	});
}

function deleteFun (id) {
	$("#deleteModal").modal("show");
	$("#formTypeId").val(id);
}

function deleteFormType(){
	$('#deleteButton').attr("disabled", true);
	var id = $("#formTypeId").val();
	$.post('${ctx }' + '/formType/delete', {id:id}, function (data) {
		if(data.success){
			$("#deleteModal").modal('hide');
			Modal_Alert('评分表类别管理','操作成功：'+data.msg + "<br/>");
			nowDataTable.fnDraw();
		}else{
			Modal_Alert('评分表类别管理','操作失败：'+data.msg);
		}
		$('#deleteButton').attr("disabled", false);
	},"json").error(function() { 
		$('#deleteButton').attr("disabled", false);
		Modal_Alert('评分表类别管理','操作失败：'+data.msg);
	});
}

function editFun(id) {
	$.post("${ctx }/formType/editPage",{id:id},function(data){
		var success = data.success;
		if(true){
			var formType = data.obj.formType;
			$("#formType").val(formType.formType);
			$("#remark").val(formType.remark);
			$("#idmesg").val(id);
			$("#updateModal").modal();
		}else{
		    $("#mesg").html(data.msg);
			$("#Msg").modal();
		}
	},"json").error(function(e) {

		Modal_Alert('评分表类别管理','加载数据失败');
	});
}

function updateFormType(){
	$('#updateButton').attr("disabled", true);
	var formType = $.trim($("#formType").val());
	var remark = $.trim($("#remark").val());
	var id = $("#idmesg").val();
	var flag = checkData(formType);
	if(!flag){
		$('#updateButton').attr("disabled", false);
		return;
	}
	$.post('${ctx }' + '/formType/edit', {id:id,formType:formType,remark:remark}, function (data) {
		if(data.success){
			$("#updateModal").modal('hide');
			Modal_Alert('评分表类别管理','操作成功：'+data.msg + "<br/>");
			nowDataTable.fnDraw();
		}else{
			Modal_Alert('评分表类别管理','操作失败：'+data.msg);
		}
		$('#updateButton').attr("disabled", false);
	},"json").error(function() { 
		$('#updateButton').attr("disabled", false);
		Modal_Alert('评分表类别管理','操作失败：'+data.msg);
	});
}

function checkData(formType){
	if( formType.length <1){
		Modal_Alert('评分表类别管理','操作失败：评分表类别不能为空');
		return;
	}
	return true;
}




</script>

</body>
</html>