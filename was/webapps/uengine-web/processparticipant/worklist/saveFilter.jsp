<%@include file="../../common/header.jsp"%>
<%@include file="../../common/styleHeader.jsp"%>

<%@page import="org.uengine.webservices.worklist.filter.*"%>

<%
	String  filterName = request.getParameter("filterName");
	String  definition = request.getParameter("processDefinition");
	String  status = request.getParameter("status");
	String  information = request.getParameter("information");	
	
	WorkListFilter wf = new WorkListFilter(filterName);
	wf.setStatus(status);
	wf.setDefinition(definition);
	wf.setInformation(information);
	
	WorkListFilterList wfl = WorkListFilterList.load();
	wfl.setWorkItemFilters(wf);
	
	WorkListFilterList.save(wfl);
%>
<html>
<head>
<style TYPE="TEXT/CSS">
BODY {background:url(../../processmanager/images/empty.gif) #ffffff }
</style>
</head>
<body>
<table width=100% height=100%>
	<tr>
		<td>
		<div class="portlet-msg-success">
			This filter has been successfully saved
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