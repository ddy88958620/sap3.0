<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
        <title>字段设置管理</title>
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
		.ruleTr{
			height:5px;
		}
		.ruleTh {
    		text-align:center; 
    		border:2px solid #dddddd; 
    		background-color:#eceeed; 
    		vertical-align: middle;
    		font-weight: bold;
    		height:5px;
    	}
    	.ruleTd {
    		text-align:center;
    		border:2px solid #dddddd; 
    		vertical-align: middle;
    		font-weight: bold;
    		height:5px;
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
		 	padding:5px;
			text-align:center;
	/* 		width:90px; */
			font-size:16px;
			/* color:#848484"; */	
			color:#88878C;	
		}
		
		.addTable .input{
			height:30px;
		/* 	width:300px; */
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
	<div style="position:absolute;top:0px;bottom:0px;left:0px;right:0px;height:100%;overflow-x:hidden;overflow-y:hidden;padding:10px;" >
		<div id="cesi" style="position:absolute;width:100%;left:30px">
			<table>
	       		<tr>
	       			<td>
	       				<a>
	       					<button type="button" id="add" class="btn btn-info btn-sm" style="z-index:1;" onClick="addFun()">
	       						<span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>&nbsp;添加
	       					</button>
	       				</a>
	       			</td>
	       			<!-- <td>
	       				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	       				<input id="queryData" name="queryData" class="input" type="text" onkeydown="enterSearch()"/>
	       			</td>
	       			<td>
	       				&nbsp;&nbsp;&nbsp;
	       				<a>
	       					<button type="button" id="search" class="btn btn-search btn-sm" style="z-index:1;" onClick="getAllRecord()">
	       						<span class="fa icon-on-right bigger-110"></span>&nbsp;查询
	       					</button>
	       				</a>
	       			</td> -->
	   			</tr>
	   		</table>
		</div>
		
		<!-- <div id="nowPosition" style="position:absolute;right:5px;top:15px;">
			<span class="label label-xlg label-yellow arrowed-in">当前位置：  
				<font  id="tabSelect">字段设置</font>
			</span>
		</div> -->

	    <div style="width:100%;top:45px;bottom:0px;position:absolute;height:100%;">
	       <div class="row" style="height:100%;">
		       <div class="col-sm-9 side"  style="height:100%;width:100%;padding-top:0px;padding-right: 10px;">
					<div class="tab-content" style="top:10px;bottom:0px;position:absolute;width:98%">
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

 	<!-- 添加modal -->
 	<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   		<div class="modal-dialog">
      		<div class="modal-content" style="width:460px;height:auto;">
         		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  		&times;
            		</button>
            		<h4 class="modal-title" id="myModalLabel" style="margin-top:0;font-size:22px;letter-spacing: 1.5px;width:100px">
              			添加字段
            		</h4>
         		</div>
         		<div class="modal-body" id="modal-body" align="center" style=" min-height: 0px; " >
        			<table id="addTable" class="addTable">
        				<tr style="width:100%;">
        					<td style=" padding-bottom: 0px; ">
        						<table>
        							<tr>
        								<td style="width:100px;">显示名称:</td>
		                  				<td style="width:230px;"><input id="addName" name="addName" placeholder="请输入显示名称" class="input" type="text" style="width:300px;" onkeyup="value=value.replace(/\s/g,'')"/></td>
        							</tr>
        							<tr>
        								<td>字段参数:</td>
		                  				<td><input id="addCode" name="addCode" placeholder="请输入字段参数" class="input" type="text" style="width:300px;" onkeyup="value=value.replace(/\s/g,'')"/></td>
        							</tr>
        						</table>
        					</td>
        				</tr>
        				<tr style="width:100%;">
        					<td colspan="2" style=" padding-top: 0px; ">
        						<table>
        							<tr>
        								<td style="width:98px;">取值类型:</td>
				                        <td style="width:300px;">
				                        	<select id="addType" class="select" style="width:300px;" onChange="typeChange('add')">
				                          	</select>
				                        </td>
        							</tr>
        							<tr class="emnu">
			                        	<td>枚举取值:</td>
			                        	<td><input id="aEqualValue" name="equalValue" type="text" placeholder="输入格式为  真实值:显示值，输入完成请按回车"  onkeydown="enterEnum('a')" style="text-align:left;width:300px;"></td>
			                        </tr>
			                        <tr class="emnu">
				                        <td>枚举预览:</td>
				                        <td>
				                        	<!-- <div id="aPreview" style="border:1px solid #87CEFA;width:300px;height:100px;overflow-y:auto;overflow-x:hidden;text-align: left;">
				                       		</div> -->
				                       		<div id="uPreview" style="overflow-y:auto;overflow-x:hidden;text-align: center;">
					                        	<table style="width:100%;">
					                        		<thead>
					                        			<tr>
					                        				<th style="width:30%;" class="ruleTh">真实值</th>
					                        				<th style="width:30%;" class="ruleTh">显示值</th>
					                        				<th style="width:30%;" class="ruleTh">操作</th>
					                        			</tr>
									    			</thead> 
									    			<tbody id="mbody">
									    			</tbody> 
					                        	</table>
					                        </div>
				                        </td>
			                        </tr> 
			                        <tr class="num">
                                        <td>单位:</td>
                                        <td><select id="anumberType" class="select" style="width:300px;">
                                            </select></td>
                                    </tr>
                                    <tr class="num">
                                        <td>最小值:</td>
                                        <td><input id="aminValue" name="minValue" type="text" placeholder="请输入取值范围的最小值，不填为不限制"  style="text-align:left;width:300px;"></td>
                                    </tr>
                                    <tr class="num">
                                        <td>最大值:</td>
                                        <td><input id="amaxValue" name="maxValue" type="text" placeholder="请输入取值范围的最大值，不填为不限制" style="text-align:left;width:300px;"></td>
                                    </tr>
        						</table>
        					</td>
        				</tr>
            		</table>
         		</div>
       			<hr style="color:#d0d0d0;margin-top:0;margin-bottom: 10px; "/>
            	<div align="right" style=" padding-right:42px; padding-bottom:22px;right: 0px;bottom: 0px;">
		            <button id="addButton" onclick="addRuleType()" type="button" class="btn btn-info btn-sm" style="margin-right:10px"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
		            <button type="reset" onclick="clearData()" class="btn btn-sm" data-dismiss="modal" ><i class="ace-icon fa fa-undo bigger-110" ></i>取消</button>
		        </div>
      		</div>
      	</div>
	</div>

	 <!-- 修改modal -->
	 <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	 	<div class="modal-dialog">
	    	<div class="modal-content" style="width:auto;height:auto;">
	        	<div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
		                  &times;
		            </button>
		            <h4 class="modal-title" id="myModalLabel" style="margin-top:0;font-size:22px;letter-spacing: 1.5px;width:100px">
		              	编辑
		            </h4>
	         	</div>
	         	<div class="modal-body" id="modal-body" align="center" >
	         		<table id="updateTable" class="addTable">
        				<tr style="width:100%;">
        					<td style=" padding-bottom: 0px; ">
        						<table>
        							<tr>
        								<td style="width:100px;">显示名称:</td>
		                  				<td style="width:230px;"><input id="updateName" name="updateName" placeholder="请输入规则类型名称" class="input" type="text" style="width:300px;" onkeyup="value=value.replace(/\s/g,'')"/></td>
        							</tr>
        							<tr>
        								<td>字段参数:</td>
		                  				<td><input id="updateCode" name="updateCode" placeholder="请输入宏命令" class="input" type="text" style="width:300px;" onkeyup="value=value.replace(/\s/g,'')"/></td>
        							</tr>
        						</table>
        					</td>
        					<!-- <td>
        						<table>
        							<tr>
			        					<td style="width:100px;">是否质检:</td>
			                          	<td style="width:100px;">
			                          		<select id="updateIsQuality" class="select" style="width:100px;">
					                            <option value ="0">否</option>
					                            <option value ="1">是</option>
			                          		</select>
			                          	</td>
                          			</tr>
        							<tr>
										<td>是否检索:</td>
			                          	<td>
			                          		<select id="updateIsSearch" class="select" style="width:100px;">
			                            		<option value ="0">否</option>
			                            		<option value ="1">是</option>
			                          		</select>
			                          	</td>
        							</tr>
        						</table>
        					</td> -->
        				</tr>
        				<tr style="width:100%;">
        					<td colspan="2" style=" padding-top: 0px; ">
        						<table>
        							<tr>
        								<td style="width:98px;">取值类型:</td>
				                        <td style="width:300px;">
				                        	<select id="updateType" class="select" style="width:300px;" onChange="typeChange('update')" disabled="disabled">
					                            <option value ="0">精确匹配</option>
					                            <option value ="4">模糊匹配</option>
                                                <option value ="1">全文匹配</option>
                                                <option value ="2">数值类型</option>
                                                <option value ="3">枚举类型</option>
                                                <option value ="5">时间范围</option>
				                          	</select>
				                        </td>
        							</tr>
        							<tr class="emnu">
			                        	<td>枚举取值:</td>
			                        	<td><input id="uEqualValue" name="equalValue" type="text" placeholder="请输入值，格式为     真实值:显示值"  onkeydown="enterEnum('u')" style="text-align:left;width:300px;"></td>
			                        </tr>
			                        <tr class="emnu">
				                        <td>枚举预览:</td>
				                        <td>
				                       		<div id="uPreview" style="overflow-y:auto;overflow-x:hidden;text-align: center;">
					                        	<table style="width:100%;">
					                        		<thead>
					                        			<tr>
					                        				<th style="width:30%;" class="ruleTh">真实值</th>
					                        				<th style="width:30%;" class="ruleTh">显示值</th>
					                        				<th style="width:30%;" class="ruleTh">操作</th>
					                        			</tr>
									    			</thead> 
									    			<tbody id="mbody">
									    			</tbody> 
					                        	</table>
					                        </div>
				                        </td>
			                        </tr> 
			                        <tr class="num">
                                        <td>单位:</td>
                                        <td><select id="unumberType" class="select" style="width:300px;">
                                            </select>
                                            </td>
                                    </tr>
                                    <tr class="num">
                                        <td>最小值:</td>
                                        <td><input id="uminValue" name="minValue" type="text" placeholder="请输入取值范围的最小值，不填为不限制"  style="text-align:left;width:300px; line-height: 17px; "></td>
                                    </tr>
                                    <tr class="num">
                                        <td>最大值:</td>
                                        <td><input id="umaxValue" name="maxValue" type="text" placeholder="请输入取值范围的最大值，不填为不限制" style="text-align:left;width:300px;line-height: 17px;"></td>
                                    </tr>
        						</table>
        					</td>
        				</tr>
            		</table>
	            	<input id="updateUuid" name="updateUuid" type="hidden" />
	         	</div>
	       		<hr style="color:#d0d0d0;margin-top:0;margin-bottom: 10px;"/>
	            <div align="center" style="padding-left: 55px; padding-right: 0px;padding-bottom: 22px;">
		            <button id="updateButton" onclick="updateRuleType()" type="button" class="btn btn-info btn-sm" style="margin-right:15px"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
		            <button type="reset" onclick="clearData()" class="btn btn-sm" data-dismiss="modal" style="margin-right:25px"><i class="ace-icon fa fa-undo bigger-110" ></i>取消</button>
		        </div>
	      	</div>
	    </div>
	 </div>
	 
</body>
<script type="text/javascript">
var flag = false;
var tagArray = new Array();
$(function(){
	getAllRecord();
}); 
var queryData = $("#queryData");
var nowDataTable = null;

var aoColumns = [
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
	                   "sTitle" : "显示名称", 
	                   "sWidth": "15%",
	                   "bVisible": true,
	                   "sDefaultContent" : "",  
	                   "sClass" : "center"  
                   },
                   {  
                       "mDataProp" : "code",  
                       "sTitle" : "字段参数", 
                       "sWidth": "20%",
                       "bVisible": true,
                       "sDefaultContent" : "",  
                       "sClass" : "center"  
                   },
	               {  
	                   "mDataProp" : "action",  
	                   "sTitle" : "操作", 
	                   "sWidth": "10%",
	                   "bVisible": true,
	                   "sDefaultContent" : "",  
	                   "sClass" : "center",
	                   "render": function (data, type, full, meta) {
	                   		var button = "";
	                   		button += '<a href="javascript:void(0)" onclick="editFun(\''+full.uuid+'\')">编辑</a>&nbsp;&nbsp;';
	               	        return button;
	              		}
                  	}
            ];

