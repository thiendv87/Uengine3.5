<%@include file="../common/header.jsp"%>
<%@page import="javax.transaction.*"%>

<LINK href="../style/uengine.css" type=text/css rel=stylesheet>

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" /><%

	ProcessManagerRemote pm = processManagerFactory.getProcessManager();
	InitialContext context = new InitialContext();
	
	UserTransaction tx = (GlobalContext.useManagedTransaction ? (UserTransaction)context.lookup(GlobalContext.USERTRANSACTION_JNDI_NAME) : null);

	try{
		if(tx!=null) tx.begin();
	
		String instanceId = decode(request.getParameter("instanceId"));

		pm.executeProcess(instanceId);
		pm.applyChanges();
		
		if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
			tx.commit();

%>
Process instance '<%=instanceId%>' has been successfully started.<p>
<%
	}catch(Exception e){
		try{
			pm.cancelChanges();
		}catch(Exception ex){
		}
	
		if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
			tx.rollback();

		throw e;
	}finally{
		try{
			pm.remove();
		}catch(Exception ex){
		}
	}

%>