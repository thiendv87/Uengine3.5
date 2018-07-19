<%@include file="../common/header.jsp"%>
<%@page import="javax.transaction.*"%>


<LINK href="../style/uengine.css" type=text/css rel=stylesheet>

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" /><%

	ProcessManagerRemote pm = processManagerFactory.getProcessManager();
	InitialContext context = new InitialContext();
	
	String pd = decode(request.getParameter("processDefinition"));
	System.out.println("pd : "+pd);
	UserTransaction tx = (GlobalContext.useManagedTransaction ? (UserTransaction)context.lookup(GlobalContext.USERTRANSACTION_JNDI_NAME) : null);

	try{
		if(tx!=null) tx.begin();
	
		pm.removeProcessDefinition(pd);
		pm.applyChanges();
		
		if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
			tx.commit();

%>
Process definition has been successfully removed.<br>


<%
	}catch(Exception e){
		e.printStackTrace();
	
		if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
			tx.rollback();
		throw e;
	}

%>