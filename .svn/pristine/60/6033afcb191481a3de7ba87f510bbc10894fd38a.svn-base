<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!---登入表单的布局 --->
<%String basePath=request.getContextPath();%>
<html>
	<head>
        <title>坐席管理</title>
        <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/ace/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/ace/font-awesome.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/ace/ace-fonts.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/ace/ace-skins.css">
		<link rel="stylesheet" href="<%=basePath%>/css/ace/ace.css" class="ace-main-stylesheet" id="main-ace-style" />  
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/button.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/seat.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/select2/select2.css">
		<!--[if lte IE 9]>
			<link rel="stylesheet" href="<%=basePath%>/css/ace/ace-part2.css" class="ace-main-stylesheet" />
		<![endif]-->
		
		<!--[if lte IE 9]>
		  <link rel="stylesheet" href="<%=basePath%>/css/ace/ace-ie.css" />
		<![endif]-->
		<!-- ace settings handler -->
		<script src="<%=basePath%>/js/jquery-1.11.1.min.js"></script>	
		<script src="<%=basePath%>/js/ace/jquery.dataTables.js"></script>
		<script src="<%=basePath%>/js/ace/bootstrap.js"></script>	
		<script src="<%=basePath%>/js/ace/jquery.dataTables.bootstrap.js"></script>
		<script src="<%=basePath%>/js/ace/ace-extra.js"></script>
		<script src="<%=basePath%>/js/ace/ace-elements.js"></script>
		<script src="<%=basePath%>/js/ace/ace.js"></script>
		<script src="<%=basePath%>/js/select2/select2.js"></script>
		<script src="<%=basePath%>/js/echarts/echarts.js"></script>
		<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->
		
		<!--[if lte IE 8]>
		<script src="<%=basePath%>/js/ace/html5shiv.js"></script>
		<script src="<%=basePath%>/js/ace/respond.js"></script>
		<![endif]-->
		
<script type="text/javascript">
var callId = "";//记录是否有新通话
var callLength=0;//当前通话长度
var captainLength=0;//队长消息长度
var timerPage;//即时消息定时器
var nowDataTable;
var focusTable;
var userPhone;
var indicatorValue;
var dataValue;
var timeArray;
 $(function(){
	 getSeatWord();
	  $("#chartImage").height($("#chartDiv").height()-57);
	  $("#concernPortDiv").height($("#focusDiv").height()-47);
	 timerPage = setInterval("getMessage()",500);
 });
 
function look(id){
	window.open("./lookSeatwordPage?id="+id, '_blank', 'height=750, width=800, top=150, left=200, toolbar=no, menubar=no, scrollbars=yes, resizable=yes,location=no,status=no');
}

function initPeriod(){
	require.config({  
         paths: {  
             echarts:'<%=basePath%>/js/echarts'  
         }  
     });  
     require(  
     [  
         'echarts', 
         'echarts/theme/blue', 
         'echarts/chart/line',  
         'echarts/chart/bar'  
     ],  
     DrawEChart
     );
     function DrawEChart(ec,theme) {
    	 var chartContainer = document.getElementById("concernChart");
    	 //加载图表
    	 var myChart = ec.init(chartContainer,theme);
    	 myChart.setOption({
		    tooltip : {
		        trigger: 'axis',
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		        }
		    },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'value',
				    splitLine:{show: false}
		        }
		    ],
		    yAxis : [
		        {
		            type : 'category',
				    splitLine:{show: false},
		            data : timeArray
		        }
		    ],
		    grid : {
		    	x:75,
		    	y:0,
		    	x2:0,
		    	y2:0
		    },
		    series : [
		        {
		            name:'开场白',
		            type:'bar',
		            stack: '总量',
		            data:[0.4, 0.6, 0.5, 0.7, 0.3, 0.2, 1]
		        },
		        {
		            name:'产品介绍',
		            type:'bar',
		            stack: '总量',
		            data:[0.5, 0.7, 0.2, 0.4, 0.5, 0.5, 0.2]
		        },
		        {
		            name:'健康告知',
		            type:'bar',
		            stack: '总量',
		            data:[0.4, 0.6, 0.8, 0.9, 0.1, 0.2, 0.3]
		        },
		        {
		            name:'登记资料',
		            type:'bar',
		            stack: '总量',
		            data:[0.1, 0.6, 0.3, 0.2, 0.7, 0.2, 0.2]
		        },
		        {
		            name:'确认办理',
		            type:'bar',
		            stack: '总量',
		            data:[0.9, 0.3, 0.1,0.4, 0.3, 0.7, 0.1]
		        },
		        {
		            name:'在线支付',
		            type:'bar',
		            stack: '总量',
		            data:[0.5, 0.8, 0.3, 0.2, 0.4, 0.5, 0.7]
		        },
		        {
		            name:'服务提示',
		            type:'bar',
		            stack: '总量',
		            data:[0.2, 0.8, 0.7, 0.2, 0.4, 1.0, 0.7]
		        }
		    ]
		});
     }
	}

