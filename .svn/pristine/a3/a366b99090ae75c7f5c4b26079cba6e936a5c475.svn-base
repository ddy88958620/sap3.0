var debug=true;


Function.prototype.method = function(name, func) {
	this.prototype[name] = func;
	return this;
};

Array.method('add', function(elem) {
	this.push(elem);
});

Array.method('print', function() {
	var msg = "[";
	for ( var i = 0; i < this.length; i++) {
		if (i > 0)
			msg += ',';
		msg += this[i];
	}
	msg += "]";
});

Array.method('insert', function(index, elem) {

	this.push(0);
	for ( var i = this.length - 1; i >= index; i--) {
		this[i] = this[i - 1];
	}
	if (index < this.length)
		this[i + 1] = elem;
	else
		this[i] = elem;
});

Array.method('swap', function(i, j) {
	var tmp = this[i];
	this[i] = this[j];
	this[j] = tmp;
});

Array.method('removeAt', function(index) {
	for ( var i = index; i < this.length - 1; i++) {
		this[i] = this[i + 1];
	}
	this.pop();
});

/** 获取元素位置(easyui tree) */
Array.method('treeindex', function(elem) {
	var index = -1;
	for ( var i = 0; i < this.length; i++) {
		if (elem.target == this[i].target) {
			index = i;
			break;
		}
	}
	return index;
});

/***  判断数据位置(MyApp.data)。 */
Array.method('dataindex', function(elem){
	var index=-1;
	for (var i=0; i<this.length; i++) {
		if (elem == this[i]){
			index = i;
			break;
		}
	}
	return index;
});
//查找元素位置
Array.prototype.indexOf = function(val) {
	for (var i = 0; i < this.length; i++) {
		if (this[i] == val) return i;
	}
	return -1;
};
//删除元素
Array.prototype.remove = function(val) {
	var index = this.indexOf(val);
	if (index > -1) {
		this.splice(index, 1);
	}
};
Array.prototype.unique = function()
{
	var n = {},r=[]; //n为hash表，r为临时数组
	for(var i = 0; i < this.length; i++) //遍历当前数组
	{
		if (!n[this[i]]) //如果hash表中没有当前项
		{
			n[this[i]] = true; //存入hash表
			r.push(this[i]); //把当前数组的当前项push到临时数组里面
		}
	}
	return r;
}

/** 判断是否可见的过滤函数。 */
function filter_isblock(){
	return $(this).css('display') == 'block';
}
function hi(msg, obj) {
	if (!debug) return;
	if (obj !== undefined){
		try {
			var json = '';
			if (obj.hasOwnProperty('attributes')){
				json = JSON.stringify(getTreeData(obj));
			} else {
				json = JSON.stringify(obj);
			}
			alert(msg + " = " + json);
		}
		catch(err){
			alert(msg + " = " + obj.toString());
		}
	}	
	else
		alert(msg);
}

function log(msg, obj) {
	/*if (!debug || console==undefined) return;
	if (obj !== undefined && obj != null) {
		try {
			var json = '';
			if (obj.hasOwnProperty('attributes')){
				json = JSON.stringify(getTreeData(obj));
			} else {
				json = JSON.stringify(obj);
			}
			console.log(msg + " = " + json);
		} catch (err) {
			console.log(msg + " = " + obj.toString());
		}
	}
	else
		console.log(msg);*/
}

/** 定义函数注释生成字符串（解决多行字符串问题）。 */
function hereDoc(f) {
    return f.toString().replace(/^[^\/]+\/\*!?\s?/, '').replace(/\*\/[^\/]+$/, '');
}

/** 判断对象是否是数组。 */
function isArray(arg){
	return Object.prototype.toString.call(arg) === '[object Array]';
}

/** 规范化字符串（特殊字符导致JSON无法正确解析）。 */
function normalize(content){
	return content.replace('\r','').replace('\n','');
}

/** 将树结点的数据复制到目标（直接JSON.stringy报cirular structure TypeError）。*/
function getTreeData(treedata) {
	var data = {attributes:{}, children:[]};
	if (treedata.hasOwnProperty('attributes')) {
		$.extend(true, data.attributes, treedata.attributes);
	}
	if (treedata.hasOwnProperty('children')){
		for (var i=0;i<treedata.children.length;i++){
			data.children.push(getTreeData(treedata.children[i]));
		}
	}
	return data;
}

