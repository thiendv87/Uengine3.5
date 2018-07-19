var divBackground;
var divBugDescript;
var docObject = window.parent.window.document;
	if (parent.name != "iframeWihContent") {
		//alert(parent.name);
		docObject = document;
	}

function setDivBackground() {
	if (!docObject.getElementById("divBackground")) {
		var htmlLayer = "<div id=\"divBackGround\" style=\"filter:alpha(opacity=70); position: absolute; z-index:100;left:0px; top:0px;display: none; width:100%; height:100%;\"></div>"
		divBackground = docObject.createElement(htmlLayer);
		docObject.body.insertBefore(divBackground);
	}
	
	divBackground = docObject.getElementById("divBackground");
	divBackground.innerHTML = "<table width=\"100%\" height=\"100%\" bgcolor=\"#FFFFFF\"><tr><td>&nbsp;</td></tr></table>";
	
}

function createdivBugDescript() {
	if (!docObject.getElementById("divBugDescript")) {
		var htmlLayer = "<div id=\"divBugDescript\" style=\"position: absolute; z-index:101; display: none; \"></div>"; 
		var elCopyLayer = docObject.createElement(htmlLayer);
		docObject.body.insertBefore(elCopyLayer);
	}
	
	divBugDescript = docObject.getElementById("divBugDescript");
}

function setDivDisplay(strDisplay) {
	divBackground.style.display = strDisplay;
	divBugDescript.style.display = strDisplay;
}

 /**
  * openPopupLayer
  * @param {type} param 
  */
function openPopupLayer() {
	setDivDisplay("");
	var elLayer = document.getElementById("divOrgBugDescript");
	divBugDescript.innerHTML = elLayer.innerHTML;
	
	var arrBtnClose = new Array();
	arrBtnClose = docObject.getElementsByName("btnCloseMsg");
	for (var i = 0; i < arrBtnClose.length; i++) {
		btnClose = arrBtnClose[i];
		btnClose.attachEvent("onclick", function(){closePopupLayer();});
	}
	
	var scrollTop = docObject.body.scrollTop;
	var scrollLeft = docObject.body.scrollLeft;
	
	var intBodyHeight = 0;
	var intBodyWidth = 0;
	
	
	intBodyHeight = docObject.body.offsetHeight;
	intBodyWidth = docObject.body.offsetWidth;
	
	var wh = (intBodyHeight / 2) - (divBugDescript.offsetHeight / 2) + scrollTop;
	var ww = (intBodyWidth / 2) - (divBugDescript.offsetWidth / 2) + scrollLeft;
	
	if (wh < 0) wh = "0";
	if (ww < 0) ww = "0";
	
	divBugDescript.style.top = wh + "px";
	divBugDescript.style.left = ww + "px";
	
	divBackground.style.top = scrollTop + "px";
	divBackground.style.left = scrollLeft + "px";
}

function closePopupLayer() {
	setDivDisplay("none");
}

function setErrorPage() {
	setDivBackground();
	createdivBugDescript();
}

if (window.attachEvent) {
	window.attachEvent("onload", function () {setErrorPage();});
} else {
	addEventListener("onload", function() {setErrorPage()}, false);	//mozilla,firefox
}
