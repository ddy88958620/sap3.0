<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!---登入表单的布局 --->
<html>
    <head>
        <title>规则集添加</title>
        <link rel="stylesheet" type="text/css" href="${ctx }/css/ace/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="${ctx }/css/ace/font-awesome.css">
        <link rel="stylesheet" type="text/css" href="${ctx }/css/ace/ace-fonts.css">
        <link rel="stylesheet" type="text/css" href="${ctx }/css/ace/ace-skins.css">
        <link rel="stylesheet" href="${ctx }/css/ace/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
        <link rel="stylesheet" type="text/css" href="${ctx }/css/datetimepicker/bootstrap-datetimepicker.min.css">
        <link rel="stylesheet" type="text/css" href="${ctx }/css/button.css">
        <link rel="stylesheet" type="text/css" href="${ctx }/css/select2/select2.css">
        <link rel="stylesheet" type="text/css" href="${ctx }/css/zTree/metroStyle/metroStyle.css">
        <!-- ace settings handler -->
        <script src="${ctx }/js/jquery-1.11.1.min.js"></script> 
        <script src="${ctx }/js/ace/jquery.dataTables.js"></script>
        <script src="${ctx }/js/ace/bootstrap.js"></script>
        <script src="${ctx }/js/ace/ace-extra.js"></script>
        <script src="${ctx }/js/ace/ace-elements.js"></script>
        <script src="${ctx }/js/ace/fuelux/fuelux.wizard.js"></script>
        <script src="${ctx }/js/ace/ace.js"></script>
        <script src="${ctx }/js/select2/select2.js"></script>
        <script src="${ctx }/js/respond.min.js"></script>
        <script src="${ctx }/js/ace/ace/elements.treeview.js"></script>
        
        <!-- datetimepicker -->
        <script src="${ctx }/js/ace/date-time/bootstrap-datepicker.js"></script>
        <script src="${ctx }/js/datetimepicker/bootstrap-datetimepicker.js"></script>
        <script src="${ctx }/js/datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"></script>
        <script src="${ctx }/js/windowResize.js"></script>
        <!-- jquery validate -->
        <script src="${ctx }/js/ace/jquery.validate.js"></script>
    	
    	<style type="text/css">
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
    	.rulesInfoHead {
    		color: #657ba0;
    		font-weight: bold;
    	}
    	.rulesInfoBody {
    		font-weight: bold;
    		float: left;
    	}
    	</style>
    	
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

