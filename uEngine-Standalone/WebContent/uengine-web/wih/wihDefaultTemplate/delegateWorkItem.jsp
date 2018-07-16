<%@page import="javax.transaction.*"%>
<%@include file="../wihDefaultTemplate/header.jsp"%>	
<%@include file="styleHeader.jsp"%>		

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%
    ProcessManagerRemote pm = null;
	String instanceId = request.getParameter("instanceId");
	String tracingTag = request.getParameter("tracingTag");
	String delegateEndpoint = request.getParameter("delegateEndpoint");
	String[] delegateEndpoints = delegateEndpoint.split(";");
    
	InitialContext context = new InitialContext();

	UserTransaction tx = (GlobalContext.useManagedTransaction ? (UserTransaction)context.lookup(GlobalContext.USERTRANSACTION_JNDI_NAME) : null);

	try{
		if(tx!=null) tx.begin();
		
		pm = processManagerFactory.getProcessManager();
		
		Map genericContext = new HashMap();
		genericContext.put("request", request);
		genericContext.put("response", response);
		genericContext.put("servlet", this);
		pm.setGenericContext(genericContext);
		
		ProcessInstance instance = pm.getProcessInstance(instanceId);
		
		RoleMapping delegateRoleMapping = RoleMapping.create();
		for (int i = 0; i<delegateEndpoints.length; i++) {
		    String endpoint = delegateEndpoints[i];
			delegateRoleMapping.setEndpoint(endpoint);
			delegateRoleMapping.fill(instance);
			delegateRoleMapping.moveToAdd();
		}
	    delegateRoleMapping.beforeFirst();
		
		String[] taskIds = pm.delegateWorkitem(instanceId, tracingTag, delegateRoleMapping);
	
		pm.applyChanges();
		
		if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
			tx.commit();

	} catch(Exception e) {
		e.printStackTrace();
		
		if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
			tx.rollback();
		throw e;
	} finally {
		pm.remove();
	}
%>
<script type="text/javascript">
	window.parent.location.href = "<%=GlobalContext.WEB_CONTEXT_ROOT%>/wih/formApprovalHandler/submitResult.jsp";
</script>