<%@include file="../common/header.jsp"%>
<%@page import="javax.transaction.*"%>

<LINK href="../style/uengine.css" type=text/css rel=stylesheet>

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" /><%

	ProcessManagerRemote pm = processManagerFactory.getProcessManager();
	InitialContext context = new InitialContext();
	
	UserTransaction tx = (GlobalContext.useManagedTransaction ? (UserTransaction)context.lookup(GlobalContext.USERTRANSACTION_JNDI_NAME) : null);

	try{
		if(tx!=null) tx.begin();
	
		String definitionName = decode(request.getParameter("definitionName"));
		String productionVersionId = pm.getProcessDefinitionProductionVersionByName(definitionName);
		String instanceId = pm.initializeProcess(productionVersionId);
		pm.applyChanges();
		
		try{
			tx.commit();
		}catch(Exception txe){
		}

%>
Process instance '<%=instanceId%>' has been successfully initialized.<p>
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
			System.out.println("error when to remove pm");
			ex.printStackTrace();
		}
	}

%>