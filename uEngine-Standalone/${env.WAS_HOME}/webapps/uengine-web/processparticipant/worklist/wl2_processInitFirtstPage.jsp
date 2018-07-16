<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%
	String pdId = request.getParameter("processDefinition");
%>

<html>
<head>
	<style TYPE="TEXT/CSS">
	BODY {background:url(../../processmanager/images/empty.gif) #ffffff }
	</style>
</head>
<body>
<table border=0 width=95% height=90% >
	<tr>
<%
	if("".equals(pdId)||pdId==null){
%>
		<td align=center height=400><img src="../../images/preview.gif" ></td>
<%  
	}else{
%>
		<td><%@include file="../viewProcessFlowChart.jsp"%></td>
<%
	}
%>
	</tr>
</table>
		
</body>
</html>