<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!---登入表单的布局 --->
<html>
	<head>
        <title>质检评分查询</title>
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
	.searchPanelBody tr{
		line-height:22px;
	}
	.searchPanelBody td{
		padding:10px;
		text-align:center;
		width:60px;
		font-size:16px;
		/* color:#848484"; */	
		color:#666;	
	}
	.searchPanelBody select,.searchPanelBody input{
		width:150px;
		height:25px;
		padding:2px;
		border-radius:3px;
	}
	td{white-space:nowrap;}
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
		<script src="${ctx }/js/ace/ace-extra.js"></script>
		<script src="${ctx }/js/ace/ace-elements.js"></script>
		<script src="${ctx }/js/ace/ace.js"></script>
		<script src="${ctx }/js/select2/select2.js"></script>
		<script src="${ctx }/js/datetimepicker/bootstrap-datetimepicker.js"></script>
		<script src="${ctx }/js/datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"></script>
		<script src="${ctx }/js/voice/audioCommon.js"></script>
		<script src="${ctx }/js/voice/audioSearch.js"></script>
		<script src="${ctx }/js/voice/exportExcel.js"></script>
		<script src="${ctx }/js/voice/parseTransFile.js"></script>
		<script type="text/javascript" src="${ctx }/js/respond.min.js"></script>
		<script src="${ctx }/js/ace/jquery.dataTables.bootstrap.js"></script>
		
		<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->
		
		<!--[if lte IE 8]>
		<script src="${ctx }/js/ace/html5shiv.js"></script>
		<script src="${ctx }/js/ace/respond.js"></script>
		<![endif]-->

