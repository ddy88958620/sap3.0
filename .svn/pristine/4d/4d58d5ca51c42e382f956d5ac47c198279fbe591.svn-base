<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!---登入表单的布局 --->
<html>
	<head>
        <title>质检汇总报表</title>
        <link rel="stylesheet" type="text/css" href="${ctx }/css/ace/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/font-awesome.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/ace-fonts.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/ace-skins.css">
		<link rel="stylesheet" href="${ctx }/css/ace/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
		<link rel="stylesheet" type="text/css" href="${ctx }/css/button.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/select2/select2.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/js/jPlug/uploadify/uploadify.css">
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
			.uploadify-button{
		    	background:#AEEEEE;
		    	color: #666666;
		    }
		    .uploadify:hover .uploadify-button{
			    background:#BFEFFF;
		    }
			.bt{
				border-radius: 4px;
				background: #00C5CD 
			}
			.bt:hover{
				background:#AEEEEE;
				color:#666666;
			}
		</style>
		
		<!--[if lte IE 9]>
			<link rel="stylesheet" href="${ctx }/css/ace/ace-part2.css" class="ace-main-stylesheet" />
		<![endif]-->
		
		<!--[if lte IE 9]>
		  <link rel="stylesheet" href="${ctx }/css/ace/ace-ie.css" />
		<![endif]-->
		
		
		<!-- ace settings handler -->
		<script src="${ctx }/js/jquery-1.11.1.min.js"></script>	
	    <script src="${ctx }/js/ace/jquery.dataTables.js"></script>
		<script src="${ctx }/js/ace/bootstrap.js"></script>
        <script src="${ctx }/js/ace/jquery.dataTables.bootstrap.js"></script>
		<script src="${ctx }/js/ace/ace-extra.js"></script>
		<script src="${ctx }/js/ace/ace-elements.js"></script>
		<script src="${ctx }/js/ace/ace.js"></script>
		<script type="text/javascript" src="${ctx }/js/respond.min.js"></script>
		<script src="${ctx }/js/jPlug/uploadify/jquery.uploadify.min.js"></script>
		<script src="${ctx }/js/windowResize.js"></script>
		<script src="${ctx }/js/select2/select2.js"></script>
		<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->
		
		<!--[if lte IE 8]>
		<script src="${ctx }/js/ace/html5shiv.js"></script>
		<script src="${ctx }/js/ace/respond.js"></script>
		<![endif]-->
