<%@include file="../common/header.jsp"%>
<%@page pageEncoding="KSC5601"%>

<%@page import="org.uengine.kernel.viewer.ViewerOptions"%>

<body bgcolor="#FFFFFF">
<LINK href="../style/uengine.css" type="text/css" rel="stylesheet">

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%
	ProcessManagerRemote pm = processManagerFactory.getProcessManager();
	
	String pd = decode(request.getParameter("processDefinition"));
	String folder = decode(request.getParameter("folder"));
	String pi = decode(request.getParameter("instanceId"));
	String chart ="no chart is available";
	
	ProcessDefinitionRemote pdr;	
	if(pi!=null)
		pdr = pm.getProcessDefinitionRemoteWithInstanceId(pi);
	else
		pdr = pm.getProcessDefinitionRemote(pd);
	
	String title = pdr.getName().toString();
	
	ViewerOptions options = new ViewerOptions();
	options.put("flowControl", new Boolean(true));
	
	if(pi != null){
		chart = pm.viewProcessInstanceFlowChart(pi, options);
%>
<script>
	function viewProcessVariableInXML(variableName){
		window.open('viewProcessVariableInXML.jsp?instanceId=<%=pi%>&variableName='+variableName, 'processVariable', 'width=700,height=500,scrollbars=yes,resizable=yes');
	}
	function showProcessVariableChangeForm(variableName, variableType){
		window.open('processVariableChangeForm.jsp?instanceId=<%=pi%>&variableName='+variableName+ '&dataClassName=' + variableType, 'processVariable', 'width=700,height=500,scrollbars=yes,resizable=yes');
	}
	function showRoleMappingChangeForm(roleName, oldValue){
		window.open('roleMappingChangeForm.jsp?instanceId=<%=pi%>&roleName='+roleName.replace(' ', '+')+ '&oldValue=' + oldValue, 'roleMapping', 'width=700,height=500,scrollbars=yes,resizable=yes');
	}

	function showActivityDetails(instanceID, tracingTag){
		window.open('viewActivityDetails.jsp?instanceID=' + instanceID + '&tracingTag=' + tracingTag,'activitydetails','width=500,height=400,scrollbars=yes,resizable=yes');
	}
	function resume(tracingTag){
		flowControl('resume', tracingTag);
	}
	
	function suspend(tracingTag){
		flowControl('suspend', tracingTag);
	}
	
	function skip(tracingTag){
		flowControl('skip', tracingTag);
	}
	
	function compensate(tracingTag){
		flowControl('compensate', tracingTag);
	}

	function flowControl(command, tracingTag){
		go('flowControl.jsp?returnPage=viewProcessFlowChart.jsp&command='+ command + '&instanceId=<%=pi%>' + '&tracingTag=' + tracingTag);
	}
			
	function go(urlToGo){
	 	location = urlToGo;
	}
</script>

<%
	//ProcessInstance processInstanceCopy = pm.getProcessInstance(pi);
	String pin = request.getParameter("pin"); //process instance name
%>
	
<h1>Instance Name (ID): <%=(pin !=null ? pin:"")%> (<%=pi%>)</h1>
<%
	}
	else
	if(pd != null){
		chart = pm.viewProcessDefinitionFlowChart(pd, options);
	}
%>		        


