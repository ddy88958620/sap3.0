<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!---登入表单的布局 --->
<html>
	<head>
        <title>自动质检通用词组管理</title>
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
			width:160px;
			font-size:16px;
			/* color:#848484"; */	
			color:#666;	
		}
		
		.addTable .input{
			height:30px
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
<body style="height:100%;weight:100%; background-color: #f7f7f7; " >
<div id="notVisiable" style="display:none"></div>
	
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
	       			<td>
	       				<font style="font-size:14px; font-family: Micosoft YaHei; color:#88878B;">
							&nbsp;&nbsp;&nbsp;通用词组名称：
						</font>
	       				<input id="queryData" name="queryData" class="input" type="text" onkeydown="enterSearch()"/>
	       			</td>
	       			<td>
	       				&nbsp;&nbsp;&nbsp;
	       				<a>
	       					<button type="button" id="search" class="btn btn-info btn-sm" onClick="getAllRecord()">
           						<span class="ace-icon fa fa-search icon-on-right bigger-110"></span>&nbsp;查询
           					</button>
	       				</a>
	       			</td>
	   			</tr>
	   		</table>
		</div>
		
		<!-- <div id="nowPosition" style="position:absolute;right:5px;top:15px;">
			<span class="label label-xlg label-yellow arrowed-in">当前位置： 质检规则 - 
				<font  id="tabSelect">自动质检通用词组管理</font>
			</span>
		</div> -->

	    <div style="width:100%;top:45px;bottom:0px;position:absolute;height:100%;">
	       <div class="row" style="height:100%;">
		       <div class="col-sm-9 side"  style="height:100%;width:100%;padding-top:0px;padding-right: 10px;">
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
	
	<!-- 添加通用词组modal -->
 	<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="margin-top:-100px; left: 0%;position:relative ">
   		<div class="modal-dialog">
      		<div class="modal-content" style="width:560px;height:360px;" id="modalContent">
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
		                  <td style="padding-left:65px">名称:</td>
		                  <td ><input id="addName" name="addName" placeholder="请输入通用词组名称" class="input" type="text"/ style="width:280px"></td>
		                </tr>
		                <tr>
		                  <td style="padding-left:65px">内容:</td>
		                  <td id="lexiconValueDiv" style="width:280px;"></td>
		                </tr>
		                <tr>
		                  <td style="padding-left:65px">状态:</td>
		                  <td style="width:280px"><select id="addState" class="width-100" style=" font-size: 14px; "><option value="1">启用</option><option value="0">禁用</option></select></td>
		                </tr>
		                
            		</table>
         		</div>
       			<hr style="color:#d0d0d0;margin-bottom:15px;margin-top: 0 "/>
            	<div  align="right" style="position:absolute;bottom:20px;right:30px">
		            <button id="addButton" onclick="addAutoLexicon()" type="button" class="btn btn-info btn-sm" style="margin-right:10px"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
		            <button type="reset" class="btn btn-sm" data-dismiss="modal" ><i class="ace-icon fa fa-undo bigger-110" ></i>取消</button>
		        </div>
      		</div>
      	</div>
	</div>

	 <!-- 修改通用词组modal -->
	 <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="margin-top:-100px;margin-left:-200px；position:relative">
	 	<div class="modal-dialog">
	    	<div class="modal-content" style="width:560px;height:360px;" id="modalContent1">
	        	<div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
		                  &times;
		            </button>
		            <h4 class="modal-title" id="myModalLabel" style="margin-top:0;font-size:22px;letter-spacing: 1.5px;width:100px">
		              	编辑
		            </h4>
	         	</div>
	         	<div class="modal-body" id="modal-body" align="center" >
	        		<table id="updateTable" class="addTable">
		                <tr>
		                  <td style="padding-left:65px">名称:</td>
		                  <td><input id="updateName" name="updateName"  placeholder="请输入通用词组名称" class="input" type="text"/ style="width:280px"></td>
		                </tr>
		                <tr>
		                  <td style="padding-left:65px">内容:</td>
		                  <td id="lexiconValueDiv1" style="width:280px;"></td>
		                </tr>
		                <tr>
		                  <td style="padding-left:65px">状态:</td>
		                  <td style="width:280px"><select id="updateState" class="width-100"><option value="1">启用</option><option value="0">禁用</option></select></td>
		                </tr>
	            	</table>
	            	<input id="updateUuid" name="updateUuid" type="hidden" />
	         	</div>
	       		<hr style="color:#d0d0d0;margin-bottom:15px;margin-top: 0"/>
	            <div align="right" style="position:absolute;bottom:20px;right:30px">
		            <button id="updateButton" onclick="updateAutoLexicon()" type="button" class="btn btn-info btn-sm" style="margin-right:10px"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
		            <button type="reset" class="btn btn-sm" data-dismiss="modal" ><i class="ace-icon fa fa-undo bigger-110" ></i>取消</button>
		        </div>
	      	</div>
	    </div>
	 </div>
	 
	 <!-- 删除通用词组modal -->
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
						确定要删除当前通用词组？
		      		   
		        </div>
		        <input id="deleteUuid" name="deleteUuid" type="hidden" />
	        	<hr style="margin-bottom: 10px;"/>
			  	<div align="right" style="padding-right: 42px; padding-bottom: 22px;">
					<button id="deleteButton" onclick="deleteAutoLexicon()" type="button" class="btn btn-info btn-sm" style=" padding-right: 10px "><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
		            <button type="reset" class="btn btn-sm" data-dismiss="modal"><i class="ace-icon fa fa-undo bigger-110"></i>取消</button>
		        </div>
      		</div>
		</div>
	</div>
</body>
<script type="text/javascript">
$(function(){
	getAllRecord();
}); 
var queryData = $("#queryData");
var nowDataTable = null;

var aoColumns = [
					{  
					    "mDataProp" : "uuid",  
					    "sTitle" : "主键ID", 
					    "bVisible": false,
					    "sDefaultContent" : "",
					    "sWidth": "5%",
					    "sClass" : "center"  
					},
	               {  
	                   "mDataProp" : "index",  
	                   "sTitle" : "序号", 
	                   "bVisible": true,
	                   "sDefaultContent" : "",
	                   "sWidth": "5%",
	                   "sClass" : "center"  
	               },
                   {  
	                   "mDataProp" : "name",  
	                   "sTitle" : "词组名称", 
	                   "sWidth": "10%",
	                   "bVisible": true,
	                   "sDefaultContent" : "",  
	                   "sClass" : "center"  
                   },
                   {  
	                   "mDataProp" : "state",  
	                   "sTitle" : "状态", 
	                   "sWidth": "10%",
	                   "bVisible": true,
	                   "sDefaultContent" : "",  
	                   "sClass" : "center",
	                   "render" : function (data,type,full,meta){
	                	   if(0==data){
	                		   return "禁用";
	                	   }else if(1==data){
	                		   return "启用";
	                	   }
	                   }
                   },
                   {  
	                   "mDataProp" : "content",  
	                   "sTitle" : "内容", 
	                   "sWidth": "20%",
	                   "bVisible": true,
	                   "sDefaultContent" : "",  
	                   "sClass" : "center"  
	               },
                   {  
	                   "mDataProp" : "updateUserName",  
	                   "sTitle" : "编辑用户", 
	                   "sWidth": "20%",
	                   "bVisible": true,
	                   "sDefaultContent" : "",  
	                   "sClass" : "center"  
	               },
	               {  
	                   "mDataProp" : "updateTime",  
	                   "sTitle" : "编辑时间", 
	                   "sWidth": "20%",
	                   "bVisible": true,
	                   "sDefaultContent" : "",  
	                   "sClass" : "center"  
	               },
	               {  
	                   "mDataProp" : "action",  
	                   "sTitle" : "操作", 
	                   "sWidth": "20%",
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
	aoData.push({"name":"name","value":queryData.val()});
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
	
	var tabContent = $(".tab-content").height()-34-58-40;
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
	    "scrollY": tabContent,
	    "scrollX": $(".tab-content").width(),
		"order": [[ 0, 'asc' ]],
		"sAjaxSource": "../autoRuleLexicon/dataGrid",	//请求内容为退一步请求的内容
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
					Modal_Alert('自动质检通用词组管理','加载数据失败');
				}  
		 	});
		 }
	});
}
var count=0;
var tagArray = new Array();
/**-- 打开添加modal --*/
function addFun(){
	$("#addName").val('');
	$("#addContent").val('');
	$("#addModal").css({
		"position" : "absolute",
		"top" : "15%"
	});
	createWidget();
	$("#addModal").modal("show");
	placeHolderBug();
}
function createWidget() {
	var html = "";
	html += '<div class="tags" style="border-color:#72aec2;max-height:100px;  overflow-y:auto; overflow-x:hidden; width:280px; margin-top:5px;">' + 
			'<div id="tags"></div><input id="equalValue" ' + 
			'name="equalValue" type="text" placeholder="请输入词组内容,按回车键保存..." ' +
				'onkeydown="enterSearch()"></div>';
	$("#lexiconValueDiv").html(html);
	placeHolderBug();
}
function createWidget1() {
	var html = "";
	html += '<div class="tags" style="border-color:#72aec2;max-height:100px;  overflow-y:auto; overflow-x:hidden; width:280px; margin-top:5px;">' + 
			'<div id="tags"></div><input id="equalValue" ' + 
			'name="equalValue" type="text" placeholder="请输入词组内容,按回车键保存..." ' +
				'onkeydown="enterSearch()"></div>';
	$("#lexiconValueDiv1").html(html);
	placeHolderBug();
}
function enter(e) {
	enterSearch(e, 'no');	
}
function enterSearch(e, is) {
	var e = e || window.event; 
	var code = e.keyCode||e.which||e.charCode;
	if(code == 13){
		if(is == 'no') {
			window.event.returnValue = false;
			return;
		}
		
		if(!flag) {
			flag = true;
			
			var value = $("#equalValue").val();
			
			value = stripScript(value);
			if(trim(value) == '') {
				Modal_Alert('自动质检规则管理','输入不合法，请重新输入！');
				flag = false;
				return;
			}
			
			for(var i=0;i<tagArray.length;i++) {
				if(value == tagArray[i]) {
					$("#" + value).addClass("tag-warning");
					setTimeout("clearTagClass('" + value + "')",700);
					flag = false;
					return;
				}
			}
			
			tagArray[tagArray.length] = value;
			createTag(value);
			
			flag = false;
		} else {
			flag = false;
		}
	} 
}
function clearTagClass(value) {
	$("#" + value).removeClass("tag-warning");
}
function stripScript(s) {
    var pattern = new RegExp("[`~!@#$%^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？]");
    var rs = "";
    for (var i = 0; i < s.length; i++) {
        rs = rs + s.substr(i, 1).replace(pattern, '');
    }
    return rs;
}
//创建词组添加的关键词标签
function createTag(value) {
	var html = $("#tags").html();
	html += '<span class="tag" id="' + value + '">'+ value + 
		'<button type="button" class="close" onclick="clearTag(\'' + value +
		'\')">×</button></span>';
	$("#tags").html(html);
	
	$("#equalValue").val('');
}
/** -- 编辑页面 -- */
function editFun(uuid){
	
	 $("#modalContent1").css("height","360px");
	//$("#searchList1").css("display","none");
	//$("#searchConditionList1").html('');
	$("#updateModal").css({
		"position" : "absolute",
		"top" : "15%"
	});
	
	loadmask();
	$.post("../autoRuleLexicon/loadById",{uuid:uuid},function(result){
		disloadmask();
		var autoLexicon = result.obj;
		createWidget1();
		 tagArray = autoLexicon.content.split(",");
		for(var i=0;i<tagArray.length;i++) {
			createTag(tagArray[i]);
		} 
		
		$("#updateName").val(autoLexicon.name);

		$("#updateUuid").val(autoLexicon.uuid);
		$("#updateState").val(autoLexicon.state);
		$("#updateModal").find("input").each(function(){
			if($(this).val()!=$(this).attr('placeholder')){
				$(this).css("color","#393939");
			}else{
				$(this).css("color","#c0c0c0");
			}
		});
		
		$("#updateModal").modal();
		
	},"json").error(function(e) {
		Modal_Alert('自动质检通用词组管理','加载数据失败');
	});
}

