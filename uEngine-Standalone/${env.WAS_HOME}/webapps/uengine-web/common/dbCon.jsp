<%@ page language="java" import="java.sql.*,javax.sql.*,javax.naming.*" contentType="text/html;charset=utf-8" %>

<%
Connection conn;
//Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");

InitialContext context = new InitialContext();
DataSource okerpDS = (DataSource)context.lookup("java:/okerpDS");
conn = okerpDS.getConnection();
Statement stmt = conn.createStatement();

ResultSet rs = stmt.executeQuery("SELECT empl_no, empl_name, empl_level FROM erp_emp");
%>
MS SQLSERVER2000 JDBC Connection Test
<%

if(conn != null) out.println("Connection Ok");
else out.println("Connection Fail");


stmt.close();
conn.close();
%>