<body class="no-skin" onkeydown="enter()" id="myBody">
	<!-- #section:basics/navbar.layout -->
	<div class="widget-box" style="border:0px;">
    	<div class="widget-header widget-header-blue widget-header-flat" style="border-bottom:2px solid #d5e3ef;">
        	<h4 class="widget-title lighter">
            	<i class="ace-icon fa fa-hand-o-right"></i>添加规则集
            </h4>
            <!-- 
            <button type="button" style="float:right; border:none; background-color:transparent;" onclick="closeWindow()">
            	<i class="ace-icon fa fa-remove bigger-240"></i>
            </button>
             -->
            <button onclick="closeWindow()" type="button" class="btn btn-danger btn-sm" 
            	style="width:70px; height:25px; float:right; border:0px; margin-top:6px; margin-right:7px;">
            	<i class="ace-icon fa fa-remove bigger-110" style=""></i>取消
            </button>
    	</div>

	    <div class="widget-body">
	    	<div class="widget-main">
	            <!-- #section:plugins/fuelux.wizard -->
	            <div id="fuelux-wizard-container">
	                <div>
	                    <!-- #section:plugins/fuelux.wizard.steps -->
	                    <ul class="steps">
	                        <li data-step="1" class="active">
	                            <span class="step">1</span>
	                            <span class="title">基本信息</span>
	                        </li>
	
	                        <li data-step="2">
	                            <span class="step">2</span>
	                            <span class="title">生效范围</span>
	                        </li>
	
	                        <li data-step="3">
	                            <span class="step">3</span>
	                            <span class="title">规则维护</span>
	                        </li>
	
	                        <li data-step="4">
	                            <span class="step">4</span>
	                            <span class="title">信息预览</span>
	                        </li>
	                    </ul>
	                    <!-- /section:plugins/fuelux.wizard.steps -->
	                </div>
	
	                <hr />
	
	                <!-- #section:plugins/fuelux.wizard.container -->
	                <div class="step-content pos-rel">
	                    <div class="step-pane active" data-step="1">
	                        <h3 class="lighter block green">规则集基本信息</h3>
	
	                        <form class="form-horizontal " id="basicForm">
	                            <!-- #section:elements.form.input-state -->
	                            <div class="form-group has-info">
	                                <label class="col-xs-12 col-sm-4 control-label no-padding-right">名称</label>
	
	                                <div class="col-xs-12 col-sm-2">
	                                	<input id="name" name="name" placeholder="请输入规则集名称" class="width-100" type="text" style="color:#000000;"/>
	                                </div>
	                            </div>
	                            <div class="form-group has-info">
	                            	<label class="col-xs-12 col-sm-4 control-label no-padding-right">所属类别</label>
	
                                	<div class="col-xs-12 col-sm-8">
	                                    <select class="input-medium" id="rulesTypeId" name="rulesTypeId" style="color:#000000;" onchange="changeRulesTypeId()">
	                                    </select>
	                                </div>
	                            </div>
	                            <div class="form-group has-info">
	                            	<label class="col-xs-12 col-sm-4 control-label no-padding-right">备注</label>
	
	                                <div class="col-xs-12 col-sm-5">
	                                	<textarea id="remark" name="remark" rows="3" class="input-xlarge" style="width:100%; color:#000000;"></textarea>
	                                </div>
	                            </div>
	                        </form>
	                    </div>
	
	                    <div class="step-pane" data-step="2">
 							<h3 class="lighter block green">生效范围</h3>
	
	                        <form class="form-horizontal" id="effectFrom" style="overflow-y:auto; overflow-x:hidden; height:280px;">
	                         	<div class="form-group has-info">
	                                <label class="col-xs-12 col-sm-3 control-label no-padding-right">生效开始时间</label>
	
	                                <div class="col-xs-12 col-sm-3">
	                                	<input id="startTime" name="startTime" placeholder="请输入生效开始时间" class="width-100" type="text" readonly style="cursor:pointer;color:#000000;"/>
	                                </div>
	                                <div class="col-xs-12 col-sm-1">
	                                	<input type="button" onclick="clearTime('startTime')" class="btn btn-primary" value="清除" style="border:0px;"/>
	                                </div>
	                            </div>
	                            <div class="form-group has-info">
	                                <label class="col-xs-12 col-sm-3 control-label no-padding-right">生效结束时间</label>

	                                <div class="col-xs-12 col-sm-3">
	                                	<input id="endTime" name="endTime" placeholder="请输入生效结束时间" class="width-100" type="text" readonly style="cursor:pointer;color:#000000;"/>
	                                </div>
	                                <div class="col-xs-12 col-sm-1">
	                                	<input type="button" onclick="clearTime('endTime')" class="btn btn-primary" value="清除" style="border:0px;"/>
	                                </div>
	                            </div>
	                            <div class="form-group has-info">
	                                <label class="col-xs-12 col-sm-3 control-label no-padding-right">生效用户组</label>
	
	                                <div class="col-xs-12 col-sm-6">
	                                	<input id="userGroupNameSet" name="userGroupNameSet" placeholder="请选择生效用户组(默认为全部用户组)" class="width-100" type="text" style="color:#000000;"/>
	                                    <input id="userGroupSet" name="userGroupSet" type="hidden" />
	                                </div>
	                                <div class="col-xs-12 col-sm-1">
	                                	<input type="button" onclick="selectUserGroupSetFun()" class="btn btn-primary btn-purple" value="选择" style="border:0px;"/>
	                                </div>
	                            </div>
	                            <!-- #section:elements.form.input-state -->
	                            <div class="form-group has-info">
	                            	<label class="col-xs-12 col-sm-3 control-label no-padding-right">预置条件</label>
	
	                                <div class="col-xs-12 col-sm-6">
	                                	<textarea id="preconditions" name="preconditions" rows="4" class="input-xlarge" style="width:100%; color:#000000;"></textarea>
	                                </div>
	                            </div>
	                        </form>
	                    </div>
	
	                    <div class="step-pane" data-step="3">
	                        <h3 class="lighter block green">
	                        	规则维护
	                        	<input type="button" onclick="addRuleFun()" class="btn btn-primary" value="添加" style="border:0px; float:right;"/>
	                        </h3>
	                        <div style="overflow-y:auto; overflow-x:hidden; height:280px;">
	                        	<table style="width:100%;">
	                        		<thead>
	                        			<tr>
	                        				<th style="width:10%;" class="ruleTh">序号</th>
	                        				<th style="width:20%;" class="ruleTh">名称</th>
	                        				<th style="width:10%;" class="ruleTh">所属规则类型</th>
	                        				<th style="width:10%;" class="ruleTh">质检结果类型</th>
	                        				<th style="width:30%;" class="ruleTh">值</th>
	                        				<th style="width:20%;" class="ruleTh">操作</th>
	                        			</tr>
					    			</thead> 
					    			<tbody id="tbody">
					    			</tbody> 
	                        	</table>
	                        </div>
	                    </div>
	
	                    <div class="step-pane" data-step="4">
	                        <div class="center" style="height:246px;">
	                        	<!-- #section:elements.tab -->
								<div class="tabbable">
									<ul class="nav nav-tabs" id="myTab">
										<li class="active">
											<a data-toggle="tab" href="#home">
												<i class="blue ace-icon fa fa-home bigger-120"></i>
												基础信息
											</a>
										</li>
	
										<li>
											<a data-toggle="tab" href="#messages">
												<i class="green ace-icon fa fa-leaf bigger-120"></i>
												规则信息
											</a>
										</li>
									</ul>
	
									<div class="tab-content">
										<div id="home" class="tab-pane fade in active" style="height:244px; overflow-y:auto; overflow-x:hidden;">
											<table style="width:100%; margin-top:10px;">
												<tbody>
													<tr>
														<td class="rulesInfoHead" align="right" width="12%">规则集名称：</td>
														<td id="nameInfo" class="rulesInfoBody"></td>
													</tr>
													<tr>
														<td class="rulesInfoHead" align="right">所属规则级类别：</td>														
														<td id="rulesTypeIdInfo" class="rulesInfoBody"></td>
													</tr>
													<tr>
														<td class="rulesInfoHead" align="right">备注：</td>
														<td id="remarkInfo" class="rulesInfoBody"></td>
													</tr>
													
													<tr>
														<td class="rulesInfoHead" align="right">生效开始时间：</td>
														<td id="startTimeInfo" class="rulesInfoBody"></td>
													</tr>
													<tr>
														<td class="rulesInfoHead" align="right">生效结束时间：</td>
														<td id="endTimeInfo" class="rulesInfoBody"></td>
													</tr>
													<tr>
														<td class="rulesInfoHead" align="right">生效用户组：</td>
														<td id="userGroupNameSetInfo" class="rulesInfoBody"></td>
													</tr>
													<tr>
														<td class="rulesInfoHead" align="right">预置条件：</td>
														<td id="preconditionsInfo" class="rulesInfoBody"></td>
													</tr>
												</tbody>
											</table>
										</div>
	
										<div id="messages" class="tab-pane fade" style="height:244px; overflow-y:auto; overflow-x:hidden;">
											<table style="width:100%; margin-top:10px;">
				                        		<thead>
				                        			<tr>
				                        				<th style="width:10%;" class="ruleTh">序号</th>
				                        				<th style="width:20%;" class="ruleTh">名称</th>
				                        				<th style="width:20%;" class="ruleTh">所属规则类型</th>
				                        				<th style="width:20%;" class="ruleTh">质检结果类型</th>
				                        				<th style="width:30%;" class="ruleTh">值</th>
				                        			</tr>
								    			</thead> 
								    			<tbody id="tbodyInfo">
								    			</tbody> 
				                        	</table>
										</div>
									</div>
								</div>
								<!-- #section:elements.tab -->
	                        </div>
	                    </div>
	                </div>
	
	                <!-- /section:plugins/fuelux.wizard.container -->
	            </div>
	
	            <hr />
	            <div class="wizard-actions">
	                <!-- #section:plugins/fuelux.wizard.buttons -->
	                <button class="btn btn-prev">
	                    <i class="ace-icon fa fa-arrow-left"></i>
	                                                                                             上一步
	                </button>
	
	                <button class="btn btn-success btn-next" data-last="保存">
	                                                                                             下一步
	                    <i class="ace-icon fa fa-arrow-right icon-on-right"></i>
	                </button>
	
	                <!-- /section:plugins/fuelux.wizard.buttons -->
	            </div>
	
	            <!-- /section:plugins/fuelux.wizard -->
	        </div><!-- /.widget-main -->
	    </div><!-- /.widget-body -->
	</div>
	
	<!-- 选择用户组modal -->
 	<div class="modal fade" id="selectUserGroupSetModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    	<div class="modal-dialog">
      		<div class="modal-content" style="width:620px;">
         		<div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
		                  &times;
		            </button>
		            <h4 class="modal-title" id="myModalLabel" style="text-align:center;margin-top:0;font-size:22px;color:#429af1;letter-spacing: 1.5px;width:150px">
		              	生效用户组
		            </h4>
         		</div>
         		<div class="modal-body" id="modal-body" align="center" >
         			<div id="selectUserGroupSetDiv"></div>
         		</div>
       			<hr style="color:#d0d0d0;margin:0"/>
            	<div align="center" style="padding-left:30px; padding-right:10px; padding-bottom:15px;">
		            <button id="selectUserGroupSetButton" onclick="selectUserGroupSet()" type="button" class="btn btn-info btn-sm" style="width:75px;height:30px;margin-right:15px"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
		            <button type="reset" class="btn btn-sm" data-dismiss="modal" style="width:75px;height:30px;margin-right:25px"><i class="ace-icon fa fa-undo bigger-110" ></i>取消</button>
		        </div>
      		</div>
      	</div>
	</div>
	
	<!-- 添加&编辑规则modal -->
 	<div class="modal fade" id="ruleModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    	<div class="modal-dialog">
      		<div class="modal-content" style="width:620px;">
         		<div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
		                  &times;
		            </button>
		            <h4 class="modal-title" id="myModalLabel" style="text-align:center;margin-top:0;font-size:22px;color:#429af1;letter-spacing: 1.5px;width:150px">
		              	规则维护
		            </h4>
         		</div>
         		<div class="modal-body" id="modal-body" align="center" >
         			 <table style="width:100%;">
         			 	<tr>
		                  <td style="width:30%; color:#657ba0; padding-right:15px;" align="right"><label class="control-label no-padding-right">规则名称</label></td>
		                  <td>
	                  	  		<input id="ruleName" name="ruleName" placeholder="请输入规则名称" class="width-40" type="text" style="color:#000000; border-color:#72aec2; height:30px;"/>
		                  </td>
		                </tr>
		                
                		<tr style="line-height:40px;">
		                  <td style="width:30%; color:#657ba0; padding-right:15px;" align="right"><label class="control-label no-padding-right">规则类型</label></td>
		                  <td>
	                  	  		<select class="input-medium" id="ruleTypeId" name="ruleTypeId" style="color:#000000; border-color:#72aec2;" onchange="changeRuleType()">
                            	</select>
                            	<input id="ruleId" name="ruleId" type="hidden" value=""/>
                            	<input id="ruleNumber" name="ruleNumber" type="hidden" value=""/>
		                  </td>
		                </tr>
		                
		                <tr style="line-height:30px;">
		                  <td style="width:30%; color:#657ba0; padding-right:15px;" align="right"><label class="control-label no-padding-right">质检结果</label></td>
		                  <td>
	                  	  		<select class="input-medium" id="resultType" name="resultType" style="color:#000000; border-color:#72aec2;">
	                  	  			<option value="0" selected>正常</option>
	                  	  			<option value="1">警告</option>
	                  	  			<option value="2">违规</option>
	                  	  			<option value="3">重大违规</option>
                            	</select>
		                  </td>
		                </tr>
		                
		                <tr style="line-height:40px;">
		                  <td style="width:30%; color:#657ba0; padding-right:15px;" align="right"><label class="control-label no-padding-right" id="ruleValueTextDiv"></label></td>
		                  <td id="ruleValueDiv" style="line-height:normal;">
		                  </td>
		                </tr>
            		 </table>
         		</div>
       			<hr style="color:#d0d0d0;margin:0"/>
            	<div align="center" style="padding-left:30px; padding-right:10px; padding-bottom:10px;">
		            <button id="ruleButton" onclick="rule()" type="button" class="btn btn-info btn-sm" style="width:75px;height:30px;margin-right:15px"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
		            <button type="reset" class="btn btn-sm" data-dismiss="modal" style="width:75px;height:30px;margin-right:25px"><i class="ace-icon fa fa-undo bigger-110" ></i>取消</button>
		        </div>
      		</div>
      	</div>
	</div>
	
	<!-- 删除规则modal -->
	<div class="modal fade" id="deleteRuleModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
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
		        <div class="modal-body" id="hint" align="center">
		      		   确定要删除当前资源？
		        </div>
		        <input id="deleteId" name="deleteId" type="hidden" />
	        	<hr style="margin-bottom: 10px;"/>
			  	<div align="center" style="padding-right: 0px;padding-bottom: 0px; padding-bottom: 15px;">
					<button id="deleteRuleButton" onclick="deleteRule()" type="button" class="btn btn-info btn-sm"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
		            <button type="reset" class="btn btn-sm" data-dismiss="modal"><i class="ace-icon fa fa-undo bigger-110"></i>取消</button>
		        </div>
      		</div>
		</div>
	</div>

