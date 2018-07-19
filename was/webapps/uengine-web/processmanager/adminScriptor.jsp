<%@include file="../common/header.jsp"%>
<%@page import="javax.transaction.*"%>

<LINK href="../style/uengine.css" type=text/css rel=stylesheet>

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%
	ProcessManagerRemote pm = processManagerFactory.getProcessManager();
	
	String pi = decode(request.getParameter("instanceId"));

	UserTransaction tx = (GlobalContext.useManagedTransaction ? (UserTransaction)context.lookup(GlobalContext.USERTRANSACTION_JNDI_NAME) : null);

	try{
		if(tx!=null) tx.begin();
		
		ProcessInstance instance = pm.getProcessInstance("201");
		instance = instance.getRootProcessInstance();
		SubProcessActivity sp = (SubProcessActivity)instance.getProcessDefinition().getActivity("15");
		sp.attachSubProcess(instance, "189", "testtest");
		pm.applyChanges();
		
		if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
			tx.commit();

	}catch(Exception e){
		try{
			pm.cancelChanges();
		}catch(Exception ex){
		}
		
		e.printStackTrace();
	
		if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
			tx.rollback();
		throw e;
	}finally{
		pm.remove();
	}

%>