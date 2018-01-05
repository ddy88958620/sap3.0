<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!---登入表单的布局 --->
<html>
	<head>
        <title>操作日志</title>
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
	       				开始时间&nbsp;
	       				<input id="startTime" name="startTime" type="text" readonly style="width:150px;cursor:pointer;"/>
	       			</td>
	       			<td>
                        &nbsp; 结束时间&nbsp;
                        <input id="endTime" name="endTime" type="text" readonly style="width:150px;cursor:pointer;"/>
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
                   <!--  <td>
                        &nbsp;数据类型&nbsp;
                        <select class="input-medium" id="dataType" name="dataType" style="width:90px;color:#000000;" >
                                        </select>
                    </td>
                    <td>
                        &nbsp;操作类型&nbsp;
                        <select class="input-medium" id="operateType" name="operateType" style="width:90px;color:#000000;">
                                        </select>
                    </td> -->
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
				<font  id="tabSelect">操作日志</font>
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
	 
</body>
<script type="text/javascript">
$(function(){
	initDate();
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
	                   "mDataProp" : "description",
	                   "sTitle" : "用户操作",
	                   "sWidth": "20%",
	                   "bVisible": true,
	                   "sDefaultContent" : "",  
	                   "sClass" : "center"  
                   },
                   {  
	                   "mDataProp" : "requestIp",
	                   "sTitle" : "操作ip",
	                   "sWidth": "10%",
	                   "bVisible": true,
	                   "sDefaultContent" : "",  
	                   "sClass" : "center"  
	               },

                   {  
	                   "mDataProp" : "createBy",
	                   "sTitle" : "操作用户", 
	                   "sWidth": "10%",
	                   "bVisible": true,
	                   "sDefaultContent" : "",  
	                   "sClass" : "center"  
	               },
					{
						"mDataProp" : "userGroupName",
						"sTitle" : "操作用户所属组",
						"sWidth": "10%",
						"bVisible": true,
						"sDefaultContent" : "",
						"sClass" : "center"
					},
					{
						"mDataProp" : "exceptionDetail",
						"sTitle" : "异常结果说明",
						"sWidth": "15%",
						"bVisible": true,
						"sDefaultContent" : "",
						"sClass" : "center"
					},
	               {  
	                   "mDataProp" : "createDate",
	                   "sTitle" : "操作时间", 
	                   "sWidth": "20%",
	                   "bVisible": true,
	                   "sDefaultContent" : "",  
	                   "sClass" : "center"
                  	},
					{
						"mDataProp" : "action",
						"sTitle" : "操作",
						"sWidth": "15%",
						"bVisible": true,
						"sDefaultContent" : "",
						"sClass" : "center",
						"render": function (data, type, full, meta) {
							var button = "";
							button += '<a href="javascript:void(0)" onclick="excelExport(\''+full.uuid+'\')">导出参数文本</a>';
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

/** -- 填充页面用户组信息 -- */
function setUserGroupIdInfo(userGroupList, prefix) {
    $("#" + prefix + "UserGroupId").select2({
        minimumResultsForSearch: -1,
        data: userGroupList
    });
}

/** -- 查询条件 -- */
function addSearchInfo(aoData) {
	if($("#startTime").val()!=null&&$("#startTime").val().length>0)
	aoData.push({"name":"startTime","value":$("#startTime").val()});
	if($("#endTime").val()!=null&&$("#endTime").val().length>0)
	aoData.push({"name":"endTime","value":$("#endTime").val()});
    aoData.push({"name":"createBy","value":queryName.val()});
    if(queryUserGroupId.val() != -1) {
        aoData.push({"name":"userGroupId","value":queryUserGroupId.val()});
    }
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
 	//检查时间
    var startTime=$("#startTime").val();
    var start=new Date(startTime.replace("-", "/").replace("-", "/"));
    var endTime=$("#endTime").val();
    var end=new Date(endTime.replace("-", "/").replace("-", "/"));
    if(end<start){
    Modal_Alert('操作日志','开始时间不能大于等于结束时间！');
    return false;
    }
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
		"sPaginationType": "full_numbers", //显示首页和尾页
	    "scrollY": tabContent,
	    "scrollX":  $(".tab-content").width(),
		"order": [[ 0, 'asc' ]],
		"iDisplayLength": pageNum,
		"sAjaxSource": "../systemLog/dataGrid",	//请求内容为退一步请求的内容
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
				},
				"error": function(XMLHttpRequest, textStatus, errorThrown) {
					disloadmask();
					Modal_Alert('用户组管理','加载数据失败');
				}
			});
		 }
	});
}

function initDate(){
	var nowDate = new Date();
	$('#startTime').datetimepicker({
        format:"yyyy-mm-dd hh:ii:ss",
        minView:0,
        maxView:3,
        endDate:nowDate,
        language:"zh-CN",
        editable:false,
       autoclose: true,
       todayBtn:true ,
       todayHighlight: true
    });
    $('#endTime').datetimepicker({
        format:"yyyy-mm-dd hh:ii:ss",
        minView:0,
        maxView:3,
        editable:false,
        endDate:nowDate,
        language:"zh-CN",
        editable:false, 
       autoclose: true,
       todayBtn:true ,
       todayHighlight: true
    });
    var today = new Date();
    var lastDay = new Date();
    var todayString = today.format('yyyy-MM-dd hh:mm:ss');
    lastDay = getLastDate(lastDay);
    var lastDayString = lastDay.format('yyyy-MM-dd hh:mm:ss');
    $('#startTime').val(lastDayString);
    $('#endTime').val(todayString);
	$('#dataTable tbody').on( 'click', 'tr', function () {
		var aData = nowDataTable.fnGetData(this);
		$(this).toggleClass('selected');
		if($("#index"+aData.index).is(":checked")){
			$("#index"+aData.index).prop("checked",false);
		}else{
			$("#index"+aData.index).prop("checked",true);			
		}
    });
}

//默认时间
function getLastDate(lastDay){
     lastDay.setMonth(lastDay.getMonth()-1);
	 return lastDay;
}


/** -- 文件下载 -- */
function excelExport(uuid){
    var url = "${ctx }/systemLog/download";
    url += "?uuid=" + uuid;
    location.href = url;
    //Modal_Alert('导出防骚扰列表','正在下载...请稍后');
}
</script>
</html>