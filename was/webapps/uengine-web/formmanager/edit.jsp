<%@page pageEncoding="KSC5601"%>
<%response.setContentType("text/html; charset=UTF-8");%>
<%--
  - Author(s): Sungsoo Park ( ghbpark@hanwha.co.kr )
  - Copyright Notice:
	Copyright 2001-2005 by HANWHA S&C Corp.,
	All rights reserved.

	This software is the confidential and proprietary information
	of HANWHA S&C Corp. ("Confidential Information").  You
	shall not disclose such Confidential Information and shall use
	it only in accordance with the terms of the license agreement
	you entered into with HANWHA S&C Corp.
  - @(#)
  - Description:
--%>
<%@include file="../../common/no_cache.jsp"%>
<%@include file="../../common/commons.jsp"%>
<%@page import="hanwha.commons.dao.IDAO"%>
<%@page import="hanwha.commons.dao.GenericDAO"%>
<%@page import="hanwha.bpm.form.business.FormBusinessFacade"%>
<%@page import="hanwha.bpm.form.dao.ProductionFormDAO"%> 
<%@page import="hanwha.bpm.form.dao.FormVersionDAO"%> 
<%@page import="java.util.Date"%> 
<jsp:useBean id="saveFormBean" scope="page" class="hanwha.bpm.form.admin.SaveFormBean" />
<jsp:setProperty name="saveFormBean" property="*" />
<%
	RequestContext reqCtx = new RequestContext(request);
	FormBusinessFacade formBF = new FormBusinessFacade(reqCtx);

	String formId = request.getParameter("formId");
	String formVerId = request.getParameter("formVerId");
	System.out.println("edit.jsp : formVerId : " + formVerId);
	String actionType = request.getParameter("actionType");
	
	boolean versionIncreaseYN = saveFormBean.getVersionIncreaseYN().equalsIgnoreCase("yes") ? true : false;
	
	String formVersion = request.getParameter("formVersion");
	
	System.out.println("formVersion : " + formVersion);
	
	if ( actionType != null ) {
		if ( actionType.equals("save") ) {
			try {
				saveFormBean.processRequest(request);
			} catch(Exception e) {
				e.printStackTrace();
				throw e;
			}
		} else if ( actionType.equals("setAsProduction") ) {
			try {
				formBF.setAsProduction(Long.parseLong(formId), Long.parseLong(formVersion));
				//saveFormBean.setAsProduction();
			} catch(Exception e) {
				e.printStackTrace();
				throw e;
			}
		}
	}
	
	System.out.println("formId : " + formId);
	//
	//System.out.println("getFormName : " + saveFormBean.getFormName());
	
	if ( formId == null ) {
%>
<body>
</body>
<%	
		return;
	}
%>

<%	
	///////////////////////////////////////////////////////////////////////////
	// Get FormVersion List.
	FormVersionDAO formVersionDAO = formBF.getFormVersionList(Long.parseLong(formId));
	int iVerListSize = formVersionDAO.size();
	///////////////////////////////////////////////////////////////////////////

	ProductionFormDAO productionFormDAO = formBF.getProductionForm(formId, formVerId, versionIncreaseYN);
	
	System.out.println("productionFormDAO.size() : " + productionFormDAO.size());
	
	if ( productionFormDAO.size() == 0 ) return;
	
	int formVer_formversion  = productionFormDAO.getVersion().intValue();	// 현재 편집중인 버전.
	int formVer_formVerId = productionFormDAO.getFormVersionId().intValue();	// 현재 편집중인 버전 ID.
	int formMain_productionVer = productionFormDAO.getProductionVersion().intValue();
	String processDefinition = ( productionFormDAO.getDefinitionId() != null ) ? productionFormDAO.getDefinitionId().toString() : "";
	
	
	String formType = productionFormDAO.getFormType();
	if ( formType == null ) formType = "form";
	
	String chkFreeEdit = ( productionFormDAO.getFreeEditorYN().booleanValue() ) ? "checked" : "";
		
	String formPath = productionFormDAO.getFormPath().replace('\\', '/');
	
	String formPathPrefix = formPath.substring(0, formPath.lastIndexOf("."));
	String submitHandlerPath = formPathPrefix + "_submit.jsp";
	
	String formBasePath = formPathPrefix;
	
	String chkFomrlinkIn = ( productionFormDAO.getFormLinkInYN().booleanValue() ) ? "checked" : "";
	String chkFomrlinkOut = ( productionFormDAO.getFormLinkOutYN().booleanValue() ) ? "checked" : "";
	
	String displayName = productionFormDAO.getDisplayName();
	if ( !GWUtil.isNotEmpty(displayName) ) displayName = productionFormDAO.getFormName();
%>
<html>
<head>
<title>폼 편집</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />                                                                                                                                                                
<link rel="stylesheet" type="text/css" href="<%=CSS%>/admin_common.css.jsp">
<link rel="stylesheet" type="text/css" href="<%=CSS%>/admin_page.css.jsp">
<link rel="stylesheet" type="text/css" href="<%=CSS%>/global.css.jsp">
<link rel="stylesheet" type="text/css" href="<%=CSS%>/bpm.css">
<script type="text/javascript" src="<%=JS%>/css.js"></script>
<script type="text/javascript" src="<%=JS%>/popup.js"></script>
<script language="JavaScript">
	function loadForm() {
  		var url = "<%=HttpUtil.getBaseUrl(request)%>" + document.editForm.formUrl.value;
  		//alert(url);
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

		var url = "dao_generate_edit.jsp?path=<%=submitHandlerPath%>";
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
			alert("양식 제목을 입력하세요");
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

//		var reportInfo = "버전을 증가시키시겠습니까?";	
//		if(!confirm(reportInfo)){
//			document.editForm.versionIncreaseYN.value = 'no';
//		}
//		document.editForm.actionType.value = 'save';
//		document.editForm.action = "edit.jsp";
//		document.editForm.submit();

		var reportInfo = "저장하시겠습니까?";	
		if(confirm(reportInfo)){
			// 무조건 버전업한다.
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
		var deleteAlert = "현재 버전을 삭제하시겠습니까?";	
		var actionType = "del_form_ver";

		if( <%=iVerListSize%> <= 1 ){
			deleteAlert = "현재 폼을 삭제하시겠습니까?";	
			actionType = "del_form";
		}
		
		if(!confirm(deleteAlert)){
			return;
		}

		document.editForm.actionType.value = actionType;
		document.editForm.action = "form_delete.jsp";
		document.editForm.submit();
	}
	
	// DAO 추가.
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
			alert("양식에 프로세스를 매핑하신 후 사용하시기 바랍니다.");
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
			alert("양식에 프로세스를 매핑하신 후 사용하시기 바랍니다.");
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
		var url = "select_processdefinition_frame.jsp?formId=<%=formId%>";
		var StrOption ;
		StrOption  = "dialogWidth:600px;dialogHeight:500px;";
		StrOption += "center:on;scroll:auto;status:off;resizable:off";	
		showModelessDialog (url , window, StrOption);		
	}
	
	function setProcessDefinition(name, pd) {
		pdInfo.innerHTML = name + " (" + pd + ")";
		document.formLinkForm.definitionId.value = pd;
	}
	
	// 달력.
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
	
	// 사용자 찾기.
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
	
	// 부서 찾기.
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
		var expression = '<bpm:formUserList name="'+formDeptListName+'" treeOption="T" titleHead="부서찾기" titleMain="부서찾기" titleSelected="선택된 부서" viewMode="<'+'%=InputConstants.VIEW%'+'>"/>';
		var replaceStr = prefix + expression + postfix;
		document.Wec.Value = replaceStr;
	}	
	
	
	// 팀장 찾기.
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

	// 파일업로드.
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
									
	<%-- showDBDialog()에서 callback() 형태로 호출됨 --%>
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

	// 필드설정.
	function selectBindingElement() {
		showSelectBindingElementDialog();
	}
	
	// 필드설정 다이알로그.
	function showSelectBindingElementDialog() {
		//alert("showSelectBindingElementDialog");
		var url = "select_binding_element_frame.jsp?formId=<%=formId%>&formVerId=<%=formVer_formVerId%>";
		var StrOption ;
		StrOption  = "dialogWidth:800px;dialogHeight:500px;";
		StrOption += "center:on;scroll:auto;status:off;resizable:off";	
		showModalDialog (url , window, StrOption);
		//window.open(url);
	}
	
	// 필수 입력 항목 설정.
	function selectBindingMandatoryElement() {
		showSelectBindingMandatoryElementDialog();
	}

	// 필수 입력 항목 설정 다이알로그.
	function showSelectBindingMandatoryElementDialog() {
		//alert("showSelectBindingMandatoryElementDialog");
		var url = "select_binding_mandatory_element_frame.jsp?formId=<%=formId%>&formVerId=<%=formVer_formVerId%>";
		var StrOption ;  
		StrOption  = "dialogWidth:750px;dialogHeight:480px;";
		StrOption += "center:on;scroll:no;status:off;resizable:off";	
		showModalDialog (url , window, StrOption);
		//window.open(url);
	}
	
	// 나모웹 에디터 설정 다이알로그.
	function openfreeContentsDlg() {
		var url = "freeContents_frame.jsp";
		var StrOption ;
		StrOption  = "dialogWidth:350px;dialogHeight:180px;";
		StrOption += "center:on;scroll:auto;status:off;resizable:off";	
		showModalDialog (url , window, StrOption);
	}	
	
	// 나모웹 에디터 설정.
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

	// 매뉴얼 관련
	function openJobManualDlg(){
		var url = "job_manual_frame.jsp?formId=<%=formId%>";
		var StrOption ;
		StrOption  = "dialogWidth:600px;dialogHeight:280px;";
		StrOption += "center:on;scroll:auto;status:off;resizable:off";	
		showModalDialog (url , window, StrOption);
	}
	function setJobManualProcess( cnt ) {
		if(Number(cnt) > 0)	manualInfo.innerHTML = "등록";
		else manualInfo.innerHTML = "미등록";

	}

	// 그리드 관련
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
	폼 버전 아이디: <input value="<%=formVerId%>">
	폼 아이디: <input value="<%=formId%>">

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
<input type="hidden" name="baseURL" value="<%=HttpUtil.getBaseUrl(request)%>">
<input type="hidden" name="formId" value="<%=productionFormDAO.getFormId()%>">
<input type="hidden" name="mimeValue">
<input type="hidden" name="actionType">
<input type="hidden" name="path" value="<%=formPath%>">
<input type="hidden" name="formUrl" value="/hwbpm/downloadSvc/form.mht?module=bpm&path=<%=formPath%>&name=form.xml&type=form&isView=down&sid=<%=hanwha.commons.util.GWUtil.getUniqID()%>">