<h1>Definition Name : <%=pdr.getName()%> <input type=button onclick="rename()" value="Rename"></h1>
<h1>Version: <%=pdr.getVersion()%></h1>
<h1>Flow Chart: </h1>
<%
chart = chart.replaceAll("<td width=2 bgcolor=black></td>", "<td width=2 bgcolor=black><img src='' width=2></td>");
chart = chart.replaceAll("<td width=2 bgcolor=green></td>", "<td width=2 bgcolor=green><img src='' width=2></td>");
chart = chart.replaceAll("<td width=2 bgcolor=gray></td>", "<td width=2 bgcolor=gray><img src='' width=2></td>");
%>
<style type="text/css">
<!--div.scroll {	
	height: 250px;	width: 700px;	
	overflow: auto;	border: 1px solid #B6CBEB;	padding: 8px;}-->
</style>
<div class="scroll" id="processLine" overflow:scroll; style="display:block" width=700 height=250 cellspacing="0" cellpadding="0">
<%=chart%>
</div>

<%if (pd!=null){
	if(pdr.getDescription()!=null){%>
	<h1> Description:</h1>
	<ul><%=pdr.getDescription()%></ul> 
<%	}%>

	<form>
		<input value="Initiate" type=button onclick="location='initiateForm.jsp?processDefinition=<%=pd%>'">
		<input value="Improve" type=button onclick="location='ProcessDesigner.jnlp?processDefinition=<%=pd%>&folder=<%=folder%>'">
		<input value="Retire" type=button onclick="removeDefinition('<%=pd%>')">
<%	
	if(pdr.isProduction()){
		%><font color=gray>[production]</font><p><%
	}else{
		%><input type=button value="Set as production" onclick="javascript:makeProduction()"><%
	}
%>	
	</form>
	
	<script>
	function rename(){
		var newName;
		if(newName = prompt("Enter new name:")){
			location="renameProcessDefinition.jsp?processDefinition=<%=pdr.getBelongingDefinitionId()%>&newName="+ newName.replace(' ', '+');
		}
	}
	
	function showDefinition(processDefinitionName, language){
		window.open('showDefinitionInLanguage.jsp?processDefinition=' + processDefinitionName + '&language=' + language,'definitionInLanguage','width=700,height=500,scrollbars=yes,resizable=yes');
	}
	function showWSDL(location){
		window.open(location, 'wsdl', 'width=700,height=500,scrollbars=yes,resizable=yes')
	}
	function removeDefinition(definition){
		answer = confirm("There may be a running instance with this process definition.\nAre you sure to remove?");
		if(answer){
			location="removeProcessDefinition.jsp?processDefinition=" + definition;
		}
	}
	function makeProduction(){
		location="makeProduction.jsp?processDefinition=<%=pd.replace(' ', '+')%>";
	}
	</script>
	<h1> See process in:</h1>
	<a href="javascript:showDefinition('<%=pd%>', 'BPEL')">BPEL4WS</a>,
	 <a href="javascript:showDefinition('<%=pd%>', 'Bean')">Bean</a>
	or
	<a href="javascript:showDefinition('<%=pd%>', 'WSCI')">WSCI</a>
	<p>
	<%	String serviceName = pdr.getName().replace(' ', '_');%>
	<!--
	<h1> See service description in </h1> [<a href=javascript:showWSDL('/axis/services/<%=serviceName%>?wsdl')>WSDL</a>] and the endpoint is <a href='/axis/services/<%=serviceName%>'>here</a>
	-->
	<p>
<%}else{
	if(pdr.isAdhoc()){
		%><input value="Edit" type=button onclick="location='ProcessDesigner.jnlp?processInstance=<%=pi%>&processDefinition=<%=pdr.getId()%>'"><i>(beta)</i><%
	}
  }
%>

<h1> Variables</h1>
<table border=0 cellspacing=4>
	<tr><td>Name</td><td>Type</td><td>Value</td></tr>
	<tr><td height=1 colspan=3 bgcolor=black></td></tr>
<%
		
	ProcessVariable[] pvdrs = pdr.getProcessVariableDescriptors();
	
	if(pvdrs!=null)
	for(int i=0; i<pvdrs.length; i++){
		ProcessVariable pvd = pvdrs[i];
		
		%><tr><td><%=pvd.getDisplayName()%></td><td><%=pvd.getType() == null ? "" : pvd.getType().getName()%></td><td><%
		if(pi!=null){
			Serializable data = pm.getProcessVariable(pi, "", pvd.getName());
			%><%=data%> 
			<input type=button value='XML' onclick="viewProcessVariableInXML('<%=pvd.getName()%>')">
			<input type=button value='change' onclick="showProcessVariableChangeForm('<%=pvd.getName()%>', '<%=pvd.getType() == null ? "" : pvd.getType().getName()%>')">
			<%
		}
		%></td></tr><%
	}
	

%>
</table>
<p>


<h1> Roles</h1>

<table border=0 cellspacing=4>
	<tr><td>Name</td><td>Bound Resource</td></tr>
	<tr><td height=1 colspan=2 bgcolor=black></td></tr>

<%
	Role[] roles = pdr.getRoles();
	
	if(roles!=null)
	for(int i=0; i<roles.length; i++){
		Role role = roles[i];
		
		%><tr><td><%=role.getDisplayName()%></td><td><%
		if(pi!=null){
			String endpoint = pm.getRoleMapping(pi, role.getName());
			%><%=endpoint%> 
			<input type=button value='change' onclick="showRoleMappingChangeForm('<%=role.getName()%>', '<%=endpoint%>')">
			<%
		}
		%></td></tr><%
	}
	
%>
</table>