/** -- 回车查询 -- */
function enterSearch(e) {
	var e = e || window.event; 
	if(e.keyCode == 13){ 
		getAllRecord();
	} 
}

/** -- 查询条件 -- */
function addSearchInfo(aoData) {
	aoData.push({"name":"name","value":queryData.val()});
}

/** -- 获取分页列表 -- */
function getAllRecord() {
	var pageNum=$("#dataTable_length").find("select").val();
	if(nowDataTable != null) {
		nowDataTable.fnClearTable(0);
		nowDataTable.fnDestroy();
	}
	$("#thead").html("");
	$("#tbody").html("");
	
	var tabContent = $(".tab-content").height()-34-58-40;
	nowDataTable = $('#dataTable').dataTable({
		"bAutoWidth": false,	//for better responsiveness
		"bProcessing": true,
		"bServerSide": true,
		"showRowNumber":false,
        "bPaginate" : true,	//分页按钮
		"bLengthChange" : true,	//每页显示记录数
		"bSort" : false,	//排序
		"bInfo":true,
		"bStateSave":false, //是否开启cookies保存当前状态信息
		"iDisplayLength": pageNum,
		"sPaginationType": "full_numbers", //显示首页和尾页
	    "scrollY": tabContent,
	    "scrollX": $(".tab-content").width(),
		"order": [[ 0, 'asc' ]],
		"sAjaxSource": "../ruleType/dataGrid",	//请求内容为退一步请求的内容
		"aoColumns":aoColumns,
		"fnServerData": function (sSource, aoData, fnCallback) {
			addSearchInfo(aoData);
			
			loadmask();
			$.ajax({
				"dataType": 'json',
				"type": "POST",
				"url": sSource,
				"data": aoData,
				"success": function(resp) {
					disloadmask();
				 	if(resp.aaData!=null&&resp.aaData.length>0){
				 		for(var i=0;i<resp.aaData.length;i++){
				 			resp.aaData[i].index = i+1;
				 		}
				 	}
				    fnCallback(resp);   
				},
				"error": function(XMLHttpRequest, textStatus, errorThrown) {
					disloadmask();
					Modal_Alert('字段管理','加载数据失败');
				}
		 	});
		 }
	});
}
//IE低版本兼容HTML5 placeHolder属性
function placeHolderBug(){
	$("input").each(function(){
		if($(this).val()!=$(this).attr('placeholder')){
			$(this).css("color","#88878C");
		}else{
			$(this).css("color","#88878C");
		}
	});
	if(!placeholderSupport()){   // 判断浏览器是否支持 placeholder 
	    $('[placeholder]').focus(function() { 
	        var input = $(this); 
	        if (input.val() == input.attr('placeholder')) { 
	            input.val(''); 
	            input.removeClass('placeholder'); 
	            input.css("color","#88878C");
	        } 
	    }).blur(function() { 
	        var input = $(this); 
	        if (input.val() == '' || input.val() == input.attr('placeholder')) { 
	            input.addClass('placeholder'); 
	            input.val(input.attr('placeholder')); 
	            input.css("color","#88878C");
	        } 
	    }).blur(); 
	}; 
}
function placeholderSupport() { 
    return 'placeholder' in document.createElement('input'); 
}
/** -- 添加页面 -- */
function addFun(){
	var inputList=$("#addModal").find("input");
	for(var i=0;i<inputList.length;i++){
		inputList[i].value="";
	}
	var selectList=$("#addModal").find("select");
	for(var i=0;i<selectList.length;i++){
		$(selectList[i]).find("option").eq(0).attr("selected",true);
	}
	$("#aPreview").html("");
	$("#aEqualValue").val("");
	tagArray = new Array();
	$(".emnu").hide();
	$(".num").hide();
	$("#addModal").css({
		"position" : "absolute",
		"top" : "5%"
		// "left" : "5%"
	});
	$("#addModal").modal("show");
	initSelect("add");
	initUintSelect("a");
	placeHolderBug();
}

