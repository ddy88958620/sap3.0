<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

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
			em{
			   background-color: yellow;
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
			.ruleTh {
	    		text-align:center; 
	    		border:2px solid #dddddd; 
	    		color:#ffffff; 
	    		background-color:#00b4c8; 
	    		vertical-align: middle;
	    		font-weight: bold;
	    	}
	    	.ruleTd {
	    		text-align:center;
	    		border:2px solid #dddddd; 
	    		background-color:#97FFFF;
	    		vertical-align: middle;
	    		font-weight: bold;
	    	}
			/* 通用 */
			::-webkit-input-placeholder { color:#BDBCC1; }
			::-moz-placeholder { color:#BDBCC1; } /* firefox 19+ */
			:-ms-input-placeholder { color:#BDBCC1; } /* ie */
			input:-moz-placeholder { color:#BDBCC1; }
			
			/* webkit专用 */
			::-webkit-input-placeholder { color:#BDBCC1;font:14px Microsoft YaHei; }
			#field3::-webkit-input-placeholder { color:#090; background:lightgreen; text-transform:uppercase; }
			#field4::-webkit-input-placeholder { font-style:italic; text-decoration:overline; letter-spacing:3px; color:#999; }
			
			/* mozilla专用 */
			::-moz-placeholder { color:#BDBCC1; font:14px Microsoft YaHei;}
			#field3::-moz-placeholder { color:#090; background:lightgreen; text-transform:uppercase; }
			#field4::-moz-placeholder { font-style:italic; text-decoration:overline; letter-spacing:3px; color:#999; }
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

<body style="height:100%;weight:100%;background: #f7f7f7;" >
<div style="position:absolute;top:0px;bottom:0px;left:0px;right:0px;height:100%;
padding:20px;" >
	<div>
		<div id="cesi" style="position: absolute;width:100%;margin-top:-10px">
			<table>
	           	<tr>   
	           	    <td>
	           	    	<font style="font-size:14px; font-family:Microsoft YaHei; color:#88878B;">
							&nbsp;请输入关键字：&nbsp;&nbsp;
						</font>
					</td>
	           	    <td><input id="searchKeyword" name="searchKeyword" type="text" onmouseover="tipShow()" onmouseout="tipHide()" class="sap_input" style="width:300px;height:30px;" placeholder="例如输入: 短信  流量" />
		              <!--   <div id="tip" class="alert alert-warning" style="display:none; position:absolute; z-index:100;">
							<strong>提示：</strong>
							“+”表示“并且”，“|”表示“或者”，“-”表示“非”并需放在文本首位
						</div> -->
		            </td>
	           		<td>
	           			&nbsp;&nbsp;&nbsp;
	           			<a>
	           				<button type="button" id="searchButton" class="btn btn-info btn-sm" onClick="search()">
	           					<span class="ace-icon fa fa-search icon-on-right bigger-110"></span>
	           					&nbsp;查询
	           				</button>
	           				<button type="button" class="btn btn-info btn-sm" onclick="openSearchInfo()">
				            	<span class="ace-icon fa fa-folder-o icon-on-right bigger-110"></span>
				            	<font style="font-size:13px;">
				            		打开
				            	</font>
				            </button>
				            <button type="button" class="btn btn-info btn-sm" onclick="saveSearchInfo()">
				            	<span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
				            	<font style="font-size:13px;">
				            		保存
				            	</font>
				            </button>
	           			</a>
	           		</td>
	           		<td></td>
	       		</tr>
	       	</table>
		</div>
<!-- 		<div id="nowPosition" style="position:absolute;right:5px;top:15px;">
			<span class="label label-xlg label-yellow arrowed-in">
				当前位置：  全文检索
			</span>
		</div> -->
		<div>
			<div style="width:25%; height:90%; top:54px; bottom:0px; position:absolute;">
				<div style="width:86%; height:100%; overflow-y:auto; overflow-x:hidden;">
					<table style="width:100%;">
						<tbody id="searchConditionList">
						</tbody>
					</table>
					<div>
						<button type="button" class="btn btn-info btn-sm" onclick="addSearchCondition()"
		            	style="width:95%; height:25px; top:10px; border:0px;">
			            	<font style="font-size:13px;">
			            		添加检索条件
			            	</font>
		           	 	</button>
					</div>
				</div>
			</div>
			<div class="tab-content" style="width:65%;top:54px;bottom:0px;right:7%;position:absolute;">
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
   <div class="modal-dialog" style="width:900px;margin:auto;">
      <div class="modal-content">
         <div class="modal-header" style="padding: 8px;">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="modalLabelPlay">
              	录音播放
            </h4>
         </div>
         <div class="modal-body">
		    <div data-options="region:'center', fit:false, border:true" title=""
		        style="overflow: hidden;padding: 0px;">
		        <div id="playerDiv" style="display:block; padding:0px; overflow-x: hidden;">
		            <iframe id="myIFrame" name="myIFrame" scrolling="auto" src="" frameborder="0" 
		            	style="height:650px; width:100%; padding:0px; margin:0px;"> 
					</iframe>
		        </div>
		    </div>
         </div>
      </div>
	</div>
</div>

<div class="modal fade" id="addSearchInfoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
   <div class="modal-dialog" style="width:340px;margin:auto;">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="modalLabelPlay">
              	添加检索条件
            </h4>
         </div>
         <div class="modal-body" id="modal-body" align="center">
			<table id="searchInfoTable" class="addTable" style="height:151px;">
				<tr>
				  <td>名称:</td>
				  <td><input id="searchInfoName" name="searchInfoName" placeholder="请输入检索名称" class="input" type="text"/></td>
				</tr>
			</table>
         </div>
		 <hr style="color:#d0d0d0;margin:0"/>
		 <div align="center" style="padding-left:30px; padding-right:0px; padding-bottom:15px;">
		 	<button id="addButton" onclick="addSearchInfo()" type="button" class="btn btn-info btn-sm" style="width:75px;height:30px;margin-right:15px"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
			<button type="reset" class="btn btn-sm" data-dismiss="modal" style="width:75px;height:30px;margin-right:25px"><i class="ace-icon fa fa-undo bigger-110" ></i>取消</button>
		 </div>
      </div>
	</div>
</div>

<div class="modal fade" id="searchConditionListModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
	<div class="modal-dialog" style="width:740px; margin:auto;height:500px">
		<div class="modal-content" style="height:500px">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
				&times;
				</button>
				<h4 class="modal-title" id="modalLabelPlay">
				检索条件列表
				</h4>
			</div>
         	<div class="modal-body" id="modal-body" align="center"  style="font-size:12px;height:400px;overflow:auto">
			  		<table style="width:95%;" class="table table-striped table-bordered table-hover dataTable no-footer">
                   		<thead>
                   			<tr style="background-color:#417AB2;">
                   				<th style="width:40%;background-color:#5CACDF;color:rgb(236,238,237);text-align:center" >名称(点击打检索条件)</th>
                   				<th style="width:20%;background-color:#5CACDF;color:rgb(236,238,237);text-align:center" >操作</th>
                   			</tr>
    					</thead> 
			   			<tbody id="tbodySearch">
			   			</tbody> 
                    </table>
          	</div>
      	</div>
	</div>
</div>
 <div class="modal fade" id="assignModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="positio:relative">
	 	<div class="modal-dialog">
	    	<div class="modal-content" style="width:800px;height:550px;position:relative">
	        	<div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
		                  &times;
		            </button>
		            <h4 class="modal-title" id="myModalLabel" style="margin-top:0;font-size:22px;letter-spacing: 1.5px;width:200px">
		              	检索条件列表
		            </h4>
	         	</div>
	         	<div class="modal-body" id="modal-body" align="center" style="font-size:12px;" >
	            	<input id="ids" name="ids" type="hidden" />
	            	<input id="insIds" name="insIds" type="hidden" />
	            	<table id="insTable" class="table table-striped table-bordered table-hover">
					   <thead id="inshead">
					   </thead> 
					   <tbody id="insbody">
					   </tbody>
					</table>
	         	</div>
	      	</div>
	    </div>
	 </div>
<script type="text/javascript">
var nowDataTable=null;
var nowDataTable1=null;
var aaData = null;
var checkTime="";
//检索条件
var number = 0;	//检索条件编号
var searchIdArray = new Array();
var ruleTypeArray = null;
var flag = false;
var searchInfoCommon="";

$(function(){
	initData();
	initSearchInfo();
	setTimeout("search()",100);
	 placeHolderBug();
	 setTimeout("setStyle()",100);
	
	
});
/*
function openSearchInfo(){
	$("#assignModal").css({
		"position" : "absolute",
	});
	$("#assignModal").modal("show");
	var insColumns = [
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
                        "sWidth": "30%",
                        "bVisible": true,
                        "sDefaultContent" : "",  
                        "sClass" : "center"  
                    },
                  	{  
  	                   "mDataProp" : "action",  
  	                   "sTitle" : "操作", 
  	                   "sWidth": "30%",
  	                   "bVisible": true,
  	                   "sDefaultContent" : "",  
  	                   "sClass" : "center",
  	                   "render": function (data, type, full, meta) {
  	                   		var button = "";
  	                   		button += '<a href="javascript:void(0)" onclick="deleteSearchInfo(\''+full.uuid+'\')">删除</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
  	                   		return button;
  	              		}
                    	}
	];
	if(nowDataTable1!=null){
		nowDataTable1.fnClearTable(0); //清空数据
		nowDataTable1.fnDestroy();
	}
	$("#inshead").html("");
	$("#insbody").html("");
	nowDataTable1 = $('#insTable').dataTable({
		 "bAutoWidth": false,//for better responsiveness
		 "bProcessing": true,
		 "bServerSide": false,
		 "showRowNumber":false,
         "bPaginate" : true,// 分页按钮
		 "bLengthChange" : false,// 每行显示记录数
		 "aLengthMenu": [10],//设置每页显示多少行
		 "bSort" : false,// 排序
		 "bInfo":true,
		 "aoColumns":insColumns,
		 "order": [[ 0, 'asc' ]],//按照第一列升序排序 
		 "fnDrawCallback":function(){

		 },
		 "sAjaxSource": "./getSearchInfo",
		 "fnServerData": function ( sSource, aoData, fnCallback ) {
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
		 }
		 
	});
	$("#insTable").parent().find(".row").css({"position":"absolute","top":"400px","right":"1px","width":"790px"});
}
*/



function setStyle(){
	$(".dataTables_scroll").css("overflow","auto");
	$(".dataTables_scrollHead").css("overflow","");
	$(".dataTables_scrollBody").css("overflow","");
}
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

function initData(){
	$('#dataTable tbody').on( 'click', 'tr', function () {
        $(this).toggleClass('selected');
    } );
}

function search(){
	//高级检索条件
	 searchInfoCommon = JSON.stringify(getSearchCondition());
	if(searchInfoCommon=="null"){
		return ;
	}
	getAllRecord();
}	

function fillSearchInfo(aoData){


	aoData.push({"name":"searchInfo","value": searchInfoCommon});
	var defaultValue=$.trim($("#searchKeyword").attr('placeholder'));
	if(defaultValue!=$("#searchKeyword").val()){
		aoData.push({"name":"searchKeyword","value":$("#searchKeyword").val()});
	}
	
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
		                        "sWidth": "210px",
		                        "sClass" : "center"  
		                    },
	                      {  
		                        "mDataProp" : "uuid",  
		                        "sTitle" : "工单号", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sWidth": "300px",
		                        "sClass" : "center"  
		                    },
		                  {  
		                        "mDataProp" : "callTime",  
		                        "sTitle" : "呼叫时间", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sWidth": "240px",
		                        "sClass" : "center"  
		                    },
		                    {  
		                        "mDataProp" : "analysisTime",  
		                        "sTitle" : "转写时间", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sWidth": "240px",
		                        "sClass" : "center"  
		                    },
	                      {  
		                        "mDataProp" : "userName",  
		                        "sTitle" : "平台编号", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sWidth": "240px",
		                        "sClass" : "center"  
	                      }
		];
	if(nowDataTable!=null){
		nowDataTable.fnClearTable(0); //清空数据
		nowDataTable.fnDestroy();
	}

	$("#thead").html("");
	$("#tbody").html("");
	var tabContent = $(".tab-content").height()-34-58-40;
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
		 "sPaginationType": "full_numbers", //显示首页和尾页
	     "scrollY": tabContent,
	     "scrollX": "1150px",
	     "iDisplayLength": pageNum,
		 "order": [[ 0, 'asc' ]],
		 "sAjaxSource": "../search/dataGrid",
		 "fnServerData": function ( sSource, aoData, fnCallback ) {
			
			 if(fillSearchInfo(aoData)==null){
				 return;
			 }
			 if(checkTime!=""){
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
		            /* var width = $("#dataTable").css("width");
		            $(".dataTables_scrollHead .dataTables_scrollBody").css("width", width); */
		        }    
			 } );
		 },
		 "aoColumns":aoColumns,
		 "fnDrawCallback": function(settings) {
			    if(aaData!=null&&aaData.length>0){
			    	$("#dataTable").css("table-layout","fixed");
			    	var trs = $("#dataTable tbody tr");
			    	for(var i=0 ;i<aaData.length; i++){/* '+trs[i].scrollWidth+' */
			    		//播放功能暂无法使用，删除    <td class="center" style="border-bottom:black;"><a href=# onclick=\'play("'+aaData[i].uuid+'")\'>播放</a></td>
			    		insertAfter($('<tr><td class=" left" colspan="10" style="width:1024px;word-wrap:break-word;word-break:break-all;white-space:normal;">'+aaData[i].remark+'</td></tr>')[0],trs[i]);
			    	}
			    }
			}
	});
	
}
function insertAfter(newElement, targetElement){
	var parent = targetElement.parentNode;
	if (parent.lastChild == targetElement) {
		// 如果最后的节点是目标元素，则直接添加。因为默认是最后
		parent.appendChild(newElement);
	}
	else {
		parent.insertBefore(newElement, targetElement.nextSibling);
		//如果不是，则插入在目标元素的下一个兄弟节点 的前面。也就是目标元素的后面
	}
}
function changeTwoDecimal(x)
{
var f_x = parseFloat(x);
if($.trim(f_x)=='NaN'){
	return "";
}
f_x = Math.round(f_x *100)/100;

return f_x;
}
//录音按钮事件播放
function play(id) {
	document.getElementById("myIFrame").src = "../search/flashWidget?uuid=" + id;
	
	//录音流水号
	$("#modalLabelPlay").html(id);
	$("#voicePlay").modal("show");
	   
	$('#voicePlay').on('hide.bs.modal', function () {
		document.getElementById("myIFrame").src = "" ;
	})
}

//秒数转化为时分秒
function formatSeconds(value) {
    var second = parseInt(value) / 1000; //秒
    var minute = 0; //分
    var hour = 0; //小时

    if(second <= 0) {
    	second = 1;
    } else {
    	second = Math.floor(second);
    }
    
    if(second > 60) {
    	minute = parseInt(second/60);
    	second = parseInt(second%60);
		if(minute > 60) {
			hour = parseInt(minute/60);
			minute = parseInt(minute%60);
		}
    }
    
    var result = "";
    if(hour > 0) {
    	if(hour.toString().length > 1) {
    		result += hour + ":";
    	} else {
    		result += "0" + hour + ":";
    	}
    } else {
    	result += "00:";
    }
    
    if(minute > 0) {
    	if(minute.toString().length > 1) {
    		result += minute + ":";
    	} else {
    		result += "0" + minute + ":";
    	}
    } else {
    	result += "00:";
    }
    
    if(second > 0) {
    	if(second.toString().length > 1) {
    		result += second;
    	} else {
    		result += "0" + second;
    	}
    } else {
    	result += "00";
    }
    
    return result;
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
//检索条件
function tipShow() {
	$("#tip").show();
}

function tipHide() {
	$("#tip").hide();
}

 function openSearchInfo() {
	$.post("../search/getSearchInfo", null, function(result) {
		var searchInfoList = result.aaData;
		var html = '';
		var number = 1;
		for(var i=0; i<searchInfoList.length; i++) {
			html += "<tr>";
			 //html += '<td class="ruleTd">' + number + '</td>'; 
			// html += '<td class="ruleTd">' + searchInfoList[i].createTime + '</td>'; 
			html += '<td style="text-align:center"><a href="javascript:void(0)" onclick="loadSearchInfo(\'' + number + '\')">' + searchInfoList[i].name + '</a></td>';
			html += "<input type='hidden' id='searchInfo" + number + "' value='" + JSON.stringify(searchInfoList[i].searchInfo) + "'/>";
			html += '<td style="text-align:center"><a href="javascript:void(0)" onclick="deleteSearchInfo(\'' + searchInfoList[i].uuid + '\')">删除</a></td>'; 
			html += "</tr>";
			number++;
		}
		
		$("#tbodySearch").html(html);
		
		$("#addSearchInfoModal").css({
			"position" : "absolute",
			"top" : "15%",
			"left" : "0%"
		});
		$("#searchConditionListModal").modal("show");
	},"json").error(function(e) {
		Modal_Alert('检索信息列表','加载检索信息失败');
	});
} 
//删除保存的检索条件
function deleteSearchInfo(uuid){
	$.post("../search/deleteSearchInfo", {uuid:uuid}, function(result) {
		Modal_Alert('检索信息列表','删除成功');
		openSearchInfo();
	},"json").error(function(e) {
        Modal_Alert('检索信息列表','删除失败');
    });
}
function loadSearchInfo(value) {
	var searchInfoText = $("#searchInfo" + value).val();
	var searchInfo = eval('('+searchInfoText.substring(1,searchInfoText.length-1).replace(/\\\"/g,"\"")+')');

	$("#searchKeyword").val(searchInfo.searchKeyword);
	
	$("#searchConditionList").html("");
	searchIdArray.splice(0, searchIdArray.length);
	
	var searchArray = searchInfo.advanceCondition;
	var tagArray;
	for(var i=0; i < searchArray.length; i++) {
		addSearchConditionDialog();

		$("#searchField" + number).val(searchArray[i].id);

		changeValueWidget(number);
		
		if(searchArray[i].type == '0') {
			$("#equalValue" + number).val(searchArray[i].equalValue);
		} else if(searchArray[i].type == '1') {
			tagArray = searchArray[i].equalValue.split(",");
			for(var j=0;j<tagArray.length;j++) {
				createTag(number, tagArray[j]);
			}
		} else if(searchArray[i].type == '2') {
			$("#minValue" + number).val(convertTime(searchArray[i].minValue,searchArray[i],false));
			$("#maxValue" + number).val(convertTime(searchArray[i].maxValue,searchArray[i],false));
		} else if(searchArray[i].type == '3') {
			$('input[name="equalValue' + number + '"]').each(function(){
				if(searchArray[i].equalValue.indexOf($(this).val()) >= 0) {
					$(this).attr("checked", true);
				}
			});
		} else if(searchArray[i].type == '4') {
			$("#equalValue" + number).val(searchArray[i].equalValue);
		} else if(searchArray[i].type == '5') {
			$("#minValue" + number).val(searchArray[i].minValue);
			$("#maxValue" + number).val(searchArray[i].maxValue);
		} else if(searchArray[i].type == '6') {
			$("#minValue" + number).val(searchArray[i].minValue);
			$("#maxValue" + number).val(searchArray[i].maxValue);
		}
		
		number++;
	}
	
	$("#searchConditionListModal").modal("hide");
}

function saveSearchInfo() {
	$("#addSearchInfoModal").css({
		"position" : "absolute",
		"top" : "10%",
		"left" : "0%"
	});
	$("#addSearchInfoModal").modal("show");
	$("#addSearchInfoModal").find("input").each(function(){
		$(this).val("");
	})
}

function addSearchInfo() {
	var searchName = $("#searchInfoName").val();
	if(searchName == null || searchName == ''||searchName=='请输入检索名称') {
		Modal_Alert('保存检索信息','名称不能为空');
		return;
	}
	$.post("../search/checkSearchInfo", {name : searchName}, function(result) {
		if(result.obj==1) {
			Modal_Alert('查询检索名称',result.msg);
		} else{
			var searchObject = new Object();
			var searchArray = getSearchCondition();
			if(searchArray==null){
		        return;
		    }
			if(searchArray!=null&&searchArray.length>0){
				searchObject.advanceCondition = searchArray;
				searchObject.searchKeyword = $("#searchKeyword").val();
				
				$.post("../search/addSearchInfo", {name : searchName, searchInfo : JSON.stringify(searchObject)}, function(result) {
					if(!result.success) {
						Modal_Alert('保存检索信息',result.msg);
					} else {
						Modal_Alert('保存检索信息','保存检索信息成功');
						$("#addSearchInfoModal").modal("hide");
					}
				},"json").error(function(e) {
					Modal_Alert('保存检索信息','保存检索信息失败');
				});
			}else{
				Modal_Alert('保存检索信息','请输入检索条件后进行保存!');
			}
		}
	},"json").error(function(e) {
		
	});

}

function getSearchCondition() {
	var searchArray = new Array();
	var searchObj = null;
	var searchNumber = 0;
	
	var ruleType = null;
	for(var i=0; i<searchIdArray.length; i++) {
		searchObj = new Object();
		//alert($("#searchField" + searchIdArray[i]).val());
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
			var defaultValue=$.trim($("#minValue" + searchIdArray[i]).attr('placeholder'));
			if(defaultValue==$.trim($("#minValue" + searchIdArray[i]).val())){
				searchObj.minValue=null;
			}else{
				searchObj.minValue = convertTime($.trim($("#minValue" + searchIdArray[i]).val()),ruleType,true);
			}
			if(searchObj.minValue==null){
                return null;
            }
			var defaultValue=$.trim($("#maxValue" + searchIdArray[i]).attr('placeholder'));
			if(defaultValue==$.trim($("#maxValue" + searchIdArray[i]).val())){
				searchObj.maxValue=null;
			}else{
				searchObj.maxValue = convertTime($.trim($("#maxValue" + searchIdArray[i]).val()),ruleType,true);
			}
			if(searchObj.maxValue==null){
                return null;
            }
		    if(searchObj.minValue>searchObj.maxValue){
            	Modal_Alert('检索信息错误',ruleType.text+"的最小值不能大于最大值");
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
			   if(searchObj.minValue>searchObj.maxValue){
	            	Modal_Alert('检索信息错误',ruleType.text+"的最小值不能大于最大值");
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
			 if(searchObj.minValue>searchObj.maxValue){
	            	Modal_Alert('检索信息错误',ruleType.text+"的最小值不能大于最大值");
					return null;
	            }
		}


		searchArray[searchNumber++] = searchObj;
	}
	return searchArray;
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
	checkTime='';
	if(ori==null||ori.length==0){
		Modal_Alert('检索信息错误',type.text+"的取值不能为空");
		checkTime=type.text+"的取值不能为空";
		checkTime='';
		return;
	}
	var reg = new RegExp("^[0-9.]*$");  
	if(!reg.test(ori)){  
        Modal_Alert('检索信息错误', type.text+"的取值不是数字");
        checkTime=type.text+"的取值不是数字";
        checkTime='';
        return;
   } 
	
	var mult = 1;
	if(type.numberType==11){
		mult = 1000;
	}else if(type.numberType==12){
		mult = 1000;
	}else if(type.numberType==13){
        mult = 60*60*1000;
    }
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
	addSearchConditionDialog();
	
	changeValueWidget(number);
	
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

function closeSearchCondtion(value) {
	for(var i=0;i<searchIdArray.length;i++) {
		if(value == searchIdArray[i]) {
			searchIdArray.splice(i, 1);
			break;
		}
	}
	
	var id = "search" + value;
	$("#" + id).remove();
	
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

function initSearchField(value) {
	var id = "searchField" + value;
	if(ruleTypeArray == null || ruleTypeArray.length <= 0) {
		return;
	}
	
	var html = "";
	//var ruleTypeText = "录音流水号,主叫号码,被叫号码,静音总时长,通话总时长,呼叫时间,质检完成状态";
	for(var i=0;i<ruleTypeArray.length;i++) {
		if(ruleTypeArray[i].id=="1"){
			continue;
		}
		//if(ruleTypeText.indexOf(ruleTypeArray[i].text) != -1) {
			html += "<option value='" + ruleTypeArray[i].id + "'>" + ruleTypeArray[i].text + "</option>";
		//}
	}
	$("#" + id).html(html);
}

function changeValueWidget(value) {
	var obj = getRuleType($("#searchField" + value).val());

	var html = "";
	if(obj.type == '0') {
		$("#fieldLabel" + value).html("字段取值：");
   		html += '<input id="equalValue' + value + '" name="equalValue' + value 
   			+ '" placeholder="请输入值"' + 
   			' type="text" style="width:100%; color:#88878B; height:30px; border-color:#b3d4e7;" value=""/>';
	} else if(obj.type == '1') {
		$("#fieldLabel" + value).html("字段取值：");
		html += '<div class="tags" style="border-color:#b3d4e7; max-height:100px; overflow-y:auto; overflow-x:auto; width:100%;">' + 
				'<div id="tags' + value + '"></div><input id="equalValue' + value + '" ' + 
				'name="equalValue' + value + '" type="text" placeholder="请输入关键字，然后按回车键确认" ' +
				'onkeydown="enterSearch(event,\'' + value + '\',\'yes\')" /><input id="equalValueText' + value + '" type="hidden"/></div>';
	} else if(obj.type == '2') {
		var type = changeNumber(obj.numberType);
		if(type.length>0){
			type = "(单位" + type+")";
		}
		$("#fieldLabel" + value).html("字段取值"+type+"：");
		html += '<input id="minValue' + value + '" name="minValue' + value + '" placeholder="最小值" onblur="checkValue('+value+')" style="height:30px; width:45%; border-color:#b3d4e7;" type="text"/>' + 
				'<label align="center" style="width:10%; font-size:12px; font-family:黑体; color:#88878B;">至</label>' + 
				'<input id="maxValue' + value + '" name="maxValue' + value + '" placeholder="最大值" onblur="checkValue('+value+')" style="height:30px;  width:45%;  border-color:#b3d4e7;" type="text"/>';
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
			' type="text" style="color:#88878B; width:100%; height:30px; border-color:#b3d4e7;"/>';
	} else if(obj.type == '5') {
		$("#fieldLabel" + value).html("字段取值：");
		html += '<input id="minValue' + value + '" name="minValue' + value + '" placeholder="开始时间" style="height:30px; width:45%; border-color:#b3d4e7;" type="text"/>' + 
				'<label style="width:10%; font-size:12px; font-family:黑体; color:#88878B;">&nbsp;-</label>' + 
				'<input id="maxValue' + value + '" name="maxValue' + value + '" placeholder="结束时间" style="height:30px;  width:45%;  border-color:#b3d4e7;" type="text"/>';
	} else if(obj.type == '6') {
		$("#fieldLabel" + value).html("字段取值：(单位:分钟)");
		html += '<input id="minValue' + value + '" name="minValue' + value + '" placeholder="最小值" onblur="checkValue('+value+')" style="height:30px; width:40%; border-color:#b3d4e7;" type="text"/>' + 
				'<label style="width:20%; font-size:12px; font-family:黑体; color:#88878B;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;</label>' + 
				'<input id="maxValue' + value + '" name="maxValue' + value + '" placeholder="最大值" onblur="checkValue('+value+')" style="height:30px;  width:40%;  border-color:#b3d4e7;" type="text"/>';
	}
	
	$("#valueWidget" + value).html(html);
	placeHolderBug();
	if(!placeholderSupport()){   // 判断浏览器是否支持 placeholder 
		if($("#maxValue"+value).val()==""){
			$("#maxValue"+value).val("最大值");
		}
	};

	if(obj.type == '5') {
		initDate(value);
	}
}

function checkValue(value){
	var minValue = $('#minValue'+value).val();
	var maxValue = $('#maxValue'+value).val();
	if(''!=minValue&&''!=maxValue){
	 	var reg = new RegExp("^[0-9]*$");  
	 	if(reg.test(minValue)&&reg.test(maxValue)){ 
			if(parseInt(minValue)>parseInt(maxValue)){
				$('#maxValue'+value).val('');
			}
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
        return "秒";
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
							<label style="font-size:12px; font-family: Micosoft YaHei; color:#88878B;">检索字段：</label>
							<select class="input-medium" id="searchField{id}" name="searchField{id}" 
									style="color:#88878B; border-color:#b3d4e7; width:100%; height:30px;" onchange="changeValueWidget('{id}')">
							</select>
						</div>
						<br />
						<div>
							<label id="fieldLabel{id}" for="form-field-9" style="font-size:12px; font-family: Micosoft YaHei; color:#88878B;">字段取值：</label>
							<div id="valueWidget{id}"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</td>
</tr>
*/}

/** -- 规则维护添加页面模糊查询控件 -- */
function enter(e) {
	enterSearch(e, 'no');	
}

function enterSearch(e, id, is) {
	var equalValueTextVal='';
	$("#tags"+id).find("span").each(function(){
		if(''==equalValueTextVal){
			equalValueTextVal=$(this).text().substring(0,$(this).text().length-1);
		}else{
			equalValueTextVal=equalValueTextVal+","+$(this).text().substring(0,$(this).text().length-1);
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
				Modal_Alert('全文检索','输入不合法，请重新输入！');
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
			var a=$("#equalValueText" + id).val();
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
			equalValueTextVal1=$(this).text().substring(0,$(this).text().length);
		}else{
			equalValueTextVal1=equalValueTextVal1+","+$(this).text().substring(0,$(this).text().length);
		}
	});
	$("#equalValueText" + id).val(equalValueTextVal1);
	$("#equalValue" + id).val('');
}

function clearTagClass(value) {
	$("#" + value).removeClass("tag-warning");
}

function clearTag(id, value) {
	$("#" + id + value).remove();
	
	var equalValueText = $("#equalValueText" + id).val()
	var equalValueArray = textToArray(equalValueText);
	
	for(var i=0; i<equalValueArray.length; i++) {
		if(value == equalValueArray[i]) {
			equalValueText = equalValueText.substring(0, equalValueText.indexOf(value)) + equalValueText.substring(equalValueText.indexOf(value) + value.length + 1,
				equalValueText.length);
			$("#equalValueText" + id).val(equalValueText);
		}
	}
}

function trim(value){
	return value.replace(/(^\s*)|(\s*$)/g, "");
}
 
function stripScript(s) {
	var pattern = new RegExp("[`~!@#$%^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？]");
    var rs = "";
    for (var i = 0; i < s.length; i++) {
        rs = rs + s.substr(i, 1).replace(pattern, '');
    }
    return rs;
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
		format:"yyyy-mm-dd hh:ii:ss",
		minView:0,
		maxView:3,
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
		format:"yyyy-mm-dd hh:ii:ss",
		minView:0,
		maxView:3,
		endDate:nowDate,
		language:"zh-CN",
	    autoclose: true,
	    todayBtn:true ,
	    todayHighlight: true,
	    pickerPosition: direction
	}).on("click", function (ev) {
	    $('#maxValue' + value).datetimepicker("setStartDate", $('#minValue' + value).val());
	});
	//$('#maxValue' + value).datetimepicker("update", nowDate);
}
</script>
</body>
</html>