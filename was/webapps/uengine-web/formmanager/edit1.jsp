<%@page pageEncoding="KSC5601"%>
<%response.setContentType("text/html; charset=UTF-8");%>

<html>
<head>
<title>�� ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />                                                                                                                                                                
<link rel="stylesheet" type="text/css" href="/admin_common.css.jsp">
<link rel="stylesheet" type="text/css" href="/admin_page.css.jsp">
<link rel="stylesheet" type="text/css" href="/global.css.jsp">
<link rel="stylesheet" type="text/css" href="/bpm.css">
<script type="text/javascript" src="/css.js"></script>
<script type="text/javascript" src="/popup.js"></script>
<script language="JavaScript">
	function loadForm() {
  		var url = "/hwbpm/downloadSvc/form.mht?module=bpm&path=&name=form.xml&type=form&isView=down&sid=";
  		alert(url);
  		document.Wec.OpenFile(url)	
	}
	
	function openContentEditor() {
		document.hiddenForm.action = "sourceEditor.jsp" ;
		document.hiddenForm.target = "sourceEditFrame";
		document.hiddenForm.submit();
		//document.hiddenForm.sourceEditor.editContent();
	}
	
	function editSubmitAction() {
//		document.hiddenForm.action = "sourceEditor.jsp?action=submit" ;
//		document.hiddenForm.target = "sourceEditFrame";
//		document.hiddenForm.submit();	
		//document.hiddenForm.sourceEditor.editSubmitAction();

		var url = "dao_generate_edit.jsp?path=";
		var StrOption ;
		StrOption  = "dialogWidth:800px;dialogHeight:500px;";
		StrOption += "center:on;scroll:auto;status:off;resizable:off";	
		showModalDialog (url , window, StrOption);
	}
	
	function changeDocument(contents) {
		document.Wec.Value = contents;
	}
	
	function saveSubmitActionContents (contents) {
		document.editForm.submitActionContents.value = contents;
		alert(document.editForm.submitActionContents.value);
	}
	
	function saveForm() {
		if (document.editForm.formName.value == "") {
			alert("��� ������ �Է��ϼ���");
			document.editForm.formName.focus();
			return;
		}
		
		document.editForm.mimeValue.value =  document.Wec.MimeValue;
		if(document.editForm.freeEdit.checked == true) {
			document.editForm.freeEdit.value = "true"
		}
		
		// formlink in
		if(document.editForm.formInYN.checked == true) {
			document.editForm.formInYN.value = "true"
		}
		
		// formlink out
		if(document.editForm.formOutYN.checked == true) {
			document.editForm.formOutYN.value = "true"
		}

//		var reportInfo = "������ ������Ű�ðڽ��ϱ�?";	
//		if(!confirm(reportInfo)){
//			document.editForm.versionIncreaseYN.value = 'no';
//		}
//		document.editForm.actionType.value = 'save';
//		document.editForm.action = "edit.jsp";
//		document.editForm.submit();

		var reportInfo = "�����Ͻðڽ��ϱ�?";	
		if(confirm(reportInfo)){
			// ������ �������Ѵ�.
			document.editForm.actionType.value = 'save';
			document.editForm.action = "edit.jsp";
			document.editForm.submit();	
		}else{
			return;
		}
	}
	
	function showForm(version, id) {
		//alert("showForm : " + version + ", " + id);
		document.editForm.versionIncreaseYN.value = 'no';
		document.editForm.formVersion.value = version;
		document.editForm.formVerId.value = id;
		document.editForm.submit();
	}
	
	function setAsProduction() {
		document.editForm.versionIncreaseYN.value = 'no';
		document.editForm.actionType.value = 'setAsProduction';   
		document.editForm.submit();
	}
	
	function deleteForm() {	
		var deleteAlert = "���� ������ �����Ͻðڽ��ϱ�?";	
		var actionType = "del_form_ver";

		if( iVerListSize <= 1 ){
			deleteAlert = "���� ���� �����Ͻðڽ��ϱ�?";	
			actionType = "del_form";
		}
		
		if(!confirm(deleteAlert)){
			return;
		}

		document.editForm.actionType.value = actionType;
		document.editForm.action = "form_delete.jsp";
		document.editForm.submit();
	}
	
	// DAO �߰�.
	function insertDAO() {
		showDBDialog();
	}
	
	function showDBDialog() {
		var url = "dao_generate_frame.jsp";
		var StrOption ;
		StrOption  = "dialogWidth:600px;dialogHeight:330px;";
		StrOption += "center:on;scroll:auto;status:off;resizable:off";	
		showModalDialog (url , window, StrOption);
	}
	
	function openVariableMappingDlg() {
		var pd = document.formLinkForm.definitionId.value;
		if ( pd == '' ) {
			alert("��Ŀ� ���μ����� �����Ͻ� �� ����Ͻñ� �ٶ��ϴ�.");
			return;
		}
		var url = "variable_mapping_frame.jsp?processDefinition="+pd;
		var StrOption ;
		StrOption  = "dialogWidth:600px;dialogHeight:500px;";
		StrOption += "center:on;scroll:auto;status:off;resizable:off";	
		showModelessDialog (url , window, StrOption);
	}
	
	function setVariableMapping(formName, varName) {
		document.Wec.InsertValue(1, "#varMap#");
		//document.editForm.fviFormName.value = formName;
		//document.editForm.fviVarName.value = varName;
		var htmlSource = document.Wec.Value;
		var idx = htmlSource.indexOf("#varMap#");
		var prefix = htmlSource.substring(0, idx);
		var postfix = htmlSource.substring(idx+"#varMap#".length, htmlSource.length);
		var expression = '<'+'%='+'fvh.getProcessVariable("'+formName+'", "'+varName+'")%'+'>';
		var replaceStr = prefix + expression + postfix; 
		document.Wec.Value = replaceStr;
	}
	
	function openFormLinkDlg(mode) {
		var pd = document.formLinkForm.definitionId.value;
		if ( pd == '' ) {
			alert("��Ŀ� ���μ����� �����Ͻ� �� ����Ͻñ� �ٶ��ϴ�.");
			return;
		}
		/*
		var url = "formlink_frame.jsp?processDefinition="+pd;
		var StrOption ;
		StrOption  = "dialogWidth:600px;dialogHeight:500px;";
		StrOption += "center:on;scroll:auto;status:off;resizable:off";	
		showModelessDialog (url , window, StrOption);
		*/
		openFormLink(pd, mode);
	}
	
	function openFormLink(pd, mode) {
		//alert(pd + ", " + mode);
		document.formLinkForm.target = "hiddenFrame";
		document.formLinkForm.definitionId.value = pd;
		document.formLinkForm.mode.value = mode;
		document.formLinkForm.submit();
	}	
	
	function openProcessDefinitionMappingDlg() {
		var url = "select_processdefinition_frame.jsp?formId=";
		var StrOption ;
		StrOption  = "dialogWidth:600px;dialogHeight:500px;";
		StrOption += "center:on;scroll:auto;status:off;resizable:off";	
		showModelessDialog (url , window, StrOption);		
	}
	
	function setProcessDefinition(name, pd) {
		pdInfo.innerHTML = name + " (" + pd + ")";
		document.formLinkForm.definitionId.value = pd;
	}
	
	// �޷�.
	function openCalendarDlg() {
		var url = "calendar_frame.jsp";
		var StrOption ;
		StrOption  = "dialogWidth:350px;dialogHeight:180px;";
		StrOption += "center:on;scroll:auto;status:off;resizable:off";	
		showModalDialog (url , window, StrOption);
	}	
	
	function setCalendarParam(calendarName, calendarViewFormat, calendarAlign) {
		var form = document.editForm;
		//form.calendarName.value = calendarName;
		//form.calendarViewFormat.value = calendarViewFormat;
		//form.calendarAlign.value = calendarAlign;
		document.Wec.InsertValue(1, "#calendar#");
		var htmlSource = document.Wec.Value;
		var idx = htmlSource.indexOf("#calendar#");
		var prefix = htmlSource.substring(0, idx);
		var postfix = htmlSource.substring(idx+"#calendar#".length, htmlSource.length);
//		var expression = '<'+'%='+'formHeaderBean.getCalendarHTML("'+calendarName+'", "'+calendarViewFormat+'", "'+calendarAlign+'", pageContext)%'+'>';
		var expression = '<bpm:calendar name="'+calendarName+'" viewFormat="'+calendarViewFormat+'" align="'+calendarAlign+'" viewMode="<'+'%=InputConstants.VIEW%'+'>"/>';
		var replaceStr = prefix + expression + postfix;
		document.Wec.Value = replaceStr;
		//formHeaderBean.getCalendarHTML("testcal", "y-mm-dd", "TI")
		//saveForm();
	}
	
	// ����� ã��.
	function openFormUserListDlg() {
		var url = "formUserList_frame.jsp";
		var StrOption ;
		StrOption  = "dialogWidth:350px;dialogHeight:130px;";
		StrOption += "center:on;scroll:auto;status:off;resizable:off";	
		showModalDialog (url , window, StrOption);
	}	
	
	function setFormUserListParam(formUserListName) {
		var form = document.editForm;
		document.Wec.InsertValue(1, "#formUserList#");
		var htmlSource = document.Wec.Value;
		var idx = htmlSource.indexOf("#formUserList#");
		var prefix = htmlSource.substring(0, idx);
		var postfix = htmlSource.substring(idx+"#formUserList#".length, htmlSource.length);
//		var expression = '<'+'%='+'formHeaderBean.getFormUserListHTML("'+formUserListName+'", pageContext)%'+'>';
		var expression = '<bpm:formUserList name="'+formUserListName+'" viewMode="<'+'%=InputConstants.VIEW%'+'>"/>';
		var replaceStr = prefix + expression + postfix;
		document.Wec.Value = replaceStr;
	}
	
	// �μ� ã��.
	function openFormDeptListDlg() {
		var url = "formDeptList_frame.jsp";
		var StrOption ;
		StrOption  = "dialogWidth:350px;dialogHeight:130px;";
		StrOption += "center:on;scroll:auto;status:off;resizable:off";	
		showModalDialog (url , window, StrOption);
	}		
	
	function setFormDeptListParam(formDeptListName) {
		var form = document.editForm;
		document.Wec.InsertValue(1, "#formDeptList#");
		var htmlSource = document.Wec.Value;
		var idx = htmlSource.indexOf("#formDeptList#");
		var prefix = htmlSource.substring(0, idx);
		var postfix = htmlSource.substring(idx+"#formDeptList#".length, htmlSource.length);
//		var expression = '<'+'%='+'formHeaderBean.getFormUserListHTML("'+formUserListName+'", pageContext)%'+'>';
		var expression = '<bpm:formUserList name="'+formDeptListName+'" treeOption="T" titleHead="�μ�ã��" titleMain="�μ�ã��" titleSelected="���õ� �μ�" viewMode="<'+'%=InputConstants.VIEW%'+'>"/>';
		var replaceStr = prefix + expression + postfix;
		document.Wec.Value = replaceStr;
	}	
	
	
	// ���� ã��.
	function openSearchManagerDlg() {
		var url = "searchManager_frame.jsp";
		var StrOption ;
		StrOption  = "dialogWidth:350px;dialogHeight:130px;";
		StrOption += "center:on;scroll:auto;status:off;resizable:off";	
		showModalDialog (url , window, StrOption);
	}	
	
	function setSearchManagerParam(searchManagerName) {
		var form = document.editForm;
		document.Wec.InsertValue(1, "#searchManagerName#");
		var htmlSource = document.Wec.Value;
		var idx = htmlSource.indexOf("#searchManagerName#");
		var prefix = htmlSource.substring(0, idx);
		var postfix = htmlSource.substring(idx+"#searchManagerName#".length, htmlSource.length);
//		var expression = '<'+'%='+'formHeaderBean.getSearchManagerHTML("'+searchManagerName+'", pageContext)%'+'>';
		var expression = '<bpm:searchManager name="'+searchManagerName+'" viewMode="<'+'%=InputConstants.VIEW%'+'>"/>';
		var replaceStr = prefix + expression + postfix;
		document.Wec.Value = replaceStr;
	}

	// ���Ͼ��ε�.
	function openFileUploadDlg() {
		var url = "fileUpload_frame.jsp";
		var StrOption ;
		StrOption  = "dialogWidth:350px;dialogHeight:130px;";
		StrOption += "center:on;scroll:auto;status:off;resizable:off";	
		showModalDialog (url , window, StrOption);
	}	
	
	function setFileUploadParam(fileUploadName) {
		var form = document.editForm;
		document.Wec.InsertValue(1, "#fileUpload#");
		var htmlSource = document.Wec.Value;
		var idx = htmlSource.indexOf("#fileUpload#");
		var prefix = htmlSource.substring(0, idx);
		var postfix = htmlSource.substring(idx+"#fileUpload#".length, htmlSource.length);
//		var expression = '<'+'%='+'formHeaderBean.getFileUploadHTML("'+fileUploadName+'", pageContext)%'+'>';
		var expression = '<bpm:fileUpload name="'+fileUploadName+'" viewMode="<'+'%=InputConstants.VIEW%'+'>"/>';
		var replaceStr = prefix + expression + postfix;
		document.Wec.Value = replaceStr;
	}
									
	<%-- showDBDialog()���� callback() ���·� ȣ��� --%>
	function setDbParameter(dbUseDataSource, 
							dbDataSource,
							dbDriver,
							dbUrl,
							dbId,
							dbPassword,
							dbClassName,
							dbQuery)
	{
		var form = document.idaoForm;
		form.dbUseDataSource.value = dbUseDataSource;
		form.dbDataSource.value = dbDataSource;
		form.dbDriver.value = dbDriver;
		form.dbUrl.value = dbUrl;
		form.dbId.value = dbId;
		form.dbPassword.value = dbPassword;
		form.dbClassName.value = dbClassName;
		form.dbQuery.value = dbQuery;
		
		
		form.target = "iDAOFrame";
		form.submit();
		
		//saveForm();
		<%--
		//var expression = 'freeContentsName'+'" width="'+freeContentsWidth+'" height="'+freeContentsHeight+'" viewMode="<'+'%=InputConstants.VIEW%'+'>"/>';
		//var replaceStr = prefix + expression + postfix;
		//document.Wec.Value = replaceStr;
		--%>
	}
	
	function insertIDAODeclaration(dec) {
		//document.Wec.InsertValue(0, "#dec#");
		var htmlSource = "#dec#" + document.Wec.Value;
		var idx = htmlSource.indexOf("#dec#");
		var prefix = htmlSource.substring(0, idx);
		var postfix = htmlSource.substring(idx+"#dec#".length, htmlSource.length);
		var replaceStr = prefix + dec + postfix;
		document.Wec.Value = replaceStr;	
	}
	
	function insertIDAOCode(dao) {
		document.Wec.InsertValue(1, "#dao#");
		var htmlSource = document.Wec.Value;
		var idx = htmlSource.indexOf("#dao#");
		var prefix = htmlSource.substring(0, idx);
		var postfix = htmlSource.substring(idx+"#dao#".length, htmlSource.length);
		var replaceStr = prefix + dao + postfix;
		document.Wec.Value = replaceStr;		
	}

	// �ʵ弳��.
	function selectBindingElement() {
		showSelectBindingElementDialog();
	}
	
	// �ʵ弳�� ���̾˷α�.
	function showSelectBindingElementDialog() {
		//alert("showSelectBindingElementDialog");
		var url = "select_binding_element_frame.jsp?formId=&formVerId=";
		var StrOption ;
		StrOption  = "dialogWidth:800px;dialogHeight:500px;";
		StrOption += "center:on;scroll:auto;status:off;resizable:off";	
		showModalDialog (url , window, StrOption);
		//window.open(url);
	}
	
	// �ʼ� �Է� �׸� ����.
	function selectBindingMandatoryElement() {
		showSelectBindingMandatoryElementDialog();
	}

	// �ʼ� �Է� �׸� ���� ���̾˷α�.
	function showSelectBindingMandatoryElementDialog() {
		//alert("showSelectBindingMandatoryElementDialog");
		var url = "select_binding_mandatory_element_frame.jsp?formId=&formVerId=";
		var StrOption ;  
		StrOption  = "dialogWidth:750px;dialogHeight:480px;";
		StrOption += "center:on;scroll:no;status:off;resizable:off";	
		showModalDialog (url , window, StrOption);
		//window.open(url);
	}
	
	// ������ ������ ���� ���̾˷α�.
	function openfreeContentsDlg() {
		var url = "freeContents_frame.jsp";
		var StrOption ;
		StrOption  = "dialogWidth:350px;dialogHeight:180px;";
		StrOption += "center:on;scroll:auto;status:off;resizable:off";	
		showModalDialog (url , window, StrOption);
	}	
	
	// ������ ������ ����.
	function setfreeContentsParam(freeContentsName, freeContentsWidth, freeContentsHeight) {
		var form = document.editForm;
		document.Wec.InsertValue(1, "#freeContents#");
		var htmlSource = document.Wec.Value;
		var idx = htmlSource.indexOf("#freeContents#");
		var prefix = htmlSource.substring(0, idx);
		var postfix = htmlSource.substring(idx+"#freeContents#".length, htmlSource.length);
		var expression = '<bpm:freeContents name="'+freeContentsName+'" width="'+freeContentsWidth+'" height="'+freeContentsHeight+'" viewMode="<'+'%=InputConstants.VIEW%'+'>"/>';
		var replaceStr = prefix + expression + postfix;
		document.Wec.Value = replaceStr;
	}
	
	function insertDeclaration() {
		//var caretPosition = document.Wec.GetCaretPos;
		//alert(caretPosition);
		//alert(document.Wec.SelectedValue);
		document.Wec.InsertValue(1, "#declaration#");
		saveForm();
	}

	function insertScriptlet() {
		document.Wec.InsertValue(1, "#scriptlet#");
		saveForm();
	}

	function insertExpression() {
		document.Wec.InsertValue(1, "#expression#");
		saveForm();
	}

	// �Ŵ��� ����
	function openJobManualDlg(){
		var url = "job_manual_frame.jsp?formId=";
		var StrOption ;
		StrOption  = "dialogWidth:600px;dialogHeight:280px;";
		StrOption += "center:on;scroll:auto;status:off;resizable:off";	
		showModalDialog (url , window, StrOption);
	}
	function setJobManualProcess( cnt ) {
		if(Number(cnt) > 0)	manualInfo.innerHTML = "���";
		else manualInfo.innerHTML = "�̵��";

	}

	// �׸��� ����
	function openGridDlg(){
		var url = "grid_frame.jsp";
		var StrOption ;
		StrOption  = "dialogWidth:700px;dialogHeight:440px;";
		StrOption += "center:on;scroll:auto;status:off;resizable:off";
		showModalDialog (url , window, StrOption);
	}
	function setGridParam(	name,
							baseUrl,
							width,
							height,
							headerNames,
							headerWidths,
							headerAligns,
							columnAligns,
							columnNumbers,
							headerSort,
							paging,
							pageItemSize,
							pageLineSize) {
		var form = document.editForm;
		document.Wec.InsertValue(1, "#grid#");
		var htmlSource = document.Wec.Value;
		var idx = htmlSource.indexOf("#grid#");
		var prefix = htmlSource.substring(0, idx);
		var postfix = htmlSource.substring(idx+"#grid#".length, htmlSource.length);
		var expression = '<bpm:grid name="'+name+'" baseUrl="'+baseUrl+'" width="'+width+'" height="'+height+'" headerNames="'+headerNames+'" headerWidths="'+headerWidths+'" headerAligns="'+headerAligns+'" columnAligns="'+columnAligns+'" columnNumbers="'+columnNumbers+'" headerSort="'+headerSort+'" paging="'+paging+'" pageItemSize="'+pageItemSize+'" pageLineSize="'+pageLineSize+'" />';
		var replaceStr = prefix + expression + postfix;
		document.Wec.Value = replaceStr;
	}
