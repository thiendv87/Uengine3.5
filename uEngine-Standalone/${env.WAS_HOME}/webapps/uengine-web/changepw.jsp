<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,javax.sql.*,javax.naming.*"  %>
<%@include file="common/header.jsp"%>
<%@include file="common/getLoggedUser.jsp"%>
<%
	
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
	
	StringBuffer buf = new StringBuffer();
	String errMsg = "";

	String ACT = request.getParameter("ACT")==null?"":request.getParameter("ACT");
	
	if (ACT.equals("ChangePassWord")){
		String currentPassWd = decode(request.getParameter("currentPassWd")==null?"":request.getParameter("currentPassWd"));
		String newPassWd     = decode(request.getParameter("newPassWd")==null?"":request.getParameter("newPassWd"));
		
		Connection 	    conn	= null;
		Statement 		stmt 	= null;
		ResultSet 		rs 		= null;
		StringBuffer 	sql 	= new StringBuffer();
		int				rows 	= 0;
	
		try
		{
	        InitialContext context = new InitialContext();
	        DataSource okerpDS = (DataSource)context.lookup("java:/okerpDS");
	        conn = okerpDS.getConnection();
	        stmt = conn.createStatement();
	
			sql.setLength(0);
			sql.append(" SELECT count(*) ");
			sql.append(" FROM   EMPLOGIN  ");
			sql.append(" WHERE  EMPCODE = '").append(loggedUserId).append("'");
			sql.append(" AND    PASSWORD= '").append(currentPassWd).append("'");
			
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
				sql.append(" UPDATE EMPLOGIN ");
				sql.append(" SET    PASSWORD= '").append(newPassWd).append("'");
				sql.append(" WHERE  EMPCODE = '").append(loggedUserId).append("'");
				rows = stmt.executeUpdate(sql.toString());
				errMsg = "새로운 비밀번호가 성공적으로 저장되었습니다.";
			}else{
				errMsg = "현재 비밀번호와 다릅니다.";
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
		if('<%=ACT%>'=='ChangePassWord'){
			alert('<%=errMsg%>');
			history.go(-2);
		}
	}
	function formValidate(){
		if(form1.newPassWd1.value == form1.newPassWd2.value){
			form1.newPassWd.value = form1.newPassWd1.value;
			form1.ACT.value = "ChangePassWord";
			return true;
		}else{
			alert("The re-enterred password is not correct.");
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

<form NAME=form1 METHOD=post action="changepw.jsp">
<input type="hidden" name="return_to" value="" />

Current login: <b></b><p>

<!-- 사용자 ID:<input type="hidden" name="userId" value="" /-->
Current Password:<input type="password" name="currentPassWd" />
<br>
New Password:<input type="password" name="newPassWd1" /> Re-enter :<input type="password" name="newPassWd2" />

<br>
<input type="submit" name="login" value="Confirm" onClick="return formValidate();" />
<INPUT NAME="cmdDele" TYPE=button VALUE="Cancel" onClick="javascript:history.go(-1);">
</p>

</td></table>
<INPUT TYPE=hidden NAME=ACT>
<INPUT TYPE=hidden NAME=newPassWd>
</form>
<script type="text/javascript">

</script>


</html>