/** -- 编辑页面 -- */
function editFun(uuid){
	$("#uPreview").html("");
	$("#mbody").html("");
    $("#uEqualValue").val("");
    tagArray = new Array();
    $(".emnu").hide();
    $(".num").hide();
    $("input").val("");
	$("#updateModal").css
	({
		"position" : "absolute",
		"top" : "5%"
		// "left" : "5%"
	});
	$("#updateModal").modal("show");
 	
	$.post("../ruleType/loadById",{uuid:uuid},function(result){
		var ruleType = result.obj;
		$("#updateName").val(ruleType.name);
		$("#updateCode").val(ruleType.code);
		/* $("#updateIsSearch").val(ruleType.isSearch);
		$("#updateIsQuality").val(ruleType.isQuality); */
		$("#updateUuid").val(ruleType.uuid);
		$("#updateType").val(""+ruleType.valueType);
		if(ruleType.valueType==3){
			$(".emnu").show();
			var array = eval(ruleType.enumValue);
			for(var i=0;i<array.length;i++){
				setTag("u",array[i].text,array[i].id);
				var tag = {};
				tag.trueValue=array[i].id;
				tag.showValue=array[i].text;
				tagArray[i]=tag;
			}
		}
		if(ruleType.valueType==2){
			initUintSelect("u");
			$(".num").show();
			$("#unumberType").select2('val',parseInt(ruleType.numberType));
	        $("#uminValue").val(ruleType.minValue);
	        $("#umaxValue").val(ruleType.maxValue);
		}
		placeHolderBug();
		$("#updateModal").modal();

	},"json").error(function(e) {
		Modal_Alert('字段管理','加载数据失败');
	});
}