<!-- <![endif]-->

<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='../assets/js/jquery1x.js'>"+"<"+"/script>");
</script>
<![endif]-->

<!-- inline scripts related to this page -->
<script type="text/javascript">
$(function(){
	initForm();
});

var rules = new Object();

var ruleTypeArray = new Array();
var ruleArray = new Array();
var tagArray = new Array();
var flag = false;
var id = 0;
var flagOpt = false;

function clearTime(id) {
	$("#" + id).val("");
}

function closeWindow() {
	window.parent.clearIFrame();
	window.parent.search();
}

function selectUserGroupSetFun() {
	var userGroupSet = $("#userGroupSet").val();
	
	$('input[name="userGroupSetCheckbox"]').each(function(){
		if(userGroupSet.indexOf($(this).val()) >= 0) {
			$(this).checked;
		}
	});
	
	$("#selectUserGroupSetModal").modal("show");
}

function addRuleFun() {
	flagOpt = true;
	createWidget();
	$("#ruleModal").modal("show");
}

function editRuleFun(_id) {
	flagOpt = false;
	var rule = ruleArray[_id];
	setModalData(rule);
	$("#ruleModal").modal("show");
}

function deleteRuleFun(_id) {
	$("#deleteId").val(_id);
	$("#deleteRuleModal").modal("show");
}

