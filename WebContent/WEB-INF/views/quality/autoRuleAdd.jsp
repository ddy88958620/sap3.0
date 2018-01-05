<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!---登入表单的布局 --->
<html>
    <head>
        <title>规则集添加</title>
        <link rel="stylesheet" type="text/css" href="${ctx }/css/ace/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="${ctx }/css/ace/font-awesome.css">
        <link rel="stylesheet" type="text/css" href="${ctx }/css/ace/ace-fonts.css">
        <link rel="stylesheet" type="text/css" href="${ctx }/css/ace/ace-skins.css">
        <link rel="stylesheet" href="${ctx }/css/ace/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
        <link rel="stylesheet" type="text/css" href="${ctx }/css/datetimepicker/bootstrap-datetimepicker.min.css">
        <link rel="stylesheet" type="text/css" href="${ctx }/css/button.css">
        <link rel="stylesheet" type="text/css" href="${ctx }/css/select2/select2.css">
        <link rel="stylesheet" type="text/css" href="${ctx }/css/zTree/metroStyle/metroStyle.css">
        <!-- ace settings handler -->
        <script src="${ctx }/js/jquery-1.11.1.min.js"></script> 
        <script src="${ctx }/js/ace/jquery.dataTables.js"></script>
        <script src="${ctx }/js/ace/bootstrap.js"></script>
        <script src="${ctx }/js/ace/ace-extra.js"></script>
        <script src="${ctx }/js/ace/ace-elements.js"></script>
        <script src="${ctx }/js/ace/fuelux/fuelux.wizard.js"></script>
        <script src="${ctx }/js/ace/ace.js"></script>
        <script src="${ctx }/js/select2/select2.js"></script>
        <script src="${ctx }/js/respond.min.js"></script>
        <script src="${ctx }/js/ace/ace/elements.treeview.js"></script>
        <script src="${ctx }/js/windowResize.js"></script>
        <!-- datetimepicker -->
        <script src="${ctx }/js/ace/date-time/bootstrap-datepicker.js"></script>
        <script src="${ctx }/js/datetimepicker/bootstrap-datetimepicker.js"></script>
        <script src="${ctx }/js/datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"></script>
        
        <!-- jquery validate -->
        <script src="${ctx }/js/ace/jquery.validate.js"></script>
    	
    	<style type="text/css">
    	.ruleTh {
    		text-align:center; 
    		border:2px solid #b0d5e8; 
    		color:#eceeed; 
    		background-color:#5cacdf; 
    		vertical-align: middle;
    		font-weight: bold;
    	}
    	.ruleTd {
    		text-align:center;
    		border:2px solid #b0d5e8; 
    		background-color:#f7f7f7;
    		color: #88878b;
    		vertical-align: middle;
    		font-weight: bold;
    	}
    	.rulesInfoHead {
    		color: #657ba0;
    		font-weight: bold;
    	}
    	.rulesInfoBody {
    		font-weight: bold;
    		float: left;
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

<body class="no-skin" onkeydown="enter()" id="myBody" style="background-color: #f7f7f7;">
	<!-- #section:basics/navbar.layout -->
	<div class="widget-box" style="border:0px;background-color: #f7f7f7;">
    	<div class="widget-header widget-header-blue widget-header-flat" style=" height: 48px; border-bottom:2px solid #d5e3ef;">
        	<h4 class="widget-title lighter" style=" font-size: 20px; color: #5CACE9;line-height: 48px; ">
            	<i class="ace-icon fa fa-hand-o-right"></i>添加规则集
            </h4>
            <button onclick="closeWindow()" type="button" class="btn btn-danger btn-sm" 
            	style="width:70px; height:30px; float:right; border:0px; margin-top:9px; margin-right:20px; ">
            	<i class="ace-icon fa fa-remove bigger-110" style=""></i>取消
            </button>
    	</div>

	    <div class="widget-body" style=" background-color: #f7f7f7; ">
	    	<div class="widget-main">
	            <!-- #section:plugins/fuelux.wizard -->
	            <div id="fuelux-wizard-container">
	                <div style=" height: 168px ">
	                    <!-- #section:plugins/fuelux.wizard.steps -->
	                    <ul class="steps" style=" height: 168px ">
	                        <li data-step="1" class="active">
	                            <span class="step">1</span>
	                            <span class="title">基本信息</span>
	                        </li>
	
	                        <li data-step="2">
	                            <span class="step">2</span>
	                            <span class="title">词组信息</span>
	                        </li>
	
	                        <li data-step="3">
	                            <span class="step">3</span>
	                            <span class="title">短语信息</span>
	                        </li>
	
	                        <li data-step="4">
	                            <span class="step">4</span>
	                            <span class="title">规则逻辑</span>
	                        </li>
	                    </ul>
	                    <!-- /section:plugins/fuelux.wizard.steps -->
	                </div>
	
	                <hr />
	
	                <!-- #section:plugins/fuelux.wizard.container -->
	                <div class="step-content pos-rel">
	                    <div class="step-pane active" data-step="1">
	                        <h3 class="lighter block " style=" color: #5CACE9 ">基本信息</h3>
	
	                        <form class="form-horizontal " id="basicForm">
	                            <!-- #section:elements.form.input-state -->
	                            <div class="form-group has-info">
	                                <label class="col-xs-12 col-sm-4 control-label no-padding-right">名称：</label>
	
	                                <div class="col-xs-12 col-sm-2">
	                                	<input id="name" name="name" placeholder="请输入规则名称" class="width-100" type="text" style=" line-height: 14px; "/>
	                                </div>
	                            </div>
	                            <div class="form-group has-info">
	                                <label class="col-xs-12 col-sm-4 control-label no-padding-right">所属规则集：</label>
	
	                                <div class="col-xs-12 col-sm-2">
	                                	<select id="autoRulesId" class="width-100" style=" line-height: 34px; height: 34px;font-size: 14px; "></select>
	                                </div>
	                            </div>
	                            <div class="form-group has-info">
	                                <label class="col-xs-12 col-sm-4 control-label no-padding-right">状态：</label>
	
	                                <div class="col-xs-12 col-sm-2">
	                                	<select id="state" class="width-100"><option value="1">启用</option><option value="0">禁用</option></select>
	                                </div>
	                            </div>
	                            <div class="form-group has-info">
	                            	<label class="col-xs-12 col-sm-4 control-label no-padding-right">备注：</label>
	
	                                <div class="col-xs-12 col-sm-5">
	                                	<!-- <textarea id="remark" name="remark" rows="3" class="input-xlarge" style="width:100%; "></textarea> -->
	                                	<input id="remark" name="remark" placeholder="请输入备注(选填)" class="width-100" type="text" style="height: 80px; "/>
	                                </div>
	                            </div>
	                        </form>
	                    </div>
	
	                    <div class="step-pane" data-step="2">
 							<h3 class="lighter block " style=" color: #5CACE9 ">
 								词组信息
 								<input type="button" onclick="addLexiconFun()" class="btn btn-primary" value="添加" style="border:0px; float:right;"/>
 							</h3>
							<div style="overflow-y:auto; overflow-x:hidden; height:280px;">
	                        	<table style="width:100%;">
	                        		<thead>
	                        			<tr>
	                        				<th style="width:10%;" class="ruleTh">序号</th>
	                        				<th style="width:20%;" class="ruleTh">名称</th>
	                        				<th style="width:30%;" class="ruleTh">词组信息</th>
	                        				<th style="width:20%;" class="ruleTh">操作</th>
	                        			</tr>
					    			</thead> 
					    			<tbody id="lbody">
					    			</tbody> 
	                        	</table>
	                        </div>
	                    </div>
	
	                    <div class="step-pane" data-step="3">
	                        <h3 class="lighter block " style=" color: #5CACE9 ">
	                        	短语信息
	                        	<input type="button" onclick="addPhraseFun()" class="btn btn-primary" value="添加" style="border:0px; float:right;"/>
	                        </h3>
	                        <div style="overflow-y:auto; overflow-x:hidden; height:280px;">
	                        	<table style="width:100%;">
	                        		<thead>
	                        			<tr>
	                        				<th style="width:10%;" class="ruleTh">序号</th>
	                        				<th style="width:20%;" class="ruleTh">名称</th>
	                        				<th style="width:30%;" class="ruleTh">值</th>
	                        				<th style="width:20%;" class="ruleTh">操作</th>
	                        			</tr>
					    			</thead> 
					    			<tbody id="pbody">
					    			</tbody> 
	                        	</table>
	                        </div>
	                    </div>
					<div class="step-pane" data-step="4">
	                        <h3 class="lighter block " style=" color: #5CACE9 ">
	                        	规则逻辑 
	                        	<input type="button" onclick="addRuleFun()" class="btn btn-primary" value="添加" style="border:0px; float:right;"/>
	                        </h3>
	                        <div style="overflow-y:auto; overflow-x:hidden; height:280px;">
	                        	<table style="width:100%;">
	                        		<thead>
	                        			<tr>
	                        				<th style="width:10%;" class="ruleTh">序号</th>
	                        				<th style="width:30%;" class="ruleTh">值</th>
	                        				<th style="width:20%;" class="ruleTh">操作</th>
	                        			</tr>
					    			</thead> 
					    			<tbody id="logicBody">
					    			</tbody> 
	                        	</table>
	                        </div>
	                    </div>
	                   <!--   <div class="step-pane" data-step="4">
	                        <h3 class="lighter block green">规则逻辑</h3>
	
	                        <form class="form-horizontal " id="scriptForm">
	                            <div class="form-group has-info">
	                                <label class="col-xs-12 col-sm-4 control-label no-padding-right">逻辑内容</label>
	
	                                <div class="col-xs-12 col-sm-3">
	                                	<input id="scriptContent" name="scriptContent" placeholder="请输入逻辑内容" class="width-100" type="text" style="color:#000000;height:80px;" readonly="readonly"/>
	                                	<div class="box2 col-md-6">
										   <label for="bootstrap-duallistbox-nonselected-list_duallistbox_demo1[]" style="display: none;"></label>
										   <select multiple="multiple" id="phraseSelect" class="form-control" name="lexiconSelect" onclick="IEsupportPastePhrase(this)" style="height: 270px;">
											</select>
										</div>
										<div class="box2 col-md-6">
										   <label for="bootstrap-duallistbox-nonselected-list_duallistbox_demo1[]" style="display: none;"></label>
										   <select multiple="multiple" id="phraseSymbolSelect" class="form-control" name="symbolSelect" onclick="IEsupportPastePhraseSym(this)" style="height: 270px;">
											</select>
										</div>
	                                </div>
	                                <div>
				            		 	
									</div>
	                            </div>
	                        </form>
	                    </div>-->
	                </div>
	
	                <!-- /section:plugins/fuelux.wizard.container -->
	            </div>
	
	            <hr />
	            <div class="wizard-actions">
	                <!-- #section:plugins/fuelux.wizard.buttons -->
	                <button class="btn btn-prev">
	                    <i class="ace-icon fa fa-arrow-left"></i>
	                                                                                             上一步
	                </button>
	
	                <button class="btn btn-success btn-next" data-last="保存">
	                                                                                             下一步
	                    <i class="ace-icon fa fa-arrow-right icon-on-right"></i>
	                </button>
	
	                <!-- /section:plugins/fuelux.wizard.buttons -->
	            </div>
	
	            <!-- /section:plugins/fuelux.wizard -->
	        </div><!-- /.widget-main -->
	    </div><!-- /.widget-body -->
	</div>
	
	<!-- 添加&编辑词组modal -->
 	<div class="modal fade" id="lexiconModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    	<div class="modal-dialog">
      		<div class="modal-content" style="width:800px;">
         		<div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
		                  &times;
		            </button>
		            <h4 class="modal-title" id="myModalLabel" style="text-align:center;margin-top:0;font-size:22px;color:#429af1;letter-spacing: 1.5px;width:150px">
		              	词组维护
		            </h4>
         		</div>
         		<div class="modal-body" id="modal-body" align="center" >
         			 <table style="width:100%;">
         			 	<tr>
		                  <td style="width:30%; color:#657ba0; padding-right:15px;" align="right"><label class="control-label no-padding-right">词组名称</label></td>
		                  <td style="text-align:left">
		                  		<input id="luuid" name="luuid" type="hidden" value=""/>
	                  	  		<input id="lexiconId" name="lexiconId" type="hidden" value=""/>
	                  	  		<input id="lexiconNumber" name="lexiconNumber" type="hidden" value=""/>
	                  	  		<input id="lexiconName" name="lexiconName" placeholder="请输入词组名称"  type="text" style="color:#000000; border-color:#72aec2;width:300px"/>
		                  </td>
		                </tr>
		                
		                <tr>
		                  <td style="width:30%; color:#657ba0; padding-right:15px;" align="right"><label class="control-label no-padding-right">词组内容</label></td>
		                  <td id="lexiconValueDiv" style="text-align:left">
		                  </td>
		                </tr>
            		 </table>
         		</div>
       			<hr style="color:#d0d0d0;margin:0"/>
            	<div align="center" style="padding-left:30px; padding-right:10px; padding-bottom:10px;">
		            <button id="ruleButton" onclick="lexicon()" type="button" class="btn btn-info btn-sm" style="width:75px;height:30px;margin-right:15px"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
		            <button type="reset" onclick="clearLexiconData()" class="btn btn-sm" data-dismiss="modal" style="width:75px;height:30px;margin-right:25px"><i class="ace-icon fa fa-undo bigger-110" ></i>取消</button>
		        </div>
      		</div>
      	</div>
	</div>
	
	<!-- 添加&编辑短语modal -->
 	<div class="modal fade" id="phraseModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    	<div class="modal-dialog">
      		<div class="modal-content" style="width:620px;height:auto;">
         		<div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
		                  &times;
		            </button>
		            <h4 class="modal-title" id="myModalLabel" style="text-align:center;margin-top:0;font-size:22px;color:#429af1;letter-spacing: 1.5px;width:150px">
		              	短语维护
		            </h4>
         		</div>
         		<div class="modal-body" id="modal-body" align="center" >
         			 <table style="width:100%;">
         			 	<tr>
		                  <td style="width:30%; color:#657ba0; padding-right:15px;" align="right"><label class="control-label no-padding-right">短语名称</label></td>
		                  <td>
		                  		<input id="puuid" name="puuid" type="hidden" value=""/>
		                  		<input id="phraseId" name="phraseId" type="hidden" value=""/>
	                  	  		<input id="phraseNumber" name="phraseNumber" type="hidden" value=""/>
	                  	  		<input id="phraseName" name="phraseName" placeholder="请输入短语名称" class="width-80" type="text" style="color:#000000; border-color:#72aec2; height:30px;"/>
		                  </td>
		                </tr>
		                
                		<tr >
		                  <td style="width:30%; color:#657ba0; padding-right:15px;" align="right"><label class="control-label no-padding-right">规则内容</label></td>
		                  <td >
	                  	  		<input id="phraseContent" name="phraseContent" placeholder="请选择词组或运算符拼接短语" class="width-80" type="text" style="color:#000000; border-color:#72aec2; height:30px;" />
		                  </td>
		                </tr>
		                
		                <tr style="line-height:40px;">
		                  <td style="width:30%; color:#657ba0; padding-right:15px;" align="right"><label class="control-label no-padding-right" id="ruleValueTextDiv"></label></td>
		                  <td id="ruleValueDiv" style="line-height:normal;">
		                  </td>
		                </tr>
            		 </table>
            		 <div>
            		 	<div class="box2 col-md-6">
						   <label for="bootstrap-duallistbox-nonselected-list_duallistbox_demo1[]" style="display: none;"></label>
						   <select multiple="multiple" id="lexiconSelect" class="form-control" name="lexiconSelect" onclick="IEsupportPasteLexicon(this)" style="height: 135px;")>
							</select>
							<select multiple="multiple" id="commonLexiconSelect" class="form-control" name="commonLexiconSelect" onclick="IEsupportPasteLexicon(this)" style="height: 135px;")>
							</select>
						</div>
						<div class="box2 col-md-6">
						   <label for="bootstrap-duallistbox-nonselected-list_duallistbox_demo1[]" style="display: none;"></label>
						   <select multiple="multiple" id="symbolSelect" class="form-control" name="symbolSelect" onclick="IEsupportPasteLexiconSym(this)" style="height: 270px;">
							</select>
						</div>
					</div>
         		</div>
       			<hr style="color:#d0d0d0;margin:0"/>
            	<div align="center" style="padding-left:30px; padding-right:10px; padding-bottom:10px;">
		            <button id="ruleButton" onclick="phrase()" type="button" class="btn btn-info btn-sm" style="width:75px;height:30px;margin-right:15px"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
		            <button type="reset" onclick="clearPhraseData()" class="btn btn-sm" data-dismiss="modal" style="width:75px;height:30px;margin-right:25px"><i class="ace-icon fa fa-undo bigger-110" ></i>取消</button>
		        </div>
      		</div>
      	</div>
	</div>
	<!-- 增加规则逻辑 -->
	<div class="modal fade" id="logicModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    	<div class="modal-dialog">
      		<div class="modal-content" style="width:620px;height:auto;">
         		<div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
		                  &times;
		            </button>
		            <h4 class="modal-title" id="myModalLabel" style="text-align:center;margin-top:0;font-size:22px;color:#429af1;letter-spacing: 1.5px;width:150px">
		              	逻辑维护
		            </h4>
         		</div>
         		<div class="modal-body" id="modal-body" align="center" >
         			 <table style="width:100%;">
                		<tr >
		                  <td style="width:30%; color:#657ba0; padding-right:15px;" align="right"><label class="control-label no-padding-right">逻辑内容</label></td>
		                  <td >
		                   		<input id="logicuuid" name="logicuuid" type="hidden" value=""/>
	                  	  		<input id="logicId" name="logicId" type="hidden" value=""/>
	                  	  		<input id="logicNumber" name="logicNumber" type="hidden" value=""/>
	                  	  		<input id="scriptContent" name="scriptContent" placeholder="请输入规则内容" class="width-80" type="text" style="color:#000000; border-color:#72aec2; height:30px;" />
		                  </td>
		                </tr>
		                
		                <tr style="line-height:40px;">
		                  <td style="width:30%; color:#657ba0; padding-right:15px;" align="right"><label class="control-label no-padding-right" id="ruleValueTextDiv"></label></td>
		                  <td id="ruleValueDiv" style="line-height:normal;">
		                  </td>
		                </tr>
            		 </table>
            		 <div>
            		 	<div class="box2 col-md-6">
						   <label for="bootstrap-duallistbox-nonselected-list_duallistbox_demo1[]" style="display: none;"></label>
						   <select multiple="multiple" id="phraseSelect" class="form-control" name="lexiconSelect" onclick="IEsupportPastePhrase(this)" style="height: 270px;")>
							</select>
						</div>
						<div class="box2 col-md-6">
						   <label for="bootstrap-duallistbox-nonselected-list_duallistbox_demo1[]" style="display: none;"></label>
						   <select multiple="multiple" id="phraseSymbolSelect" class="form-control" name="symbolSelect" onclick="IEsupportPastePhraseSym(this)" style="height: 270px;">
							</select>
						</div>
					</div>
         		</div>
       			<hr style="color:#d0d0d0;margin:0"/>
            	<div align="center" style="padding-left:30px; padding-right:10px; padding-bottom:10px;">
		            <button id="ruleButton" onclick="saveRuleLogic()" type="button" class="btn btn-info btn-sm" style="width:75px;height:30px;margin-right:15px"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
		            <button type="reset" onclick="clearRuleLogic()" class="btn btn-sm" data-dismiss="modal" style="width:75px;height:30px;margin-right:25px"><i class="ace-icon fa fa-undo bigger-110" ></i>取消</button>
		        </div>
      		</div>
      	</div>
	</div>
	<!-- 删除词组modal -->
	<div class="modal fade" id="deleteLexiconModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
		<div class="modal-dialog">
	    	<div class="modal-content">
	        	<div class="modal-header">
		        	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
		                  &times;
		            </button>
		            <h4 class="modal-title" id="myModalLabel">
		              	  信息提示
		            </h4>
	         	</div>
		        <div class="modal-body" id="hint" align="center">
		      		   确定要删除当前资源？
		        </div>
		        <input id="deleteId" name="deleteId" type="hidden" />
	        	<hr style="margin-bottom: 10px;"/>
			  	<div align="center" style="padding-right: 0px;padding-bottom: 0px; padding-bottom: 15px;">
					<button id="deleteLexiconButton" onclick="deleteLexicon()" type="button" class="btn btn-info btn-sm"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
		            <button type="reset" class="btn btn-sm" data-dismiss="modal"><i class="ace-icon fa fa-undo bigger-110"></i>取消</button>
		        </div>
      		</div>
		</div>
	</div>
	
	<!-- 删除短语modal -->
	<div class="modal fade" id="deletePhraseModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
		<div class="modal-dialog">
	    	<div class="modal-content">
	        	<div class="modal-header">
		        	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
		                  &times;
		            </button>
		            <h4 class="modal-title" id="myModalLabel">
		              	  信息提示
		            </h4>
	         	</div>
		        <div class="modal-body" id="hint" align="center">
		      		   确定要删除当前资源？
		        </div>
		        <input id="deletePId" name="deletePId" type="hidden" />
	        	<hr style="margin-bottom: 10px;"/>
			  	<div align="center" style="padding-right: 0px;padding-bottom: 0px; padding-bottom: 15px;">
					<button id="deletePhraseButton" onclick="deletePhrase()" type="button" class="btn btn-info btn-sm"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
		            <button type="reset" class="btn btn-sm" data-dismiss="modal"><i class="ace-icon fa fa-undo bigger-110"></i>取消</button>
		        </div>
      		</div>
		</div>
	</div>