<input type="hidden" name="submitHandlerPath" value="<%=submitHandlerPath%>">
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

<input type="hidden" name="formVerId" value="<%=productionFormDAO.getFormVersionId()%>">
<input type="hidden" name="formVersion" value="<%=productionFormDAO.getVersion()%>">

<input type="hidden" name="versionIncreaseYN" value="yes">

<!--	########################	contents start		########################	-->
<table class="bodyframe" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td> 
      <!--타이틀 테이블 시작 -->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td class="title_bg"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td> 
                  <!--타이틀글씨box시작 -->
                  <table border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td class="title"> 
                        <!--타이틀아이콘 -->
                        <img src="<%=IMG%>/themes/common/images/title_icon.gif" align="absmiddle">폼편집</td>
                    </tr>
                  </table>
                  <!--타이틀글씨box끝 -->
                </td>
                <td class="location_t_padding"> 
                  <!--경로테이블시작 -->
                  <table border="0" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td class="location_padding"> <img src="<%=IMG%>/themes/common/images/bull-tri-gray.gif" align="absmiddle"> 
                        BPM &gt;<font class="linemap_curpos">폼편집</font></td>
                    </tr>
                  </table>
                  <!--경로테이블끝 -->
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <!--타이틀 테이블 끝 -->
      <table width="100%"   border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td class="margin_table"></td>
        </tr>
      </table>
      <!--테이블 위 라인시작 -->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td class="list_tit_line_s"></td>
        </tr>
        <tr>
          <td class="list_btn_line_e"></td>
        </tr>
      </table>
      <!--테이블 위 라인끝-->      
      <!--본문내용 시작-->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="td_tit">양식명</td>
			<td class="td_left"><input type="text" class="input" name="formName" value="<%=productionFormDAO.getFormName()%>" class="input" style="width:90%"></td>
			<td class="td_tit" >화면출력용 제목</td>
			<td class="td_left"><input type="text" class="input" name="displayName" value="<%=displayName%>"></td>
			<input style="display:none" type="checkbox" name="freeEdit" value="" <%=chkFreeEdit%>>
		</tr>
        <tr> 
          <td class="td_line" colspan="4"></td>
        </tr>
		<tr height="28">
			<td class="td_tit">폼 형태</td>
			<td class="td_left">
				<select class="select" size="1" name="formType" class="input">
					<option value="form" <%if(formType.equalsIgnoreCase("form")) out.println("selected");%>>기본(자유) 양식</option>
					<option value="approval" <%if(formType.equalsIgnoreCase("approval")) out.println("selected");%>>전자결재 (기본)</option>
					<option value="approval1" <%if(formType.equalsIgnoreCase("approval1")) out.println("selected");%>>전자결재 (대내 시행)</option>
					<option value="approval11" <%if(formType.equalsIgnoreCase("approval11")) out.println("selected");%>>전자결재 (대외 시행)</option>
					<option value="approval2" <%if(formType.equalsIgnoreCase("approval2")) out.println("selected");%>>전자결재 (기안)</option>
					<option value="approval3" <%if(formType.equalsIgnoreCase("approval3")) out.println("selected");%>>전자결재 (보고)</option>
					<option value="approval4" <%if(formType.equalsIgnoreCase("approval4")) out.println("selected");%>>전자결재 (회람)</option>
