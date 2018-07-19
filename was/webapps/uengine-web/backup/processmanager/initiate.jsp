<%@include file="../common/header.jsp"%>
<%@page import="javax.transaction.*"%>
	
<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />
<%
	ProcessManagerRemote pm = processManagerFactory.getProcessManager();
	
	String pd = decode(request.getParameter("processDefinition"));
	String pi = decode(request.getParameter("instanceId"));
	String isAdhoc = decode(request.getParameter("isAdhoc"));

	if(pi!=null)
		pi = pi.trim();
	String pid;

	ProcessDefinitionRemote pdr = pm.getProcessDefinitionRemote(pd);
		
	ProcessVariable[] processVariables = pdr.getProcessVariableDescriptors();
	
	boolean isValid = true;
%>		        

You've submitted values for the initial process variables as follows:
<table><tr><td bgcolor=black>
<table cellspacing=1>

<%
	Vector result = new Vector();
	
	for(int j=0; j<processVariables.length; j++){		
		ParameterContext parameterContext = new ParameterContext();
		parameterContext.setVariable(processVariables [j]);
		parameterContext.setArgument(processVariables [j].getName());
	
	    %>	<tr><td bgcolor=#aaaaaa colspan=2> <%=parameterContext.getArgument().getText(loggedUserLocale)%> </td></tr><%
		
		WebInputter defaultInputter = (WebInputter)parameterContext.getVariable().getInputter();
		
		if(defaultInputter==null){	//generates inputter on the fly
			Class outputCls = parameterContext.getVariable().getType(); //org.uengine.kernel.GlobalContext.getComponentClass(clsName);	
			ObjectType outputClsTable = new ObjectType(outputCls);
			HashMap validationResult = null;
			
			ObjectInstance rec = (ObjectInstance)WebUtil.createRecord(outputClsTable, request.getParameterMap(), parameterContext.getVariable().getName(), validationResult);
			Object value = rec.getObject();
			
			//show submitted result again
			FieldDescriptor[] arrayFieldDescriptors = outputClsTable.getFieldDescriptors();
			for(int i=0; i<arrayFieldDescriptors.length; i++){
		    	FieldDescriptor fieldDescriptor = arrayFieldDescriptors[i];
		        %>
		        <tr>
		        	<td bgcolor=#aaaaff> <%=fieldDescriptor.getDisplayName()%> </td> 
		   			<td bgcolor=white> <%=rec.getFieldValue(fieldDescriptor.getName())%>
		   		<%
		   		if(validationResult!=null && validationResult.containsKey(fieldDescriptor.getName())){
		   			%><font color=red>(<%=validationResult.get(fieldDescriptor.getName())%>)</font><%
		   		}		   			
		   		%>	
		   			</td>
		   		</tr>
		   		<%
		    }
	    
			if(validationResult==null)
				result.add(value);
			else 
				isValid = false;
		}else{	//use the specified one
			Object value = defaultInputter.createValueFromHTTPRequest(request.getParameterMap(), parameterContext.getVariable().getName(), "value");
			result.add(value);
			%>
		        <tr>
		   			<td bgcolor=white colspan=2> <%=value%>	</td>
		   		</tr>
		   	<%
		}
	}
%>

</table>
</td></tr></table>

<%
	if(isValid){
//		UserTransaction txCtx = (UserTransaction)context.lookup("UserTransaction");
//		try{
//			txCtx.begin();		
			if(pi!=null && pi.length()>0){
				pid = pm.initializeProcess(pd, pi);
			}else
				pid = pm.initializeProcess(pd);
				
			Role[] roles = pdr.getRoles();
			for(int i=0; i<roles.length; i++){
				String endpoint = request.getParameter(roles[i].getName().replace(' ', '_') + "_endpoint");
				
				if(endpoint!=null){
					pm.putRoleMapping(pid, roles[i].getName(), endpoint);
				}
			}
		
			for(int i=0; i<processVariables.length; i++){
				String pvName = processVariables[i].getName();
				Serializable value = (Serializable)result.elementAt(i);
				if(value!=null){
					pm.setProcessVariable(pid, "", pvName, value);
				}
			}	
			
			//for sub process 
			String returningProcess = decode(request.getParameter("returningProcess"));
			String returningMessage = decode(request.getParameter("returningMessage"));	
			if(returningProcess!=null && returningProcess.trim().length()>0){
				pm.setProcessVariable(pid, "", "_returningProcess", returningProcess);
				pm.setProcessVariable(pid, "", "_returningMessage", returningMessage);
			}
			//end
		
			pm.executeProcess(pid);
			pm.remove();
//			txCtx.commit();
//		}catch(Exception e){
//			txCtx.rollback();
//			throw e;
//		}
%>
<p>
		Process has been initiated with process instance id '<a href='viewProcessFlowChart.jsp?instanceId=<%=pid%>'><%=pid%></a>'.
<%	}else{%>
<p>		Oops!, Some invalid initial value! go back and submit again.
<%	}%>		