function initSelect(prefix){
	var typeArray = new Array();
	
	//取值类型拼接
	typeArray.push({'id':'0','text':'精确匹配'});
	typeArray.push({'id':'4','text':'模糊匹配'});
	typeArray.push({'id':'1','text':'全文匹配'});
	typeArray.push({'id':'2','text':'数值类型'});
	typeArray.push({'id':'3','text':'枚举类型'});
	typeArray.push({'id':'5','text':'时间日期'});
	
	$('#'+prefix+'Type').select2({
		minimumResultsForSearch: -1,
		data:typeArray
	});
	
	
}

//初始化单位选择控件
function initUintSelect(prefix){
	var unitArray = new Array();
	//单位拼接
	unitArray.push({'id':'0','text':'无单位'});
	unitArray.push({'id':'1','text':'个'});
	unitArray.push({'id':'2','text':'字/秒'});
	unitArray.push({'id':'10','text':'毫秒'});
	unitArray.push({'id':'11','text':'秒'});
	unitArray.push({'id':'12','text':'分钟'});
	unitArray.push({'id':'13','text':'小时'});
	$('#'+prefix+'numberType').select2({
		minimumResultsForSearch: -1,
		data:unitArray
	});
}

/** -- 添加规则类型 -- */
function addRuleType() {
	var data = new Object();
	data.name = $("#addName").val();
	data.code = $("#addCode").val();
	/* data.isSearch = $("#addIsSearch").val();
	data.isQuality = $("#addIsQuality").val(); */
	data.valueType = parseInt($("#addType").val());
	data.enumValue = "";
	data.maxValue =  $("#amaxValue").val();
	data.minValue =  $("#aminValue").val();
	data.numberType =  $("#anumberType").val();
	for(var i=0;i<tagArray.length;i++){
		var tag = tagArray[i];
		data.enumValue += '{"id":"'+tag.trueValue+'","text":"'+tag.showValue+'"},';
	}
	if(data.enumValue.length>0){
		data.enumValue = "["+data.enumValue.substring(0,data.enumValue.length-1)+"]";
	}
	if(!validation(data)) {
		return;
	}
	if(data.name==$("#addName").attr("placeholder")){
		Modal_Alert('字段设置', "请输入字段名称");
		return false;
	}
	if(data.code==$("#addCode").attr("placeholder")){
		Modal_Alert('字段设置', "请输入字段参数");
		return false;
	}
	if(data.maxValue==$("#amaxValue").attr("placeholder")){
		data.maxValue="";
	}
	if(data.minValue==$("#aminValue").attr("placeholder")){
		data.minValue="";
	}
	if(data.numberType==$("#anumberType").attr("placeholder")){
		data.numberType="";
	}
	loadmask();
	$.post("../ruleType/add", data, function(result){
		disloadmask();
		var success = result.success;
		if(success) {
			$("#addModal").modal("hide");
			getAllRecord();
		} else {
			Modal_Alert('字段管理', result.msg);
		}
	},"json").error(function(e) {
		disloadmask();
		Modal_Alert('字段管理','通讯失败，请重新发起请求！');
	});
}