Date.prototype.format = function (formatStr) {    
    var date = this;    
    /*   
    函数：填充0字符   
    参数：value-需要填充的字符串, length-总长度   
    返回：填充后的字符串   
    */   
    var zeroize = function (value, length) {    
        if (!length) {    
            length = 2;    
        }    
        value = new String(value);    
        for (var i = 0, zeros = ''; i < (length - value.length); i++) {    
            zeros += '0';    
        }    
            return zeros + value;    
    };    
    return formatStr.replace(/"[^"]*"|'[^']*'|\b(?:d{1,4}|M{1,4}|yy(?:yy)?|([hHmstT])\1?|[lLZ])\b/g, function($0) {    
        switch ($0) {    
            case 'd': return date.getDate();    
            case 'dd': return zeroize(date.getDate());    
            case 'ddd': return ['Sun', 'Mon', 'Tue', 'Wed', 'Thr', 'Fri', 'Sat'][date.getDay()];    
            case 'dddd': return ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'][date.getDay()];    
            case 'M': return date.getMonth() + 1;    
            case 'MM': return zeroize(date.getMonth() + 1);    
            case 'MMM': return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][date.getMonth()];    
            case 'MMMM': return ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'][date.getMonth()];    
            case 'yy': return new String(date.getFullYear()).substr(2);    
            case 'yyyy': return date.getFullYear();    
            case 'h': return date.getHours() % 12 || 12;    
            case 'hh': return zeroize(date.getHours() % 12 || 12);    
            case 'H': return date.getHours();    
            case 'HH': return zeroize(date.getHours());    
            case 'm': return date.getMinutes();    
            case 'mm': return zeroize(date.getMinutes());    
            case 's': return date.getSeconds();    
            case 'ss': return zeroize(date.getSeconds());    
            case 'l': return date.getMilliseconds();    
            case 'll': return zeroize(date.getMilliseconds());    
            case 'tt': return date.getHours() < 12 ? 'am' : 'pm';    
            case 'TT': return date.getHours() < 12 ? 'AM' : 'PM';    
        }    
    });    
};  


function htmlEscape(str) {
    return String(str)
            .replace(/&/g, '&amp;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#39;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;');
}
var quickSort = function(arr) {
	if (arr.length <= 1) { return arr; }
		var pivotIndex = Math.floor(arr.length / 2);
		var pivot = arr.splice(pivotIndex, 1)[0];
		var left = [];
		var right = [];
		for (var i = 0; i < arr.length; i++){
		if (arr[i] < pivot) {
			left.push(arr[i]);
		} else {
			right.push(arr[i]);
		}
	}
	return quickSort(left).concat([pivot], quickSort(right));
	}

var IframePost = function() {
    var
        setFrame = function(oFrm) {
            if (!oFrm.name || oFrm.name == "")
                oFrm.name = oFrm.id;
        },
        createForm = function(obj) {
            var oForm = document.createElement("form");
            oForm.id = "forPost";
            oForm.method = "post";
            oForm.action = obj.Url;
            oForm.target = obj.Target.name;
            var oIpt, arrParams;
            arrParams = obj.PostParams;
            for (var tmpName in arrParams) {
                oIpt = document.createElement("input");
                oIpt.type = "hidden";
                oIpt.name = tmpName;
                oIpt.value = arrParams[tmpName];
                oForm.appendChild(oIpt);
            }
            return oForm;
        },
        deleteForm = function() {
            var oOldFrm = document.getElementById("forPost");
            if (oOldFrm) {
                document.body.removeChild(oOldFrm);
            }
        };

    return {
        //功能：给嵌套的Iframe界面Post值
        //参数：obj - 传递对象
        //     {Url - 页面地址, Target - Iframe对象, PostParams - Post参数,{ 参数名1 : 值1, 参数名2 : 值2 } }
        //例：{ Url: "ProjPlan_DcRate_Dept_Main.aspx?YearMonth=2012-01", Target: appIframe, PostParams: { DeptGUID: document.all["txt_DeptGUID"].value} }
        doPost: function(obj) {
            setFrame(obj.Target);
            deleteForm();
            var oForm = createForm(obj);
            document.body.appendChild(oForm);
            oForm.submit();
            deleteForm();
        }
    };
} ();
