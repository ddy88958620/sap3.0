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
$(function(){
	initSearchInfo();
	/* var height = window.screen.height;
	$("#container").height(height/2); */
});

</script>
</head>

<body style="height:100%;weight:100%;background: #f7f7f7;" >
<!-- <img class="bg" src="../img/background.png" /> -->
<div style="position:absolute;top:0px;bottom:0px;left:0px;right:0px;height:100%;
padding:8px;" >
<div>
<div style="position:absolute;height:100%;width:100%;top:10px;overflow-y:auto; ">
<div id="cesi" style="position: absolute;width:100%;left:20px">
     <table>
         <tr>
             <td>关键词:&nbsp;&nbsp;</td>
             <td>
                <input id="searchKeyword" name="searchKeyword" type="text" onmouseover="tipShow()" onmouseout="tipHide()"
                        class="sap_input" style="width:180px;height:30px;" placeholder="例如输入: 短信  流量" />
                <div id="tip" class="alert alert-warning" style="display:none; position:absolute; z-index:100;">
                    <strong>提示：</strong>
                    “+”表示“并且”，“|”表示“或者”，“-”表示“非”
                </div>
             </td>
             <td>&nbsp;&nbsp;数据类型:&nbsp;&nbsp;</td>
             <td><select id="dataType" onchange="typeChange()"/><option value="count">数量</option><option value="avg" selected>平均值</option><option value="sum">总和</option><option value="min">最小值</option><option value="max">最大值</option></select></td>
             <td class="yserious">&nbsp;&nbsp;y轴数据来源:&nbsp;&nbsp;</td>
             <td class="yserious"><select id="yType"/></select></td>
             <td>&nbsp;&nbsp;x轴数据来源:&nbsp;&nbsp;</td>
             <td><select id="xType" onChange="xTypeChange()"></select></td>
             <td>&nbsp;&nbsp;x轴取值间隔:&nbsp;&nbsp;</td>
             <td><input id="xPeriod" type="text" value="1" style="width:70px;height:28px;font-size:13px;background-color:#ECEEED"/></td><td><div id="xUnit"></div></td>
             <td>&nbsp;&nbsp;&nbsp;<a><button type="button" id="searchButton" class="btn btn-info btn-sm" onClick="search()" ><span class="ace-icon fa fa-search icon-on-right bigger-110"></span>&nbsp;查询</button></a></td><td></td>
             <!-- <td>&nbsp;&nbsp;&nbsp;<a><button type="button" id="clearButton" class="btn btn-info btn-sm" onClick="clearSearch()"><span class="fa icon-on-right bigger-110"></span>&nbsp;清空</button></a></td><td></td> -->
             <!-- <td>&nbsp;&nbsp;&nbsp;<a><button type="button" id="advanceSearchButton" class="btn btn-info btn-sm" onClick="searchAdvanceForm()"><span class="ace-icon fa fa-search icon-on-right bigger-110"></span>&nbsp;高级查询</button></a></td><td></td> -->
         </tr>
     </table>