/** -- 更新规则类型 -- */
function updateRuleType() {
	var data = new Object();
	data.name = $("#updateName").val();
    data.code = $("#updateCode").val();
	/* data.isSearch = $("#updateIsSearch").val();
	data.isQuality = $("#updateIsQuality").val(); */
    data.valueType = parseInt($("#updateType").val());
    data.numberType =  $("#unumberType").val();
    data.enumValue = "";
    data.maxValue =  $("#umaxValue").val();
    data.minValue =  $("#uminValue").val();
    for(var i=0;i<tagArray.length;i++){
        var tag = tagArray[i];
        data.enumValue += '{"id":"'+tag.trueValue+'","text":"'+tag.showValue+'"},';
    }
    if(data.enumValue.length>0){
        data.enumValue = "["+data.enumValue.substring(0,data.enumValue.length-1)+"]";
    }
	data.uuid = $("#updateUuid").val();
	if(data.name==$("#addName").attr("placeholder")){
		Modal_Alert('字段设置', "请输入字段名称");
		return false;
	}
	if(data.code==$("#addCode").attr("placeholder")){
		Modal_Alert('字段设置', "请输入字段参数");
		return false;
	}
	if(!validation(data)) {
		return;
	}
	if(data.maxValue==$("#amaxValue").attr("placeholder")){
		data.maxValue="";
	}
	if(data.minValue==$("#aminValue").attr("placeholder")){
		data.minValue="";
	}
	if(data.numberType==$("#anumberType").attr("placeholder")){
		data.numberType="";
	}
	if(data.uuid == null || data.uuid == '') {
		Modal_Alert('字段管理', "信息缺失，请重新操作！");
		return;
	}

	
	loadmask();
	$.post("../ruleType/edit", data, function(result){
		disloadmask();
		var success = result.success;
		if(success) {
			$("#updateModal").modal("hide");
			getAllRecord();
		} else {
			Modal_Alert('字段管理', result.msg);
		}
	},"json").error(function(e) {
		disloadmask();
		Modal_Alert('字段管理','通讯失败，请重新发起请求！');
	});
}

