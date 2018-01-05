<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!---登入表单的布局 --->
<html>
	<head>
        <title>工单质检</title>
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
			.infoHead {
				line-height:2em;
	    		color: #657ba0;
	    		font-weight: bold;
	    	}
	    	.infoBody {
	    		line-height:2em;
	    		font-weight: bold;
	    		float: left;
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
		<script type="text/javascript" src="${ctx }/js/respond.min.js"></script>
		<script src="${ctx }/js/ace/ace/elements.treeview.js"></script>
	    <script type="text/javascript" src="${ctx }/js/md5.js"></script>
		<script src="${ctx }/js/windowResize.js"></script>
		<c:if test="${fn:contains(sessionInfo.privilegeList, '/voice/searchPlay')}">
	    	<script type="text/javascript">
				$.canPlay = true;
			</script>
		</c:if>
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
<body style="height:100%;weight:100%;margin:0px;padding:0px;background:#F7F7F7" >

<div style="position:absolute;top:0px;bottom:0px;left:0px;right:0px;height:100%;width:100%; padding:20px;" >
		<!-- <div id="nowPosition" style="position:absolute;right:5px;top:15px;">
			<span class="label label-xlg label-yellow arrowed-in">
				当前位置：  工单质检
			</span>
		</div> -->
		<div  style="top:5px;position: absolute;">
			<table style="font-size:15px;border-collapse:separate; border-spacing:5px;">
         <tr>
             <td>呼叫时间:&nbsp;&nbsp;</td>
             <td ><input id="startTime" name="startTime" class="input" type="text" style="background-color:#ECEEED"/></td>
             <td>到</td>
             <td><input id="endTime" name="endTime" class="input" type="text" style="background-color:#ECEEED"/></td>
             <td>质检状态:&nbsp;&nbsp;</td>
             <td><select id="dateType" onchange="search()" style="background-color:#ECEEED"><option value="1">未质检</option><option value="2">已质检</option><option value="3">全部</option></select></td>
             <td>&nbsp;&nbsp;&nbsp;<a><button  type="button" id="searchButton" class="btn btn-info btn-sm" onClick="search()"><span class="ace-icon fa fa-search icon-on-right bigger-110"></span>&nbsp;查询</button></a></td><td></td>
         </tr>
     </table>
     </div>
		 <div style="width:98%;top:45px;padding-bottom:17px;position:absolute;height:97%;right:12px;left:12px">
	       <div class="row" style="height:100%;bottom:17px;width:100%;margin-left:2px">
		       <div class="col-sm-9 side"  style="height:100%;width:100%;padding-top:0px;">
					<div class="tab-content" style="top:10px;bottom:0px;position:absolute;width:100%;left:0px">
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
	
<!-- 质检结果Modal -->
<div class="modal fade" id="viewResult" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
   <div class="modal-dialog" style="width:900px;height:auto;">
      <div class="modal-content" style="width:900px;height:auto;">
         <div class="modal-header" style="padding: 5px;">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="modalLabelPlay">
              	质检结果查看
            </h4>
         </div>
		<div class="table-header" style="background:#5CACDF">工单信息</div>
		<div class="profile-user-info profile-user-info-striped">
			<div class="profile-info-row">
				<div class="profile-info-name"> 录音流水号： </div>
		
				<div class="profile-info-value">
					<span class="editable editable-click" id="uuid"></span>
				</div>
			</div>
		
			<div class="profile-info-row">
				<div class="profile-info-name"> 主叫号码： </div>
		
				<div class="profile-info-value">
					<span class="editable editable-click" id="ani"></span>
				</div>
			</div>
		
			<div class="profile-info-row">
				<div class="profile-info-name"> 被叫号码： </div>
		
				<div class="profile-info-value">
					<span class="editable editable-click" id="dnis">38</span>
				</div>
			</div>
		
			<div class="profile-info-row">
				<div class="profile-info-name"> 通话总时长： </div>
		
				<div class="profile-info-value">
					<span class="editable editable-click" id="duration"></span>
				</div>
			</div>
		
			<div class="profile-info-row">
				<div class="profile-info-name"> 静音总时长： </div>
		
				<div class="profile-info-value">
					<span class="editable editable-click" id="silenceDuration"></span>
				</div>
			</div>
		
			<div class="profile-info-row">
				<div class="profile-info-name"> 呼叫时间： </div>
		
				<div class="profile-info-value">
					<span class="editable editable-click" id="callTime"></span>
				</div>
			</div>
		</div>
		<div class="table-header" style="background:#5CACDF">质检信息</div>
		<div class="profile-user-info profile-user-info-striped">
			<div class="profile-info-row">
				<div class="profile-info-name"> 工单得分： </div>
		
				<div class="profile-info-value">
					<span class="editable editable-click" id="score"></span>
				</div>
			</div>
		
			<div class="profile-info-row">
				<div class="profile-info-name"> 严重差个数： </div>
		
				<div class="profile-info-value">
					<span class="editable editable-click" id="seriousNum"></span>
				</div>
			</div>
		
			<div class="profile-info-row">
				<div class="profile-info-name"> 一般差个数： </div>
		
				<div class="profile-info-value">
					<span class="editable editable-click" id="generalNum">38</span>
				</div>
			</div>
		
			<div class="profile-info-row">
				<div class="profile-info-name"> 质检结果： </div>
		
				<div class="profile-info-value">
					<span class="editable editable-click" id="content"></span>
				</div>
			</div>
		
			<div class="profile-info-row">
				<div class="profile-info-name"> 质检人员： </div>
		
				<div class="profile-info-value">
					<span class="editable editable-click" id="inspectorName"></span>
				</div>
			</div>
		</div>
      </div>
	</div>
</div>

<script type="text/javascript">
var nowDataTable=null;
var aaData = null;
$(function(){
	initData();
	setTimeout("search()",100);
	$(".tab-content").css("left","4px");
	//$(".tab-content").css("padding-right","6px");
	$("table").each(function(){
		$(this).css("width","100%");
	});

});

function initData(){
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
        $(this).toggleClass('selected');
    } );
}

