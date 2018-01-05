<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!---登入表单的布局 --->
<html>
	<head>
        <title>成功单数据导出</title>
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
		
		#searchTable tr{
    		display: block;
   			 margin-bottom: 6px;
   			 min-width: 1000px;
		}
		
		#searchTable tr td{
    		width: 250px;
		}
		
		#dataTable td{
            word-wrap: break-word;
			word-break:break-all;
        }
         .mask {       
            position: absolute; top: 0px; filter: alpha(opacity=60); background-color: #777;     
            z-index: 1002; left: 0px;     
            opacity:0.5; -moz-opacity:0.5;     
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
	<div style="position:absolute;top:0px;bottom:0px;left:0px;right:0px;height:100%;overflow:hidden;padding:10px;" >
		<div id="cesi" style="position:absolute;width:100%;left:10px;">
			<table id="searchTable">
				<tr>
					<td align="right">
						工单号：&nbsp;
						<input id="orderIdInput" style="height: 25px" type="text"/>
					</td>
					<td  align="right">
						&nbsp;录音流水号：&nbsp;
						<input  id="voiceIdInput" style="height: 25px" type="text"/>
					</td>
					<td align="right" style="width:122px;">
						&nbsp; 平台编号：&nbsp;
					</td>
					<td align="left" style="width:125px;">
						<select id="platFormSelect" style="width:125px;height: 25px" class="select">
							<option value="">全部</option>
						</select>
					</td>
					<td align="left" style="width:150px;">
						<a style="margin-left: 20px">
							<button type="button" class="btn btn-info btn-sm" style="z-index:1;" onClick="downloadtText()" >
								<span class="ace-icon fa fa-download icon-on-right bigger-110"></span>&nbsp;导出工单文本
							</button>
						</a>
					</td>
					<td>
						<a style="margin-left: 20px">
							<button type="button" class="btn btn-info btn-sm" style="z-index:1;" onClick="downTranceText()" >
								<span class="ace-icon fa fa-download icon-on-right bigger-110"></span>&nbsp;导出转译文本
							</button>
						</a>
					</td>
				</tr>
				<tr>
					<td align="right">
						开始时间：&nbsp;
						<input id="startTime" type="text" readonly style="height: 25px;"/>
					</td>
					<td align="right">
						&nbsp; 结束时间：&nbsp;
						<input id="endTime" type="text" readonly style="height: 25px;"/>
					</td>
					<td align="right " style="width:122px;">
						 &nbsp;&nbsp;质检点所属规则集：&nbsp;
					</td>
					<td style="width:125px;">
						<select id="qualityDataSelect" style=" width:125px;" class="select">
							<option value="">全部</option>
						</select>
					</td>
					<td>
						<a style="margin-left: 20px">
							<button type="button" class="btn btn-info btn-sm" style="z-index:1;" onClick="downloadData()">
								<span class="ace-icon fa fa-download icon-on-right bigger-110"></span>&nbsp;导出工单数据
							</button>
						</a>
					</td>
				</tr>
				<tr>
					<td  align="right">
						质检点名称：&nbsp;
						<input id="qualityNameInput" style="height: 25px"  type="text"/>
					</td>
					<td colspan="4" align="right" style="width: 585px;">
						<a style="margin-left: 20px">
							<button type="button" id="search" class="btn btn-info btn-sm" style="z-index:1;"
							onClick="getAllRecord()">
								<span class="ace-icon fa fa-search icon-on-right bigger-110"></span>&nbsp;查询
							</button>
						</a>
					</td>
				</tr>
			</table>
		</div>
	    <div style="width:100%;top:100px;bottom:0px;position:absolute;height:90%;">
	    	<div class="row" style="height:100%;">
		    	<div class="col-sm-6 side"  style="height:100%;width:100%;padding-top:0px;padding-right: 10px;" >
					<div class="tab-content" style="top:32px;bottom:0px;position:absolute;width:98%">
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
	<!-- 文本弹出框 -->
 	<div class="modal fade" id="textModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   		<div class="modal-dialog">
      		<div class="modal-content" style="width:660px;height:500px;">
         		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  		&times;
            		</button>
            		<h4 class="modal-title" id="myModalLabel" style="margin-top:0;font-size:22px;letter-spacing: 1.5px;width:200px">
              			语音文本
            		</h4>
         		</div>
         		<div class="modal-body" id="modal-body" style="height:348px; overflow:scroll;margin: 20px 20px 20px 20px; " >
        			
         		</div>
       			<hr style="color:#d0d0d0;margin-bottom:0px"/>
            	<div align="right" style="padding-right:42px; padding-bottom:22px;position: absolute;right: 0px;bottom: 0px;">
		            <button type="reset" class="btn btn-sm" data-dismiss="modal" ><i class="ace-icon fa fa-undo bigger-110" ></i>取消</button>
		        </div>
      		</div>
      	</div>
	</div>

</body>
<script type="text/javascript">
var orderId = $("#orderIdInput");
var voiceId = $("#voiceIdInput");
var qualityName = $("#qualityNameInput");
var qualityData = $("#qualityDataSelect option:selected");
var platForm = $("#platFormSelect");
var endTime = $("#endTime");
var startTime = $("#startTime");
$(function(){
	/* initData(); */
	initDate();
	getAllRecord();
	$.post("${ctx }/autoRule/getAutoRules",{},function(result) {
		setAutoRulesInfo(result.obj, "qualityDataSelect");
		$(".dataTables_scrollBody").css("overflow-x","auto");
		$(".dataTables_scrollHeadInner").find("table").css("width","100%");
		 $(".dataTables_scrollBody").find("table").css("width","100%");
	},"json").error(function(e) {
		Modal_Alert('自动质检规则集管理','加载数据失败');
	});
	
	/* 获取平台*/
	$.post("${ctx }/record/getPlaytForms",{},function(result) {
		setAutoRulesInfo(result.obj, "platFormSelect");
		$(".dataTables_scrollBody").css("overflow-x","auto");
		$(".dataTables_scrollHeadInner").find("table").css("width","100%");
		 $(".dataTables_scrollBody").find("table").css("width","100%");
	},"json").error(function(e) {
		Modal_Alert('平台编号','加载数据失败');
	});
	
});

	function downloadData(){
		var url = "${ctx}/success/downloadNew";
		var data = {"orderId":orderId.val(),"voiceId":voiceId.val(),"qualityName":qualityName.val(),
				"qualityData":qualityData.text(),"platForm":platForm.val(),"endTime":endTime.val(),"startTime":startTime.val()};
		post(url,data);
		/* var qualityDA = qualityData.text();
		if(qualityData.text() == "全部"){
			qualityDA = "";
		}
		url += "?orderId="+orderId.val()+"&voiceId="+voiceId.val()+"&qualityName="+qualityName.val()+"&qualityData="+qualityDA
			+"&platForm="+platForm.val()+"&endTime="+endTime.val()+"&startTime="+startTime.val();
		location.href=url; */
	}
	function downloadtText(){
		var url = "${ctx}/success/downloadText";
		var data = {"orderId":orderId.val(),"voiceId":voiceId.val(),"qualityName":qualityName.val(),
				"qualityData":qualityData.text(),"platForm":platForm.val(),"endTime":endTime.val(),"startTime":startTime.val()};
		post(url,data);
		Modal_Alert('导出工单文本','正在下载...请稍后');
	}
	function downTranceText(){
		var url = "${ctx}/success/downTranceText";
		var data = {"orderId":orderId.val(),"voiceId":voiceId.val(),"qualityName":qualityName.val(),
				"qualityData":qualityData.text(),"platForm":platForm.val(),"endTime":endTime.val(),"startTime":startTime.val()};
		post(url,data);
		Modal_Alert('导出工单文本','正在下载...请稍后');
	}
var nowDataTable = null;
//VOICE_ID,ORDER_ID,PLAT_FORM,USER_PHONE,CALL_LENGTH,CALL_COENGTENT,QUALITY_NAME,QUALITY_DETAIL,QUALITY_DATA,CALL_START_TIME,CALL_END_TIME,CREATE_TIME
var aoColumns = [
					{
				    	"mDataProp" : "index",  "sTitle" : "序号", "bVisible": true,"sDefaultContent" : "","sWidth": "50px","sClass" : "center"
					},
                 {
                     "mDataProp" : "orderId",   "sTitle" : "工单号", "sWidth": "150px","bVisible": true,"sDefaultContent" : "",  "sClass" : "center"
                 },
					{
                     "mDataProp" : "voiceId",  "sTitle" : "录音流水号","sWidth": "400px","bVisible": true,"sDefaultContent" : "",  "sClass" : "center"
                 },
	               	{
	                   "mDataProp" : "platForm",  "sTitle" : "平台编号","sWidth": "100px","bVisible": true,"sDefaultContent" : "",  "sClass" : "center"
	               	},
	               	{
                    "mDataProp" : "callLength","sTitle" : "通话时长","bVisible": true,"sDefaultContent" : "","sWidth": "100px","sClass" : "center"
                 },
                {
                   "mDataProp" : "qualityName","sTitle" : "质检点名称","sWidth": "200px","bVisible": true, "sDefaultContent" : "",  "sClass" : "center"
                },
                 {
                   "mDataProp" : "qualityDetail",   "sTitle" : "检出明细","sWidth": "200px","bVisible": true, "sDefaultContent" : "",  "sClass" : "center"
                },
                {
                    "mDataProp" : "receiveTime",   "sTitle" : "接收时间","sWidth": "150px","bVisible": true, "sDefaultContent" : "",  "sClass" : "center"
                 },
                {
                   "mDataProp" : "createTime","sTitle" : "上报时间","sWidth": "150px","bVisible": true,"sDefaultContent" : "", "sClass" : "center"
                },
                {
                    "mDataProp" : "inspectionTime","sTitle" : "质检用时","sWidth": "150px","bVisible": true,"sDefaultContent" : "", "sClass" : "center"
                 }, 
                {
                    "mDataProp" : "orderId","sTitle" : "操作","sWidth": "100px","bVisible": true,"sDefaultContent" : "", "sClass" : "center",
                    "render": function ( data, type, full, meta ) {
                        return '<a  onclick=\"viewContent('+"'"+data+"'"+')\">查文本</a>';
                    }
                }
              ];

    function viewContent(content){
    	$.post(
    		"${ctx}/success/getContent",
    		{"orderId":content},
    		function(data){
    			var show = "";
    			for(var i=0;i<data.length;i++){
    				show += "录音流水号："+data[i].voiceId+"<br/>"+data[i].callContent+"<hr/>";
    			}
    			$("#modal-body").html(show);
    			$("#textModal").modal("show");
    		},
    		"json"
    	);
    }
    //显示遮罩层
    function showMask(){     
        $("#mask").css("height",$(document).height());     
        $("#mask").css("width",$(document).width());     
        $("#mask").show();     
    } 

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
		 aoData.push({"name": "orderId", "value": $("#orderIdInput").val()});
		 aoData.push({"name": "voiceId", "value": $("#voiceIdInput").val()});
		 aoData.push({"name": "qualityName", "value": $("#qualityNameInput").val()});
		 aoData.push({"name": "qualityData", "value": $("#qualityDataSelect option:selected").text()});
		 aoData.push({"name": "platForm", "value": $("#platFormSelect").val()});
		 aoData.push({"name": "startTime", "value": $("#startTime").val()});
		 aoData.push({"name": "endTime", "value": $("#endTime").val()});
	}

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

	var tabContent = $(".tab-content").height() -110;
	nowDataTable = $('#dataTable').dataTable({
		"bAutoWidth": false,	//for better responsiveness
		"bProcessing": false,
		"bServerSide": true,
		"showRowNumber":false,
	    "bPaginate" : true,// 分页按钮
		"bLengthChange" : true,// 每行显示记录数
		"bSort" : false,// 排序
		"bInfo":true,
		"bStateSave":false, //是否开启cookies保存当前状态信息
		"iDisplayLength": pageNum,
		"sPaginationType": "full_numbers", //显示首页和尾页
	    "scrollY": tabContent,
	    "scrollX": $(".tab-content").width(),
		"order": [[ 0, 'asc' ]],
		"sAjaxSource": "${ctx }/success/dataGrid",//请求内容为退一步请求的内容
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
	/* $('#minLength').datetimepicker({
		pickDate: false,
		language:"zh-CN",
		editable:false,
		autoclose: true
	}); */
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
	//lastDay.setMonth(lastDay.getMonth()-1);
	
	lastDay.setHours(0);
	lastDay.setMinutes(0);
	lastDay.setSeconds(0);
	lastDay.setMilliseconds(0);
	
	return lastDay;
}

/** -- 填充页面规则集类型信息 -- */
function setAutoRulesInfo(autoRulesList, prefix) {
	$("#"+prefix).select2({
		minimumResultsForSearch: -1,
		data:autoRulesList
	});
}
//发送post请求
function post(URL, PARAMS) {        
    var temp = document.createElement("form");        
    temp.action = URL;        
    temp.method = "post";        
    temp.style.display = "none";        
    for (var x in PARAMS) {        
        var opt = document.createElement("textarea");        
        opt.name = x;        
        opt.value = PARAMS[x];        
        // alert(opt.name)        
        temp.appendChild(opt);        
    }        
    document.body.appendChild(temp);        
    temp.submit();        
    return temp;        
} 
</script>
</html>