function selectUserGroupSet() {
	var userGroupSet = "";
	var userGroupNameSet = "";
	$('input[name="userGroupSetCheckbox"]:checked').each(function(){
		userGroupSet += $(this).val() + ",";
		userGroupNameSet += $(this).parent().text() + ",";
	});
	if(userGroupSet.length > 0) {
		userGroupSet = userGroupSet.substr(0, userGroupSet.length - 1);
		userGroupNameSet = userGroupNameSet.substr(0, userGroupNameSet.length - 1);
	}
	
	$("#userGroupSet").val(userGroupSet);
	$("#userGroupNameSet").val(userGroupNameSet);
	
	$("#userGroupNameSetInfo").html(userGroupNameSet);
	
	$("#selectUserGroupSetModal").modal("hide");
}

function rule() {
	if(flagOpt) {
		for(var i=0; i<ruleArray.length; i++) {
			if($("#ruleName").val() == ruleArray[i].name) {
				Modal_Alert('规则集管理','规则名称重复，请重新输入！');
				return;
			}
		}
		
		var obj = getRuleType($("#ruleTypeId").val());
		var rule = getModalData(obj);
		rule.id = id++;
		rule.number = rule.id + 1;
		
		if(!validateRule(rule)) {
			return;
		}
		
		ruleArray[ruleArray.length] = rule;
		setData(rule);
		clearModalData(rule);
	} else {
		for(var i=0; i<ruleArray.length; i++) {
			if($("#ruleName").val() == ruleArray[i].name 
					&& $("#ruleId").val() != ruleArray[i].id) {
				Modal_Alert('规则集管理','规则名称重复，请重新输入！');
				return;
			}
		}
		
		var obj = getRuleType($("#ruleTypeId").val());
		var rule = getModalData(obj);
		rule.id = $("#ruleId").val();
		rule.number = $("#ruleNumber").val();
		
		if(!validateRule(rule)) {
			return;
		}

		ruleArray[rule.id] = rule;
		updateData(rule);
		clearModalData(rule);
		$("#ruleModal").modal("hide");
	}
}

function deleteRule() {
	var deleteId = $("#deleteId").val();

	ruleArray.splice(deleteId, 1);
	$("#tbody").html("");
	id = 0;
	
	var html = "";	
	for(var i=0;i<ruleArray.length;i++) {
		ruleArray[i].id = id++;
		ruleArray[i].number = ruleArray[i].id + 1;
		
		html += "<tr id='tr" + ruleArray[i].id + "'>";
		html += createRuleHtml(ruleArray[i]);
		html += "</tr>";
	}
	$("#tbody").html(html);

	$("#deleteRuleModal").modal("hide");
}

/** -- 规则维护页面数据控制 -- */
function setData(rule) {
	var html = "<tr id='tr" + rule.id + "'>";
	
	html += createRuleHtml(rule);
	
	html += "</tr>";
	$("#tbody").html($("#tbody").html() + html);
}

function updateData(rule) {
	$("#tr" + rule.id).html(createRuleHtml(rule));
}

function createRuleHtml(rule) {
	var html = "";

	html += '<td class="ruleTd">' + rule.number + '</td>';
	html += '<td class="ruleTd">' + rule.name + '</td>';
	html += '<td class="ruleTd">' + rule.ruleTypeName + '</td>';
	html += '<td class="ruleTd">' + rule.resultTypeName + '</td>';
	html += '<td class="ruleTd">' + getRuleValue(rule) + '</td>';
	
	html += '<td class="ruleTd"><a href="javascript:void(0)" onclick="editRuleFun(\'' + rule.id + '\')">编辑</a>&nbsp;&nbsp;' + 
			'<a href="javascript:void(0)" onclick="deleteRuleFun(\'' + rule.id + '\')">删除</a></td>';
	
	return html;
}

function getRuleValue(rule) {
	var value = "";
	if(rule.type == '2') {
		value = "最小值为" + rule.minValue + ",最大值为" + rule.maxValue;
	} else if(rule.type == '3'){
		value = rule.equalValueText;
	} else if(rule.type == '0' || rule.type == '1' || rule.type == '4'){
		value = rule.equalValue;
	} else if(rule.type == '6') {
		value = "最小值为" + rule.minValue + "分钟,最大值为" + rule.maxValue + "分钟";
	}   else if(rule.type == '5') {
		value = "开始时间为" + rule.minValue + ",结束时间为" + rule.maxValue;
	} 
	return value;
}

function clearModalData(rule) {
	$("#ruleName").val("");
	if(rule.type == '2' || rule.type == '6'  || rule.type == '5' ) {
		$("#minValue").val("");
		$("#maxValue").val("");
	} else if(rule.type == '0' || rule.type == '4'){
		$("#equalValue").val("");
	} else if(rule.type == '1'){
		for(var i=0;i<tagArray.length;i++) {
			$("#" + tagArray[i]).remove();
		}
		tagArray = new Array();
	} else if(rule.type == '3') {
		$('input[name="equalValue"]:checked').each(function(){
			$(this).attr("checked", false);
		});
	}
}

