<%@include file="../common/header.jsp"%>


<LINK href="../style/uengine.css" type=text/css rel=stylesheet>

<%
	InitialContext context = new InitialContext();
	ProcessManagerHomeRemote pmh = (ProcessManagerHomeRemote)context.lookup("ProcessManagerHomeRemote");
	
	ProcessManagerRemote pm = pmh.create();
	
	String pi = decode(request.getParameter("instanceId"));
	pm.removeProcessInstance(pi);
%>
Process archive '<%=pi%>' has been successfully removed.<p>

[<a href="processArchiveList.jsp">back</a>]