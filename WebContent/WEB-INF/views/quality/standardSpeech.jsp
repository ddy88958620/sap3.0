<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!---登入表单的布局 --->
<html>
	<head>
        <title>标准话术管理</title>
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
							&nbsp;&nbsp;&nbsp;标准话术名称：
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
	
	<!-- 标准话术添加modal -->
 	<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="margin-top:-100px;margin-left:-200px; left: 0% ">
   		<div class="modal-dialog">
      		<div class="modal-content" style="width:600px;height:420px;" id="modalContent">
         		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  		&times;
            		</button>
            		<h4 class="modal-title" id="myModalLabel" style="margin-top:0;font-size:22px;letter-spacing: 1.5px;width:100px">
              			添加
            		</h4>
         		</div>
         		<div class="modal-body" id="modal-body" align="center" >
        			<table id="addTable" class="addTable" style="width:90%">
                		<tr>
		                  <td style="padding-left:0px">名称:</td>
		                  <td><input id="addName" style="width:100%" name="addName" placeholder="请输入标准话术名称" class="input" type="text"/></td>
		                </tr>
		                <tr>
		                  <td style="padding-left:0px">状态:</td>
		                  <td><select id="addState" class="width-100" style=" font-size: 14px; "><option value="1">启用</option><option value="0">禁用</option></select></td>
		                </tr>
		                <tr>
		                  <td style="padding-left:0px;width:70px">阈值(0.01~0.99):</td>
		                  <td>
		                  	<input id="addThreshold" class="input" type="text" style="width:100%; border:0px;"></input>
		                  </td>
		                </tr>
		                 <tr>
		                  <td style="padding-left:0px;margin-left:0px">标准话术内容:</td>
		                  <td>
		                  	<textArea id="addContent" name="content" placeholder="请输入标准话术内容，多条内容已*隔开" style="width:100%; height:80px; border:0px;"></textArea>
		                  </td>
		                </tr>
            		</table>
         		</div>
       			<hr style="color:#d0d0d0;margin-bottom:15px;margin-top: 0 "/>
            	<div  align="right" style=" padding-right:42px; padding-bottom:22px;">
		            <button id="addButton" onclick="addStandardSpeech()" type="button" class="btn btn-info btn-sm" style="margin-right:10px"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
		            <button type="reset" class="btn btn-sm" data-dismiss="modal" ><i class="ace-icon fa fa-undo bigger-110" ></i>取消</button>
		        </div>
      		</div>
      	</div>
	</div>

	 <!-- 修改标准话术modal -->
	 <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="margin-top:-100px;margin-left:-200px">
	 	<div class="modal-dialog">
	    	<div class="modal-content" style="width:600px;height:420px;" id="modalContent1">
	        	<div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
		                  &times;
		            </button>
		            <h4 class="modal-title" id="myModalLabel" style="margin-top:0;font-size:22px;letter-spacing: 1.5px;width:100px">
		              	编辑
		            </h4>
	         	</div>
	         	<div class="modal-body" id="modal-body" align="center" >
	        		<table id="updateTable" class="addTable" style="width:90%">
		                <tr>
		                  <td style="padding-left:0px">名称:</td>
		                  <td><input id="updateName" style="width:100%" name="updateName"  placeholder="请输入标准话术名称" class="input" type="text"/></td>
		                </tr>
		                <tr>
		                  <td style="padding-left:0px">状态:</td>
		                  <td><select id="updateState" class="width-100"><option value="1">启用</option><option value="0">禁用</option></select></td>
		                </tr>
		                 <tr>
		                  <td style="padding-left:0px;width:70px">阈值(0.01~0.99):</td>
		                  <td>
		                  	<input id="updateThreshold" class="input" type="text" style="width:100%; border:0px;"></input>
		                  </td>
		                </tr>
		                <tr>
		                  <td style="padding-left:0px;width:70px">标准话术内容:</td>
		                  <td>
		                  	<textArea id="updateContent" style="width:100%; height:80px; border:0px;"></textArea>
		                  </td>
		                </tr>
	            	</table>
	            	<div id="searchList1" style="width:70%; height:250px; margin-top:5px; margin-left:90px;overflow-y:auto; overflow-x:hidden;display:none">
					<table style="width:100%;">
						<tbody id="searchConditionList1">
						</tbody>
					</table>
				</div>
	            	<input id="updateUuid" name="updateUuid" type="hidden" />
	         	</div>
	       		<hr style="color:#d0d0d0;margin-bottom:15px;margin-top: 0"/>
	            <div align="right" style=" padding-right: 42px;padding-bottom: 22px;">
		            <button id="updateButton" onclick="updateStandardSpeech()" type="button" class="btn btn-info btn-sm" style="margin-right:10px"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
		            <button type="reset" class="btn btn-sm" data-dismiss="modal" ><i class="ace-icon fa fa-undo bigger-110" ></i>取消</button>
		        </div>
	      	</div>
	    </div>
	 </div>
	 
	 <!-- 删除标准话术modal -->
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
						确定要删除当前标准话术？
		      		   
		        </div>
		        <input id="deleteUuid" name="deleteUuid" type="hidden" />
	        	<hr style="margin-bottom: 10px;"/>
			  	<div align="right" style="padding-right: 42px; padding-bottom: 22px;">
					<button id="deleteButton" onclick="deleteStandardSpeech()" type="button" class="btn btn-info btn-sm" style=" padding-right: 10px "><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
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
					    "mDataProp" : "updateByGroupId",  
					    "sTitle" : "操作用户组id", 
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
	                   "sTitle" : "标准话术名称", 
	                   "sWidth": "10%",
	                   "bVisible": true,
	                   "sDefaultContent" : "",  
	                   "sClass" : "center"  
                   },
                   {  
	                   "mDataProp" : "state",  
	                   "sTitle" : "状态", 
	                   "sWidth": "5%",
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
	                   "sTitle" : "标准话术内容", 
	                   "sWidth": "40%",
	                   "bVisible": true,
	                   "sDefaultContent" : "",  
	                   "sClass" : "center"  
	               },
	               {  
	                   "mDataProp" : "threshold",  
	                   "sTitle" : "阈值", 
	                   "sWidth": "10%",
	                   "bVisible": true,
	                   "sDefaultContent" : "",  
	                   "sClass" : "center"  
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
		"sAjaxSource": "../standardSpeech/dataGrid",	//请求内容为退一步请求的内容
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
					Modal_Alert('标准话术管理','加载数据失败');
				}  
		 	});
		 }
	});
}
var count=0;
/**-- 打开添加modal --*/
function addFun(){
	count++;
	$("#addName").val('');
	$("#addContent").val('');
	$("#addThreshold").val('0.8');
	$("#addModal").css({
		"position" : "absolute",
		"top" : "15%"

		// "left" : "20%"
	});
	$("#addModal").modal("show");
	placeHolderBug();
	if(count>0){
		number=0;
		$("#searchConditionList").find("tr").each(function(){
			$(this).remove();
		});
		$("#modalContent").css("height","420px");
		$("#searchList").css("display","none");
	}
}

