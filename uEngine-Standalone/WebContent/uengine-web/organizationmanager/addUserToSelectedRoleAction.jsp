<%//@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="org.uengine.util.dao.*, java.sql.*,javax.sql.*,javax.naming.*" %>
<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>

<%
	String selectedUser = decode(request.getParameter("selectedUsers"));
	String roleCode = decode(request.getParameter("roleCode"));
	
	String selectedUserId[] = selectedUser.split(",");
		
	Connection conn	= null;
	PreparedStatement pstmt = null;
	String sql = "insert into roleusertable(rolecode, empcode) values(?, ?)";
	
	try
	{
		conn = DefaultConnectionFactory.create().getConnection();
		pstmt = conn.prepareStatement(sql);
		
		for(int i = 0 ; i < selectedUserId.length; i++){
//			System.out.println(
//					"\n =========================================="
//					+ "\n roleCode : " + roleCode
//					+ "\n empCode : " + selectedUserId[i]
//					+ "\n =========================================="
//			);
			
			pstmt.setString(1, roleCode);
			pstmt.setString(2, selectedUserId[i].trim());
			
			pstmt.execute();
		}
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	finally
	{
		if (pstmt != null) try { pstmt.close(); } catch(Exception e) {}
		if (conn != null) try { conn.close(); } catch(Exception e) {}
	}
	
	
%>
Selected users[<%=selectedUserId.length %>] has been successfully registered in <%=roleCode %>.
