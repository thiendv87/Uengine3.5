
<%@include file="../../common/header.jsp"%>
<%@page import="org.uengine.util.dao.*"%>
<%@page import="org.uengine.persistence.dao.*"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="basic.css" rel="stylesheet" type="text/css">


<%
	String pd = decode(request.getParameter("taskId"));
	WorkListDAO wl = (WorkListDAO)GenericDAO.createDAOImpl(
		"java:/uEngineDS", 
		GlobalContext.getSQL("workitem.delete"), 
		WorkListDAO.class
	);
	
	wl.update();
%>

<script type="text/javascript">
	function sendRedirectPage() {
		setTimeout("sendUrl()", 2000);
	}

	function sendUrl() {
		history.go(-1);
		//location.href = "viewFormDefinition.jsp?objectDefinitionId=983&folder=&processDefinitionVersionID=12357";
	}
</script>
<body>
<div id="center">
	<div class="boxtext">
Object has been successfully saved with id [983@12357]
	</div>
</div>
</body>
</html>


<script type="text/javascript">
sendRedirectPage();
</script>