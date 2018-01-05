<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!---登入表单的布局 --->
<html>
	<head>
        <title>规则集管理</title>
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
			/* color:#848484"; */	
			color:#666;	
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
        <!-- jqGrid -->
        <link rel="stylesheet" type="text/css" href="${ctx }/css/ace/ui.jqgrid.css">
		<script src="${ctx }/js/ace/jqGrid/jquery.jqGrid.src.js"></script>
		<script src="${ctx }/js/ace/jqGrid/i18n/grid.locale-cn.js"></script>

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
<body style="position:absolute; top:0px; bottom:0px; left:0px; right:0px;" >
	<img class="bg" src="../img/background.png" />
	<div style="position:absolute;top:0px;bottom:0px;left:0px;right:0px;height:100%;overflow-x:hidden;overflow-y:hidden;padding:10px;" >
		<div id="cesi" style="position:absolute;width:100%;left:30px;">
			<table>
       			<tr>
       				<td>
	       				<a>
	       					<button type="button" id="add" class="btn btn-info btn-sm" style="z-index:1;" onClick="addFun()">
	       						<span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>&nbsp;添加
	       					</button>
	       				</a>
	       			</td>
	       			<td>
	       				<font style="font-size:14px; font-family:黑体; color:#4D4D4D;">
							&nbsp;&nbsp;规则集类型：
						</font>
	       			</td>
	       			<td>
	       				<select id="queryRulesTypeId" name="queryRulesTypeId" class="select" onchange="search()"></select>
	       			</td>
	       			<td>
	       				<font style="font-size:14px; font-family:黑体; color:#4D4D4D;">
							&nbsp;&nbsp;&nbsp;规则集名称：
						</font>
	       				<input id="queryName" name="queryName" class="input" type="text" onkeydown="enterSearch()"/>
	       			</td>
	       			<td>
	       				&nbsp;&nbsp;&nbsp;
	       				<a>
	       					<button type="button" id="search" class="btn btn-info btn-sm" style="z-index:1;" onClick="search()">
	       						<span class="fa icon-on-right bigger-110"></span>&nbsp;查询
	       					</button>
	       				</a>
	       			</td>
	    		</tr>
   			</table>
		</div>
		<div id="nowPosition" style="position:absolute;right:5px;top:15px;">
			<span class="label label-xlg label-yellow arrowed-in">当前位置： 质检规则 - 
				<font  id="tabSelect">规则集管理</font>
			</span>
		</div>

	    <div style="width:98%;top:45px;bottom:0px;position:absolute;height:100%;">
	    	<div class="row" style="height:100%;">
		    	<div class="col-sm-6 side"  style="height:100%;width:100%;padding-top:0px;padding-right: 10px;" >
					<div class="tab-content" style="width:100%; top:10px;bottom:0px;position:absolute;">
			  			<!-- 
			  			<table id="dataTable" class="table table-striped table-bordered table-hover">
					    	<thead id="thead">
					    	</thead> 
					    	<tbody id="tbody">
					    	</tbody> 
						</table>
						 -->
						<table id="grid-table"></table>
        				<div id="grid-pager" style="height:auto;"></div>
			 		</div>
		   		</div>
	    	</div>
		</div>
	</div>
	<iframe id="myIFrame" name="myIFrame" src="" scrolling="yes" frameborder="0" style="position:absolute; top:100%;;width:100%; height:100%;z-index:2;"> 
	</iframe> 
</body>
<script type="text/javascript">
var queryName = $("#queryName");
var queryRulesTypeId = $("#queryRulesTypeId");

var grid_selector  = "#grid-table";
var pager_selector = "#grid-pager";
var postData;

var editUuid = null;

$(function(){
	$.post("getRulesTypeInfo",{},function(result) {
		setRulesTypeIdInfo(result.obj, "query");
	},"json").error(function(e) {
		Modal_Alert('规则集管理','加载数据失败');
	});
	
	postData = {name:'', rulesTypeId: queryRulesTypeId.val()};
	getAllRecord();
});

$(document).ready(function() { 
	$(".ui-jqgrid-sortable").hover(function() {
	    $(this).css("color", "#547EA8");
	},
	function(){
		$(this).css("color", "#ffffff");
	});
});

