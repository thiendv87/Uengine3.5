<%@page contentType="text/html; charset=UTF-8" language="java" import="com.defaultcompany.login.LoginServiceNew"%><%
	LoginServiceNew loginService = new LoginServiceNew();
%><%=loginService.login(request)%>