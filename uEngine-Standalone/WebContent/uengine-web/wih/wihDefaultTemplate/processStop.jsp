<%@page import="javax.transaction.*"%>
<%@include file="header.jsp"%>
<%@include file="definition.jsp"%>
<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<body onload="document.forms[0].submit()">

<%
	instanceId = request.getParameter("instanceId");
	
	InitialContext context = new InitialContext();

	UserTransaction tx = (GlobalContext.useManagedTransaction ? (UserTransaction)context.lookup(GlobalContext.USERTRANSACTION_JNDI_NAME) : null);

	try{
		if(tx!=null) tx.begin();
		
		pm = processManagerFactory.getProcessManager();
		
		ProcessInstance rootInstance = pm.getProcessInstance(instanceId).getRootProcessInstance();
		
		rootInstance.stop();
		
		pm.applyChanges();
		
		if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
			tx.commit();

	}catch(Exception e){
		
		if(pm != null) try{ pm.remove(); }catch(Exception ex){}
		e.printStackTrace();		
	
		if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
			tx.rollback();
		throw e;
	}finally{
		if(pm != null) try{ pm.remove(); }catch(Exception ex){}
	}
%>
		<form name="submitResultFrm" action="submitResult.jsp" target="iframeWihContent" method="post">
			<br>
			<%@include file="passValues.jsp"%>
		</form>
	</body>
</html>
