// xml解析相关
var sentenceRegion = "";

var currentSentence = "";
//保存句子信息的字典
var transSentenceArray = new Array();

var slienceIndex = 0;

function resetTransVariable() {
	sentenceRegion = "";
	overlayRegion = "";
	currentSentence = "";
	transSentenceArray = new Array();
	$("#lrcContent").val("");
}

function parseTransFile(id) {
	var isOk = true;
	
	resetTransVariable();
	
	try {
		var xmlDoc = loadXML(id);
		if (xmlDoc == null) {
			isOk = false;
			return isOk;
		}

		var innerHtml = "";
		var cNodes = xmlDoc.getElementsByTagName("sentence_list")[0].getElementsByTagName("sentence");
		/**lsh**/  //var sNodes = xmlDoc.getElementsByTagName("silence_list")[0].getElementsByTagName("silence");
		sNodes=null;
		sentenceRegion = "";
		
		
		
		for (var i = 0; i < cNodes.length; i++) {
			innerHtml += parseSentenceNode(cNodes[i], i,sNodes);
		}
		//if(slienceIndex<sNodes.length){
		if(slienceIndex<silenceArray.length){
			var sStart = silenceArray[slienceIndex].start+"";
			var sEnd = silenceArray[silenceArray.length-1].end+"";
			//if(Number(silenceTime)*1000<=(Number(sEnd)-Number(sStart))){
				sentenceRegion += sStart + " ";
				sentenceRegion += sEnd + " ";
				sentenceRegion += "静音" + " ";
				innerHtml+='<p class="lrc" id="';
				innerHtml += changeTimeToText(sStart, sEnd, null);
				innerHtml += (Number(sEnd)-Number(sStart))/1000+'秒<span/></p>';
			}
		//}
		
		
		
		document.getElementById("lrcContent").innerHTML=innerHtml;
		$("p.lrc").dblclick(function(){
			playSentence( $(this).attr("id") );
	    } );
	} catch(e) {
		alert("错误信息", "解析trans文档失败!\n" + e.message + "\n" + id);
		//$.messager.alert("错误信息", "解析trans文档失败!\n" + e.message + "\n" + fileNo);
		isOk = false;
	}
	
	return isOk; 
}

/*
 * 解析sentence节点
 */
function parseSentenceNode(node , sentenseIndex,sNodes) {
	
	var content = '<p class="lrc" style="color:green;" id="';
	var startTime = node.getAttribute( "start" );
	var endTime = node.getAttribute( "end" );
	var role = node.getAttribute( "role" );
	if(role=="AGENT"){
		content = '<p class="lrc lrc_agent" style="color:black;" id="';
	
	}
	var sentenceChildren = node.getElementsByTagName( "word" );
	var sentence = node.getElementsByTagName( "text" );
	if(sentence!=null&&sentence.length>0&&sentence[0].childNodes.length>0)
		sentence = sentence[0].childNodes[0];
	var text = "";
	if (typeof(sentence) != "undefined" && sentence != null) {
		text = sentence.nodeValue;
	}
	var emotionNode =  node.getElementsByTagName( "emotion" );
	var speed =  Number(node.getAttribute( "speed" ));
	
/*	if(text==null||text.lenth==0||sentenceChildren.length==0){
		return "";
	}*/
	if(text==null||text.lenth==0){
		return "";
	}
	//静音
	var fStart,lEnd,hasSilence;
	//for(;slienceIndex<sNodes.length;slienceIndex++){
	for(;slienceIndex<silenceArray.length;slienceIndex++){
		var sStart = silenceArray[slienceIndex].start+"";
		var sEnd = silenceArray[slienceIndex].end	;
		if(Number(sEnd)<=Number(startTime)){
			if(!hasSilence){
				fStart = sStart;
				hasSilence = true;
			}
			lEnd = sEnd;
		}else{
			break;
		}
	}
	if(hasSilence/*&&Number(silenceTime)*1000<=(Number(lEnd)-Number(fStart))*/){
		sentenceRegion += fStart + " ";
		sentenceRegion += lEnd + " ";
		sentenceRegion += "静音" + " ";
		content += changeTimeToText(fStart, lEnd, null);
		content += (Number(lEnd)-Number(fStart))/1000+'秒<span/></p><p class="lrc" id="';
	}
	sentenceRegion += startTime + " ";
	sentenceRegion += endTime + " ";
	if ( "AGENT" == role )
		role = "AGENT";
	else
		role = "USER";
	
	sentenceRegion += role + " ";
	content += changeTimeToText(startTime, endTime, role);
	// sentence中word数组
	var wordListArray = new Array();
	
	try {
		//暂时去掉--lsh
	/*	for ( var j = 0; j < sentenceChildren.length; j++ ) {
			var word = new Object;
			var value = sentenceChildren[j].childNodes[0];
			if (value != null) {
				if (typeof(value.nodeValue) != "undefined") {
					word.txt = value.nodeValue;
					//content += sentenceChildren[j].childNodes[0].nodeValue;
				}
				else {
					word.txt = "";
				}
				word.start = sentenceChildren[j].getAttribute( "start" );
				word.end = sentenceChildren[j].getAttribute( "end" );
				wordListArray[word.start] = word;
			} else {
				word.start = sentenceChildren[j].getAttribute( "start" );
				word.end = sentenceChildren[j].getAttribute( "end" );
				//alert("ding: " + start + " to " + end + " " + sentenceChildren[j]);
			}
		}*/
		content += text;
		
	} catch (e) {
		Modal_Alert("错误信息", "获取trans文档通话信息失败!\n" + e.message);
		//$.messager.alert("错误信息", "获取trans文档通话信息失败!\n" + e.message); 
	}
	
	var index = node.getAttribute( "index" );
	var sentenceObj = new Object();
	try {
		// 处理text为空的情况
		var textChildNode = node.getElementsByTagName( "text" )[0].childNodes[0];
		if (typeof(textChildNode) == "undefined" || textChildNode == null) {
			sentenceObj.txt = "";
		} else {
			if (typeof(textChildNode.nodeValue) != "undefined" && textChildNode.nodeValue != null) {
				sentenceObj.txt = textChildNode.nodeValue;
			}
		}
		sentenceObj.start = startTime;
		sentenceObj.end = endTime;
		sentenceObj.wordList = wordListArray;
		transSentenceArray[index] = sentenceObj;
	} catch (e) {
		Modal_Alert("错误信息", "获取trans文档句子文本失败!\n" + e.message);
		//$.messager.alert("错误信息", "获取trans文档句子文本失败!\n" + e.message); 
		return "";
	} 
	//关键词处理
	if(keywordColors!=null&&keywordColors.length>0){
		for(var i=0;i<keywordColors.length;i++){
			var items = keywordColors[i].split("-");
			//alert(items[0] + "-" + items[1]);
			if(items[0]!=null&&items[0].length>0&&content.indexOf(items[0])>=0){
				var reg=new RegExp(items[0],"g");
				content = content.replace(reg,'<span style="color:blue">'+items[0]+"</span>");
			}
		}
	}
	//情绪处理
	if(emotionNode.length>0 && typeof(emotionNode[0].childNodes[0].nodeValue) != "undefined"){
		content += '<span style="color:#EE1289">(情绪:'+emtionMap[emotionNode[0].childNodes[0].nodeValue]+')</span>';
	}
	//语速处理
	if("AGENT" == role&&speed<speedSlow){
		content += '<span style="color:#436EEE">(语速:'+speed.toFixed(2)+'，过慢)</span>';
	}else if("AGENT" == role&&speed>speedFast){
		content += '<span style="color:#CD2626">(语速:'+speed.toFixed(2)+'，过快)</span>';
	}/*else{
		content += '<span>(语速:'+speed+'，正常)</span>';
	}*/
	content += "</p>";
	return content;
}

