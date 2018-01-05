<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!---登入表单的布局 --->
<html>
	<head>
        <title>系统参数管理</title>
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
			width:75px;
			font-size:16px;
			color:#88878C;	
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
<body style="height:100%;weight:100%;background:#f7f7f7;" >
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
							&nbsp;&nbsp;&nbsp;参数名称：
						</font>
	       				<input id="queryData" name="queryData" class="input" type="text" onkeydown="enterSearch()"/>
	       			</td>
	       			<td>
	       				&nbsp;&nbsp;&nbsp;
	       				<a>
	       					<button type="button" id="search" class="btn btn-info btn-sm" style="z-index:1;" onClick="getAllRecord()">
	       						<span class="fa icon-on-right bigger-110"></span>&nbsp;查询
	       					</button>
	       				</a>
	       			</td>
	   			</tr>
	   		</table>
		</div>
		
		<!-- <div id="nowPosition" style="position:absolute;right:5px;top:15px;">
			<span class="label label-xlg label-yellow arrowed-in">当前位置： 系统管理 - 
				<font  id="tabSelect">系统参数管理</font>
			</span>
		</div> -->

	    <div style="width:97%;top:45px;bottom:0px;position:absolute;height:100%;">
	       <div class="row" style="height:100%;">
		       <div class="col-sm-9 side"  style="height:100%;width:100%;padding-top:0px;padding-right: 10px;">
					<div class="tab-content" style="top:10px;bottom:0px;position:absolute;width:100%">
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
      		<div class="modal-content" style="width:460px;height:350px;">
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
		                  <td>名称:</td>
		                  <td><input id="addName" name="addName" placeholder="请输入系统参数名称" class="input" type="text"/></td>
		                </tr>
		                
		                <tr>
		                  <td>参数值:</td>
		                  <td><input id="addValue" name="addValue" placeholder="请输入系统参数值" class="input" type="text"/></td>
		                </tr>
		                
		                <tr>
		                  <td>类型:</td>
		                  <td>
		                  	<select id="addType" name="addType" style="width:160px;float:left;">
		                  	</select>
		                  </td>
		                </tr>
		                
		                <tr>
		                  <td>备注:</td>
		                  <td><input id="addRemark" name="addRemark" placeholder="请输入备注" class="input" type="text"/></td>
		                </tr>
            		</table>
         		</div>
       			<hr style="color:#d0d0d0;margin:0"/>
            	<div align="right" style="padding-right:42px; padding-bottom:22px;">
		            <button id="addButton" onclick="addSystemParam()" type="button" class="btn btn-info btn-sm" style="margin-right:10px"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
		            <button type="reset" class="btn btn-sm" data-dismiss="modal" ><i class="ace-icon fa fa-undo bigger-110" ></i>取消</button>
		        </div>
      		</div>
      	</div>
	</div>

	 <!-- 修改modal -->
	 <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	 	<div class="modal-dialog">
	    	<div class="modal-content" style="width:460px;height:350px;">
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
		                  <td>名称:</td>
		                  <td><input id="updateName" name="updateName" placeholder="请输入系统参数名称" class="input" type="text"/></td>
		                </tr>
		                
		                <tr>
		                  <td>参数值:</td>
		                  <td><input id="updateValue" name="updateValue" placeholder="请输入系统参数值" class="input" type="text"/></td>
		                </tr>
		                
		                <tr hidden=" hidden " id="errorAlertMsg" name="errorAlertMsg">
						 <!--  <td id="alertMsg" name="alertMsg" style=" line-height: 20px; color: red; width: 50px; ">
							
						  </td>	 -->
						  <td></td>
						  <td style=" padding: 0px; ">
						  <span id="alertMsg" name="alertMsg" style=" line-height: 15px; color: red; font-size: 12px;text-align: center;padding: 0px; " ></span>

						  </td>
		                </tr>

		                <tr>
		                  <td>类型:</td>
		                  <td>
		                  	<select id="updateType" name="updateType" style="width:160px;float:left;">
		                  	</select>
		                  </td>
		                </tr>
		                
		                <tr>
		                  <td>备注:</td>
		                  <td><input id="updateRemark" name="updateRemark" placeholder="请输入备注" class="input" type="text"/></td>
		                </tr>
	            	</table>
	            	<input id="updateUuid" name="updateUuid" type="hidden" />
	         	</div>
	       		<hr style="color:#d0d0d0;margin-bottom:10px;"/>
	            <div align="right" style=" padding-right: 42px;padding-bottom: 22px;">
		            <button id="updateButton" onclick="updateSystemParam()" type="button" class="btn btn-info btn-sm" style="margin-right:10px"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
		            <button type="reset" class="btn btn-sm" data-dismiss="modal" onclick="cancleError()"><i class="ace-icon fa fa-undo bigger-110" ></i>取消</button>
		        </div>
	      	</div>
	    </div>
	 </div>
	 