/** -- 验证 -- */
function validation(data) {
	if(data.name == null || data.name == '') {
		Modal_Alert('字段管理', "请填写显示名称");
		return false;
	}
	if(data.name.length > 64) {
		Modal_Alert('字段管理', "显示名称过长");
		return false;
	}
	if(data.code == null || data.code == '') {
        Modal_Alert('字段管理', "请填写字段参数");
        return false;
    }
    if(data.code.length > 256) {
        Modal_Alert('字段管理', "字段参数过长");
        return false;
    }
    if(data.valueType==3){
    	 if(data.enumValue == null || data.enumValue == '') {
    	        Modal_Alert('字段管理', "请填写字段参数枚举取值");
    	        return false;
    	    }
    	    if(data.enumValue > 512) {
    	        Modal_Alert('字段管理', "字段参数枚举取值过长");
    	        return false;
    	    }
    }
    if(data.valueType==2){
    	var reg = new RegExp("^[0-9]*$");  
        if(data.maxValue != null && data.maxValue != '') {
        	if(!reg.test(data.maxValue)){  
        		 Modal_Alert('字段管理', "最大值不是数字");
                 return false;
            } 
        	data.maxValue = parseInt(data.maxValue);
        }
        if(data.minValue != null && data.minValue != '') {
            if(!reg.test(data.minValue)){  
                 Modal_Alert('字段管理', "最小值不是数字");
                 return false;
            } 
            data.minValue = parseInt(data.minValue);
        }
        if(data.minValue>data.maxValue){
        	Modal_Alert('字段管理', "最小值不能大于最大值");
            return false;
        }
   }
   
	return true;
}

