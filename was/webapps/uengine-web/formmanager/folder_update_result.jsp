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
<%@include file="../../common/commons.jsp"%>
<%@page import="hanwha.bpm.form.manager.*"%>
<%@page import="hanwha.bpm.form.*"%>
<%@page import="hanwha.bpm.form.dao.*"%>
<%@page import="hanwha.commons.util.*"%>
<%@page import="org.uengine.contexts.RequestContext"%>
<%@page import="hanwha.bpm.form.business.FormBusinessFacade"%>
<%
	String parentGroupId = request.getParameter("parentGroupId");
	if ( parentGroupId == null || 
		parentGroupId.equals("undefined") ||
		parentGroupId.equals("null") 
		) {
		parentGroupId = "0";
	}
	String procDefId = request.getParameter("procDefId");
	String ownCompany = request.getParameter("ownCompany");
	String name = GWUtil.toEncode(request.getParameter("name"));
	String desc = request.getParameter("desc");
	if ( desc != null ) desc = GWUtil.toEncode(desc);
	String action = request.getParameter("action");	
	String actionType = request.getParameter("actionType");	
	if ( actionType == null ) actionType = "folder";
	
	String formType = request.getParameter("formType");	
	
	System.out.println("RESULT============");
	System.out.println("parentGroupId : " + parentGroupId);
	System.out.println("procDefId : " + procDefId);
	System.out.println("ownCompany : " + ownCompany);		
	System.out.println("name : " + name);	
	System.out.println("action : " + action);
	System.out.println("formType : " + formType);	
	
	String resultMsg = "성공적으로 업데이트 되었습니다.";
	try {
		RequestContext reqCtx = new RequestContext(request);
		FormBusinessFacade formBF = new FormBusinessFacade(reqCtx);
		if ( actionType.equals("folder") ) {
			if ( action.equals("add") ) {
				formBF.addFolder(Long.parseLong(parentGroupId), name, name, Long.parseLong(ownCompany));
			} else if ( action.equals("update") ) {
				formBF.renameFolder(Long.parseLong(parentGroupId), name);
			}
		} else if ( actionType.equals("form") ) {
			if ( action.equals("add") ) {
				formBF.addForm(Long.parseLong(parentGroupId), name, "", desc, false, formType);
			} else if ( action.equals("update") ) {
				//formDAOFacade.updateForm(Long.parseLong(parentGroupId), name, name, name);
			}
		}
	} catch (Exception e) {
		e.printStackTrace(); 
		resultMsg = "업데이트에 실패하였습니다.";
	}
%>
<html>
<head>
<script language="JavaScript">
	function confirm() {
		top.dialogArguments.refresh();
		//window.calendar.refresh();
		parent.close();
	}
	
	function refreshParent() {
//		top.dialogArguments.location.href = top.dialogArguments.location.href;
		top.dialogArguments.location.reload();
		if (top.dialogArguments.progressWindow) {
			top.dialogArguments.progressWindow.close()
		}
		parent.close();
	}
	
</script>
<LINK REL="stylesheet" type="text/css" href="<%=CSS%>/common.css">
<LINK REL="stylesheet" type="text/css" href="<%=CSS%>/body.css"/>
<script type="text/javascript" src="<%=JS%>/css.js"></script>
</head>

<body>
<%=resultMsg%>
&nbsp;<INPUT TYPE="button" TITLE="ALT+s" ACCESSKEY="s" CLASS="buttonOff" NAME="확인" VALUE="확인" ONFOCUS="this.blur();" ONMOUSEOVER="swapClass(this, 'buttonOver')" ONMOUSEOUT="swapClass(this, 'buttonOff')" ONCLICK="refreshParent();"/>


</body>

</html>