</body>
<script type="text/javascript">
var regExp = new Array();
var errorMsg = new Array();
var uuid = new Array();
$(function(){
	getAllRecord();
	placeHolderBug();
}); 
var queryData = $("#queryData");
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
	                   "mDataProp" : "name",  
	                   "sTitle" : "名称", 
	                   "sWidth": "20%",
	                   "bVisible": true,
	                   "sDefaultContent" : "",  
	                   "sClass" : "center"  
                   },
	               {  
	                   "mDataProp" : "value",  
	                   "sTitle" : "参数值", 
	                   "sWidth": "13%",
	                   "bVisible": true,
	                   "sDefaultContent" : "",  
	                   "sClass" : "center"  
	               },
	               {  
	                   "mDataProp" : "type",  
	                   "sTitle" : "参数类型", 
	                   "sWidth": "12%",
	                   "bVisible": true,
	                   "sDefaultContent" : "",  
	                   "sClass" : "center",
	                   "render": function (data, type, full, meta) {
	                	   var type = full.type;
	                	   if(type == '0') {
	                		   return 'ASR引擎参数';
	                	   } else if(type == '1') {
	                		   return 'CTI接口参数';
	                	   } else if(type == '2') {
	                		   return '质检引擎参数';
	                	   } else if(type == '4') {
	                		   return '搜索引擎参数';
	                	   } else if(type == '5') {
	                		   return '其他参数';
	                	   } else {
	                		   return '';
	                	   }
	              		}
	               },
                   {  
	                   "mDataProp" : "remark",  
	                   "sTitle" : "备注", 
	                   "sWidth": "30%",
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
	                   		button += '<a href="javascript:void(0)" onclick="editFun(\''+full.uuid+'\')">编辑</a>';
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
/*取消错误信息*/
function cancleError(){
	$("#alertMsg").text("");
	$("#errorAlertMsg").hide();
	$(".modal-content").css("height","350px");
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
		"sPaginationType": "full_numbers", //显示首页和尾页
	    "scrollY": tabContent,
	    "scrollX": $(".tab-content").width(),
		"order": [[ 0, 'asc' ]],
		"sAjaxSource": "../systemParam/dataGrid",	//请求内容为退一步请求的内容
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
				 			regExp[i] = resp.aaData[i].regexp;
				 			errorMsg[i] = resp.aaData[i].errorMsg;
				 			uuid[i] = resp.aaData[i].uuid;
				 		}
				 	}
				    fnCallback(resp);   
				},
				"error": function(XMLHttpRequest, textStatus, errorThrown) {
					disloadmask();
					Modal_Alert('系统参数管理','加载数据失败');
				}
			});
		 }
	});
}

/** -- 添加页面 -- */
function addFun(){
	var inputList=$("#addModal").find("input");
	for(var i=0;i<inputList.length;i++){
		inputList[i].value="";
	}
	$("#addModal").css({
		"position" : "absolute"
		// "left" : "20%"
	});
	$("#addModal").modal("show");
	placeHolderBug();
	initSelect("add");
}
//IE低版本兼容HTML5 placeHolder属性
function placeHolderBug(){
	$("input").each(function(){
		if($(this).val()!=$(this).attr('placeholder')){
			$(this).css("color","#88878C");
		}else{
			$(this).css("color","#88878C");
		}
	});
	if(!placeholderSupport()){   // 判断浏览器是否支持 placeholder 
	    $('[placeholder]').focus(function() { 
	        var input = $(this); 
	        if (input.val() == input.attr('placeholder')) { 
	            input.val(''); 
	            input.removeClass('placeholder'); 
	            input.css("color","#88878C");
	        } 
	    }).blur(function() { 
	        var input = $(this); 
	        if (input.val() == '' || input.val() == input.attr('placeholder')) { 
	            input.addClass('placeholder'); 
	            input.val(input.attr('placeholder')); 
	            input.css("color","#88878C");
	        } 
	    }).blur(); 
	}; 
}
function placeholderSupport() { 
    return 'placeholder' in document.createElement('input'); 
}
/** -- 编辑页面 -- */
function editFun(uuid){
	$("#updateModal").css({
		"position" : "absolute"
		// "left" : "20%"
	});
	$("#updateModal").modal("show");
	$.post("../systemParam/loadById",{uuid:uuid},function(result){
		var systemParam = result.obj;
		
		$("#updateUuid").val(systemParam.uuid);
		$("#updateName").val(systemParam.name);
		$("#updateValue").val(systemParam.value);
		$("#updateRemark").val(systemParam.remark);
		
		initSelect("update");
		$('#updateType').select2('val',systemParam.type);
		placeHolderBug();
		$("#updateModal").modal();

	},"json").error(function(e) {
		Modal_Alert('系统参数管理','加载数据失败');
	});
}

