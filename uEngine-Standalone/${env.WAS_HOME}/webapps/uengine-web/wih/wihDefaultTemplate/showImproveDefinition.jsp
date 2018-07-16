<%@include file="header.jsp"%>
<%@include file="definition.jsp"%>
<%
	try{ 
%>

<%@include file="initialize.jsp"%>
<%@include file="findBackableActivities.jsp"%>


<%@page import="org.uengine.security.util.DefaultAclUtil"%><style TYPE="TEXT/CSS">
	body {
		background:url(../../processmanager/images/empty.gif) #ffffff; 
		padding:15px;
	}
</style>

<body>

<div style="font-weight:bold; margin-bottom:15px;">
 <span class="sectiontitle"><%=GlobalContext.getLocalizedMessageForWeb("improve_rule", loggedUserLocale, "Your changes would not be reflected until the administrator approve them(setting production).") %></span>
</div>
<table border=0  width=100% style="border:solid 5px #e7e7e7; padding:10px;">
	<tr>
		<td>
			<fieldset class="block-labels">
				<legend><%=GlobalContext.getLocalizedMessageForWeb("processdefinition", loggedUserLocale, "Process Definition") %></legend>
					<table border=0 CELLPADDING==5 CELLSPACING=5 >
						<tr>
							<td  align="center">
								<!-- a href='/html/uengine-web/processparticipant/initiateForm.jsp?alias=proc_process_improve&improve_process_defverid=<%=pdr.getId() %>'-->
								<a href='../../processmanager/ProcessDesigner.jnlp?defVerId=<%=pdr.getId()%>'>
									<img src="../../processmanager/images/processReadyToBeEdited.gif" width="100"><br>
									<%=pdr.getName().getText(loggedUserLocale)%>
								</a>
							</td>
							<td align="center">
							&nbsp;&nbsp;&nbsp;
							</td>
						</tr>
					</table>
			</fieldset>
		</td>
	</tr>
</table>
<br>
<table border=0  width=100% style="border:solid 5px #e7e7e7; padding:10px;">
	<tr><td>
	
<%
	Vector formVariable = new Vector();
	if (pdr == null && UEngineUtil.isNotEmpty(processDefinition))
		pdr = pm.getProcessDefinitionRemote(processDefinition);
		
	ProcessVariable[] pvdrs = (pdr!=null ? pdr.getProcessVariableDescriptors() : null);
	if (pvdrs != null) {
		for(int i=0; i<pvdrs.length; i++) {
			ProcessVariable pvd = pvdrs[i];
			Serializable data = piRemote.get("", pvd.getName());
			if(data instanceof Calendar && data !=null)
				data = ((Calendar)data).getTime();
			if(data instanceof HtmlFormContext)
				formVariable.add(data);					
			if(data == null) data = ".";
		}
	}

	AclManager acl = AclManager.getInstance();
	HashMap permission = acl.getPermission(Integer.parseInt(pdr.getBelongingDefinitionId()), loggedUserId);
	if (	formVariable.size() > 0 && (permission.containsKey(AclManager.PERMISSION_EDIT))) {
%>
	</td></tr>
	<tr>
		<td>
			<fieldset class="block-labels">
				<legend><%=GlobalContext.getLocalizedMessageForWeb("formdefinition", loggedUserLocale, "Form Definition") %></legend>
				<table border="0" cellpadding="5" cellspacing="5">
					<tr>
<%
		for (int i=0 ; i < formVariable.size(); i++) {
			HtmlFormContext htmlFormContext = (HtmlFormContext) formVariable.get(i);
			ProcessDefinitionRemote processDefinitionRemote = pm.getProcessDefinitionRemote(htmlFormContext.getFormDefId().split("@")[1]);
			String formName = processDefinitionRemote.getName().getText(loggedUserLocale);
%>
						<td align="center">
							<a href="javascript:viewFormDefinition('<%=processDefinitionRemote.getBelongingDefinitionId()%>')">
							<img src="../../processmanager/images/formReadyToBeEdited.gif" width="100"><br>
							<%=formName%>
							</a>
						</td>
						<td  align="center">
							&nbsp;&nbsp;&nbsp;	
						</td>
<%
		}
%>
					</tr>
				</table>
			</fieldset>
		</td>
	</tr>
<%
	}
%>
	
</table>

<Script>
	function viewFormDefinition(formDefinitionId){

		if( formDefinitionId != "" ){
			window.open('../../processmanager/viewFormDefinition.jsp?objectDefinitionId=' + formDefinitionId,'viewFormDefinition','width=1000,height=700,scrollbars=yes,resizable=yes');
		}
	}
</script>

<%@include file="passValues.jsp"%>
</form>
</body>
<%
	}finally{
		try{pm.cancelChanges();}catch(Exception ex){}
		try{pm.remove();}catch(Exception ex){}
	}
%>

