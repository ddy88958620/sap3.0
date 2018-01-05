<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!---登入表单的布局 --->
<html>
	<head>
        <title>系统参数管理</title>
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
		
		<!--[if lte IE 9]>
			<link rel="stylesheet" href="${ctx }/css/ace/ace-part2.css" class="ace-main-stylesheet" />
		<![endif]-->
		
		<!--[if lte IE 9]>
		  <link rel="stylesheet" href="${ctx }/css/ace/ace-ie.css" />
		<![endif]-->
		
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
		<script src="${ctx }/js/respond.min.js"></script>
		<script src="${ctx }/js/ace/ace/elements.treeview.js"></script>
	    <script src="${ctx }/js/md5.js"></script>
	    <script src="${ctx }/js/windowResize.js"></script>
	    	<!--[if lte IE 8]>
		<script src="${ctx }/js/ace/html5shiv.js"></script>
		<script src="${ctx }/js/ace/respond.js"></script>
		<![endif]-->
</head>

<body style="height:100%;weight:100%;" >
<!-- 主页面 -->
<img class="bg" src="../img/background.png" />
<div style="position:absolute;top:0px;bottom:0px;left:0px;right:0px;height:100%;overflow-x:hidden;overflow-y:hidden;padding:20px;" >
<div style="height:50px;">
		<div id="nowPosition" style="position:absolute;right:5px;top:5px;"><span class="label label-xlg label-yellow arrowed-in">当前位置： 系统管理 - <font  id="tabSelect">系统参数管理 </font></span></div>
	 <div class="tab-content" style="width:99%;top:40px;bottom:0px;right:10px;position:absolute;">
	  		<table id="dataTable" class="table table-striped table-bordered table-hover">
			   <thead id="thead">
			    </thead> 
			    <tbody id="tbody">
			    </tbody> 
			</table>
	 </div>
 </div>
 </div>
 
 <!-- 修改modal -->
 <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content" style="width:600px;">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel" style="text-align:right;margin-top:0;font-size:22px;color:#429af1;letter-spacing: 1.5px;width:100px">
              	编辑
            </h4>
         </div>
         <div class="modal-body" id="modal-body" align="center" >
         <br/>
            <div class="form-group">
            		<input id="idmesg" type="hidden" />
            		<label id="passw" class="col-sm-2 control-label no-padding-right" style="text-align:right;letter-spacing: 1.5px;font-size:16px;color:#666;width:100px">编码 </label>
					<div class="col-sm-9" >
						<input type="text" id="code" readonly="readonly" placeholder="编码" class="col-xs-10 col-sm-4" style="width:190px;height:28px;"/>
						<span class="help-inline col-xs-12 col-sm-7">
							<span class="middle"><font color="red"></font></span>
						</span>
					</div>
					<br/><br/><br/>
					<label id="passw" class="col-sm-2 control-label no-padding-right" style="text-align:right;letter-spacing: 1.5px;font-size:16px;color:#666;width:100px">取值 </label>
					<div class="col-sm-9" >
						<input type="text" id="text" placeholder="取值" class="col-xs-10 col-sm-4" style="width:190px;height:28px;"/>
					</div>
					<br/><br/><br/>
					<label id="passw2" class="col-sm-2 control-label no-padding-right" style="text-align:right;letter-spacing: 1.5px;font-size:16px;color:#666;width:100px">状态</label>
					<div class="col-sm-9" >
					<!--  input type="text" id="state" placeholder="状态" class="col-xs-10 col-sm-4" style="width:190px;height:28px;"/>-->
					<select id="state" class="col-xs-10 col-sm-4 form-control" style="width:190px;height:28px;"></select>
					</div>
					<br/><br/><br/>
					<label id="passw2" class="col-sm-2 control-label no-padding-right" style="text-align:right;letter-spacing: 1.5px;font-size:16px;color:#666;width:100px"> 备注</label>
					<div class="col-sm-9" >
					<textarea id="remark" placeholder="备注" class="col-xs-10 col-sm-4" style="width:190px;height:80px;"></textarea>
					</div>
				</div>
         	</div>
       <hr style="color:#d0d0d0;margin:0"/>
       		<br/>
            <div align="right" style="padding-right: 10px;padding-bottom: 15px;">
            
            <button id="updateButton" onclick="updateDictionary()" type="button" class="btn btn-info btn-sm" style="width:75px;height:30px;margin-right:15px"><i class="ace-icon fa fa-check bigger-110"></i>修改</button> 
            <button type="reset" class="btn btn-sm" data-dismiss="modal" style="width:75px;height:30px;margin-right:25px"><i class="ace-icon fa fa-undo bigger-110" ></i>取消</button>
         </div>
      </div>
      </div>
</div>


<script type="text/javascript">
var nowDataTable=null;
$(function(){
	initData();
	getAllRecord();
});