/** -- 规则维护添加页面模糊查询控件 -- */
function enter(e) {
	enterEnum(null,e, 'no');   
}

function enterEnum(aOrU,e, is) {
    var e = e || window.event; 
    var code = e.keyCode||e.which||e.charCode;
    var emnu={};
    if(code == 13){
        if(is == 'no') {
            e.preventDefault();
            return;
        }
        
        if(!flag) {
            flag = true;
            
            var value = $("#"+aOrU+"EqualValue").val();
            
            value = stripScript(value);
            if(trim(value) == '') {
                Modal_Alert('字段管理','输入不合法，请重新输入！');
                flag = false;
                return;
            }
            if(value.indexOf(":") <=0||value.indexOf(":") == (value.length-1)) {
                Modal_Alert('字段管理','输入格式不合法，请重新输入！');
                flag = false;
                return;
            }
            var split = value.split(":");
            emnu.trueValue = split[0];
            emnu.showValue = split[1];
            for(var i=0;i<tagArray.length;i++) {
                if(emnu.trueValue == tagArray[i].trueValue||emnu.showValue==tagArray[i].showValue) {
                    $("#tr" + tagArray[i].trueValue).css("backgroundColor",'#FFD39B');
                    setTimeout(function(){$("#tr" + tagArray[i].trueValue).css("backgroundColor","white");},1000);
                    flag = false;
                    return;
                }
            }
            tagArray[tagArray.length] = emnu;
            createTag(aOrU,emnu.showValue,emnu.trueValue);
            
            flag = false;
        } else {
            flag = false;
        }
    } 
}

