<%@ page pageEncoding="UTF-8" language="java" contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-cache");
%>
<%@include file="../../common/header.jsp"%>
<%@include file="../../common/getLoggedUser.jsp"%>
<%@page import="javax.transaction.*"%>
<%@page import="org.apache.commons.fileupload.*"%>
<%@page import="org.uengine.contexts.HtmlFormContext"%>

<!--
You've submitted data as follows:
<table><tr><td bgcolor=black>
<table cellspacing=1>
-->

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
<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%
	
	ProcessManagerRemote pm = processManagerFactory.getProcessManager();

	InitialContext context = new InitialContext();

	UserTransaction tx = (GlobalContext.useManagedTransaction ? (UserTransaction)context.lookup(GlobalContext.USERTRANSACTION_JNDI_NAME) : null);


	try{
		if(tx!=null)
			tx.begin();		

		
		boolean nextUserIsCurrentUser = false;
		String nextTaskId = "";
		boolean wasIsJBoss = "JBOSS".equals(GlobalContext.getPropertyString("was.type", "TOMCAT"));
		
		ObjectType.addInputterPackage("org.uengine.processdesigner.inputters");
	
		Map parameterMap;
	
		WebUtil.setWebStringDecoder(
			new WebStringDecoder() {
				public String decode(String src){
					return outterdecoder(src);
				}
			}
		);
	
	
		parameterMap = FormActivity.createParameterMapFromRequest (request);
			
		String processDefinition = getParameter(parameterMap, "processDefinition");
		String initiationProcessDefinition = getParameter(parameterMap, "initiationProcessDefinition");
		String processInstance = decode(getParameter(parameterMap, "instanceId"));
		String tracingTag = decode(getParameter(parameterMap, "tracingTag"));
		String taskId = decode(getParameter(parameterMap, "taskId"));
		boolean initiate = "yes".equals(getParameter(parameterMap, "initiate"));
		boolean saveOnly = "yes".equals(getParameter(parameterMap, "saveOnly"));
		boolean isEventHandler = "yes".equals(getParameter(parameterMap, "isEventHandler"));
		
		// 2009-08-07 add start
		String InstanceName = decode(getParameter(parameterMap,"name"));
		//add end
		
		Vector result = new Vector();
		ProcessInstance instance = (org.uengine.util.UEngineUtil.isNotEmpty(processInstance) ? pm.getProcessInstance(processInstance) : null);
		ProcessDefinition procDef = (ProcessDefinition)pm.getProcessDefinition(initiationProcessDefinition);
		
		String approvalbtn = getParameter(parameterMap, "approvalbtn");
		boolean isAutoComplete = "true".equals(getParameter(parameterMap, "isAutoCompelte"));
%>

</table>
</td></tr></table>
<%
			ResultPayload resultPayload = new org.uengine.kernel.ResultPayload();

			Map genericContext = new HashMap();			
			genericContext.put(HumanActivity.GENERICCONTEXT_CURR_LOGGED_ROLEMAPPING, loggedRoleMapping);
			genericContext.put("request", request);
			genericContext.put("parameterMap", parameterMap);
			genericContext.put("response", response);
			genericContext.put("servlet", this);
			pm.setGenericContext(genericContext);

			if(isEventHandler){
				//String mainInstanceId = getParameter(parameterMap, "mainInstanceId");
				String eventName = getParameter(parameterMap, "eventName");
				
				pm.executeEventByWorkitem(processInstance, eventName, resultPayload);
			
			}else
			if(initiate){//The case that this workitem handler should initiate the process
				if(processInstance!=null && (processInstance.trim().equals("null") || processInstance.trim().length()==0))
					processInstance = null;
				
				processInstance = pm.initializeProcess(processDefinition, processInstance);
				ProcessDefinitionRemote pdr = pm.getProcessDefinitionRemote(processDefinition);

								
				if(saveOnly)
					pm.saveWorkitem(processInstance, tracingTag, taskId, resultPayload);
				else
					pm.executeProcessByWorkitem(processInstance, resultPayload);
					

			}else if(saveOnly){
				pm.saveWorkitem(processInstance, tracingTag, taskId, resultPayload);
			}else{
				if(!isAutoComplete){
					instance.set("approvalbtn",approvalbtn);
				}				
				pm.completeWorkitem(processInstance, tracingTag, taskId, resultPayload);
			}

			String nextWorkerInfo = "";
			instance = pm.getProcessInstance(processInstance);
			List executedActivityCtxs = instance.getProcessTransactionContext().getExecutedActivityInstanceContextsInTransaction();
			
			//2009-08-10 set Instance Name
			if(InstanceName!=null && InstanceName.trim().length()>0)
				instance.setName(InstanceName);
			
			if(executedActivityCtxs!=null && executedActivityCtxs.size() > 0){
				for(int i=executedActivityCtxs.size()-1; i>-1; i--){
					ActivityInstanceContext lastActCtx = (ActivityInstanceContext)executedActivityCtxs.get(i);
					Activity lastAct = lastActCtx.getActivity();
					if(lastAct instanceof HumanActivity && lastActCtx.getInstance().isRunning(lastAct.getTracingTag())){
						RoleMapping lastWorkerRM = ((HumanActivity)lastAct).getRole().getMapping(lastActCtx.getInstance());
						if(lastWorkerRM!=null){
							lastWorkerRM.fill(instance);
							if(lastWorkerRM.equals(loggedRoleMapping)){
								String[] taskIds = ((HumanActivity)lastAct).getTaskIds(lastActCtx.getInstance());
								
								if(taskIds!=null && taskIds.length>0){
									nextUserIsCurrentUser = true;
									nextTaskId=taskIds[0];
								  //pageContext.forward(GlobalContext.WEB_CONTEXT_ROOT+"/processparticipant/worklist/workitemHandler.jsp?taskId="+taskIds[0]);
								}
							}else{
									nextWorkerInfo = GlobalContext.getLocalizedMessageForWeb("the_next_step_is", loggedUserLocale, "The next step is")+" '<b>" + lastAct+"</b>'";
									nextWorkerInfo+= GlobalContext.getLocalizedMessageForWeb("nextWorkerInfo_and", loggedUserLocale, "")+", ";
									nextWorkerInfo+= GlobalContext.getLocalizedMessageForWeb("and_the_worker_is", loggedUserLocale, "and the worker is")+" <b>";
									nextWorkerInfo+= ((HumanActivity)lastAct).getRole() + "(" +lastWorkerRM+")</b>";
									nextWorkerInfo+= GlobalContext.getLocalizedMessageForWeb("nextWorkerInfo_sentence_end", loggedUserLocale, "")+"."; 
							}
						}
					}
				}
			}

			pm.applyChanges();
			


		    if ((!saveOnly && nextUserIsCurrentUser) || isAutoComplete) {
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
		    
			if(GlobalContext.logLevelIsDebug && pm instanceof ProcessManagerBean){
				ProcessManagerBean pmb = (ProcessManagerBean)pm;
				StringBuilder debugInfo = pmb.getTransactionContext().getDebugInfo();
			
				%>

				<textarea rows="80" cols="150"><%=debugInfo%></textarea><p>

				<%
			}
			
%>

<%@include file="../wihDefaultTemplate/showSubmitResult.jsp"%>
<% 
	if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
		tx.commit();


}catch(Exception e){
	e.printStackTrace();
	
	try{
		pm.cancelChanges();
	}catch(Exception ex){}
	
	if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
		tx.rollback();

	throw e;
}finally{
	try{pm.remove();}catch(Exception exc){}	
}
%>
