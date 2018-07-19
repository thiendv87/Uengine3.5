<%@include file="../../wihDefaultTemplate/header.jsp"%>	
<%@page import="javax.transaction.*,org.uengine.util.dao.*"%>
<%@include file="../troubleTicket.dao" %>	

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

//		pm.setProcessVariable(instanceId, "", "trouble_class", troubleClass);
//		pm.setProcessVariable(instanceId, "", "trouble_desc", troubleDesc);
		
		pm.completeWorkitem(instanceId, tracingTag, taskId, null);
		
		TroubleTicket troubleTicket = (TroubleTicket)GenericDAO.createDAOImpl(DefaultConnectionFactory.create(), "insert into troubleticket(regno, problemdesc, problemtype, instid) values (?regno, ?problemdesc, ?problemtype, ?instid)", TroubleTicket.class);
		troubleTicket.setRegNo(new Long(instanceId));
		troubleTicket.setProblemDesc(troubleDesc);
		troubleTicket.setProblemType(troubleClass);
		troubleTicket.setInstId(new Long(instanceId));
		troubleTicket.insert();

		pm.applyChanges();

		if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
			tx.commit();

	%>
	<h1><font color=green>		Workitem has been successfully completed
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