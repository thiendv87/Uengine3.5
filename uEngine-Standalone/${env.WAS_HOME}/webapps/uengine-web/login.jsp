<%@page contentType="text/html; charset=UTF-8" language="java" import="com.defaultcompany.login.LoginService"%><%
	LoginService loginService = new LoginService();
%>
<%=loginService.login(request)%>