/** -- 删除页面 -- */
function deleteFun(uuid) {
	$("#deleteModal").css({
		"position" : "absolute",
		"top" : "15%"
		// "left" : "5%"
	});
	$("#deleteUuid").val(uuid);
	$("#deleteModal").modal("show");
}
/** -- 添加通用词组类型 -- */
function addAutoLexicon() {
	var data = new Object();
	data.name = $("#addName").val();
	var str="";
	for(var i=0;i<tagArray.length;i++){
		if(str==""){
			str=tagArray[i];
		}else{
			str=str+","+tagArray[i];
		}
	}

	data.content = str;
	data.state = $("#addState").val();
	if(!validation(data)) {
		return;
	}
	if(str==""){
		Modal_Alert('质检通用词组管理', "词组不能为空");
		return;
	}
	loadmask();
	$.post("../autoRuleLexicon/add", data, function(result){
		disloadmask();
		var success = result.success;
		if(success) {
			$("#addModal").modal("hide");
			getAllRecord();
		} else {
			Modal_Alert('质检通用词组管理', result.msg);
		}
	},"json").error(function(e) {
		disloadmask();
		Modal_Alert('自动质检通用词组管理','通讯失败，请重新发起请求！');
	});
}

/** -- 更新通用词组类型 -- */
function updateAutoLexicon() {
	var data = new Object();
	data.name = $("#updateName").val();
	var str="";
	for(var i=0;i<tagArray.length;i++){
		if(str==""){
			str=tagArray[i];
		}else{
			str=str+","+tagArray[i];
		}
	}
	data.content = str;
	data.state = $("#updateState").val();
	data.uuid = $("#updateUuid").val();
	if(data.uuid == null || data.uuid == '') {
		Modal_Alert('自动质检通用词组管理', "信息缺失，请重新操作！");
		return;
	}
	if(!validation(data)) {
		return;
	}
	if(str==""){
		Modal_Alert('质检通用词组管理', "词组不能为空");
		return;
	}
	loadmask();
	$.post("../autoRuleLexicon/edit", data, function(result){
		disloadmask();
		var success = result.success;
		if(success) {
			$("#updateModal").modal("hide");
			getAllRecord();
		} else {
			Modal_Alert('自动质检通用词组管理', result.msg);
		}
	},"json").error(function(e) {
		disloadmask();
		Modal_Alert('自动质检通用词组管理','通讯失败，请重新发起请求！');
	});
}