</script>

</head>

<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" onLoad="loadForm();">

<form name="idaoForm" Method="post" target="iDAOFrame" action="getIDAOSource.jsp" >
	�� ���� ���̵�: <input value="">
	�� ���̵�: <input value="">

	<input type="hidden" name="dbClassName">
	<input type="hidden" name="dbQuery">
	<input type="hidden" name="dbUseDataSource">
	<input type="hidden" name="dbDataSource">
	<input type="hidden" name="dbDriver">
	<input type="hidden" name="dbUrl">
	<input type="hidden" name="dbId">
	<input type="hidden" name="dbPassword">
</form>

<FORM name="editForm" Method="Post" Action="edit.jsp" >
<input type="hidden" name="baseURL" value="">
<input type="hidden" name="formId" value="">
<input type="hidden" name="mimeValue">
<input type="hidden" name="actionType">
<input type="hidden" name="path" value="">
<input type="hidden" name="formUrl" value="/hwbpm/downloadSvc/form.mht?module=bpm&path=&name=form.xml&type=form&isView=down&sid=">

<input type="hidden" name="submitHandlerPath" value="">
<input type="hidden" name="submitActionContents">

<%--
<input type="hidden" name="fviFormName">
<input type="hidden" name="fviVarName">

<input type="hidden" name="calendarName">
<input type="hidden" name="calendarViewFormat">
<input type="hidden" name="calendarAlign">
--%>