<!--				<option value="approval5" <%if(formType.equalsIgnoreCase("approval5")) out.println("selected");%>>전자결재 (대외발신문서)</option> -->
					<option value="approval6" <%if(formType.equalsIgnoreCase("approval6")) out.println("selected");%>>전자결재 (None Title)</option>
					<option value="approval7" <%if(formType.equalsIgnoreCase("approval7")) out.println("selected");%>>OneStop (기안문)</option>
					<option value="approval8" <%if(formType.equalsIgnoreCase("approval8")) out.println("selected");%>>전자결재 (시행문 내부결재)</option>
					<option value="approval12" <%if(formType.equalsIgnoreCase("approval12")) out.println("selected");%>>전자결재 (시행결과보고)</option>
					<option value="approval9" <%if(formType.equalsIgnoreCase("approval9")) out.println("selected");%>>전자결재 (지출품의)</option>
					<option value="approval10" <%if(formType.equalsIgnoreCase("approval10")) out.println("selected");%>>전자결재 (대외문서 내부결재)</option>
					<option value="approval13" <%if(formType.equalsIgnoreCase("approval13")) out.println("selected");%>>전자결재 (법인카드)</option>
					<option value="approval14" <%if(formType.equalsIgnoreCase("approval14")) out.println("selected");%>>전자결재 (신청)</option>
				</select>				
			</td>
			<td class="td_tit">프로세스 정의</td>
			<td class="td_left">
			  <span id="pdInfo">
