<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!---登入表单的布局 --->
<html>
	<head>
        <title>录音查询</title>
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
			.searchCondtion tr{
				 line-height:22px;
			}
			.searchCondtion td{
				padding:10px;
				text-align:center;
				width:180px;
				font-size:16px;
				/* color:#848484"; */	
				color:#666;	
			}
			.searchCondtion .input{
				height:30px
			}
			.searchCondtion .select{
				width:160px;
				padding:2px;
				border-radius:3px;
			}
			#dataTable td,#dataTable th{
				white-space:nowrap;
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

		<c:if test="${fn:contains(sessionInfo.privilegeList, '/voice/searchPlay')}">
	    	<script type="text/javascript">
				$.canPlay = true;
			</script>
		</c:if>

</head>

<body style="height:100%;weight:100%;" >
<img class="bg" src="../img/background.png" />
<div style="position:absolute;top:0px;bottom:0px;left:0px;right:0px;height:100%;
padding:20px;" >
<div>
	<div id="cesi" style="position: absolute;width:100%;margin-top:-10px">
		<table>
           	<tr>
           	    <td>&nbsp;<a>请输入关键词:&nbsp;&nbsp;</a></td>
           	    <td><input id="searchKeyword" name="searchKeyword" type="text"
	                class="sap_input" style="width:150px;height:30px;" placeholder="例如输入: 短信  流量" />
           		<td>&nbsp;&nbsp;&nbsp;<a><button type="button" id="searchButton" class="btn btn-info btn-sm" onClick="search()"><span class="ace-icon fa fa-search icon-on-right bigger-110"></span>&nbsp;查询</button></a></td><td></td>
           		<td>&nbsp;&nbsp;&nbsp;<a><button type="button" id="clearButton" class="btn btn-info btn-sm" onClick="clearSearch()"><span class="fa icon-on-right bigger-110"></span>&nbsp;清空</button></a></td><td></td>
           		<td>&nbsp;&nbsp;&nbsp;<a><button type="button" id="advanceSearchButton" class="btn btn-info btn-sm" onClick="searchAdvanceForm()"><span class="ace-icon fa fa-search icon-on-right bigger-110"></span>&nbsp;高级查询</button></a></td><td></td>
       		</tr><!-- button button-primary button-pill button-small -->
       	</table>
	</div>
	<div id="nowPosition" style="position:absolute;right:5px;top:5px;"><span class="label label-xlg label-yellow arrowed-in">当前位置： 质检查询分析 - <font  id="tabSelect">质检录音查询 </font></span></div>
	<div class="tab-content" style="width:99%;top:54px;bottom:0px;right:10px;position:absolute;">
  		<table id="dataTable" class="table table-striped table-bordered table-hover">
		   <thead id="thead">
		   </thead> 
		   <tbody id="tbody">
		   </tbody> 
		</table>
		</div>
	</div>
 </div>
 
  <!-- 高级查询modal -->
 <div class="modal fade" id="advanceModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content" style="width:620px;">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel" style="text-align:center;margin-top:0;font-size:22px;color:#429af1;letter-spacing: 1.5px;width:100px">
              	高级查询
            </h4>
         </div>
         <div class="modal-body" id="modal-body" align="center" >
         <br/>
        <table id="searchCondtion" class="searchCondtion">
                <tr>
                  <td>呼叫时间:&nbsp;&nbsp;</td>
                  <td><input id="callTime" name="callTime" class="input" type="text"/></td>
                  <td>到</td>
                  <td><input id="callTime2" name="callTime2" class="input" type="text"/></td>
                </tr>
                
                <tr>
                  <td>流水号:</td>
                  <td><input id="fileNo" name="fileNo" class="input" type="text"/></td>
                  <td>座席:</td>
                  <td><input id="userName" name="userName" class="input" type="text"/></td>
                </tr>
                <tr>
                  <td>主叫号码:</td>
                  <td><input id="ani" name="ani" class="input" type="text"/></td>
                  <td>被叫号码:</td>
                  <td><input id="dnis" name="dnis" class="input" type="text"/></td>
                </tr>
                
                <tr>
                  <td style="width: 202px">座席所在部门:</td>
                  <td><select id="organizationId" name="organizationId" class="select"></select></td>
                  <td>技能:</td>
                  <td><select id="skillGroupId" name="skillGroupId" class="select"></select></td>
                </tr>
                <tr>
                  <td>业务:</td>
                  <td><select id="businessId" name="businessId" class="select"></select></td>
                </tr>
            </table>
            <br/>
         	</div>
       <hr style="color:#d0d0d0;margin:0"/>
       		<br/>
            <div align="right" style="padding-right: 10px;padding-bottom: 15px;">
            <button id="searchButton" onclick="advanceSearch()" type="button" class="btn btn-info btn-sm" style="width:75px;height:30px;margin-right:15px"><i class="ace-icon fa fa-check bigger-110"></i>查询</button> 
            <button type="reset" class="btn btn-sm" data-dismiss="modal" style="width:75px;height:30px;margin-right:25px"><i class="ace-icon fa fa-undo bigger-110" ></i>取消</button>
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

	initData();
	setTimeout("search()",100);
});