/**--保存枚举型列表展示--*/
function createTag(aOrU,showValue,trueValue) {
    /* var html = '<div id='+trueValue+' style="width:298px;height:21px;" onClick="showClick(\''+showValue+'\',\''+trueValue+'\')" onmouseover="this.style.backgroundColor=\'#87CEFA\'" onmouseout="this.style.backgroundColor=\'#FFFFFF\'">&nbsp;&nbsp;'+showValue
    +'<button type="button" class="close" onclick="clearTag(\'' + trueValue +
    '\')">×</button></div>';
    $("#"+aOrU+"Preview").append(html);
    $("#"+aOrU+"EqualValue").val(''); */
    saveData(showValue,trueValue);
    $("#"+aOrU+"EqualValue").val('');
}

function setTag(aOrU,showValue,trueValue) {
	setData(showValue,trueValue);
	$("#"+aOrU+"EqualValue").val('');
}

/** -- 枚举信息保存列表 -- */
function saveData(showValue,trueValue) {
	var html = "<tr id='tr" + trueValue + "' class='ruleTr'>";
	html += createHtml(showValue,trueValue);
	html += "</tr>";
	$("#mbody").html($("#mbody").html() + html);
}

/** -- 编辑展示 -- */
function setData(showValue,trueValue) {
	var html = "<tr id='tr" + trueValue + "'>";
		html += '<td class="ruleTd">' + trueValue + '</td>';
		html += '<td class="ruleTd">' + showValue + '</td>';
		html += '<td class="ruleTd"><a href="javascript:void(0)" onclick="deleteTdFun(\'' + trueValue + '\')">删除</a></td>';
	
	html += "</tr>";
	$("#mbody").html($("#mbody").html() + html);
}

function createHtml(showValue,trueValue) {
	var html = "";

	html += '<td class="ruleTd">' + trueValue + '</td>';
	html += '<td class="ruleTd">' + showValue + '</td>';
	html += '<td class="ruleTd"><a href="javascript:void(0)" onclick="deleteTdFun(\'' + trueValue + '\')">删除</a></td>';
	
	return html;
}

/**-- 删除行数据 --*/
function deleteTdFun(value){
	$("#" + value).remove();
    for(var i=0;i<tagArray.length;i++) {
        if(value == tagArray[i].trueValue) {
            tagArray.splice(i, 1);
            break;
        }
    }
    $("#mbody").html("");
	
	var html = "";	
	for(var i=0;i<tagArray.length;i++) {
		html += "<tr id='tr" + tagArray[i].trueValue + "'>";
		html += createHtml(tagArray[i].showValue,tagArray[i].trueValue);
		html += "</tr>";
	}
	$("#mbody").html(html);
    return false;
}

/**--点击取消清除数据--*/
function clearData(){
	$("#mbody").val("");
	for(var i=0;i<tagArray.length;i++) {
		$("#" + tagArray[i].trueValue).remove();
	}
	tagArray = new Array();
}

function showClick(value,trueValue){
	 Modal_Alert('点击预览','点击的显示值为'+value+" 实际值为"+trueValue);
}

function clearTagClass(value) {
    $("#" + value).removeClass("tag-warning");
}

function clearTag(value) {
    $("#" + value).remove();
    for(var i=0;i<tagArray.length;i++) {
        if(value == tagArray[i].trueValue) {
            tagArray.splice(i, 1);
            break;
        }
    }
    event.stopPropagation();
    event.preventDefault();
    return false;
}

function trim(value){
    return value.replace(/(^\s*)|(\s*$)/g, "");
}

function stripScript(s) {
	var pattern = new RegExp("[`~!@#$%^&*()=|{}';',\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？]");
    var rs = "";
    for (var i = 0; i < s.length; i++) {
        rs = rs + s.substr(i, 1).replace(pattern, '');
    }
    return rs;
}

function typeChange(aOrU){
	var id = $("#"+aOrU+"Type").val();
	if(id=="3"){
		$(".emnu").show();
	}else{
		$(".emnu").hide();
	}
	if(id=="2"){
        $(".num").show();
    }else{
        $(".num").hide();
    }
}
</script>
</html>