function setModalData(rule) {
	$("#ruleId").val(rule.id);
	$("#ruleNumber").val(rule.number);
	
	$("#ruleName").val(rule.name);
	$("#resultType").val(rule.resultType);
	$("#ruleTypeId").val(rule.ruleTypeId);
	
	createWidget();
	
	if(rule.type == '2' || rule.type == '6'  || rule.type == '5' ) {
		$("#minValue").val(rule.minValue);
		$("#maxValue").val(rule.maxValue);
	} else if(rule.type == '0' || rule.type == '4'){
		$("#equalValue").val(rule.equalValue);
	} else if(rule.type == '1'){
		tagArray = rule.equalValue.split(",");
		for(var i=0;i<tagArray.length;i++) {
			createTag(tagArray[i]);
		}
	} else if(rule.type == '3') {
		$('input[name="equalValue"]').each(function(){
			if(rule.equalValue.indexOf($(this).val()) >= 0) {
				$(this).attr("checked", true);
			}
		});
	}
}

function getModalData(obj) {
	var rule = new Object();
	
	rule.ruleTypeId = $("#ruleTypeId").val();
	rule.resultType = $("#resultType").val();
	rule.name = $("#ruleName").val();
	
	rule.type = obj.type;
	rule.ruleTypeName = obj.text;
	rule.resultTypeName = $('select[name="resultType"]').get(0).options[$("#resultType").get(0).selectedIndex].text;
	
	if(obj.type == '0') {
		rule.equalValue = $("#equalValue").val();
	} else if(obj.type == '1') {
		var s = "";
		for(var i=0;i<tagArray.length;i++) {
			s += tagArray[i];
			if(i!=tagArray.length - 1) {
				s += ",";
			}
		}
		rule.equalValue = s;
	} else if(obj.type == '2' || obj.type == '6'  || obj.type == '5' ) {
		rule.minValue = $("#minValue").val();
		rule.maxValue = $("#maxValue").val();
	} else if(obj.type == '3') {
		var s = "";
		var sText = "";
		$('input[name="equalValue"]:checked').each(function(){
			s += $(this).val() + ",";
			sText += $(this).parent().text() + ",";
		});
		if(s.length > 0) {
			s = s.substr(0, s.length - 1);
			sText = sText.substr(0, sText.length - 1);
		}
		rule.equalValue = s;
		rule.equalValueText = sText;
	} else if(obj.type == '4') {
		rule.equalValue = $("#equalValue").val();
	}
	
	return rule;
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

/** -- select响应事件 -- */
function changeRuleType() {
	createWidget();
	tagArray.splice(0, tagArray.length);
}

function changeRulesTypeId() {
	$("#rulesTypeIdInfo").html($('select[name="rulesTypeId"]').get(0).options[$("#rulesTypeId").get(0).selectedIndex].text);
}

/** -- 规则维护添加页面根据规则类型创建控件 -- */
function createWidget() {
	var obj = getRuleType($("#ruleTypeId").val());
	
	var ruleValueTextDiv = $("#ruleValueTextDiv");
	var html = "";
	if(obj.type == '0') {
		ruleValueTextDiv.html("值");
   		html += '<input id="equalValue" name="equalValue" placeholder="请输入值"' + 
   			' class="width-100" type="text" style="color:#000000; height:30px; border-color:#72aec2;"/>';
	} else if(obj.type == '1') {
		ruleValueTextDiv.html("值列表");
		html += '<div class="tags" style="border-color:#72aec2; max-height:100px; overflow-y:auto; overflow-x:hidden; width:300px; margin-top:5px;">' + 
				'<div id="tags"></div><input id="equalValue" ' + 
				'name="equalValue" type="text" placeholder="请输入关键字..." ' +
				'onkeydown="enterSearch()"></div>';
	} else if(obj.type == '2') {
		ruleValueTextDiv.html("从");
		html += '<input id="minValue" name="minValue" placeholder="最小值" class="width-30" style="height:30px; border-color:#72aec2;" type="text"/>' + 
				'<label class="control-label no-padding-right" style="color:#657ba0;">&nbsp;&nbsp;至&nbsp;&nbsp;</label>' + 
				'<input id="maxValue" name="maxValue" placeholder="最大值" class="width-30" style="height:30px; border-color:#72aec2;" type="text"/>';
	} else if(obj.type == '3') {
		ruleValueTextDiv.html("值列表");
		var array = eval(obj.value);
		if(array != null && array.length > 0) {
			var width = 100 / (array.length <= 6 ? array.length : 6);
			
			var html = "<table style='width:100%;'><tr style='width:100%;'>";
			for(var i=0;i<array.length;i++) {
				if(i%6 == 0) {
					html += "</tr><tr style='width:100%;'>";
				}
				html += '<td width="' + width + '%" align="center"><input name="equalValue" type="checkBox" style="margin-left:0px;" value="' + array[i].id + '">' + array[i].text + '</input></td>';
			}
			html += "</tr></table>";
		} else {
			hmtl += '';
		}
	} else if(obj.type == '4') {
		ruleValueTextDiv.html("表达式");
		html += '<input id="equalValue" name="equalValue" placeholder="请输入值"' + 
			' class="width-100" type="text" style="color:#000000; height:30px; border-color:#72aec2;"/>';
	} else if(obj.type == '6') {
		ruleValueTextDiv.html("从");
		html += '<input id="minValue" name="minValue" placeholder="最小值" class="width-30" style="height:30px; border-color:#72aec2;" type="text"/>' + 
				'<label class="control-label no-padding-right" style="color:#657ba0;">&nbsp;&nbsp;至&nbsp;&nbsp;</label>' + 
				'<input id="maxValue" name="maxValue" placeholder="最大值" class="width-30" style="height:30px; border-color:#72aec2;" type="text"/>' + 
				'<label class="control-label no-padding-right" style="color:#657ba0;">&nbsp;&nbsp;(单位：分钟)</label>';
	}  else if(obj.type == '5') {
		ruleValueTextDiv.html("从");
		html += '<input id="minValue" name="minValue" placeholder="开始时间" class="width-30" style="height:30px; border-color:#72aec2;" type="text"/>' + 
				'<label class="control-label no-padding-right" style="color:#657ba0;">&nbsp;&nbsp;至&nbsp;&nbsp;</label>' + 
				'<input id="maxValue" name="maxValue" placeholder="结束时间" class="width-30" style="height:30px; border-color:#72aec2;" type="text"/>';
	}  
	
	$("#ruleValueDiv").html(html);
	 if(obj.type == '5') {
		initDateTimePicker("minValue");
		initDateTimePicker("maxValue");
	} 
}

/** -- 页面初始化 -- */
function initForm() {
	var uuid = window.parent.getEditUuid();
	
	initDateTimePicker("startTime");
	initDateTimePicker("endTime");
	
	var data = {};
	if(uuid != null) {
		data.uuid = uuid;
	}
	$.post("getFormInfo", data, function(result) {
		if(!result.success)
			return;
		
		initSelect(result.obj.rulesTypeList, "rulesTypeId");
		initSelect(result.obj.ruleTypeList, "ruleTypeId");
		initCheckBox(result.obj.userGroupList, "selectUserGroupSetDiv");
		
		initRuleType(result.obj.ruleTypeList);
		initRulesTypeIdInfo();
		
		if(uuid != null) {
			initData(result.obj.rules, result.obj.ruleList);
		}
	},"json").error(function(e) {
		Modal_Alert('规则集管理','加载数据失败');
	});
}

function initRuleType(array) {
	if(array == null || array.length <= 0) {
		return;
	}
	
	ruleTypeArray = array;
}

function initRulesTypeIdInfo() {
	changeRulesTypeId();
}

function initDateTimePicker(name) {
	$('#' + name).datetimepicker({
		format:"yyyy-mm-dd",
		minView:2,
		maxView:2,
		language:"zh-CN",
		
	    autoclose: true,
	    todayBtn:true ,
	    todayHighlight: true
	});
}

function initSelect(array, name) {
	if(array == null || array.length <= 0) {
		return;
	}
	
	var html = "";
	for(var i=0;i<array.length;i++) {
		html += "<option value='" + array[i].id + "'>" + array[i].text + "</option>";
	}
	$("#" + name).html(html);
}

function initCheckBox(array, name) {
	if(array == null || array.length <= 0) {
		return;
	}
	
	var width = 100 / (array.length <= 6 ? array.length : 6);
	
	var html = "<table style='width:100%;'><tr style='width:100%;'>";
	for(var i=0;i<array.length;i++) {
		if(i%6 == 0) {
			html += "</tr><tr style='width:100%;'>";
		}
		html += '<td width="' + width + '%" align="center"><input name="userGroupSetCheckbox" type="checkBox" style="margin-left:0px;" value="' + array[i].id + '">' + array[i].text + '</input></td>';
	}
	html += "</tr></table>";
	
	$("#" + name).html(html);
}

function initData(rules, ruleList) {
	$("#name").val(rules.name);
	$("#rulesTypeId").val(rules.rulesTypeId);
	$("#remark").val(rules.remark);
	
	$("#nameInfo").html(rules.name);
	$("#rulesTypeIdInfo").html(rules.rulesTypeName);
	$("#remarkInfo").html(rules.remark);
	
	$("#startTime").val(rules.startTime);
	$("#endTime").val(rules.endTime);
	$("#userGroupSet").val(rules.userGroupSet);
	$("#userGroupNameSet").val(rules.userGroupNameSet);
	$("#preconditions").val(rules.preconditions);
	
	$("#startTimeInfo").html(rules.startTime);
	$("#endTimeInfo").html(rules.endTime);
	$("#userGroupNameSetInfo").html(rules.userGroupNameSet);
	$("#preconditionsInfo").html(rules.preconditions);
	
	var rule = null, obj = null, array = null, text = null, valueArray = null;
	for(var i=0; i<ruleList.length; i++) {
		rule = new Object();
		
		rule.id = id++;
		rule.number = rule.id + 1;
		
		rule.ruleTypeId = ruleList[i].ruleTypeId;
		rule.resultType = ruleList[i].resultType;
		rule.name = ruleList[i].name;

		obj = getRuleType(ruleList[i].ruleTypeId);
		rule.type = obj.type;
		rule.ruleTypeName = ruleList[i].ruleTypeName;
			
		if(rule.resultType == '0') {
			rule.resultTypeName = '正常';
		} else if(rule.resultType == '1') {
			rule.resultTypeName = '警告';
		} else if(rule.resultType == '2') {
			rule.resultTypeName = '违规';
		} else if(rule.resultType == '3') {
			rule.resultTypeName = '重大违规';
		}
		
		if(rule.type == '2' || rule.type == '6'  || rule.type == '5' ) {
			rule.minValue = ruleList[i].minValue;
			rule.maxValue = ruleList[i].maxValue;
		} else if(rule.type == '3'){
			rule.equalValue = ruleList[i].equalValue;
			valueArray = rule.equalValue.split(",");
			
			array = eval(obj.value);
			text = '';
			if(array != null && array.length > 0) {
				for(var k=0;k<array.length;k++) {
					for(var j=0;j<valueArray.length;j++) {
						if(array[k].id = valueArray[j]) {
							text += array[k].text + ",";
						}
					}
				}
				
				if(text != '' && text.length > 0) {
					text = text.substring(0, text.length - 1);
				}
			}

			rule.equalValueText = text;
		} else {
			rule.equalValue = ruleList[i].equalValue;
		}

		setData(rule);
		ruleArray[i] = rule;
	}
}

/** -- 规则维护添加页面模糊查询控件 -- */
function enter(e) {
	enterSearch(e, 'no');	
}

function enterSearch(e, is) {
	var e = e || window.event; 
	var code = e.keyCode||e.which||e.charCode;
	if(code == 13){
		if(is == 'no') {
			e.preventDefault();
			return;
		}
		
		if(!flag) {
			flag = true;
			
			var value = $("#equalValue").val();
			
			value = stripScript(value);
			if(trim(value) == '') {
				Modal_Alert('规则集管理','输入不合法，请重新输入！');
				flag = false;
				return;
			}
			
			for(var i=0;i<tagArray.length;i++) {
				if(value == tagArray[i]) {
					$("#" + value).addClass("tag-warning");
					setTimeout("clearTagClass('" + value + "')",700);
					flag = false;
					return;
				}
			}
			
			tagArray[tagArray.length] = value;
			createTag(value);
			
			flag = false;
		} else {
			flag = false;
		}
	} 
}

function createTag(value) {
	var html = $("#tags").html();
	html += '<span class="tag" id="' + value + '">'+ value + 
		'<button type="button" class="close" onclick="clearTag(\'' + value +
		'\')">×</button></span>';
	$("#tags").html(html);
	
	$("#equalValue").val('');
}

function clearTagClass(value) {
	$("#" + value).removeClass("tag-warning");
}

function clearTag(value) {
	$("#" + value).remove();
	for(var i=0;i<tagArray.length;i++) {
		if(value == tagArray[i]) {
			tagArray.splice(i, 1);
			break;
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

/** -- 验证规则 -- */
function validateRule(rule) {
	if(isNull(rule.name, "规则名称", 1)) {
		return false;
	}
	if(isExceed(rule.name, 64, "规则名称")) {
		return false;
	}
	if(isNull(rule.ruleTypeId, "规则类型", 2)) {
		return false;
	}
	if(isExceed(rule.ruleTypeId, 32, '规则类型')) {
		return false;
	}
	if(isNull(rule.resultType, '质检结果类型', 2)) {
		return false;
	}
	if(rule.resultType != '0' && rule.resultType !='1' &&
			rule.resultType != '2' && rule.resultType != '3') {
		Modal_Alert('规则维护', '质检结果类型不合法');
		return false;
	}
	if(rule.type == '2' || rule.type == '6') {
		if(rule.minValue == null && rule.minValue == '' &&
				rule.maxValue == null && rule.maxValue == '') {
			Modal_Alert('规则维护', '请填写最小值或最大值');
			return false;
		}
		if(rule.minValue != null && rule.minValue != '') {
			if(isFloat(rule.minValue, '最小值')) {
				return false;
			}
		} else {
			if(isFloat(rule.maxValue, '最大值')) {
				return false;
			}
		}
	} else if(rule.type == '0' || rule.type == '1' 
			|| rule.type == '3' || rule.type == '4'){
		if(isNull(rule.equalValue, '值', 1)) {
			return false;
		}
		if(isExceed(rule.equalValue, 512, '值')) {
			return false;
		}
	}  else if(rule.type == '5') {
		if(rule.minValue == null && rule.minValue == '' &&
				rule.maxValue == null && rule.maxValue == '') {
			Modal_Alert('规则维护', '请填写开始时间或结束时间');
			return false;
		}
		if(rule.minValue != null && rule.minValue != '') {
			if(isTime(rule.minValue, '开始时间')) {
				return false;
			}
		} else {
			if(isTime(rule.maxValue, '结束时间')) {
				return false;
			}
		}
	} 
	return true;
}

/** -- 判断是否为空 -- */
function isNull(value, name, type) {
	if(value == null || value == '') {
		var prefix = '';
		if(type == 1) {
			prefix = '请填写';
		} else if(type == 2) {
			prefix = '请选择';
		}
		Modal_Alert('规则维护', prefix + name);
		return true;
	}
	return false;
}

/** -- 判断是否超过规定长度 -- */
function isExceed(value, length, name) {
	if(value.length > length) {
		Modal_Alert('规则维护', name + "过长");
		return true;
	}
	return false;
}

/** -- 判断是否为浮点数 -- */
function isFloat(value, name) {
	var reg = /^(-?\d+)(\.\d+)?$/;
//	var reg = new RegExp("");
	if(!reg.test(value)) {
		Modal_Alert('规则维护', name + "必须为数字");
		return true;
	}
	return false;
}

/** -- 判断是否为年月日时间格式 -- */
function isTime(value, name) {
	var reg = /^((((19|20)\d{2})-(0?[13-9]|1[012])-(0?[1-9]|[12]\d|30))|(((19|20)\d{2})-(0?[13578]|1[02])-31)|(((19|20)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|((((19|20)([13579][26]|[2468][048]|0[48]))|(2000))-0?2-29))$/;
	if(!reg.test(value)) {
		Modal_Alert('规则维护', name + "必须为日期格式");
		return true;
	}
	return false;
}

jQuery(function($) {
	$(".select2").css('width','200px').select2({allowClear:true})
		.on('change', function(){
			$(this).closest('form').validate().element($(this));
	}); 
		
	$('#fuelux-wizard-container')
		.ace_wizard({
			//step: 2 //optional argument. wizard will jump to step "2" at first
			//buttons: '.wizard-actions:eq(0)'
		})
		
		.on('actionclicked.fu.wizard' , function(e, info){
			var direction = info.direction;
			if(direction == 'previous') {
				return;
			}

			if(info.step == 1) {
				if(!$('#basicForm').valid()) {
					e.preventDefault();
				}
				
				rules.name = $("#name").val();
				rules.rulesTypeId = $("#rulesTypeId").val();
				rules.remark = $("#remark").val();
				
				$("#nameInfo").html(rules.name);
				$("#remarkInfo").html(rules.remark);
			} else if(info.step == 2) {
				if(!$('#effectFrom').valid()) {
					e.preventDefault();
				}
				if($('#startTime').val() != null && $('#startTime').val() != '' &&
						$('#endTime').val() != null && $('#endTime').val() != '') {
					if($('#startTime').val() > $('#endTime').val()) {
						Modal_Alert('生效范围', '开始时间不能大于结束时间');
						e.preventDefault();
					}
				}
				
				rules.startTime = $("#startTime").val();
				rules.endTime = $("#endTime").val();
				rules.userGroupSet = $("#userGroupSet").val();
				rules.preconditions = $("#preconditions").val();
				
				$("#startTimeInfo").html(rules.startTime);
				$("#endTimeInfo").html(rules.endTime);
				$("#preconditionsInfo").html(rules.preconditions);
			} else if(info.step == 3) {
				if(ruleArray.length <= 0) {
					Modal_Alert('规则维护', '规则不能为空，请添加规则!');
					e.preventDefault();
				}
				
				rules.ruleList = new Array();
				
				$("#tbodyInfo").html("");
				var html = "";
				
				var rule = null;
				for(var i=0; i<ruleArray.length; i++) {
					rule = new Object();
					
					rule.name = ruleArray[i].name;
					rule.ruleTypeId = ruleArray[i].ruleTypeId;
					rule.resultType = ruleArray[i].resultType;
					
					if(ruleArray[i].type == '2'
							|| ruleArray[i].type == '6'
							 || ruleArray[i].type == '5' ) {
						if(ruleArray[i].type == '2') {
							rule.equalValue = null;
							rule.minValue = ruleArray[i].minValue;
							rule.maxValue = ruleArray[i].maxValue;
						} else {
							rule.equalValue = null;
							rule.minValue = parseFloat(ruleArray[i].minValue) * 60 * 1000;
							rule.maxValue = parseFloat(ruleArray[i].maxValue) * 60 * 1000;
						}
					} else {
						rule.equalValue = ruleArray[i].equalValue;
						rule.minValue = null;
						rule.maxValue = null;
					}
					
					rules.ruleList[rules.ruleList.length] = rule;
					
					html += "<tr>";
					html += '<td class="ruleTd">' + ruleArray[i].number + '</td>';
					html += '<td class="ruleTd">' + ruleArray[i].name + '</td>';
					html += '<td class="ruleTd">' + ruleArray[i].ruleTypeName + '</td>';
					html += '<td class="ruleTd">' + ruleArray[i].resultTypeName + '</td>';
					html += '<td class="ruleTd">' + getRuleValue(ruleArray[i]) + '</td>';
					html += "</tr>";
				}
				
				$("#tbodyInfo").html(html);
			}
		})
		
		.on('finished.fu.wizard', function(e) {
			var data = JSON.stringify(rules);

			loadmask();
			$.post("add", {json : data}, function(result){
				disloadmask();
				var success = result.success;
				if(success) {
					closeWindow();
					window.parent.getAllRecord();
				} else {
					Modal_Alert('规则集管理', result.msg);
				}
			},"json").error(function(e) {
				disloadmask();
				Modal_Alert('规则集管理','通讯失败，请重新发起请求！');
			});
		})

		/*
		$.mask.definitions['~']='[+-]';
		$('#phone').mask('(999) 999-9999');
	
		
		jQuery.validator.addMethod("phone", function (value, element) {
			return this.optional(element) || /^\(\d{3}\) \d{3}\-\d{4}( x\d{1,6})?$/.test(value);
		}, "Enter a valid phone number.");
		*/
		
		$('#basicForm').validate({
			errorElement: 'div',
			errorClass: 'help-block',
			focusInvalid: false,
			ignore: "",
			rules: {
				name: {
					required: true,
					maxlength: 64
				},
				rulesTypeId: {
					required: true,
					maxlength: 32
				},
				remark: {
					required: false,
					maxlength: 128
				},
			},
	
			messages: {
				name: {
					required: "请填写规则集名称",
					maxlength: "规则集名称长度不能大于64个字符"
				},
				rulesTypeId: {
					required: "请选择规则集类型",
					maxlength: "规则集类型长度不能大于32个字符"
				},
				remark: {
					maxlength: "备注长度不能大于128个字符"
				}
			},
	
			highlight: function (e) {
				$(e).closest('.form-group').removeClass('has-info').addClass('has-error');
			},
	
			success: function (e) {
				$(e).closest('.form-group').removeClass('has-error').addClass('has-info');
				$(e).remove();
			},
	
			errorPlacement: function (error, element) {
				if(element.is('input[type=checkbox]') || element.is('input[type=radio]')) {
					var controls = element.closest('div[class*="col-"]');
					if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
					else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
				}
				else if(element.is('.select2')) {
					error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
				}
				else if(element.is('.chosen-select')) {
					error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
				}
				else error.insertAfter(element.parent());
			},
		});
		
		$('#effectFrom').validate({
			errorElement: 'div',
			errorClass: 'help-block',
			focusInvalid: false,
			ignore: "",
			rules: {
				startTime: {
					date:true
				},
				endTime: {
					date:true
				},
				userGroupSet: {
					maxlength: 1024
				},
				preconditions: {
			//		required: true,
					maxlength: 1024
				}
			},
	
			messages: {
				startTime: {
					date: "日期格式不正确"
				},
				endTime: {
					date: "日期格式不正确"
				},
				userGroupSet: {
					maxlength: "生效用户组长度不能大于1024个字符"
				},
				preconditions: {
			//		required: "请填写预置条件",
					maxlength: "预置条件长度不能大于1024个字符"
				}
			},
	
	
			highlight: function (e) {
				$(e).closest('.form-group').removeClass('has-info').addClass('has-error');
			},
	
			success: function (e) {
				$(e).closest('.form-group').removeClass('has-error').addClass('has-info');
				$(e).remove();
			},
	
			errorPlacement: function (error, element) {
				if(element.is('input[type=checkbox]') || element.is('input[type=radio]')) {
					var controls = element.closest('div[class*="col-"]');
					if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
					else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
				}
				else if(element.is('.select2')) {
					error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
				}
				else if(element.is('.chosen-select')) {
					error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
				}
				else error.insertAfter(element.parent());
			},
		});
		
		$('#modal-wizard-container').ace_wizard();
		$('#modal-wizard .wizard-actions .btn[data-dismiss=modal]').removeAttr('disabled');
});
</script>
</body>
</html>