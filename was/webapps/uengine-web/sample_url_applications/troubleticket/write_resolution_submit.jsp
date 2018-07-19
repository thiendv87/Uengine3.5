<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,javax.sql.*,javax.naming.*"  %>
<%@ page import="org.uengine.util.dao.DbcpConnectionFactory"%>
<%@include file="../../common/header.jsp"%>
<%

	String regno 	= decode(request.getParameter("regno"));
	String resolution 	= decode(request.getParameter("resolution"));
	
	Connection 	conn	= null;
	Statement 	stmt 	= null;
	ResultSet 	rs 	= null;
	String 		sql 	="";
	int		rows 	= 0;

	try
	{
		conn = new DbcpConnectionFactory().getConnection();
        stmt = conn.createStatement();


		sql = "update troubleticket set resolution='"+resolution+"' where regno=" + regno;
		
		stmt.executeUpdate(sql);
%>
<script>location='view.jsp?regno=<%=regno%>'</script>

<%


		
	}
	finally
	{
		if ( stmt != null ) try { stmt.close(); } catch (Exception e) {}
		if ( conn != null ) try { conn.close(); } catch (Exception e) {}
    }
%>
