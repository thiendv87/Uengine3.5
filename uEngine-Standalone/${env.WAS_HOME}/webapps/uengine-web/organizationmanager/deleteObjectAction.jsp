<%//@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="org.uengine.util.dao.*, java.sql.*,javax.sql.*,javax.naming.*" %>
<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>

<%
	String itemType = request.getParameter("itemType") == null ? "" : request.getParameter("itemType");
	String itemId = request.getParameter("itemId") == null ? "" : request.getParameter("itemId");
	String roleCode = request.getParameter("roleCode") == null ? "" : request.getParameter("roleCode");
	String comCode = request.getParameter("comCode") == null ? "" : request.getParameter("comCode");
	
	Connection conn	= null;
	Statement stmt = null;
	StringBuffer sql = new StringBuffer();
	
//	System.out.println(itemType);
//	System.out.println(itemId);
//	System.out.println(roleCode);
	
	if ("department".equals(itemType))
	{
		sql.append("update parttable set isdeleted='1' where partcode='" + itemId + "'");
		sql.append(" AND globalcom = '" + comCode + "'");
	}
	else if ("company".equals(itemType))
	{
		sql.append("update comtable set isdeleted='1' where comcode='" + itemId + "'");
	}
	else if ("roleUser".equals(itemType))
	{
		String[] empCode = itemId.split(":");
		sql.append("delete from roleusertable where rolecode='" + empCode[0].trim() + "' and empcode='" + empCode[1].trim() + "'");
	}
	else if ("role".equals(itemType))
	{
		sql.append("update roletable set isdeleted='1' where rolecode='" + itemId + "'");
		sql.append(" AND comcode = '" + comCode + "'");
	}
	else
	{
		sql.append("update emptable set isdeleted='1' where empcode='" + itemId + "'");
	}
	
//	System.out.println("SQL TEST: " + sql.toString());
	conn = DefaultConnectionFactory.create().getConnection();
	stmt = conn.createStatement();
	stmt.execute(sql.toString());
	stmt.close();
	conn.close();
%>
<br />itemType : <%=itemType %>
<br />itemId : <%=itemId %>
<br />roleCode : <%=roleCode %>
<br />
<br />User information has been successfully updated.

<script>
	window.top.location.href="index.jsp?listtype=" + window.parent.listtype;
</script>