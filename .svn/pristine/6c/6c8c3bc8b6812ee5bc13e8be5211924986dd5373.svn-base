<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!---登入表单的布局 --->
<html>
	<head>
        <title>开始质检</title>
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
<body style="height:100%;weight:100%;background:#F7F7F7"" >
<div style="position:absolute;top:0px;padding:20px;bottom:0px;left:0px;right:0px;height:85%;" >
<div class="row">
<div class="col-sm-5">
			<div class="tabbable">
											<ul class="nav nav-tabs" id="myTab">
												<li class="active">
													<a data-toggle="tab" href="#information">
														
														录音信息
													</a>
												</li>

												<li>
													<a data-toggle="tab" href="#rule">
														违规点信息
													</a>
												</li>

												<li class="dropdown">
													<a data-toggle="tab" href="#speech">
														标准话术
													</a>
												</li>
											</ul>

											<div class="tab-content" >
											<div id="information" class="tab-pane fade in active">
														<div class="row" style="height:150px;width:100%;margin-left:0px;overflow:auto">
														<table style="width:100%;border-right:none;border-left:none" class="table table-striped table-bordered table-hover dataTable no-footer" >
													                   		<thead>
													                   			<tr style="background-color:#417AB2;">
													                   				<th style="width:100%;background-color:#5CACDF;color:rgb(236,238,237);text-align:center" colspan="4">基本信息</th>
													                   				
													                   			</tr>
													    					</thead> 
																   			<tbody style="text-align:center;width:100%;">
																   			   <tr style="height:38px"><td style="border-left:none">录音流水号</td><td id="uuid"></td><td>时长</td><td id="duration" style="border-right:none;border-left:none"></td></tr>
																   			   <tr style="height:38px"><td style="border-left:none">主叫号码</td><td id="ani"></td><td>被叫号码</td><td id="dnis" style="border-right:none;border-left:none"></td></tr>
																   			   <tr style="height:38px"><td style="border-left:none">呼叫时间</td><td id="callTime"></td><td>总静音时长</td><td id="silenceDuration" style="border-right:none;border-left:none"></td></tr>
																   			</tbody> 
													   </table>
			<!-- 										<div class="profile-user-info profile-user-info-striped" style="dispaly:none">
													<div class="profile-info-row" style="background:#5CACDF">
														<div class="profile-info-name"> </div>
														<div class="profile-info-value">
															<span class="editable" ><b></b></span>
														</div>
														<div class="profile-info-name"> ： </div>
															<div class="profile-info-value">
																<span class="editable" ><b></b></span>
															</div>
														</div>
														<div class="profile-info-row">
														<div class="profile-info-name"> 录音流水号：</div>
														<div class="profile-info-value">
															<span class="editable" id="uuid"><b></b></span>
														</div>
														<div class="profile-info-name"> 主叫号码： </div>
															<div class="profile-info-value">
																<span class="editable" id="ani"><b></b></span>
															</div>
														</div>
														<div class="profile-info-row">
															<div class="profile-info-name"> 被叫号码：</div>
															<div class="profile-info-value">
																<span class="editable" id="dnis"><b></b></span>
															</div>
																	<div class="profile-info-name"> 时长： </div>
															<div class="profile-info-value">
																<span class="editable" id="duration"><b></b></span>
															</div>
														</div>
														
														<div class="profile-info-row">
															<div class="profile-info-name"> 总静音时长：</div>
															<div class="profile-info-value">
																<span class="editable" id="silenceDuration"><b></b></span>
															</div>
																			<div class="profile-info-name"> 来电时间：</div>
															<div class="profile-info-value">
																<span class="editable" id="callTime"><b></b></span>
															</div>
														</div>
													</div> -->
												</div>
												</div>
											

												<div id="rule" class="tab-pane fade" >
													<div class="row" style="height:150px;width:100%;margin-left:0px;overflow:auto">
														<table style="width:100%;border-right:none;border-left:none" class="table table-striped table-bordered table-hover dataTable no-footer">
													                   		<thead>
													                   			<tr style="background-color:#417AB2;">
													                   				<th style="width:20%;background-color:#5CACDF;color:rgb(236,238,237);text-align:center" >规则名称</th>
													                   				<th style="width:20%;background-color:#5CACDF;color:rgb(236,238,237);text-align:center" >规则短语</th>
													                   				<th style="width:60%;background-color:#5CACDF;color:rgb(236,238,237);text-align:center" >命中语句</th>
													                   			</tr>
													    					</thead> 
																   			<tbody id="tbodySearch">
																   			</tbody> 
													   </table>
													</div>
												</div>
													<div id="speech" class="tab-pane fade">
													<div class="row" style="height:150px;width:100%;margin-left:0px;overflow:auto">
															<table style="width:100%;border-right:none;border-left:none" class="table table-striped table-bordered table-hover dataTable no-footer">
													                   		<thead>
													                   			<tr style="background-color:#417AB2;">
													                   				<th style="width:40%;background-color:#5CACDF;color:rgb(236,238,237);text-align:center" >话术名称</th>
													                   				<th style="width:60%;background-color:#5CACDF;color:rgb(236,238,237);text-align:center" >可信度(0-100)</th>
													                   				
													                   			</tr>
													    					</thead> 
																   			<tbody id="tbodySearch1">
																   			</tbody> 
													   </table>
													</div>
												</div>
												
											</div>
										</div>
										<div style="width:100%;height:100%;">
	<iframe id="myIFrame" name="myIFrame" scrolling="auto" src="" frameborder="0" style="width:100%;height:525px;padding:0px; margin:0px;margin-top:15px"> 
	</iframe>
	</div >
