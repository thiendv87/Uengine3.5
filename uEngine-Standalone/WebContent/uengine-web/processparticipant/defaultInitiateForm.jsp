<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>
<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" /><%

	ProcessManagerRemote pm = processManagerFactory.getProcessManager();

	
	InitialContext context = new InitialContext();
	
	String processDefinition = decode(request.getParameter("processDefinition"));
	ProcessDefinitionRemote pd = pm.getProcessDefinitionRemote(processDefinition);
	
	if(pd.isInitiateByFirstWorkitem()){
		String initiatorHumanActivityTracingTag = pd.getInitiatorHumanActivityTracingTag();
		String tool = (String)pm.getActivityProperty(processDefinition, initiatorHumanActivityTracingTag, "tool");
		String url = "../wih/" + tool + "/index.jsp";
		
		
		Map parameterMap = (Map)pm.getActivityProperty(processDefinition, initiatorHumanActivityTracingTag, "parameterMap");
%>
<LINK href="../style/uengine.css" type=text/css rel=stylesheet>

<body onload="document.forms[0].submit()">
<form action="<%=url%>" method="POST">	
	<input type=hidden value='<%=processDefinition%>' name=processDefinition>
	<input type=hidden value='<%=initiatorHumanActivityTracingTag%>' name=tracingTag>
	<input type=hidden value='yes' name=initiate>
	<input type=hidden value='write' name=documentMode>
<%			
		for(Iterator iter = parameterMap.keySet().iterator(); iter.hasNext();) {
			String key = (String)iter.next();
			String value = ""+parameterMap.get(key);
			value=value.replace('\"','\'');
			
				%><input type=hidden name="<%=key%>" value="<%=value%>">
				<%
		}
%>	
	
</form>

<%
		return;
	}

	
	String defaultInstanceId = decode(request.getParameter("defaultInstanceId"));
	if(defaultInstanceId==null){		
		defaultInstanceId = UEngineUtil.createInstanceId(pd);
	}
%>



<script>
	insertingRole='';
 	function openMapper(role){
		window.open('urb','mapper','width=500,height=400,scrollbars=yes');
		insertingRole = role;
	}

	function setMapping(name, endpoint){
		eval('document.initiateform.' + insertingRole + '_name.value = name');
//		eval('document.initiateform.' + insertingRole + '_email.value = email');
		eval('document.initiateform.' + insertingRole + '_endpoint.value = endpoint');
	}
	
</script>

<% String pdname = decode(request.getParameter("processDefinition"));%>
			
<h1>New <%=pdname%></h1>

<br>


<form action='initiate.jsp' name=initiateform>
Please name this instance: 
<input size=90 name="instanceId" value="<%=defaultInstanceId%>"><br> *leave if you want to auto-generate<p>
Please fill out following role mappings:

<table>
<tr>
<td>


<table b order=1>
<tr><th bgcolor=#bbbbbb>Role</th><th bgcolor=#bbbbbb>name</th><th bgcolor=#bbbbbb>email or endpoint</th><td></td></tr>
			     	
<%
	Role[] roles = pd.getRoles();
	for(int i=0; i < roles.length; i++){
		if(!roles[i].isAskWhenInit()) continue;
		String roleName = roles[i].getName().replace(' ', '_');		
		String defaultEndpoint = roles[i].getDefaultEndpoint();
		String defaultUserName = "";

		if(defaultEndpoint!=null && defaultEndpoint.toLowerCase().equals("${initiator}")){
			defaultEndpoint = loggedUserId;
			defaultUserName = loggedUserFullName;
		}

		if(defaultEndpoint==null)
			defaultEndpoint = "";
		else
			defaultEndpoint = " value='" + defaultEndpoint + "'";

		if(defaultUserName==null)
			defaultUserName = "";
		else
			defaultUserName = " value='" + defaultUserName + "'";
		%>
		
        	<tr><td b gcolor=#bbbbbb> <b> <%=roles[i].getDisplayName()%> : </b></td>
        	<td> <input name='<%=roleName%>_name'<%=defaultUserName%> size=10> </td>
        	<td> <input name='<%=roleName%>_endpoint'<%=defaultEndpoint%> size=30> </td>
        	<td> <input value="<-" type=button onclick="document.initiateform.<%=roleName%>_endpoint.value=selectedOrganizationInfo.id;document.initiateform.<%=roleName%>_name.value=selectedOrganizationInfo.name">
        	<!--<input value="search" type=button onclick="openMapper('<%=roleName%>')">--> </td>
        	</tr>
<%	}%>
		        
</table> 


</td>
<td>

<%@include file="../common/organizationChart.jsp"%>

</td>
</tr>
</table>


<p>
Please fill out followings:


<table><tr><td bgcolor=black>
<table cellspacing=1>

<%
	ProcessVariable[] variables = pd.getProcessVariableDescriptors();
	for(int j=0; j<variables.length; j++){
	
		if(!variables[j].isAskWhenInit()) continue;
		
		ParameterContext parameterContext = new ParameterContext();
		parameterContext.setVariable(variables[j]);
		parameterContext.setArgument(variables[j].getDisplayName());

        %>	<tr><td bgcolor=#bbbbbb colspan=2><b> <%=parameterContext.getArgument().getText(loggedUserLocale)%> </b></td></tr><%
	
		Object existingValue = null;
		
		WebInputter defaultInputter = (WebInputter)parameterContext.getVariable().getInputter();
		if(defaultInputter==null){
			ObjectType outputClsTable = new ObjectType(parameterContext.getVariable().getType());
			FieldDescriptor[] arrayFieldDescriptors = outputClsTable.getFieldDescriptors();
				
			String[] columns = new String[arrayFieldDescriptors.length];	
			for(int i=0; i<arrayFieldDescriptors.length; i++){
				columns[i] = arrayFieldDescriptors[i].getName();
			}
			
			for(int i=0; i<columns.length; i++){
		    	FieldDescriptor fieldDescriptor = outputClsTable.getFieldDescriptor(columns[i]);
		        %>	<tr><td bgcolor=#eeeeee> <%=fieldDescriptor.getDisplayName()%> </td> <%
		    	
		    	WebInputter inputter = fieldDescriptor.getWebInputter();
		    	
		   		%>  <td bgcolor=white><%=inputter.getInputterHTML(parameterContext.getVariable().getName(), fieldDescriptor, existingValue, null)%></td>
		   		</tr><%
		    }
		 }else{		    	
	 		FieldDescriptor fieldDescriptor = new FieldDescriptor("value","value");
	        %>	<tr><td bgcolor=white colspan=2> 
	    	<%=defaultInputter.getInputterHTML(parameterContext.getVariable().getName(), fieldDescriptor, existingValue, null)%></td>
	   		</tr><%
		 }
	}
%>
</table>
</td></tr></table>



<input type="hidden" name="processDefinition" value="<%=decode(request.getParameter("processDefinition"))%>">

<%
	String returningProcess = decode(request.getParameter("returningProcess"));
	if(returningProcess!=null){%>
<input type="hidden" name="returningProcess" value="<%=returningProcess%>">
<input type="hidden" name="returningMessage" value="<%=decode(request.getParameter("returningMessage"))%>">
<%	}
%>

<p><input type='submit' value='initiate process'> 

</form>
