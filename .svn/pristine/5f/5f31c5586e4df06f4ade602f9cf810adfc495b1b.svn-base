//音频格式
var audioSampleRate = 8000;
var audioBitsPerSample = 16;
// 1=单声道，2=双声道
var channelType = 1;
// 左声道是用户还是客服， 是用户传”USER”，是客服传”AGENT”，单声道时忽略此参数
var leftChannel = "AGENT";

/*
 * 判断浏览器是否为IE
 */
function IsIE() {
	/*var sUserAgent = navigator.userAgent;
	var isOpera = sUserAgent.indexOf("Opera") > -1;
	var oisIE = sUserAgent.indexOf("compatible") > -1
		&& sUserAgent.indexOf("MSIE") > -1
		&& !isOpera;
		
	if (!oisIE) {
		return false;
	}

	return true;*/
	return ("ActiveXObject" in window);
};

/*
 * 判断某个对象是否为数组中的元素
 */
function indexOfArray(array, obj) {
    for (var i = 0; i < array.length; i++) {
      if (array[i] == obj) {
        return i;
      }
    }
    return -1;
};

/*
 *  加载web服务上的xml文档，返回文档对象
 */
function loadXML(id) {
	// alert("loadXML=" + callTime);
	var xmlDoc = null;
	try {
		var url = "http://" + location.host + "/sap/voice/queryTrans?id=" + id;
		if (window.ActiveXObject) {
			xmlDoc = new ActiveXObject('Msxml2.DOMDocument');
			xmlDoc.async = false;
			xmlDoc.load(url);
		} else if (document.implementation && document.implementation.createDocument) {
			var xmlhttp = new window.XMLHttpRequest();
			xmlhttp.open("GET", url, false);
			xmlhttp.send(null);
			// 超时处理
			if (xmlhttp.responseXML == null) {
				if (xmlhttp.responseText != null) {
					try{
					var data = eval("(" + xmlhttp.responseText + ")");
					}catch(e){
						return xmlDoc;
					}
					var errorResult = data.returnMessage.errorResult;
	        		if (errorResult == "OUT_LOGIN_TIME") {
	        			location.href = redirectHref;
	        		}
				}else{
					return xmlDoc;
				}
			} else {
				// 正常情况
				xmlDoc = xmlhttp.responseXML.documentElement;
			}
		}
	} catch (e) {
		Modal_Alert("错误信息", "加载文档失败！\n" + e.message + "\n" + xml);
		//$.messager.alert("错误信息", "加载文档失败！\n" + e.message + "\n" + xml);
	}
	return xmlDoc;
};

var loadDataTimer;
function loadAudioData(id,platForm) {
	var isOk = false;
	var fileName = "http://" + location.host + "/sap/voice/playRecord?id=" + id+"&platForm="+platForm;
	try {
		swfObj.loadAudio(fileName, audioSampleRate, audioBitsPerSample, channelType, leftChannel);
		isOk = true;
	
	} 
	catch (err) {
		var callFunc = 'loadAudioData("' + id +'","'+platForm+  '")';
		loadDataTimer = setTimeout(callFunc, 50);
		isOk = true;
		
	}
	
	return isOk;
};

/*
 * 播放指定位置的录音
 */
function playTo(start, end) {
	swfObj.playTo( start, end );
}

/*
 * 检查终止时间是否大于结束时间
 */
function checkTime(dtStart, dtEnd) {
	if (dtStart != null && dtStart.length > 0 && dtEnd != null && dtEnd.length > 0) {
		return ((new Date(dtStart.replace(/-/g,"\/"))) <= (new Date(dtEnd.replace(/-/g,"\/"))));
	}
	
	return true;
}