function initData(){
	$('#dataTable tbody').on( 'click', 'tr', function () {
        $(this).toggleClass('selected');
    } );
}

//初始化时间控件
function initDate(){
	var nowDate = new Date();
	$('#callTime').datetimepicker({
		format:"yyyy-mm-dd",
		minView:2,
		maxView:2,
		endDate:nowDate,
		language:"zh-CN",
		
	   autoclose: true,
	   todayBtn:true ,
	   todayHighlight: true
	});
	$('#callTime2').datetimepicker({
		format:"yyyy-mm-dd",
		minView:2,
		maxView:2,
		endDate:nowDate,
		language:"zh-CN",
		
	   autoclose: true,
	   todayBtn:true ,
	   todayHighlight: true
	});
}

/**
 * 添加搜索条件
 */
/* function addSearchInfo(aoData){
	aoData.push({"name":"callTime","value":$.trim($("#callTime").val())});
	aoData.push({"name":"callTime2","value":$.trim($("#callTime2").val())});
	aoData.push({"name":"fileNo","value":$.trim($("#fileNo").val())});
	aoData.push({"name":"userName","value":$.trim($("#userName").val())});
	aoData.push({"name":"ani","value":$.trim($("#ani").val())});
	aoData.push({"name":"dnis","value":$.trim($("#dnis").val())});
	aoData.push({"name":"organizationId","value":$.trim($("#organizationId").val())});
	aoData.push({"name":"skillGroupId","value":$.trim($("#skillGroupId").val())});
	aoData.push({"name":"businessId","value":$.trim($("#businessId").val())});
} */

function search(){
	getAllRecord();
}	

function searchAdvanceForm(){
	$("#advanceModal").modal("show");
	initDate();
}	

function advanceSearch(){
	getAllRecord();
}

function clearSearch(){
	$("#searchKeyword").val("");
}	

function addSearchInfo(aoData){
	aoData.push({"name":"searchKeyword","value":$("#searchKeyword").val()});
}

function getAllRecord(){
	var pageNum=$("#dataTable_length").find("select").val();
	var aoColumns = [
	                      {  
		                        "mDataProp" : "index",  
		                        "sTitle" : "序号", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sWidth": "70px",
		                        "sClass" : "center"  
		                    },
	                      {  
		                        "mDataProp" : "fileNo",  
		                        "sTitle" : "录音流水号", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sWidth": "140px",
		                        "sClass" : "center"  
		                    },
		                  {  
		                        "mDataProp" : "callTime",  
		                        "sTitle" : "呼叫时间", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sWidth": "140px",
		                        "sClass" : "center"  
		                    },
	                      {  
		                        "mDataProp" : "duration",  
		                        "sTitle" : "时长",  
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sWidth": "120px",
		                        "sClass" : "center"  
		                    },
	                      {  
		                        "mDataProp" : "ani",  
		                        "sTitle" : "主叫号码", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sWidth": "120px",
		                        "sClass" : "center"  
		                    },
	                      {  
		                        "mDataProp" : "dnis",  
		                        "sTitle" : "被叫号码", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sWidth": "120px",
		                        "sClass" : "center"  
		                    },
	                      {  
		                        "mDataProp" : "userLoginName",  
		                        "sTitle" : "坐席工号", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sWidth": "120px",
		                        "sClass" : "center"  
		                    },
	                      {  
		                        "mDataProp" : "userName",  
		                        "sTitle" : "坐席姓名", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sWidth": "120px",
		                        "sClass" : "center"  
		                    },
	                      {  
		                        "mDataProp" : "skillGroupName",  
		                        "sTitle" : "技能", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sWidth": "100px",
		                        "sClass" : "center"  
		                    },
	                      {  
		                        "mDataProp" : "businessName",  
		                        "sTitle" : "业务", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sWidth": "140px",
		                        "sClass" : "center"  
		                    },
	                      {  
		                        "mDataProp" : "analyseStartTime",  
		                        "sTitle" : "转写时间", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sWidth": "120px",
		                        "sClass" : "center"  
		                    },
	                      {  
		                        "mDataProp" : "silenceDuration",  
		                        "sTitle" : "总静音时长", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sWidth": "120px",
		                        "sClass" : "center"  
		                    },
	                      {  
		                        "mDataProp" : "searchKeyword",  
		                        "sTitle" : "关键词", 
		                        "bVisible": false,
		                        "sDefaultContent" : "", 
		                        "sWidth": "120px",
		                        "sClass" : "center",
		                    },
	                      {  
		                        "mDataProp" : "action",  
		                        "sTitle" : "播放", 
		                        "bVisible": true,
		                        "sWidth": "120px",
		                        "sDefaultContent" : "",  
		                        "sClass" : "center"  ,
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
		 "bStateSave":false, //是否开启cookies保存当前状态信息
		 "iDisplayLength": pageNum,
	     "scrollY": tabContent,
	     "scrollX": "2000px",
		 "order": [[ 0, 'asc' ]],
		 "sAjaxSource": "./dataGrid",
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
		            /* var width = $("#dataTable").css("width");
		            $(".dataTables_scrollHead .dataTables_scrollBody").css("width", width); */
		        }    
			 } );
		 },
		 "aoColumns":aoColumns
	});
	
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