</div>  
  <!-- <div style="width:25%; height:80%; top:54px; bottom:0px; position:absolute;">
      <div style="width:100%; height:30px; top:5px;">
          <font style="font-size:16px; font-family:黑体; color:#4D4D4D;">
              <strong>检索条件</strong>
              趋势分组
          </font>
          <button type="button" class="btn btn-info btn-sm" onclick="addSearchCondition()"
              style="width:50px; height:25px; float:right; top:3px; border:0px;">
              <font style="font-size:10px;">
                  打开
              </font>
          </button>
          <button type="button" class="btn btn-info btn-sm" onclick="addSearchCondition()"
              style="width:50px; height:25px; float:right; maring-left:5px; right:35px; top:3px; border:0px;">
              <font style="font-size:10px;">
                  保存
              </font>
          </button>
      </div>
      
      
      <div>
         <button type="button" class="btn btn-warning btn-sm" onclick="addAccord()"
         style="width:95%; height:25px; top:0px; border:0px;left:1%;">
             <font style="font-size:10px;">
                                                        添加分组
             </font>
         </button>
     </div>
      <div id="accordion" class="accordion-style1 panel-group" style="padding-right:10px;position: absolute;top:60px;bottom:10px;left:0px;right:0px;">
     </div>
     
  </div> -->
	<div class="tab-content" style="width:98%;height:90%;top:54px;bottom:0px;right:0px;position:absolute;margin-right:1%;">
		<div style="padding-bottom:0px;text-align: center;">
			<!-- Highcharts rendergin takes place inside this DIV -->
			<div id="container" style="height:480px;padding:5px;"></div>
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
	function placeholderSupport() { 
	    return 'placeholder' in document.createElement('input'); 
	} 
	//检索条件
	function tipShow() {
	    $("#tip").show();
	}
	
	function tipHide() {
	    $("#tip").hide();
	}
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
	function search(){
		xserious = [];
		yArray = new Array();
		infos = new Array();
		sure(0);
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
	 function getHtml(){/*
	<div class="panel panel-default">
         <div class="panel-heading">
             <h4 class="panel-title">
                 <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapse{id}" aria-expanded="true">
                     <i class="bigger-110 ace-icon fa fa-angle-down" data-icon-hide="ace-icon fa fa-angle-down" data-icon-show="ace-icon fa fa-angle-right"></i>
                      &nbsp; 条件组{num}
                 </a>
             </h4>
         </div>

         <div class="panel-collapse collapse in" id="collapse{id}" aria-expanded="true">
             <div class="panel-body" style="padding:0px;">
                  <div style="width:100%; height:100%;overflow-y:auto; overflow-x:hidden;">
                      <table style="width:100%;">
                          <tbody id="searchConditionList{id}">
                          </tbody>
                      </table>
                      <div>
                          <button type="button" class="btn btn-info btn-sm" onclick="addSearchCondition({id})"
                          style="width:95%; height:25px; top:10px; border:0px;left:2%;">
                              <font style="font-size:10px;">
                                                                         添加条件
                              </font>
                          </button>
                      </div>
                  </div>
             </div>
         </div>
     </div> */}
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
		       /*  'echarts/theme/helianthus',  */
		         'echarts/chart/line'  ,
		         'echarts/chart/bar'  
		     ],  
		     function (ec,theme) {  
		    	 var type ;
		    	 var dataType = $("#dataType").find("option:selected").text();
		    	 if(dataType=="数量"){
		    		 type = "数量";
		    	 }else{
		    		 type = $("#yType").find("option:selected").text();
		    	 }
		    	 
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
		                 trigger:'axis'  
		             },  
		             legend: {  
		                 data: infos,
		                 textStyle: {  
                             color:'rgb(115,115,115)',
                             fontSize:14
                         } 
		             }, 
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
		    		 		name:$("#xType").find("option:selected").text(),
					         type:'category',  
					         boundaryGap:false,  
					         data: xserious
					     }  
					 ],  
		             yAxis: [  
					     {  
					    	 name:type,
					         type:'value',  
					         splitArea: { show:true }  
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
	 //检查时间
	 function checkTime(start,end,dateType){
		 var startTime =  new Date(start);
		 var endTime = new Date(end);
		 var between = endTime.getTime() - startTime.getTime();
		 if(between<=0){
			 Modal_Alert('趋势统计','开始时间不能小于等于结束时间！');
             return false;
		 }
		/*  if(dateType=="1m"){
			 var hour=Math.ceil(between/(3600*1000));
			 if(hour>10){
				 Modal_Alert('趋势统计','分钟维度时间间隔不能超过10个小时！');
				 return false;
			 }
         }else if(dateType=="1h"){
        	 var day=Math.ceil(between/(24*3600*1000));
             if(day>10){
                 Modal_Alert('趋势统计','小时维度时间间隔不能超过10天！');
                 return false;
             }
         }else if(dateType=="1d"){
        	 var day=Math.ceil(between/(24*3600*1000));
             if(day>200){
                 Modal_Alert('趋势统计','天维度时间间隔不能超过200天！');
                 return false;
             }
         }else if(dateType=="1M"){
        	 var year=Math.ceil(between/(365*24*3600*1000));
             if(year>10){
                 Modal_Alert('趋势统计','月维度时间间隔不能超过10年！');
                 return false;
             }
         } */
		 return true;
	 }

	 function insertAfter(newElement, targetElement){
	     var parent = targetElement.parentNode;
	     if (parent.lastChild == targetElement) {
	         // 如果最后的节点是目标元素，则直接添加。因为默认是最后
	         parent.appendChild(newElement);
	     }
	     else {
	         parent.insertBefore(newElement, targetElement.nextSibling);
	         //如果不是，则插入在目标元素的下一个兄弟节点 的前面。也就是目标元素的后面
	     }
	 }

	//秒数转化为时分秒
	function formatSeconds(value) {
	    var second = parseInt(value) / 1000; //秒
	    var minute = 0; //分
	    var hour = 0; //小时

	    if(second <= 0) {
	        second = 1;
	    } else {
	        second = Math.floor(second);
	    }
	    
	    if(second > 60) {
	        minute = parseInt(second/60);
	        second = parseInt(second%60);
	        if(minute > 60) {
	            hour = parseInt(minute/60);
	            minute = parseInt(minute%60);
	        }
	    }
	    
	    var result = "";
	    if(hour > 0) {
	        if(hour.toString().length > 1) {
	            result += hour + ":";
	        } else {
	            result += "0" + hour + ":";
	        }
	    } else {
	        result += "00:";
	    }
	    
	    if(minute > 0) {
	        if(minute.toString().length > 1) {
	            result += minute + ":";
	        } else {
	            result += "0" + minute + ":";
	        }
	    } else {
	        result += "00:";
	    }
	    
	    if(second > 0) {
	        if(second.toString().length > 1) {
	            result += second;
	        } else {
	            result += "0" + second;
	        }
	    } else {
	        result += "00";
	    }
	    
	    return result;
	}

	//检索条件
	function getSearchCondition(id) {
	    var searchArray = new Array();
	    var searchObj = null;
	    var searchNumber = 0;
	    
	    var ruleType = null;
	    
	    for(var i=0; i<searchIdArray[id].length; i++) {
	        searchObj = new Object();
	        
	        ruleType = getRuleType($("#searchField" + searchIdArray[id][i]).val());
	        
	        searchObj.field = ruleType.code;
	        searchObj.type = ruleType.type;
	        
	        if(ruleType.type == '0') {
	            searchObj.equalValue = $.trim($("#equalValue" + searchIdArray[id][i]).val());
	        } else if(ruleType.type == '1') {
	            searchObj.equalValue = $.trim($("#equalValueText" + searchIdArray[id][i]).val());
	            if(searchObj.equalValue != '') {
	                searchObj.equalValue = searchObj.equalValue.substring(0, searchObj.equalValue.length - 1);
	            }
	        } else if(ruleType.type == '2') {
	        	searchObj.minValue = convertTime($.trim($("#minValue" + searchIdArray[id][i]).val()),ruleType,true);
	        	if(searchObj.minValue==null){
	                return null;
	            }
	            searchObj.maxValue = convertTime($.trim($("#maxValue" + searchIdArray[id][i]).val()),ruleType,true);
	            if(searchObj.maxValue==null){
	                return null;
	            }
	         } else if(ruleType.type == '3') {
	            var s = "";
	            var sText = "";
	            $('input[name="equalValue' + searchIdArray[id][i] +'"]:checked').each(function(){
	                s += $(this).val() + ",";
	                sText += $(this).parent().text() + ",";
	            });
	            if(s.length > 0) {
	                s = s.substr(0, s.length - 1);
	                sText = sText.substr(0, sText.length - 1);
	            }
	            searchObj.equalValue = s;
	            searchObj.equalValueText = sText;
	        } else if(ruleType.type == '4') {
	            searchObj.equalValue = $.trim($("#equalValue" + searchIdArray[id][i]).val());
	        } else if(ruleType.type == '5') {
	            searchObj.minValue = $.trim($("#minValue" + searchIdArray[id][i]).val());
	            searchObj.maxValue = $.trim($("#maxValue" + searchIdArray[id][i]).val());
	        } else if(ruleType.type == '6') {
	            searchObj.minValue = $.trim($("#minValue" + searchIdArray[id][i]).val());
	            searchObj.maxValue = $.trim($("#maxValue" + searchIdArray[id][i]).val());
	        }

	        searchArray[searchNumber++] = searchObj;
	    }
	    
	    return searchArray;
	}
	//时间转换
	function convertTime(ori,type,isMult){
		if(ori==null||ori.length==0){
	        Modal_Alert('检索信息错误',type.text+"的取值不能为空");
	        return null;
	    }
	    if(ori==null||ori.length==0){
	        Modal_Alert('检索信息错误',type.text+"的取值不能为空");
	        return null;
	    }
	    var reg = new RegExp("^[0-9]*$");  
	    if(!reg.test(ori)){  
	        Modal_Alert('检索信息错误', type.text+"的取值不是数字");
	        return false;
	   } 
	    
	    var mult = 1;
	    if(type.numberType==11){
	        mult = 1000;
	    }else if(type.numberType==12){
	        mult = 60*1000;
	    }else if(type.numberType==13){
	        mult = 60*60*1000;
	    }
	    if(type.minValue!=null&&type.minValue.length>0&&parseInt(ori)<parseInt(type.minValue)){
	        Modal_Alert('检索信息错误',type.text+"的取值不能小于"+type.minValue);
	        return null;
	    }
	    if(type.maxValue!=null&&type.maxValue.length>0&&parseInt(ori)>parseInt(type.maxValue)){
	        Modal_Alert('检索信息错误',type.text+"的取值不能大于"+type.maxValue);
	        return null;
	    }
	    if(isMult){
	        return parseInt(ori)*mult;
	    }else{
	        return parseInt(ori)/mult;
	    }
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

	function addSearchCondition(id) {
	    var searchCondition = searchString.toString().split(/\n/).slice(1, -1).join('\n');
	    
	    var reg=new RegExp("{id}","g");
	    searchCondition = searchCondition.replace(reg, number);
	    
	    $("#searchConditionList"+id).append(searchCondition);
	    
	    searchIdArray[id][searchIdArray[id].length] = number;
	    
	    initSearchField(number);
	    setTimeout(function(){changeValueWidget(number-1);},500);
	    
	    number++;
	}

	function closeSearchCondtion(value) {
		var tmp;
	    for(var i=0;i<searchIdArray.length;i++) {
	    	for(var j=0;j<searchIdArray[i].length;j++)
	        if(value == searchIdArray[i][j]) {
	            searchIdArray[i].splice(j, 1);
	            tmp = i;
	            break;
	        }
	    }
	    
	    var id = "search" + value;
	    $("#" + id).remove();
	    
	    //判断当前第一个检索条件的类型是否是时间区间类型，如果是重新初始化时间控件
	    if(searchIdArray[tmp].length > 0) {
	        var ruleType = getRuleType($("#searchField" + searchIdArray[tmp][0]).val());
	        if(ruleType.type == '5') {
	            var minValue = $("#minValue" + searchIdArray[tmp][0]).val();
	            var maxValue = $("#maxValue" + searchIdArray[tmp][0]).val();
	            
	            changeValueWidget(searchIdArray[tmp][0]);
	            
	            $("#minValue" + searchIdArray[tmp][0]).val(minValue);
	            $("#maxValue" + searchIdArray[tmp][0]).val(maxValue);
	        }
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
        //var id = "searchField" + value;

        if(ruleTypeArray == null || ruleTypeArray.length <= 0) {
            return;
        }
        
        var html = "";
        for(var i=0;i<ruleTypeArray.length;i++) {
        	if(ruleTypeArray[i].type=="2")
            html += "<option value='" + ruleTypeArray[i].id + "'>" + ruleTypeArray[i].text + "</option>";
        }
        $("#" + id).html(html);
    }

	function changeValueWidget(value) {
	    var obj = getRuleType($("#searchField" + value).val());
	    
	    var html = "";
	    if(obj.type == '0') {
	        $("#fieldLabel" + value).html("字段取值：");
	        html += '<input id="equalValue' + value + '" name="equalValue' + value 
	            + '" placeholder="请输入值"' + 
	            ' type="text" style="width:100%; color:#000000; height:30px; border-color:#72aec2;" value=""/>';
	    } else if(obj.type == '1') {
	        $("#fieldLabel" + value).html("字段取值：");
	        html += '<div class="tags" style="border-color:#72aec2; max-height:100px; overflow-y:auto; overflow-x:hidden; width:100%;">' + 
	                '<div id="tags' + value + '"></div><input id="equalValue' + value + '" ' + 
	                'name="equalValue' + value + '" type="text" placeholder="请输入关键字..." ' +
	                'onkeydown="enterSearch(event,\'' + value + '\',\'yes\')" /><input id="equalValueText' + value + '" type="hidden"/></div>';
	    } else if(obj.type == '2') {
	    	var type = changeNumber(obj.numberType);
	        if(type.length>0){
	            type = "(单位" + type+")";
	        }
	        $("#fieldLabel" + value).html("字段取值"+type+"：");
	        html += '<input id="minValue' + value + '" name="minValue' + value + '" placeholder="最小值" style="height:30px; width:40%; border-color:#72aec2;" type="text"/>' + 
	                '<label style="width:20%; font-size:12px; font-family:黑体; color:#000000;">&nbsp;&nbsp;至&nbsp;&nbsp;</label>' + 
	                '<input id="maxValue' + value + '" name="maxValue' + value + '" placeholder="最大值" style="height:30px;  width:40%;  border-color:#72aec2;" type="text"/>';
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
	            ' type="text" style="color:#000000; width:100%; height:30px; border-color:#72aec2;"/>';
	    } else if(obj.type == '5') {
	        $("#fieldLabel" + value).html("字段取值：");
	        html += '<input id="minValue' + value + '" name="minValue' + value + '" placeholder="开始时间" style="height:30px; width:45%; border-color:#72aec2;" type="text"/>' + 
	                '<label style="width:10%; font-size:12px; font-family:黑体; color:#000000;">&nbsp;-</label>' + 
	                '<input id="maxValue' + value + '" name="maxValue' + value + '" placeholder="结束时间" style="height:30px;  width:45%;  border-color:#72aec2;" type="text"/>';
	    } else if(obj.type == '6') {
	        $("#fieldLabel" + value).html("字段取值：(单位:分钟)");
	        html += '<input id="minValue' + value + '" name="minValue' + value + '" placeholder="最小值" style="height:30px; width:40%; border-color:#72aec2;" type="text"/>' + 
	                '<label style="width:20%; font-size:12px; font-family:黑体; color:#000000;">&nbsp;&nbsp;至&nbsp;&nbsp;</label>' + 
	                '<input id="maxValue' + value + '" name="maxValue' + value + '" placeholder="最大值" style="height:30px;  width:40%;  border-color:#72aec2;" type="text"/>';
	    }
	    
	    $("#valueWidget" + value).html(html);
	    if(obj.type == '5') {
	        initDate(value);
	    } 
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
	        sure(null);
	    },"json").error(function(e) {
	        Modal_Alert('全文检索','加载检索数据失败');
	    });
	}
	//x轴变化
	function xTypeChange(){
		var obj = getRuleType($("#xType").val());
		var type = changeNumber(obj.numberType);
        if(type.length>0){
            type = "(单位" + type+")";
        }
		$("#xUnit").html(type);
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

	function searchString() {/*
	<tr style="width:100%" id="search{id}">
	    <td>
	        <div style="width:95%">
	            <div class="widget-box">
	                <div class="widget-header" style="background-color:#ffffff;">
	                    <font class="widget-title" style="font-size:10px; font-family: Open Sans;
	                            color:#669fc7; font-weight:bold;" id="searchTitle{id}">
	                    添加检索条件</font>
	                    
	                    <input type="hidden" id="searchFlag{id}" value="1" />

	                    <div class="widget-toolbar">
	                        <a href="#" data-action="collapse" onclick="closeWindow('{id}')">
	                            <i class="ace-icon fa fa-chevron-up"></i>
	                        </a>
	                    
	                        <a href="#" onclick="closeSearchCondtion('{id}')">
	                            <i class="ace-icon fa fa-times" style="color:#FF6A6A;"></i>
	                        </a>
	                    </div>
	                </div>
	                
	                <div class="widget-body">
	                    <div class="widget-main">
	                        <div>
	                            <label style="font-size:12px; font-family:黑体; color:#4D4D4D;">检索字段：</label>
	                            <select class="input-medium" id="searchField{id}" name="searchField{id}" 
	                                    style="color:#000000; border-color:#72aec2; width:100%; height:30px;" onchange="changeValueWidget('{id}')">
	                            </select>
	                        </div>
	                        <br />
	                        <div>
	                            <label id="fieldLabel{id}" for="form-field-9" style="font-size:12px; font-family:黑体; color:#4D4D4D;">字段取值：</label>
	                            <div id="valueWidget{id}"></div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </td>
	</tr>
	*/}

	/** -- 规则维护添加页面模糊查询控件 -- */
	function enter(e) {
	    enterSearch(e, 'no');   
	}

	function enterSearch(e, id, is) {
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
	                Modal_Alert('全文检索','输入不合法，请重新输入！');
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

	            $("#equalValueText" + id).val($("#equalValueText" + id).val() + value + ",");
	            createTag(id, value);
	            
	            flag = false;
	        } else {
	            flag = false;
	        }
	    } 
	}

	function createTag(id, value) {
	    var html = $("#tags" + id).html();
	    html += '<span class="tag" id="' + id + value + '">'+ value + 
	        '<button type="button" class="close" onclick="clearTag(\'' + id + '\',\'' + value +
	        '\')">×</button></span>';
	    $("#tags" + id).html(html);
	    
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

	function trim(value){
	    return value.replace(/(^\s*)|(\s*$)/g, "");
	}
	 
	function stripScript(s) {
		var pattern = new RegExp("[`~!@#$%^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？]");
	    var rs = "";
	    for (var i = 0; i < s.length; i++) {
	        rs = rs + s.substr(i, 1).replace(pattern, '');
	    }
	    return rs;
	}

	function textToArray(text) {
	    text = text.substring(0, text.length - 1);
	    var array = text.split(",");
	    return array;
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
	        format:"yyyy-mm-dd",
	        minView:2,
	        maxView:2,
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
	        format:"yyyy-mm-dd",
	        minView:2,
	        maxView:2,
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
	//单个检索条件
	 function sure(id){
		var searchArray = [];
		 var name = null;
		 if(id==searchIdArray.length){
			 if(yArray.length==0){
				 sure(null);
				 return;
			 }else{
				 var dataType = $("#dataType").val();
				 if("count"==dataType){
                     loadChart();
                 }else{
                	 loadChart();
                 }
	             return; 
			 }
		 }
         if(id==null){
             name = "查询结果";
         }else{
             name = "条件组"+(id+1);
             searchArray = getSearchCondition(id)
             if(searchArray==null){
            	 return;
             }
         }
         if(infos.indexOf(name)>-1){
             //将之前的数据去掉
             infos.remove(name);
             for (var i = 0; i < yArray.length; i++) {
                 if (yArray[i].name == name) 
                     yArray.splice(i, 1);
                 }
         }
		if(id==null||searchArray.length>0){
			infos.push(name);
			getPostData(id,searchArray,name);
		}else{
			if(id<searchIdArray.length){
	             sure(id+1);
	         }
		}
	 }
	//发送post请求，获取数据
	 function getPostData(id,condition,name){
		 var searchWord = $("#searchKeyword").val();
		 var dataType = $("#dataType").val();
		 var yType =  getRuleType($("#yType").val()).code;
		 var xType =  getRuleType($("#xType").val()).code;
		 var xPeriod =  $("#xPeriod").val();
		 if(xPeriod==null||xPeriod.length==0){
			 Modal_Alert('交叉分析','请输入x轴取值间隔！');
			 return;
		 }
		 var r = /^\+?[1-9][0-9]*$/;
		 if( !r.test(xPeriod)){
			 Modal_Alert('交叉分析','x轴取值间隔不是数字！');
             return;
		 }
		 var ruleType = getRuleType($("#xType").val());
		 var xmult = getMult("x");
		 var ymult = getMult("y");
		 xPeriod = Number(xPeriod)*xmult;
         if(condition.length == 0){
        	 condition = null;
         }
         var queryString = {
       		 condition:JSON.stringify(condition),
       		 searchWord : searchWord,
       		 dataType: dataType,
             yType: yType,
             xType: xType,
             xmult: xmult,
             ymult: ymult,
             xPeriod:xPeriod
         };
         var yserious = [];
         $.post('./getCrossData', queryString, function(data, status){

             var response;
             try{
                 response = $.parseJSON(data);
             }catch(e){
                 parent.location.href='${ctx}/admin/index';
             }
             lastDayString = $('#callTime').val();
             todayString = $('#callTime2').val();
             if(lastStartTime!=lastDayString||lastEndTime!=todayString||lastDateType!=$("#dateType").val()){
                 lastStartTime = lastDayString;
                 lastEndTime = todayString;
                 lastDateType = $("#dateType").val();
             }
             if (response.isSucess){         
            	 xserious = response.xSeries;
                 /* for(var i=0;i< tmpserious.length;i++){
                	 var tmp = tmpserious[i];
                	 if(xserious.indexOf(tmp)<0){
                		 xserious[xserious.length] = tmp;
                	 }
                	 xserious.sort();
                 } */
                 yserious = response.ySeries;
                 var newY =  {  
                             name:name,  
                             type:'line',  
                             data: yserious,
                             markPoint : {
                                data : [
                                    {type : 'max', name: '最大值'},
                                    {type : 'min', name: '最小值'}
                                ]
                            }
                         };
                  yArray.push(newY);
                  if(id==null){
                	  if("count"==dataType){
                		  loadChart();
                	  }else{
                		  loadChart();
                	  }
                      return;
                  }
                  if(id<searchIdArray.length){
                	  sure(id+1);
                  }
             }else{
            	 if(response.dataCount>0){
            		 Modal_Alert('趋势统计','得到的结果过多！');
                     return;
            	 }
             }
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
	 </script>  

</html> 