<%
	String pdButtonName = "연결";
	if ( productionFormDAO.getDefinitionId() != null ) {
		pdButtonName = "변경";
		IDAO pdInfoDAO = (IDAO)GenericDAO.createDAOImpl("select DEFINITIONNAME from BPM_PROCDEF where DEFINITIONID = ?id", IDAO.class);
		pdInfoDAO.set("id", new Long(processDefinition));	
		pdInfoDAO.select();
		pdInfoDAO.next();
%>
								<%=pdInfoDAO.get("DEFINITIONNAME")%> (<%=processDefinition%>)
<%
	} else {
%>	
								연결된 프로세스 정의 없음 
<%
	}
%>
				</span>
				<img src="<%=IMG%>/btn-conec.gif" align="absmiddle" onclick="openProcessDefinitionMappingDlg('<%=processDefinition%>')" style="cursor:hand;">
		</tr>
        <tr> 
          <td class="td_line" colspan="4"></td>
        </tr>
		<tr height="28">
			<td class="td_tit"> 폼링크 사용  여부 </td>
			<td class="td_left" >
				IN&nbsp;<input type="checkbox" name="formInYN" value="" <%=chkFomrlinkIn%>>&nbsp;&nbsp;&nbsp;
				OUT&nbsp;<input type="checkbox" name="formOutYN" value="" <%=chkFomrlinkOut%>>
			</td>
			<td class="td_tit"> 메뉴얼 여부 </td>
			<td class="td_left" >
					
