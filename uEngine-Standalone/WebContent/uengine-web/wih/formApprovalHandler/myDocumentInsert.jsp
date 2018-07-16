<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="java.sql.*,
				javax.sql.*,
				javax.naming.*,
				org.uengine.util.dao.DefaultConnectionFactory" %>
<%@include file="../../../common/header.jsp"%>
<%@include file="../../../common/getLoggedUser.jsp"%>

<%
    response.setHeader("Cache-Control", "no-cache");

	String DEFID = request.getParameter("DEFID");
	String EMPNO = loggedUserId;
	
	Connection 	    	conn	= null;
	PreparedStatement  	ps 		= null;
	ResultSet 			rs 		= null;
	String 				sql 	= "";
	int 				rows 	= 0;
	
	//해당인스턴스 ID에 커멘트 입력하기 
	try
	{
		conn = DefaultConnectionFactory.create().getConnection();
		conn.setAutoCommit(false);

		sql = "INSERT INTO doc_mydocument " +
			  "(empno, defid, created_date, created_by, updated_date, updated_by) " +
			  "VALUES (?, ?, SYSDATE, ?, SYSDATE, ?)";
			  
		ps = conn.prepareStatement(sql);
		
		ps.setString(1, EMPNO);
		ps.setString(2, DEFID);
		ps.setString(3, EMPNO);
		ps.setString(4, EMPNO);
		
		ps.executeUpdate();

		ps.close();
		conn.commit(); 
		conn.setAutoCommit(true);
		conn.close();
	
	}catch (Exception e){
		if ( ps != null ) 	try { ps.close();    } 				catch(Exception e1) {}
		if ( conn != null ) try { conn.rollback(); } 			catch(Exception e2) {} 
		if ( conn != null ) try { conn.setAutoCommit(true); } 	catch(Exception e3) {}
		if ( conn != null ) try { conn.close(); } 				catch(Exception e4) {}
	}finally{
		if ( conn != null ) try { conn.close(); } 				catch(Exception e5) {}
	}
	out.println("내 양식함 저장중 .......");
%>
<script>
//	alert("저장이 완료되었습니다");
	window.close();
</script>