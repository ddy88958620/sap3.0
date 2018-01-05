<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!---登入表单的布局 --->
<html>
	<head>
        <title>自动质检规则管理</title>
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
			width:60px;
			font-size:16px;
			/* color:#848484"; */	
			color:#666;	
		}
		
		.addTable .input{
			height:30px
		}

	   /* #dataTable td,#dataTable th{
			white-space:nowrap;
		}  */ 
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
<body style="height:100%;weight:100%; background-color: #f7f7f7; " >
	
	<div style="position:absolute;top:0px;bottom:0px;left:0px;right:0px;height:100%;overflow-x:hidden;overflow-y:hidden;padding:10px;" >
		<div id="cesi" style="position:absolute;width:100%;left:30px">
			<table>
	       		<tr>
	       			<td>
	       				<a>
	       					<button type="button" id="add" class="btn btn-info btn-sm" style="z-index:1;" onClick="addFun()">
	       						<span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>&nbsp;添加
	       					</button>
	       				</a>
	       			</td>
	       			<td>&nbsp;&nbsp;
	       				<a>
	       					<button type="button" id="add" class="btn btn-info btn-sm" style="z-index:1;" onClick="quickAddFun()">
	       						<span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>&nbsp;快速添加
	       					</button>
	       				</a>
	       			</td>
	       			<td>
	       				<font style="font-size:14px;font-family: Micosoft YaHei; color:#88878B;">
							&nbsp;&nbsp;所属规则集：
						</font>
	       			</td>
	       			<td>
	       				<select id="queryAutoRulesId" name="queryAutoRulesId" class="select" onchange="getAllRecord()" style=" min-width: 70px; "></select>
	       			</td>
	       			<td>
	       				<font style="font-size:14px; font-family: Micosoft YaHei; color:#88878B;">
							&nbsp;&nbsp;&nbsp;规则名称：
						</font>
	       				<input id="queryData" name="queryData" class="input" type="text" onkeydown="enterSearch() " />
	       			</td>
	       			<td>
	       				&nbsp;&nbsp;&nbsp;
	       				<a>
	       					<button type="button" id="search" class="btn btn-info btn-sm" onClick="getAllRecord()">
           						<span class="ace-icon fa fa-search icon-on-right bigger-110"></span>&nbsp;查询
           					</button>
	       				</a>
	       				<!-- <a>
	       					<button type="button" id="search" class="btn btn-info btn-sm" onClick="synchronizedRule()">
           						<span class="ace-icon fa fa-search icon-on-right bigger-110"></span>&nbsp;同步规则
           					</button>
	       				</a> -->
	       			</td>
	   			</tr>
	   		</table>
		</div>
		
		<!-- <div id="nowPosition" style="position:absolute;right:5px;top:15px;">
			<span class="label label-xlg label-yellow arrowed-in">当前位置： 质检规则 - 
				<font  id="tabSelect">自动质检规则管理</font>
			</span>
		</div> -->

	     <div style="width:100%;top:45px;bottom:0px;position:absolute;height:100%;">
	    	<div class="row" style="height:100%;">
		    	<div class="col-sm-6 side"  style="height:100%;width:100%;padding-top:0px;padding-right: 10px;" >
					<div class="tab-content" style="top:10px;bottom:0px;position:absolute;width:98%;">
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
		        <div class="modal-body" id="hint" align="center" style=" line-height: 161px; " >
						确定要删除当前规则？
		      		   
		        </div>
		        <input id="deleteUuid" name="deleteUuid" type="hidden" />
	        	<hr style="margin-bottom: 10px;"/>
			  	<div align="right" style="padding-right: 42px; padding-bottom: 22px;">
					<button id="deleteButton" onclick="deleteAutoRule()" type="button" class="btn btn-info btn-sm"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
		            <button type="reset" class="btn btn-sm" data-dismiss="modal"><i class="ace-icon fa fa-undo bigger-110"></i>取消</button>
		        </div>
      		</div>
		</div>
	</div>
	</div>
	<iframe id="myIFrame" name="myIFrame" src="" scrolling="yes" frameborder="0" style="position:absolute; top:100%;;width:100%; height:100%;z-index:2;background-color: #f7f7f7;"> 
	</iframe>
	<iframe id="quickAddFrame" name="quickAddFrame" src="" scrolling="yes" frameborder="0" style="position:absolute; top:100%;;width:100%; height:100%;z-index:2;background-color: #f7f7f7;"> 
	</iframe>