function search(){
 	//检查时间
    var startTime=$("#startTime").val();
    var start=new Date(startTime.replace("-", "/").replace("-", "/"));
    var endTime=$("#endTime").val();
    var end=new Date(endTime.replace("-", "/").replace("-", "/"));
    if(end<start){
    Modal_Alert('操作日志','开始时间不能大于等于结束时间！');
    return false;
    }
	getAllRecord();
}	

//默认时间
function getLastDate(lastDay){
     lastDay.setMonth(lastDay.getMonth()-1);
	 return lastDay;
}

function fillSearchInfo(aoData){
	aoData.push({"name":"startTime","value":$("#startTime").val()});
	aoData.push({"name":"endTime","value":$("#endTime").val()});
	aoData.push({"name":"status","value":$("#dateType").find("option:selected").text()});
	return 1;
}

function getAllRecord(){
	var pageNum=$("#dataTable_length").find("select").val();
	var aoColumns = [
	                      {  
		                        "mDataProp" : "index",  
		                        "sTitle" : "序号", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sWidth": "40px",
		                        "sClass" : "center"  
		                    },
	                      {  
		                        "mDataProp" : "uuid",  
		                        "sTitle" : "录音流水号", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sWidth": "130px",
		                        "sClass" : "center"  
		                    },
	                      {  
		                        "mDataProp" : "ani",  
		                        "sTitle" : "主叫号码", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sWidth": "100px",
		                        "sClass" : "center"  
		                    },
	                      {  
		                        "mDataProp" : "dnis",  
		                        "sTitle" : "被叫号码", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sWidth": "100px",
		                        "sClass" : "center"  
		                    },
		                    {  
		                        "mDataProp" : "durationStr",  
		                        "sTitle" : "通话总时长",  
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sWidth": "100px",
		                        "sClass" : "center"
		                    },
	                      {  
		                        "mDataProp" : "silenceDurationStr",  
		                        "sTitle" : "静音总时长", 
		                        "bVisible": true,
		                        "sDefaultContent" : "0",  
		                        "sWidth": "90px",
		                        "sClass" : "center"
		                    },{  
		                        "mDataProp" : "callTime",  
		                        "sTitle" : "呼叫时间", 
		                        "bVisible": true,
		                        "sWidth": "140px",
		                        "sDefaultContent" : "",  
		                        "sClass" : "center"  
		                    },
		                    {  
		                        "mDataProp" : "inspectionStatus",  
		                        "sTitle" : "质检状态", 
		                        "bVisible": true,
		                        "sWidth": "140px",
		                        "sDefaultContent" : "",  
		                        "sClass" : "center"  
		                    },
	                      {  
		                        "mDataProp" : "silenceDurationStr",  
		                        "sTitle" : "操作", 
		                        "bVisible": true,
		                        "sWidth": "90px",
		                        "sClass" : "center",
		                        "render": function ( data, type, full, meta ) {
		                        	  var button = ""; 
		                        	  if("未质检"==full.inspectionStatus){
		                        		  button = "<a href=# onclick='indpection(\"" + full.uuid + "\")'><b>开始质检</b></a>";
		                        	  }else{
		                        		  button = "<a href=# onclick='viewResult(\"" + full.uuid + "\")'><b>查看结果</b></a>";
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
		 "showRowNumber":true,
         "bPaginate" : true,// 分页按钮
		 "bLengthChange" : true,// 每行显示记录数
		 "bSort" : false,// 排序
		 "bInfo":true,
		 "iDisplayLength": pageNum,
		 "sPaginationType": "full_numbers", //显示首页和尾页
	     "scrollY": tabContent,
		 "order": [[ 0, 'asc' ]],
		 "sAjaxSource": "../inspection/dataGrid",
		 "fnServerData": function ( sSource, aoData, fnCallback ) {
			 if(fillSearchInfo(aoData)==null){
				 return;
			 }
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
				 	aaData = resp.aaData;
		            fnCallback(resp);  
		        }    
			 } );
		 },
		 "aoColumns":aoColumns,
		 "fnDrawCallback": function(settings) {
			}
	});
	 $("#dataTable_paginate").css("margin-right","-8px");	
}

