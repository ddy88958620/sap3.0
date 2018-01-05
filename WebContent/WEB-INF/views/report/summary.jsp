<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!---登入表单的布局 --->
<html>
	<head>
        <title>质检汇总报表</title>
        <link rel="stylesheet" type="text/css" href="${ctx }/css/ace/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/font-awesome.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/ace-fonts.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/ace-skins.css">
		<link rel="stylesheet" href="${ctx }/css/ace/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
		<link rel="stylesheet" type="text/css" href="${ctx }/css/datetimepicker/bootstrap-datetimepicker.min.css">
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
		<script src="${ctx }/js/datetimepicker/bootstrap-datetimepicker.js"></script>
		<script src="${ctx }/js/datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"></script>
		<script src="${ctx }/js/tool.js"></script>
		<script src="${ctx }/js/jquery.ztree.core-3.5.min.js"></script>
		<script src="${ctx }/js/jquery.ztree.excheck-3.5.min.js"></script>
		<script src="${ctx }/js/jquery.ztree.exedit-3.5.min.js"></script>
		<script type="text/javascript" src="${ctx }/js/respond.min.js"></script>
		<script src="${ctx }/js/ace/ace/elements.treeview.js"></script>
	    <script type="text/javascript" src="${ctx }/js/md5.js"></script>
		
		<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->
		
		<!--[if lte IE 8]>
		<script src="${ctx }/js/ace/html5shiv.js"></script>
		<script src="${ctx }/js/ace/respond.js"></script>
		<![endif]-->

</head>
<body style="height:100%;weight:100%;" >
<img class="bg" src="../img/background.png" />
<div style="position:absolute;top:0px;bottom:0px;left:0px;right:0px;height:100%;" >
<div style="height:50px;">
		<div id="cesi" style="position: absolute;width:100%;margin-top:10px;margin-left:10px;">
			<table>
            	<tr>
            	    <td class="systemInfo" style="text-align:right;">&nbsp;部门:&nbsp;&nbsp;</td><td class="operateInfo"><select id="searchOrganization" class="js-example-basic-hide-search" style="width:150px;height:30px;"/></td>
                    <td class="systemInfo" style="text-align:right;">&nbsp;座席:&nbsp;&nbsp;</td><td class="operateInfo"><select id="searchUser" class="js-example-basic-hide-search" style="width:150px;height:30px;"/></td>
           			<td class="systemInfo" style="text-align:right;">&nbsp;评分标准:&nbsp;&nbsp;</td><td class="operateInfo"><select id="searchForm" class="js-example-basic-hide-search" style="width:150px;height:30px;"/></td>
        		</tr><!-- button button-primary button-pill button-small -->
            	<tr>
            	    <td class="systemInfo" style="text-align:right;">&nbsp;维度:&nbsp;&nbsp;</td><td class="operateInfo"><select id="searchReportType" class="js-example-basic-hide-search" style="width:150px;height:30px;"/></td>
            		<td class="systemInfo" style="text-align:right;">&nbsp;开始时间:&nbsp;&nbsp;</td><td class="systemInfo"><input type="text" id="searchStartTime" style="width:150px;height:30px;"/></td>
            		<td class="systemInfo" style="text-align:right;">&nbsp;结束时间:&nbsp;&nbsp;</td><td class="systemInfo"><input type="text" id="searchEndTime" style="width:150px;height:30px;"/></td>
           			<td >&nbsp;&nbsp;&nbsp;<a><button type="button" id="search" class="btn btn-info btn-sm" onClick="search()"><span class="ace-icon fa fa-search icon-on-right bigger-110"></span>&nbsp;查询</button></a></td><td></td>
           			<td >&nbsp;&nbsp;&nbsp;<a><button type="button" id="search" class="btn btn-info btn-sm" onClick="exportSummary()"><span class="ace-icon fa fa-download icon-on-right bigger-110"></span>&nbsp;导出</button></a></td><td></td>
            		
        		</tr><!-- button button-primary button-pill button-small -->
        	</table>
		</div>
		<div id="nowPosition" style="position:absolute;right:5px;top:5px;"><span class="label label-xlg label-yellow arrowed-in">当前位置： 质检报表管理 - <font  id="tabSelect">质检汇总报表 </font></span></div>
	 <div class="tab-content" style="width:100%;top:80px;bottom:0px;position:absolute;">
	  		<table id="dataTable" class="table table-striped table-bordered table-hover">
			   <thead id="thead">
			    </thead> 
			    <tbody id="tbody">
			    </tbody> 
			</table>
	 </div>
	 <iframe id="downloader" name="downloader" style="display:none;"></iframe>
 </div>
 </div>

<script type="text/javascript">
var nowDataTable=null;
$(function(){
	initTable();
});

/**
 * 初始化日期组件
 */
