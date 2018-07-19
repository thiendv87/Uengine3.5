<%@include file="../common/header.jsp"%>
<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />
<%

	ProcessManagerRemote pm = processManagerFactory.getProcessManager();
	
	String pd = decode(request.getParameter("processDefinition"));
	String pi = decode(request.getParameter("instanceId"));
	
	ProcessDefinitionRemote pdr = pm.getProcessDefinitionRemote(pd);	
	ProcessVariable[] pvdrs = pdr.getProcessVariableDescriptors();
	
	for(int i=0; i<pvdrs.length; i++){
		ProcessVariable pvd = pvdrs[i];
		
		%><tr><td><%=pvd.getName()%></td><td><%=pvd.getType()%></td><%
		if(pi!=null){
			Serializable data = pm.getProcessVariable(pi, "", pvd.getName());
			%><%=data%> 
			<input type=button value='value in XML'>
			<input type=button value='change value'>
			<%
		}
	}
	
%>      
