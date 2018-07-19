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

<%if(isRacing){	%>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
	<tr height="1">
		<td align="center" bgcolor=yellow><b><%=GlobalContext.getLocalizedMessageForWeb("accept_desc", loggedUserLocale, "You need to accept this workitem since users are racing to handle this workitem.") %></b></td>
	</tr>
</table>
		
<%}%>


<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr height="20" >
		<td width="120" align=left bgcolor="f4f4f4">
			&nbsp;<div nowrap><b><%=GlobalContext.getLocalizedMessageForWeb("to_do", loggedUserLocale, "To-Do") %>:</b> </div>
		</td>
		<td width="10"></td>
		<td width="*" align=left valign=center>
			<a href="../../processmanager/JCalc.jnlp?openSpot=executeOfficeInstance&documentDefVerId=<%=currProductionOfficeDocDefId%>&instanceId=<%=instanceId%>&tracingTag=<%=tracingTag%>&processDefId=<%=initiationProcessDefinition%>&userId=<%=loggedUserId%>">
			<img src="../../processmanager/images/openJCalc.gif" align=absmiddle>
			</a><%=GlobalContext.getLocalizedMessageForWeb("working_with_web_office", loggedUserLocale, "Working with web office") %>
		</td>		
	</tr>
	
	<tr height="1">
		<td align="center" colspan="3" height="1" class="bgcolor_head_underline"></td>
	</tr>
	<tr height="1">
		<td align="center" colspan="3" height="1" class="bgcolor_head_underline"></td>
	</tr>
</table>
