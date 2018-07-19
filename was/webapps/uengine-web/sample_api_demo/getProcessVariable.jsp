<%@include file="../common/header.jsp"%>
<%@page import="javax.transaction.*"%>

<LINK href="../style/uengine.css" type=text/css rel=stylesheet>

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" /><%

	ProcessManagerRemote pm = processManagerFactory.getProcessManagerForReadOnly();
	InitialContext context = new InitialContext();
	
	UserTransaction tx = (GlobalContext.useManagedTransaction ? (UserTransaction)context.lookup(GlobalContext.USERTRANSACTION_JNDI_NAME) : null);

	try{
		if(tx!=null) tx.begin();
	
		String instanceId = decode(request.getParameter("instanceId"));
		String variableName = decode(request.getParameter("variableName"));

		Serializable value = pm.getProcessVariable(instanceId, "", variableName);


%>
The value is '<%=value%>'.<p>
<%
	}catch(Exception e){
		throw e;
	}finally{
		try{
			pm.remove();
		}catch(Exception ex){
		}
	}

%>