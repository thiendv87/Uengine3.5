
<%@include file="../../../common/header.jsp"%>
<%@include file="../../../common/getLoggedUser.jsp"%>

<%@include file="../../wihDefaultTemplate/definition.jsp"%>
<%@include file="../../wihDefaultTemplate/initialize.jsp"%>
<%@include file="../../wihDefaultTemplate/findBackableActivities.jsp"%>
<%@include file="../../wihDefaultTemplate/checkLogin.jsp"%>


<%
	try {
%>
<div align="center">

<%@include file="../../wihDefaultTemplate/returnIfNotRunning.jsp"%>
<%@include file="../../wihDefaultTemplate/showInputForm.jsp"%>
</div>
<%
	} finally {
		try { pm.cancelChanges(); } catch(Exception ex) {}
		try { pm.remove(); } catch(Exception ex) {}
	}
%>

