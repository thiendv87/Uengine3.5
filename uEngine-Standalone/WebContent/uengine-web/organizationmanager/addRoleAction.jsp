<%//@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="org.uengine.util.dao.*, java.sql.*,javax.sql.*,javax.naming.*" %>
<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>

<%
	String roleCode = request.getParameter("roleCode");
	String roleName = request.getParameter("roleName");
	String roleCompany = request.getParameter("roleCompany");
	
	Connection conn	= null;
	PreparedStatement pstmt = null;
	String sql = "INSERT INTO roletable(rolecode, descr, comcode) VALUES(?, ?, ?)";
	
	if(
			UEngineUtil.isNotEmpty(roleCode)
			&& UEngineUtil.isNotEmpty(roleName)
			&& UEngineUtil.isNotEmpty(roleCompany)
	)
	{
		conn = DefaultConnectionFactory.create().getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, roleCode);
		pstmt.setString(2, roleName);
		pstmt.setString(3, roleCompany);
		pstmt.execute();
%>
Role information has been successfully registered.
<script>
	window.top.location.href="index.jsp?listtype=" + window.parent.listtype;
</script>
<%
	}
	else
	{
%>
You must fill out the role name and the role code.
<%
	}
%>