</div>
<div class="col-sm-7" style="height:700px;position:relative">
<!-- 服务规范列表 -->
<div style="width:100%;height:95%;float: right;padding-top:0px;margin-top:35px;margin-bottom:1px">
<div style="width:98%;height:100%;float: right;padding-top:0px;overflow:auto">
<table id="ruleTable" class="table table-striped table-bordered table-hover" style="overflow:auto">
   <thead id="rhead">
   </thead> 
   <tbody id="rbody">
   </tbody> 
</table>

	<div class="row" style="position:absolute;top:710px;right:17px;width:500px">
		<div class="profile-user-info profile-user-info-striped" >
			<div class="profile-info-row">
			<div class="profile-info-name"> 当前总得分：</div>
			<div class="profile-info-value">
				<span class="editable" id="score"><b></b></span>
			</div>
			<div class="profile-info-name"> 严重差个数： </div>
			
				<div class="profile-info-value">
					<span class="editable" id="seriousNum"><b></b></span>
				</div>
					<div class="profile-info-name"> 一般差个数：</div>
			
				<div class="profile-info-value" style="margin-right:15px;padding-right:15px">
					<span class="editable" id="generalNum"><b></b></span>
				</div>
				<div class="profile-info-value" style="margin-left:15px">
									<button type="button" id="searchButton" class="btn btn-info btn-sm" onClick="inspectConfirm()" style="margin-right:5px;">
					<span class="glyphicon glyphicon-ok"></span>
					&nbsp;提交
				</button>
				</div>

			</div>


		</div>
	</div>

</div>
</div>
</div>
</div>
<div class="modal fade" id="confirmMsg" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
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
         <div class="modal-body" id="conte" align="center" style=" line-height: 161px; ">
      			   确定提交质检结果?
         </div>
        <hr style="margin-bottom: 10px;"/>
	  			<div align="right" style="padding-right: 10px;padding-bottom: 10px;">
			<button id="sureRelate" onclick="inspect()" type="button" class="btn btn-info btn-sm"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
            <button type="reset" class="btn btn-sm" data-dismiss="modal"><i class="ace-icon fa fa-undo bigger-110"></i>取消</button>
         </div>
      </div>
	</div>
</div>
<div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
              	工单质检
            </h4>
         </div>
         <div class="modal-body" id="conte" align="center" style=" line-height: 161px; ">
      			   操作成功：已完成质检！
         </div>
        <hr style="margin-bottom: 10px;"/>
	  			<div align="right" style="padding-right: 10px;padding-bottom: 10px;">
            <button type="reset" class="btn btn-sm" data-dismiss="modal"><i class="ace-icon fa fa-undo bigger-110"></i>关闭</button>
         </div>
      </div>
	</div>
</div>

