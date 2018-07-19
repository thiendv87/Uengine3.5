<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.uengine.util.UEngineUtil"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<%
	String strategyId = request.getParameter("strategyId");
	String processMap1Col = request.getParameter("cookieProcessMap1Col");
	if( UEngineUtil.isNotEmpty(processMap1Col) ) {
		Cookie cookie = new Cookie("cookieProcessMap1Col", processMap1Col);
		response.addCookie(cookie);
		response.sendRedirect("viewProcessMap.jsp?strategyId="+strategyId);
	}
	
	String processMap2Col = request.getParameter("cookieProcessMap2Col");
	if( UEngineUtil.isNotEmpty(processMap2Col) ) {
		Cookie cookie = new Cookie("cookieProcessMap2Col", processMap2Col);
		response.addCookie(cookie);
		response.sendRedirect("viewProcessMap2.jsp?strategyId="+strategyId);
	}
%>
</body>
</html>