//添加搜索信息
function addSearchInfo(aoData){
		aoData.push({"name":"userPhone","value":userPhone});
}
 
//获取当前对话与团队长消息
 function getMessage(){
 	$.ajax({
 		type : "post",
 		url : './getMessage',
 		dataType : "json",
 		data : {callId : callId , callLength : callLength , captainLength : captainLength},
 		async: false,//发送同步请求		
 		cache: false,
 		success : function(a) {
 			switch (a.errorCode) {
 			case 0:
 				var result=a.retMsg;
 				if(result!=null){
 					if(result.callId!=null){//有新通话记录
 						if(result.userphone!=null&&result.userphone.length>0){
 	 						userPhone = result.userphone;
 	 					}
 						if(result.callId!=callId){//新通话
 						/* 	$(".message").empty(); */
 							$(".message tr").remove();  
 							callId=result.callId;
 							callLength=result.historyList.length;
 							//dataGrid(callId);
 							getFocus(userPhone);
 						}else{//当前通话
 							callLength+=result.historyList.length;
 						}
 						var innerHtml = "";
 						if(result.historyList!=null&&result.historyList.length>0){
 							for(var i=result.historyList.length-1;i>=0;i--){
 								var userClass = "talk_recordboxme";
 								var errorTip = "";
 								var showErrorMsg = "";
 								var user = "&nbsp;:&nbsp;坐席";
 								if(result.historyList[i].talkertype==2){
 									userClass = "talk_recordbox";
 									user = "客户&nbsp;:&nbsp;";
 								}
								var errorMsg="";
								if(result.historyList[i].answerType!=null&&(result.historyList[i].answerType==8||result.historyList[i].answerType==5||result.historyList[i].answerType==6)&&result.historyList[i].talkertype==1){
									errorTip = ' errorMessage';
									//showErrorMsg = '<font style="font-weight:bold;">(违规类型：'+result.historyList[i].answer+")</font>";
									errorMsg = '<div class="talk_recordboxerror">'				
		 								+'<div class="talk_recordtextbg">&nbsp;</div>'
		 								+'<div class="talk_recordtext" style="min-height:40px;">'
		 								+'<font size="2" color="red">违规类型：'+result.historyList[i].answer+'</font>'
		 								+'</div>'
		 								+'<br style="clear:right"/>'
		 								+'<br style="clear:left"/>'
		 								+'</div>'
									
								}else if(result.historyList[i].answerType!=null&&(result.historyList[i].answerType==5||result.historyList[i].answerType==6||result.historyList[i].answerType==8)&&result.historyList[i].talkertype==2){
										if(result.historyList[i].cmd!=null && result.historyList[i].cmd!=''){
		 									showErrorMsg += '<font style="font-weight:bold;" color="#9400D3">[关注点：'+result.historyList[i].cmd+"]</font>";
										}
										errorMsg ='<div class="talk_recordboxerror">'
		 								+'<div class="talk_recordtextbg">&nbsp;</div>'
		 								+'<div class="talk_recordtext" style="min-height:40px;">'
		 								+'<font size="2">话术建议：'+result.historyList[i].answer+'</font>'
		 								+'</div>'
		 								+'<br style="clear:right"/>'
		 								+'<br style="clear:left"/>'
		 								+'</div>'
								}
								innerHtml += '<tr><td width="250px;" style="border-right:1px solid #ccc;margin-left:15px;margin-right:15px;">'+errorMsg
									+'</td><td><div class="'+userClass+'">'
									+'<div class="user">'+user+'</div>'
									+'<div class="talk_recordtextbg">&nbsp;</div>'
									+'<div class="talk_recordtext'+errorTip+'">'
									+'<h7>'+result.historyList[i].content+showErrorMsg
									+'<span class="talk_time">'+result.historyList[i].time+'</span>'+'</h7>'
									+'</div>'
									+'<br style="clear:right"/>'
									+'<br style="clear:left"/>'
									+'</div></td></tr>';
								}
								//$(".message").append(innerHtml);
								$(".message").html($(".message").html()+innerHtml);
								$('#contentSeat').scrollTop($('#contentSeat')[0].scrollHeight);
 						}
 					}else{
 						$("#concernChart").html("没有数据"); 
 						$("#mainChart").html("没有数据");
 					}
 				}else{
 					$("#concernChart").html("没有数据"); 
					$("#mainChart").html("没有数据");
 				}
 				if(result!=null){
 					if(result.captain!=null&&result.captain.length>0){//队长有新消息
 						var contents='';
 						for(var i=0;i<result.captain.length;i++){	
 							contents+='<div style="font-size:12px;word-break: break-all;"><span>'+result.captain[i].name+'</span>：'+result.captain[i].content+'&nbsp;&nbsp;('+result.captain[i].time+')</div>';
 						}
 						$("#captain").append(contents);
 						$('#captain').scrollTop($('#captain')[0].scrollHeight);
 						contents=null;
 						captainLength+=result.captain.length;
 					}
 				}
 				break;
 			default:
 			    clearInterval(timerPage);
 			    Modal_Alert("提醒消息", "获取新消息失败!");
 			break;
 			}
 		},
 		complete: function (XHR, TS) {
 			XHR = null 
 		},
 		error : function() {
 			clearInterval(timerPage);
 			Modal_Alert("提醒消息", "获取新消息失败");
 		}
 	});
 }
 
 function dataGrid(){
	 if(nowDataTable!=null){
			nowDataTable.fnClearTable(0); //清空数据
			//nowDataTable.fnDraw(); //重新加载数据
			nowDataTable.fnDestroy();
		}
		$("#thead").html("");
		$("#tbody").html("");
		var url = './dataGrid';
		var aoColumns = [
		                    {  
		                        "mDataProp" : "timestamp",  
		                        "sTitle" : "通话时间",  
		                        "sDefaultContent" : "",  
		                        "sClass" : "center"  
		                    },
		                    {  
		                        "mDataProp" : "userTeam",  
		                        "sTitle" : "摘要",  
		                        "sDefaultContent" : "",  
		                        "sClass" : "center"  
		                    },
		                    {  
		                        "mDataProp" : "cmd",  
		                        "sTitle" : "关注点",  
		                        "sDefaultContent" : "",  
		                        "sClass" : "center"  
		                    },
		                    {  
			                       "sTitle" : "操作",  
			                       "sDefaultContent" : "",
			                      "bSearchable": false,
			                       "bStorable": false,
			                       "sClass" : "center",
			                       "render": function ( data, type, full, meta ) {
			                    	   var  str = "<a onclick='listenHistory("+full.id+")'>调听</a>&nbsp;&nbsp;&nbsp;";
			                    	   return str;
			                		}
			                    }
		                    
							];
		
		var tabContent = $(".tab-content").height()-34-58;
		nowDataTable = $('#dataTable').dataTable({
			 bAutoWidth: false,//for better responsiveness
			"bProcessing": true,
			"bServerSide": true,
			showRowNumber:true,
			"bPaginate" : true,// 分页按钮
			"bStateSave": false, //是否开启cookies保存当前状态信息
			"bLengthChange" : true,// 每行显示记录数
			"bSort" : false,// 排序
			bInfo:true,
			 scrollY: tabContent,
			 "order": [[ 0, 'asc' ]],
			 "sAjaxSource": url,
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
			            fnCallback(resp);   
			        }    
				 } );
			 },
			 "aoColumns":aoColumns
		});
 }
 function getFocus(userphone){
	 var param = {"userphone":userphone};
	url = "./getFocus";
		$.post(url, param, function (data) {
			if(data!=null&&data.length>0){
				//表头
				var aoColumns = new Array();
				var mList = data[0].msgList;
				aoColumns.push({ //时间列
	                    "mDataProp" : "time",  
	                    "sTitle" : "接通时间",  
	                    "sDefaultContent" : "",  
	                    "sClass" : "left"  
	                });
				//关注点列
				for(var i=0;i<mList.length;i++){
					aoColumns.push({  
	                    "mDataProp" : mList[i],  
	                    "sTitle" : mList[i],  
	                    "sDefaultContent" : "",  
	                    "sClass" : "center"  
	                });
				}
				//表体数据
				var aaData = new Array();
				for(var i=0;i<data.length;i++){
					var time = data[i].type;
					var msgList = data[i].focusMap;
					var rowData = {"time":time};
					for(var j=0;j<mList.length;j++){
						var focus = mList[j];
						var focusTime = 0;
						if(msgList[focus]!=null){
							focusTime = msgList[focus];
						}
						rowData[focus] = focusTime;
					}
					aaData.push(rowData);
				}
				showGrid(aoColumns,aaData);
			}else{
				if(focusTable!=null){
					focusTable.fnClearTable(0); //清空数据
					focusTable.fnDestroy();
				}
				//$("#theadFocus").html("");
				$("#concernChart").html("没有数据"); 
				$("#mainChart").html("没有数据");
			}
			  var phoneStr = "";
          	  if(userPhone.length>=11){
          		  phoneStr = userPhone.substr(0,3)+"****"+userPhone.substr(7,userPhone.length-7);
        	  }else if(userPhone.length>4){
        		  phoneStr =   userPhone.substr(0,userPhone.length-4)+"****";
        	  }else if(userPhone.length>0){
        		  phoneStr = "****";
        	  }else{
        		  phoneStr = "无";
        	  }
			  $("#userPhone").html(phoneStr);	
		},"json").error(function() { 
			
		}); 
 }
 
 function showGrid(aoColumns,aaData){
		if(focusTable!=null){
			focusTable.fnClearTable(0); //清空数据
			//nowDataTable.fnDraw(); //重新加载数据
			focusTable.fnDestroy();
		}
		//$("#theadFocus").html("");
		//$("#tbodyFocus").html("");  
		$("#concernChart").html("");
		$("#mainChart").html("");
		var tabContent = $("#focusDiv").height()-75;
		focusTable = $('#focusTable').dataTable({
			 bAutoWidth: false,//for better responsiveness
			"bProcessing": false,
			"bServerSide": true,
			showRowNumber:true,
			"bPaginate" : false,// 分页按钮
			"bLengthChange" : false,// 每行显示记录数
			"bSort" : false,// 排序
			"bStateSave":true,
			 dom:"t",
			 bInfo:true,
			 scrollY: tabContent,
			 "columnDefs": [ {
		            "searchable": false,
		            "orderable": false,
		            "targets": 0
		        } ],
		      "order": [[ 0, 'asc' ]],
			 data: aaData,
			 "aoColumns":aoColumns
		});
		if(aaData!=null && aaData.length>0){
			timeArray = null;
			timeArray = new Array();
			for(var i=0;i<aaData.length;i++){
				timeArray[i] = aaData[i].time;
				if(i>=6){
					break;
				}
			}
			initPeriod();
		}
		if(aoColumns!=null&&aoColumns.length>0){
			var lastData = aaData[aaData.length-1]; 
			dataValue=new Array();
			indicatorValue=new Array();
			var max=0;
			for(var i=1;i<aoColumns.length;i++){
				if(aoColumns[i].mDataProp>max){
					max=aoColumns[i].mDataProp;
				}
				indicatorValue.push({text:aoColumns[i].mDataProp+"("+lastData[aoColumns[i].mDataProp]+")",max: max});
				dataValue.push(lastData[aoColumns[i].mDataProp]);
			}
			  require.config({  
			         paths: {  
			             echarts:'<%=basePath%>/js/echarts'  
			         }  
			     });  
			     require(  
			     [  
			         'echarts', 
			         'echarts/chart/radar'
			     ],  
			     DrawEChartNew
			     );
			  
		}
		
	}
 function DrawEChartNew(ec) {
	 var chartContainer = document.getElementById("mainChart");
	 //加载图表
	 var myChart = ec.init(chartContainer);
	 myChart.setOption({ 
            tooltip: {   //提示框，鼠标悬浮交互时的信息提示
                show:false,
                trigger: 'axis'
            },
            polar: [{    //极坐标 
                indicator: indicatorValue,
                radius: 69,      
                startAngle: 45   // 改变雷达图的旋转度数
            }],
            series: [{  
            	type: 'radar',
                data: [{
                    value: dataValue,
                    name: 'VGOP系统'
                }]
            }]
        });
 }
 
