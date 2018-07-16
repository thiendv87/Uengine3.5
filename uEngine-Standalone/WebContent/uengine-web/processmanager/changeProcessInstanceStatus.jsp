<%@include file="../common/header.jsp"%>

<LINK href="../style/uengine.css" type=text/css rel=stylesheet>

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />
<%
	ProcessManagerRemote pm = processManagerFactory.getProcessManager();
	String status = decode(request.getParameter("status"));	
	String pi = decode(request.getParameter("instanceId"));

	
	UserTransaction tx = (GlobalContext.useManagedTransaction ? (UserTransaction)context.lookup(GlobalContext.USERTRANSACTION_JNDI_NAME) : null);

	try{
		if(tx!=null) tx.begin();
		
		pm.setProcessInstanceStatus(pi, status);
		pm.applyChanges();
		
		if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
			tx.commit();

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
Status process instance '<%=pi%>' is set to '<%=status%>'.<p>
