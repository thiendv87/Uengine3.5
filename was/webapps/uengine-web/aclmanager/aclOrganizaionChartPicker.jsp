<LINK href="../style/uengine.css" type=text/css rel=stylesheet>
<LINK rel="stylesheet" href="../style/portlet.css" type="text/css"/>	
<LINK rel="stylesheet" href="../style/portal.css" type="text/css"/>	
<LINK rel="stylesheet" href="../style/groupware.css" type="text/css"/>

<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>
<%
	String type= request.getParameter("type");
%>
<html>
<head><title> Select <%=type%></title></head>
<body <body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" leftmargin="5" topmargin="0" marginwidth="0" marginheight="0">
<table border="0" cellpadding="0" cellspacing="0" width="100%" xmlns>
<tr>
<td height="28" valign="bottom">
<img src="../images/icon_root.gif" align="middle" width="10" height="11" border="0"> 
 <b> Select <%=type%> </b>
</td>
</tr>
<tr>
<td height="1" class="path_underline"></td>
</tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr height="1">
<td align="center" height="1" class="bgcolor_head_upperline"></td>
</tr>
<tr height="5">
<td align="center" height="5" class="bgcolor_head"></td>
</tr>
<tr height="1">
<td align="center" height="1" class="bgcolor_head_underline"></td>
</tr>
</table>
<%
	if("User".equals(type)){
%><%@include file="userChart.jsp"%><%
	}else if("Group".equals(type)){
%><%@include file="groupChart.jsp"%><%
	}else if("Role".equals(type)){
%><%@include file="roleChart.jsp"%><%
	}
%>

<table width="100%" border="0" cellspacing="0" cellpadding="4">
	<tr>
		<td bgcolor=yellow height=20>
		choice one : <b>Organization Chart</b> or <b>Direct endpoint</b>
		</td>
	</tr>
<tr height="1">
<td align="center" height="1" class="bgcolor_head_upperline"></td>
</tr>
<tr height="5">
<td align="center" height="5" class="bgcolor_head"></td>
</tr>
<tr height="1">
<td align="center" height="1" class="bgcolor_head_underline"></td>
</tr>
</table>


<table border=0 width="100%">
	<tr>
		<td align="right">
			<form>
				<input type=button value="    Ok    " onclick="onOk(selectedOrganizationList, inputName);window.close()">
				<input type=button value="Cancel" onclick="window.close();">
			</form>
		</td>
	</tr>
</table>
</body>
</html>