</head>
<body style="height:100%;weight:100%;background:#F7F7F7" >
<div style="position:absolute;top:0px;bottom:0px;left:0px;right:0px;height:100%;width:98%;padding:10px;" >
	<div style="height:50px; position: absolute;top: 0px; ">
		
			<table style="margin-left:10px;">
				<tr>
					<td style="width:64px;" align="right">
		   				<font style="font-size:14px; font-family:微软雅黑; color:#88878B;">
							用户组：
						</font>
		   			</td>
		   			<td style="width:125px" align="left">
		   				<select id="queryUserGroupId" name="queryUserGroupId" style="width:125px" class="select" onchange="reloadUserInfo()"></select>
		   			</td>
		   			<td style="width:54px;" align="right">
		   				<font style="font-size:14px; font-family:微软雅黑; color:#88878B;">
							坐席：
						</font>
		   			</td>
		   			<td style="width:135px" align="left">
		   				<select id="queryUserId" name="queryUserId" style="width:125px" class="select" ></select>
		   			</td>
					<td>
					<select id="voiceType" name ="voiceType" style="width:125px">
							<option value="0">PCM(8K16BIT)</option>
							<option value="1">VOX(6K4BIT)</option>
							<option value="2">VOX(8K4BIT)</option>
							<option value="3">ALAW(8K)</option>
							<option value="4">ULAW(8K)</option>
							<option value="5">GSM610</option>
							<option value="6">视频MOV</option>
							<option value="7">MP3</option>
							<option value="-1">WAV</option>
						</select>
					</td>
					<td style="padding-left:17px;padding-top:12px">
						<input type="file" id="file_upload" name="myfile"  class="btn btn-info btn-sm"/>
					</td>
					<td style="padding-left:10px;width:95px;padding-top:17px">
						<button type="button" id="startUpload" class="btn btn-info btn-sm"><span class="ace-icon fa  icon-on-right bigger-110"></span>&nbsp;开始上传</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
					<td style="padding-left:10px;width:95px">
						<button type="button" id="cancelAll" class="btn btn-info btn-sm"><span class="fa icon-on-right bigger-110"></span>&nbsp;全部取消</button>
					</td>
					<td style="padding-left:10px;width:95px">
						<button type="button" id="bathDelete" class="btn btn-info btn-sm" onclick="bathDelete();"><span class="fa icon-on-right bigger-110"></span>&nbsp;批量删除</button>
					</td>
					<td style="padding-left:10px;width:95px">
						<button type="button" id="refresh" onclick="refresh()" class="btn btn-info btn-sm"><span class="fa icon-on-right bigger-110"></span>&nbsp;刷新列表</button>
					</td>
				</tr>
			</table>
			
			
		</div>
	</div>
	<div class="tab-content" style="width:100%;height:93%;top:60px;bottom:10px;position:absolute;padding-right:0px">
		<!-- <div style="widht:100%;float: left; ">
			<table style="margin-left:20px;margin-top:10px">
				<tr>
					<td style="width:64px;" align="right">
		   				<font style="font-size:14px; font-family:微软雅黑; color:#88878B;">
							用户组：
						</font>
		   			</td>
		   			<td style="width:125px" align="left">
		   				<select id="queryUserGroupId" name="queryUserGroupId" style="width:125px" class="select" onchange="reloadUserInfo()"></select>
		   			</td>
		   			<td style="width:54px;" align="right">
		   				<font style="font-size:14px; font-family:微软雅黑; color:#88878B;">
							坐席：
						</font>
		   			</td>
		   			<td style="width:135px" align="left">
		   				<select id="queryUserId" name="queryUserId" style="width:125px" class="select" ></select>
		   			</td>
					<td>
						<select id="voiceType" name ="voiceType" style="width:125px">
							<option value="0">PCM(8K16BIT)</option>
							<option value="1">VOX(6K4BIT)</option>
							<option value="2">VOX(8K4BIT)</option>
							<option value="3">ALAW(8K)</option>
							<option value="4">ULAW(8K)</option>
							<option value="-1">WAV</option>
						</select>
					</td>
					<td style="padding-left:17px;padding-top:12px">
						<input type="file" id="file_upload" name="myfile"  class="btn btn-info btn-sm"/>
					</td>
					<td style="padding-left:10px;width:95px;padding-top:17px">
						<button type="button" id="startUpload" class="btn btn-info btn-sm"><span class="ace-icon fa  icon-on-right bigger-110"></span>&nbsp;开始上传</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
					<td style="padding-left:10px;width:95px">
						<button type="button" id="cancelAll" class="btn btn-info btn-sm"><span class="fa icon-on-right bigger-110"></span>&nbsp;全部取消</button>
					</td>
				</tr>
			</table>
			<div style=" width:92%; padding-left: 25px; max-width: 715px; ">
			录音文件格式说明：<strong>PCM(8K16BIT)、VOX(6K4BIT)、VOX(8K4BIT)、ALAW(8K)、ULAW(8K)</strong>，其它格式暂不支持，文件名仅支持半角字母和数字,(一次最多只能同时上传1000个文件，且单个文件的大小不能超过100M)
			
		
			</div>
			
		</div><br/> -->
		<div style="margin-left:23px; float:left;width: 35%;overflow:auto;height: 100%;">
			<div style="  padding-left: 10px; max-width: 715px;padding-top: 10px; ">

			录音文件格式说明：<strong>PCM(8K16BIT)、VOX(6K4BIT)、VOX(8K4BIT)、ALAW(8K)、ULAW(8K)、GSM610、视频MOV</strong>，其它格式暂不支持，文件名仅支持半角字母和数字,(一次最多只能同时上传1000个文件，且单个文件的大小不能超过100M)
			
		
			</div>
			<div id="uploadfileQueue" style=" float:left;width: 99%;padding-top: 15px; /*margin-top: 120px*/;overflow:auto;height:90%; "></div><!-- 存放选择文件的 图片按钮的 div -->

		</div>
		<!-- <div id="uploadfileQueue" style="margin-left:23px; float:left;width: 35%;position: absolute;margin-top: 120px;overflow:auto;height: 625px; "></div>存放选择文件的 图片按钮的 div -->

		<div id="dataContent" style="width:60%;height:85%;float: right;padding-top:10px; padding-right: 10px; ">
			<!-- <button type="button" id="refresh" onclick="refresh()" class="btn btn-info btn-sm"><span class="fa icon-on-right bigger-110"></span>&nbsp;刷新列表</button> -->
			<table id="dataTable" class="table table-striped table-bordered table-hover">
			   <thead id="rhead">
			   </thead> 
			   <tbody id="rbody">
			   </tbody> 
			</table>

		</div>
		
	</div>
 	 
 </div>

