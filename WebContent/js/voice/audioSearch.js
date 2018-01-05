var INTRODUCE_INDEX_SEARCH_MSG = "例如输入: 短信  流量";

// 表格相关
var isReload;

// =====查询相关===== //
var sentencePos; // 句子位置
var interval; // 跳转页的步进
var sentenceStartPos; // 当前页的首句位置
var sentenceEndPos; // 当前页的尾句位置

//flash播放器对象
var swfObj = null;
//文档是否加载完成
var jsReady = false;

var keywordArray = new Array();
var keywordColors = new Array();
var silenceArray = new Array();
var overlayRegion = "";
//关键词
var keywordString = "";
//语速
var speedSlow = 2.5;
var speedFast = 7;
var emtionMap={};
var silenceTime=1;
$(function() {
	//--lsh注释  getVoiceInfo(uuid);
//	getKeywordsWithColor();
//	getSilenceTime();
	
	emtionMap[0]="快乐";
	emtionMap[1]="生气";
	emtionMap[2]="悲伤";
	emtionMap[3]="厌恶";
});
/*
 * 加载音频文件
 */
function openPlayer(id,platForm) {
	var isOk = false;
	if (swfObj == null){
		if ( IsIE() ){
			swfObj = document.getElementById('audioPlayer');
		}
		else {
			swfObj = document.getElementById('audioPlayer_no_ie');
		}
	}
	if (swfObj == null) {
		return isOk;
	}
	isOk = true;
	
	if (!isOk) {
		return isOk;
	}
	// 加载trans文件
	isOk = parseTransFile(id);
	if (!isOk) {		
		return isOk;
	}

	// 加载音频文件
	
	isOk = loadAudioData(id,platForm);
	jsReady = true;

	return isOk;
}

function isReady() {
	return jsReady;
}

/*
 * 回车处理
 */
function onSearchClick(e) {
	var keynum = 0;
	
	if (window.event) { // IE
		keynum = e.keyCode;
	} else if (e.which) { // Netscape/Firefox/Opera
		keynum = e.which;
	}
	
	if (keynum == 13) {
        initSearchCondition();
        if ($.trim($("#searchKeyword").val()) != INTRODUCE_INDEX_SEARCH_MSG) {
          searchCondition.searchKeyword = $.trim($("#searchKeyword").val());
        } else {
          searchCondition.searchKeyword = '';
        }
    
        dataGrid.datagrid('reload');
        
		return false;
	}
	
	return true;
}

/*
 * 清空当前提示信息
 */
function onKeywordFocus() {
	if (INTRODUCE_INDEX_SEARCH_MSG == $.trim($("#searchKeyword").val())) {
		$("#searchKeyword").val("");
		$("#searchKeyword").css({"width":"40%", "color":"#000"});
	}
}

/*
 * 重置提示信息
 */
function onKeywordBlur() {
	if ("" == $.trim($("#searchKeyword").val())) {
		$("#searchKeyword").val(INTRODUCE_INDEX_SEARCH_MSG);
		$("#searchKeyword").css({"width":"40%", "color":"#808080"});
	}
}

function getVoiceInfo(uuid)
{
	$.post("../search/getVoiceInfo", {uuid:uuid}, function (data) {
			var items = data.obj.keyWordList;			if(items!=null&&items.length>0){
				for(var i=0;i<items.length;i++){
					if(i>0&&items[i].beginDate==items[i-1].beginDate){
						continue;
					}
					var key = items[i].keyWord;
					keywordString += parseFloat(items[i].beginDate)*1000+" "+parseFloat(items[i].endDate)*1000+" "+key+" "+items[i].role+" ";
					keywordColors.push(key);
				}
				keywordString = keywordString.substring(0,keywordString.length-1);
				//quickSort(keywordColors,0,keywordColors.length-1);
				quickSort(keywordColors);
			}
			items = data.obj.voiceOverlapList;
			if(items!=null&&items.length>0){
				for(var i=0;i<items.length;i++){
					overlayRegion += parseFloat(items[i].beginDate)*1000+" "+parseFloat(items[i].endDate)*1000+" ";
				}
				overlayRegion = overlayRegion.substring(0,overlayRegion.length-1);
			}
			items = data.obj.silenceList;
			if(items!=null&&items.length>0){
				for(var i=0;i<items.length;i++){
					var sil = {};
					sil.start = parseFloat(items[i].beginDate)*1000;
					sil.end = parseFloat(items[i].endDate)*1000;
					silenceArray.push(sil);
				}
			}
	},"json");
}

/*function quickSort(array,left,right){
	if (array.length <= 1) { return array; }
	if(left<right){
		var key = array[left];
		var low = left;
		var high = right;
		while(low < high){
			while(low < high && array[high].length > key.length){
				high--;
			}
			array[low] = array[high];
			while(low < high && array[low].length < key.length){
				low++;
			}
			array[high] = array[low];
		}
		array[low] = key;
		quickSort(array,left,low-1);
		quickSOrt(array,low+1,right);
	}
}*/

/*function getKeywordsWithColor()
{
	$.post("../keyword/dataGridWithColor", {rows:999999}, function (data) {
		var items = data.rows;
		if(items!=null&&items.length>0){
			for(var i=0;i<items.length;i++){
				var key = items[i].keyword;
				keywordColors.push(key);
			}
		}
	},"json");
}*/

/*function getSilenceTime(){
	$.post("../dictionary/dataGrid", {code:"SILENCE_TIME"}, function (data) {
		var items = data.rows;
		if(items!=null&&items.length>0){
			silenceTime = items[0].text;
		}
	},"json");
}*/

function createTreeGrid(data) {
	var count = 0;
	var level = 0;
	if (data.length > 0) {
		var table = "<thead><td style='width:40%;'>评分标准</td><td style='width:30%;'>得分</td><td style='width:30%;'>备注</td></thead>";
		//table += "<table class=\"tree\">";
		var rootId= 0;
		for (var i = 0; i < data.length; i++) {
			if (typeof(data[i].parentId) == "undefined") {
				rootId = data[i].id;
				table += "<tr class=\"treegrid-";
				table += rootId;
				table += "\"><td>";
				table += data[i].formNodeName;
				table += "</td><td>";
				table += data[i].score;
				table += "</td><td>";
				table += data[i].remark;
				table += "</td></tr>";
				data[i].formNodeType = -1;
				count++;
				break;
			}
		}
		table += building(data, rootId, count, level+1);
		//table += "</table>";
	}
	return table;
}

function building(data, parentId, count, level) {
	var table = "";
	if (count >= data.length) {
		return table;
	}
	for (var i = 0; i < data.length; i++) {
		if (data[i].parentId == parentId) {
			var nextParentId = data[i].id;
			table += "<tr class=\"treegrid-";
			table += nextParentId;
			table += " treegrid-parent-";
			table += parentId;
			table += "\"><td>";
			for (var j = 0; j < level; j++) {
				table += "&nbsp;&nbsp;&nbsp;&nbsp;";
			}
			table += data[i].formNodeName;
			table += "</td><td>";
			table += data[i].score;
			table += "</td><td>";
			table += data[i].remark;
			table += "</td></tr>";
			data[i].formNodeType = -1;
			count++;
			table += building(data, nextParentId, count, level+1);
		}
	}
	return table;
}
