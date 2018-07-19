<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,javax.sql.*,javax.naming.*"  %>
<%@ page import="org.uengine.util.dao.DefaultConnectionFactory"%>
<%@include file="common/header.jsp"%>
<%@include file="common/getLoggedUser.jsp"%>
<%
	
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
	
	StringBuffer buf = new StringBuffer();
	String errMsg    = new String("");
	String isSuccess = new String("false");

	String ACT = request.getParameter("ACT")==null?"":request.getParameter("ACT");
	
	if (ACT.equals("InputPassWord")){
		String newPassWd     = decode(request.getParameter("newPassWd")==null?"":request.getParameter("newPassWd"));
		
		Connection 	    conn	= null;
		Statement 		stmt 	= null;
		ResultSet 		rs 		= null;
		StringBuffer 	sql 	= new StringBuffer();
		int				rows 	= 0;
		
		try
		{
			conn = DefaultConnectionFactory.create().getConnection();
			stmt = conn.createStatement();
	
			sql.setLength(0);
			sql.append(" SELECT count(*) ");
			sql.append(" FROM   EMPTABLE  ");
			sql.append(" WHERE  EMPCODE = '").append(loggedUserId).append("'");
			
			rs = stmt.executeQuery(sql.toString());
			rows = 0;
			while (rs.next())
			{
				rows = rs.getInt(1);
			}
			rs.close();
			if (rows == 1)
			{
				sql.setLength(0);
				sql.append(" UPDATE EMPTABLE ");
				sql.append(" SET PASSWORD ='").append(newPassWd).append("'");
				sql.append(" WHERE EMPCODE  ='").append(loggedUserId).append("'");
				rows = stmt.executeUpdate(sql.toString());
				errMsg = "Password has been sucessfully changed.";
				isSuccess = "true";
			}else{
				errMsg = "Can't change the password.";
			}
			
		}
		finally
		{
			if ( stmt != null ) try { stmt.close(); } catch (Exception e) {}
			if ( conn != null ) try { conn.close(); } catch (Exception e) {}
	    }
	}
%>

<html>
<head>
    <title>Change Password</title>
    <style type="text/css">
    p { font-family: georgia, sans-serif; font-size: 11px; }
    </style>

	<script type="text/javascript">
	function init(){
		if('<%=ACT%>'=='InputPassWord'){
			alert('<%=errMsg%>');
			if('<%=isSuccess%>'=='true') this.location = "index.jsp";
		}
	}
	function formValidate(){
		if(form1.newPassWd1.value == form1.newPassWd2.value){
			form1.newPassWd.value = form1.newPassWd1.value;
			form1.ACT.value = "InputPassWord";
			return true;
		}else{
			alert("Please check the new password.");
			return false;
		}
	}
	</script>
</head>

<body onLoad="init();" >

<table height=80%>
<td width=200>&nbsp;</td>
<td>
<img src=images/logo.gif><br>

<form NAME=form1 METHOD=post action="inputpw.jsp">
<input type="hidden" name="return_to" value="" />

<br>
New Password:<input type="password" name="newPassWd1" /> 재입력 :<input type="password" name="newPassWd2" />

<br>
<input type="submit" name="login" value="확인" onClick="return formValidate();" />
<INPUT NAME="cmdDele" TYPE=button VALUE="취소" onClick="javascript:history.go(-1);">
</p>

</td></table>
<INPUT TYPE=hidden NAME=ACT>
<INPUT TYPE=hidden NAME=newPassWd>
</form>
<script type="text/javascript">

</script>


</html>