<%@include file="../../common/header.jsp"%>
<%@include file="../../common/styleHeader.jsp"%>

<%@page import="org.uengine.ui.worklist.filter.*"%>

<%
	String  filterUID = request.getParameter("filterUID");
	String  fileterType = request.getParameter("fileterType");
	

		WorkListFilterList wfl = WorkListFilterList.load();
		wfl.deleteFilter(filterUID);	

	
%>
<html>
<head>
<style type="text/css">
BODY {background:url(../../processmanager/images/empty.gif) #ffffff }
</style>
</head>
<body>
<table width=100% height=100%>
	<tr>
		<td>
		<div class="portlet-msg-success">
			This filter has been successfully deleted
		</div>
		</td>
	<tr>
</table>	
</body>
</html>

<script>

	sendRedirectPage();
	
	function sendRedirectPage() {
		setTimeout("windowClose()", 1500);
	}

	function windowClose(){
		opener.location.reload();
		window.close();
	}
</script>