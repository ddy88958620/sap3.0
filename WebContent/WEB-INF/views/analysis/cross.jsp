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
        <link rel="stylesheet" type="text/css" href="${ctx }/css/ace/ace-skins.css">
        <link rel="stylesheet" href="${ctx }/css/ace/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
        <link rel="stylesheet" type="text/css" href="${ctx }/css/datetimepicker/bootstrap-datetimepicker.min.css">
        <link rel="stylesheet" type="text/css" href="${ctx }/css/button.css">
        <link rel="stylesheet" type="text/css" href="${ctx }/css/select2/select2.css">
	   <link rel="stylesheet" type="text/css" href="${ctx }/css/smart_wizard.css">
			<!--[if lte IE 9]>
			<link rel="stylesheet" href="${ctx }/css/ace/ace-part2.css" class="ace-main-stylesheet" />
		<![endif]-->
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
            .searchCondtion tr{
                 line-height:22px;
            }
            .searchCondtion td{
                padding:10px;
                text-align:center;
                width:180px;
                font-size:16px;
                /* color:#848484"; */   
                color:#666; 
            }
            .searchCondtion .input{
                height:30px
            }
            .searchCondtion .select{
                width:160px;
                padding:2px;
                border-radius:3px;
            }
            #dataTable td,#dataTable th{
                white-space:nowrap;
            }
            em{
               background-color: yellow;
            }
            
            .addTable tr{
                line-height:22px;
            }
            
            .addTable td{
                padding:10px;
                text-align:center;
                width:60px;
                font-size:16px;
                /* color:#848484"; */   
                color:#666; 
            }
            
            .addTable .input{
                height:30px
            }
            
            .ruleTh {
                text-align:center; 
                border:2px solid #dddddd; 
                color:#ffffff; 
                background-color:#00b4c8; 
                vertical-align: middle;
                font-weight: bold;
            }
            .ruleTd {
                text-align:center;
                border:2px solid #dddddd; 
                background-color:#97FFFF;
                vertical-align: middle;
                font-weight: bold;
            }
        </style>
		<!--[if lte IE 9]>
		  <link rel="stylesheet" href="${ctx }/css/ace/ace-ie.css" />
		<![endif]-->

        <script src="${ctx }/js/jquery-1.11.1.min.js"></script> 
        <script src="${ctx }/js/ace/jquery.dataTables.js"></script>
        <script src="${ctx }/js/ace/bootstrap.js"></script>
        <script src="${ctx }/js/ace/jquery.dataTables.bootstrap.js"></script>
        <script src="${ctx }/js/ace/ace.js"></script>
        <script src="${ctx }/js/ace/ace-extra.js"></script>
        <script src="${ctx }/js/ace/ace-elements.js"></script>
        <script src="${ctx }/js/ace/date-time/bootstrap-datepicker.js"></script>
        <script src="${ctx }/js/select2/select2.js"></script>
        <script src="${ctx }/js/datetimepicker/bootstrap-datetimepicker.js"></script>
        <script src="${ctx }/js/datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"></script>
        <script type="text/javascript" src="${ctx }/js/respond.min.js"></script>
        <script src="${ctx }/js/ace/ace/elements.treeview.js"></script>
        <script src="${ctx }/js/tool.js"></script>
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
<title>交叉分析</title>
<style>
*{margin:0px 0px 0px 0px;
 padding:0px 0px 0px 0px;
}
</style>
<script type="text/javascript">
var searchInfoCommon;
$(function(){
	var height = $("#tabHeight").height();
	var newHeight = (height-540)/2;
	$("#imageHeight").css("padding-top",newHeight+"px");
	initData();
	function initData(){
     	initSearchInfo();
	}
	 //默认时间
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
});

</script>
</head>

<body style="height:100%;weight:100%;background: #f7f7f7;" >
<!-- <img class="bg" src="../img/background.png" /> -->
<div style="position:absolute;top:0px;bottom:0px;left:0px;right:0px;height:100%;
padding:8px;" >
<div>
<div style="position:absolute;height:100%;width:100%;top:10px;overflow-y:auto;left:2px ">
<div id="cesi2" style="position: absolute;width:90%;left:10px">
     <table>
         <tr>
             <td>关键词:&nbsp;&nbsp;</td>
             <td>
                <input id="searchKeyword" name="searchKeyword" type="text" onmouseover="tipShow()" onmouseout="tipHide()"
                        class="sap_input" style="width:230px;height:30px;" placeholder="例如输入: 短信  流量" />
              <!--   <div id="tip" class="alert alert-warning" style="display:none; position:absolute; z-index:100;">
                    <strong>提示：</strong>
                    “+”表示“并且”，“|”表示“或者”，“-”表示“非”
                </div> -->
             </td>
             <td>&nbsp;&nbsp;&nbsp;<a><button type="button" id="searchButton" class="btn btn-info btn-sm" onClick="search()" ><span class="ace-icon fa fa-search icon-on-right bigger-110"></span>&nbsp;查询</button></a></td><td></td>
         </tr>
     </table>
