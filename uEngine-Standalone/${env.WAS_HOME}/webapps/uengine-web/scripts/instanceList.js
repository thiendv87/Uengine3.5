function changeView(objButton) {
	var divMainSearch = document.getElementById("divMainSearch");
	var divSubSearch = document.getElementById("divSubSearch");
	if (divSubSearch.style.display == "") {
		// divMainSearch.style.display = "";
		divSubSearch.style.display = "none";

		objButton.src = WEB_CONTEXT_ROOT + "/images/Common/b_filteropen_" + LOGGED_USER_LOCALE + ".gif";
		objButton.style.cursor = "pointer";
	} else {
		// divMainSearch.style.display = "none";
		divSubSearch.style.display = "";

		objButton.src = WEB_CONTEXT_ROOT + "/images/Common/b_filterclose_" + LOGGED_USER_LOCALE + ".gif";
		objButton.style.cursor = "pointer";
	}
}

function refresh(filtering) {
	var f = document.refreshForm;
	f.filtering.value = filtering;
	f.currentPage.value = "1";
	f.action = "?";
	f.target = "_self";
	f.submit();
}

function viewProcInfo( instanceid ) {
	var option = "width=950,height=650,scrollbars=yes,resizable=yes";
	var url = "../viewProcessInformation.jsp?omitHeader=yes&instanceId="+instanceid;
	window.open(url, "", option)
}

function viewTaskInfo(taskid, instanceId, tracingTag, status) {
	var screenWidth = screen.width;
	var screenHeight = screen.Height;
	var windowWidth = 950;
	var windowHeight = 650;
	var window_left = (screenWidth - windowWidth) / 2;
	var window_top = (screenHeight - windowHeight) / 2;

	var isViewMode = (status == "COMPLETED");

	var option = "left=" + window_left + ", top=" + window_top + ", width="
			+ windowWidth + ", height=" + windowHeight
			+ " ,scrollbars=yes,resizable=yes";
	var url = "workitemHandler.jsp?taskId=" + taskid + "&instanceId="
			+ instanceId + "&tracingTag=" + tracingTag + "&isViewMode="
			+ isViewMode;
	var openedWih = window.open(url, "processView", option);

	openedWih.onclose = refresh;
}

function selectProcess() {
	var url = "../commonfilter/selectProcessDefinition_frame.jsp";

	var screenWidth = screen.width;
	var screenHeight = screen.Height;
	var windowWidth = 500;
	var windowHeight = 300;
	var window_left = (screenWidth - windowWidth) / 2;
	var window_top = (screenHeight - windowHeight) / 2;

	var option = "left=" + window_left + ", top=" + window_top + ", width="
			+ windowWidth + ", height=" + windowHeight
			+ " ,scrollbars=yes,resizable=yes";

	var arrResult = window.open(url, "", option);
}

function setProcess(processDefinition, processDefName) {
	document.refreshForm.processDefinition.value = processDefinition;
	$("#processDefName").val(processDefName);
}

function resetHiddenValue(objname) {
	document.getElementsByName(objname)[0].value = "";
}

function showDetailSearch(menuName, dialogWidth, dialogHeight, searchBtn, closeBtn) {
	
	$("#divSubSearch").dialog({
		autoOpen: false,
		width: dialogWidth,
		modal: true,
		resizable: true,
		buttons: [{
			text: searchBtn,
			click: function() { searchDetail(menuName); }
		},{
			text: closeBtn,
			click: function() { $(this).dialog("close"); }
		}]
	});
	
	$("#divSubSearch").dialog("open");
	$('#divSubSearch').css('height', dialogHeight);
}

function searchSimple() {
	var mainForm = document.refreshForm;
	if (mainForm.simpleKeyWord.value || mainForm.status) {
		mainForm.submit();
	} else {
		alert("You need keyword.");
	}
}

function searchDetail(menuName) {
	var mainForm = document.refreshForm;

	if(menuName=='Process'){
		mainForm.inputParentFolderName.value = $("#inputParentFolderName").val();
		mainForm.inputDefinitionName.value = $("#inputDefinitionName").val();
		mainForm.inputDefinitionAlias.value = $("#inputDefinitionAlias").val();
	}else if(menuName=='ProcessMenuTreeList'){
		mainForm.inputDefinitionName.value = $("#inputDefinitionName").val();
		mainForm.inputDefinitionAlias.value = $("#inputDefinitionAlias").val();
	}else{
		mainForm.inputInstanceName.value = $("#inputInstanceName").val();
		mainForm.inputWorkName.value = $("#inputWorkName").val();
		mainForm.workitem_start_date.value = $("#workitem_start_date").val();
		mainForm.workitem_end_date.value = $("#workitem_end_date").val();
		mainForm.search_user_display.value = $("#search_user_display").val();
		mainForm.search_user.value = $("#search_user").val();
		mainForm.processDefName.value = $("#processDefName").val();
	}
	mainForm.simpleKeyWord.value = "";
	mainForm.submit();
}