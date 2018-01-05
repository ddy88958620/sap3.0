var preWidth=document.documentElement.clientWidth;
$(document).ready(
		$(window).resize(function() {
			 var nextWidth=document.documentElement.clientWidth;
			 if(preWidth<nextWidth){
				 $(".dataTables_scrollHeadInner").find("table").css("width","100%");
				 $(".dataTables_scrollBody").find("table").css("width","100%");
				 $(".row").css({"position":"absolute","bottom":"18px","width":"100%"});
				 $(".side").css({"top":"16px","height":"99%"});
				 $("#dataTable_paginate").css("padding-bottom","18px");
			 }
		})
);