 <%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@page import="com.hcicloud.sap.common.utils.DateConversion,java.util.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/bootstrap.css">
<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/font-awesome.css">
<link rel="stylesheet" type="text/css" href="${ctx }/css/ace/ace-fonts.css">
<link rel="stylesheet" href="${ctx }/css/ace/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
	<link rel="stylesheet" type="text/css" href="${ctx }/css/smart_wizard.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/select2/select2.css">
			<!--[if lte IE 9]>
			<link rel="stylesheet" href="${ctx }/css/ace/ace-part2.css" class="ace-main-stylesheet" />
		<![endif]-->
		
		<!--[if lte IE 9]>
		  <link rel="stylesheet" href="${ctx }/css/ace/ace-ie.css" />
		<![endif]-->
<script src="${ctx }/js/jquery-1.11.1.min.js"></script>	
	<script src="${ctx }/js/select2/select2.js"></script>
	<script src="${ctx }/js/tool.js"></script>
	 <script src="${ctx }/js/ace/bootstrap.js"></script>
<title>主页</title>
<style>
*{margin:0px 0px 0px 0px;
 padding:0px 0px 0px 0px;
}
</style>
<script type="text/javascript">
$(function(){
	loadChart();
	var height = window.screen.height;
	$("#container").height(height/2);
});

</script>
</head>

<body style="width:100%;height:1200px;background-image:url('');moz-background-size: 100% 100%; -o-background-size: 100% 100%; -webkit-background-size: 100% 100%; background-size: 100% 100%;-moz-border-image: url('${ctx }/img/background.png') 0; 
background-repeat:no-repeat\9; 
background-image:none\9; 
filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${ctx }/img/background.png', sizingMethod='scale')\9; " class="no-skin">
<%-- <div class="widget-header widget-header-large" style="height:25px;FILTER: none">
	<h3 class="widget-title grey lighter">
		实时话务量统计
	</h3>
	<div class="widget-toolbar no-border invoice-info">
		<span class="invoice-info-label">系统版本:</span>
		<span class="red">3.0.0</span>
		<span class="invoice-info-label">日期:</span>
		<span class="blue"><%=DateConversion.getTimeString(new Date(), "yyyy/MM/dd")%></span>
	</div>
</div> --%>
<div style="position:absolute;height:100%;width:100%;top:0px;overflow-y:auto;background:rgb(247,247,247)">
<%-- <table style="width:80%;margin:0 auto;margin-top:8%">
	<tr><td name="regist" style="height:260px;width:33%;cursor:pointer;" align="center" onmouseover="mouseOver('regist')" onmouseleave="mouseLeave('regist')" onclick="goPage('regist')"><img src="${ctx }/img/m_register.png" id="regist_img"  style="height:86%"/></td>
		<td name="search" style="height:260px;width:33%;cursor:pointer;" align="center" onmouseover="mouseOver('search')" onmouseleave="mouseLeave('search')" onclick="goPage('search')"><img src="${ctx }/img/m_recog.png"  id="search_img" style="height:86%"/></td>
		<td name="auth" style="height:260px;width:33%;cursor:pointer;" align="center" onmouseover="mouseOver('auth')" onmouseleave="mouseLeave('auth')"  onclick="goPage('auth')"><img src="${ctx }/img/m_auth.png" id="auth_img"  style="height:86%"/></td></tr>
	<tr><td name="regist" onmouseover="mouseOver('regist')" onmouseleave="mouseLeave('regist')" onclick="goPage('regist')" align="center" style="height:120px;font-size:34px;cursor:pointer;">身份注册</td><td align="center" name="search" onmouseover="mouseOver('search')" onmouseleave="mouseLeave('search')" onclick="goPage('search')" align="center" style="font-size:34px;cursor:pointer;">身份查询</td><td name="auth" onmouseover="mouseOver('auth')" onmouseleave="mouseLeave('auth')"  onclick="goPage('auth')" align="center" style="font-size:34px;cursor:pointer;">身份认证</td></tr>
	<tr><td></td><td></td><td></td>