<input type="hidden" name="dbClassName">
<input type="hidden" name="dbQuery">
<input type="hidden" name="dbUseDataSource">
<input type="hidden" name="dbDataSource">
<input type="hidden" name="dbDriver">
<input type="hidden" name="dbUrl">
<input type="hidden" name="dbId">
<input type="hidden" name="dbPassword">

<input type="hidden" name="formVerId" value="">
<input type="hidden" name="formVersion" value="">

<input type="hidden" name="versionIncreaseYN" value="yes">

<!--	########################	contents start		########################	-->
<table class="bodyframe" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td> 
      <!--Ÿ��Ʋ ���̺� ���� -->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td class="title_bg"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td> 
                  <!--Ÿ��Ʋ�۾�box���� -->
                  <table border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td class="title"> 
                        <!--Ÿ��Ʋ������ -->
                        <img src="/themes/common/images/title_icon.gif" align="absmiddle">������</td>
                    </tr>
                  </table>
                  <!--Ÿ��Ʋ�۾�box�� -->
                </td>
                <td class="location_t_padding"> 
                  <!--������̺���� -->
                  <table border="0" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td class="location_padding"> <img src="/themes/common/images/bull-tri-gray.gif" align="absmiddle"> 
                        BPM &gt;<font class="linemap_curpos">������</font></td>
                    </tr>
                  </table>
                  <!--������̺� -->
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <!--Ÿ��Ʋ ���̺� �� -->
      <table width="100%"   border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td class="margin_table"></td>
        </tr>
      </table>
      <!--���̺� �� ���ν��� -->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td class="list_tit_line_s"></td>
        </tr>
        <tr>
          <td class="list_btn_line_e"></td>
        </tr>
      </table>
      <!--���̺� �� ���γ�-->      
      <!--�������� ����-->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="td_tit">��ĸ�</td>
			<td class="td_left"><input type="text" class="input" name="formName" value="" class="input" style="width:90%"></td>
			<td class="td_tit" >ȭ����¿� ����</td>
			<td class="td_left"><input type="text" class="input" name="displayName" value=""></td>
		</tr>
        <tr> 
          <td class="td_line" colspan="4"></td>
        </tr>
		<tr height="28">
			<td class="td_tit">�� ����</td>
			<td class="td_left">
				<select class="select" size="1" name="formType" class="input">
					<option value="form">�⺻(����) ���</option>
					<option value="approval">���ڰ��� (�⺻)</option>
					<option value="approval1">���ڰ��� (�볻 ����)</option>
					<option value="approval11">���ڰ��� (��� ����)</option>
					<option value="approval2">���ڰ��� (���)</option>
					<option value="approval3">���ڰ��� (����)</option>
					<option value="approval4">���ڰ��� (ȸ��)</option>
