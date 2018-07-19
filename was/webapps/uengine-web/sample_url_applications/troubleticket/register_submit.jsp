<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,javax.sql.*,javax.naming.*"  %>
<%@ page import="org.uengine.util.dao.DbcpConnectionFactory"%>
<%@include file="../../common/header.jsp"%>
<%

	String trouble_class 	= decode(request.getParameter("trouble_class"));
	String trouble_desc	= decode(request.getParameter("trouble_desc"));
	
	Connection 	conn	= null;
	Statement 	stmt 	= null;
	ResultSet 	rs 		= null;
	String 		sql 	="";
	int			rows 	= 0;

	try
	{
			conn = new DbcpConnectionFactory().getConnection();
	        stmt = conn.createStatement();


		sql = "select max(regno)+1 as regno from troubleticket";
		
		rs = stmt.executeQuery(sql);
		int regno = -1;
		while (rs.next())
		{
			regno = rs.getInt("regno");
		}
		rs.close();

		if (regno > -1)
		{
			sql = "insert into troubleticket (regno, problemtype, problemdesc) values ("+regno+", '"+ trouble_class +"', '"+ trouble_desc +"')";
			rows = stmt.executeUpdate(sql);
			%>
			<script>location='view.jsp?regno=<%=regno%>'</script>
			
			<%
			
		}else{
			throw new Exception("Failed to issue a sequence number for register No.");
		}
		
	}
	finally
	{
		if ( stmt != null ) try { stmt.close(); } catch (Exception e) {}
		if ( conn != null ) try { conn.close(); } catch (Exception e) {}
    	}
%>