</body>
<script type="text/javascript">
var queryData = $("#queryData");
var queryAutoRulesId = "";
var nowDataTable = null;

$(function(){
	$.post("../autoRule/getAutoRules",{},function(result) {
		setAutoRulesInfo(result.obj, "query");
		getAllRecord();
		$(".dataTables_scrollBody").css("overflow-x","auto");
		placeHolderBug();
		$(".dataTables_scrollHeadInner").find("table").css("width","100%");
		 $(".dataTables_scrollBody").find("table").css("width","100%");
	},"json").error(function(e) {
		Modal_Alert('自动质检规则集管理','加载数据失败');
	});
}); 
function placeHolderBug(){
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
var aoColumns = [
					{  
					    "mDataProp" : "uuid",  
					    "sTitle" : "主键ID", 
					    "bVisible": false,
					    "sDefaultContent" : "",
					    "sClass" : "center"  
					},
	               {  
	                   "mDataProp" : "index",  
	                   "sTitle" : "序号", 
	                   "bVisible": true,
	                   "sDefaultContent" : "",
	                   "sWidth": "4%",
	                   "sClass" : "center"  
	               },
                   {
	                   "mDataProp" : "name",  
	                   "sTitle" : "规则名称", 
	                   "sWidth": "10%",
	                   "bVisible": true,
	                   "sDefaultContent" : "",  
	                   "sClass" : "center"  
                   },
                   {  
	                   "mDataProp" : "autoRulesName",  
	                   "sTitle" : "所属规则集", 
	                   "sWidth": "5%",
	                   "bVisible": true,
	                   "sDefaultContent" : "",  
	                   "sClass" : "center"  
                   },
                   {  
	                   "mDataProp" : "content",  
	                   "sTitle" : "内容", 
	                   "sWidth": "60%",
	                   "bVisible": true,
	                   "sDefaultContent" : "",  
	                   "sClass" : "center",
	                   "render":function (data, type, full, meta) {
	                		   return data;
	                   }
	               },
	               {  
	                   "mDataProp" : "state",  
	                   "sTitle" : "状态", 
	                   "sWidth": "5%",
	                   "bVisible": true,
	                   "sDefaultContent" : "",  
	                   "sClass" : "center",
	                   "render":function (data, type, full, meta) {
	                	   if(0==full.state){
	                		   return "禁用";
	                	   }else if(1==full.state){
	                		   return "启用";
	                	   }else{
	                		   return "";
	                	   }
	                   }
	               },
                   {  
	                   "mDataProp" : "updateByName",  
	                   "sTitle" : "编辑用户", 
	                   "sWidth": "5%",
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
	                   		button += '<a href="javascript:void(0)" onclick="editFun(\''+full.uuid+'\')">编辑</a>&nbsp;&nbsp;';
	                   		button += '<a href="javascript:void(0)" onclick="deleteFun(\''+full.uuid+'\')">删除</a>&nbsp;&nbsp;';
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
	queryAutoRulesId = $('#queryAutoRulesId').val();
	aoData.push({"name":"name","value":queryData.val()});
	aoData.push({"name":"autoRulesId","value":queryAutoRulesId});
}

/** -- 获取分页列表 -- */
function getAllRecord() {
	var pageNum=$("#dataTable_length").find("select").val();
	if(nowDataTable != null) {
		nowDataTable.fnClearTable(0);
		nowDataTable.fnDestroy();
	}
	$("#thead").html("");
	$("#tbody").html("");
	
	var tabContent = $(".tab-content").height()-34-58-40-40;
	nowDataTable = $('#dataTable').dataTable({
		"bAutoWidth": false,	//for better responsiveness
		"bProcessing": true,
		"bServerSide": true,
		"showRowNumber":false,
        "bPaginate" : true,	//分页按钮
		"bLengthChange" : true,	//每页显示记录数
		"bSort" : false,	//排序
		"bInfo":true,
		"bStateSave":false, //是否开启cookies保存当前状态信息
		"iDisplayLength": pageNum,
		"sPaginationType": "full_numbers", //显示首页和尾页
	    "scrollY": tabContent,
	    "scrollX": $(".tab-content").width(),
		"order": [[ 0, 'asc' ]],
		"sAjaxSource": "../autoRule/dataGrid",	//请求内容为退一步请求的内容
		"aoColumns":aoColumns,
		"fnServerData": function (sSource, aoData, fnCallback) {
			addSearchInfo(aoData);
			
			loadmask();
			$.ajax({
				"dataType": 'json',
				"type": "POST",
				"url": sSource,
				"data": aoData,
				"success": function(resp) {
					disloadmask();
				 	if(resp.aaData!=null&&resp.aaData.length>0){
				 		for(var i=0;i<resp.aaData.length;i++){
				 			resp.aaData[i].index = i+1;
				 		}
				 	}
				    fnCallback(resp);   
				} ,
				"error": function(XMLHttpRequest, textStatus, errorThrown) {
					disloadmask();
					Modal_Alert('自动质检规则管理','加载数据失败');
				}  
		 	});
		 }
	});
}

/** -- 添加页面 -- */
function addFun() {
	editUuid = null;
	$.post("../autoRule/getAutoRules",{},function(result) {
		if(result.success==true){
			openIFrame();			
		}else{
			Modal_Alert('自动质检规则管理','请先添加规则集！');	
		}
	},"json").error(function(e) {
		Modal_Alert('自动质检规则管理','加载数据失败');
	});
}

/** -- 快速添加页面 -- */
function quickAddFun() {
	editUuid = null;
	$.post("../autoRule/getAutoRules",{},function(result) {
		if(result.success==true){
			openQuickAddFrame();			
		}else{
			Modal_Alert('自动质检规则管理','请先添加规则集！');	
		}
	},"json").error(function(e) {
		Modal_Alert('自动质检规则管理','加载数据失败');
	});
}

/** -- 编辑页面 -- */
function editFun(uuid) {
	editUuid = uuid;
	openIFrame();
}

/** -- 删除页面 -- */
function deleteFun(uuid) {
	$("#deleteModal").css({
		"position" : "absolute",
		"top" : "15%",
		"left" : "5%"
	});
	$("#deleteUuid").val(uuid);
	$("#deleteModal").modal("show");
}

/** -- 删除规则 -- */
function deleteAutoRule(){
	$("#deleteModal").modal("hide");
	var uuid = $("#deleteUuid").val();
	
	loadmask();
	$.post("../autoRule/delete", {uuid:uuid}, function(result){
		disloadmask();
		var success = result.success;
		if(success) {
			getAllRecord();
		} else {
			Modal_Alert('自动质检规则集管理', result.msg);
		}
	},"json").error(function(e) {
		disloadmask();
		Modal_Alert('自动质检规则集管理','通讯失败，请重新发起请求！');
	});
}
//同步规则
function synchronizedRule(){
	loadmask();
	$.post("../autoRule/synchronizedRule", function(result){
		disloadmask();
		var success = result.success;
		if(success) {
			Modal_Alert('自动质检规则集管理',"规则同步成功");
		} else {
			Modal_Alert('自动质检规则集管理', result.msg);
		}
	},"json").error(function(e) {
		disloadmask();
		Modal_Alert('自动质检规则集管理','通讯失败，请重新发起请求！');
	});
}
function getEditUuid() {
	return editUuid;
}

/** -- 开启IFrame -- */
function openIFrame() {
	document.getElementById("myIFrame").src = "addAutoRule";
	placeHolderBug();
	setTimeout(function(){$("#myIFrame").animate({top:"0%"},1000)},400);
}
/** -- 开启QuickAddFrame -- */
function openQuickAddFrame() {
	document.getElementById("quickAddFrame").src = "quickAddAutoRule";
	placeHolderBug();
	setTimeout(function(){$("#quickAddFrame").animate({top:"0%"},1000)},400);
}

/** -- 关闭IFrame -- */
function clearIFrame() {
	$("#myIFrame").animate({top:"100%"},1000);
}

/** -- 填充页面规则集类型信息 -- */
function setAutoRulesInfo(autoRulesList, prefix) {
	
	$("#"+prefix+"AutoRulesId").select2({
		minimumResultsForSearch: -1,
		data:autoRulesList
	});
}
</script>
</html>