<!--				<option value="approval5">���ڰ��� (��ܹ߽Ź���)</option> -->
					<option value="approval6">���ڰ��� (None Title)</option>
					<option value="approval7">OneStop (��ȹ�)</option>
					<option value="approval8">���ڰ��� (���๮ ���ΰ���)</option>
					<option value="approval12">���ڰ��� (����������)</option>
					<option value="approval9">���ڰ��� (����ǰ��)</option>
					<option value="approval10">���ڰ��� (��ܹ��� ���ΰ���)</option>
					<option value="approval13">���ڰ��� (����ī��)</option>
					<option value="approval14">���ڰ��� (��û)</option>
				</select>				
			</td>
			<td class="td_tit">���μ��� ����</td>
			<td class="td_left">
			  <span id="pdInfo">

				</span>
				<img src="btn-conec.gif" align="absmiddle" onclick="openProcessDefinitionMappingDlg('')" style="cursor:hand;">
		</tr>
        <tr> 
          <td class="td_line" colspan="4"></td>
        </tr>
		<tr height="28">
			<td class="td_tit"> ����ũ ���  ���� </td>
			<td class="td_left" >
				IN&nbsp;<input type="checkbox" name="formInYN" value="" >&nbsp;&nbsp;&nbsp;
				OUT&nbsp;<input type="checkbox" name="formOutYN" value="" >
			</td>
			<td class="td_tit"> �޴��� ���� </td>
			<td class="td_left" >
					
			<a href="#" onclick="openJobManualDlg('');" class="bold">
			<span id="manualInfo">
			</span>
			</a>
			</td>				
		</tr>
        <tr> 
          <td class="td_line" colspan="4"></td>   
        </tr>
		<tr height="28">
			<td class="td_tit"> ���� �������� ���� </td>
			<td class="td_left"  colspan="3">
				<b></b> &nbsp;&nbsp;
				<font class="txt-r">[This version is production] </font>
				<INPUT TYPE="button" class="input" TITLE="Set as production" NAME="Set as production" VALUE="Set as production" onclick="setAsProduction()"/>
			</td>
		</tr>
        <tr> 
          <td class="td_line" colspan="4"></td>
        </tr>		
		<tr height="28">		
			<td class="td_tit"> ��ü ���� ��� </td>
			<td class="td_left" colspan="3">
					<font title="" onmouseover='this.style.textDecoration="underline"' style="font-size: 10pt; CURSOR: hand; TEXT-DECORATION: none" onmouseout='this.style.textDecoration="none"'  onclick="javascript:showForm('', '')"><b></b></font>
		    </td>
		 </tr>
	   </table>
       <!--���̺� ���ν��� -->
       <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr><td class="list_btn_line_e"></td></tr>
         <tr><td class="list_line_light"></td></tr>
       </table>
       <br>
		<!--	#####	basic setting end		#####	-->
				<table border="0" cellspacing="0" cellpadding="0">
					<tr><td>
						<a href="#" ><img onclick="openVariableMappingDlg();" src="/but-01-off.gif" border="0" name="Image01" style="margin-left:1" title="��������"></a>
						<a href="#" ><img onclick="openContentEditor();" src="/but-02-off.gif" border="0" name="Image02" style="margin-left:1" title="�ҽ�����"></a>
						<a href="#" ><img onclick="editSubmitAction();" src="/but-03-off.gif" border="0" name="Image03" style="margin-left:1" title="�Ϸ�׼�����"></a>
						<a href="#" ><img onclick="openFormLinkDlg('in');" src="/but-04-off.gif" border="0" name="Image04" style="margin-left:1" title="����ũ(IN)"></a>
						<a href="#" ><img onclick="openFormLinkDlg('out');" src="/but-05-off.gif" border="0" name="Image05" style="margin-left:1" title="����ũ(OUT)"></a>
						<a href="#" ><img onclick="insertDAO();" src="/but-06-off.gif" border="0" name="Image06" style="margin-left:1" title="�����ͺ��̽� ����"></a>
					</td></tr>
				</table>
				<br style="line-height:2px">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr><td>
						<a href="#" ><img onclick="selectBindingElement();" src="/but-07-off.gif" border="0" name="Image07" style="margin-left:1" title="�ʵ弳��"></a>
						<a href="#" ><img onclick="openCalendarDlg();" src="/but-08-off.gif" border="0" name="Image08" style="margin-left:1" title="�޷�"></a>
						<a href="#" ><img onclick="openFormUserListDlg();" src="/but-09-off.gif" border="0" name="Image09" style="margin-left:1" title="�����ã��"></a>
						<a href="#" ><img onclick="openFormDeptListDlg();" src="/but-10-off.gif" border="0" name="Image10" style="margin-left:1" title="����ã��"></a>
						<a href="#" ><img onclick="openFileUploadDlg();" src="/but-11-off.gif" border="0" name="Image11" style="margin-left:1" title="����÷��"></a>
						<a href="#" ><img onclick="saveForm();" src="but-12-off.gif" border="0" name="Image12" style="margin-left:1" title="�����ϱ�"></a>
						<a href="#" ><img onclick="deleteForm();" src="but-13-off.gif" border="0" name="Image13" style="margin-left:1" title="������"></a>
					</td></tr>
					<tr><td>
						<%-- �μ�ã�� --%>						
						<a href="#"><img onclick="openSearchManagerDlg();" src="but-14-off.gif" border="0" name="Image14" style="margin-left:1" title="�μ�ã��"></a>
						<!-- �׸��� �Է� ���� -->
						<a href="#"><img onclick="openGridDlg();" src="but-15-off.gif" border="0" name="Image15" style="margin-left:1" title="�׸��� �Է� ����"></a>					
						<!-- �ʼ� �Է� �׸� ���� -->
						<a href="#"><img onclick="selectBindingMandatoryElement();" src="but-16-off.gif" border="0" name="Image16" style="margin-left:1" title="�ʼ� �Է� �׸� ����"></a>
						<!-- ������������  ���� -->
						<a href="#"><img onclick="openfreeContentsDlg();" src="but-17-off.gif" border="0" name="Image17" style="margin-left:1" title="������������  ����"></a>
					</td></tr>
				</table>
					<br style="line-height:5px">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="100%">
								<%--
								<OBJECT WIDTH=0 HEIGHT=0 CLASSID="clsid:5220cb21-c88d-11cf-b347-00aa00a28331">
								   <PARAM NAME="LPKPath" VALUE="NamoWec5_Hanwha_Group_M.lpk">
								</OBJECT>
								<OBJECT ID="Wec" WIDTH="100%" HEIGHT="630" 
									CLASSID="CLSID:2E478DF0-BB7F-434a-9BB5-FC09B2D216AE" 
									CODEBASE="NamoWec.cab#version=5,0,0,63">
									<param name="InitFileURL" value="namowec.env">
								</OBJECT>		
								--%>
								<OBJECT WIDTH="0" HEIGHT="0" CLASSID="CLSID:5220cb21-c88d-11cf-b347-00aa00a28331">
								<param name="LPKPath" value="lib/namo/ActiveSquare5/NamoWec5_hanwha_snc.lpk"/>
								</OBJECT>
								
								<OBJECT ID="Wec" 
									style="width:100%;height:630px;"  
									CLASSID="CLSID:9AE9AD96-D867-4ac4-8AF1-775C66A9E83B"  
									codebase="lib/namo/ActiveSquare5/NamoWec.cab#version=5,0,0,16"  
									viewMode="edit">
									<param name="InitFileURL" value="lib/namo/ActiveSquare5/env/approval_admin.env">
								</OBJECT>										
							</td>
						</tr>
					</table>
	 </td>	
   </tr>
