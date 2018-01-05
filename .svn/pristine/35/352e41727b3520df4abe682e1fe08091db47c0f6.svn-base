<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!---登入表单的布局 --->
<%String basePath=request.getContextPath();%>
<html>
	<head>
        <title>添加自动质检规则</title>
        <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/ace/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/ace/font-awesome.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/ace/ace-fonts.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/ace/ace.css" class="ace-main-stylesheet" id="main-ace-style" />  
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/ace/datepicker.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/button.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/select2/select2.css">
		<!--[if lte IE 9]>
			<link rel="stylesheet" href="<%=basePath%>/css/ace/ace-part2.css" class="ace-main-stylesheet" />
		<![endif]-->
		
		<!--[if lte IE 9]>
		  <link rel="stylesheet" href="<%=basePath%>/css/ace/ace-ie.css" />
		<![endif]-->
		
		
		<!-- ace settings handler -->
		<script src="<%=basePath%>/js/jquery-1.11.1.min.js"></script>	
		<script src="<%=basePath%>/js/ace/jquery.dataTables.js"></script>
		<script src="<%=basePath%>/js/ace/jquery.dataTables.bootstrap.js"></script>
		<script src="<%=basePath%>/js/ace/ace-extra.js"></script>
		<script src="<%=basePath%>/js/ace/respond.js"></script>
		<script src="<%=basePath%>/js/ace/bootstrap.js"></script>
		<script src="${ctx }/js/select2/select2.js"></script>
		
		<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->
		
		<!--[if lte IE 8]>
		<script src="<%=basePath%>/js/ace/html5shiv.js"></script>
		<script src="<%=basePath%>/js/ace/respond.js"></script>
		<![endif]-->
<script type="text/javascript">
/**
 * 添加搜索信息
 */
var nowDataTable;
var ipRowNum = 1;
$(function(){
	$("#myModal").on('show.bs.modal', function (e) {  
	    $(this).find('.modal-dialog').css({  
	  	  	height: 'auto'
	    });      
	}); 
});
function addSeatWords(){
	$("#myModal").modal();
 	$("#myModal input[type=text]").val('');
	var html = '<tr><td>名称&nbsp;&nbsp;<input name="wordsName" type="text" style="width:150px;height:25px;" ><br/><br/>内容&nbsp;&nbsp;<textarea name="wordsContent" style="width:95%;height:180px;"></textarea></td></tr>';
	$('#ipTable').html(html);
	ipRowNum = 1;
}

function addRow(){
	ipRowNum++;
	var flag = 'wordsRowTr'+ ipRowNum;
	var html = "<tr id='"+flag+"'><td>名称&nbsp;&nbsp;<input name='wordsName' type='text' style='width:150px;height:25px;' ><br/><br/>内容&nbsp;&nbsp;<textarea name='wordsContent' style='width:95%;height:180px;'></textarea>";
	html += "<div align='right'><button type='button' class='btn btn-info btn-xs' onclick='removeRow("+ipRowNum+");'>删除</button></div>	</td></tr>";
	$('#ipTable').append(html);
}
//删除行
function removeRow(rowNum){
	$('#wordsRowTr'+rowNum).remove();
}