<script type="text/javascript">
	var dataTable=null;
	$(document).ready(function(){
		initSelect();
		userGroupId = $('#queryUserGroupId').val();
		//上一次上传成功的文件数量
		var lastUploadsSuccessful = 0;
		
		$("#file_upload").uploadify({
			//是否自动上传 true or false
			'auto'     : false,
			//按钮上显示的文字，默认”SELECT FILES”
			'buttonText' : '浏&nbsp;览&nbsp;文&nbsp;件',
			//表示文件上传完成后等待服务器响应的时间
	        //在此时间后，若服务器未响应，则默认为成功(单位：秒) 
			'successTimeout':30,
			//上传地址
			'uploader' : '../upload/uploadFile',
			//flash,进度条显示文件
			'swf'	   : '../js/jPlug/uploadify/uploadify.swf',
			//文件选择后的容器div的id值
			'queueID'  : 'uploadfileQueue',
			//将要上传的文件对象的名称 必须与后台controller中抓取的文件名保持一致
			'fileObjName':'myfile',
			//浏览将要上传文件按钮的背景图片路径
	        //'buttonImage':'${ctx}/javascript/jPlug/uploadify/img/upload3.gif',
			//浏览按钮的宽度
			'width'    : '78',
			//浏览按钮的高度
			'height'   : '30',
			//是否多文件上传
			'multi'	   : 'true',      
			//在浏览窗口底部的文件类型下拉菜单中显示的文本
			'fileTypeDesc':'支持的格式:pcm、wav、v3、vox、alaw、ulaw',
			//允许上传的文件后缀
			'fileTypeExts':'*.pcm;*.wav;*.v3;*.vox;*.mov',
			/*上传文件的大小限制允许上传文件的最大 大小。 这个值可以是一个数字或字 符串。
	               如果它是一个字符串，它接受一个单位(B, KB, MB, or GB)。
	               默认单位为KB您可以将此值设置为0 ，没有限制, 
	               单个文件不允许超过所设置的值 如果超过 onSelectError时间被触发*/
	        'fileSizeLimit':'100MB',
	        //上传附件时要提交到服务器的额外数据
	        'formData':{'voiceType':$('#voiceType').val()},
	        //定义检查目标文件夹中是否存在同名文件的脚本文件路径。
	        //返回1时存在同名文件，返回0时不存在同名文件。
	        //'checkExisting' : '/uploadify/check-exists.php',
	        'removeTimeout' : 0,//上传完成后多久删除队列中的进度条，默认为3，即3秒。
	        //当点击文件队列中文件的关闭按钮或点击取消上传时触发，file参数为被取消上传的文件对象
	        /* 'onCancel'  :  function(file){
	        }, */
	        //'cancelImg' :  '${ctx }/javascript/jPlug/uploadify/uploadify-cancel.png',
			//允许上传的文件的最大数量。当达到或超过这个数字，onSelectError事件被触发。
	        'queueSizeLimit' : 1000,
	        //每添加一个文件至上传队列时触发该事件。
	        /* 'onSelect' : function(file) {
        		//var currentQueueSize = $('#uploadfileQueue').children().length;
	        }, */ 
	        //当flash按钮载入完毕时触发该事件。
	        /* 'onSWFReady' : function() {
	        }, */
	        //当浏览文件对话框关闭时触发该事件。如果该事件被添加到overrideEvents属性中，
	        //在添加文件到队列中发生错误时，将不会弹出默认错误信息。 
	        
	        'onDialogClose'  : function(queueData) {
	        	$("#cancelAll").click(function(){
	    			/* var bool = confirm("确定要取消所有文件的上传吗?");
	    			if(bool){
	    				$('#file_upload').uploadify('cancel','*');
	    			} */
    				$('#file_upload').uploadify('cancel','*');
	    		});
	        	
	    		$("#startUpload").click(function(){
		        	var userGroupId = $('#queryUserGroupId').val();
		        	if(userGroupId == null){
		        		Modal_Alert('录音上传','请选择用户组');
		        		return;
		        	}
		        	var userList = $("#queryUserId").select2('data');
		        	if(userList.length==0){
		        		Modal_Alert('录音上传','请选择坐席');
		        		return;
		        	}
	    			$('#file_upload').uploadify('upload','*');
	    		});
	        },
	        //在开始上传之前的瞬间会触发该事件。
	        'onUploadStart' : function(file) {
	        	var userName = $("#queryUserId").select2('data')[0].text;
	        	var userId = $('#queryUserId').val();
	        	var userGroupId = $('#queryUserGroupId').val();
	        	$("#file_upload").uploadify('settings','formData',{'userGroupId': userGroupId,'userId': userId,'userName':userName,'voiceType':$('#voiceType').val() });       
	        },
	        //队列中的所有文件被处理完成时触发该事件。
	        'onQueueComplete' : function(queueData) {
	        	//$("#pause").val("继续上传");
	        	if(queueData.uploadsErrored>0){
		            Modal_Alert("上传结果", queueData.uploadsSuccessful - lastUploadsSuccessful + ' 个文件上传成功;' + queueData
		            		.uploadsErrored + ' 个文件上传失败.');
	        	}else{
	        		Modal_Alert("上传结果", queueData.uploadsSuccessful - lastUploadsSuccessful + ' 个文件上传成功.');
	        	}
	        	lastUploadsSuccessful = queueData.uploadsSuccessful;
	        }, 
	        //上传队列清空（激活ancel方法）时，将允许运行一个自定义函数。
	        //queueItemCount:被取消的文件数量。
	        /* 'onClearQueue' : function(queueItemCount) {
	           // alert(queueItemCount + ' 个任务被取消 ');
	        }, */ 
	        //选择上传文件后调用
			/* 'onSelect' : function(file){
				alert("文件 ["+file.name+"] 成功加入上传队列");
			}, */
			//返回一个错误，选择文件的时候触发
	        'onSelectError':function(file, errorCode, errorMsg){
	            switch(errorCode) {
	                case -100:
	                	 window.alert = function(){  
                			return ;  
						 }
	                	Modal_Alert("上传异常", "同时上传的文件数量不能超过"
	                     +$('#file_upload').uploadify('settings','queueSizeLimit')+"个！");
	                    break;
	                case -110:
	                	 window.alert = function(){  
                		return ;  
						 }  
	                	Modal_Alert("上传异常", "文件 ["+file.name+"] 的大小大于"
	                     +$('#file_upload').uploadify('settings','fileSizeLimit')+"，请重新选择！");
	                    break;
	                case -120:
	                	 window.alert = function(){  
                		return ;  
						 }  
	                	Modal_Alert("上传异常", "文件 ["+file.name+"] 大小异常！");
	                    break;
	                case -130:
	                	 window.alert = function(){  
	                		return ;  
							 }  
						Modal_Alert("上传异常", "文件 ["+file.name+"] 类型不正确！");
	                    break;
	            }
	        },
	        //当单个文件上传出错时触发
	        /* 'onUploadError': function (file, errorCode, errorMsg, errorString) { 
	        	//errorCode  -280:取消  -290:暂停
	        	//alert(errorCode);
	        	//alert(errorMsg);
	        	//alert(errorString);
	        	//alert("上传失败");
	        	//fileCount --;
	        	//alert(fileCount);
	        }, */
	        //上传到服务器，服务器返回相应信息到data里
	        'onUploadSuccess':function(file, data, response){
	            //alert("上传成功");
	        	initTable();
	        }
	        
		});
		
		initTable();
		var tabcontent=$(".dataContent").width();
		$(".row").css({"position":"fixed","bottom":"0px","width":tabcontent});
		$("#dataTable").css("width","100%");
	});
	/** -- 初始化用户组下拉框 -- */
	function initSelect(){
		$.post("../upload/getUserGroupInfo",{},function(result) {
			setUserGroupIdInfo(result.obj, "query");
			var userGroupId = $("#queryUserGroupId").val();
			loadUserSelectByGroupId(userGroupId);
			//$("#queryUserGroupId").val(-1);
		},"json").error(function(e) {
			Modal_Alert('用户管理','加载数据失败');
		});
	}
	/** -- 填充页面用户组信息 -- */
	function setUserGroupIdInfo(userGroupList, prefix) {
		$("#" + prefix + "UserGroupId").select2({
			minimumResultsForSearch: -1,
			 data: userGroupList
		});
	}
	function loadUserSelectByGroupId(userGroupId){
		$.post("../upload/getUserInfoByGroupId",{"userGroupId":userGroupId},function(result) {
			setUserInfo(result.obj, "query");
			//$("#queryUserGroupId").val(-1);
		},"json").error(function(e) {
			Modal_Alert('用户管理','加载数据失败');
		});
	}
	function reloadUserInfo(){
		var userGroupId = $("#queryUserGroupId").val();
		//var userId = $("#queryUserId").select2('data')[0].text;
		$("#queryUserId").empty();
		loadUserSelectByGroupId(userGroupId);
	}
	/** -- 填充页面用户组信息 -- */
	function setUserInfo(userList, prefix) {
		
		$("#" + prefix + "UserId").select2({
			minimumResultsForSearch: -1,
			 data: userList
		});
	}
