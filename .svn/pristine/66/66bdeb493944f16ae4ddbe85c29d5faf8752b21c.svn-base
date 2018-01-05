<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>录音Flash</title>
	
	<link rel="stylesheet" href="${ctx }/css/ace/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
	
	<script src="${ctx }/js/jquery-1.11.1.min.js"></script>	
	<script src="${ctx }/js/ace/bootstrap.js"></script>
	<script type="text/javascript" src="${ctx }/js/tool.js"></script>
	<script type="text/javascript" src="${ctx }/js/voice/audioSearch.js"></script>
	<script type="text/javascript" src="${ctx }/js/voice/audioCommon.js"></script>
	<script type="text/javascript" src="${ctx }/js/voice/parseTransFile.js"></script>
	
	<style>
		td{
		border:solid 0.5px #add9c0;
		margin:0px;
		padding:0px;
		
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

<body style="height:100%; width:100%; padding:0px; margin:0px;">
<div style="padding:0px;">
	<object
	    classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
	     type="application/x-shockwave-flash"
	    width="${width}" height="${height}" id="audioPlayer"
	    align="middle">
	    <param name="movie" value="${ctx }/js/voice/audioPlayer.swf?random=${time}" />
	    <param name="quality" value="high" />
	    <param name="bgcolor" value="#000000" />
	    <param name="play" value="true" />
	    <param name="loop" value="true" />
	    <param name="wmode" value="window" />
	    <param name="scale" value="showall" />
	    <param name="allowScriptAccess" value="always" />
	    <!--[if !IE]>-->
	    <object type="application/x-shockwave-flash"
	        data="${ctx }/js/voice/audioPlayer.swf?random=${time}"
	        id="audioPlayer_no_ie" width="${width}" height="${height}">
	        <param name="movie" value="${ctx }/js/voice/audioPlayer.swf?random=${time}" />
	        <param name="quality" value="high" />
	        <param name="bgcolor" value="#000000" />
	        <param name="play" value="true" />
	        <param name="loop" value="true" />
	        <param name="wmode" value="window" />
	        <param name="scale" value="showall" />
	        <param name="allowScriptAccess" value="always" />
	    </object>
	    <!--<![endif]-->
	</object>
		    </object>
</div>


<!-- <div style="height:100px;width:860px;overflow:auto;margin-top:5px">
	<table style="width:100%;height:100%" class="table table-striped table-bordered table-hover dataTable no-footer" id="analyzeData">
                   		<thead>
                   			<tr style="background-color:#417AB2;">
                   				<th style="width:240px;height:30px;background-color:#5CACDF;color:rgb(236,238,237);text-align:center" >规则名称</th>
                   				<th style="width:240px;height:30px;background-color:#5CACDF;color:rgb(236,238,237);text-align:center" >规则短语</th>
                   				<th style="width:240px;height:30px;background-color:#5CACDF;color:rgb(236,238,237);text-align:center" >命中语句</th> 
                   			</tr>
    					</thead> 
			   			<tbody id="tbodySearch">
			   			</tbody> 
                    </table>
</div> -->
<div class="lrcBlock" id="lrcContent" style="overflow-y:auto;width:99.7%;height:373px;top:17px;border:1px solid #B3D4E7"></div>
</body>
<script>
var uuid = '${uuid}';
var width='${width}';
$(function(){
	$("#lrcContent").html("");
	
	//拉取对应录音文件及trans文件等
	setTimeout(function(){openPlayer(uuid);},1000);
	//getAnalyzeData();
});


</script>
</html>