/** -- 编辑页面 -- */
function editFun(uuid){
	 $("#modalContent1").css("height","420px");
		$("#searchList1").css("display","none");
	$("#searchConditionList1").html('');
	$("#updateModal").css({
		"position" : "absolute",
		"top" : "15%"
		// "left" : "20%"
	});
	$("#updateModal").modal("show");
 	
	$.post("../standardSpeech/loadById",{uuid:uuid},function(result){
		var standardSpeech = result.obj;
		var html ="";
		$("#searchConditionList1").html('');
		searchIdArray = new Array();
		var arr=eval(standardSpeech.searchInfo);
	if (typeof(arr)!='undefined'&&arr!=null){
				if(arr.length>0){
					var num=1;
					for(var i=0; i<arr.length; i++) {

					html += "<input type='hidden' id='searchInfo" + num + "' value='" + JSON.stringify(arr[i]) + "'/>";
					num++;
					}
				}
				$("#notVisiable").html(html);
				if(arr.length>0){
					$("#modalContent1").css("height","700px");
					$("#searchList1").css("display","block");
					var number = 1;
					for(var i=0; i<arr.length; i++) {
						loadSearchInfo(number);
						number++;
					}
				}
		 }else{
			 $("#modalContent1").css("height","420px");
			$("#searchList1").css("display","none");
		 }

		$("#updateName").val(standardSpeech.name);
		$("#updateContent").val(standardSpeech.content);
		$("#updateUuid").val(standardSpeech.uuid);
		$("#updateState").val(standardSpeech.state);
		$("#updateThreshold").val(standardSpeech.threshold);
		$("#updateModal").find("input").each(function(){
			if($(this).val()!=$(this).attr('placeholder')){
				$(this).css("color","#393939");
			}else{
				$(this).css("color","#c0c0c0");
			}
		});
		$("#updateModal").modal();
	},"json").error(function(e) {
		Modal_Alert('标准话术管理','加载数据失败');
	});
}
function getSearchCondition() {
	var searchArray = new Array();
	var searchObj = null;
	var searchNumber = 0;
	
	var ruleType = null;
	
	for(var i=0; i<searchIdArray.length; i++) {
		searchObj = new Object();
		
		ruleType = getRuleType($("#searchField" + searchIdArray[i]).val());
		
		searchObj.id = ruleType.id;
		searchObj.field = ruleType.code;
		searchObj.type = ruleType.type;
		
		if(ruleType.type == '0') {
			var defaultValue=$.trim($("#equalValue" + searchIdArray[i]).attr('placeholder'));
			if(defaultValue==$.trim($("#equalValue" + searchIdArray[i]).val())){
				searchObj.equalValue ="";
			}else{
				searchObj.equalValue = $.trim($("#equalValue" + searchIdArray[i]).val());
			}
			if(searchObj.equalValue==""){
				Modal_Alert('检索信息错误',ruleType.text+"的取值不能为空");
				return null;
			}
			
		} else if(ruleType.type == '1') {
			var defaultValue=$.trim($("#equalValueText" + searchIdArray[i]).attr('placeholder'));
			if(defaultValue==$.trim($("#equalValueText" + searchIdArray[i]).val())){
				searchObj.equalValue ="";
			}else{
				searchObj.equalValue = $.trim($("#equalValueText" + searchIdArray[i]).val());
				if(searchObj.equalValue != '') {
					searchObj.equalValue = searchObj.equalValue.substring(0, searchObj.equalValue.length - 1);
				}
			}
			if(searchObj.equalValue==""){
				Modal_Alert('检索信息错误',ruleType.text+"的取值不能为空");
				return null;
			}
		} else if(ruleType.type == '2') {
			searchObj.minValue = convertTime($.trim($("#minValue" + searchIdArray[i]).val()),ruleType,true);
			if(searchObj.minValue==null){
                return null;
            }
			searchObj.maxValue = convertTime($.trim($("#maxValue" + searchIdArray[i]).val()),ruleType,true);
			if(searchObj.maxValue==null){
                return null;
            }
		} else if(ruleType.type == '3') {
			var s = "";
			var sText = "";
			$('input[name="equalValue' + searchIdArray[i] +'"]:checked').each(function(){
				s += $(this).val() + ",";
				sText += $(this).parent().text() + ",";
			});
			if(s.length > 0) {
				s = s.substr(0, s.length - 1);
				sText = sText.substr(0, sText.length - 1);
			}
			if(s==""||sText==""){
				Modal_Alert('检索信息错误',ruleType.text+"的取值不能为空");
				return null;
			}
			searchObj.equalValue = s;
			searchObj.equalValueText = sText;
		} else if(ruleType.type == '4') {
			var defaultValue=$.trim($("#equalValue" + searchIdArray[i]).attr('placeholder'));
			if(defaultValue==$.trim($("#equalValue" + searchIdArray[i]).val())){
				searchObj.equalValue ="";
			}else{
				searchObj.equalValue = $.trim($("#equalValue" + searchIdArray[i]).val());
			}
			if(searchObj.equalValue==""){
				Modal_Alert('检索信息错误',ruleType.text+"的取值不能为空");
				return null;
			}
		} else if(ruleType.type == '5') {
			var defaultValue=$.trim($("#minValue" + searchIdArray[i]).attr('placeholder'));
			if(defaultValue==$.trim($("#minValue" + searchIdArray[i]).val())){
				searchObj.minValue ="";
			}else{
				searchObj.minValue = $.trim($("#minValue" + searchIdArray[i]).val());
			}
			var defaultValue1=$.trim($("#maxValue" + searchIdArray[i]).attr('placeholder'));
			if(defaultValue1==$.trim($("#maxValue" + searchIdArray[i]).val())){
				searchObj.maxValue ="";
			}else{
				searchObj.maxValue = $.trim($("#maxValue" + searchIdArray[i]).val());
			}
			if(searchObj.minValue==""||searchObj.maxValue==""){
				Modal_Alert('检索信息错误',ruleType.text+"的取值不能为空");
				return null;
			}
			
		} else if(ruleType.type == '6') {
			var defaultValue=$.trim($("#minValue" + searchIdArray[i]).attr('placeholder'));
			if(defaultValue==$.trim($("#minValue" + searchIdArray[i]).val())){
				searchObj.minValue ="";
			}else{
				searchObj.minValue = $.trim($("#minValue" + searchIdArray[i]).val());
			}
			var defaultValue1=$.trim($("#maxValue" + searchIdArray[i]).attr('placeholder'));
			if(defaultValue1==$.trim($("#maxValue" + searchIdArray[i]).val())){
				searchObj.maxValue ="";
			}else{
				searchObj.maxValue = $.trim($("#maxValue" + searchIdArray[i]).val());
			}
			if(searchObj.minValue==""||searchObj.maxValue==""){
				Modal_Alert('检索信息错误',ruleType.text+"的取值不能为空");
				return null;
			}
		}


		searchArray[searchNumber] = searchObj;
		searchNumber++;
	}
	
	return searchArray;
}
function loadSearchInfo(value) {
	var searchInfo= JSON.parse($("#searchInfo" + value).val());
	//var searchInfo = eval('('+searchInfoText.substring(1,searchInfoText.length-1).replace(/\\\"/g,"\"")+')');
		addSearchConditionDialog1();
		$("#searchField" + number).val(searchInfo.id);
		changeValueWidget(number);
		
		if(searchInfo.type == '0') {
			$("#equalValue" + number).val(searchInfo.equalValue);
		} else if(searchInfo.type == '1') {
			
			tagArray = searchInfo.equalValue.split(",");
			//alert(tagArray.length);
			for(var i=0;i<tagArray.length;i++) {
				createTag(number, tagArray[i]);
				
			}
		} else if(searchInfo.type == '2') {
			$("#minValue" + number).val(convertTime(searchInfo.minValue,searchInfo,false));
			$("#maxValue" + number).val(convertTime(searchInfo.maxValue,searchInfo,false));
		} else if(searchInfo.type == '3') {
			$('input[name="equalValue' + number + '"]').each(function(){
				if(searchInfo.equalValue.indexOf($(this).val()) >= 0) {
					$(this).attr("checked", true);
				}
			});
		} else if(searchInfo.type == '4') {
			$("#equalValue" + number).val(searchInfo.equalValue);
		} else if(searchInfo.type == '5') {
			$("#minValue" + number).val(searchInfo.minValue);
			$("#maxValue" + number).val(searchInfo.maxValue);
		} else if(searchInfo.type == '6') {
			$("#minValue" + number).val(searchInfo.minValue);
			$("#maxValue" + number).val(searchInfo.maxValue);
		}
		number++;
}
function addSearchConditionDialog() {
	var searchCondition = searchString.toString().split(/\n/).slice(1, -1).join('\n');
	
	var reg=new RegExp("{id}","g");
	searchCondition = searchCondition.replace(reg, number);
	
	$("#searchConditionList").append(searchCondition);
	
	searchIdArray[searchIdArray.length] = number;
	initSearchField(number);
}