var colNames = [ '','序号','名称', '生效开始时间','生效结束时间','预置条件','状态','编辑用户','编辑时间','备注','操作'];
var colModel = [
            	{
            		name:'uuid',
            		width:0, 
            		hidden:true,
            		sortable:false
            	},{
            		name:'index',
            		width:5,
            		sortable:false
            	},{
            		name:'name',
            		width:8,
            		sortable:false
            	},{
            		name:'startTime',
            		width:12,
            		sortable:false,
            		formatter:'date',
            		formatoptions:{srcformat: 'Y-m-d H:i:s', newformat: 'Y-m-d'}
            	},
            	{
            		name:'endTime',
            		width:12,
            		sortable:false,
            		formatter:'date',
            		formatoptions:{srcformat: 'Y-m-d H:i:s', newformat: 'Y-m-d'}
            	},{
            		name:'preconditions',
            		width:20,
            		sortable:false
            	},{
            		name:'state',
            		width:5,
            		sortable:false,
            		formatter:function(cellvalue, options, rowObject){
            			if(cellvalue==1){
            				return '<span color="green">生效</span>';
            			} else if(cellvalue==0){
            				return '<span color="red">失效</span>';  
            			} else {
            				return '';
            			}
            		}
            	},{
            		name:'updateByName',
            		width:10,
            		sortable:false
            	},{
            		name:'updateTime',
            		width:13,
            		sortable:false
            	},{
            		name:'remark',
            		width:10,
            		sortable:false
            	},{
            		name:'action',
            		width:10,
            		sortable:false,
            		formatter:function(cellvalue, options, rowObject){
            			var button = "";
                   		button += '<a href="javascript:void(0)" onclick="editFun(\''+rowObject.uuid+'\')"><span style="font-size:13px;">编辑</span></a>&nbsp;&nbsp;';
                   		if(rowObject.userGroupNameSet != '' && rowObject.userGroupNameSet != null) {
               	        	button += '<a href="javascript:void(0)" onclick="Modal_Alert(\'规则集管理\',\'' + rowObject.userGroupNameSet + '\');">查看用户组</a>'
                   		}
                   		return button;
            		}
            	}
            ];

/** -- 回车查询 -- */
function enterSearch(e) {
	var e = e || window.event; 
	var code = e.keyCode||e.which||e.charCode;
	if(code == 13){
		search();
	} 
}

/** -- 查询条件 -- */
function search() {
	jQuery(grid_selector).clearGridData();
	postData = {name:queryName.val(), rulesTypeId: queryRulesTypeId.val()};
	jQuery(grid_selector).setGridParam({  
        datatype:'json',  
        postData:postData, //发送数据  
    }).trigger("reloadGrid");
}
     
