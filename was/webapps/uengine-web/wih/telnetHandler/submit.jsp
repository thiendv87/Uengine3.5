<%@include file="../wihDefaultTemplate/header.jsp"%>		
<%@page import="javax.transaction.*"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.regex.Matcher"%>
<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />
<%!
	final String fileUploadEncoding = "UTF-8";

	public String getParameter(Map parameterMap, String key){
		String[] paramPair = (String[])parameterMap.get(key);
		if(paramPair!=null && paramPair.length > 0)
			return paramPair[0];
		else
			return null;
	}
	public String outterdecoder(String orgVal){
		try{
			return decode(orgVal);
		}catch(Exception e){
			return null;
		}
	}
%>
<%
	ProcessManagerRemote pm = processManagerFactory.getProcessManager();

	Map parameterMap = FormActivity.createParameterMapFromRequest (request);
	boolean wasIsJBoss = "JBOSS".equals(GlobalContext.getPropertyString("was.type", "TOMCAT"));
	boolean saveOnly = "yes".equals(request.getParameter("saveOnly"));
	boolean isValid = true;
	boolean initiate = "yes".equals(getParameter(parameterMap, "initiate"));

	String processDefinition = request.getParameter("processDefinition");
	String processInstance = request.getParameter("instanceId");
	String tracingTag = request.getParameter("tracingTag");
	String taskId = request.getParameter("taskId");

	String[] totalResult = (String[]) request.getParameterValues("totalResult");
	String[] totalResultFileName = (String[]) request.getParameterValues("totalResultFileName");
	String[] totalResultProcessVariableName = (String[]) request.getParameterValues("totalResultProcessVariableName");

	String[] result = (String[]) request.getParameterValues("result");
	String[] resultFileName = (String[]) request.getParameterValues("resultFileName");
	String[] resultProcessVariableName = (String[]) request.getParameterValues("resultProcessVariableName");
	String[] regularExpression = (String[]) request.getParameterValues("regularExpression");

	ProcessInstance instance = pm.getProcessInstance(processInstance);
	
	InitialContext context = new InitialContext();

	UserTransaction tx = (GlobalContext.useManagedTransaction ? (UserTransaction) context.lookup(GlobalContext.USERTRANSACTION_JNDI_NAME) : null);

	try {
		if (tx != null)
			tx.begin();
		
			ResultPayload resultPayload = new org.uengine.kernel.ResultPayload();

			Map genericContext = new HashMap();			
			genericContext.put(HumanActivity.GENERICCONTEXT_CURR_LOGGED_ROLEMAPPING, loggedRoleMapping);
			genericContext.put("request", request);
			genericContext.put("parameterMap", parameterMap);
			genericContext.put("response", response);
			genericContext.put("servlet", this);
			pm.setGenericContext(genericContext);

			if(isValid) {
				/*
				if (initiate) {
					processInstance = pm.initialize(processDefinition, processInstance, loggedRoleMapping);
				}
				*/
			
				if (totalResultProcessVariableName != null) {
					for (int i = 0; i < totalResultProcessVariableName.length; i++)
						if (UEngineUtil.isNotEmpty(totalResultProcessVariableName[i]))
							if (instance.getProcessDefinition().getProcessVariable(totalResultProcessVariableName[i]) != null)
								//pm.setProcessVariable(instanceId, "", totalResultProcessVariableName[i], totalResultFileName[i]);
								pm.setProcessVariable(processInstance, "", totalResultProcessVariableName[i], decode(totalResult[i]));
				}
			
				if (resultProcessVariableName != null) {
					for (int i = 0; i < resultProcessVariableName.length; i++) {
						if (UEngineUtil.isNotEmpty(resultProcessVariableName[i])) {
							if (instance.getProcessDefinition().getProcessVariable(resultProcessVariableName[i]) != null) {
								
								String decodeResult = decode(result[i]);
								String decodeRegularExpression = decode(regularExpression[i]);
								
								if (UEngineUtil.isNotEmpty(decodeRegularExpression)) {
							        StringBuffer sb = new StringBuffer();
									Pattern p = Pattern.compile(decodeRegularExpression);
									Matcher m = p.matcher(decodeResult);
					
									while (m.find()) {
										sb.append(m.group());
									}
		
									decodeResult = sb.toString();
								}
													
								pm.setProcessVariable(processInstance, "", resultProcessVariableName[i], decodeResult);
								//pm.setProcessVariable(instanceId, "", resultProcessVariableName[i], resultFileName[i]);
							}
						}
					}
				}
		
				pm.completeWorkitem(processInstance, tracingTag, taskId, null);
				
				
				boolean nextUserIsCurrentUser = false;
				String nextTaskId = "";
				
				String nextWorkerInfo = "";
				String nextAct = "";
				String nextWorkerRM = "";
				if (!saveOnly) {
					instance = pm.getProcessInstance(processInstance);
					List executedActivityCtxs = instance.getProcessTransactionContext().getExecutedActivityInstanceContextsInTransaction();
					
					if (executedActivityCtxs!=null && executedActivityCtxs.size() > 0) {
						for(int i=executedActivityCtxs.size()-1; i>-1; i--){
							ActivityInstanceContext lastActCtx = (ActivityInstanceContext) executedActivityCtxs.get(i);
							Activity lastAct = lastActCtx.getActivity();
							
							if (lastAct instanceof HumanActivity && lastActCtx.getInstance().isRunning(lastAct.getTracingTag())) {
								RoleMapping lastWorkerRM = ((HumanActivity)lastAct).getRole().getMapping(lastActCtx.getInstance());
								if(lastWorkerRM!=null){
									lastWorkerRM.fill(instance);
									
									if(lastWorkerRM.equals(loggedRoleMapping)){
										String[] taskIds = ((HumanActivity)lastAct).getTaskIds(lastActCtx.getInstance());
										
										if (taskIds!=null && taskIds.length>0) {
											nextUserIsCurrentUser = true;
											nextTaskId = taskIds[0];
										  //pageContext.forward(GlobalContext.WEB_CONTEXT_ROOT+"/processparticipant/worklist/workitemHandler.jsp?taskId="+taskIds[0]);
										}
									} else {
										nextAct = lastAct.toString();
										nextWorkerRM = lastWorkerRM.toString();
										nextWorkerInfo = GlobalContext.getMessageForWeb("The next step is", loggedUserLocale)+" '<b>" + lastAct+"</b>'";
										nextWorkerInfo+= GlobalContext.getLocalizedMessageForWeb("nextWorkerInfo_and", loggedUserLocale, "")+", ";
										nextWorkerInfo+= GlobalContext.getLocalizedMessageForWeb("and_the_worker_is", loggedUserLocale, "and the worker is")+" <b>";
										nextWorkerInfo+= ((HumanActivity)lastAct).getRole() + "(" +lastWorkerRM+")</b>";
										nextWorkerInfo+= GlobalContext.getLocalizedMessageForWeb("nextWorkerInfo_sentence_end", loggedUserLocale, "")+"."; 
									}
								}
							}
						}
						
					}
				}
	
			pm.applyChanges();

			if (!saveOnly && nextUserIsCurrentUser) {
		    	%>
				<script type="text/javascript">
			    	window.top.location.href = "<%=GlobalContext.WEB_CONTEXT_ROOT + "/processparticipant/worklist/workitemHandler.jsp?taskId=" + nextTaskId%>";
			    </script>
			    <%
		    } else {
		    	%>
				<body>
					<form name="submitResultFrm" target="_top" method="post" target="_top"
					action="<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT%>/wih/formApprovalHandler/submitResult.jsp">
					<input type="hidden" name="saveOnly" value="<%=saveOnly%>" />
					<input type="hidden" name="processInstance" value="<%=processInstance%>" />
					<input type="hidden" name="taskId" value="<%=taskId%>" />
					<input type="hidden" name="tracingTag" value="<%=tracingTag%>" />
					<input type="hidden" name="nextAct" value="<%=nextAct %>" />
					<input type="hidden" name="nextWorkerRM" value="<%=nextWorkerRM %>" />
				</form>
				</body>
				<script type="text/javascript">
			    	document.submitResultFrm.submit();
			    </script>
			    <%
		    }
%>
<%@include file="showSubmitResult.jsp"%>
<%@include file="saveFormInstance.jsp" %>

<%	} else { %>
		Oops!, Some invalid values! go back and submit again.
<%	}

	if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
		tx.commit();
	
%>
	
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
	}catch(Exception e){
	}
}
%>