function initSearchField(value) {
	var id = "searchField" + value;

	if(ruleTypeArray == null || ruleTypeArray.length <= 0) {
		return;
	}
	
	var html = "";
	for(var i=0;i<ruleTypeArray.length;i++) {
		if(ruleTypeArray[i].id=="1"){
			continue;
		}
		html += "<option value='" + ruleTypeArray[i].id + "'>" + ruleTypeArray[i].text + "</option>";
	}
	$("#" + id).html(html);
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

/** -- 添加标准话术 -- */
function addStandardSpeech() {
	var data = new Object();
	data.name = $("#addName").val();
	data.content = $("#addContent").val();
	data.state = $("#addState").val();
	data.threshold = $("#addThreshold").val();
	var searchInfo = JSON.stringify(getSearchCondition());
	data.searchInfo=searchInfo;
	/**if(searchInfo==null){
		return ;
	}*/
	if(!validation(data)) {
		return;
	}
	
	loadmask();
	$.post("../standardSpeech/add", data, function(result){
		disloadmask();
		var success = result.success;
		if(success) {
			$("#addModal").modal("hide");
			getAllRecord();
		} else {
			$("#addModal").modal("hide");
			Modal_Alert('标准话术管理', result.msg);
		}
	},"json").error(function(e) {
		disloadmask();
		Modal_Alert('标准话术管理','通讯失败，请重新发起请求！');
	});
}

/** -- 更新标准话术 -- */
function updateStandardSpeech() {
	var data = new Object();
	data.name = $("#updateName").val();
	data.state = $("#updateState").val();
	data.content = $("#updateContent").val();
	data.uuid = $("#updateUuid").val();
	data.threshold = $("#updateThreshold").val();
	//alert(JSON.stringify(getSearchCondition()));
	var searchInfo = JSON.stringify(getSearchCondition());
	data.searchInfo=searchInfo;
	if(data.uuid == null || data.uuid == '') {
		Modal_Alert('标准话术管理', "信息缺失，请重新操作！");
		return;
	}
	if(!validation(data)) {
		return;
	}
	
	loadmask();
	$.post("../standardSpeech/edit", data, function(result){
		disloadmask();
		var success = result.success;
		if(success) {
			$("#updateModal").modal("hide");
			getAllRecord();
		} else {
			$("#updateModal").modal("hide");
			Modal_Alert('标准话术管理', result.msg);
		}
	},"json").error(function(e) {
		disloadmask();
		Modal_Alert('标准话术管理','通讯失败，请重新发起请求！');
	});
}

/** -- 删除标准话术 -- */
function deleteStandardSpeech() {
	$("#deleteModal").modal("hide");
	var uuid = $("#deleteUuid").val();
	
	loadmask();
	$.post("../standardSpeech/delete", {uuid:uuid}, function(result){
		disloadmask();
		var success = result.success;
		if(success) {
			getAllRecord();
		} else {
			Modal_Alert('标准话术管理', result.msg);
		}
	},"json").error(function(e) {
		disloadmask();
		Modal_Alert('标准话术管理','通讯失败，请重新发起请求！');
	});
}

/** -- 验证 -- */
function validation(data) {
	if(data.name == null || data.name == '请输入标准话术名称' || data.name == '') {
		Modal_Alert('标准话术管理', "请填写标准话术名称");
		return false;
	}
	if(data.content == null || data.content == '请输入标准话术内容' || data.content == '') {
		Modal_Alert('标准话术管理', "请填写标准话术内容");
		return false;
	}
	if(data.threshold == null || data.threshold == '') {
		Modal_Alert('标准话术管理', "请填写阈值");
		return false;
	}
	var reg = /^(0\.(?!0+$)\d{1,2}|1(\.0{1,2})?)$/;
	if(!reg.test(data.threshold)) {
		Modal_Alert('标准话术管理', "请填写正确阈值");
		return false;
	}
	if(parseInt(data.threshold)==1){
		Modal_Alert('标准话术管理', "请填写正确阈值");
		return false;
	}
	if(data.name.length > 64) {
		Modal_Alert('标准话术管理', "标准话术名称过长");
		return false;
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
function addSearchCondition() {

	$("#modalContent").css("height","700px");
	$("#searchList").css("display","block");
	addSearchConditionDialog();
	
	changeValueWidget(number);
	
	number++;
}

function updateSearchCondition() {
	$("#modalContent1").css("height","700px");
	$("#searchList1").css("display","block");

	addSearchConditionDialog1();
	
	changeValueWidget(number);
	
	number++;
}
function closeSearchCondtion(value) {

	for(var i=0;i<searchIdArray.length;i++) {
		if(value == searchIdArray[i]) {
			searchIdArray.splice(i, 1);
			break;
		}
	}
	
	var id = "search" + value;
	$("#" + id).remove();
	var len=$("#searchList").find(".widget-toolbar").length;
	if(len<1){
		$("#modalContent").css("height","500px");
		$("#searchList").css("display","none");
	}
	//判断当前第一个检索条件的类型是否是时间区间类型，如果是重新初始化时间控件
	if(searchIdArray.length > 0) {
		var ruleType = getRuleType($("#searchField" + searchIdArray[0]).val());
		if(ruleType.type == '5') {
			var minValue = $("#minValue" + searchIdArray[0]).val();
			var maxValue = $("#maxValue" + searchIdArray[0]).val();
			
			changeValueWidget(searchIdArray[0]);
			
			$("#minValue" + searchIdArray[0]).val(minValue);
			$("#maxValue" + searchIdArray[0]).val(maxValue);
		}
	}
}

function enterSearch(e, id, is) {
	var equalValueTextVal='';
	$("#tags"+id).find("span").each(function(){
		if(''==equalValueTextVal){
			equalValueTextVal=$(this).text().substring(0,$(this).text().length-1).replace("×","");
		}else{
			equalValueTextVal=equalValueTextVal+","+$(this).text().substring(0,$(this).text().length-1).replace("×","");
		}
	});
	var e = e || window.event; 
	var code = e.keyCode||e.which||e.charCode;
	if(code == 13){
		if(is == 'no') {
			e.preventDefault();
			return;
		}
		
		if(!flag) {
			flag = true;
			var value = $("#equalValue" + id).val();
			
			value = stripScript(value);
			if(trim(value) == '') {
				Modal_Alert('标准话术检索','输入不合法，请重新输入！');
				flag = false;
				return;
			}
			
			var equalValueArray = textToArray($("#equalValueText" + id).val());
			for(var i=0; i<equalValueArray.length; i++) {
				if(value == equalValueArray[i]) {
					$("#" + id + value).addClass("tag-warning");
					setTimeout("clearTagClass('" + id + value + "')",700);
					flag = false;
					return;
				}
			}
			$("#equalValueText" + id).val(equalValueTextVal +"," +value );
			//alert($("#equalValueText" + id).val());
			createTag(id, value);
			
			flag = false;
		} else {
			flag = false;
		}
	} 
}

function createTag(id, value) {
	var html = $("#tags" + id).html();
	html += '<span class="tag" id="' + id + value + '">'+ value + 
		'<button type="button" class="close" onclick="clearTag(\'' + id + '\',\'' + value +
		'\')">×</button></span>';
	$("#tags" + id).html(html);
	var equalValueTextVal1='';
	$("#tags"+id).find("span").each(function(){
		if(''==equalValueTextVal1){
			equalValueTextVal1=$(this).text().substring(0,$(this).text().length).replace("×","");
		}else{
			equalValueTextVal1=equalValueTextVal1+","+$(this).text().substring(0,$(this).text().length).replace("×","");
		}
	});
	$("#equalValueText" + id).val(equalValueTextVal1);
	$("#equalValue" + id).val('');
}
function addSearchConditionDialog1() {
	var searchCondition = searchString.toString().split(/\n/).slice(1, -1).join('\n');
	
	var reg=new RegExp("{id}","g");
	searchCondition = searchCondition.replace(reg, number);
	
	$("#searchConditionList1").append(searchCondition);
	//alert(searchIdArray.length);
	searchIdArray[searchIdArray.length] = number;
	//alert(searchIdArray.length);
	initSearchField(number);
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
function clearTag(id, value) {
	$("#" + id + value).remove();
	
	var equalValueText = $("#equalValueText" + id).val();
	var equalValueArray = textToArray(equalValueText);
	
	for(var i=0; i<equalValueArray.length; i++) {
		if(value == equalValueArray[i]) {
			equalValueText = equalValueText.substring(0, equalValueText.indexOf(value)) + equalValueText.substring(equalValueText.indexOf(value) + value.length + 1,
				equalValueText.length);
			$("#equalValueText" + id).val(equalValueText);
		}
	}
}
function changeValueWidget(value) {
	var obj = getRuleType($("#searchField" + value).val());

	var html = "";
	if(obj.type == '0') {
		$("#fieldLabel" + value).html("字段取值：");
   		html += '<input id="equalValue' + value + '" name="equalValue' + value 
   			+ '" placeholder="请输入值"' + 
   			' type="text" style="width:100%; color:#000000; height:30px; border-color:#72aec2;" value=""/>';
	} else if(obj.type == '1') {
		$("#fieldLabel" + value).html("字段取值：");
		html += '<div class="tags" style="border-color:#72aec2; max-height:100px; overflow-y:auto; overflow-x:hidden; width:100%;">' + 
				'<div id="tags' + value + '"></div><input id="equalValue' + value + '" ' + 
				'name="equalValue' + value + '" type="text" placeholder="请输入关键字...然后按回车键" ' +
				'onkeydown="enterSearch(event,\'' + value + '\',\'yes\')" /><input id="equalValueText' + value + '" placeholder="请输入关键字...然后按回车键" type="hidden"/></div>';
	} else if(obj.type == '2') {
		var type = changeNumber(obj.numberType);
		if(type.length>0){
			type = "(单位" + type+")";
		}
		$("#fieldLabel" + value).html("字段取值"+type+"：");
		html += '<input id="minValue' + value + '" name="minValue' + value + '" placeholder="最小值" style="height:30px; width:40%; border-color:#72aec2;" type="text"/>' + 
				'<label style="width:20%; font-size:12px; font-family:黑体; color:#000000;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;</label>' + 
				'<input id="maxValue' + value + '" name="maxValue' + value + '" placeholder="最大值" style="height:30px;  width:40%;  border-color:#72aec2;" type="text"/>';
	} else if(obj.type == '3') {
		$("#fieldLabel" + value).html("字段取值：");
		var array = eval(obj.value);
		if(array != null && array.length > 0) {
			var width = 100 / (array.length <= 6 ? array.length : 6);
			
			var html = "<table style='width:100%;'><tr style='width:100%;'>";
			for(var i=0;i<array.length;i++) {
				if(i%6 == 0) {
					html += "</tr><tr style='width:100%;'>";
				}
				html += '<td width="' + width + '%" align="center"><input name="equalValue' + value + '" type="checkBox" style="margin-left:0px;" value="' + array[i].id + '">' + array[i].text + '</input></td>';
			}
			html += "</tr></table>";
		} else {
			hmtl += '';
		}
	} else if(obj.type == '4') {
		$("#fieldLabel" + value).html("字段取值：");
		html += '<input id="equalValue' + value + '" name="equalValue' + value + '" placeholder="请输入值"' + 
			' type="text" style="color:#000000; width:100%; height:30px; border-color:#72aec2;"/>';
	} else if(obj.type == '5') {
		$("#fieldLabel" + value).html("字段取值：");
		html += '<input id="minValue' + value + '" name="minValue' + value + '" placeholder="开始时间" style="height:30px; width:45%; border-color:#72aec2;" type="text"/>' + 
				'<label style="width:10%; font-size:12px; font-family:黑体; color:#000000;">&nbsp;-</label>' + 
				'<input id="maxValue' + value + '" name="maxValue' + value + '" placeholder="结束时间" style="height:30px;  width:45%;  border-color:#72aec2;" type="text"/>';
	} else if(obj.type == '6') {
		$("#fieldLabel" + value).html("字段取值：(单位:分钟)");
		html += '<input id="minValue' + value + '" name="minValue' + value + '" placeholder="最小值" style="height:30px; width:40%; border-color:#72aec2;" type="text"/>' + 
				'<label style="width:20%; font-size:12px; font-family:黑体; color:#000000;">&nbsp;&nbsp;至&nbsp;&nbsp;</label>' + 
				'<input id="maxValue' + value + '" name="maxValue' + value + '" placeholder="最大值" style="height:30px;  width:40%;  border-color:#72aec2;" type="text"/>';
	}
	
	$("#valueWidget" + value).html(html);
	placeHolderBug();
 	if(obj.type == '5') {
		initDate(value);
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

function searchString() {/*
<tr style="width:100%" id="search{id}">
	<td>
		<div style="width:95%">
			<div class="widget-box">
				<div class="widget-header" style="background-color:#ffffff;">
					<font class="widget-title" style="font-size:10px; font-family: Open Sans;
							color:#669fc7; font-weight:bold;" id="searchTitle{id}">
					添加检索条件</font>
					
					<input type="hidden" id="searchFlag{id}" value="1" />

					<div class="widget-toolbar">
						<a href="#" data-action="collapse" onclick="closeWindow('{id}')">
							<i class="ace-icon fa fa-chevron-up"></i>
						</a>
					
						<a href="#" onclick="closeSearchCondtion('{id}')">
							<i class="ace-icon fa fa-times" style="color:#FF6A6A;"></i>
						</a>
					</div>
				</div>
				
				<div class="widget-body">
					<div class="widget-main">
						<div>
							<label style="font-size:12px; font-family:黑体; color:#4D4D4D;">检索字段：</label>
							<select class="input-medium" id="searchField{id}" name="searchField{id}" 
									style="color:#000000; border-color:#72aec2; width:100%; height:30px;" onchange="changeValueWidget('{id}')">
							</select>
						</div>
						<br />
						<div>
							<label id="fieldLabel{id}" for="form-field-9" style="font-size:12px; font-family:黑体; color:#4D4D4D;">字段取值：</label>
							<div id="valueWidget{id}"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</td>
</tr>
*/}


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