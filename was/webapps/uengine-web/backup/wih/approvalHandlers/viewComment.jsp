<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.uengine.processmanager.*"%>
<%@ page import="org.uengine.kernel.*"%>
<%@ page import="java.sql.*"%>

<%
	String instanceId = request.getParameter("instanceId");
	String tracingTag = request.getParameter("tracingTag");
%>

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%
	ProcessManagerRemote pm =null;
	ProcessInstance pi = null;
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String 			INSTANCE_ID	= "";
    String 			TRACINGTAG	= "";
    String 			CONTENTS	= "";
    String 			CREATED_BY	= "";
 	try{
 		pm = processManagerFactory.getProcessManager();
 		pi = pm.getProcessInstance(instanceId);
 		conn = pi.getProcessTransactionContext().getConnection();
 		stmt = conn.createStatement();
 		StringBuilder sql = new StringBuilder();
 		
 		sql.append(" SELECT instance_id, tracingtag, CONTENTS, CREATED_BY");
        sql.append(" FROM doc_comments");
        sql.append(" WHERE instance_id = '" + instanceId + "'");
        sql.append(" and tracingTag = '" + tracingTag +  "'");
        
        rs = stmt.executeQuery(sql.toString());
        
        if (rs.next()){
            INSTANCE_ID = rs.getString(1);
            TRACINGTAG 	= rs.getString(2);
            CONTENTS 	= rs.getString(3);
            CREATED_BY 	= rs.getString(4);
            
            CONTENTS = CONTENTS.replaceAll("\n","<br>");
            CONTENTS = CONTENTS.replaceAll("<p>","");
            CONTENTS = CONTENTS.replaceAll("</p>","");
            System.out.println("============================");
            System.out.println(CONTENTS);
            System.out.println("============================");
        } else {
            CONTENTS = "없음.";
        }
        rs.close();
 	} catch (SQLException e) {
 		e.printStackTrace();
 	} finally {
 		if ( rs != null ) try { rs.close(); } catch (SQLException e) {}
 		if ( stmt != null ) try { stmt.close(); } catch (SQLException e) {}
 		if ( conn != null ) try { conn.close(); } catch (SQLException e) {}
 		if ( pm != null) try { pm.remove(); } catch(Exception e){}
 	}
%><%=CONTENTS %>