</div>  
<div id="cesi" class="tab-content" style="position: absolute;width:23%;height:90%;top:42px;position:absolute;float: left;border: 0;">
     <table width="98%" height="100%">
          	<tr style="width:100%" >
			<td colspan="2">
      		<div style="width:100%">
			<div class="widget-box">
				<div class="widget-header" style="background-color:#ffffff;">
					<font class="widget-title" style="font-size:10px; font-family: Open Sans;
							color:#669fc7; font-weight:bold;" id="searchTitle0">
					宏观检索条件</font>
					
					<input type="hidden" id="searchFlag0" value="1" />

					<div class="widget-toolbar">
					</div>
				</div>
				
				<div class="widget-body">
					<div class="widget-main">
						<div>
							<label style="font-size:12px; font-family: Micosoft YaHei; color:#88878B;">检索字段：</label>
							<select class="input-medium" id="searchField0" name="searchField0" 
									style="color:#88878B; border-color:#b3d4e7; width:100%; height:30px;" onchange="changeValueWidget('0')">
							</select>
						</div>
						<br />
						<div>
							<label id="fieldLabel0" for="form-field-9" style="font-size:12px; font-family: Micosoft YaHei; color:#88878B;">字段取值：</label>
							<div id="valueWidget0"></div>
						</div>
						<br/>
					</div>
				</div>
			</div>
		</div>
     </td>
     </tr>
     
     
     
     	<tr style="width:100%" >
			<td colspan="2">
		<div style="width:100%">
			<div class="widget-box">
				<div class="widget-header" style="background-color:#ffffff;">
					<font class="widget-title" style="font-size:10px; font-family: Open Sans;
							color:#669fc7; font-weight:bold;">
					因素一数据条件</font>
					
					<input type="hidden" id="searchFlag{id}" value="1" />

					<div class="widget-toolbar">
					</div>
				</div>
				
				<div class="widget-body">
					<div class="widget-main">
						<div>
							<label  style="font-size:12px; font-family: Micosoft YaHei; color:#88878B;">数据来源</label>
							<select class="input-medium" style="color:#88878B; border-color:#b3d4e7; width:100%; height:30px;" id="xType" onChange="xTypeChange()" style="width: 100%"></select>
						</div>
						<br />
						<div>
							<label id="xdata" for="form-field-9" style="font-size:12px; font-family: Micosoft YaHei; color:#88878B;">取值间隔</label>
							<input id="xPeriod" type="text" value="10" style="width: 100%;height:30px;font-size:13px;background-color:#ECEEED;border-color:#b3d4e7;display: none;"/>
							<select class="input-medium" style="color:#88878B; border-color:#b3d4e7; width:100%; height:30px;display: none;" id="xPeriodd" style="width: 100%;">
								<option value="1m">每分钟</option>
								<option value="1h">每小时</option>
								<option value="1d">每天</option>
								<option value="1M">每月</option>
							</select>
						</div>
						<br />
					</div>
				</div>
			</div>
		</div>
	</td>
</tr>

<tr style="width:100%" >
			<td colspan="2">
		<div style="width:100%">
			<div class="widget-box">
				<div class="widget-header" style="background-color:#ffffff;">
					<font class="widget-title" style="font-size:10px; font-family: Open Sans;
							color:#669fc7; font-weight:bold;">
					因素二数据条件</font>
					
					<input type="hidden" id="searchFlag{id}" value="1" />

					<div class="widget-toolbar">
					</div>
				</div>
				
				<div class="widget-body">
					<div class="widget-main">
						<div>
							<label style="font-size:12px; font-family: Micosoft YaHei; color:#88878B;">数据来源</label>
							<select class="input-medium" style="color:#88878B; border-color:#b3d4e7; width:100%; height:30px;" id="yType" onChange="yTypeChange();" style="width: 100%"></select>
						</div>
						<br />
						<div>
							<label id="ydata" for="form-field-9" style="font-size:12px; font-family: Micosoft YaHei; color:#88878B;">取值间隔</label>
							<input id="yPeriod" type="text" value="10" style="width: 100%;height:28px;font-size:13px;background-color:#ECEEED;border-color:#b3d4e7;display: none;"/>
							<select class="input-medium" style="color:#88878B; border-color:#72aec2; width:100%; height:30px;display: none;" id="yPeriodd" style="width: 100%">
								<option value="1m">每分钟</option>
								<option value="1h">每小时</option>
								<option value="1d">每天</option>
								<option value="1M">每月</option>
							</select>
						</div>
						<br />
					</div>
				</div>
			</div>
		</div>
	</td>
</tr>
     </table>
</div>  
	<div id="tabHeight" class="tab-content" style="width:77%;height:90%;top:50px;bottom:0px;right:0px;position:absolute;float: right;">
		<div id="imageHeight" style="text-align: center;">
			<div id="container" style="height:540px;"></div>
		</div>
    </div>
</div>
</div>
 </div>
</body>
<script>
$(function(){
	placeHolderBug();
	});