/** -- 删除通用词组类型 -- */
function deleteAutoLexicon() {
	$("#deleteModal").modal("hide");
	var uuid = $("#deleteUuid").val();
	
	loadmask();
	$.post("../autoRuleLexicon/delete", {uuid:uuid}, function(result){
		disloadmask();
		var success = result.success;
		if(success) {
			getAllRecord();
		} else {
			Modal_Alert('自动质检通用词组管理', result.msg);
		}
	},"json").error(function(e) {
		disloadmask();
		Modal_Alert('自动质检通用词组管理','通讯失败，请重新发起请求！');
	});
}

/** -- 验证 -- */
function validation(data) {
	var defaultValue=$.trim($("#addName").attr('placeholder'));
	if(defaultValue==data.name){
		data.name="";
	}
	if(data.name == null || data.name == '') {
		Modal_Alert('自动质检通用词组管理', "请填写通用词组名称");
		return false;
	}
	if(data.name.length > 64) {
		Modal_Alert('自动质检通用词组管理', "通用词组名称过长");
		return false;
	}
	if(data.content != null && data.content != '') {
		if(data.content.length > 128) {
			Modal_Alert('自动质检通用词组管理', "通用词组备注过长");
			return false;
		}
	}
	return true;
}
var nowDataTable=null;
var aaData = null;
var checkTime="";
//检索条件
var number = 0;	//检索条件编号
var searchIdArray = new Array();
var ruleTypeArray = null;
var flag = false;