</div>
<script type="text/javascript">
var ruleDataTable=null;
var attiDataTable=null;
var commDataTable=null;
$(function(){
	var width=$("#myIFrame").width();
	document.getElementById("myIFrame").src = "${ctx }/inspection/flashWidget?uuid=" + '${id}'+"&width="+width;
	initData();
	initRuleTable();
	getAnalysisData();
	getStandardSpeech();
	$("#ruleTable_wrapper").find(".row").css("display","none");
});

//工单基本信息
function initData(){
	var id = '${id}';
	$.post('../inspection/getInfoById',{id:id},function(data){
		if(data.success==true){
			$('#uuid').html(data.obj.UUID);
			$('#ani').html(data.obj.relateData.ani);
			$('#dnis').html(data.obj.relateData.dnis);
			$('#duration').html(data.obj.transData.duration);
			$('#silenceDuration').html(data.obj.transData.silenceDuration);
			$('#callTime').html(data.obj.relateData.callTime);
		}
	},"json").error(function(e) {
		Modal_Alert('工单质检','加载信息失败');
	});
	//初始化分数和被选中数
	$('#generalNum').html(0);
	$('#seriousNum').html(0);
	$('#score').html(100);
}

function getAnalysisData(){
	var uuid = '${id}';
	$.post("../inspection/getAnalysisData",{uuid:uuid}, function(result) {
		var searchInfoListArr=eval(result.obj);
		var searchInfo=searchInfoListArr[0];
		var html="";
		if(searchInfo!=null){
			
			if(searchInfo.ruleNameList.length>0){
				for(var i=0;i<searchInfo.ruleNameList.length;i++){
					html += "<tr>";
					html += '<td style="text-align:center;border-left:none">' + searchInfo.ruleNameList[i] + '</td>';
					html += '<td style="text-align:center">' + searchInfo.ruleScriptList[i] + '</td>';
					html += '<td style="text-align:center;border-right:none;border-left:none">' + searchInfo.hitPartList[i] + '</td>';
					html += "</tr>";
				}
				$("#tbodySearch").html(html);
				$("#tbodySearch").parent().css("border","none");
			}else{
				html += "<tr >";
				html += "<td colspan=\"3\" style=\"border: none;\">没有数据 </td>";
	
				html += "</tr>";
				$("#tbodySearch").html(html);
				$("#tbodySearch").parent().css("border","none");
			}
		}else{
			html += "<tr >";
			html += "<td colspan=\"3\" style=\"border: none;\">没有数据 </td>";

			html += "</tr>";
			$("#tbodySearch").html(html);
			$("#tbodySearch").parent().css("border","none");
		}
	},"json").error(function(e) {
		Modal_Alert('检索信息列表','违规点加载失败');
	});
}
function getStandardSpeech(){
	var uuid = '${id}';
	$.post("../inspection/getStandardSpeech",{uuid:uuid}, function(result) {
		var searchInfoListArr=eval(result.obj);
		var searchInfo=searchInfoListArr[0];
		var html="";
		if(searchInfo!=null){
			
			if(searchInfo.speechNameList.length>0){
				for(var i=0;i<searchInfo.speechNameList.length;i++){
					html += "<tr>";
					html += '<td style="text-align:center;border-left:none">' + searchInfo.speechNameList[i] + '</td>';
					html += '<td style="text-align:center;border-right:none;border-left:none">' + searchInfo.confidenceList[i]*100 + '</td>';
					html += "</tr>";
				}
				$("#tbodySearch1").html(html);
			}else{
				html += "<tr >";
				html += "<td colspan=\"2\" style=\"border: none;\">没有数据 </td>";
	
				html += "</tr>";
				$("#tbodySearch1").html(html);
				$("#tbodySearch1").parent().css("border","none");
			}
		}else{
			html += "<tr >";
			html += "<td colspan=\"2\" style=\"border: none;\">没有数据 </td>";

			html += "</tr>";
			$("#tbodySearch1").html(html);
			$("#tbodySearch1").parent().css("border","none");
		}	
		
	
	},"json").error(function(e) {
		Modal_Alert('检索信息列表','违规点加载失败');
	});
}
function initRuleTable(){
	var ruleColumns = [
						{  
						    "mDataProp" : "uuid",  
						    "sTitle" : "ID", 
						    "bVisible": false,
						    "sDefaultContent" : "",
						    "sWidth": "200px",
						    "sClass" : "center"
						},
						{  
						    "mDataProp" : "content",  
						    "sTitle" : "具体内容", 
						    "bVisible": true,
						    "sDefaultContent" : "",
						    "sWidth": "200px",
						    "sClass" : "center"
						},
						 {  
						    "mDataProp" : "name",  
						    "sTitle" : "所属范畴", 
						    "bVisible": true,
						    "sDefaultContent" : "",
						    "sWidth": "80px",
						    "sClass" : "center"
						},
						{  
						    "mDataProp" : "type",  
						    "sTitle" : "类型", 
						    "bVisible": true,
						    "sDefaultContent" : "",
						    "sWidth": "80px",
						    "sClass" : "center"
						},
						 {  
						    "mDataProp" : "score",  
						    "sTitle" : "分值", 
						    "bVisible": true,
						    "sDefaultContent" : "",
						    "sWidth": "50px",
						    "sClass" : "center"
						},
						{  
	                        "mDataProp" : "index",  
	                        "sTitle" : "选择",
	                        "bVisible": true,
	                        "sDefaultContent" : "",  
	                        "sWidth": "50px",
	                        "sClass" : "center",
	                        "render": function ( data, type, full, meta ) {
	                        	var level = 0;
	                        	if("一般差错"==full.type){
	                        		level = 1;
	                        	}else if("严重差错"==full.type){
	                        		level = 2;
	                        	}
	                        	var button = "<input type='checkbox' name='checkbox' id='checkbox"+data+"' value='" +full.content+ "' onclick='getScore("+data+","+level+","+full.score+")'/>";
	                        	return button;
	                            }
	                    }
		];
		if(ruleDataTable!=null){
			ruleDataTable.fnClearTable(0); //清空数据
			ruleDataTable.fnDestroy();
		}
		$("#rhead").html("");
		$("#rbody").html("");
	
		ruleDataTable = $('#ruleTable').dataTable({
			 "bAutoWidth": false,//for better responsiveness
			 "bProcessing": false,
			 "bServerSide": true,
			 "showRowNumber":false,
	         "bPaginate" : false,// 分页按钮
			 "bLengthChange" : false,// 每行显示记录数
			 "bSort" : false,// 排序
			 "bInfo":false,
			 "bStateSave":false, //是否开启cookies保存当前状态信息
			 "order": [[ 2, 'asc' ]],
			 "sAjaxSource": "../inspection/findRules",
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
			 },
			 "aoColumns":ruleColumns
		});
		
}