<!-- 删除逻辑modal -->
	<div class="modal fade" id="deleteLogicModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
		<div class="modal-dialog">
	    	<div class="modal-content">
	        	<div class="modal-header">
		        	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
		                  &times;
		            </button>
		            <h4 class="modal-title" id="myModalLabel">
		              	  信息提示
		            </h4>
	         	</div>
		        <div class="modal-body" id="hint" align="center">
		      		   确定要删除当前资源？
		        </div>
		        <input id="deleteLogicId" name="deleteLogicId" type="hidden" />
	        	<hr style="margin-bottom: 10px;"/>
			  	<div align="center" style="padding-right: 0px;padding-bottom: 0px; padding-bottom: 15px;">
					<button id="deleteLogicButton" onclick="deleteLogic()" type="button" class="btn btn-info btn-sm"><i class="ace-icon fa fa-check bigger-110"></i>确定</button> 
		            <button type="reset" class="btn btn-sm" data-dismiss="modal"><i class="ace-icon fa fa-undo bigger-110"></i>取消</button>
		        </div>
      		</div>
		</div>
	</div>
<!-- <![endif]-->

<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='../assets/js/jquery1x.js'>"+"<"+"/script>");
</script>
<![endif]-->

<!-- inline scripts related to this page -->
<script type="text/javascript">
$(function(){
	initForm();
	placeHolderBug();
	checkButton();

});
function checkButton(){
	$(".btn-next").hover(function(){
		if($("#name").val()==$("#name").attr("placeholder")){
			$("#name").val("");
		}
	})
	$(".btn-next").hover(function(){
		if($("#scriptContent").val()==$("#scriptContent").attr("placeholder")){
			$("#scriptContent").val("");
		}
	})
	
}
function placeHolderBug(){
	if(!placeholderSupport()){   // 判断浏览器是否支持 placeholder 
	    $('[placeholder]').focus(function() { 
	        var input = $(this); 
	        if (input.val() == input.attr('placeholder')) { 
	            input.val(''); 
	            input.removeClass('placeholder'); 
	            input.css("color","#393939");
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
//初始化页面
function initForm(){
	var uuid = window.parent.getEditUuid();
	
	var data = {};
	if(uuid != null) {
		data.uuid = uuid;
	}

	$.post("../autoRule/getAutoRules",{},function(result) {
		initAutoRulesSelect(result.obj);			
	},"json").error(function(e) {
		Modal_Alert('自动质检规则管理','加载数据失败');
	});
	$.post("../autoRule/getFormInfo", data, function(result) {
		if(!result.success)
			return;
		if(uuid != null) {
			initData(result.obj.rules, result.obj.commonLexiconList,result.obj.lexiconList,result.obj.phraseList,result.obj.logicList);
			
		}else{
			initCommoneData(result.obj.commonLexiconList);
		}
	},"json").error(function(e) {
		Modal_Alert('自动质检规则管理','加载数据失败');
	});
}

var rules = new Object();
var tagArray = new Array();
//词组数组
var lexiconArray = new Array();
//通用词组数组
var commonLexiconArray = new Array();
//短语数组
var phraseArray = new Array();
//逻辑数组
var logicArray= new Array();
//词组间的逻辑运算符数据
var symbolArray = new Array("|","#","&",">","!","(",")","[","]","{","}");
//短语间的逻辑运算符号
var phraseSymbolArray = new Array("|","#","&","!",">","(",")","[","]","{","}");
var flag = false;
var lId = 0;
var commonLId=0;
var pId = 0;
var logicId=0;
var uuid = "";
//增加还是修改的标识
var flagOpt = false;

//点击取消关闭Iframe
function closeWindow() {
	window.parent.clearIFrame();
	window.parent.getAllRecord();

}
//增加词组
function addLexiconFun(){
	flagOpt = true;
	var inputList=$("#lexiconModal").find("input");
	for(var i=0;i<inputList.length;i++){
		inputList[i].value="";
	}
	createWidget();
	$("#lexiconModal").modal("show");
}
//修改词组
function editLexiconFun(_id) {
	flagOpt = false;
	createWidget();
	var lexicon = lexiconArray[_id];
	setLexiconData(lexicon);
	$("input").each(function(){
		if($(this).val()!=$(this).attr('placeholder')){
			$(this).css("color","#393939");
		}else{
			$(this).css("color","#c0c0c0");
		}
	});
	$("#lexiconModal").modal("show");
}
//删除词组
function deleteLexiconFun(_id) {
	$("#deleteId").val(_id);
	$("#deleteLexiconModal").modal("show");
}
//增加短语
function addPhraseFun() {
	flagOpt = true;
	initlexiconSelect();
	$("#phraseModal").modal("show");
	var inputList=$("#phraseModal").find("input");
	for(var i=0;i<inputList.length;i++){
		inputList[i].value="";
	}
}
//增加规则逻辑模式框
function addRuleFun() {
	flagOpt = true;
	initPhraseSelect();
	$("#logicModal").modal("show");
	var inputList=$("#logicModal").find("input");
	for(var i=0;i<inputList.length;i++){
		inputList[i].value="";
	}
}
function initLogic(){
	var logic = new Object();
	logic.content = $("#scriptContent").val();
	return logic;
}
//清除逻辑信息
function clearLogicData(){
	$("#scriptContent").val('');
}
/** -- 逻辑信息保存列表 -- */
function saveLogicData(logic) {
	var html = "<tr id='logictr" + logic.id + "'>";
	
	html += createLogicHtml(logic);
	
	html += "</tr>";
	$("#logicBody").html($("#logicBody").html() + html);
}
//拼接逻辑列表行的html内容
function createLogicHtml(logic) {
	var html = "";

	html += '<td class="ruleTd">' + logic.number + '</td>';
	html += '<td class="ruleTd">' + logic.content + '</td>';
	
	html += '<td class="ruleTd"><a href="javascript:void(0)" onclick="editLogicFun(\'' + logic.id + '\')">编辑</a>&nbsp;&nbsp;' + 
			'<a href="javascript:void(0)" onclick="deleteLogicFun(\'' + logic.id + '\')">删除</a></td>';
	
	return html;
}
//更新逻辑的列表显示
function updateLogicData(logic) {
	$("#logictr" + logic.id).html(createLogicHtml(logic));
}
//保存逻辑
function saveRuleLogic() {
	if($("#scriptContent").val()==$("#scriptContent").attr("placeholder")){
		Modal_Alert('自动质检规则管理','请输入逻辑内容！');
		return;
	}
	if(flagOpt) {
		var logic = initLogic();
		logic.id = logicId++;
		logic.number = logic.id + 1;
		logicArray[logicArray.length] = logic;
		saveLogicData(logic);
		clearLogicData(logic);
		$("#logicModal").modal("hide");
	}else if(!flagOpt&&($("#logicuuid").val()=="")){
		var logic = initLogic();
		logic.id = $("#logicId").val();
		logic.number = $("#logicNumber").val();
		logicArray[logic.id] = logic;
		updateLogicData(logic);
		clearLogicData(logic);
		$("#logicModal").modal("hide");
	}
	else {
		var logic = initLogic();
		logic.uuid = $("#logicuuid").val();
		logic.id = $("#logicId").val();
		logic.number = $("#logicNumber").val();
		logicArray[logic.id] = logic;
		updateLogicData(logic);
		clearLogicData(logic);
		$("#logicModal").modal("hide");
	}
}
//修改逻辑
function editLogicFun(_id){
	flagOpt = false;
	var logic = logicArray[_id];
	setLogicData(logic);
	initPhraseSelect();
	$("#logicModal").modal("show");
}
function setLogicData(logic) {
	$("#logicuuid").val(logic.uuid);
	$("#logicId").val(logic.id);
	$("#logicNumber").val(logic.number);
	$("#scriptContent").val(logic.content);
	
}
//删除逻辑
function deleteLogicFun(_id) {
	$("#deleteLogicId").val(_id);
	$("#deleteLogicModal").modal("show");
}
//删除逻辑
function deleteLogic(){
	var deleteId = $("#deleteLogicId").val();
	logicArray.splice(deleteId, 1);
	$("#logicBody").html("");
	logicId = 0;
	
	var html = "";	
	for(var i=0;i<logicArray.length;i++) {
		logicArray[i].id = logicId++;
		logicArray[i].number = logicArray[i].id + 1;
		
		html += "<tr id='logictr" + logicArray[i].id + "'>";
		html += createLogicHtml(logicArray[i]);
		html += "</tr>";
	}
	$("#logicBody").html(html);
	$("#deleteLogicModal").modal("hide");
}
/** -- 短语信息保存列表 -- */
function savePhraseData(phrase) {
	var html = "<tr id='ptr" + phrase.id + "'>";
	
	html += createPhraseHtml(phrase);
	
	html += "</tr>";
	$("#pbody").html($("#pbody").html() + html);
}

//修改短语
function editPhraseFun(_id){
	flagOpt = false;
	var phrase = phraseArray[_id];
	setPhraseData(phrase);
	initlexiconSelect();
	$("input").each(function(){
		if($(this).val()!=$(this).attr('placeholder')){
			$(this).css("color","#393939");
		}else{
			$(this).css("color","#c0c0c0");
		}
	});
	$("#phraseModal").modal("show");
}
//删除短语
function deletePhraseFun(_id) {
	$("#deletePId").val(_id);
	$("#deletePhraseModal").modal("show");
}
/** -- 创建词组添加控件 -- */
function createWidget() {
	var lexiconValueDiv = $("#lexiconValueDiv");
	var html = "";
	lexiconValueDiv.html("值列表");
	html += '<div class="tags" style="border-color:#72aec2; max-height:100px; overflow-y:auto; overflow-x:hidden; width:300px; margin-top:5px;">' + 
			'<div id="tags"></div><input id="equalValue" ' + 
			'name="equalValue" type="text" placeholder="请输入词组内容,按回车键保存..." ' +
				'onkeydown="enterSearch()"></div>';
	$("#lexiconValueDiv").html(html);
	placeHolderBug();
}

//增加词组
function lexicon() {
	if($("#lexiconName").val()==$("#lexiconName").attr("placeholder")){
		Modal_Alert('自动质检规则管理','请输入词组名称！');
		return;
	}
	if(flagOpt) {
		for(var i=0; i<lexiconArray.length; i++) {
			if($("#lexiconName").val() == lexiconArray[i].name) {
				Modal_Alert('自动质检规则管理','词组名称重复，请重新输入！');
				return;
			}
		}
		var lexicon = initLexicon();
		if(!validateLexicon(lexicon)){
			return;
		}
		lexicon.id = lId++;
		lexicon.number = lexicon.id + 1;
		lexiconArray[lexiconArray.length] = lexicon;
		saveLexiconData(lexicon);
		clearLexiconData();
		$("#lexiconModal").modal("hide");
	}else if(!flagOpt&&($("#luuid").val()=="")){
		for(var i=0; i<lexiconArray.length; i++) {
			if($("#lexiconName").val() == lexiconArray[i].name 
					&& $("#lexiconId").val() != lexiconArray[i].id) {
				Modal_Alert('规则集管理','词组名称重复，请重新输入！');
				return;
			}
		}
		var lexicon = initLexicon();
		lexicon.id = $("#lexiconId").val();
		lexicon.number = $("#lexiconNumber").val();
		
		if(!validateLexicon(lexicon)){
			return;
		}
		lexiconArray[lexicon.id] = lexicon;
		updateLexiconData(lexicon);
		clearLexiconData();
		$("#lexiconModal").modal("hide");
	}
	else {
		for(var i=0; i<lexiconArray.length; i++) {
			if($("#lexiconName").val() == lexiconArray[i].name 
					&& $("#lexiconId").val() != lexiconArray[i].id) {
				Modal_Alert('规则集管理','词组名称重复，请重新输入！');
				return;
			}
		}
		var lexicon = initLexicon();
		lexicon.uuid = $("#luuid").val();
		lexicon.id = $("#lexiconId").val();
		lexicon.number = $("#lexiconNumber").val();
		
		if(!validateLexicon(lexicon)){
			return;
		}
		lexiconArray[lexicon.id] = lexicon;
		updateLexiconData(lexicon);
		clearLexiconData();
		$("#lexiconModal").modal("hide");
	}
	
}
//生成lexicon对象
function initLexicon(){
	var lexicon = new Object();
	lexicon.name = $("#lexiconName").val();
	var s = "";
	for(var i=0;i<tagArray.length;i++) {
		s += tagArray[i];
		if(i!=tagArray.length - 1) {
			s += ",";
		}
	}
	lexicon.content = s;
	return lexicon;
}

//修改词组回显词组信息
function setLexiconData(lexicon) {
	$("#luuid").val(lexicon.uuid);
	$("#lexiconId").val(lexicon.id);
	$("#lexiconNumber").val(lexicon.number);
	$("#lexiconName").val(lexicon.name);
	
	tagArray = lexicon.content.split(",");
	for(var i=0;i<tagArray.length;i++) {
		createTag(tagArray[i]);
	}
}

/** -- 词组信息保存列表 -- */
function saveLexiconData(lexicon) {
	var html = "<tr id='ltr" + lexicon.id + "'>";
	
	html += createLexiconHtml(lexicon);
	
	html += "</tr>";
	$("#lbody").html($("#lbody").html() + html);
}

//更新词组列表显示信息
function updateLexiconData(lexicon) {
	$("#ltr" + lexicon.id).html(createLexiconHtml(lexicon));
}

//生成词组列表行的html内容
function createLexiconHtml(lexicon) {
	var html = "";

	html += '<td class="ruleTd">' + lexicon.number + '</td>';
	html += '<td class="ruleTd">' + lexicon.name + '</td>';
	html += '<td class="ruleTd">' + lexicon.content + '</td>';
	
	html += '<td class="ruleTd"><a href="javascript:void(0)" onclick="editLexiconFun(\'' + lexicon.id + '\')">编辑</a>&nbsp;&nbsp;' + 
			'<a href="javascript:void(0)" onclick="deleteLexiconFun(\'' + lexicon.id + '\')">删除</a></td>';
	
	return html;
}

//清除词组数据
function clearLexiconData() {
	$("#lexiconName").val("");
	for(var i=0;i<tagArray.length;i++) {
		$("#" + tagArray[i]).remove();
	}
	tagArray = new Array();
}

//删除词组
function deleteLexicon(_id){
	var deleteId = $("#deleteId").val();
	for(var i=0;i<phraseArray.length;i++) {
		if((phraseArray[i].content).indexOf("lexicon_"+lexiconArray[deleteId].name)>-1){
			Modal_Alert('自动质检规则管理','词组已被引用，无法删除！');
			$("#deleteLexiconModal").modal("hide");
			return;
		}
	}
	
	lexiconArray.splice(deleteId, 1);
	$("#lbody").html("");
	lId = 0;
	
	var html = "";	
	for(var i=0;i<lexiconArray.length;i++) {
		lexiconArray[i].id = lId++;
		lexiconArray[i].number = lexiconArray[i].id + 1;
		
		html += "<tr id='ltr" + lexiconArray[i].id + "'>";
		html += createLexiconHtml(lexiconArray[i]);
		html += "</tr>";
	}
	$("#lbody").html(html);
	$("#deleteLexiconModal").modal("hide");
}

//删除短语
function deletePhrase(_id){
	var deleteId = $("#deletePId").val();
	for(var i=0;i<logicArray.length;i++) {
		if((logicArray[i].content).indexOf("phrase_"+phraseArray[deleteId].name)>-1){
			Modal_Alert('自动质检规则管理','短语已被引用，无法删除！');
			$("#deletePhraseModal").modal("hide");
			return;
		}
	}
	phraseArray.splice(deleteId, 1);
	$("#pbody").html("");
	pId = 0;
	
	var html = "";	
	for(var i=0;i<phraseArray.length;i++) {
		phraseArray[i].id = pId++;
		phraseArray[i].number = lexiconArray[i].id + 1;
		
		html += "<tr id='ptr" + phraseArray[i].id + "'>";
		html += createPhraseHtml(phraseArray[i]);
		html += "</tr>";
	}
	$("#pbody").html(html);
	$("#deletePhraseModal").modal("hide");
}

//保存短语
function phrase() {
	if($("#phraseName").val()==$("#phraseName").attr("placeholder")){
		Modal_Alert('自动质检规则管理','请输入短语名称！');
		return;
	}
	if($("#phraseContent").val()==$("#phraseContent").attr("placeholder")){
		Modal_Alert('自动质检规则管理','请输入规则内容！');
		return;
	}
	if(flagOpt) {
		for(var i=0; i<phraseArray.length; i++) {
			if($("#phraseName").val() == phraseArray[i].name) {
				Modal_Alert('自动质检规则管理','短语名称重复，请重新输入！');
				return;
			}
		}
		var phrase = initPhrase();
		if(!validatePhrase(phrase)){
			return;
		}
		phrase.id = pId++;
		phrase.number = phrase.id + 1;
		phraseArray[phraseArray.length] = phrase;
		savePhraseData(phrase);
		clearPhraseData(phrase);
		$("#phraseModal").modal("hide");
	}else if(!flagOpt&&($("#puuid").val()=="")){
		for(var i=0; i<phraseArray.length; i++) {
			if($("#phraseName").val() == phraseArray[i].name 
					&& $("#phraseId").val() != phraseArray[i].id) {
				Modal_Alert('规则集管理','短语名称重复，请重新输入！');
				return;
			}
		}
		var phrase = initPhrase();
		phrase.id = $("#phraseId").val();
		phrase.number = $("#phraseNumber").val();
		
		if(!validatePhrase(phrase)){
			return;
		}
		phraseArray[phrase.id] = phrase;
		updatePhraseData(phrase);
		clearPhraseData(phrase);
		$("#phraseModal").modal("hide");
	}
	else {
		for(var i=0; i<phraseArray.length; i++) {
			if($("#phraseName").val() == phraseArray[i].name 
					&& $("#phraseId").val() != phraseArray[i].id) {
				Modal_Alert('规则集管理','短语名称重复，请重新输入！');
				return;
			}
		}
		var phrase = initPhrase();
		phrase.uuid = $("#puuid").val();
		phrase.id = $("#phraseId").val();
		phrase.number = $("#phraseNumber").val();
		
		if(!validatePhrase(phrase)){
			return;
		}
		phraseArray[phrase.id] = phrase;
		updatePhraseData(phrase);
		clearPhraseData(phrase);
		$("#phraseModal").modal("hide");
	}
}

//初始化添加短语时的可选词组
function initlexiconSelect(){
	//var type = 1;
	var lexiconHtml = "";
	var commonLexiconHtml = "";
	var symbolHtml = "";
	for(var i=0;i<commonLexiconArray.length;i++) {
		commonLexiconHtml += "<option value='" + commonLexiconArray[i].name + "'>lexicon_" + commonLexiconArray[i].name + "</option>";
	}
	for(var i=0;i<lexiconArray.length;i++) {
		lexiconHtml += "<option value='" + lexiconArray[i].name + "'>lexicon_" + lexiconArray[i].name + "</option>";
	}
	for(var i=0;i<symbolArray.length;i++) {
		symbolHtml += "<option value='" + symbolArray[i] + "'>" + symbolArray[i] + "</option>";
	}
	$('#commonLexiconSelect').html(commonLexiconHtml);
	$('#lexiconSelect').html(lexiconHtml);
	$('#symbolSelect').html(symbolHtml);
}

//初始化添加逻辑时的可选短语
function initPhraseSelect(){
	//var type = 2;
	var phraseHtml = "";
	var phraseSymbolHtml = "";
	for(var i=0;i<phraseArray.length;i++) {
		phraseHtml += "<option value='" + phraseArray[i].name + "' >phrase_" + phraseArray[i].name + "</option>";
	}
	for(var i=0;i<symbolArray.length;i++) {
		phraseSymbolHtml += "<option value='" + phraseSymbolArray[i] + "' >" + phraseSymbolArray[i] + "</option>";
	}
	$('#phraseSelect').html(phraseHtml);
	$('#phraseSymbolSelect').html(phraseSymbolHtml);
}
/*
//粘贴选中数组名称
function pasteValue(value,type){
	var prefix = '';
	var perContent = '';
	if(type==1){
		prefix = 'phrase';
		perContent = 'lexicon_';
	}else if(type==2){
		prefix = 'script';
		perContent = 'phrase_';
	}
	var contentVal = $('#'+prefix+'Content').val();
	contentVal += perContent+value;
	$('#'+prefix+'Content').val(contentVal);
}
*/
//支持IE选择
function IEsupportPasteLexicon(obj){
	var prefix = 'phrase';
	var perContent = 'lexicon_';
	var contentVal = $('#'+prefix+'Content').val();
	if(contentVal==$.trim($('#'+prefix+'Content').attr('placeholder'))){
		contentVal='';
	}
	var value=$(obj).val();
	if(value==null){
		return ;
	}
	contentVal += perContent+value;
	$('#'+prefix+'Content').val(contentVal);
	var text=$('#'+prefix+'Content').val();
	$('#'+prefix+'Content').focus();
	$('#'+prefix+'Content').val("");
	$('#'+prefix+'Content').val(text);
}
//支持IE选择
function IEsupportPasteLexiconSym(obj){
	var prefix = 'phrase';
	var contentVal = $('#'+prefix+'Content').val();
	if(contentVal==$.trim($('#'+prefix+'Content').attr('placeholder'))){
		contentVal='';
	}
	var value=$(obj).val();
	if(value==null){
		return ;
	}
	contentVal +=value;
	$('#'+prefix+'Content').focus();
	$('#'+prefix+'Content').val("");
	$('#'+prefix+'Content').val(contentVal);
}

//支持IE选择
function IEsupportPastePhrase(obj){
	var prefix = 'script';
	var perContent = 'phrase_';
	var contentVal = $('#'+prefix+'Content').val();
	if(contentVal==$.trim($('#'+prefix+'Content').attr('placeholder'))){
		contentVal='';
	}
	var value=$(obj).val();
	if(value==null){
		return ;
	}
	contentVal += perContent+value;
	$('#'+prefix+'Content').val(contentVal);
}
//支持IE选择
function IEsupportPastePhraseSym(obj){
	var prefix = 'script';
	var contentVal = $('#'+prefix+'Content').val();
	if(contentVal==$.trim($('#'+prefix+'Content').attr('placeholder'))){
		contentVal='';
	}
	var value=$(obj).val();
	if(value==null){
		return ;
	}
	contentVal +=value;
	$('#'+prefix+'Content').val(contentVal);
}
/*
//粘贴选择的符号
function pasteSymValue(i,type){
	var prefix = '';
	var value = '';
	if(type==1){
		prefix = 'phrase';
		value = symbolArray[i];
	}else if(type==2){
		prefix = 'script';
		value = phraseSymbolArray[i];
	}
	var contentVal = $('#'+prefix+'Content').val();
	
	contentVal += value;
	$('#'+prefix+'Content').val(contentVal);
}
*/
//生成phrase
function initPhrase(){
	var phrase = new Object();
	phrase.name = $("#phraseName").val();
	phrase.content = $("#phraseContent").val();
	return phrase;
}

/** -- 短语信息保存列表 -- */
function savePhraseData(phrase) {
	var html = "<tr id='ptr" + phrase.id + "'>";
	
	html += createPhraseHtml(phrase);
	
	html += "</tr>";
	$("#pbody").html($("#pbody").html() + html);
}

//更新短语的列表显示
function updatePhraseData(phrase) {
	$("#ptr" + phrase.id).html(createPhraseHtml(phrase));
}

//拼接短语列表行的html内容
function createPhraseHtml(phrase) {
	var html = "";

	html += '<td class="ruleTd">' + phrase.number + '</td>';
	html += '<td class="ruleTd">' + phrase.name + '</td>';
	html += '<td class="ruleTd">' + phrase.content + '</td>';
	
	html += '<td class="ruleTd"><a href="javascript:void(0)" onclick="editPhraseFun(\'' + phrase.id + '\')">编辑</a>&nbsp;&nbsp;' + 
			'<a href="javascript:void(0)" onclick="deletePhraseFun(\'' + phrase.id + '\')">删除</a></td>';
	
	return html;
}

/** -- 短语回显 -- */
function setPhraseData(phrase) {
	$("#puuid").val(phrase.uuid);
	$("#phraseId").val(phrase.id);
	$("#phraseNumber").val(phrase.number);
	$("#phraseName").val(phrase.name);
	$("#phraseContent").val(phrase.content);
	
}

//清除短语信息
function clearPhraseData(){
	$("#phraseName").val('');
	$("#phraseContent").val('');
}

/** -- 规则维护添加页面模糊查询控件 -- */
function enter(e) {
	enterSearch(e, 'no');	
}

function initAutoRulesSelect(autoRulesList){
	$("#autoRulesId").select2({
		minimumResultsForSearch: -1,
		data:autoRulesList
	});
}
function initCommoneData(commonLexiconList){
	var commonLexicon=null;
	
	for(var i=0; i<commonLexiconList.length; i++) {
		commonLexicon = new Object();
		
		commonLexicon.uuid = commonLexiconList[i][0];
		commonLexicon.name = commonLexiconList[i][1];
		commonLexicon.content = commonLexiconList[i][2];
		commonLexiconArray[i] = commonLexicon;
	}
}
//初始化数据
function initData(rules,commonLexiconList, lexiconList, phraseList,logicList) {
	uuid = rules.uuid;
	$("#state").val(rules.state);
	$("#name").val(rules.name);
	$("#remark").val(rules.remark);
	$("#autoRulesId").select2('val',rules.autoRulesId);
	$("#scriptContent").val(rules.script);
	var lexicon = null, phrase = null;var commonLexicon=null;
	
	for(var i=0; i<commonLexiconList.length; i++) {
		commonLexicon = new Object();
		
		commonLexicon.uuid = commonLexiconList[i][0];
		commonLexicon.name = commonLexiconList[i][1];
		commonLexicon.content = commonLexiconList[i][2];
		commonLexiconArray[i] = commonLexicon;
	}
	for(var i=0; i<lexiconList.length; i++) {
		lexicon = new Object();
		
		lexicon.id = lId++;
		lexicon.number = lexicon.id + 1;
		
		lexicon.uuid = lexiconList[i].uuid;
		lexicon.name = lexiconList[i].name;
		lexicon.content = lexiconList[i].content;
		saveLexiconData(lexicon);
		lexiconArray[i] = lexicon;
	}
	for(var i=0; i<phraseList.length; i++) {
		phrase = new Object();
		
		phrase.id = pId++;
		phrase.number = phrase.id + 1;
		
		phrase.uuid = phraseList[i].uuid;
		phrase.name = phraseList[i].name;
		phrase.content = phraseList[i].content;

		savePhraseData(phrase);
		phraseArray[i] = phrase;
	}
	for(var i=0; i<logicList.length; i++) {
		logic = new Object();
		
		logic.id = logicId++;
		logic.number = logic.id + 1;
		
		logic.uuid = logicList[i].uuid;
		logic.content = logicList[i].content;

		saveLogicData(logic);
		logicArray[i] = logic;
	}
	$("input").each(function(){
		if($(this).val()!=$(this).attr('placeholder')){
			$(this).css("color","#393939");
		}else{
			$(this).css("color","#c0c0c0");
		}
	});
}


function enterSearch(e, is) {
	var e = e || window.event; 
	var code = e.keyCode||e.which||e.charCode;
	if(code == 13){
		if(is == 'no') {
			window.event.returnValue = false;
			return;
		}
		
		if(!flag) {
			flag = true;
			
			var value = $("#equalValue").val();
			
			value = stripScript(value);
			if(trim(value) == '') {
				Modal_Alert('自动质检规则管理','输入不合法，请重新输入！');
				flag = false;
				return;
			}
			
			for(var i=0;i<tagArray.length;i++) {
				if(value == tagArray[i]) {
					$("#" + value).addClass("tag-warning");
					setTimeout("clearTagClass('" + value + "')",700);
					flag = false;
					return;
				}
			}
			
			tagArray[tagArray.length] = value;
			createTag(value);
			
			flag = false;
		} else {
			flag = false;
		}
	} 
}

//创建词组添加的关键词标签
function createTag(value) {
	var html = $("#tags").html();
	html += '<span class="tag" id="' + value + '">'+ value + 
		'<button type="button" class="close" onclick="clearTag(\'' + value +
		'\')">×</button></span>';
	$("#tags").html(html);
	
	$("#equalValue").val('');
}

function clearTagClass(value) {
	$("#" + value).removeClass("tag-warning");
}

function clearTag(value) {
	$("#" + value).remove();
	for(var i=0;i<tagArray.length;i++) {
		if(value == tagArray[i]) {
			tagArray.splice(i, 1);
			break;
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

/** -- 验证词组 -- */
function validateLexicon(lexicon) {
	if(isNull(lexicon.name, "请填写词组名称", 1)) {
		return false;
	}
	if(isNull(lexicon.content, "请填写词组内容", 1)) {
		return false;
	}
	return true;
}

/** -- 验证短语 -- */
function validatePhrase(phrase) {
	if(isNull(phrase.name, "请填写短语名称", 2)) {
		return false;
	}
	if(isNull(phrase.content, "请填写规则内容", 2)) {
		return false;
	}
	return true;
}

/** -- 判断是否为空 -- */
function isNull(value, name, type) {
	if(value == null || value == '') {
		var prefix = '';
		if(type == 1) {
			prefix = '词组维护';
		} else if(type == 2) {
			prefix = '短语维护';
		}
		Modal_Alert(prefix, name);
		return true;
	}
	return false;
}

jQuery(function($) {
	$(".select2").css('width','200px').select2({allowClear:true})
		.on('change', function(){
			$(this).closest('form').validate().element($(this));
	}); 
		
	$('#fuelux-wizard-container')
		.ace_wizard({
			//step: 2 //optional argument. wizard will jump to step "2" at first
			//buttons: '.wizard-actions:eq(0)'
		})
		
		.on('actionclicked.fu.wizard' , function(e, info){
			var direction = info.direction;
			if(direction == 'previous') {
				return;
			}

			if(info.step == 1) {
				if(!$('#basicForm').valid()) {
					e.preventDefault();
				}
				
				rules.name = $("#name").val();
				rules.state = $("#state").val();
				rules.remark = $("#remark").val();
				rules.autoRulesId = $("#autoRulesId").val();
				
			} else if(info.step == 2) {
				if(lexiconArray.length <= 0) {
					Modal_Alert('自动质检规则维护', '词组不能为空，请添加词组!');
					e.preventDefault();
				}
				
				rules.lexiconList = new Array();
				
				var lexicon = null;
				for(var i=0; i<lexiconArray.length; i++) {
					lexicon = new Object();
					lexicon.uuid = lexiconArray[i].uuid;
					lexicon.name = lexiconArray[i].name;
					lexicon.content = lexiconArray[i].content;
					rules.lexiconList[rules.lexiconList.length] = lexicon;
				}
			} else if(info.step == 3) {
				if(phraseArray.length <= 0) {
					Modal_Alert('自动质检规则维护', '短语不能为空，请添加短语!');
					e.preventDefault();
				}
				
				rules.phraseList = new Array();
				
				var phrase = null;
				for(var i=0; i<phraseArray.length; i++) {
					phrase = new Object();
					phrase.uuid = phraseArray[i].uuid;
					phrase.name = phraseArray[i].name;
					phrase.content = phraseArray[i].content.replace("，",",");
					rules.phraseList[rules.phraseList.length] = phrase;
				}
				
			}
			
			//初始化可选短语的下拉组件
			initPhraseSelect();
		})
		
		.on('finished.fu.wizard', function(e) {
			if(logicArray.length <= 0) {
				Modal_Alert('自动质检规则维护', '逻辑不能为空，请添加逻辑!');
				e.preventDefault();
				return;
			}
			
			rules.logicList = new Array();
			
			var logic = null;
			rules.script='';
			for(var i=0; i<logicArray.length; i++) {
				logic = new Object();
				logic.uuid = logicArray[i].uuid;
				logic.content = logicArray[i].content.replace("，",",");
				rules.logicList[rules.logicList.length] = logic;
				if(''!=rules.script){
					rules.script = rules.script+","+logicArray[i].content;
				}else{
					rules.script = logicArray[i].content;
				}
			
			}
				if(uuid !=null && uuid !=""){
					rules.uuid = uuid;
				}
				var data = JSON.stringify(rules);
				loadmask();
				$.post("../autoRule/add", {json : data}, function(result){
					disloadmask();
					var success = result.success;
					if(success) {
						closeWindow();
						//window.parent.reload();
						initForm();
					} else {
						Modal_Alert('自动质检规则管理', '添加失败!数据异常');
					}
				},"json").error(function(e) {
					disloadmask();
					Modal_Alert('自动质检管理','通讯失败，请重新发起请求！');
				});
			
		});

		/*
		$.mask.definitions['~']='[+-]';
		$('#phone').mask('(999) 999-9999');
	
		
		jQuery.validator.addMethod("phone", function (value, element) {
			return this.optional(element) || /^\(\d{3}\) \d{3}\-\d{4}( x\d{1,6})?$/.test(value);
		}, "Enter a valid phone number.");
		*/
		
		$('#basicForm').validate({
			errorElement: 'div',
			errorClass: 'help-block',
			focusInvalid: false,
			ignore: "",
			rules: {
				name: {
					required: true,
					maxlength: 64
				},
				rulesTypeId: {
					required: true,
					maxlength: 32
				},
				remark: {
					required: false,
					maxlength: 128
				},
			},
	
			messages: {
				name: {
					required: "请填写自动质检规则名称",
					maxlength: "自动质检规则名称长度不能大于64个字符"
				},
				remark: {
					maxlength: "备注长度不能大于128个字符"
				}
			},
	
			highlight: function (e) {
				$(e).closest('.form-group').removeClass('has-info').addClass('has-error');
			},
	
			success: function (e) {
				$(e).closest('.form-group').removeClass('has-error').addClass('has-info');
				$(e).remove();
			},
	
			errorPlacement: function (error, element) {
				if(element.is('input[type=checkbox]') || element.is('input[type=radio]')) {
					var controls = element.closest('div[class*="col-"]');
					if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
					else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
				}
				else if(element.is('.select2')) {
					error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
				}
				else if(element.is('.chosen-select')) {
					error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
				}
				else error.insertAfter(element.parent());
			},
		});
		
		$('#modal-wizard-container').ace_wizard();
		$('#modal-wizard .wizard-actions .btn[data-dismiss=modal]').removeAttr('disabled');
});
</script>
</body>
</html>