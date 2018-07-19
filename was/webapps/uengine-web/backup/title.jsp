<%@include file="common/header.jsp"%>
<%@include file="common/getLoggedUser.jsp"%>

<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<LINK href="style/uengine.css" type=text/css rel=stylesheet>

<script>
var loggedUserId = '<%=loggedUserId%>';
if(loggedUserId==""){
	parent.location = "loginForm.jsp";
}
</script>

<body link=#5291ED alink=#5291ED vlink=#5291ED  leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">


<form name="titleform" action="loginForm.jsp" target="_top" method="post"> 
<center>
<table cellspacing="0" cellpadding="0">
<td width=200><center>
<img src=images/logo.gif>
</td>
<td>


<table border=0 cellpadding=0 cellspacing=0 bgcolor=white><tr><td rowspan=2 width=10 height=10 style='background-IMAGE: url(images/card_tl.gif); background-repeat: no-repeat;'><img src=processmanager/images/empty.gif width=10 height=10></td><td height=1 style='background-IMAGE: url(images/card_top.gif); background-repeat: repeat-x; background-position: top left;'></td><td rowspan=2 width=8 height=10 style='background-IMAGE: url(images/card_tr.gif); background-repeat: no-repeat; background-position: top right;'><img src=processmanager/images/empty.gif width=10 height=10></div></td></tr><tr><td bgcolor=white></td></tr><tr height=*><td height=100% style='background-IMAGE: url(images/card_left.gif); background-repeat: repeat-y; background-position: top left'></td><td>

<table  border=0 cellpadding=0 cellspacing=0 bgcolor=white>

<td width=30></td>
<td>

<a href="processparticipant/worklist/wl2_workList.jsp" target=workarea><%=GlobalContext.getLocalizedMessageForWeb("work_list", loggedUserLocale, "Work List") %></a> 
 <image src=images/title_separator.gif align=absmiddle> <a href="processparticipant" target=workarea><%=GlobalContext.getLocalizedMessageForWeb("workspace", loggedUserLocale, "Workspace") %></a> 

<% if(loggedUserIsAdmin){ %>

 <image src=images/title_separator.gif align=absmiddle> <a href="processmanager" target=workarea><%=GlobalContext.getLocalizedMessageForWeb("manager", loggedUserLocale, "Manager") %></a> 

 <image src=images/title_separator.gif align=absmiddle> <a href="../mondrian/testpage.jsp?query=uengine" target=workarea><%=GlobalContext.getLocalizedMessageForWeb("analyzer", loggedUserLocale, "Analyzer") %></a>
 
<image src=images/title_separator.gif align=absmiddle> <a href="organizationmanager" target=workarea><%=GlobalContext.getLocalizedMessageForWeb("organization", loggedUserLocale, "Organization") %></a> 

<% } %>

</td>
<td width=100></td>
<td>

<font color=darkgray>

<%=GlobalContext.getLocalizedMessageForWeb("current_login", loggedUserLocale, "Current login") %>: <b><%=loggedUserFullName%></b><br>

[<a href="javascript:titleform.submit();" ><%=GlobalContext.getLocalizedMessageForWeb("sign_out", loggedUserLocale, "Sign-out") %></a>]
[<a href="changepw.jsp" target=workarea ><%=GlobalContext.getLocalizedMessageForWeb("change_password", loggedUserLocale, "Change Password") %></a>]


</td>
<td width=30></td>
</table>

</td><td height=100% style='background-IMAGE: url(images/card_right.gif); background-repeat: repeat-y; background-position: top right'></td></tr><tr> <td rowspan=2 width=5 height=8 style='background-IMAGE: url(images/card_bl.gif); background-position: bottom left'></td><td height=4 style='background-IMAGE: url(images/card_bot.gif); background-repeat: repeat-x; background-position: bottom left' height=4></td><td rowspan=2 width=5 height=8 style='background-IMAGE: url(images/card_br.gif); background-position: bottom right'></td></tr></table>



</td>
<td width=100></td>

</table>
<form>