/** -- 获取分页列表 -- */
function getAllRecord(){
	var height = $(".tab-content").height()-34-58-30;
	
	jQuery(grid_selector).jqGrid({
		subGrid : true,
		subGridRowExpanded: function(subgrid_id, row_id) {  // (2)子表格容器的id和需要展开子表格的行id，将传入此事件函数  
			var data = jQuery(grid_selector).jqGrid('getRowData',row_id);

			var subgrid_table_id = subgrid_id + "_t";  // (3)根据subgrid_id定义对应的子表格的table的id 
	        var subgrid_pager_id = subgrid_id + "_pgr";  // (4)根据subgrid_id定义对应的子表格的pager的id 
	        // (5)动态添加子报表的table和pager  
	        $("#" + subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll'></table><div id='"+subgrid_pager_id+"' class='scroll'></div>");  
	        // (6)创建jqGrid对象  
	        $("#" + subgrid_table_id).jqGrid({  
	        	url: "getRuleByRulesId?uuid="+data.uuid,  // (7)子表格数据对应的url，注意传入的id参数  
	            datatype: "json",  
	            colNames: ['','序号','名称','规则类型','结果类型','值'],  
	            colModel: [ 
	                       {
	                    		name: 'uuid',
	                    		width: 10,
	                    		hidden: true,
	                    		sortable:false,
	                       }, {
	                    		name: 'index',
	                    		width: 10,
	                    		sortable:false,
	                       }, {
	                    	    name: 'name',
	                    	    width: 20,
	                    	    sortable:false,
	                       }, {
	                    	    name: 'ruleTypeName',
	                    	    width: 20,
	                    	    sortable:false
	                       }, {
	                    	    name: 'resultType',
	                    	    width: 15,
	                    	    sortable:false,
	                    	    formatter:function(cellValue, options, rowObject) {
	                    	    	if(cellValue == 0) {
	                    	    		return "正常";
	                    	    	} else if(cellValue == 1) {
	                    	    		return "警告";
	                    	    	} else if(cellValue == 2) {
	                    	    		return "违规";
	                    	    	} else if(cellValue == 3) {
	                    	    		return "重大违规";
	                    	    	}
	                    	    	return "";
	                    	    }
	                       }, {
		                   		name:'value',
		                		width:35,
		                		sortable:false,
		                		formatter:function(cellvalue, options, rowObject){
		                			if(rowObject.equalValue != null &&
		                					rowObject.equalValue != '') {
		                				return rowObject.equalValue;
		                			} else {
		                				var value = '';
		                				if(rowObject.minValue != null && 
		                						rowObject.minValue != '') {
		                					value = "最小值为" + rowObject.minValue;
		                					
		                					if(rowObject.ruleTypeType == 6) {
			                					value += "分钟";
			                				}
		                				}
		                				if(rowObject.maxValue != null && 
		                						rowObject.maxValue != '') {
		                					if(value != '') {
		                						value += ",";
		                					}
		                					value += "最大值为" + rowObject.maxValue;
		                					
		                					if(rowObject.ruleTypeType == 6) {
			                					value += "分钟";
			                				}
		                				}
		                				
		                				return value;
		                			}
		                		}
	                	   }
                ],  
                loadComplete : function() {
        	       var ids = jQuery("#" + subgrid_table_id).jqGrid('getDataIDs');
        	       for(var i=0;i < ids.length;i++){
        	    	   jQuery("#" + subgrid_table_id).jqGrid('setRowData',ids[i],{index:i+1});
        	       } 
        		},
                autowidth: true
	       	});  

		},  
		subGridOptions : {
			plusicon  : "ace-icon fa fa-plus  center bigger-110 blue",  //加号样式
			minusicon : "ace-icon fa fa-minus center bigger-110 blue", //减号样式
			openicon  : "ace-icon fa fa-chevron-right center orange",  //展开后左边按钮样式 
			reloadOnExpand :false                                      //只第一次向后台发起请求
		},
		url:"./dataGrid",
		datatype: "json",
		postData:postData,
		height: height, //表格高度
		colNames:colNames,    
		colModel:colModel, 
		viewrecords : true,
		rowNum:10,//默认行数
		rowList:[10,20,30],
		pager : pager_selector, //分页器
		pagerpos : "left",
		//loadtext:'数据加载中',
		loadComplete : function(resp) {
			var rowNum = parseInt($(this).getGridParam("records"), 10);  
			if (rowNum <= 0) {  
				Modal_Alert("提醒消息","没有数据");
			}  
			
			var ids = jQuery(grid_selector).jqGrid('getDataIDs');
			for(var i=0;i < ids.length;i++){
				jQuery(grid_selector).jqGrid('setRowData',ids[i],{index:i+1});
			} 
		},
		autowidth: true,
		sortable: false
	});
}

/** -- jqgrid相关事件 - start -- */
$(window).on('resize.jqGrid', function () {
	$(grid_selector).jqGrid('setGridWidth', $(".tab-content").width());
});

var parent_column = $(grid_selector).closest('[class*="col-"]');
$(document).on('settings.ace.jqGrid' , function(ev, event_name, collapsed) {
	if( event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed' ) {
		//setTimeout is for webkit only to give time for DOM changes and then redraw!!!
		setTimeout(function() {
			$(grid_selector).jqGrid('setGridWidth', parent_column.width() );
		}, 0);
	}
});

$(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size

$(document).one('ajaxloadstart.page', function(e) {
	$(grid_selector).jqGrid('GridUnload');
	$('.ui-jqdialog').remove();
});
/** -- jqgrid相关事件 - end -- */

/** -- 添加页面 -- */
function addFun() {
	editUuid = null;
	openIFrame();
}

/** -- 编辑页面 -- */
function editFun(uuid) {
	editUuid = uuid;
	openIFrame();
}

function getEditUuid() {
	return editUuid;
}

/** -- 开启IFrame -- */
function openIFrame() {
	document.getElementById("myIFrame").src = "addPage";
	setTimeout(function(){$("#myIFrame").animate({top:"0%"},1000)},400);
}

/** -- 关闭IFrame -- */
function clearIFrame() {
	$("#myIFrame").animate({top:"100%"},1000);
}

/** -- 填充页面规则集类型信息 -- */
function setRulesTypeIdInfo(rulesTypeList, prefix) {
	var html = "";
	var obj = null;
	for(var i=0;i<rulesTypeList.length;i++) {
		obj = rulesTypeList[i];
		html += "<option value='" + obj.id + "'>" + obj.text + "</option>";
	}
	$("#" + prefix + "RulesTypeId").html(html);
}
</script>
</html>