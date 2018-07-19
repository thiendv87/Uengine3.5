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
<%@page import="hanwha.bpm.form.business.FormBusinessFacade"%>
<%
	RequestContext reqCtx = new RequestContext(request);
	FormBusinessFacade formBF = new FormBusinessFacade(reqCtx);

	String resultMsg = "성공적으로 삭제 되었습니다.";
	String formId = request.getParameter("formId");
	String formVerId = request.getParameter("formVerId");
	String actionType = request.getParameter("actionType");
	String formVersion = request.getParameter("formVersion");
	System.out.println("form_delte start============");
	System.out.println("formId : " + formId);
	System.out.println("formVerId : " + formVerId);
	System.out.println("formVersion : " + formVersion);

	if ( actionType == null ) {
		actionType = "del_form";
	}
	
	if ( formId == null ) {
		resultMsg = "삭제에 실패하였습니다.";
	} else if ( actionType.equals("del_form") ) {
		try {
			formBF.deleteForm(Long.parseLong(formId));
		} catch(Exception e) {
			e.printStackTrace();
			resultMsg = "삭제에 실패하였습니다.";
		}
	} else if ( actionType.equals("del_form_ver") ) {
		try {
			formBF.deleteFormVersion(Long.parseLong(formVerId));
		} catch(Exception e) {
			e.printStackTrace();
			resultMsg = "삭제에 실패하였습니다.";
		}
	}
	System.out.println("form_delte end============");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="<%=CSS%>/common.css">
<link rel="stylesheet" type="text/css" href="<%=CSS%>/body.css">
<script type="text/javascript" src="<%=JS%>/css.js"></script>
<script language="JavaScript">
	function resultMsg(){

		alert("<%=resultMsg%>");
<%
	if ( actionType.equals("del_form_ver") ) {
%>
  		document.roleMenuForm.formId.value = "<%=formId%>";
  		document.roleMenuForm.action = "edit.jsp?action=view";
  		document.roleMenuForm.submit();
<%		
	} else {
%>
		parent.location.reload();
<%	
	}
%>
		//function refreshParent() {
			//parent.left.location.href = parent.left.location.href;
		//}	
	}
</script>

</head>

<body onload="resultMsg();">
<!--
<%=resultMsg%>
&nbsp;<INPUT TYPE="button" TITLE="ALT+s" ACCESSKEY="s" CLASS="buttonOff" NAME="확인" VALUE="확인" ONFOCUS="this.blur();" ONMOUSEOVER="swapClass(this, 'buttonOver')" ONMOUSEOUT="swapClass(this, 'buttonOff')" ONCLICK="refreshParent();"/>
-->

<form name="roleMenuForm" method="POST">
<input type="hidden" name="formId">
<input type="hidden" name="ownCompany" value="<%=loggedUserCompanyId%>">
</form>

</body>

</html>