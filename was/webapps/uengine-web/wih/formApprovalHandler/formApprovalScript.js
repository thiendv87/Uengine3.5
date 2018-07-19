	function delegateSearchPeople(){
			
	    var inputName = "delegateEndpoint"; 
		var orgPicker = window.open('/srms/common/dept/userpickerPM','_new','width=800,height=600,resizable=true,scrollbars=no');
		orgPicker.onOk= onDelegateWorkitem;
		//orgPicker.inputName=inputName;
	}
	
	function onDelegateWorkitem(selectedPeople){
			
	    var ids='';
	    var inputName = "delegateEndpoint";
		for(i=0; i<selectedPeople.length; i++){
			var user = selectedPeople[i];
			ids+=user.empno + ";";	
		}	
			
		document.forms[0].all[inputName].value =ids;		
		document.forms[0].action='../wihDefaultTemplate/delegateWorkItem.jsp';
		submitMainForm();
	}
			
	function delegateWorkitem(){
		delegateSearchPeople();
	}
	
	function viewComment(instanceId, tracingTag){
		var url = "../formApprovalHandler/viewComment.jsp?instanceId="+instanceId + "&tracingTag=" + tracingTag;
		var option = "dialogHeight:180px;dialogWidth:600px;help:no;resizable:no;status:no;scroll:no;center:yes";
		window.showModalDialog(url, window, option);
	}
	
//	function viewComment(instanceId){
//		var url = "./popupCommentView.jsp?instanceId="+instanceId;
//		var option = "dialogHeight:300px;dialogWidth:800px;help:no;resizable:no;status:no;scroll:no;center:yes";
//		window.showModalDialog(url, window, option); 
//	}
	
	function addApprovalLine() {

		var orgPicker = fcnOpenApproval(800,590,'approvalLineEditor/flow_edit_frame.jsp?multiSelect=N','_new',false);
		orgPicker.onOk = onApprovalLineSelected;
	}
	//창이 스크린에 정 가운데에 팝업되게 하는 소스 부분
	//2009년 04월 21일 조영섭 추가
	function fcnOpenApproval(pwidth,pheight,paddr,pname,pscroll)
	{
		var lf_tempx = (screen.availWidth - pwidth) / 2;
		var lf_tempy = (screen.availHeight - pheight) / 2 - 20;
		var lf_tempopt = "width="+pwidth+",height="+pheight+",toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars="+pscroll+",resizable=1,left="+lf_tempx+",top="+lf_tempy;
		var win=window.open(paddr,pname,lf_tempopt);
		return win;
	}
	
	function confirmWorkitem(instanceId,tracingTag,approveType){
	
		var confirmForm = document.mainForm;
		//confirmForm.approveType.value=approveType;
		comment = confirmForm.approvalComment.value;
		var commentLength = "10";//comment.length;
		
		if (commentLength == 0 && approveType != "approve") {
			alert("의견을 입력하세요");
			//confirmForm.comment.focus();
			return;
		}
		if ( commentLength > 500 ) {
			alert("문자가 500자를 초과하였습니다. 500자 이하로 입력하세요");
			return;
		}
		document.forms[0].apprStat.value=approveType;	
		document.forms[0].action = "submit.jsp?comment="+encodeURIComponent(comment);	
		submitMainForm();
	}
		
	function saveWorkitem(){
		try{startWaitMsg();}catch(err){}
		document.forms[0].saveOnly.value="yes";
		document.forms[0].action = "submit.jsp";
		submitMainForm("임시 저장 합니다.\n임시 저장시 첨부 파일은 저장되지 않습니다.");
		//alert("임시 저장 되었습니다.\n임시 저장시 첨부 파일은 저장되지 않습니다.");	
	}
	
	function saveMyDocument(defId){
		document.forms[0].target = "hiddenframe";
		document.forms[0].action = "myDocumentInsert.jsp?DEFID=" + defId;
		submitMainForm();
		alert("내 양식함으로 저장 되었습니다.");
	}
	
	function actionWorkitem(strApprStat){
		try{startWaitMsg();}catch(err){}
		document.forms[0].apprStat.value=strApprStat;
		document.forms[0].action = "submit.jsp";
		submitMainForm("결재 요청을 하겠습니까?");
	}
	
	//function confirmWorkitem(instanceId,tracingTag,preConfirm){
	//	try{startWaitMsg();}catch(err){}
	//	document.forms[0].action = "submit.jsp";
	//	document.forms[0].target = window.parent.name;
	//	document.forms[0].submit();
	//}
	
	function acceptWorkitem(){
		try{startWaitMsg();}catch(err){}
		document.forms[0].action='../wihDefaultTemplate/accept.jsp';
		submitMainForm();
	}
	
	function confirmedSubmit(){
	
			confirmedCheck();
	
	}
	
	
	
	function setMainFormTarget() {
		//document.forms[0].target = window.parent.name;
		document.forms[0].target = "messageFrameName";
	}

	function submitMainForm(massage) {
		showLoadingLayer();
		
		if (!massage) {
			massage = "전송 하시겠습니까?";
		}
		if (confirm(massage)) {
			try {
				parent.clearMassage();
			} catch (e) { }
			
			document.forms[0].target = "messageFrameName";
			document.forms[0].submit();
		} else {
			closeLoadingLayer();
		}
	}

	