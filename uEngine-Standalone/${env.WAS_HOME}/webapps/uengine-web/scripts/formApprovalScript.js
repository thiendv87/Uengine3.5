	var commentList = [];
	function viewComment(instanceId, tracingTag){
		if (commentList[tracingTag]) {
			commentList[tracingTag].dialog("open");
		} else {
			jQuery.get(
				WEB_CONTEXT_ROOT + "/wih/formApprovalHandler/viewComment.jsp"
				, {"instanceId" : instanceId, "tracingTag" : tracingTag}
				, function(htmlData) {
					var jDiv = jQuery(document.createElement("div"));
					jDiv.attr("title", "Comment for approval");
					jDiv.html(htmlData);
					commentList[tracingTag] = jDiv.dialog({
						width: 400,
						height: 200,
						modal: true,
						resizable: false
					});
				}
			);
		}
	}
	
	function addApprovalLine(isChangeApprovalLine) {
		var orgPicker = fcnOpenApproval(900,650, WEB_CONTEXT_ROOT + '/wih/formApprovalHandler/approvalLineEditor/flow_edit_frame.jsp?isChangeApprovalLine=' + isChangeApprovalLine, '_new', false);
		//var orgPicker = fcnOpenApproval(800,590,'approvalLineEditor/flow_edit_frame.jsp,'_new', false);
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
		var comment = $("#divAppComment").html(CKEDITOR.instances.approvalComment.getData()).text();

		var commentLength = comment.length;//comment.length;
		
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
		document.forms[0].action = "submit.jsp?approvalComment="+escape(encodeURIComponent(comment));
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
		var tab = $("#myTable tr");
		var msg = "결재 요청을 하시겠습니까?";
		if(tab.size() <= 2){
			msg = "결재선 편집이 이뤄지지 않았습니다. \n\n그래도 결재 요청을 하시겠습니까?";
		}
		submitMainForm(msg);
	}
	
	//function confirmWorkitem(instanceId,tracingTag,preConfirm){
	//	try{startWaitMsg();}catch(err){}
	//	document.forms[0].action = "submit.jsp";
	//	document.forms[0].target = window.parent.name;
	//	document.forms[0].submit();
	//}
	
	function acceptWorkitem(){
		try{startWaitMsg();}catch(err){}
		document.forms[0].action= WEB_CONTEXT_ROOT + '/wih/wihDefaultTemplate/accept.jsp';
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
		try {
			showLoadingLayer();
		} catch (e) {}
		
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
			try {
				closeLoadingLayer();
			} catch (e) {}
		}
	}

	