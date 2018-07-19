
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<%@ page import="org.uengine.util.dao.*,java.sql.*,javax.sql.*,javax.naming.*"%>
<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>
<%
	String groupCode = reqMap.getString("groupCode", "");
	String groupName = reqMap.getString("groupName", "");
	String desc = reqMap.getString("description", "");
	
	String type = reqMap.getString("type", "");
	String parent = reqMap.getString("parent", "");
	String comcode = reqMap.getString("comCode", "");
%>
<br />groupCode : <%=groupCode%>
<br />groupName : <%=groupName%>
<br />type : <%=type%>
<br />desc : <%=desc%>
<br />parent : <%=parent%>
<br />globalCom : <%=comcode%>
<br />
<%

	Connection conn = null;
	PreparedStatement stmt = null;
	String sql = null;
	
	if (UEngineUtil.isNotEmpty(groupCode))
	{
		try
		{
			if ("company".equals(type))
			{
				sql = "insert into parttable(partname, partcode, globalcom, description) values(?, ?, ?, ?)";
				conn = DefaultConnectionFactory.create().getConnection();
				stmt = conn.prepareStatement(sql);
				
				stmt.setString(1, groupName);
				stmt.setString(2, groupCode);
				stmt.setString(3, parent);
				stmt.setString(4, desc);
			}
			else if ("department".equals(type))
			{
				sql = "insert into parttable(partname, partcode, globalcom, parent_partcode, description) values(?, ?, ?, ?, ?)";
				conn = DefaultConnectionFactory.create().getConnection();
				stmt = conn.prepareStatement(sql);
				
				stmt.setString(1, groupName);
				stmt.setString(2, groupCode);
				stmt.setString(3, comcode);
				stmt.setString(4, parent);
				stmt.setString(5, desc);
			}
			else
			{
				sql = "insert into comtable(comname, comcode, description) values(?, ?, ?)";
				conn = DefaultConnectionFactory.create().getConnection();
				
				stmt = conn.prepareStatement(sql);
				
				stmt.setString(1, groupName);
				stmt.setString(2, groupCode);
				stmt.setString(3, desc);
			}
			
			stmt.execute();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (stmt != null) try { stmt.close(); } catch (Exception e2) {}
			if (conn != null) try { conn.close(); } catch (Exception e2) {}
		}
%>
		Group information has been successfully registered.
		<script>
			window.top.location.href="index.jsp?listtype=" + window.parent.listtype;
		</script>
<%
	} else {
%>
		You must fill out the group name and the group code.
<%
	}
%>