function saveWords(){
	$('#saveButton').attr("disabled", true);
	var wordsNameObject = $("input[name='wordsName']");
	var wordsContentObject = $("textarea[name='wordsContent']");
	var wordsNameStr = "";
	var wordsContentStr = "";
	for(var i=0;i<wordsNameObject.length;i++){
		wordsNameStr = wordsNameStr + wordsNameObject[i].value + "☆";
	}
	for(var i=0;i<wordsContentObject.length;i++){
		wordsContentStr = wordsContentStr + wordsContentObject[i].value + "☆";
	}
	if(wordsNameStr.length>0){
		wordsNameStr = wordsNameStr.substr(0,wordsNameStr.length-1);
	}
	if(wordsContentStr.length>0){
		wordsContentStr = wordsContentStr.substr(0,wordsContentStr.length-1);
	}
	$.post('<%=basePath%>' + '/autoRule/qucikAdd', 
			{queryAutoRulesId:$("#queryAutoRulesId").val(),wordsName:wordsNameStr,wordsContent:wordsContentStr}, 
			function (data) {
				var errorResult =data;
				if(errorResult.success){
					Modal_Alert('操作提示','操作成功!');
				}else{
					Modal_Alert('错误提示','操作失败：'+data.msg);
				}
				$('#saveButton').attr("disabled", false);
			},
			"json").error(function() { 
				$('#saveButton').attr("disabled", false);
				Modal_Alert('错误提示','操作失败：'+data.msg);
	});
}
function goAutoRuleBack(){
	location.href = "<%=basePath%>/autoRule/manager";
}

$(function(){
	$.post("../autoRule/getAutoRules",{},function(result) {
		setAutoRulesInfo(result.obj, "query");
		queryAutoRulesId = $("#queryAutoRulesId").val();
		$(".dataTables_scrollBody").css("overflow-x","auto");
		placeHolderBug();
		$(".dataTables_scrollHeadInner").find("table").css("width","100%");
		 $(".dataTables_scrollBody").find("table").css("width","100%");
	},"json").error(function(e) {
		Modal_Alert('自动质检规则集管理','加载数据失败');
	});
});
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
/** -- 填充页面规则集类型信息 -- */
function setAutoRulesInfo(autoRulesList, prefix) {
	
	$("#"+prefix+"AutoRulesId").select2({
		minimumResultsForSearch: -1,
		data:autoRulesList
	});
}


</script>
</head>
<body class="no-skin" style="background-color: #EFF3F8;">
	<div style="height:40px;">
		<div  style="position: absolute;width:100%;padding: 10px;">
					&nbsp;<button style="width:100px;position:fixed;left:100px;" type="button" class="btn btn-info btn-sm" onclick="addRow()"><b>+</b>添加一条</button>
		</div>
			<div id="scoll_overflow" style="padding: 40px;overflow: auto;position: absolute;top: 40px;bottom: 0px;width: 100%" >
				<div class="form-group" >
					<div class="col-sm-9">
						<table>
							<tr>
								<td>
	       							<font style="font-size:14px;font-family: Micosoft YaHei; color:#88878B;">
											&nbsp;&nbsp;所属规则集：
									</font>
	       						</td>
				       			<td>
				       				<select id="queryAutoRulesId" name="queryAutoRulesId" class="select" style=" min-width: 70px; "></select>
				       			</td>
							</tr>
						</table>
					</div>
					<br/><br/><br/>
					<label id="passw2" class="col-sm-1 control-label no-padding-right"> 质检规则 </label>
					<div class="col-sm-11">
						<div class="row">
						<div class="col-sm-11" >
		                 <table id="ipTable" class="table table-striped table-bordered table-hover" >
		            		<tr>
		            			<td>名称&nbsp;&nbsp;<input name="wordsName" type="text" style="width:150px;height:25px;" ><br/><br/>内容&nbsp;&nbsp;<textarea name="wordsContent" style="width:95%;height:180px;"></textarea>
		            			</td>
		                	</tr>
		            	</table>
		            	</div>
		            	<div class="col-sm-1" align="left">
		            	
						</div>
						</div>
						<div  class="row" align="right">
						<div class="col-sm-11" >
							<button class="btn btn-info btn-sm" type="button" id="saveButton" onclick="saveWords()">
							<i class="ace-icon fa fa-check bigger-110"></i>
							保 存
						</button>
						&nbsp;&nbsp;
						<button class="btn btn-sm" type="reset" onclick="goAutoRuleBack()">
							<i class="ace-icon fa fa-undo bigger-110"></i>
							返 回
						</button>
						</div>
						</div>
					</div>
	         </div>
        </div>
</body>
</html>
