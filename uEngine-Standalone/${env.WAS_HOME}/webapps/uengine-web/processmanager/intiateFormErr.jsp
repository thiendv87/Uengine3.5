<%@include file="../common/header.jsp"%>
<%@ page isErrorPage="true" import="javax.ejb.*"%>

<% 
   if (exception instanceof javax.ejb.ObjectNotFoundException){%>
	No such process definition '<%=decode(request.getParameter("processDefinition"))%>'.
<% }else if (exception instanceof javax.ejb.DuplicateKeyException){%>
	The process arleady started. 
	<a href="viewProcessFlowChart.jsp?instanceId=<%=decode(request.getParameter("defaultInstanceId"))%>">
	<%=decode(request.getParameter("defaultInstanceId"))%>
	</a>
<%}else{%>
	<%=exception.getMessage()%>
	<%exception.printStackTrace();%>
<%}%>
<p>
<a href="javascript:history.back()">back</a>