</table> --%>

				<!-- 		<div class="light-info">
							<div class="light-tip icon-tip"></div>
							<div style="margin-left: 20px">欢迎您使用灵云智能语音分析系统。</div>
						</div> -->
						<div style="padding:100px 0px 60px 60px;text-align: center;">
							<!-- Highcharts rendergin takes place inside this DIV -->
							<div id="container" style="height:800px;"></div>
							<br/>
							<!-- 评分标准：<select id="forms"  class="js-example-basic-hide-search" style="width:150px;height:30px;" onchange="loadChart()"/></select> -->
						</div>
						<div style="margin-right:13px;text-align:right">
						    <span style="font-size:14px"><img src="${ctx }/images/icon_date.png" style="margin-right:6px;margin-top:-4px"/>日期  :  </span>
							<span style="color:rgb(92,172,223);font-size:14px"><%=DateConversion.getTimeString(new Date(), "yyyy/MM/dd")%></span>
							<span style="color:rgb(115,115,115);font-size:14px"><img src="${ctx }/images/icon_system.png" style="margin-right:6px;margin-top:-4px"/>系统版本:</span>
							<span style="font-size:14px">3.0.0</span>
							
						</div>

</div>
<!--  div class="well" style="text-align: center;bottom: 0px;position: absolute;width: 100%;height: 35px;padding-top: 5px;">Copyright ©2015 北京捷通华声语音技术有限公司 All Right Reserved. 京ICP证030095号 </div>-->
</body>
<script>
	function goPage(page)
	{
		window.parent.goPage(page);
	}
	function mouseOver(name){
		//$("[name="+name+"]").css("background-color","honeydew");
		$("#"+name+"_img").css("height","96%");
		
	}
	function mouseLeave(name){
		//$("[name="+name+"]").css("background-color","");
		$("#"+name+"_img").css("height","86%");
	}
