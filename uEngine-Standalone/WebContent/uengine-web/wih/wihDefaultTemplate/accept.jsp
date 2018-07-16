<%@page import="javax.transaction.*"%>
<html>
<head>
<%@include file="header.jsp"%>
<%@include file="definition.jsp"%>
<%@include file="initialize.jsp"%>
</head>
<body>
		<h1>Accepting this workitem to my work...</h1>
<%
	String reqcd = request.getParameter("reqcd");
	String userDefinitionName = request.getParameter("userDefinitionName");
	String userLocale = request.getParameter("userLocale");
	String instanceAlias = request.getParameter("instanceAlias");
	String keyedParameterTiTile = request.getParameter("keyedParameterTiTile");
	String contentPageName = request.getParameter("contentPageName");
	
	InitialContext context = new InitialContext();

	UserTransaction tx = (GlobalContext.useManagedTransaction ? (UserTransaction)context.lookup(GlobalContext.USERTRANSACTION_JNDI_NAME) : null);

	try{
		if(tx!=null) tx.begin();
		
		int roleMappingSize = 0;
		String resourceName = "";
		String endPoint = "";
		
		Map genericContext = new HashMap();
		genericContext.put("request", request);
		genericContext.put("response", response);
		genericContext.put("servlet", this);
		pm.setGenericContext(genericContext);
		
		Activity act = pm.getProcessInstance(instanceId).getProcessDefinition().getActivity(tracingTag);
		if (act instanceof HumanActivity) {
			Role role = ((HumanActivity)act).getRole();
			RoleMapping roleMapping = role.getMapping(pm.getProcessInstance(instanceId), tracingTag);
			roleMappingSize = roleMapping.size();
			resourceName = roleMapping.getResourceName();
			endPoint = roleMapping.getEndpoint();
		}
		
		if (roleMappingSize > 1) {
			pm.delegateRoleMapping(instanceId, ((HumanActivity)act).getRole().getName(),loggedRoleMapping.getEndpoint());
			String[] taskIds = ((HumanActivity)act).getTaskIds(pm.getProcessInstance(instanceId));
			request.setAttribute("taskId", taskIds[0]);
			endPoint = loggedUserId;
		} 
%>
		<script type="text/javascript">
			$(document).ready(function() {
<%		
		if (loggedUserId.equals(endPoint)) {
%>
				window.top.location.href = "<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/workitemHandler.jsp" 
					+ "?taskId=<%=request.getParameter("taskId")%>"
					+ "&instanceId=<%=request.getParameter("instanceId")%>" 
					+ "&tracingTag=<%=request.getParameter("tracingTag")%>"
					+ "&isViewMode=<%=request.getParameter("isViewMode")%>"
					+ "&isMine=yes";
<%
		} else {
%>			
				alert("This workItem is accepted by <%=resourceName%>");
				window.top.opener.init();
				window.top.close();
<%				
		}
%>
			});
		</script>
<%			
		pm.applyChanges();
		
		if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
			tx.commit();

	}catch(Exception e){
		e.printStackTrace();
	
		if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
			tx.rollback();
		throw e;
	}
%>
	</body>
</html>
