<%
	if(!initiate){
		String status = pm.getActivityStatus(instanceId, tracingTag);
		if(status!=null && !status.equals("Running") && !status.equals("Timeout")){
			isViewMode=true;
%>

<table width="100%" border="0" cellspacing="0" cellpadding="4">
	<tr height="1">
		<td align="center" height="1" class="bgcolor_head_underline"></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center">
			The work item has been closed (<b><%=status%></b>)
		</td>
	</tr>
</table>

<%
		}
	}
%>