/* 	window.setInterval(function(){ 
		initTable();
	}, 5000); */ 
	function initTable(){
		$("#file_upload-button").css({"background":"#5CACDF","color":"#FFFFFF","border-radius":"2px","height":"34px","margin-top":"-4px"});
		var Columns = [
							{  
							    "mDataProp" : "UUID",  
							    "sTitle" : "uuid", 
							    "bVisible": false,
							    "sDefaultContent" : "",
							    "sClass" : "center"
							},
		                     {  
		                        "mDataProp" : "index",  
		                        "sTitle" : function ( data, type, full, meta ) {
		                        	  var button = "<input type='checkbox' onclick='checkAll()' id='checkAll' value=''/>";
		                        	  return button;
		                    	  },
		                        "bVisible": true,
		                        "sDefaultContent" : "",  
		                        "sWidth": "7%",
		                        "sClass" : "center",//列的样式
		                        "render": function ( data, type, full, meta ) {
		                        	var checkButton = "<input id='ind" +data+ "' type='checkbox' name='checkbox' value='" +full.UUID+ "' onclick='check("+data+")' />";
		                        	return checkButton;
		                            }

		                    },
							{  
							    "mDataProp" : "index",  
							    "sTitle" : "序号", 
							    "bVisible": true,
							    "sDefaultContent" : "",
							    "sWidth": "7%",
							    "sClass" : "center"
							},
							{  
							    "mDataProp" : "name",  
							    "sTitle" : "录音名称", 
							    "bVisible": true,
							    "sDefaultContent" : "",
							    "sWidth": "25%",
							    "sClass" : "center"
							},
							 {  
							    "mDataProp" : "size",  
							    "sTitle" : "录音大小", 
							    "bVisible": true,
							    "sDefaultContent" : "",
							    "sWidth": "10.7%",
							    "sClass" : "center"
							},
							{  
							    "mDataProp" : "status",  
							    "sTitle" : "录音状态", 
							    "bVisible": true,
							    "sDefaultContent" : "",
							    "sWidth": "10.7%",
							    "sClass" : "center"
							},
							{  
							    "mDataProp" : "uploadTime",  
							    "sTitle" : "上传时间", 
							    "bVisible": true,
							    "sDefaultContent" : "",
							    "sWidth": "15.7%",
							    "sClass" : "center"
							},
							{  
		 	                   "mDataProp" : "action",  
		 	                   "sTitle" : "操作", 
		 	                   "sWidth": "10.5%",
		 	                   "bVisible": "true",
		 	                   "sDefaultContent" : "",  
		 	                   "sClass" : "center",
		 	                   "render": function (data, type, full, meta) {
		 	                   		var button = "";
		 	                   		button += '<a href="javascript:void(0)" onclick="deleteFun(\''+full.UUID+'\')">删除</a>&nbsp;';
		 	                   		return button;
		 	              		}
		                   	}
			];
			if(dataTable!=null){
				dataTable.fnClearTable(0); //清空数据
				dataTable.fnDestroy();
			}
			$("#rhead").html("");
			$("#rbody").html("");
			var tabContent = $("#dataContent").height();
			var tabWidth = $("#dataContent").width();
			dataTable = $('#dataTable').dataTable({
				 "bAutoWidth": false,//for better responsiveness
				 "bProcessing": true,
				 "bServerSide": true,
				 "showRowNumber":true,
		         "bPaginate" : true,// 分页按钮
				 "bLengthChange" : true,// 每行显示记录数
				 "bSort" : false,// 排序
				 "bInfo":true,
				 "bStateSave":true,
				 "sPaginationType": "full_numbers", //显示首页和尾页
			     "scrollY": tabContent,
			     "scrollX": tabWidth,
				 "order": [[ 4, 'desc' ]],
				 "sAjaxSource": "../upload/dataGrid",
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
					 });
				 },
				 "aoColumns":Columns
			});
		var tabcontent=$("#dataContent").width();
		$(".row").css({"position":"fixed","bottom":"0px","width":tabcontent});
	}
	
	function refresh(){
		loadmask();
		$.post('../upload/refresh',{},function(data){
			initTable();
			disloadmask();
		}).error(function(e){
			disloadmask();
			Modal_Alert("录音上传","加载上传列表失败!");
		});
	}
	
	function deleteFun(UUID){
		loadmask();
		$.post('../upload/deleteFromRedis',{UUID:UUID},function(data){
			disloadmask();
			if(data.success==true){
				Modal_Alert("录音上传",data.msg);
				dataTable.fnDraw(true);
			}
		},"json").error(function(e){
			disloadmask();
			Modal_Alert("录音上传","删除失败，请重新操作");
		});
	}
	
	//选中按钮
	function check(index){
		if($('#index'+index).is(':checked')){
			$('#index'+index).prop("checked", false);
		}else{
			$('#index'+index).prop("checked", true);
		}
	}
	//全选按钮
	function checkAll(){
		if($('#checkAll').is(':checked')){
			$('input[name="checkbox"]').prop("checked", true);
		}else{
			$('input[name="checkbox"]').prop("checked", false);
		}
	}
	function bathDelete(){
		var insIds ="";
    	var tasks = $("input[name='checkbox']:checked");
    	if(tasks==null||tasks.length==0){
    		 Modal_Alert('录音上传','请选择要删除的录音!');
    		 return;
    	}else{
         	for(var i=0;i<tasks.length;i++){
         		insIds+=tasks[i].value+",";
         	}
         	insIds =insIds.substring(0, insIds.length-1);
   			loadmask();
    		$.post('../upload/bathDelete',{insIds:insIds},function(data){
           	 	disloadmask();
    			if(data.success==true){
    				Modal_Alert("批量删除",data.msg);
    				dataTable.fnDraw(true);
    				if($('#checkAll').is(':checked')){
    					$('#checkAll').prop("checked", false);
    				}
    			}
    		},"json").error(function(e){
           	 	disloadmask();
    			Modal_Alert("录音上传","批量删除失败，请重新操作");
    		});
    	}
	}
</script>

</body>
</html>