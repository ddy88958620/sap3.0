<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!---登入表单的布局 --->
<html>
	<head>
        <title>成功单数据报表</title>
		<!-- bootstrap & fontawesome -->
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/font-awesome.css">
		<!-- 引入组件库 -->
		<script src="${ctx }/js/jquery-1.11.1.min.js"></script>
		<script src="${ctx }/js/ace/bootstrap.js"></script>
		<script type="text/javascript">
		
		$(function(){
			$("#submitButton").click(function(){
				var loadfile = $("#uploadFile").val();
				if(loadfile == null || loadfile == ""){
					Modal_Alert('上传导出','未选择上传文件，请重新选择！');
					return false;
				}
				$("#uploadForm").submit();
			});
			if("${errorMessage}" != null && "${errorMessage}"!=""){
				Modal_Alert('上传导出','${errorMessage}');
			}
		});
		
		</script>

</head>
<body style="background:#457FB8;text-align: center" >
	<div style="height:30%;width:700px;background:#f7f7f7;margin: auto;margin-top: 100px;border: 4px solid gray;border-radius: 15px;text-align: center">
		<form action="${ctx }/success/downZipFile" method="post"  enctype="multipart/form-data" id="uploadForm">
			<div class="modal-body" style="height:80%;width:60%;margin: 100px 100px 100px 170px;">
					类型：&nbsp;&nbsp;&nbsp;&nbsp;
 						<input type="radio" name="uploadFileType" id="optionsRadios1" value="voiceId" checked>
						&nbsp;&nbsp;流水号&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 						<input type="radio" name="uploadFileType" id="optionsRadios2" value="orderId">
						&nbsp;&nbsp;工单号&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						
						<br/><br/>
					
					文件：<input id="uploadFile" name="uploadFile" type="file" style="display: inline;"><br><br>
						<div style="text-align: center;" >
							<button type="button" class="btn btn-info btn-sm" style="z-index:1;" id="submitButton" >
								<span class="ace-icon fa fa-download icon-on-right bigger-110"></span>&nbsp;导出转写结果
							</button>&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
			</div>
		</form>
	</div>
</body>
</html>