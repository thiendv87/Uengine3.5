<%@include file="../wihDefaultTemplate/header.jsp"%>

<%@include file="../wihDefaultTemplate/initialize.jsp"%>


<%
	String documentFile = decode(request.getParameter("documentFile"));
%>

<html>
<LINK href="../../style/uengine.css" type=text/css rel=stylesheet>

<SCRIPT LANGUAGE="Javascript">
	function launchFile(){
		location = "DocumentInvoker.jnlp?documentFile=<%=documentFile%>&FTPid=<%=request.getParameter("FTPid")%>&FTPpw=<%=request.getParameter("FTPpw")%>&uploadFTPAddress=<%=request.getParameter("uploadFTPAddress")%>&uploadFTPDirectory=<%=request.getParameter("uploadFTPDirectory")%>";
	}
</script>

<body on load=launchFile()>

<form action=submit.jsp method=POST>

<%@include file="../wihDefaultTemplate/passValues.jsp"%>
<%@include file="../wihDefaultTemplate/showFlowChart.jsp"%>
<%@include file="../wihDefaultTemplate/showRoleBindingForm.jsp"%>
<%@include file="../wihDefaultTemplate/returnIfNotRunning.jsp"%>

When you complete the task, please click 'Complete' button to submit the result.
<br>
<input type=button onclick="launchFile()" value="Open Document">
	<input type=submit value="Complete">

</form>

<%@include file="../wihDefaultTemplate/showRelatedKnowledges.jsp"%>