<%
    String jobmanualyn="메뉴얼을 등록하려면 여기를 클릭하시오. ";
    if(productionFormDAO.getJobManualYN().booleanValue())	jobmanualyn = "등록";

%>					
			<a href="#" onclick="openJobManualDlg('<%=formId%>');" class="bold">
			<span id="manualInfo">
			<%=jobmanualyn %>
			</span>
			</a>
			</td>				
		</tr>
        <tr> 
          <td class="td_line" colspan="4"></td>   
        </tr>
		<tr height="28">
			<td class="td_tit"> 현재 편집중인 버전 </td>
			<td class="td_left"  colspan="3">
				<b><%=formVer_formversion%></b> &nbsp;&nbsp;
<%
	if ( formMain_productionVer > 0 && formMain_productionVer == formVer_formversion ) {
%>								
				<font class="txt-r">[This version is production] </font>
<%
	} else {
%>
				<INPUT TYPE="button" class="input" TITLE="Set as production" NAME="Set as production" VALUE="Set as production" onclick="setAsProduction()"/>				
<%
	}
%>										
			</td>	
		</tr>
        <tr> 
          <td class="td_line" colspan="4"></td>
        </tr>		
		<tr height="28">		
			<td class="td_tit"> 전체 버전 목록 </td>
			<td class="td_left" colspan="3">
<%								
//	FormVersionDAO formVersionDAO = formBF.getFormVersionList(Long.parseLong(formId));	// Top 으로 이동.
	for ( int i=0; formVersionDAO.next(); i++ ) {
		//TODO List Box 로 보여줌.
		int formVerIdValue = formVersionDAO.getFormVersionId().intValue();
		Date formVerDate = formVersionDAO.getModifiedDate();
		
		int formVersionValue = formVersionDAO.getVersion().intValue();
		String verInfoTxt = formVersionValue+"";
		if ( formVer_formVerId == formVerIdValue && formMain_productionVer == formVersionValue ) {
			verInfoTxt += " [<font color=red>Production</font>, <font color=red>Edit</font>]";
		} else if ( formVer_formVerId == formVerIdValue && formMain_productionVer != formVersionValue ) {
			verInfoTxt += " [<font color=red>Edit</font>]";
		} else if ( formMain_productionVer == formVersionValue ) {
			verInfoTxt += " [<font color=red>Production</font>]";
		}
%>
					<font title="<%=formVerDate%>" onmouseover='this.style.textDecoration="underline"' style="font-size: 10pt; CURSOR: hand; TEXT-DECORATION: none" onmouseout='this.style.textDecoration="none"'  onclick="javascript:showForm('<%=formVersionValue%>', '<%=formVerIdValue%>')"><b><%=verInfoTxt%></b></font>
					<%=(i!=formVersionDAO.size()-1)?",":""%>&nbsp;&nbsp;
<%
	}