$(function(){
	initSearchInfo();
	 placeHolderBug();
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

//检查时间
function checkTime(start,end,dateType){
	 var startTime =  new Date(start);
	 var endTime = new Date(end);
	 var between = endTime.getTime() - startTime.getTime();
	 if(between<=0){
		 Modal_Alert('趋势统计','开始时间不能大于等于结束时间！');
        return false;
	 }

	 return true;
}


function closeWindow(id) {
	var searchFlag = $("#searchFlag" + id).val();
	if(searchFlag == '1') {
		var ruleType = getRuleType($("#searchField" + id).val());
		$("#searchTitle" + id).html(ruleType.text);
		$("#searchFlag" + id).val("2");
	} else if(searchFlag == '2') {
		$("#searchTitle" + id).html("添加检索条件");
		$("#searchFlag" + id).val("1");
	}
}
//时间转换
function convertTime(ori,type,isMult){
	if(ori==null||ori.length==0){
		Modal_Alert('检索信息错误',type.text+"的取值不能为空");
		checkTime=type.text+"的取值不能为空";
		return;
	}
	var reg = new RegExp("^[0-9]*$");  
	if(!reg.test(ori)){  
        Modal_Alert('检索信息错误', type.text+"的取值不是数字");
        checkTime=type.text+"的取值不是数字";
   } 
	
	var mult = 1;
	if(type.numberType==11){
		mult = 1000;
	}else if(type.numberType==12){
		mult = 60*1000;
	}else if(type.numberType==13){
        mult = 60*60*1000;
    }
	mult=1;
	if(type.minValue!=null&&type.minValue.length>0&&parseFloat(ori)<parseFloat(type.minValue)){
		Modal_Alert('检索信息错误',type.text+"的取值不能小于"+type.minValue);
		return null;
	}
	if(type.maxValue!=null&&type.maxValue.length>0&&parseFloat(ori)>parseFloat(type.maxValue)){
        Modal_Alert('检索信息错误',type.text+"的取值不能大于"+type.maxValue);
        return null;
    }
	if(isMult){
		return parseFloat(ori)*mult;
	}else{
		return parseFloat(ori)/mult;
	}
}


function clearTagClass(value) {
	$("#" + value).removeClass("tag-warning");
}
function stripScript(s) {
	var pattern = new RegExp("[`~!@#$%^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？]");
    var rs = "";
    for (var i = 0; i < s.length; i++) {
        rs = rs + s.substr(i, 1).replace(pattern, '');
    }
    return rs;
}

function clearTag(value) {
	$("#" + value).remove();
	for(var i=0;i<tagArray.length;i++) {
		if(value == tagArray[i]) {
			tagArray.splice(i, 1);
			break;
		}
	}
}
function initSearchInfo() {
	$.post("../search/getSearchFormInfo", null, function(result) {
		if(!result.success)
			return;
		
		ruleTypeArray = result.obj.ruleTypeList;
	},"json").error(function(e) {
		Modal_Alert('全文检索','加载检索数据失败');
	});
}

function getRuleType(value) {
	var obj = null;
	for(var i=0;i<ruleTypeArray.length;i++) {
		if(ruleTypeArray[i].id == value) {
			obj = ruleTypeArray[i];
			break;
		}
	}
	return obj;
}

function changeNumber(number){
	if(number==0){
		return "";
	}else if(number==1){
		return "个";
	}else if(number==10){
        return "毫秒";
    }else if(number==11){
        return "秒";
    }else if(number==12){
        return "分";
    }else if(number==13){
        return "时";
    }
	return "";
}


function trim(value){
	return value.replace(/(^\s*)|(\s*$)/g, "");
}
 
function textToArray(text) {
	text = text.substring(0, text.length - 1);
	var array = text.split(",");
	return array;
}

//初始化时间控件
function initDate(value){
	var direction = null;
	if(value > searchIdArray[0]) {
		direction = "top-right";
	} else {
		direction = "bottom-right";
	}

	var nowDate = new Date();
	$('#minValue' + value).datetimepicker({
		format:"yyyy-mm-dd",
		minView:2,
		maxView:2,
		endDate:nowDate,
		language:"zh-CN",
	    autoclose: true,
	    todayBtn:true ,
	    todayHighlight: true,
		pickerPosition: direction
	}).on("click",function(ev){
	    $('#minValue' + value).datetimepicker("setEndDate", $('#maxValue' + value).val());
	});
	$('#maxValue' + value).datetimepicker({
		format:"yyyy-mm-dd",
		minView:2,
		maxView:2,
		endDate:nowDate,
		language:"zh-CN",
	    autoclose: true,
	    todayBtn:true ,
	    todayHighlight: true,
	    pickerPosition: direction
	}).on("click", function (ev) {
	    $('#maxValue' + value).datetimepicker("setStartDate", $('#minValue' + value).val());
	});
}
</script>
</html>