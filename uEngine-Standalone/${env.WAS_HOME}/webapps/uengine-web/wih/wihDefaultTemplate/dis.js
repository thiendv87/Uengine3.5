var contentPageName = "";

function setDisplay(objName, className) {
	var objNames = objName.split(';');
    for(var i=0 ; i < objNames.length ; i++) {
		var objMenu = document.getElementById(objNames[i] + "_menuItem");
		if (objMenu) objMenu.className = className;
    }
}

function setContentPageName(objName) {
	contentPageName = objName;
}

function changeDisplayMenuItem(actionUrl, objName) {
	if (objName == contentPageName) {
		return;
	}
//	try {
//		showLoadingLayer();
//	} catch (e) {}
	
	var isOnReady = true;
	var iframeWihContent = document.getElementById("iframeWihContent");
	
	if (!objName) {
		objName = allElements.split(';')[0];
	} 
//	else if (
//			contentPageName == "Workitem Page" 
//			&& !confirm(" The value you have entered could be discarded. \n Sure to move? ")
//	) {
//		//document.iframeWihContent.saveWorkitem();
//		isOnReady = false;
//	}
	
	
//	try {
//		closeLoadingLayer();
//	} catch (e) {}
//
//	setContentPageName(objName)
//	
//	setDisplay(allElements, '');
//	setDisplay(objName, 'current');
//	
//	clearMassage();
//	document.title = " ::: UENGINE ::: " + listStrMenuText[objName];
	if (isOnReady) {

		setContentPageName(objName)
		
		setDisplay(allElements, '');
		setDisplay(objName, 'current');
		
		clearMassage();
		document.title = " ::: UENGINE ::: " + listStrMenuText[objName];
		
		if (contentPageName == "Related Knowledge") {
			iframeWihContent.src = actionUrl;
		} else {
			submitPassValues(actionUrl);
		}
	}
}

function submitPassValues(actionUrl) {
	var mainForm = document.formIndexPassValues;
	mainForm.action = actionUrl;
	mainForm.submit();
}

function callDis(objName,hiddenObjName){
	alert(objName + "  :::  " +hiddenObjName);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function insertMassge(strMsg) {
	var divMassageArea = document.getElementById("divMassageArea");
	var divTabMenus = document.getElementById("divTabMenus");
	divMassageArea.style.display = "";
	divMassageArea.style.height = "auto";
	divMassageArea.style.top = divTabMenus.offsetHeight + "px";
	divMassageArea.innerHTML = "<br />"
			+ strMsg + "<div align=\"right\"><img src=\"" + WEB_CONTEXT_ROOT + "/images/Common/closeMsg.gif\" style=\"cursor: pointer;\" onclick=\"closeMassage()\" /></div>";
	
	var divMassageBackGroundArea = document.getElementById("divMassageBackGroundArea");
	var iframeMassageBackGround = document.getElementById("iframeMassageBackGround");
	
	divMassageBackGroundArea.style.display = "";
	iframeMassageBackGround.style.height = divMassageArea.offsetHeight;
	divMassageBackGroundArea.style.height = divMassageArea.offsetHeight;
	divMassageBackGroundArea.style.top = divMassageArea.style.top;
}

function clearMassage() {
	document.getElementById("divMassageButton").style.display = "none";
	document.getElementById("divMassageArea").style.display = "none";
	document.getElementById("divMassageBackGroundArea").style.display = "none";
}

function showMassge() {
	document.getElementById("divMassageButton").style.display = "none";
	document.getElementById("divMassageArea").style.display = "";
	document.getElementById("divMassageBackGroundArea").style.display = "";
}

function closeMassage() {
	document.getElementById("divMassageButton").style.display = "";
	document.getElementById("divMassageArea").style.display = "none";
	document.getElementById("divMassageBackGroundArea").style.display = "none";
}