function initSelect(prefix){
	var typeArray = new Array();
	typeArray.push({'id':'0','text':'ASR引擎参数'});
	typeArray.push({'id':'1','text':'CTI接口参数'});
	typeArray.push({'id':'2','text':'质检引擎参数'});
	typeArray.push({'id':'4','text':'搜索引擎参数'});
	typeArray.push({'id':'5','text':'其他参数'});
	$('#'+prefix+'Type').select2({
		minimumResultsForSearch: -1,
		data:typeArray
	});
}

/** -- 添加用户组 -- */
function addSystemParam() {
	var data = new Object();
	data.name = $("#addName").val();
	data.remark = $("#addRemark").val();
	data.value = $("#addValue").val();
	data.type = $("#addType").val();
	if(data.name==$("#addName").attr("placeholder")){
		Modal_Alert('系统参数', "请输入系统参数名称");
		return false;
	}
	if(data.value==$("#addValue").attr("placeholder")){
		Modal_Alert('系统参数', "请输入系统参数值");
		return false;
	}
	if(data.remark==$("#addRemark").attr("placeholder")){
		data.remark="";
	}
	if(!validation(data)) {
		return;
	}
	
	loadmask();
	$.post("../systemParam/add", data, function(result){
		disloadmask();
		var success = result.success;
		if(success) {
			$("#addModal").modal("hide");
			getAllRecord();
		} else {
			Modal_Alert('系统参数管理', result.msg);
		}
	},"json").error(function(e) {
		disloadmask();
		Modal_Alert('系统参数管理','通讯失败，请重新发起请求！');
	});
}

/** -- 更新用户组 -- */
function updateSystemParam() {
	var data = new Object();
	data.name = $("#updateName").val();
	data.remark = $("#updateRemark").val();
	data.uuid = $("#updateUuid").val();
	data.value = $("#updateValue").val();
	data.type = $("#updateType").val();

	if (data.uuid != null && data.uuid != '') {
		for (var i = 0; i < uuid.length; i++) {
			if (uuid[i] == data.uuid){
				data.regexp = regExp[i];
				data.errorMsg = errorMsg[i];
				var r = regExp[i];
				var reg = new RegExp(r);
				if (!reg.test(data.value)) {
					$("#errorAlertMsg").show();
					$("#alertMsg").text("");
					$("#alertMsg").append(errorMsg[i]);
					$(".modal-content").css("height",350+$("#alertMsg").height());
					// Modal_Alert('参数值错误', errorMsg[i]);
					return;
				}
					
			}
		}
	}

	if(data.name==$("#addName").attr("placeholder")){
		Modal_Alert('系统参数', "请输入系统参数名称");
		return false;
	}
	if(data.value==$("#addValue").attr("placeholder")){
		Modal_Alert('系统参数', "请输入系统参数值");
		return false;
	}
	if(data.remark==$("#addRemark").attr("placeholder")){
		data.remark="";
	}
	if(data.uuid == null || data.uuid == '') {
		Modal_Alert('系统参数管理', "信息缺失，请重新操作！");
		return;
	}
	if(!validation(data)) {
		return;
	}
	
	loadmask();
	$.post("../systemParam/edit", data, function(result){
		disloadmask();
		var success = result.success;
		if(success) {
			$("#updateModal").modal("hide");
			getAllRecord();
			
			cancleError();

		} else {
			Modal_Alert('系统参数管理', result.msg);
		}
	},"json").error(function(e) {
		disloadmask();
		Modal_Alert('系统参数管理','通讯失败，请重新发起请求！');
	});
}

/** -- 验证 -- */
function validation(data) {
	if(data.name == null || data.name == '') {
		Modal_Alert('系统参数管理', "请填写系统参数名称");
		return false;
	}
	if(data.name.length > 64) {
		Modal_Alert('系统参数管理', "系统参数名称过长");
		return false;
	}
	if(data.value == null || data.value == '') {
		Modal_Alert('系统参数管理', "请填写系统参数值");
		return false;
	}
	if(data.value.length > 500) {
		Modal_Alert('系统参数管理', "系统参数值过长");
		return false;
	}
	if(data.type != '0' && data.type != '1' &&
			data.type != '2' && data.type != '4' &&
			data.type != '5') {
		Modal_Alert('系统参数管理', "系统参数类型不合法");
		return false;
	}
	if(data.remark != null && data.remark != '') {
		if(data.remark.length > 128) {
			Modal_Alert('系统参数管理', "系统参数备注过长");
			return false;
		}
	}
	return true;
}
</script>
</html>