function initTable(){
	var nowDate = new Date();
	$('#searchStartTime').datetimepicker({
		format:"yyyy-mm-dd",
		minView:2,
		maxView:2,
		endDate:nowDate,
		language:"zh-CN",
		
	    autoclose: true,
	    todayBtn:true ,
	    todayHighlight: true
	});
	$('#searchEndTime').datetimepicker({
		format:"yyyy-mm-dd",
		minView:2,
		maxView:2,
		endDate:nowDate,
		language:"zh-CN",
		
	    autoclose: true,
	    todayBtn:true ,
	    todayHighlight: true
	});
	
	$.post("../user/getUserCombobox", {}, function(result) {
		$("#searchUser").select2({
			minimumResultsForSearch: -1,
			 data: result
		});
		$.post("../form/getCombobox", {}, function(result) {
			  $("#searchForm").select2({
			  	  minimumResultsForSearch: -1,
				  data: result
			  });
			  search();
		  }, "json").error(function() { 
							  $("#searchForm").select2({
								  minimumResultsForSearch: -1
							  });
							  search();
						   });
			}, "json").error(function() { 
			$("#searchUser").select2({
				minimumResultsForSearch: -1
			});
			$.post("../form/getCombobox", {}, function(result) {
				$("#searchForm").select2({
					minimumResultsForSearch: -1,
					 data: result
				});
				search();
			}, "json").error(function() { 
								$("#searchForm").select2({
									minimumResultsForSearch: -1
								});
								search();
							 });
			});
	$("#searchReportType").select2({
		minimumResultsForSearch: -1,
		 data: [{"id":0, "text":"日报"}, {"id":1, "text":"周报"}, {"id":2, "text":"月报"}]
	});
}

//搜索数据
function search(){
	var start = $("#searchStartTime").val();
	var end = $("#searchEndTime").val();
	//日期校验
	if(start != null && end != null && start.length > 0 && end.length > 0){
		if(start>end){
			Modal_Alert("提醒消息","开始时间不能晚于结束时间");
			return;
		}
	}
	getAllRecord();
}	

//组装搜索条件
function addSearchInfo(aoData){
	aoData.push({"name":"organization","value":$.trim($("#searchOrganization").val())});
	aoData.push({"name":"beginDate","value":$.trim($("#searchStartTime").val())});
	aoData.push({"name":"endDate","value":$("#searchEndTime").val()});
	if (typeof($("#searchUser").select2("data")[0]) != "undefined") {
		aoData.push({"name":"users","value":$("#searchUser").select2("data")[0].id});
	}
	if (typeof($("#searchForm").select2("data")[0]) != "undefined") {
		aoData.push({"name":"form","value":$("#searchForm").select2("data")[0].id});
	}
	aoData.push({"name":"reportType","value":$("#searchReportType").select2("data")[0].id});
}

//数据加载
function getAllRecord(){
	var pageNum=$("#dataTable_length").find("select").val();
	var aoColumns = [
	                      {  
		                        "mDataProp" : "index",  
		                        "sTitle" : "序号", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center",
		                        "sWidth" : "50px"
		                    },
	                      {  
		                        "mDataProp" : "username",  
		                        "sTitle" : "座席", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center",
		                        "sWidth" : "120px"
		                    },
		                  {  
		                        "mDataProp" : "skillGroupName",  
		                        "sTitle" : "技能", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center",
		                        "sWidth" : "100px"
		                    },
	                      {  
		                        "mDataProp" : "businessName",  
		                        "sTitle" : "业务",  
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center",
		                        "sWidth" : "100px"
		                    },
	                      {  
		                        "mDataProp" : "time",  
		                        "sTitle" : "时间", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center",
		                        "sWidth" : "90px"
		                    },
	                      {  
		                        "mDataProp" : "resultCount",  
		                        "sTitle" : "评分数量", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center",
		                        "sWidth" : "90px"
		                    },
	                      {  
		                        "mDataProp" : "resultAverageScore",  
		                        "sTitle" : "平均得分", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center",
		                        "sWidth" : "90px"
		                    },
	                      {  
		                        "mDataProp" : "resultPassCount",  
		                        "sTitle" : "合格评分数量", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center",
		                        "sWidth" : "110px"
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
		bInfo:true,
		"bStateSave":true,
		"iDisplayLength": pageNum,
	    scrollY: tabContent,
		 "order": [[ 0, 'asc' ]],
		 "sAjaxSource": "./summaryDataGrid",//请求内容为退一步请求的内容
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

//导出到excel
function exportSummary() {
	IframePost.doPost({ 
		Url: "./exportSummary", 
		Target: $('#downloader')[0], 
		PostParams: {
			orgs: "",
			users: $('#searchUser').select2("data")[0].id,
			form: $('#searchForm').select2("data")[0].id,
			reportType: $('#searchReportType').select2("data")[0].id,
			beginDate: $('#searchStartTime').val(),
			endDate: $('#searchEndTime').val()
		}
	});
}

</script>

</body>
</html>