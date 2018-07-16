<%@include file="../../common/header.jsp"%>
<%@include file="../../common/getLoggedUser.jsp"%>
<%@include file="../../common/styleHeader.jsp"%>
<%@page import="org.uengine.persistence.dao.*"%>
<%@page import="org.uengine.util.dao.*"%>
<%@page import="org.uengine.webservices.worklist.*"%>
<script>
	try {
		removeCloseLoding();
	} catch (e) {}
</script>
<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<%
	String strategyId = request.getParameter("strategyId");

	//request.setAttribute("userId", loggedUserId);
	Map parameterMap = null;
	String strTaskId = request.getParameter("taskId");
	String isViewMode = request.getParameter("isViewMode");
	String tool = "";
	int dispatchingOption = 0;
	Number taskId = null;
	WorkListDAO wl = null;
	String isMine = request.getParameter("isMine");

	String tracingTag = request.getParameter("tracingTag");
	String instanceId = request.getParameter("instanceId");
	String executionScope = null;
	String status = null;
	String endpoint = null;
	
	if(strTaskId!=null){
		taskId = new Integer(strTaskId);
			
		SimpleTransactionContext st = new SimpleTransactionContext();
		try {
			wl = DAOFactory.getInstance(st).findWorkListDAOByTaskId(null);
			wl.setTaskId(taskId);
			wl.select();
			wl.next();
			
			/**
			 * Properties gettable from variable 'wl' should be set by another variable here 
			 * if it can be reused after wl.update()
			 */
			tracingTag = wl.getTrcTag();
			instanceId = wl.getInstId() + "";
			executionScope = wl.getExecScope();
			
			String parameters = wl.getParameter();
	//		if(parameters!=null)
	//			parameterMap = (Map)GlobalContext.deserialize(parameters, String.class);
	
			tool = wl.getTool();
			dispatchingOption = wl.getDispatchOption();
			status = wl.getStatus();
			endpoint = wl.getEndpoint();
			
		} finally {
			st.releaseResources();
		}


		if (isMine =="" || isMine == null) {
			isMine = (wl!=null && endpoint!=null && endpoint.equals(loggedUserId) ? "yes" : "no");
		}

		if (
				!status.equals("DRAFT") 
				&& (org.uengine.kernel.Role.DISPATCHINGOPTION_RACING != dispatchingOption 
				&& status.equals("NEW")) && "yes".equals(isMine)
		) {
			
			wl = (WorkListDAO)GenericDAO.createDAOImpl(DefaultConnectionFactory.create(), "update bpm_worklist set status=?status where taskId=?taskId", WorkListDAO.class);
			wl.setTaskId(taskId);
			wl.setStatus(DefaultWorkList.WORKITEM_STATUS_CONFIRMED);
			wl.update();
		}   
	}

	if (parameterMap == null) {
		%>
		<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />
		<%
		ProcessManagerRemote pm = null;
		try{
			pm = processManagerFactory.getProcessManagerForReadOnly();
			
			ProcessInstance instance = pm.getProcessInstance(instanceId);
			if(executionScope!=null){
				instance.setExecutionScope(executionScope);
			}
			
			HumanActivity humanActivity = (HumanActivity)instance.getProcessDefinition().getActivity(tracingTag);
			
			tool = humanActivity.getTool();
			
			parameterMap = humanActivity.createParameter(instance);
		} finally {
			pm.remove();
		}
	}

	%>
<form action="../../wih/<%=tool%>/index.jsp" method="POST">
<input type="hidden" name="isViewMode" value="<%=isViewMode%>" />
<input type="hidden" name="workitemHandler" value="<%=tool%>" />
	<%
	if (strTaskId != null) {

%>
<input type="hidden" name="strategyId" value="<%=strategyId%>" />
<input type="hidden" name="taskId" value="<%=taskId%>" />
<input type="hidden" name="dispatchingOption" value="<%=dispatchingOption%>" />
<input type="hidden" name="isMine" value="<%=isMine%>" />
<input type="hidden" name="userId" value="<%=loggedUserId%>" />
<input type="hidden" name="isHiddenContext" value="<%=request.getParameter("isHiddenContext") %>" />

<%
	}

	if(parameterMap!=null){
		for(Iterator iter = parameterMap.keySet().iterator(); iter.hasNext();) {
			String key = (String)iter.next();
			String value = ""+parameterMap.get(key);
			value=value.replace('\"','\'');
			
					%>
					<input type="hidden" name="<%=key%>" value="<%=value%>">
					<%
		}
	}
%>	

<body onload="document.forms[0].submit()">
<%
		String displayString="Loading workitem handler...<br>";
		displayString+="click <input type=submit value=here> if the handler is not located.";
%>
</form>
