<%@page pageEncoding="KSC5601"%>

<%
	if(initiate){
		ObjectType.addInputterPackage("org.uengine.processdesigner.inputters");

		if(pdr==null)
			pdr = pm.getProcessDefinitionRemote(processDefinition);

		org.uengine.kernel.Role[] roles = pdr.getRoles();
		
		boolean roleMappingFormNeeded = false;
		for(int i=0; i < roles.length; i++){
			if(roles[i].isAskWhenInit()){
				roleMappingFormNeeded = true;
			}
		}
		
		if(roleMappingFormNeeded){

			Properties defaultEndpoints = new Properties();
			defaultEndpoints.setProperty("messengerServer", "http://localhost:8082/axis/services/MSNMessengerService");
			defaultEndpoints.setProperty("mailServer", "http://localhost:8082/axis/services/EMailServer");
			defaultEndpoints.setProperty("Worklist_Service", "http://localhost:8082/axis/services/WorklistServer");
	%>



<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr height="1">
		<td align="center" colspan="3" height="1" class="bgcolor_head_underline"></td>
	</tr>			

		

	<tr height="30" >
		<td width="120" align=left bgcolor="f4f4f4">
			&nbsp;<b>Role Binding</b>
		</td>
		<td width="10" align=left>
		<td width="*" align=left>
		<table>
			     	
<%

	for(int i=0; i < roles.length; i++){
		if(!roles[i].isAskWhenInit()) continue;
		String roleName = roles[i].getName().replace(' ', '_');		
		String dispRoleName = roles[i].getDisplayName().getText();		
		String defaultEndpoint = roles[i].getDefaultEndpoint();
		String defaultUserName = "";

		if(defaultEndpoint!=null && defaultEndpoint.toLowerCase().equals("${initiator}")){
			defaultEndpoint = loggedUserId;
			defaultUserName = loggedUserFullName;
		}
		
		WebInputter inputterForRoleMapping = (WebInputter)ObjectType.getDefaultInputter(RoleMapping.class); 
		FieldDescriptor fd = new FieldDescriptor(roleName, roleName);
		RoleMapping oldValue = RoleMapping.create();
		oldValue.setEndpoint(defaultEndpoint);
		oldValue.setResourceName(defaultUserName);
		
		inputterForRoleMapping.addScriptTo(scriptSet, "rolemappings", fd, oldValue, null);
	%>
		<tr><td><%=dispRoleName%></td><td>
		<%=inputterForRoleMapping.getInputterHTML("rolemappings", fd, oldValue, null) %>
		</td></tr>
<% 		
	}
%>
		</table> 

		<%=WebUtil.createScriptBodyFromScriptSet(scriptSet) %>
		<%scriptSet.clear(); %>

		</td>
	</tr>
	<tr height="1">
		<td align="center" colspan="3" height="1" class="bgcolor_head_underline"></td>
	</tr>
</table>



<%
	}
}
%>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr height="1">
		<td align="center" height="1" class="bgcolor_head_underline"></td>
	</tr>
</table>