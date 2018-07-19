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
		String variableName = decode(request.getParameter("variableName"));
		String value = decode(request.getParameter("value"));

		pm.setProcessVariable(instanceId, "", variableName, value);

		pm.applyChanges();
		
		try{
			tx.commit();
		}catch(Exception txe){
		}

%>
Value has been set.<p>
<%
	}catch(Exception e){
		try{
			pm.cancelChanges();
		}catch(Exception txe){
		}
	
		try{
			tx.rollback();
		}catch(Exception txe){
		}

		throw e;
	}finally{
		try{
			pm.remove();
		}catch(Exception ex){
		}
	}

%>