</script>
	<script type="text/javascript" src="${ctx}/js/echarts/echarts.js"></script>
	 <script>
	 function getLastDate(lastDay,dateType){
         if(dateType=="1m"){
             lastDay.setHours(lastDay.getHours()-2);
         }else if(dateType=="1h"){
             lastDay.setDate(lastDay.getDate()-2);
         }else if(dateType=="1d"){
             lastDay.setMonth(lastDay.getMonth()-2);
         }else if(dateType=="1M"){
             lastDay.setFullYear(lastDay.getFullYear()-2);
         }
         return lastDay;
     }
	 var debug = false;
	 function loadChart(){
		 var fullWidth=document.documentElement.clientWidth;
		 var toolPosition=fullWidth-240;
         require.config({  
             paths: {  
                 echarts:'${ctx}/js/echarts'  
             }  
         });  
         require(  
         [  
             'echarts',
             'echarts/theme/macarons', 
           /*  'echarts/theme/helianthus',  */
             'echarts/chart/line'  ,
             'echarts/chart/bar'  
         ],  
         function (ec,theme) {  
             var today = new Date();
             var todayString = today.format('yyyy-MM-dd HH:mm:ss');
             var lastDayString = today.format('yyyy-MM-dd');
             lastDayString += " 00:00:00";
             $('#callTime').val(lastDayString);
             $('#callTime2').val(todayString);
             var queryString = {
                 condition:JSON.stringify(null),
                 dateType: "1m",
                 startTime: lastDayString,
                 endTime: todayString
             };
             var yserious = new Array();
             var yArray = new Array();
             var legendArray = new Array();
             $.post('./analysis/getHomeTrendData', queryString, function(data, status){

                 var response;
                 try{
                     response = $.parseJSON(data);
                 
                 }catch(e){
                     parent.location.href='${ctx}/admin/index';
                 }
                 lastDayString = $('#callTime').val();
                 todayString = $('#callTime2').val();
                 if (response.isSuccess){         
                     xserious = response.xSeries;
                     yserious = response.yList;
                     for (var i = 0; i < yserious.length; i++) {
                      legendArray[i] = "今日工单量趋势";
                       var newY = {  
                             name:"今日工单量趋势",  
                             type:'line',  
                             data: yserious[i],
                             markPoint : {
                                data : [
                                    {type : 'max', name: '最大值'},
                                    {type : 'min', name: '最小值'}
                                ]
                            }
                         };
                         var newY = {  
                             name:"今日工单量趋势",  
                             type:'line',  
                             data: yserious[i],
                             markPoint : {
                                data : [
                                    {type : 'max', name: '最大值'},
                                    {type : 'min', name: '最小值'}
                                ]
                            }
                         };
                      yArray.push(newY);
                     }
                     
                      var myChart=ec.init(document.getElementById('container'),theme);  
                      option= {  
                    		  borderColor:'rgb(92 ,172 ,223)',
                          title : {
                                 text: '工单统计',
                                 x :'200',
                                 textStyle: {  
                                     color:'rgb(115,115,115)',
                                     fontSize:20
                                 } ,
                                 subtext: ''
                             },
                          tooltip: {  
                              trigger:'axis'  
                          },  
                          legend: {  
                              data: legendArray,
                              textStyle: {  
                                  color:'rgb(115,115,115)',
                                  fontSize:14
                              } ,
                          }, 
/*                           grid: {
                              borderColor: 'red'
                          }, */
                          calculable:false,
                          toolbox: {  
                              show:true,  
                              x:toolPosition,
                              feature: {  
                                 //mark : {show: true},
                                 //dataZoom : {show: true},
                                 //dataView : {show: true, readOnly: false},
                                 magicType : {show: true, type: ['line', 'bar']},
                                 restore : {show: true},
                                 saveAsImage : {show: true}  
                              }  
                          },
                          dataZoom : {
                              show : true,
                              realtime : true,
                              //orient: 'vertical',   // 'horizontal'
                              //x: 0,
                              //y: 36,
                              //width: 400,
                              //top:80,
                              height: 20,
                              //backgroundColor: 'rgba(221,160,221,0.5)',
                              //dataBackgroundColor: 'rgba(138,43,226,0.5)',
                              //fillerColor: 'rgba(38,143,26,0.6)',
                              //handleColor: 'rgba(128,43,16,0.8)',
                              //xAxisIndex:[],
                              //yAxisIndex:[],
                              start : 0,
                              end : 100
                          },  
                          //calculable:true,  
                          xAxis: [  
                             {  
                                  type:'category', 
                                  //zlevel:1,
                                  boundaryGap:false,
                     			  splitLine: {    
                     				      show:true,
                                          lineStyle: {      
                                        	  color: ['rgb(178, 212, 231)']
                                          }
                                      },
         
                                  data: xserious,
                                  axisLine : { // 轴线
                                	  show : true,
                                	  lineStyle : {
                                	  color : 'rgb(92,172,223)',
                                	  type : 'solid',
                                	  width : 2
                                	  }
                                	 }
                             }
                          ], 
 
                          yAxis: [  
                              {  
                                  name:'工单量',
                                  fontSize:'44',
                                  color:'grb(92,172,223)',
                                  type:'value',
                                  splitLine: {           // 分隔线
                                      lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
                                          color: ['rgb(178, 212, 231)']
                                      }
                                  },

                                  axisLine : { // 轴线
                                	  show : true,
                                	  lineStyle : {
                                	  color : 'rgb(92,172,223)',
                                	  type : 'solid',
                                	  width : 2
                                	  }
                                	 }
                                  
                              }  
                          ],  
                          series: yArray 
                      };                     
                      myChart.setOption(option);
                      
                 }else{
                     if(response.dataCount>0){
                         Modal_Alert('工单量统计','得到的结果过多！');
                         return;
                     }
                 }
             });
               
        }
     );  
}
	 </script>  

</html> 