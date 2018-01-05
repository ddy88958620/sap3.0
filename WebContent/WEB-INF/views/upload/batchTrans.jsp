

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!---登入表单的布局 --->
<html>
	<head>
        <title>批量转写</title>
        <link rel="stylesheet" type="text/css" href="${ctx }/css/ace/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/font-awesome.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/ace-fonts.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/ace-skins.css">
		<link rel="stylesheet" href="${ctx }/css/ace/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
		<link rel="stylesheet" type="text/css" href="${ctx }/css/button.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/select2/select2.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/js/jPlug/uploadify/uploadify.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/datetimepicker/bootstrap-datetimepicker.min.css">
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
			.uploadify-4button{
				height: 39px;
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
		<script src="${ctx }/js/jquery-1.11.1.min.js"></script>	
	    <script src="${ctx }/js/ace/jquery.dataTables.js"></script>
		<script src="${ctx }/js/ace/bootstrap.js"></script>
        <script src="${ctx }/js/ace/jquery.dataTables.bootstrap.js"></script>
		<script src="${ctx }/js/ace/ace-extra.js"></script>
		<script src="${ctx }/js/ace/ace-elements.js"></script>
		<script src="${ctx }/js/ace/ace.js"></script>
		<script src="${ctx }/js/ace/date-time/bootstrap-datepicker.js"></script>
		<script type="text/javascript" src="${ctx }/js/respond.min.js"></script>
		<script src="${ctx }/js/jPlug/uploadify/jquery.uploadify.min.js"></script>
		<script src="${ctx }/js/windowResize.js"></script>
		<script src="${ctx }/js/select2/select2.js"></script>
		<script src="${ctx }/js/datetimepicker/bootstrap-datetimepicker.js"></script>
		<script src="${ctx }/js/datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"></script>

</head>
<body style="height:100%;weight:100%;background:#F7F7F7" >
<div style="position:absolute;top:0px;bottom:0px;left:0px;right:0px;height:100%;width:98%;padding:10px;" >
	<div style="height:50px; position: absolute;top: 0px; ">

			<!-- 这里是查询模块 Start -->
			<table id="searchTable" style="margin-top:10px;">
			<tr>

				<td  align="right">
					&nbsp;录音流水号：&nbsp;
					<input  id="voiceIdInput" style="height: 25px" type="text"/>
				</td>

				<td align="right" style="width:77px;">
					&nbsp; 录音状态：&nbsp;&nbsp;
				</td>
				<td align="left" style="width:125px;">
					<select id="transStateSelect" style="width:125px;height: 25px" class="select">
						<option value="">全部</option>
						<option value="转写中">转写中</option>
						<option value="转写完成">转写完成</option>
						<option value="录音没有上传">录音没有上传</option>
					</select>
				</td>

				<td align="right" style="padding-left: 10px;">
					开始时间：&nbsp;
					<input id="startTime" type="text" readonly style="height: 25px;"/>
				</td>
				<td align="right">
					&nbsp; 结束时间：&nbsp;
					<input id="endTime" type="text" readonly style="height: 25px;"/>
				</td>

				<td align="right" style="width:73px;">
					&nbsp; 平台编号：&nbsp;
				</td>
				<td align="left" style="width:125px;">
					<select id="platFormSelect" style="width:125px;height: 25px" class="select">
						<option value="">全部</option>
					</select>
				</td>

				<%--<td colspan="5" align="right" style="width: 585px;">--%>
					<%--<a style="margin-left: 20px">--%>
						<%--<button type="button" id="search" class="btn btn-info btn-sm" style="z-index:1;"--%>
								<%--onClick="getAllRecord()">--%>
							<%--<span class="ace-icon fa fa-search icon-on-right bigger-110"></span>&nbsp;查询--%>
						<%--</button>--%>
					<%--</a>--%>
				<%--</td>--%>
			</tr>
			</table>
			<!-- 这里是查询模块 End -->

			<!-- 这里是导入数据的模块 Start-->
			<table style="margin-left:-14px;">
				<tr>
					<td style="padding-left:17px;">
						<form action="${ctx }/batchTrans/uploadFile" method="post"  enctype="multipart/form-data" id="uploadForm">
							<input type="file" id="file_upload" name="myfile"  class="btn btn-info btn-sm"/>
		                </form>
						<!-- <input type="file" id="file_upload" name="myfile"  class="btn btn-info btn-sm"/> -->
					</td>
					
					<td style="padding-left:10px;width:95px;padding-top:17px">
						<button type="button" id="startUpload" class="btn btn-info btn-sm uploadify-4button"><span class="ace-icon fa  icon-on-right bigger-110"></span>&nbsp;开始上传</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
					<td style="padding-left:10px;width:95px">
						<button type="button" id="bathDelete" class="btn btn-info btn-sm uploadify-4button" onclick="bathDelete();"><span class="fa icon-on-right bigger-110"></span>&nbsp;批量删除</button>
					</td>
					<%--<td style="padding-left:10px;width:95px">--%>
						<%--<button type="button" id="refresh" onclick="refresh()" class="btn btn-info btn-sm uploadify-4button"><span class="fa icon-on-right bigger-110"></span>&nbsp;刷新列表</button>--%>
					<%--</td>--%>
					<td style="padding-left:10px;width:95px">
						<button type="button" class="btn btn-info btn-sm uploadify-4button" style="z-index:1;" onClick="downTranceText()" >
							<span class="ace-icon fa fa-download icon-on-right bigger-110"></span>&nbsp;导出转译文本
						</button>
					</td>
					<td style="padding-left:10px;width:95px">
						<button type="button" class="btn btn-info btn-sm uploadify-4button" style="z-index:1;" onClick="exportDownload()" >
							<span class="ace-icon fa fa-download icon-on-right bigger-110"></span>&nbsp;导出excel表格
						</button>
					</td>
					<td style="padding-left:10px;width:95px">
						<button type="button" class="btn btn-info btn-sm uploadify-4button" style="z-index:1;" onClick="initTable()" >
							<span class="ace-icon fa fa-search icon-on-right bigger-110"></span>&nbsp;查询
						</button>
					</td>
				</tr>
			</table>
			<!-- 这里是导入数据的模块 END-->
			
		</div>
	</div>
	<div class="tab-content" style="width:100%;height:93%;top:110px;bottom:10px;position:absolute;padding-right:0px">

		<div id="dataContent" style="width:100%;height:100%;float: right;padding-top:10px; padding-right: 10px; ">
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

	$(function(){
        initDate();
		initTable();

		
		$("#startUpload").click(function(){
			var loadfile = $("#file_upload").val();
			if(loadfile == null || loadfile == ""){
				Modal_Alert('批量转写','未选择上传文件，请重新选择！');
				return false;
			}
			$("#uploadForm").submit();
		});
		if("${message}" != null && "${message}"!=""){
			Modal_Alert('批量转写','${message}');
		}

        /* 获取平台*/
        $.post("${ctx }/record/getPlaytForms",{},function(result) {
            setAutoRulesInfo(result.obj, "platFormSelect");
            $(".dataTables_scrollBody").css("overflow-x","auto");
            $(".dataTables_scrollHeadInner").find("table").css("width","100%");
            $(".dataTables_scrollBody").find("table").css("width","100%");
        },"json").error(function(e) {
            Modal_Alert('平台编号','加载数据失败');
        });

	});
	

	function initTable(){
		$("#file_upload-button").css({"background":"#5CACDF","color":"#FFFFFF","border-radius":"2px","height":"34px","margin-top":"-4px"});
		Columns = [
							/* {  
							    "mDataProp" : "UUID",  
							    "sTitle" : "uuid", 
							    "bVisible": false,
							    "sDefaultContent" : "",
							    "sClass" : "center"
							}, */
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
		                        	var checkButton = "<input id='ind" +data+ "' type='checkbox' name='checkbox' value='" +full.voiceId+ "' dataValue ='" +full.transState+ "'  onclick='check("+data+")' />";
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
							    "mDataProp" : "voiceId",  
							    "sTitle" : "录音流水号", 
							    "bVisible": true,
							    "sDefaultContent" : "",
							    "sWidth": "13%",
							    "sClass" : "center"
							},
							{  
							    "mDataProp" : "platForm",  
							    "sTitle" : "平台编号", 
							    "bVisible": true,
							    "sDefaultContent" : "",
							    "sWidth": "7%",
							    "sClass" : "center"
							}, 
							{  
							    "mDataProp" : "transState",  
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
							    "sWidth": "13%",
							    "sClass" : "center"
							},
							{
								"mDataProp" : "voicePath",
								"sTitle" : "录音路径",
								"bVisible": true,
								"sDefaultContent" : "",
								"sWidth": "15%",
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
//                                   alert(full.voiceId+full.transState);
		 	                   		var button = "";
		 	                   		button += '<a href="javascript:void(0)" onclick="deleteFun( \''+full.voiceId+'\' , \''+full.transState+'\' )">删除</a>&nbsp;';
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
			var tabContent = $("#dataContent").height()-93;
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
				 "bStateSave":false,
				 "sPaginationType": "full_numbers", //显示首页和尾页
			     "scrollY": tabContent,
			     "scrollX": tabWidth,
				 "order": [[ 4, 'desc' ]],
				 "sAjaxSource": "../batchTrans/dataGrid",
				 "fnServerData": function ( sSource, aoData, fnCallback ) {
                     addSearchInfo(aoData);
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
//        window.location.reload();
        initTable();
	}
	
	function deleteFun(voiceId,transState){
 	    if(transState == '转写中'){
            Modal_Alert('删除','转写中，不能删除!');
            return;
		}
		loadmask();
		$.post('../batchTrans/deleteFromES',{voiceId:voiceId},function(data){
			disloadmask();
			if(data.success==true){
				Modal_Alert("批量转写",data.msg);
                setTimeout("refresh()",1000);
			}else{
                Modal_Alert("批量转写",data.msg);
			}
		},"json").error(function(e){
			disloadmask();
			Modal_Alert("批量转写","删除失败，请重新操作");
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
    		 Modal_Alert('批量转写','请选择要删除的转写文本!');
    		 return;
    	}else{
         	for(var i=0;i<tasks.length;i++){

         		if(tasks[i].attributes["dataValue"].nodeValue != '转写中'){
                    insIds+=tasks[i].value+",";
				}
         	}
         	insIds =insIds.substring(0, insIds.length-1);
   			loadmask();
    		$.post('../batchTrans/deleteFromES',{voiceId:insIds},function(data){
           	 	disloadmask();
    			if(data.success==true){
    				Modal_Alert("批量转写",data.msg);
                    setTimeout("refresh()",1000);
    			}else{
                    Modal_Alert("批量转写",data.msg);
                }
                if($('#checkAll').is(':checked')){
                    $('#checkAll').prop("checked", false);
                }
    		},"json").error(function(e){
           	 	disloadmask();
    			Modal_Alert("批量转写","批量删除失败，请重新操作");
    		});
    	}

	}
	//导出转义文本
    function downTranceText(){
        var url = "../batchTrans/downTranceText";
        /*var data = {"voiceId":voiceId.val()};*/
        var data = {"voiceId":$("#voiceIdInput").val(),"transState":$("#transStateSelect").val(),
            "platForm":$("#platFormSelect").val(),"startTime":$("#startTime").val(),"endTime":$("#endTime").val()};
        // TODO 这里可以后续添加条件选项
        post(url,data);
        Modal_Alert('导出工单文本','正在下载...请稍后');
    }

    //发送post请求
    function post(URL, PARAMS) {
        var temp = document.createElement("form");
        temp.action = URL;
        temp.method = "post";
        temp.style.display = "none";
        for (var x in PARAMS) {
            var opt = document.createElement("textarea");
            opt.name = x;
            opt.value = PARAMS[x];
            // alert(opt.name)
            temp.appendChild(opt);
        }
        document.body.appendChild(temp);
        temp.submit();
        return temp;
    }

    /** -- 回车查询 -- */
    function enterSearch(e) {
        var e = e || window.event;
        var code = e.keyCode||e.which||e.charCode;
        if(code == 13){
            getAllRecord();
        }
    }

    /** -- 查询条件 -- */
    function addSearchInfo(aoData) {
        aoData.push({"name": "voiceId", "value": $("#voiceIdInput").val()});
        aoData.push({"name": "transState", "value": $("#transStateSelect").val()});
        aoData.push({"name": "platForm", "value": $("#platFormSelect").val()});
        aoData.push({"name": "startTime", "value": $("#startTime").val()});
        aoData.push({"name": "endTime", "value": $("#endTime").val()});
    }

    function initDate(){
        var nowDate = new Date();
        $('#startTime').datetimepicker({
            format:"yyyy-mm-dd hh:ii:ss",
            minView:0,
            maxView:3,
            endDate:nowDate,
            language:"zh-CN",
            editable:false,
            autoclose: true,
            todayBtn:true ,
            todayHighlight: true
        });
        $('#endTime').datetimepicker({
            format:"yyyy-mm-dd hh:ii:ss",
            minView:0,
            maxView:3,
            editable:false,
            endDate:nowDate,
            language:"zh-CN",
            editable:false,
            autoclose: true,
            todayBtn:true ,
            todayHighlight: true
        });
        /* $('#minLength').datetimepicker({
            pickDate: false,
            language:"zh-CN",
            editable:false,
            autoclose: true
        }); */
        var today = new Date();
        var lastDay = new Date();
        var todayString = today.format('yyyy-MM-dd hh:mm:ss');
        lastDay = getLastDate(lastDay);
        var lastDayString = lastDay.format('yyyy-MM-dd hh:mm:ss');
        $('#startTime').val(lastDayString);
        $('#endTime').val(todayString);
        $('#dataTable tbody').on( 'click', 'tr', function () {
            var aData = dataTable.fnGetData(this);
            $(this).toggleClass('selected');
            if($("#index"+aData.index).is(":checked")){
                $("#index"+aData.index).prop("checked",false);
            }else{
                $("#index"+aData.index).prop("checked",true);
            }
        });
    }

    //默认时间
    function getLastDate(lastDay){
        //lastDay.setMonth(lastDay.getMonth()-1);

        lastDay.setHours(0);
        lastDay.setMinutes(0);
        lastDay.setSeconds(0);
        lastDay.setMilliseconds(0);

        return lastDay;
    }

    /** -- 填充页面规则集类型信息 -- */
    function setAutoRulesInfo(autoRulesList, prefix) {
        $("#"+prefix).select2({
            minimumResultsForSearch: -1,
            data:autoRulesList
        });
    }

    /** -- 文件下载 不能使用ajax导出，下面保留ajax的方式，但是是失败的-- */
    function exportDownload(){

//		var excelData = [];
		var urlHead =  window.location.protocol + "//" + window.location.host;
        var url = urlHead + "${ctx}/batchTrans/download";
//        addSearchInfo(excelData);
//        Modal_Alert('导出工单文本','正在下载...请稍后');
//        $.ajax( {
//            "dataType": 'json',
//            "type": "GET",
//            "url": url,
//            "data": excelData,
//            "success": function(resp) {
//
//            },
//			"error": function (e) {
//                Modal_Alert("导出工单文本","导出工单文本失败，请重新操作");
//            }
//        });
        url += "?voiceId="+$("#voiceIdInput").val()+"&transState="+$("#platFormSelect").val()+"&platForm="+$("#platFormSelect").val()+"&startTime="+$("#startTime").val()+
            "&endTime="+$("#endTime").val();
        location.href = url;
        Modal_Alert('导出防骚扰列表','正在下载...请稍后');

    }
</script>
</body>
</html>