<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="org.uengine.persistence.dao.DAOFactory"%>
<%@page import="java.sql.*,
				javax.sql.*,
				javax.naming.*,
				org.uengine.util.dao.DefaultConnectionFactory" %>
<%@include file="../../../common/header.jsp"%>
<%@include file="../../../common/getLoggedUser.jsp"%>

<%
    response.setHeader("Cache-Control", "no-cache");

	String approvalType	= request.getParameter("approvalType");

	String INSTANCE_ID	= request.getParameter("instanceId");
	String CONTENTS		= decode(request.getParameter("comment"));
	String OPT_TYPE		= request.getParameter("approveType");
	String EMPNO		= loggedUserId;
	String EMPNAME		= loggedUserFullName;
	String EMPTITLE		= loggedUserJikName;
	String TRACINGTAG	= request.getParameter("tracingTag");
	
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

		sql = "INSERT INTO DOC_COMMENTS (ID,INSTANCE_ID,CONTENTS,OPT_TYPE,EMPNO,EMPNAME,EMPTITLE, ";
		sql += "TRACINGTAG,CREATED_DATE,CREATED_BY,UPDATED_DATE,UPDATED_BY) ";	
//		sql += "VALUES (SEQ_DOC_COMMENTS.NEXTVAL,?,?,?,?,?,?,?,SYSDATE,?,SYSDATE,?)";
		sql += "VALUES (";
		sql += DAOFactory.getInstance(null).getSequenceSql("DOC_COMMENTS");
		sql += ",?,?,?,?,?,?,?,SYSDATE,?,SYSDATE,?)";
		ps = conn.prepareStatement(sql);
		
		ps.setString(1, INSTANCE_ID);
		ps.setString(2, CONTENTS);
		ps.setString(3, OPT_TYPE);
		ps.setString(4, EMPNO);
		ps.setString(5, EMPNAME);
		ps.setString(6, EMPTITLE);
		ps.setString(7, TRACINGTAG);
		ps.setString(8, EMPNO);
		ps.setString(9, EMPNO);
		
		ps.executeUpdate();

		ps.close();
		conn.commit(); 
		conn.setAutoCommit(true);
		conn.close();
		
		System.out.println("Comment inserted");
%>
<script>
	alert("저장이 완료되었습니다.");
	parent.opener.actionWorkitem("<%=approvalType%>");
	parent.close();
</script>
<%
	}catch (Exception e){
		if ( ps != null ) 	try { ps.close();    } 				catch(Exception e1) {}
		if ( conn != null ) try { conn.rollback(); } 			catch(Exception e2) {} 
		if ( conn != null ) try { conn.setAutoCommit(true); } 	catch(Exception e3) {}
		if ( conn != null ) try { conn.close(); } 				catch(Exception e4) {}
		
		System.out.println("Comment not inserted");
%>
<script>
	alert("저장이 되지 않았습니다. 다시 시도해 주세요");
	parent.close();
</script>
<%
	}finally{
		if ( conn != null ) try { conn.close(); } 				catch(Exception e5) {}
	}
%>