function playSentence( sentence ){
	//console.log(sentence);
	swfObj.playSentence( sentence );
}

function getSentenceRegion() {
	return sentenceRegion;
}

function getKeyword() {
	return keywordString;
}

function getOverlayRegion(){
	return overlayRegion;
}

function syncLRC( value ) {
	try {
		var priorNode = document.getElementById( currentSentence );
		if ( null != priorNode ) {
			priorNode.style.color = "#000000";
			//priorNode.style.fontSize="20px";
		}
		var currentNode = document.getElementById(value);
		if ( null != currentNode ) {
			// 设定颜色
			currentNode.style.color = "#ff0000";
			//priorNode.style.fontSize="12px";
			// 调整滚动位置
			var container = $( '#lrcContent' )[0];
			var lrcID = '#' + value;
			var lrc = $( lrcID )[0];
			var moveValue = 0;
			if ( lrc.offsetTop <= container.offsetTop ||
				 lrc.offsetTop + lrc.offsetHeight + 20 - container.offsetTop < container.clientHeight ) 
			{
				moveValue = 0;
			} else {
				moveValue = lrc.offsetTop - container.offsetTop - container.clientHeight + lrc.offsetHeight + 20;
			}
			
			if ( moveValue > container.scrollTopMax ) {
				moveValue = container.scrollTopMax;
			}
			container.scrollTop = moveValue;
		}
		currentSentence = value;			
	} catch ( err ){
		Modal_Alert("错误信息", "同步显示句子信息失败!\n" + e.message);
		//$.messager.alert("错误信息", "同步显示句子信息失败!\n" + e.message); 
	}
}
function changeTimeToText(startTime,endTime,role){
	var content = startTime + '">';
	if(role==null){
		content += '<span style="color:##D15FEE">'
	}
	content += '[';
	content += convertTime(startTime);
	/*content += "-";
	content += convertTime(endTime);*/
	content += "]";
	if ( "AGENT" == role ){
		content += "[客服] ";
	} else if(role!=null) {
		content += "[用户] ";
	}else{
		content += "[静音] ";
	}
	return content;
}

function convertTime(time){
	var content = "";
	var minites = parseInt((time / 1000 / 60).valueOf());
	var seconds = parseInt((time / 1000 % 60).valueOf());
	var microseconds = parseInt((time % 1000).valueOf());
	if (minites < 10)
		content += "0" + minites;
	else
		content += minites;
	content += ":";
	if (seconds < 10)
		content += "0" + seconds;
	else
		content += seconds;
	/*if(microseconds<10)
		content += ".00" + microseconds;
	else if(microseconds<100){
		content += ".0" + microseconds;
	}else{
		content += "." + microseconds;
	}*/
	return content;
}