</table>


						
<br><br>
<!--	########################	contents end		########################	-->


</form>


<FORM name="hiddenForm" Method="Post" Action="edit.jsp" >
</FORM>

<!-- <iframe name="sourceEditFrame" style="display:none"></iframe> -->
<iframe name="sourceEditFrame" width="0" height="0"></iframe>

<iframe name="hiddenFrame" style="display:none"></iframe>

<iframe name="iDAOFrame" onload="iDAOSubmit(this);" width="0px;" height="0px"></iframe>
<script>
	var checkInit = false;
	function iDAOSubmit(iDAOFrame) {
		if ( checkInit ) {
			try {
				var responseMsg = iDAOFrame.contentWindow.document.all("responseXML");	
				if ( responseMsg == null) return;			
				var returnXml = responseMsg.xml;
				//alert(returnXml);
				var respMsgDoc = new ActiveXObject("Msxml2.DOMDocument");		
				respMsgDoc.loadXML (returnXml);
				//alert(respMsgDoc.xml);

				var decNode = respMsgDoc.selectSingleNode("//template[@id='DAO_DECLARATION']");
				var decText = decNode.text;
				insertIDAODeclaration(decText);
				//alert(decText);
				
				var daoNode = respMsgDoc.selectSingleNode("//template[@id='DAO_CODE']");
				var daoText = daoNode.text;
				//alert(daoText);
				insertIDAOCode(daoText);
			} catch (e) {
				alert(e.description);				
			}
					
		}
		checkInit = true;
	}
</script>	

<form name="formLinkForm" action="FormLink.jnlp" method="POST">
	<input type="hidden" name="formId" value="">
	<input type="hidden" name="formVerId" value="">
	<input type="hidden" name="savePath" value="">
	<input type="hidden" name="definitionId" value="">
	<input type="hidden" name="mode" value="out">
</form>	


</body>
</html>

