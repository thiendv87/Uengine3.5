
/*	아래 3가지의 메시지는 wih/wihDefaultTemplate/showActions.jsp 에서 사용된다.
	var msgCompleteWork = "Do you want complete work?";
	var msgDelegateWork = "Do you want to delegate?";
	var msgSaveWork = "Do you want to save work?";
 */

function delegateSearchPeople(){
		
	    var elName = "delegateEndpoint"; 
		var orgPicker = window.open(WEB_ROOT + '/common/organizationChartPicker.jsp?fncName=onDelegateWorkitem','_new','width=430,height=550,resizable=true,scrollbars=no');
//		orgPicker.onOk= onDelegateWorkitem;
		orgPicker.inputName = elName;
	}

function onDelegateWorkitem(selectedPeople){ 
    var ids='';
	$(selectedPeople).each(function (index, user) {
		ids += user.id + ";";
	});
	
	$("input[name=delegateEndpoint]").val(ids);
	$("form[name=mainForm]").attr("action", "../wihDefaultTemplate/delegateWorkItem.jsp");
	submitMainForm(msgDelegateWork);
}

function delegateWorkitem(){
	delegateSearchPeople();
}

function saveWorkitem(){
	document.mainForm.saveOnly.value="yes";
	submitMainForm(msgSaveWork);
}

function validateWorkitem(){
	document.mainForm.action = "validate.jsp";
	submitMainForm();
}

function acceptWorkitem(){
	document.mainForm.action='../wihDefaultTemplate/accept.jsp';
	submitMainForm();
}

function back(tracingTag){
	document.mainForm.action='../wihDefaultTemplate/back.jsp?backTracingTag='+tracingTag;
	submitMainForm();
}

function confirmWI(approval){
	document.mainForm.approvalbtn.value=approval;
	submitMainForm();
}

// ess 2009.05.11 reject option add
function viewReject(instanceID, tracingTag, taskId){
		var url = "../confirmHandler/viewReject.jsp?instanceID="+instanceID + "&tracingTag=" + tracingTag+ "&taskId=" + taskId;
		//var option = "dialogHeight:180px;dialogWidth:600px;help:no;resizable:no;status:no;scroll:no;center:yes";
		//window.showModalDialog(url, window, option);
		window.open(url, 'viewReject',  "toolbar=0, status=0, scrollbars=yes, location=0, menubar=0, width=600, height=200"); 
	}

function setMainFormTarget() {
	document.mainForm.target = "messageFrameName";
}

function submitMainForm(massage) {
	if (!massage) {
		massage = msgCompleteWork;
	}
	var isValid=true;
	try {
		isValid = tagValidation();
	} catch (e) { }
	
	if (isValid) {
		try {
			isValid = formValidation();
		} catch (e) { }
	}
	
	if(isValid){
		if ( confirm(massage) ) {
			try {
				parent.clearMassage();
				formValidation();
			} catch (e) { }

			$("input[type=checkbox]").each(function(index, chkbox) {
				if(!$(chkbox).attr("checked")) {
					$(chkbox).val("");
					//$(chkbox).replaceWith($(chkbox).attr("outerHTML").replace(/type=checkbox/gi, "type=hidden"));
					//buf fix (ff cross browsing)
					var hiddenTag = getouterHtml(chkbox).replace(/type=checkbox/gi, "type=hidden").replace(/type="checkbox"/gi, "type=hidden");
					$(chkbox).replaceWith(hiddenTag);
				}
			});
			
			checkTitles(document.mainForm);
			document.mainForm.target = "messageFrameName";
			document.mainForm.submit();
		}
	}
}