</head>
<body style="height:100%;weight:100%;" >
<img class="bg" src="../img/background.png" />
		<div class="col-xs-12 col-sm-6 widget-container-col" style="margin-top:2px;">
		<div class="widget-box collapsed" style="border:none;">
			<div class="widget-header" style="width:300px;top:7px">
				<h3 class="widget-title">评分查询</h3>
				<div class="widget-toolbar" style="left:-56px;background-color:#00b4c8">
					<a id="searchPanelId" data-action="collapse">
						<i class="ace-icon fa fa-chevron-up"><span style="color:#FFFAFA;">&nbsp;&nbsp;查询条件</span></i>
					</a>&nbsp;&nbsp;
					</div>
					
				<div class="widget-toolbar" style="left:194px;background-color:#00b4c8">	
					<a href="#" data-action="collapse" onclick="conClearReload()" >
						<i class="ace-icon fa fa-refresh"><span style="color:#FFFAFA;">&nbsp;&nbsp;清空条件</span></i>
					</a>&nbsp;&nbsp;
				</div> 
			</div>
			<div id="searchPanelBody" class="widget-body" style="position:relative;width:560px;z-index:100;top:5px;background-color:#D1F3F8;">
				<div class="widget-main" style="background-color:#D1EEEE;">
					<table class="searchPanelBody">
		           		<tr>
		            	    <td class="systemInfo">技能:</td><td class="operateInfo"><select id="searchSkillGroup" class="js-example-basic-hide-search" ></select></td>
		            	    <td class="systemInfo">业务:</td><td class="operateInfo"><select id="searchBusiness" class="js-example-basic-hide-search" ></select></td>
		            	</tr>
		        		<tr>
		            	    <td class="systemInfo">评分表:</td><td class="operateInfo"><select id="searchForm" class="js-example-basic-hide-search" ></select></td>
		            	    <td class="systemInfo">部门:</td><td class="operateInfo"><select id="searchOrganization" class="js-example-basic-hide-search" ></select></td>
		        		</tr>
		        		<tr>
		        			<td class="systemInfo">呼叫时间:</td><td class="systemInfo"><input type="text" id="searchStartDate" /></td>
		            		<td class="systemInfo">到</td><td class="systemInfo"><input type="text" id="searchEndDate" /></td>
		            	</tr>
		        		<tr>
		            		<td class="systemInfo">评分:</td><td class="systemInfo"><input type="text" id="searchLowScore" /></td>
		            		<td class="systemInfo">到</td><td class="systemInfo"><input type="text" id="searchHighScore" /></td>
		        		</tr>
		        		<tr>
		        			<td class="systemInfo">座席:</td><td class="systemInfo"><input type="text" id="searchUserName" /></td>
		            		<td class="systemInfo">流水号:</td><td class="systemInfo"><input type="text" id="searchFileNo" /></td>
		            	</tr>
		        		<tr>
		            		<td class="systemInfo">主叫号码:</td><td class="systemInfo"><input type="text" id="searchDnis" /></td>
		            		<td class="systemInfo">被叫号码:</td><td class="systemInfo"><input type="text" id="searchAni" /></td>
		            	</tr>
		        		<tr>
		            	    <td colspan="4"><a><button type="button" id="search" class="btn btn-info btn-sm" onClick="search()"><span class="ace-icon fa fa-search icon-on-right bigger-110"></span>&nbsp;查询</button></a></td>
		        		</tr>
		        	</table>
				</div>
			</div>
		</div>
	</div>
		<div id="nowPosition" style="position:absolute;right:5px;top:5px;"><span class="label label-xlg label-yellow arrowed-in">当前位置： 质检查询分析 - <font id="tabSelect">质检评分查询 </font></span></div>
	       <div id="tableDiv" style="width:100%;top:50px;position:absolute;height:100%">
	       <div class="row" style="height:100%;">
	      <div class="col-sm-6"  style="height:100%;width:100%;padding-top:10px;">
	    <div class="tab-content" style="top:0px;bottom:0px;height:100%;">
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
 <div class="modal fade" id="voicePlay" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
   <div class="modal-dialog" style="width:60%;margin:auto;">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
              	录音播放
            </h4>
         </div>
         <div class="modal-body">
		    <div data-options="region:'center', fit:false, border:true" title=""
		        style="overflow: hidden;padding: 3px;">
		        <div id="playerDiv" style="display:block; padding:0px; overflow: hidden;">
		            <div style="height:148px; width:100%; background:#000000; padding:0px;">
		                <object
		                    classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
		                    width="860px" height="148px" id="audioPlayer"
		                    align="middle">
		                    <param name="movie" value="${ctx }/js/voice/audioPlayer.swf" />
		                    <param name="quality" value="high" />
		                    <param name="bgcolor" value="#000000" />
		                    <param name="play" value="true" />
		                    <param name="loop" value="true" />
		                    <param name="wmode" value="window" />
		                    <param name="scale" value="showall" />
		                    <param name="allowScriptAccess" value="always" />
		                    <!--[if !IE]>-->
		                    <object type="application/x-shockwave-flash"
		                        data="${ctx }/js/voice/audioPlayer.swf"
		                        id="audioPlayer_no_ie" width="860px" height="148px">
		                        <param name="movie" value="AudioPlayer.swf" />
		                        <param name="quality" value="high" />
		                        <param name="bgcolor" value="#000000" />
		                        <param name="play" value="true" />
		                        <param name="loop" value="true" />
		                        <param name="wmode" value="window" />
		                        <param name="scale" value="showall" />
		                        <param name="allowScriptAccess"
		                            value="always" />
		                        <!--<![endif]-->
		                        <!--[if !IE]>-->
		                    </object>
		                    <!--<![endif]-->
		                </object>
		            </div>
		            <div class="lrcBlock" id="lrcContent" style="height:270px;overflow-y:scroll;"></div>
		        </div>
		    </div>
		    <div style="overflow-y:scroll;height:180px;">
		        <table id="dataGridDetail" class="tree table table-hover table-bordered table-condensed"></table>
		    </div>
		     <%--  <form id="qualityResultDetailForm" method="post">
		        <input id="id" name="id" type="hidden" value="${qualityResultForm.id}"/>
		        <label style="width:10px;" >评分</label>
		        <input id="auditScore" name="auditScore" type="text" style="width:80px" class="easyui-numberbox sap_input" placeholder="请输入数字" min="-100" max="100" precision="2" value="${qualityResultForm.auditScore}" ></input>
		        <label style="width:10px;">评语</label>
		        <input id="auditNote" name="auditNote" style="width:670px" class="easyui-validatebox sap_input" validType="length[0,64]" invalidMessage="不能超过64个字符！" value="${qualityResultForm.auditNote}"></input>
		       </form> --%>
         </div>

         <hr style="margin-bottom: 10px;"/>
	  	 <div align="right" style="padding-right: 10px;padding-bottom: 10px;">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
         </div>
      </div>
	</div>
</div>

<script type="text/javascript">
var nowDataTable=null;
$(function(){
	initTable();
	initData();
	//评分数据的每一行添加双击事件，该事件执行play()函数
	$("#dataTable #tbody").on("dblclick", "tr", function() {
		//console.log($($(this).children("td")[12]).children("a").attr("onclick"));
		var elements = $($($(this).children("td")[12]).children("a")[0]).attr("onclick");
		eval(elements);
	});
	$("#tableDiv").height($(".bg").height()-50);
	//$("#dataTable_wrapper .dataTables_scroll .dataTables_scrollBody").css("width", "102%");
	//var width = $("#dataTable_wrapper").attr("id");
	//alert(width);
});