</script>
</head>
<body scoll=no class="no-skin">

	<!-- 
	 <div id="nowPosition" style="position:absolute;right:5px;top:3px;"><span class="label label-xlg label-yellow arrowed-in">当前位置： 系统管理 - <font  id="tabSelect">坐席管理</font></span></div>
	 <div id="nowphone" style="position:absolute;top:33px;right:5px;text-align: center;"><span class="label">当前通话电话号码:<span id="userPhone"></span></span></div>
	  -->
	  	 <div id="nowPosition" style="position:absolute;right:5px;top:5px;"><span class="label label-xlg label-yellow arrowed-in"><span>当前通话电话号码:<span id="userPhone"></span></span></span></div>
	 <div class="fullsize">
		 <div class="row" style="padding:3%;padding-top:0%;padding-bottom:0%;padding-right:1%;height:100%;width:100%;">
		 <div  class="col-sm-9"  style="height: 100%;padding: 1%;padding-top: 0px">
			 <div class="col-sm-12 leftside" id="contentSeat" style="height:95%;overflow-y:scroll;background-color: #ddd; ">
	           <table class="message"></table>
	         </div>
         <!-- 
		  <div id="captainDiv" class="col-sm-12 leftside"  style="height: 10%;padding: 1%;overflow-y:scroll;">
		    <div id="captain">
		    </div>
		  </div>
		   -->
		 </div>
		 <div class="col-sm-3" float="right" style="height: 95%;padding: 0px;">
			  <div class="col-sm-12 leftside"  style="height:98%;border: 0px;">
				  <div class="widget-box" id="focusDiv" style="height:30%;margin-bottom:5px;border:1px solid #d0d0d0;">
											<div class="widget-header widget-header-small">
												<h6 class="widget-title">
													销售进度
												</h6>
												<div class="widget-toolbar  no-border" style="margin-top:7px;">
													<a href="#" data-action="close">
														<i class="ace-icon fa fa-times"></i>
													</a>
												</div>
											</div>
											<div class="widget-body">
												<div class="widget-main" id="concernPortDiv" style="padding-bottom:0px;padding-left: 3%;padding-right: 1%;">
													<!-- 
													<table id="focusTable">
					    								<thead id="theadFocus"></thead> 
					    								<tbody id="tbodyFocus"></tbody>
				  									</table>
				  									 -->
				  									<div id="concernChart" style="width:100%; height:100%;"></div>
												</div>
											</div>
										</div>
				  
				  
		   			<div class="widget-box" style="height:30%;margin-bottom:5px;" id="chartDiv">
				  	 <div class="widget-header widget-header-small">
						<h6 class="widget-title">
							关注点统计雷达图
						</h6>
						<div class="widget-toolbar  no-border" style="margin-top:7px;">
													<a href="#" data-action="close">
														<i class="ace-icon fa fa-times"></i>
													</a>
												</div>

					</div>
						<div class="widget-body">
							<div class="widget-main" id="chartImage">
		      					<div id="mainChart" style="width:100%; height:100%;"></div>
							</div>
						</div>
					</div>
				<div class="widget-box" style="height:22%;margin-bottom:5px;" id="huashuDiv">
				  	 <div class="widget-header widget-header-small">
						<h6 class="widget-title">
							个人话术名称列表
						</h6>
						<div class="widget-toolbar  no-border" style="margin-top:7px;">
													<a href="#" data-action="close">
														<i class="ace-icon fa fa-times"></i>
													</a>
												</div>
					</div>
					<div class="widget-body">
						<div class="widget-main" id="dataTableWord" style="overflow-y:auto; ">
						</div>
					</div>
					
				</div>
			 	<div class="widget-box collapsed">
				  	 <div class="widget-header widget-header-small">
						<h6 class="widget-title">
							即时消息列表
						</h6>
						<div class="widget-toolbar  no-border">
							<a href="#" data-action="collapse">
								<i class="ace-icon fa fa-chevron-down"></i>
							</a>
							<a href="#" data-action="close">
								<i class="ace-icon fa fa-times"></i>
							</a>
						</div>
					</div>
						<div class="widget-body">
								<div class="widget-main" id="captain" style="max-height:100px;overflow-y:auto; ">
								</div>	
							</div>
						</div>
					
				</div>
			  </div>
		 </div>
		 </div>
</body>
</html>
