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
	String parentGroupId = request.getParameter("parentGroupId");
	System.out.println("RESULT============");
	System.out.println("parentGroupId : " + parentGroupId);

	if ( parentGroupId == null || 
		parentGroupId.equals("undefined") ||
		parentGroupId.equals("null") 
		) {
		//parentGroupId = "0";
		resultMsg = "삭제에 실패하였습니다.";
	} else {
		try {
			formBF.deleteFolder(Long.parseLong(parentGroupId));
		} catch (Exception e) {
			e.printStackTrace(); 
			resultMsg = "삭제에 실패하였습니다.";
		}
	}

	
%>
<html>
<head>
<script language="JavaScript">
	function refreshParent() {
		top.dialogArguments.location.href = top.dialogArguments.location.href;
		if (top.dialogArguments.progressWindow) {
			top.dialogArguments.progressWindow.close()
		}
		parent.close();
	}	
</script>
<link rel="stylesheet" type="text/css" href="<%=CSS%>/common.css">
<link rel="stylesheet" type="text/css" href="<%=CSS%>/body.css">
<script type="text/javascript" src="<%=JS%>/css.js"></script>
</head>

<body>
<%=resultMsg%>
&nbsp;<INPUT TYPE="button" TITLE="ALT+s" ACCESSKEY="s" CLASS="buttonOff" NAME="확인" VALUE="확인" ONFOCUS="this.blur();" ONMOUSEOVER="swapClass(this, 'buttonOver')" ONMOUSEOUT="swapClass(this, 'buttonOff')" ONCLICK="refreshParent();"/>


</body>

</html>