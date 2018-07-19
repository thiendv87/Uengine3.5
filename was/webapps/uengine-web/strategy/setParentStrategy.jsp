<%@page import="java.net.URLDecoder"%><%@page import="org.springframework.web.bind.ServletRequestUtils"%><%@page import="com.defaultcompany.web.strategy.StrategyService"%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
	request.setCharacterEncoding("UTF-8");

	String from = ServletRequestUtils.getStringParameter(request, "fromStrategy", null);
	String to = ServletRequestUtils.getStringParameter(request, "toStrategy", null);
	
	StrategyService ss = new StrategyService();
	ss.setParentId(to,from);
	out.print(ss.allStrategyToJSON());%>