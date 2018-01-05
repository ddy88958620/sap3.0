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
<title>主页</title>
<style>
*{margin:0px 0px 0px 0px;
 padding:0px 0px 0px 0px;
}
</style>
<script type="text/javascript">
$(function(){
	$.post('${ctx}/form/getFormCombobox', null, function(data, status){
		if (status=='success'){
			$("#forms").select2({
				minimumResultsForSearch: -1,
				 data: data
			});
			//loadChart();
		}
	},"json").error(function() { 
		$("#forms").select2({
			minimumResultsForSearch: -1
		});
			});
	
	var height = window.screen.height;
	$("#container").height(height/2);
});

</script>
</head>

<body style="width:100%;height:1200px;background-image:url('${ctx }/img/background.png');moz-background-size: 100% 100%; -o-background-size: 100% 100%; -webkit-background-size: 100% 100%; background-size: 100% 100%;-moz-border-image: url('${ctx }/img/background.png') 0; 
background-repeat:no-repeat\9; 
background-image:none\9; 
filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${ctx }/img/background.png', sizingMethod='scale')\9; " class="no-skin">
<div class="widget-header widget-header-large" style="height:25px;FILTER: none">
	<h3 class="widget-title grey lighter">
		实时话务量统计
	</h3>
	<div class="widget-toolbar no-border invoice-info">
		<span class="invoice-info-label">系统版本:</span>
		<span class="red">3.0.0</span>
		<span class="invoice-info-label">日期:</span>
		<span class="blue"><%=DateConversion.getTimeString(new Date(), "yyyy/MM/dd")%></span>
	</div>
</div>
<div style="position:absolute;height:100%;width:100%;top:0px;overflow-y:auto; ">
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
						<div style="padding:60px;text-align: center;">
							<!-- Highcharts rendergin takes place inside this DIV -->
							<div id="container" style="height:400px;border:1px solid #ccc;padding:10px;"></div>
							</br>
							<!-- 评分标准：<select id="forms"  class="js-example-basic-hide-search" style="width:150px;height:30px;" onchange="loadChart()"/></select> -->
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
		function createDate(){
			var dates = new Array();
			for (var i=-31;i<0;i++) {
				var date = new Date();
				date.setHours(0, 0, 0, 0);
				date.setDate(date.getDate()+i);
				dates.push(date.format('MM-dd'));
			}
			return dates;
		}
		
		function createData() {
			var dates = new Array();
			for (var i=-31;i<=0;i++) {
				dates.push(Math.random() * ( 1000 + 1));
			}
			return dates;
		}
	 var debug = false;
	 function loadChart(){
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
		         'echarts/chart/line'  
		     ],  
		     function (ec,theme) {  
		    	var today = new Date();
		 		today.setHours(0, 0, 0, 0);
		 		var lastDay = new Date();
		 		lastDay.setHours(0,0,0,0);
		 		lastDay.setMonth(lastDay.getMonth()-1);
		 		var formId = 0;
		 		if (typeof($('#forms').select2("data")[0]) != "undefined") {
			 		formId = $('#forms').select2("data")[0].id;
		 		}
		 		if(formId==null||formId.length==0){
		 			formId = 0;
		 		}
		 		var queryString = {
		 			user: '${sessionInfo.uuid}',
		 			formId: formId,
		 			beginDate: lastDay.format('yyyy-MM-dd'),
		 			endDate: today.format('yyyy-MM-dd'),
		 			page: 1,
		 			rows: 31
		 		};
		 		var averages = [];
		 		var formCounts = [];
		 		var passedForms = [];
		 		for (var i=0;i<31;i++) {
		 			averages.push(0);
		 			formCounts.push(0);
		 			passedForms.push(0);
		 		}
		 		$.post('${ctx}/report/personSummaryDataGrid', queryString, function(data, status){

		 				var response;
		 				try{
		 					response = $.parseJSON(data);
		 				}catch(e){
		 					parent.location.href='${ctx}/admin/index';
		 				}
		 				
		 			
		 			if (response.success){		 			
		 				var rowData = $.parseJSON(response.msg);
		 				var today = new Date();
		 				today.setHours(0,0,0,0);
		 				for (var i=30;i>=0;i--) {
		 					if(debug){
		 						averages[i] = Math.ceil(Math.random()*70)+30;
	 							formCounts[i] = Math.ceil(Math.random()*70)+30;
	 							passedForms[i] = Math.ceil(Math.random()*70)+30;
		 					}else{
		 						for (var j=0;j<rowData.rows.length;j++) {
			 						var row = rowData.rows[j];
			 						if (row.time == today.format('yyyy-MM-dd').replace(/\-/g,'')) {
			 							averages[i] = row.resultAverageScore;
			 							formCounts[i] = row.resultCount;
			 							passedForms[i] = row.resultPassCount;
			 							break;
			 						}
			 					}
		 					}
		 					today.setDate(today.getDate()-1);
		 				}
				         var myChart=ec.init(document.getElementById('container'),theme);  
				         option= {  
			        		 title : {
			        		        text: '汇总图',
			        		        subtext: '最近一月'
			        		    },
				             tooltip: {  
				                 trigger:'axis'  
				             },  
				             legend: {  
				                 data: ['平均成绩','评分数量','合格评分数量']  
				             },  
				             toolbox: {  
				                 show:true,  
				                 feature: {  
				                	//mark : {show: true},
				                	//dataZoom : {show: true},
			                        //dataView : {show: true, readOnly: false},
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
				                 height: 20,
				                 //backgroundColor: 'rgba(221,160,221,0.5)',
				                 //dataBackgroundColor: 'rgba(138,43,226,0.5)',
				                 //fillerColor: 'rgba(38,143,26,0.6)',
				                 //handleColor: 'rgba(128,43,16,0.8)',
				                 //xAxisIndex:[],
				                 //yAxisIndex:[],
				                 start : 80,
				                 end : 100
				             },  
				             //calculable:true,  
				             xAxis: [  
				    		 	{  
							         type:'category',  
							         boundaryGap:false,  
							         data: createDate()
							     }  
							 ],  
				             yAxis: [  
							     {  
							    	 name:'取值范围',
							         type:'value',  
							         splitArea: { show:true }  
							     }  
							 ],  
				             series: [  
							     {  
							         name:'平均成绩',  
							         type:'line',  
							         //stack:'总量',  
							         data: averages,
							         markPoint : {
						                data : [
						                    {type : 'max', name: '最大值'},
						                    {type : 'min', name: '最小值'}
						                ]
						            }/* ,
						            itemStyle:{
						            	normal: {
						            		color:"orange"
						                }
						            } */
							     },  
							     {  
							         name:'评分数量',  
							         type:'line',  
							         //stack:'评分数量',  
							         data: formCounts  ,
							         markPoint : {
						                data : [
						                    {type : 'max', name: '最大值'},
						                    {type : 'min', name: '最小值'}
						                ]
						            }
							     },  
							     {  
							         name:'合格评分数量',  
							         type:'line',  
							         //stack:'合格评分数量',  
							         data: passedForms ,
							         markPoint : {
						                data : [
						                    {type : 'max', name: '最大值'},
						                    {type : 'min', name: '最小值'}
						                ]
						            }
							     }
							 ]  
				         };                     
				         myChart.setOption(option);  
		 			}
				});
		     }   
		 );  
	}
	 </script>  

</html> 