<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,javax.sql.*,javax.naming.*"  %>
<%@ page import="org.uengine.util.dao.DbcpConnectionFactory"%>
<%@include file="../../common/header.jsp"%>
<%

	String regno 	= decode(request.getParameter("regno"));
	
	Connection 	conn	= null;
	Statement 	stmt 	= null;
	ResultSet 	rs 		= null;
	String 		sql 	="";
	int			rows 	= 0;

	try
	{
		conn = new DbcpConnectionFactory().getConnection();
        stmt = conn.createStatement();

		sql = "select problemtype,problemdesc,resolution from troubleticket where regno = " + regno;
		
		rs = stmt.executeQuery(sql);
		while (rs.next())
		{
			String trouble_class = rs.getString("problemtype");
			String trouble_desc = rs.getString("problemdesc");
			String resolution = rs.getString("resolution");
			
			%>
			Reg no : <%=regno%><br>
			Trouble Class: <%=trouble_class%><br>
			Trouble Desc: <%=trouble_desc%><br>
			Resolution: <%=resolution%>
			<%
		}
		rs.close();


		
	}
	finally
	{
		if ( stmt != null ) try { stmt.close(); } catch (Exception e) {}
		if ( conn != null ) try { conn.close(); } catch (Exception e) {}
    }
%>
