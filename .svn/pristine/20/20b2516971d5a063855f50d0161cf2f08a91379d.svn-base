<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>录音Flash</title>

<link rel="stylesheet" href="${ctx }/css/ace/ace.css"
	class="ace-main-stylesheet" id="main-ace-style" />

<script src="${ctx }/js/jquery-1.11.1.min.js"></script>
<script src="${ctx }/js/ace/bootstrap.js"></script>
<script type="text/javascript" src="${ctx }/js/tool.js"></script>
<script type="text/javascript" src="${ctx }/js/voice/audioSearch.js"></script>
<script type="text/javascript" src="${ctx }/js/voice/audioCommon.js"></script>
<script type="text/javascript" src="${ctx }/js/voice/parseTransFile.js"></script>

<style>
td {
	border: solid 0.5px #add9c0;
	margin: 0px;
	padding: 0px;
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

<body
	style="height: 100%; width: 98%; padding: 0px; margin-left: 18px;">
	<div id="voiceContainer">
		<div style="float: left; font-size: 22px;">录音流水号&nbsp&nbsp</div>
		<div style="float: left">
			<select id="voiceIdSelect" style="width: 250px; height: 30px"
				class="select">
			</select>
		</div>
	</div>

	<div style="padding-top: 45px; padding-bottom: 5px; padding-left: 0px;">
		<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
			type="application/x-shockwave-flash" width="1220px" height="137px"
			id="audioPlayer" align="middle">
			<param name="movie"
				value="${ctx }/js/voice/audioPlayer.swf?random=${time}" />
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
				id="audioPlayer_no_ie" width="860px" height="137px">
				<param name="movie"
					value="${ctx }/js/voice/audioPlayer.swf?random=${time}" />
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


	<div class="lrcBlock" id="lrcContent"
		style="overflow-y: auto; width: 1200px; height: 520px; top: 15px; border: 1px solid #B3D4E7">
	</div>
</body>



<script>
	//var uuid = '${uuid}';
	var voiceIds = '${voiceIds}';
	var select = '${select}';
	
	
	//处理voiceIds串
	var reData = voiceIds.split(",");
	var voiceIdSelect = $("#voiceIdSelect");
	voiceIdSelect.find("option").remove();
	for ( var i = 0; i < reData.length; i++) {
		var voiceId = reData[i];
		if(select==i){
			voiceIdSelect.append("<option selected value='" +i+ "'>" + voiceId
				+ "</option>");
		}else{
			voiceIdSelect.append("<option value='" + i + "'>" + voiceId
					+ "</option>");
		}
	}
	//页面加载完成
	$(function(){
		pullVoiceInfo();
	}); 
	
	//添加change事件 
	
	voiceIdSelect.change(function() {
		var select = $('#voiceIdSelect option:selected').val();
		var voices = "${voiceIds}"+","+'${platForm}';
		window.location.href="${ctx }/flashWidget?voices=" + voices+"&select="+select;
	});
	
	
</script>

<script>
	function pullVoiceInfo() {
		
		
		var uuid = $('#voiceIdSelect option:selected').text();
		var platForm =  '${platForm}';
		$("#lrcContent").html("");
		
		//拉取对应录音文件及trans文件等
		setTimeout(function() {
			
			var isOk = openPlayer(uuid,platForm);
			if(!isOk){
				
				alert("文件加载失败！");  
			}
		}, 1000);
		
	};
	
</script>

</html>