function initData(){
	$('#dataTable tbody').on( 'click', 'tr', function () {
        $(this).toggleClass('selected');
    } );
}

//页面初始化
function initTable(){
	var nowDate = new Date();
	//时间查询条件框
	$('#searchStartDate').datetimepicker({
		format:"yyyy-mm-dd",
		minView:2,
		maxView:2,
		endDate:nowDate,
		language:"zh-CN",
		
	    autoclose: true,
	    todayBtn:true ,
	    todayHighlight: true
	});
	$('#searchEndDate').datetimepicker({
		format:"yyyy-mm-dd",
		minView:2,
		maxView:2,
		endDate:nowDate,
		language:"zh-CN",
		
	    autoclose: true,
	    todayBtn:true ,
	    todayHighlight: true
	});
	
	//下拉菜单框
	$.post("../skillGroup/getCombobox", {}, function(result) {
		$("#searchSkillGroup").select2({
			minimumResultsForSearch: -1,
			 data: result
		});
		$.post("../business/getCombobox", {}, function(result) {
			$("#searchBusiness").select2({
				minimumResultsForSearch: -1,
				 data: result
			});
			$.post("../form/getCombobox", {}, function(result) {
				$("#searchForm").select2({
					minimumResultsForSearch: -1,
					 data: result
				});
				//三个条件均加载后才加载数据
				getAllRecord();
			}, "json").error(function() { 
				$("#searchForm").select2({
					minimumResultsForSearch: -1
				});
					});
		}, "json").error(function() { 
			$("#searchBusiness").select2({
				minimumResultsForSearch: -1
			});
				});
	}, "json").error(function() { 
		$("#searchSkillGroup").select2({
			minimumResultsForSearch: -1
		});
			});
}

//搜索按钮事件
function search(){
	//查询按钮按下后隐藏条件面板
	$("#searchPanelId").click();
	//加载数据
	getAllRecord();
}

//组装查询条件
function addSearchInfo(aoData){
	aoData.push({"name":"beginDate","value":$.trim($("#searchStartDate").val())});
	aoData.push({"name":"endDate","value":$.trim($("#searchEndDate").val())});
	aoData.push({"name":"score","value":$.trim($("#searchLowScore").val())});
	aoData.push({"name":"score2","value":$.trim($("#searchHighScore").val())});
	aoData.push({"name":"userId","value":$.trim($("#searchUserName").val())});
	aoData.push({"name":"fileNo","value":$.trim($("#searchFileNo").val())});
	aoData.push({"name":"dnis","value":$.trim($("#searchDnis").val())});
	aoData.push({"name":"ani","value":$.trim($("#searchAni").val())});
	aoData.push({"name":"skillGroupId","value":$("#searchSkillGroup").select2("data")[0].id});
	aoData.push({"name":"businessId","value":$("#searchBusiness").select2("data")[0].id});
	//防止评分表下拉菜单为空时报错
	if (typeof($("#searchForm").select2("data")[0]) == "undefined") {
		aoData.push({"name":"formId","value":0});
	}
	else {
		aoData.push({"name":"formId","value":$("#searchForm").select2("data")[0].id});
	}
	aoData.push({"name":"searchMode","value":1});
	//aoData.push({"name":"organizationId","value":$("#searchOrganization").select2("data")[0].id});
}

