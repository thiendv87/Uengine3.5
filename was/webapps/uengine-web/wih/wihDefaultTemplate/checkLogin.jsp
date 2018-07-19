<%
if(!isAllowAnonymous){
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr height="1">
		<td align="center" bgcolor=yellow><b><%=GlobalContext.getLocalizedMessageForWeb("login_desc", loggedUserLocale, "You need to login for progressing toward this step.") %></b></td>
	</tr>
</table>
<%}
%>