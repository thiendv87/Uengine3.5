<%@include file="../../common/header.jsp"%>
<%@include file="../../common/getLoggedUser.jsp"%>
<%@page import="javax.transaction.*"%>
<%@page import="org.apache.commons.fileupload.*"%>

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
		try {
			return decode(orgVal);
		} catch(Exception e) {
			return null;
		}
	}
	
%>
<jsp:useBean id="processManagerFactory" scope="application" 
class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%
	boolean wasIsJBoss = "JBOSS".equals(GlobalContext.getPropertyString("was.type", "TOMCAT"));	
	ProcessManagerRemote pm = processManagerFactory.getProcessManager();
	InitialContext context = new InitialContext();
	boolean nextUserIsCurrentUser = false;
	String nextTaskId = "";

	Map parameterMap;

	WebUtil.setWebStringDecoder(
		new WebStringDecoder() {
			public String decode(String src){
				return outterdecoder(src);
			}
		}
	);
	
	parameterMap = request.getParameterMap();

	String processDefinition = getParameter(parameterMap, "processDefinition");
	String initiationProcessDefinition = getParameter(parameterMap, "initiationProcessDefinition");
	String processInstance = decode(getParameter(parameterMap, "instanceId"));
	String tracingTag = decode(getParameter(parameterMap, "tracingTag"));
	String taskId = decode(getParameter(parameterMap, "taskId"));
	boolean initiate = "yes".equals(getParameter(parameterMap, "initiate"));
	boolean saveOnly = "yes".equals(getParameter(parameterMap, "saveOnly"));
	boolean isEventHandler = "yes".equals(getParameter(parameterMap, "isEventHandler"));
	String tags = decode(getParameter(parameterMap, "tags"));
	
	// 2009-08-07 add start
	String InstanceName = decode(getParameter(parameterMap,"name"));
	//add end
	
	ProcessInstance instance = (org.uengine.util.UEngineUtil.isNotEmpty(processInstance) ? pm.getProcessInstance(processInstance) : null);
	String executionScope = getParameter(parameterMap, "executionScope");
	if(UEngineUtil.isNotEmpty(executionScope)){
		instance.setExecutionScope(executionScope);
	}
	
	Vector result = new Vector();

	
	boolean isValid = true;

	UserTransaction tx = (GlobalContext.useManagedTransaction ? (UserTransaction)context.lookup(GlobalContext.USERTRANSACTION_JNDI_NAME) : null);

	try {
		if (tx != null) tx.begin();	
		
		if (isValid && initiate && !UEngineUtil.isNotEmpty(processInstance)) {
			processInstance = pm.initializeProcess(processDefinition, processInstance);
		}
		
%>
<div id="getResult" style="display : 'NONE'">
<%@include file="getResult.jsp"%>
</div >
<%
		
		if(isValid){
			ResultPayload resultPayload = new org.uengine.kernel.ResultPayload();
			KeyedParameter[] processVariableChanges = new KeyedParameter[result.size()];
			result.toArray(processVariableChanges);
			resultPayload.setProcessVariableChanges(processVariableChanges);
			
			String url_of_application_result = getParameter(parameterMap, "url_of_application_result");
			if(UEngineUtil.isNotEmpty(url_of_application_result)){
				resultPayload.setExtendedValue(
						new KeyedParameter("url_of_application_result", url_of_application_result)
				);
			}
 
			String html_of_application_result = getParameter(parameterMap, "html_of_application_result");
			if(UEngineUtil.isNotEmpty(html_of_application_result)){
				resultPayload.setExtendedValue(
						new KeyedParameter("html_of_application_result", html_of_application_result)
				);
			}

			resultPayload.setExtendedValues(new KeyedParameter[]{new KeyedParameter("TASKID", taskId)});
			
			Map genericContext = new HashMap();
			genericContext.put(HumanActivity.GENERICCONTEXT_CURR_LOGGED_ROLEMAPPING, loggedRoleMapping);
			genericContext.put("request", request);
			genericContext.put("response", response);
			genericContext.put("servlet", this);

			//added
			String initiationTime = getParameter(parameterMap, "initiationTime");
			if(UEngineUtil.isNotEmpty(initiationTime)){
				genericContext.put("initiationTime", initiationTime);
			}
			//end
			
			pm.setGenericContext(genericContext);

			if(isEventHandler){
				//String mainInstanceId = getParameter(parameterMap, "mainInstanceId");
				String eventName = getParameter(parameterMap, "eventName");
				String triggerActivityTracingTag = request.getParameter("triggerActivityTracingTag");

				pm.executeEventByWorkitem(processInstance, eventName, triggerActivityTracingTag , resultPayload);
			
			} else if (initiate) {//The case that this workitem handler should initiate the process
			//	if(processInstance!=null && (processInstance.trim().equals("null") || processInstance.trim().length()==0))
			//		processInstance = null;
				
			//	processInstance = pm.initializeProcess(processDefinition, processInstance);
				ProcessDefinitionRemote pdr = pm.getProcessDefinitionRemote(processDefinition);
				
				org.uengine.kernel.Role[] roles = pdr.getRoles();
				WebInputter inputterForRoleMapping = (WebInputter)ObjectType.getDefaultInputter(RoleMapping.class); 
				for(int i=0; i<roles.length; i++){
					String key = roles[i].getName().replace(' ', '_');
					
					RoleMapping roleMapping = (RoleMapping)inputterForRoleMapping.createValueFromHTTPRequest(parameterMap, "rolemappings", key, null);

					if (roleMapping!=null && roleMapping.getEndpoint()!=null) {
						roleMapping.setName(roles[i].getName());
						pm.putRoleMapping(processInstance, roleMapping);
					}
				}
				
				//added by yookjy 2011-04-04 (for the first process is a subprocess)
				tracingTag = request.getParameter("initiatorHumanActivityTracingTag");
				
				if(saveOnly){
					pm.saveWorkitem(processInstance, tracingTag, taskId, resultPayload);
				}else{
					pm.executeProcessByWorkitem(processInstance, resultPayload);
				}
				
				if (instance == null) {
				    instance = pm.getProcessInstance(processInstance);
				}
			}else if(saveOnly){
				pm.saveWorkitem(processInstance, tracingTag, taskId, resultPayload);
			}else{
				pm.completeWorkitem(processInstance, tracingTag, taskId, resultPayload);
			}
			
			// add tag 2011-03-17
            com.defaultcompany.web.tag.TagDAO tagDao = new com.defaultcompany.web.tag.TagDAO();
            tagDao.setTag(instance, tags, loggedUserGlobalCom);

			String nextWorkerInfo = "";
			String nextAct = "";
			String nextWorkerRM = "";
			instance = pm.getProcessInstance(processInstance);
			if (!saveOnly) {
				
				List executedActivityCtxs = instance.getProcessTransactionContext().getExecutedActivityInstanceContextsInTransaction();
				
				//2009-08-10 set Instance Name
				if(InstanceName!=null && InstanceName.trim().length()>0)
					instance.setName(InstanceName);
				
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
			
			if(instance.isNew()) {
				//modified by yookjy 2011-04-04 (for the first process is a subprocess)
				String status = saveOnly ? Activity.STATUS_RUNNING : Activity.STATUS_COMPLETED;
				Vector activityList = instance.getActivitiesDeeply(status);
				
				ActivityInstanceContext aiContext = null;
				ProcessInstance currInstance = null;
				Activity currActivity = null;
				
				for (int i=activityList.size()-1; i>=0; i--) {
					aiContext = (ActivityInstanceContext)activityList.get(i);
					currInstance = aiContext.getInstance();
					currActivity = aiContext.getActivity();
					
					if (currActivity instanceof HumanActivity) {
						String[] taskIds =  ((HumanActivity)currActivity).getTaskIds(currInstance);
				    	taskId = taskIds[0];
				    	
						if (!processInstance.equals(currInstance.getInstanceId())) {
							processDefinition = "[" + currInstance.getProcessDefinition().getAlias() + "]@"
											+ currInstance.getProcessDefinition().getBelongingDefinitionId();
							processInstance = currInstance.getInstanceId();
							tracingTag = currActivity.getTracingTag();
						} 
					}
				}
				// end
			/*
				Activity activity = instance.getProcessDefinition().getActivity(tracingTag);
				
				if (activity instanceof HumanActivity) {
			    	String[] taskIds =  ((HumanActivity)activity).getTaskIds(instance);
			    	taskId = taskIds[0];
				}
			*/	
		    }
			
			pm.applyChanges();

			
			/* Add Debug info */
			if (GlobalContext.logLevelIsDebug && pm instanceof ProcessManagerBean) {
				ProcessManagerBean pmb = (ProcessManagerBean)pm;
				StringBuilder debugInfo = pmb.getTransactionContext().getDebugInfo();
			
%>
				<textarea rows="80" cols="150"><%=debugInfo%></textarea><br /><br />
<%
			}
%>

<%-- Set Reload URL --%>
<%	
			String reloadURL = "";  
			if (!saveOnly && nextUserIsCurrentUser) {
				reloadURL = GlobalContext.WEB_CONTEXT_ROOT + "/processparticipant/worklist/workitemHandler.jsp?taskId="+nextTaskId;
			} else {
				reloadURL = GlobalContext.WEB_CONTEXT_ROOT + "/processparticipant/worklist/workitemHandler.jsp?taskId="+taskId;
			}
%>


			<script type="text/javascript">
			
			function reloadWih(){
	    		var url = "<%=reloadURL%>"; 			    
				var ifrm =window.parent.window.parent.window.parent.document.getElementById("iframeViewTotalResult");
				if(ifrm !=null){
					ifrm.src = url;
					ifrm.reload();
				}else{
					window.top.location.href = url;
				}
			}
			reloadWih();
			
			</script>
			
<%-- 	
		<body>
			<form name="submitResultFrm" target="_top" method="post" target="_top"
			action="<%=org.uengine.kernel.GlobalContext.WEB_CONTEXT_ROOT%>/wih/wihDefaultTemplate/submitResult.jsp">
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
	    
		<%@include file="showSubmitResult.jsp"%> 
--%>
<%@include file="saveFormInstance.jsp" %>

<%	} else { %>
		Oops!, Some invalid values! go back and submit again.
<%	}

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
	}catch(Exception e){
	}
}
%>