//数据展示
function getAllRecord(){
	
	
	var pageNum=$("#dataTable_length").find("select").val();
	var aoColumns = [
	                      {  
		                        "mDataProp" : "index",  
		                        "sTitle" : "序号", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center",
		                        "sWidth":"70px"
		                    },
		                  {  
		                        "mDataProp" : "fileNo",  
		                        "sTitle" : "录音流水号", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center",
		                        "sWidth":"160px"  
		                    },
	                      {  
		                        "mDataProp" : "callTime",  
		                        "sTitle" : "呼叫时间",  
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center",
		                        "sWidth":"160px",
		                        "bSortable": true
		                    },
		                    {  
		                        "mDataProp" : "",  
		                        "sTitle" : "时长",  
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center",
		                        "sWidth":"70px",
		                        "render": function ( data, type, full, meta ) {
				                        	var val = full.duration/1000;
				                            minute = parseInt((val / 60).valueOf());
				                            second = parseInt((val % 60).valueOf());
				                            if( second < 10){ 
				                              return minute + ':0' + second;  
				                            }else{
				                              return minute + ':' + second;
				                            }
		                        }
		                    },
		                    {  
		                        "mDataProp" : "ani",  
		                        "sTitle" : "主叫号码",  
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center",
		                        "sWidth":"110px"  
		                    },
		                    {  
		                        "mDataProp" : "dnis",  
		                        "sTitle" : "被叫号码",  
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center",
		                        "sWidth":"110px"  
		                    },
		                    {  
		                        "mDataProp" : "userName",  
		                        "sTitle" : "座席",  
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center",
		                        "sWidth":"70px"  
		                    },
		                    {  
		                        "mDataProp" : "score",  
		                        "sTitle" : "评分",  
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center",
		                        "sWidth":"60px"  
		                    },
		                    {  
		                        "mDataProp" : "formName",  
		                        "sTitle" : "评分表",  
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center",
		                        "sWidth":"100px"  
		                    },
		                    {  
		                        "mDataProp" : "qualityTime",  
		                        "sTitle" : "评分时间",  
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center",
		                        "sWidth":"110px"  
		                    },
		                    {  
		                        "mDataProp" : "skillGroupName",  
		                        "sTitle" : "技能",  
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center",
		                        "sWidth":"100px"  
		                    },
		                    {  
		                        "mDataProp" : "businessName",  
		                        "sTitle" : "业务",  
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center",
		                        "sWidth":"100px"  
		                    },
	                      {  
		                        "mDataProp" : "",  
		                        "sTitle" : "播放", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",
		                        "sClass" : "center" ,
		                        "sWidth":"50px",
		                        "render": function ( data, type, full, meta ) {
				                        	  var button = "<a href=# onclick='play(" + full.id + "," + full.qualityResultFormId + ",\"" + full.callTime + "\",\"" + full.fileNo + "\")'>播放</a>";
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
	var tabContent = $(".tab-content").height()-93;
	nowDataTable = $('#dataTable').dataTable({
		
		"bAutoWidth": true,//for better responsiveness
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
	    "scrollX": "100%",
		"order": [[ 0, 'asc' ]],
		"sAjaxSource": "./dataGrid",//请求内容为退一步请求的内容
		"fnServerData": function ( sSource, aoData, fnCallback ) {
			addSearchInfo(aoData);
			 $.ajax({
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
		            /* var width = $("#dataTable_wrapper .dataTables_scroll .dataTables_scrollBody").css("width");
		            var showHeight = $("#dataTable_wrapper .dataTables_scroll .dataTables_scrollBody").css("height");
		            var dataHeight = $("#dataTable_wrapper .dataTables_scroll .dataTables_scrollBody #dataTable").css("height");
		            var newWidth = width + "px";
		            if (dataHeight > showHeight) {
		            	newWidth = (parseInt(width) + 17) + "px"
		            }
		            $("#dataTable_wrapper .dataTables_scroll .dataTables_scrollBody").css("width", newWidth); */
		        }    
			 });
		 },
		 "aoColumns":aoColumns
	});
	
}

//查询条件清空按钮的点击事件
function conClearReload() {
	//清空查询条件
	dataClear();
	//重新加载数据
	getAllRecord();
}

//清除编辑modal中的所有值
function dataClear() {
	$("#searchStartDate").val("");
	$("#searchEndDate").val("");
	$("#searchLowScore").val("");
	$("#searchHighScore").val("");
	$("#searchUserName").val("");
	$("#searchFileNo").val("");
	$("#searchDnis").val("");
	$("#searchAni").val("");
	$("#searchSkillGroup").select2("val",0);
	$("#searchBusiness").select2("val",0);
	$("#searchForm").select2("val",0);
	//$("#searchOrganization").select2("val",0);
}

//录音按钮事件播放
function play(id, qualityReusltFormId, callTime, fileNo) {
	$("#lrcContent").html("");
	$("#dataGridDetail").html("");
	$("#voicePlay").modal("show");
		
	//拉取对应录音文件及trans文件等
	openPlayer(fileNo, callTime);
	//setTimeout(function(){openPlayer(fileNo, callTime);},500);
	$.post("./treeGrid", {"qualityResultFormId":qualityReusltFormId}, function(result) {
		//获取该条录音评分详细情况
		var table = createTreeGrid(result);
		$("#dataGridDetail").html(table);
	}, "json");
	    
}

</script>
</body>
</html>