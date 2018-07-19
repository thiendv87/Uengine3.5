<%@page import="org.uengine.util.UEngineUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%><%@ 
	page import=
	"
	java.sql.Connection,
	java.sql.ResultSet,
	java.sql.PreparedStatement,
	org.uengine.util.dao.DefaultConnectionFactory
	" 
%><%
	String  loggedUserId       		= (String) session.getAttribute("loggedUserId");
	
	StringBuilder sql = new StringBuilder();
		sql.append(" SELECT ");
		sql.append(" 	INSTLIST.INSTID, ");
		sql.append(" 	WORKLIST.TASKID, ");
		sql.append(" 	WORKLIST.TRCTAG, ");
		sql.append(" 	INSTLIST.NAME, ");
		sql.append(" 	WORKLIST.TITLE "); 
		sql.append(" FROM BPM_WORKLIST WORKLIST LEFT JOIN BPM_PROCINST INSTLIST ON WORKLIST.INSTID = INSTLIST.INSTID ");
		sql.append(" 	, (SELECT MAX(TASKID) ID FROM BPM_WORKLIST WORKLIST WHERE ENDPOINT = ? AND STATUS = ? ) MAXTASK ");
		sql.append(" WHERE ");
		sql.append(" 	INSTLIST.ISDELETED = 0 ");
		sql.append(" 	AND ");
		sql.append(" 	WORKLIST.TASKID = MAXTASK.ID ");
		sql.append(" ORDER BY TASKID DESC ");

		/*******************************
		SELECT WORKLIST.TITLE, WORKLIST.TASKID, WORKLIST.TRCTAG, INSTLIST.NAME, INSTLIST.INSTID
			FROM BPM_WORKLIST WORKLIST LEFT JOIN BPM_PROCINST INSTLIST ON WORKLIST.INSTID = INSTLIST.INSTID AND INSTLIST.ISDELETED = 0
			, (SELECT MAX(TASKID) ID FROM BPM_WORKLIST WORKLIST WHERE ENDPOINT = 'KBS' AND STATUS = 'NEW') MAXTASK
		WHERE 
			WORKLIST.TASKID=MAXTASK.ID
		ORDER BY TASKID DESC
		********************************/
	StringBuilder json = new StringBuilder();
		
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try{
		conn = DefaultConnectionFactory.create().getConnection();
		
		pstmt = conn.prepareStatement(sql.toString());
		pstmt.setString(1,loggedUserId);
		pstmt.setString(2,"NEW");
				
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			json.append("{'RESULT':'TRUE'");
			json.append(",'INSTID':'").append(rs.getString("INSTID")).append("'");
			json.append(",'TASKID':'").append(rs.getString("TASKID")).append("'");
			json.append(",'TRCTAG':'").append(rs.getString("TRCTAG")).append("'");
			json.append(",'NAME':'").append(rs.getString("NAME")).append("'");
			json.append(",'TITLE':'").append(rs.getString("TITLE")).append("'");
			json.append("}");
		}else{
			json.append("{'RESULT':'FALSE'}");
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(rs!=null){
			try{rs.close();}catch(Exception e){}
		}
		if(pstmt!=null)
		{
			try{pstmt.close();}catch(Exception e){}
		}
		if(conn!=null)
		{
			try{conn.close();}catch(Exception e){}	
		}
	}
%><%=json%>