function getScore(index,type,score){
	var sumScore = parseInt($('#score').html(),10);
	var generalNum = parseInt($('#generalNum').html(),10);
	var seriousNum = parseInt($('#seriousNum').html(),10);
	if($('#checkbox'+index).is(':checked')){
		if(type==1){
			$('#generalNum').html(generalNum+1);			
		}else{
			$('#seriousNum').html(seriousNum+1);
		}
		$('#score').html(sumScore-score);
	}else{
		if(type==1){
			$('#generalNum').html(generalNum-1);			
		}else{
			$('#seriousNum').html(seriousNum-1);
		}
		$('#score').html(sumScore+score);
	}
}

function inspectConfirm(id) {
	$("#confirmMsg").modal();
}

function inspect(){
	var id = '${id}';
	var generalNum = parseInt($('#generalNum').html());
	var seriousNum = parseInt($('#seriousNum').html());
	var score = parseInt($('#score').html());
	var content = "";
	$("input[name='checkbox']:checked").each(function(){
		content += $(this).attr('value')+"|";
	});
	content = content.substr(0,content.length-1);
	$.post('../inspection/inspect',{id:id,content:content,generalNum:generalNum,seriousNum:seriousNum,score:score},function(data){
		if(data.success==true){
			$("#confirmMsg").modal("hide");
			$("#successModal").modal();
			$('#successModal').on('hide.bs.modal', function () {
				window.location.href="../inspection/manager";
			});
		}
	},"json").error(function(e){
		
	})
	
}
</script>
</body>
</html>