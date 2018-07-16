<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%
	ProcessManagerRemote pm = processManagerFactory.getProcessManager();

	String instanceId = decode(request.getParameter("instanceId"));
	String tracingTag = request.getParameter("tracingTag");

	ProcessInstance instance = pm.getProcessInstance(instanceId);
//	ProcessDefinition procDef = intance.getProcessDefinition();
//	HumanActivity humanActivity = (HumanActivity)procDef.getActivity(tracingTag);
//	Role role = humanActivity.getRole();
	
	pm.delegateWorkitem(instanceId, tracingTag, roleMapping);
	pm.applyChanges();
%>