//开始质检
function indpection(obj){
	location.href = "./inspectionPage?id="+obj;
}

//查看质检结果
function viewResult(id) {
	$("#viewResult").modal("show");
	$.post('../inspection/getInfoById',{id:id},function(data){
		if(data.success==true){
			$('#uuid').html(data.obj.UUID);
			$('#ani').html(data.obj.relateData.ani);
			$('#dnis').html(data.obj.relateData.dnis);
			$('#duration').html(data.obj.transData.duration);
			$('#silenceDuration').html(data.obj.transData.silenceDuration);
			$('#callTime').html(data.obj.relateData.callTime);
			$('#score').html(data.obj.manualData.inspectResult.score);
			$('#generalNum').html(data.obj.manualData.inspectResult.generalNum);
			$('#seriousNum').html(data.obj.manualData.inspectResult.seriousNum);
			$('#inspectorName').html(data.obj.manualData.inspectorName);
			var content = data.obj.manualData.inspectResult.content;
			if(""==content){
				$('#content').html("");
			}else{
				var array = content.split('|');
				var contentStr = "";
				for(var i = 0;i<array.length;i++){
					contentStr += i+1+'、'+array[i]+'<br/>'
				}
				$('#content').html(contentStr);
			}
			
		}
	},"json").error(function(e) {
		Modal_Alert('工单质检','加载信息失败');
	});
}

</script>
</body>
</html>