%>								
		    </td>
		 </tr>
	   </table>
       <!--테이블 라인시작 -->
       <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr><td class="list_btn_line_e"></td></tr>
         <tr><td class="list_line_light"></td></tr>
       </table>
       <br>
		<!--	#####	basic setting end		#####	-->
				<table border="0" cellspacing="0" cellpadding="0">
					<tr><td>
						<a href="#" ><img onclick="openVariableMappingDlg();" src="<%=IMG%>/but-01-off.gif" border="0" name="Image01" style="margin-left:1" title="변수연결"></a>
						<a href="#" ><img onclick="openContentEditor();" src="<%=IMG%>/but-02-off.gif" border="0" name="Image02" style="margin-left:1" title="소스편집"></a>
						<a href="#" ><img onclick="editSubmitAction();" src="<%=IMG%>/but-03-off.gif" border="0" name="Image03" style="margin-left:1" title="완료액션편집"></a>
						<a href="#" ><img onclick="openFormLinkDlg('in');" src="<%=IMG%>/but-04-off.gif" border="0" name="Image04" style="margin-left:1" title="폼링크(IN)"></a>
						<a href="#" ><img onclick="openFormLinkDlg('out');" src="<%=IMG%>/but-05-off.gif" border="0" name="Image05" style="margin-left:1" title="폼링크(OUT)"></a>
						<a href="#" ><img onclick="insertDAO();" src="<%=IMG%>/but-06-off.gif" border="0" name="Image06" style="margin-left:1" title="데이터베이스 연동"></a>
					</td></tr>
				</table>
				<br style="line-height:2px">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr><td>
						<a href="#" ><img onclick="selectBindingElement();" src="<%=IMG%>/but-07-off.gif" border="0" name="Image07" style="margin-left:1" title="필드설정"></a>
						<a href="#" ><img onclick="openCalendarDlg();" src="<%=IMG%>/but-08-off.gif" border="0" name="Image08" style="margin-left:1" title="달력"></a>
						<a href="#" ><img onclick="openFormUserListDlg();" src="<%=IMG%>/but-09-off.gif" border="0" name="Image09" style="margin-left:1" title="사용자찾기"></a>
						<a href="#" ><img onclick="openFormDeptListDlg();" src="<%=IMG%>/but-10-off.gif" border="0" name="Image10" style="margin-left:1" title="팀장찾기"></a>
						<a href="#" ><img onclick="openFileUploadDlg();" src="<%=IMG%>/but-11-off.gif" border="0" name="Image11" style="margin-left:1" title="파일첨부"></a>
						<a href="#" ><img onclick="saveForm();" src="<%=IMG%>/but-12-off.gif" border="0" name="Image12" style="margin-left:1" title="저장하기"></a>
						<a href="#" ><img onclick="deleteForm();" src="<%=IMG%>/but-13-off.gif" border="0" name="Image13" style="margin-left:1" title="폼삭제"></a>
					</td></tr>
					<tr><td>
						<%-- 부서찾기 --%>						
						<a href="#"><img onclick="openSearchManagerDlg();" src="<%=IMG%>/but-14-off.gif" border="0" name="Image14" style="margin-left:1" title="부서찾기"></a>					
						<!-- 그리드 입력 설정 -->
						<a href="#"><img onclick="openGridDlg();" src="<%=IMG%>/but-15-off.gif" border="0" name="Image15" style="margin-left:1" title="그리드 입력 설정"></a>					
						<!-- 필수 입력 항목 설정 -->
						<a href="#"><img onclick="selectBindingMandatoryElement();" src="<%=IMG%>/but-16-off.gif" border="0" name="Image16" style="margin-left:1" title="필수 입력 항목 설정"></a>
						<!-- 나모웹에디터  설정 -->
						<a href="#"><img onclick="openfreeContentsDlg();" src="<%=IMG%>/but-17-off.gif" border="0" name="Image17" style="margin-left:1" title="나모웹에디터  설정"></a>
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
								<param name="LPKPath" value="/hwbpm/lib/namo/ActiveSquare5/NamoWec5_hanwha_snc.lpk"/>
								</OBJECT>
								
								<OBJECT ID="Wec" 
									style="width:100%;height:630px;"  
									CLASSID="CLSID:9AE9AD96-D867-4ac4-8AF1-775C66A9E83B"  
									codebase="/hwbpm/lib/namo/ActiveSquare5/NamoWec.cab#version=5,0,0,16"  
									viewMode="edit">
									<param name="InitFileURL" value="/hwbpm/lib/namo/ActiveSquare5/env/approval_admin.env">
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
	<input type="hidden" name="formId" value="<%=productionFormDAO.getFormId()%>">
	<input type="hidden" name="formVerId" value="<%=productionFormDAO.getFormVersionId()%>">
	<input type="hidden" name="savePath" value="<%=formBasePath%>">
	<input type="hidden" name="definitionId" value="<%=processDefinition%>">
	<input type="hidden" name="mode" value="out">
</form>	


</body>
</html>

