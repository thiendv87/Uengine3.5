<%@include file="../../wihDefaultTemplate/header.jsp"%>		
<%@page import="javax.transaction.*"%>

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%
	ProcessManagerRemote pm = processManagerFactory.getProcessManager();

	String definitionId = request.getParameter("processDefinition");
	String instanceId = request.getParameter("instanceId");
	String tracingTag = request.getParameter("tracingTag");
	String taskId = request.getParameter("taskId");
	
	String troubleClass = request.getParameter("trouble_class");
	String troubleDesc = request.getParameter("trouble_desc");
	
	InitialContext context = new InitialContext();

	UserTransaction tx = (GlobalContext.useManagedTransaction ? (UserTransaction)context.lookup(GlobalContext.USERTRANSACTION_JNDI_NAME) : null);

	try{
		if(tx!=null) tx.begin();		

		instanceId = pm.initialize(definitionId, instanceId, loggedRoleMapping);
		
		pm.setProcessVariable(instanceId, "", "trouble_class", troubleClass);
		pm.setProcessVariable(instanceId, "", "trouble_desc", troubleDesc);
		
		pm.completeWorkitem(instanceId, tracingTag, taskId, null);

		pm.applyChanges();

		if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
			tx.commit();

	%>
	<h1><font color=green>Workitem has been successfully completed</font></h1>
	<%

	}catch(Exception e){
		e.printStackTrace();
		
		if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
			tx.rollback();
		
		throw e;
	}finally{
		try{
			pm.remove();
		}catch(Exception e){}
	}
%>		