/*
 * 给datatable设置样式
 */
function initData(){		
	$('#dataTable tbody').on( 'click', 'tr', function () {
        $(this).toggleClass('selected');
    } );
}

function getAllRecord(){
	var pageNum=$("#dataTable_length").find("select").val();
	var aoColumns = [
	                   {  
	                        "mDataProp" : "index",  
	                        "sTitle" : "序号", 
	                        "bVisible": true,
	                        "sDefaultContent" : "",  
	                        "sWidth": "50px",
	                        "sClass" : "center"  
	                    },
	                      {  
		                        "mDataProp" : "code",  
		                        "sTitle" : "编码", 
		                        "sWidth": "100px",
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center"  
		                    },
	                      {  
		                        "mDataProp" : "text",  
		                        "sTitle" : "取值", 
		                        "sWidth": "300px",
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sClass" : "center"  
		                    },
		                  {  
		                        "mDataProp" : "remark",  
		                        "sTitle" : "备注", 
		                        "bVisible": true,
		                        "sWidth": "300px",
		                        "sDefaultContent" : "",  
		                        "sClass" : "center"  
		                    },
	                      {  
		                        "mDataProp" : "state",  
		                        "sTitle" : "状态",  
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sWidth": "50px",
		                        "sClass" : "center",
		                        "render": function ( data, type, full, meta ) {
		                    	     switch(data){
		                    	          case 1:
		                    	            return '启用';
		                    	          case 0:
		                    	            return '停用';  
		                    	          default:
		                    	            return '启用';
		                    	     }
		                    	    } 
		                    },
	                      {  
		                        "mDataProp" : "action",  
		                        "sTitle" : "操作", 
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sWidth": "50px",
		                        "sClass" : "center",
		                        "render": function ( data, type, full, meta ) {
		                    	    return '<a onclick="editFun('+full.id+')">编辑</a>'
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
		"showRowNumber":false,
         "bPaginate" : false,// 分页按钮
		"bLengthChange" : true,// 每行显示记录数
		"bSort" : false,// 排序
		"bInfo":true,
		"bStateSave":false, //是否开启cookies保存当前状态信息
		"iDisplayLength": pageNum,
	    "scrollY": tabContent,
		 "order": [[ 0, 'asc' ]],
		 "sAjaxSource": "./dataGrid",//请求内容为退一步请求的内容
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
		            fnCallback(resp);   
		        }    
			 } );
		 },
		 "aoColumns":aoColumns
	});
	
}


function editFun(id) {
	$.post("${ctx }/dictionary/editPage",{id:id},function(data){
		var success = data.success;
		var dictionary = data.obj.dictionary;
		var states = data.obj.stateList;
		$("#code").val(dictionary.code);
		$("#text").val(dictionary.text);
		//$("#state").val(parameter.description);
		$("#remark").val(dictionary.remark);
		$("#idmesg").val(id);
		$("#updateModal").modal();
		
		/* $("#state").select2({
			minimumResultsForSearch: -1,
			 data: states,
		});
		$("#state").select2("val", dictionary.state);  */
		var html="";
		for(var key in states){
			html+="<option value='"+key+"'>"+states[key]+"</option>";
		}
		$("#state").html(html);
	},"json").error(function(e) {

		Modal_Alert('参数管理','加载数据失败');
	});
}

function updateDictionary(){
	$('#updateButton').attr("disabled", true);
	var code = $.trim($("#code").val());
	var text = $.trim($("#text").val());
	var remark = $.trim($("#remark").val());
	var state = $("#state").val();
	var id = $("#idmesg").val();
	var flag = checkData(code,text,remark);
	if(!flag){
		$('#updateButton').attr("disabled", false);
		return;
	}
	$.post('${ctx }' + '/dictionary/edit', {id:id,code:code,text:text,remark:remark,state:state}, function (data) {
		if(data.success){
			$("#updateModal").modal('hide');
			Modal_Alert('系统参数管理','操作成功：'+data.msg + "<br/>");
			nowDataTable.fnDraw();
		}else{
			Modal_Alert('系统参数管理','操作失败：'+data.msg);
		}
		$('#updateButton').attr("disabled", false);
	},"json").error(function() { 
		$('#updateButton').attr("disabled", false);
		Modal_Alert('系统参数管理','操作失败：'+data.msg);
	});
}

function checkData(code,text,remark){
	if( code.length <1){
		Modal_Alert('系统参数管理','操作失败：编码不能为空');
		return;
	}
	if( text.length <1){
		Modal_Alert('系统参数管理','操作失败：取值不能为空');
		return;
	}
	if( remark.length <1){
		Modal_Alert('系统参数管理','操作失败：备注不能为空');
		return;
	}
	return true;
}




</script>

</body>
</html>