<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,javax.sql.*,javax.naming.*"  %>
<%@ page import="org.uengine.util.dao.DefaultConnectionFactory"%>
<%
session.setAttribute("loggedUserId", "");
session.setAttribute("loggedUserFullName", "");
session.setAttribute("loggedUserIsAdmin",  "");
session.setAttribute("loggedUserJikName",  "");
session.setAttribute("loggedUserEmail",    "");
session.setAttribute("loggedUserPartCode", "");
%>
<html>
<head>
    <title>Login Form</title>
    <style type="text/css">
    p { font-family: georgia, sans-serif; font-size: 11px; }
    </style>

	<script type="text/javascript">
	function formValidate(){
		return true;
	}
	</script>
</head>

<body background="images/background.jpg">

<table height="80%">
<td width="200">&nbsp;</td>
<td>
<img src="images/logo.gif"><br>

<form action="login.jsp" method="post">
<input type="hidden" name="return_to" value="" />

<!-- 사용자 ID:<input type="hidden" name="userId" value="" /-->
사용자 ID: <select name="userId">
<%
Connection conn = DefaultConnectionFactory.create().getConnection();
Statement stmt = conn.createStatement();
try
{	
	StringBuffer sql = new StringBuffer();
	sql.append(" select EMPNAME, EMPCODE  ");
	sql.append(" from   EMPTABLE ");
	sql.append(" group by EMPNAME,EMPCODE ");

	ResultSet rs = stmt.executeQuery(sql.toString());
	
	while (rs.next())
	{
		out.println("	<option value='"+rs.getString("EMPCODE")+"'>"+rs.getString("EMPNAME"));
	}
}
finally
{
	if ( stmt != null ) try { stmt.close(); } catch (Exception e) {}
	if ( conn != null ) try { conn.close(); } catch (Exception e) {}
}
%>
</select>

비밀번호:<input type="password" name="passWd" />
<br>
<input type="submit" name="login" value="로그인" onClick="return formValidate();" />
</p>

</td></table>

</form>
</html>