//IE低版本兼容HTML5 placeHolder属性
	function placeHolderBug(){
		if(!placeholderSupport()){   // 判断浏览器是否支持 placeholder 
		    $('[placeholder]').focus(function() { 
		        var input = $(this); 
		        if (input.val() == input.attr('placeholder')) { 
		            input.val(''); 
		            input.removeClass('placeholder'); 
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
	//检索条件
	function tipShow() {
		$("#tip").show();
	}

	function tipHide() {
		$("#tip").hide();
	}

	function placeholderSupport() { 
	    return 'placeholder' in document.createElement('input'); 
	} 
	function search(){
		var array = getSearchCondition();
		if(array!=null&&array==1){
			
		}else{
			searchInfoCommon = JSON.stringify(array);
			getPostData();
		}
		
	}   

	function clearSearch(){
	    $("#callTime").val("");
	    $("#callTime2").val("");
	    $("#dateType").val("1d");
	}   
</script>
	<script type="text/javascript" src="${ctx}/js/echarts/echarts.js"></script>
	 <script>
	//检索条件
	 var number = 0; //检索条件编号
	 var searchIdArray = new Array();
	 var xserious = [];
	 var ruleTypeArray = null;
	 var flag = false;
	 //y坐标的数据集
	 var yArray = new Array();
	 //多轴的名称
	 var infos = new Array();
	 //最新的开始时间
	 var lastStartTime ;
	 //最新的结束时间
	 var lastEndTime;
	 //最新的时间类型
	 var lastDateType;
	 var debug = false;
	 function addAccord(){
		 var searchCondition = getHtml.toString().split(/\n/).slice(1, -1).join('\n');
		    var reg=new RegExp("{id}","g");
		    searchCondition = searchCondition.replace(reg, searchIdArray.length);
		    var reg=new RegExp("{num}","g");
            searchCondition = searchCondition.replace(reg, searchIdArray.length+1);
		    $("#accordion").append(searchCondition);
		    searchIdArray[searchIdArray.length]=new Array();
		    var tabsHeight = $('.panel-heading').outerHeight() * $('.panel-heading').length;
		    var height = $('#accordion').innerHeight() - tabsHeight;
		    $('.panel-collapse').height(height - 1);
		    $('.panel-body').height(height - 1);
		    for(var i=0;i<searchIdArray.length-1;i++){
		    	$("#collapse"+(i)).collapse('hide');
		    }
		    $("#collapse"+(searchIdArray.length-1)).collapse('show');
	 }
	 function getHtml(){}
	 function loadChart(){
		 var fullWidth=$("#container").width();
		 var toolPosition=fullWidth-200;
			 require.config({  
		         paths: {  
		             echarts:'${ctx}/js/echarts'  
		         }  
		     });  
		     require(  
		     [  
		         'echarts',
		         'echarts/theme/macarons', 
		         'echarts/chart/line'  ,
		         'echarts/chart/bar'  
		     ],  
		     function (ec,theme) {  
		         var myChart=ec.init(document.getElementById('container'),theme);  
		         option= {  
	        		 title : {
	        		        text: '交叉分析',
	        		        textStyle: {  
                                color:'rgb(115,115,115)',
                                fontSize:20
                            } ,
	        		        x:200
	        		    },
		             tooltip: {  
		                 trigger:'item',
		                 formatter: function(data){
		                	 var xName = $("#xType").find("option:selected").text()
		                	 var yName = $("#yType").find("option:selected").text()
				 	         var xmult = $("#xType").val();
				 	         var ymult = $("#yType").val();
		                	 var str = "";
		                	 if(xmult==2){
		                		 var interval = $("#xPeriod").val();
		                		 str+= xName+":("+data[1]+")<br/>";
		                	 }else{
		                		 str+= xName+":"+data[1]+"<br/>";
		                	 }
		                	 if(ymult==2){
		                		 var interval = $("#yPeriod").val();
								 var num= parseInt(data[0]) + parseInt(interval);
		                		 str+= yName+":("+data[0]+"-"+num+")<br/>";
		                	 }else{
		                		 str+= yName+":"+data[0]+"<br/>";
		                	 }
		                	 str+= "总数量:"+  data[5]+"个";
		                	 return str;
		                 }
		             },  
		             /*
		             legend: {  
		                 data: infos,
		                 textStyle: {  
                             color:'rgb(115,115,115)',
                             fontSize:14
                         } 
		             },*/ 
		             toolbox: {  
		                 show:true,  
		                 x:toolPosition,
		                 feature: {  
	                        magicType : {show: true, type: ['line', 'bar']},
	                        dataView : {show: false, readOnly: false},
	                        restore : {show: true},
	                        saveAsImage : {show: true}  
		                 }  
		             },
		             xAxis: [  
		    		 	{  
		    		 		 name:$("#xType").find("option:selected").text(),
					         type:'category',  
					         data: xserious
					     }  
					 ],  
		             yAxis: [  
					     {  
					    	 name:"数量",
					         type:'value',  
					     }  
					 ],  
		             series: yArray 
		         };                     
		         myChart.setOption(option);  
 			}
		 );  
	}
	 //默认时间
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

	function closeWindow(id) {
	    var searchFlag = $("#searchFlag" + id).val();
	    if(searchFlag == '1') {
	        var ruleType = getRuleType($("#searchField" + id).val());
	        $("#searchTitle" + id).html(ruleType.text);
	        $("#searchFlag" + id).val("2");
	    } else if(searchFlag == '2') {
	        $("#searchTitle" + id).html("添加检索条件");
	        $("#searchFlag" + id).val("1");
	    }
	}


	function initSearchField(value) {
	    var id = "searchField" + value;
	    if(ruleTypeArray == null || ruleTypeArray.length <= 0) {
	        return;
	    }
	    var html = "";
	    for(var i=0;i<ruleTypeArray.length;i++) {
	        html += "<option value='" + ruleTypeArray[i].id + "'>" + ruleTypeArray[i].text + "</option>";
	    }
	    $("#" + id).html(html);
	}
	
	function initTypeField(id) {
        if(ruleTypeArray == null || ruleTypeArray.length <= 0) {
            return;
        }
        var html = "";
        for(var i=0;i<ruleTypeArray.length;i++) {
        	if(ruleTypeArray[i].type=="2"||ruleTypeArray[i].type=="3"||ruleTypeArray[i].type=="5")
            html += "<option value='" + ruleTypeArray[i].type + "' name='"+ruleTypeArray[i].code+"' >" + ruleTypeArray[i].text + "</option>";
        }
        $("#" + id).html(html);
    }

	function changeNumber(number){
	    if(number==0){
	        return "";
	    }else if(number==1){
	        return "个";
	    }else if(number==10){
	        return "毫秒";
	    }else if(number==11){
	        return "秒";
	    }else if(number==12){
	        return "分";
	    }else if(number==13){
	        return "时";
	    }
	    return "";
	}
	function initSearchInfo() {
	    $.post("../search/getSearchFormInfo", null, function(result) {
	        if(!result.success)
	            return;
	        ruleTypeArray = result.obj.ruleTypeList;
	        initTypeField("xType");
	        initTypeField("yType");
	        var xmult = $("#xType").val();
			if(xmult==5){
				$("#xPeriodd").css('display','block'); 
				$("#xPeriod").css('display','none'); 
				$("#xdata").css('display','block'); 
			}else if(xmult==3){
				$("#xPeriodd").css('display','none'); 
				$("#xPeriod").css('display','none'); 
				$("#xdata").css('display','none'); 
			}else{
				$("#xPeriodd").css('display','none'); 
				$("#xPeriod").css('display','block'); 
				$("#xdata").css('display','block'); 
			}
			var ymult = $("#yType").val();
			if(ymult==5){
				$("#yPeriodd").css('display','block'); 
				$("#yPeriod").css('display','none'); 
				$("#ydata").css('display','block'); 
			}else if(ymult==3){
				$("#xPeriodd").css('display','none'); 
				$("#xPeriod").css('display','none'); 
				$("#xdata").css('display','none'); 
			}else{
				$("#yPeriodd").css('display','none'); 
				$("#yPeriod").css('display','block'); 
				$("#ydata").css('display','block'); 
			}
			initSearchField(0);
			changeValueWidget(0);
	     	search();
	    },"json").error(function(e) {
	        Modal_Alert('交叉分析','加载检索数据失败');
	    });
	}
	//x轴变化
	function xTypeChange(){
		var xmult = $("#xType").val();
		if(xmult==5){
			$("#xPeriodd").css('display','block'); 
			$("#xPeriod").css('display','none'); 
			$("#xdata").css('display','block'); 
		}else if(xmult==3){
			$("#xPeriodd").css('display','none'); 
			$("#xPeriod").css('display','none'); 
			$("#xdata").css('display','none'); 
		}else{
			$("#xPeriodd").css('display','none'); 
			$("#xPeriod").css('display','block'); 
			$("#xdata").css('display','block'); 
		}
	}
	function yTypeChange(){
		var xmult = $("#yType").val();
		if(xmult==5){
			$("#yPeriodd").css('display','block'); 
			$("#yPeriod").css('display','none'); 
			$("#ydata").css('display','block'); 
		}else if(xmult==3){
			$("#yPeriodd").css('display','none'); 
			$("#yPeriod").css('display','none'); 
			$("#ydata").css('display','none'); 
		}else{ 
			$("#yPeriodd").css('display','none'); 
			$("#yPeriod").css('display','block'); 
			$("#ydata").css('display','block'); 
		}
	}
	//类型变化
	function typeChange(){
		var type = $("#dataType").val();
		if(type == "count"){
			$(".yserious").hide();
		}else{
			$(".yserious").show();
		}
	}

	function getRuleType(value) {
	    var obj = null;
	    for(var i=0;i<ruleTypeArray.length;i++) {
	        if(ruleTypeArray[i].id == value) {
	            obj = ruleTypeArray[i];
	            break;
	        }
	    }
	    return obj;
	}
	//发送post请求，获取数据
	 function getPostData(){
		 var dataType = $("#dataType").val();
		 var xmult = $("#xType").val();
		 var ymult = $("#yType").val();
		 var yType =  $('#yType option:selected').attr("name");
		 var xType =  $('#xType option:selected').attr("name");
		 var xPeriod = "";
		 var yPeriod = "";
		 if(xmult==5){
			 xPeriod =  $("#xPeriodd").val();
		 }else if(xmult==3){
			 
		 }else{
			xPeriod =  $("#xPeriod").val();
			if(xPeriod==null||xPeriod.length==0){
				 Modal_Alert('交叉分析','请输入x轴取值间隔！');
				 return;
			 }
			 var r = /^\+?[1-9][0-9]*$/;
			 if( !r.test(xPeriod)){
				 Modal_Alert('交叉分析','x轴取值间隔不是数字！');
	             return;
			 }
		 }
		 if(ymult==5){
			 yPeriod =  $("#yPeriodd").val();
		 }else if(ymult==3){
			 
		 }else{
			 yPeriod =  $("#yPeriod").val();
			 if(yPeriod==null||yPeriod.length==0){
				 Modal_Alert('交叉分析','请输入y轴取值间隔！');
				 return;
			 }
			 var r = /^\+?[1-9][0-9]*$/;
			 if( !r.test(yPeriod)){
				 Modal_Alert('交叉分析','y轴取值间隔不是数字！');
	             return;
			 }
		 }
		 var searchKeyword = $("#searchKeyword").val();
         var queryString = {
        	 searchInfoCommon:searchInfoCommon,
        	 searchKeyword:searchKeyword,
       		 dataType: dataType,
             yType: yType,
             xType: xType,
             xmult: xmult,
             ymult: ymult,
             xPeriod:xPeriod,
             yPeriod:yPeriod
         };
         var yserious = [];
		 loadmask();
         $.post('../analysis/getCrossData', queryString, function(data, status){
        	 disloadmask();
             var response;
             try{
                 response = $.parseJSON(data);
             }catch(e){
                 parent.location.href='${ctx}/admin/index';
             }
             var success = response.isSucess;
			 if(success){
				 var objX = response.xSeries;
	             var objY = response.yJsonArray;
	             var objZ = response.yList;
	             if(objX!=null&&objY!=null){
	            	 infos = objZ;
	            	 xserious = objX;
	            	 yArray = objY;
	            	 loadChart();
	             }	 
			 }else{
	             var flag = response.dataCount;
				 if(flag==1){
					 Modal_Alert('交叉分析','分析的数据量太多,请重新增大取值间隔进行查询！');
				 }else{
	            	 xserious = [];
	            	 yArray = [];
	            	 loadChart();
	            	 Modal_Alert('交叉分析','未统计到相关数据,请重新输入条件进行查询！');
				 }
			 }
   		 }).error(function(e) {
   			disloadmask();
   			Modal_Alert('交叉分析','通讯失败，请重新发起请求！');
   		});
	 }
	 function getMult(id){
		 var ruleType = getRuleType($("#"+id+"Type").val());
         var mult = 1;
         if(ruleType.numberType==11){
            mult = 1000;
         }else if(ruleType.numberType==12){
            mult = 60*1000;
         }else if(ruleType.numberType==13){
            mult = 60*60*1000;
         }
         return mult;
	 }
	 function changeValueWidget(value) {
			var obj = getRuleType($("#searchField" + value).val());

			var html = "";
			if(obj.type == '0') {
				$("#fieldLabel" + value).html("字段取值：");
		   		html += '<input id="equalValue' + value + '" name="equalValue' + value 
		   			+ '" placeholder="请输入值"' + 
		   			' type="text" style="width:100%; color:#88878B; height:30px; border-color:#b3d4e7;" value=""/>';
			} else if(obj.type == '1') {
				$("#fieldLabel" + value).html("字段取值：");
				html += '<div class="tags" style="border-color:#b3d4e7; max-height:100px; overflow-y:auto; overflow-x:auto; width:100%;">' + 
						'<div id="tags' + value + '"></div><input id="equalValue' + value + '" ' + 
						'name="equalValue' + value + '" type="text" placeholder="请输入关键字，然后按回车键确认" ' +
						'onkeydown="enterSearch(event,\'' + value + '\',\'yes\')" /><input id="equalValueText' + value + '" type="hidden"/></div>';
			} else if(obj.type == '2') {
				var type = changeNumber(obj.numberType);
				if(type.length>0){
					type = "(单位" + type+")";
				}
				$("#fieldLabel" + value).html("字段取值"+type+"：");
				html += '<input id="minValue' + value + '" name="minValue' + value + '" placeholder="最小值" onblur="checkValue('+value+')" style="height:30px; width:45%; border-color:#b3d4e7;" type="text"/>' + 
						'<label align="center" style="width:10%; font-size:12px; font-family:黑体; color:#88878B;">至</label>' + 
						'<input id="maxValue' + value + '" name="maxValue' + value + '" placeholder="最大值" onblur="checkValue('+value+')" style="height:30px;  width:45%;  border-color:#b3d4e7;" type="text"/>';
			} else if(obj.type == '3') {
				$("#fieldLabel" + value).html("字段取值：");
				var array = eval(obj.value);
				if(array != null && array.length > 0) {
					var width = 100 / (array.length <= 6 ? array.length : 6);
					
					var html = "<table style='width:100%;'><tr style='width:100%;'>";
					for(var i=0;i<array.length;i++) {
						if(i%6 == 0) {
							html += "</tr><tr style='width:100%;'>";
						}
						html += '<td width="' + width + '%" align="center"><input name="equalValue' + value + '" type="checkBox" style="margin-left:0px;" value="' + array[i].id + '">' + array[i].text + '</input></td>';
					}
					html += "</tr></table>";
				} else {
					hmtl += '';
				}
			} else if(obj.type == '4') {
				$("#fieldLabel" + value).html("字段取值：");
				html += '<input id="equalValue' + value + '" name="equalValue' + value + '" placeholder="请输入值"' + 
					' type="text" style="color:#88878B; width:100%; height:30px; border-color:#b3d4e7;"/>';
			} else if(obj.type == '5') {
				$("#fieldLabel" + value).html("字段取值：");
				html += '<input id="minValue' + value + '" name="minValue' + value + '" placeholder="开始时间" style="height:30px; width:45%; border-color:#b3d4e7;" type="text"/>' + 
						'<label style="width:10%; font-size:12px; font-family:黑体; color:#88878B;">&nbsp;-</label>' + 
						'<input id="maxValue' + value + '" name="maxValue' + value + '" placeholder="结束时间" style="height:30px;  width:45%;  border-color:#b3d4e7;" type="text"/>';
			} else if(obj.type == '6') {
				$("#fieldLabel" + value).html("字段取值：(单位:分钟)");
				html += '<input id="minValue' + value + '" name="minValue' + value + '" placeholder="最小值" onblur="checkValue('+value+')" style="height:30px; width:40%; border-color:#b3d4e7;" type="text"/>' + 
						'<label style="width:20%; font-size:12px; font-family:黑体; color:#88878B;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;</label>' + 
						'<input id="maxValue' + value + '" name="maxValue' + value + '" placeholder="最大值" onblur="checkValue('+value+')" style="height:30px;  width:40%;  border-color:#b3d4e7;" type="text"/>';
			}
			
			$("#valueWidget" + value).html(html);
			placeHolderBug();
			if(!placeholderSupport()){   // 判断浏览器是否支持 placeholder 
				if($("#maxValue"+value).val()==""){
					$("#maxValue"+value).val("最大值");
				}
			};

			if(obj.type == '5') {
				initDate(value);
			}
		}
	//初始化时间控件
	 function initDate(value){
	 	var direction = null;
	 	if(value > searchIdArray[0]) {
	 		direction = "top-right";
	 	} else {
	 		direction = "bottom-right";
	 	}

	 	var nowDate = new Date();
	 	$('#minValue' + value).datetimepicker({
	 		format:"yyyy-mm-dd hh:ii:ss",
	 		minView:0,
	 		maxView:3,
	 		endDate:nowDate,
	 		language:"zh-CN",
	 	    autoclose: true,
	 	    todayBtn:true ,
	 	    todayHighlight: true,
	 		pickerPosition: direction
	 	}).on("click",function(ev){
	 	    $('#minValue' + value).datetimepicker("setEndDate", $('#maxValue' + value).val());
	 	});
	 	$('#maxValue' + value).datetimepicker({
	 		format:"yyyy-mm-dd hh:ii:ss",
	 		minView:0,
	 		maxView:3,
	 		endDate:nowDate,
	 		language:"zh-CN",
	 	    autoclose: true,
	 	    todayBtn:true ,
	 	    todayHighlight: true,
	 	    pickerPosition: direction
	 	}).on("click", function (ev) {
	 	    $('#maxValue' + value).datetimepicker("setStartDate", $('#minValue' + value).val());
	 	});
	 }
	 function getSearchCondition() {
			var searchArray = new Array();
			var searchObj = null;
			var searchNumber = 0;
			var searchIdArray = [0];
			var ruleType = null;
			for(var i=0; i<searchIdArray.length; i++) {
				var searchObj = new Object();
				var ruleType = getRuleType($("#searchField" + searchIdArray[i]).val());
				searchObj.id = ruleType.id;
				searchObj.field = ruleType.code;
				searchObj.type = ruleType.type;
				if(ruleType.type == '0') {
					var defaultValue=$.trim($("#equalValue" + searchIdArray[i]).attr('placeholder'));
					if(defaultValue==$.trim($("#equalValue" + searchIdArray[i]).val())){
						searchObj.equalValue ="";
					}else{
						searchObj.equalValue = $.trim($("#equalValue" + searchIdArray[i]).val());
					}
					if(searchObj.equalValue==""){
						//Modal_Alert('检索信息错误',ruleType.text+"的取值不能为空");
						return null;
					}
				} else if(ruleType.type == '1') {
					var defaultValue=$.trim($("#equalValueText" + searchIdArray[i]).attr('placeholder'));
					if(defaultValue==$.trim($("#equalValueText" + searchIdArray[i]).val())){
						searchObj.equalValue ="";
					}else{
						searchObj.equalValue = $.trim($("#equalValueText" + searchIdArray[i]).val());
						if(searchObj.equalValue != '') {
							searchObj.equalValue = searchObj.equalValue.substring(0, searchObj.equalValue.length - 1);
						}
					}
					if(searchObj.equalValue==""){
						//Modal_Alert('检索信息错误',ruleType.text+"的取值不能为空");
						return null;
					}
				} else if(ruleType.type == '2') {
					var defaultValue=$.trim($("#minValue" + searchIdArray[i]).attr('placeholder'));
					if(defaultValue==$.trim($("#minValue" + searchIdArray[i]).val())){
						searchObj.minValue=null;
					}else{
						searchObj.minValue = convertTime($.trim($("#minValue" + searchIdArray[i]).val()),ruleType,true);
					}
					if(searchObj.minValue==null){
		                return null;
		            }
					if(searchObj.minValue=="error"){
						return 1;
					}
					var defaultValue=$.trim($("#maxValue" + searchIdArray[i]).attr('placeholder'));
					if(defaultValue==$.trim($("#maxValue" + searchIdArray[i]).val())){
						searchObj.maxValue=null;
					}else{
						searchObj.maxValue = convertTime($.trim($("#maxValue" + searchIdArray[i]).val()),ruleType,true);
					}
					if(searchObj.maxValue==null){
		                return null;
		            }
					if(searchObj.maxValue=="error"){
						return 1;
					}
					   if(searchObj.minValue>searchObj.maxValue){
			            	Modal_Alert('检索信息错误',ruleType.text+"的最小值不能大于最大值");
							return 1;
			            }
				} else if(ruleType.type == '3') {
					var s = "";
					var sText = "";
					$('input[name="equalValue' + searchIdArray[i] +'"]:checked').each(function(){
						s += $(this).val() + ",";
						sText += $(this).parent().text() + ",";
					});
					if(s.length > 0) {
						s = s.substr(0, s.length - 1);
						sText = sText.substr(0, sText.length - 1);
					}
					if(s==""||sText==""){
						//Modal_Alert('检索信息错误',ruleType.text+"的取值不能为空");
						return null;
					}
					searchObj.equalValue = s;
					searchObj.equalValueText = sText;
				} else if(ruleType.type == '4') {
					var defaultValue=$.trim($("#equalValue" + searchIdArray[i]).attr('placeholder'));
					if(defaultValue==$.trim($("#equalValue" + searchIdArray[i]).val())){
						searchObj.equalValue ="";
					}else{
						searchObj.equalValue = $.trim($("#equalValue" + searchIdArray[i]).val());
					}
					if(searchObj.equalValue==""){
						//Modal_Alert('检索信息错误',ruleType.text+"的取值不能为空");
						return null;
					}
				} else if(ruleType.type == '5') {
					var defaultValue=$.trim($("#minValue" + searchIdArray[i]).attr('placeholder'));
					if(defaultValue==$.trim($("#minValue" + searchIdArray[i]).val())){
						searchObj.minValue ="";
					}else{
						searchObj.minValue = $.trim($("#minValue" + searchIdArray[i]).val());
					}
					var defaultValue1=$.trim($("#maxValue" + searchIdArray[i]).attr('placeholder'));
					if(defaultValue1==$.trim($("#maxValue" + searchIdArray[i]).val())){
						searchObj.maxValue ="";
					}else{
						searchObj.maxValue = $.trim($("#maxValue" + searchIdArray[i]).val());
					}
					if(searchObj.minValue==""||searchObj.maxValue==""){
						//Modal_Alert('检索信息错误',ruleType.text+"的取值不能为空");
						return null;
					}
					if(searchObj.minValue>searchObj.maxValue){
			            Modal_Alert('检索信息错误',ruleType.text+"的最小值不能大于最大值");
						return 1;
			        }
				} else if(ruleType.type == '6') {
					var defaultValue=$.trim($("#minValue" + searchIdArray[i]).attr('placeholder'));
					if(defaultValue==$.trim($("#minValue" + searchIdArray[i]).val())){
						searchObj.minValue ="";
					}else{
						searchObj.minValue = $.trim($("#minValue" + searchIdArray[i]).val());
					}
					var defaultValue1=$.trim($("#maxValue" + searchIdArray[i]).attr('placeholder'));
					if(defaultValue1==$.trim($("#maxValue" + searchIdArray[i]).val())){
						searchObj.maxValue ="";
					}else{
						searchObj.maxValue = $.trim($("#maxValue" + searchIdArray[i]).val());
					}
					if(searchObj.minValue==""||searchObj.maxValue==""){
						//Modal_Alert('检索信息错误',ruleType.text+"的取值不能为空");
						return null;
					}
				 	if(searchObj.minValue>searchObj.maxValue){
		            	Modal_Alert('检索信息错误',ruleType.text+"的最小值不能大于最大值");
						return 1;
		         	}
				}
				searchArray[searchNumber++] = searchObj;
			}
			return searchArray;
		}
	//时间转换
	 function convertTime(ori,type,isMult){
	 	var checkTime='';
	 	if(ori==null||ori.length==0){
	 		//Modal_Alert('检索信息错误',type.text+"的取值不能为空");
	 		checkTime=type.text+"的取值不能为空";
	 		return null;
	 	}
	 	var reg = new RegExp("^[0-9]*$");  
	 	if(!reg.test(ori)){  
	         Modal_Alert('检索信息错误', type.text+"的取值不是数字");
	         checkTime=type.text+"的取值不是数字";
	         return "error";
	    } 
	 	
	 	var mult = 1;
	 	if(type.numberType==11){
	 		mult = 1000;
	 	}else if(type.numberType==12){
	 		mult = 1000;
	 	}else if(type.numberType==13){
	         mult = 60*60*1000;
	     }
	 	if(type.minValue!=null&&type.minValue.length>0&&parseFloat(ori)<parseFloat(type.minValue)){
	 		Modal_Alert('检索信息错误',type.text+"的取值不能小于"+type.minValue);
	 		return "error";
	 	}
	 	if(type.maxValue!=null&&type.maxValue.length>0&&parseFloat(ori)>parseFloat(type.maxValue)){
	         Modal_Alert('检索信息错误',type.text+"的取值不能大于"+type.maxValue);
	         return "error";
	     }
	 	if(isMult){
	 		return parseFloat(ori)*mult;
	 	}else{
	 		return parseFloat(ori)/mult;
	 	}
	 }
	 function checkValue(value){
			var minValue = $('#minValue'+value).val();
			var maxValue = $('#maxValue'+value).val();
			if(''!=minValue&&''!=maxValue){
			 	var reg = new RegExp("^[0-9]*$");  
			 	if(reg.test(minValue)&&reg.test(maxValue)){ 
					if(parseInt(minValue)>parseInt(maxValue)){
						$('#maxValue'+value).val('');
			 		}
			 	}
			}
		}
	 /** -- 规则维护添加页面模糊查询控件 -- */
	 function enter(e) {
	 	enterSearch(e, 'no');	
	 }
	 function enterSearch(e, id, is) {
			var equalValueTextVal='';
			$("#tags"+id).find("span").each(function(){
				if(''==equalValueTextVal){
					equalValueTextVal=$(this).text().substring(0,$(this).text().length-1);
				}else{
					equalValueTextVal=equalValueTextVal+","+$(this).text().substring(0,$(this).text().length-1);
				}
			});
			var e = e || window.event; 
			var code = e.keyCode||e.which||e.charCode;
			if(code == 13){
				if(is == 'no') {
					e.preventDefault();
					return;
				}
				
				if(!flag) {
					flag = true;
					
					var value = $("#equalValue" + id).val();
					
					value = stripScript(value);
					if(trim(value) == '') {
						Modal_Alert('交叉分析','输入不合法，请重新输入！');
						flag = false;
						return;
					}
					
					var equalValueArray = textToArray($("#equalValueText" + id).val());
					for(var i=0; i<equalValueArray.length; i++) {
						if(value == equalValueArray[i]) {
							$("#" + id + value).addClass("tag-warning");
							setTimeout("clearTagClass('" + id + value + "')",700);
							flag = false;
							return;
						}
					}

					$("#equalValueText" + id).val(equalValueTextVal +"," +value );
					var a=$("#equalValueText" + id).val();
					createTag(id, value);
					
					flag = false;
				} else {
					flag = false;
				}
			} 
		}
	 function stripScript(s) {
			var pattern = new RegExp("[`~!@#$%^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？]");
		    var rs = "";
		    for (var i = 0; i < s.length; i++) {
		        rs = rs + s.substr(i, 1).replace(pattern, '');
		    }
		    return rs;
		}
	 function trim(value){
			return value.replace(/(^\s*)|(\s*$)/g, "");
		}
	 function textToArray(text) {
			text = text.substring(0, text.length - 1);
			var array = text.split(",");
			return array;
		}
	 function createTag(id, value) {
			var html = $("#tags" + id).html();
			html += '<span class="tag" id="' + id + value + '">'+ value + 
				'<button type="button" class="close" onclick="clearTag(\'' + id + '\',\'' + value +
				'\')">×</button></span>';
			$("#tags" + id).html(html);
			var equalValueTextVal1='';
			$("#tags"+id).find("span").each(function(){
				if(''==equalValueTextVal1){
					equalValueTextVal1=$(this).text().substring(0,$(this).text().length);
				}else{
					equalValueTextVal1=equalValueTextVal1+","+$(this).text().substring(0,$(this).text().length);
				}
			});
			$("#equalValueText" + id).val(equalValueTextVal1);
			$("#equalValue" + id).val('');
		}

	 function clearTagClass(value) {
	 	$("#" + value).removeClass("tag-warning");
	 }
	 function clearTag(id, value) {
			$("#" + id + value).remove();
			var equalValueText = $("#equalValueText" + id).val()
			var equalValueArray = textToArray(equalValueText);
			for(var i=0; i<equalValueArray.length; i++) {
				if(value == equalValueArray[i]) {
					equalValueText = equalValueText.substring(0, equalValueText.indexOf(value)) + equalValueText.substring(equalValueText.indexOf(value) + value.length + 1,
						equalValueText.length);
					$("#equalValueText" + id).val(equalValueText);
				}
			}
		}
	 </script>  

</html> 