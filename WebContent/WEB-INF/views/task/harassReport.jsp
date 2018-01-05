<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!---登入表单的布局 --->
<html>
	<head>
        <title>防骚扰报表显示</title>
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
                    <td style="width:250px" align="right">
                       		 开始时间：&nbsp;
                        <input id="startTime" name="startTime" type="text" readonly style="width:163px;height:25px;cursor:pointer;"/>
                    </td>
                    <td style="width:250px" align="right">
                        &nbsp; 结束时间：&nbsp;
                        <input id="endTime" name="endTime" type="text" readonly style="width:163px;height:25px;cursor:pointer;"/>
                    </td>
					<td>
						<a style="margin-left: 20px">
							<button type="button" id="search" class="btn btn-info btn-sm" style="z-index:1;" onClick="getAllRecord()">
								<span class="ace-icon fa fa-search icon-on-right bigger-110"></span>&nbsp;查询
							</button>
						</a>
					</td>
					
					<td>
						<input type="button" value="aaaaaa" onclick="a()" />
					</td>
					
				</tr>
			</table>
		</div>

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
</body>
<script type="text/javascript">



function a()
{
	 window.open("http://10.0.0.225:8080/pingan_sap/externalLogin?ctiCode=100", 'newwindow', ' top=0, left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no');
}

$(function(){
	initDate();
	getAllRecord();

});
var startTime = $("#startTime");
var endTime = $("#endTime");
var nowDataTable = null;

var aoColumns = [
	{
		"mDataProp" : "name", "sTitle" : "类别", "bVisible": true, "sDefaultContent" : "", "sWidth": "20%", "sClass" : "center"
	},
	{
		"mDataProp" : "XQD-CCOD", "sTitle" : "XQD-CCOD", "sWidth": "10%", "bVisible": true, "sDefaultContent" : "0", "sClass" : "center"
	},
	{
		"mDataProp" : "XQD-HW", "sTitle" : "XQD-HW", "sWidth": "10%", "bVisible": true, "sDefaultContent" : "0", "sClass" : "center"
	},
	{
		"mDataProp" : "XQD-ZX", "sTitle" : "XQD-ZX", "sWidth": "10%", "bVisible": true, "sDefaultContent" : "0", "sClass" : "center"
	},
	{
		"mDataProp" : "XQD-ZHW", "sTitle" : "XQD-ZHW", "sWidth": "10%", "bVisible": true, "sDefaultContent" : "0", "sClass" : "center"
	},
	{
		"mDataProp" : "XQD-SHW", "sTitle" : "XQD-SHW", "bVisible": true, "sDefaultContent" : "0", "sWidth": "10%", "sClass" : "center"
	},
	{
		"mDataProp" : "total", "sTitle" : "总计", "sWidth": "10%", "bVisible": true, "sDefaultContent" : "0", "sClass" : "center"
	}
];


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
	
	var tabContent = $(".tab-content").height()-128;
	nowDataTable = $('#dataTable').dataTable({
		"bAutoWidth": false,//for better responsiveness
		"bProcessing": true,
		"bServerSide": true,
		"showRowNumber":false,
		"bPaginate" : false,
		"bScrollInfinite" : true,
		"bSort" : false,// 排序
		"bStateSave":false,//是否开启cookies保存当前状态信息
	    "scrollY": tabContent,
	    "scrollX": $(".tab-content").width(),
		"order": [[ 0, 'asc' ]],
		"sAjaxSource": "${ctx }/annoy/countDataGrid",//请求内容为退一步请求的内容
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
				 	}else if(resp.message!=null){
                    	Modal_Alert('错误信息', resp.message);
                    }
		            fnCallback(resp);   
		        },
				"error": function(XMLHttpRequest, textStatus, errorThrown) {
					disloadmask();
					Modal_Alert('用户管理','加载数据失败');
				}    
			});
		}
	});
}

/** -- 查询条件 -- */
function addSearchInfo(aoData) {
    aoData.push({"name": "endTime", "value": endTime.val()});
    aoData.push({"name": "startTime", "value": startTime.val()});
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
	today.setSeconds(0);
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
	//lastDay.setMonth(lastDay.getMonth()-1);
	lastDay.setHours(0);
	lastDay.setMinutes(0);
	lastDay.setSeconds(0);
	lastDay.setMilliseconds(0);
	return lastDay;
}
</script>
</html>