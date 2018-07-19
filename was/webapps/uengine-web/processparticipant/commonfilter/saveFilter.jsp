<%@include file="../../common/header.jsp"%>
<%@include file="../../common/styleHeader.jsp"%>

<%@page import="org.uengine.ui.worklist.filter.*"%>

<%
	String	type = 	request.getParameter("type");
	String  filterName = decode(request.getParameter("filterName"));
	String  definition = request.getParameter("processDefinition");
	String  status = request.getParameter("status");
	String  information = decode(request.getParameter("informationListName"));
	String endpointType = decode(request.getParameter("endpointType"));
	
	//System.out.println("filter type: "+type);
	//System.out.println("information: "+information);
	
	WorkListFilter wf = new WorkListFilter(filterName);
	wf.setType(type);
	wf.setStatus(status);
	wf.setDefinition(definition);
	wf.setInformation(information);
	wf.setEndpointType(endpointType);
		

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