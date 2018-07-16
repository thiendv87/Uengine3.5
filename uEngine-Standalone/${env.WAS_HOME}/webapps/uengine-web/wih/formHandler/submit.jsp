<%@ page pageEncoding="UTF-8" language="java" contentType="text/html; charset=UTF-8"%>

<%@include file="../../common/header.jsp"%>
<%@include file="../../common/getLoggedUser.jsp"%>
<%@page import="javax.transaction.*"%>
<%@page import="org.apache.commons.fileupload.*"%>
<%@page import="org.uengine.contexts.HtmlFormContext"%>

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
		
		String tags = decode(getParameter(parameterMap, "tags"));
		
		// 2009-08-07 add start
		String InstanceName = decode(getParameter(parameterMap,"name"));
		System.out.println(InstanceName);
		//add end
		
		Vector result = new Vector();
		ProcessInstance instance = (org.uengine.util.UEngineUtil.isNotEmpty(processInstance) ? pm.getProcessInstance(processInstance) : null);
		ProcessDefinition procDef = (ProcessDefinition)pm.getProcessDefinition(initiationProcessDefinition);

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
			
			} else if (initiate) {
				//The case that this workitem handler should initiate the process
				if (processInstance!=null && (processInstance.trim().equals("null") || processInstance.trim().length()==0))
					processInstance = null;
				
				processInstance = pm.initializeProcess(processDefinition, processInstance);
				ProcessDefinitionRemote pdr = pm.getProcessDefinitionRemote(processDefinition);

				
				if(saveOnly) {
					pm.saveWorkitem(processInstance, tracingTag, taskId, resultPayload);
				} else {
					pm.executeProcessByWorkitem(processInstance, resultPayload);
				}
				
				if (instance == null) {
                    instance = pm.getProcessInstance(processInstance);
                }
			} else if (saveOnly) {
				pm.saveWorkitem(processInstance, tracingTag, taskId, resultPayload);
			} else {
				pm.completeWorkitem(processInstance, tracingTag, taskId, resultPayload);
			}
			
			// add tag 2011-03-17
            com.defaultcompany.web.tag.TagDAO tagDao = new com.defaultcompany.web.tag.TagDAO();
            tagDao.setTag(instance, tags, loggedUserGlobalCom);

			String nextWorkerInfo = "";
			String nextAct = "";
			String nextWorkerRM = "";
			instance = pm.getProcessInstance(processInstance);
			List executedActivityCtxs = instance.getProcessTransactionContext().getExecutedActivityInstanceContextsInTransaction();
			
			//2009-08-10 set Instance Name
			if(InstanceName!=null && InstanceName.trim().length()>0)
				instance.setName(InstanceName);
			
			if(executedActivityCtxs!=null && executedActivityCtxs.size() > 0){
				for (int i=executedActivityCtxs.size()-1; i>-1; i--) {
					ActivityInstanceContext lastActCtx = (ActivityInstanceContext)executedActivityCtxs.get(i);
					Activity lastAct = lastActCtx.getActivity();
					
					if (lastAct instanceof HumanActivity && lastActCtx.getInstance().isRunning(lastAct.getTracingTag())) {
						RoleMapping lastWorkerRM = ((HumanActivity)lastAct).getRole().getMapping(lastActCtx.getInstance());
						
						if (lastWorkerRM != null) {
							lastWorkerRM.fill(instance);
							
							if (lastWorkerRM.equals(loggedRoleMapping)) {
								String[] taskIds = ((HumanActivity)lastAct).getTaskIds(lastActCtx.getInstance());
								
								if (taskIds != null && taskIds.length > 0){
									nextUserIsCurrentUser = true;
									nextTaskId = taskIds[0];
								}
							} else {
								nextAct = lastAct.toString();
								nextWorkerRM = lastWorkerRM.toString();
							}
						}
					}
				}
			}
			
			if(instance.isNew()){
		    	try {
					String[] taskIds =  ((HumanActivity)procDef.getActivity(tracingTag)).getTaskIds(instance);
			    	taskId = taskIds[0];
				} catch (Exception e) {
					Vector activities = instance.getCurrentRunningActivitiesDeeply();
					for (int i=0; i<activities.size(); i++) {
						ActivityInstanceContext aic = (ActivityInstanceContext) activities.get(i);
						Activity act = aic.getActivity();
						if (act instanceof HumanActivity) {
							HumanActivity humanAct = (HumanActivity) act;
							taskId = humanAct.getTaskIds(aic.getInstance())[0];
							break;
						}
					}
				}
		    }
		    
			pm.applyChanges();

			if (GlobalContext.logLevelIsDebug && pm instanceof ProcessManagerBean) {
				ProcessManagerBean pmb = (ProcessManagerBean)pm;
				StringBuilder debugInfo = pmb.getTransactionContext().getDebugInfo();
			
%>
				<textarea rows="80" cols="150"><%=debugInfo%></textarea><br /><br />
<%
			}
%>			
				<script type="text/javascript">
				var CONTEXT_ROOT = "<%=GlobalContext.WEB_CONTEXT_ROOT%>";
				function reloadWih(){
<%				
		    if(!saveOnly && nextUserIsCurrentUser) {
		    	%>
		    		var url = CONTEXT_ROOT + "/processparticipant/worklist/workitemHandler.jsp?taskId=<%=nextTaskId%>";
			    <%
		    } else {
		    	%>
					var url = CONTEXT_ROOT + "/processparticipant/worklist/workitemHandler.jsp?taskId=<%=taskId%>";
				<%
		    }
%>
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
<% 
	if (tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION)
		tx.commit();

} catch(Exception e) {
	e.printStackTrace();
	
	try {
		pm.cancelChanges();
	} catch(Exception ex) {}
	
	if (tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION)
		tx.rollback();

	throw e;
} finally {
	try {pm.remove();} catch(Exception exc) {}
}
%>
