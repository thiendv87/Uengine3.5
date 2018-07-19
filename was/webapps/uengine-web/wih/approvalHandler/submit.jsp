<%@include file="../wihDefaultTemplate/header.jsp"%>		
<%@page import="javax.transaction.*"%>
<%@page import="org.apache.commons.fileupload.*"%>

You've submitted data as follows:
<table><tr><td bgcolor=black>
<table cellspacing=1>

<%!

	final String fileUploadEncoding = "UTF-8";

	public String getParameter(Map parameterMap, String key){
		String[] paramPair = (String[])parameterMap.get(key);
		if(paramPair!=null && paramPair.length > 0)
			return paramPair[0];
		else
			return null;
	}
%>
<%

	Map parameterMap;

	if (FileUpload.isMultipartContent(request)){
		parameterMap = new HashMap();

		DiskFileUpload diskFileUpload = new DiskFileUpload();
		diskFileUpload.setSizeThreshold(40960);
		diskFileUpload.setSizeMax(9981920);
		diskFileUpload.setRepositoryPath("temp");
		diskFileUpload.setHeaderEncoding(fileUploadEncoding);//request.getCharacterEncoding());
		List fileItemsList = diskFileUpload.parseRequest(request);

		Iterator it = fileItemsList.iterator();
		while (it.hasNext()){
		  FileItem fileItem = (FileItem)it.next();
		  if (fileItem.isFormField()){
		    parameterMap.put(fileItem.getFieldName(), new String[]{fileItem.getString(), ""});
		  }
		  else{
		    parameterMap.put(fileItem.getFieldName(), new String[]{fileItem.getName(), ""});
		  }
		}
	}else{
		parameterMap = request.getParameterMap();
	}

	String processDefinition = getParameter(parameterMap, "processDefinition");
	String initiationProcessDefinition = getParameter(parameterMap, "initiationProcessDefinition");
	String processInstance = decode(getParameter(parameterMap, "instanceId"));
	String tracingTag = decode(getParameter(parameterMap, "tracingTag"));
	String taskId = decode(getParameter(parameterMap, "taskId"));
	boolean initiate = "yes".equals(getParameter(parameterMap, "initiate"));
	boolean isEventHandler = "yes".equals(getParameter(parameterMap, "isEventHandler"));
	Vector result = new Vector();

	%>
	<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />
	<%

	ProcessManagerRemote pm = processManagerFactory.getProcessManager();
	ProcessInstance instance = (org.uengine.util.UEngineUtil.isNotEmpty(processInstance) ? pm.getProcessInstance(processInstance) : null);
	
	boolean isValid = true;

	InitialContext context = new InitialContext();
	UserTransaction tx = (GlobalContext.useManagedTransaction ? (UserTransaction)context.lookup(GlobalContext.USERTRANSACTION_JNDI_NAME) : null);

	try{
		if(tx!=null) tx.begin();		
	
%>

<%@include file="../wihDefaultTemplate/getResult.jsp"%>

</table>
</td></tr></table>

<%
		if(isValid){




	//		pm.sendMessage(decode(request.getParameter("instanceId")), decode(request.getParameter("message")), (java.io.Serializable)result);
	
			ResultPayload resultPayload = new org.uengine.kernel.ResultPayload();
			KeyedParameter[] processVariableChanges = new KeyedParameter[result.size()];
			result.toArray(processVariableChanges);
			resultPayload.setProcessVariableChanges(processVariableChanges);
			resultPayload.setExtendedValues(new KeyedParameter[]{new KeyedParameter("TASKID", taskId)});
	System.out.println("initiate=" + initiate);
	
			if(isEventHandler){
				//String mainInstanceId = getParameter(parameterMap, "mainInstanceId");
				String eventName = getParameter(parameterMap, "eventName");

				pm.executeEventByWorkitem(processInstance, eventName, resultPayload);
			
			}else
			if(initiate){//The case that this workitem handler should initiate the process
				if(processInstance!=null && (processInstance.trim().equals("null") || processInstance.trim().length()==0))
					processInstance = null;
				
				processInstance = pm.initializeProcess(processDefinition, processInstance);
				Map genericContext = new HashMap();
				genericContext.put(HumanActivity.GENERICCONTEXT_CURR_LOGGED_ROLEMAPPING, loggedRoleMapping);
				pm.setGenericContext(genericContext);
				ProcessDefinitionRemote pdr = pm.getProcessDefinitionRemote(processDefinition);

				Role[] roles = pdr.getRoles();
				WebInputter inputterForRoleMapping = (WebInputter)ObjectType.getDefaultInputter(RoleMapping.class); 
				for(int i=0; i<roles.length; i++){
					String key = roles[i].getName().replace(' ', '_');
					
					RoleMapping roleMapping = (RoleMapping)inputterForRoleMapping.createValueFromHTTPRequest(parameterMap, "rolemappings", key, null);

					if(roleMapping!=null && roleMapping.getEndpoint()!=null){
						roleMapping.setName(roles[i].getName());
						pm.putRoleMapping(processInstance, roleMapping);
					}
				}
				
//				 approval
				ProcessDefinition processDefinitionObject = pm.getProcessDefinition(processDefinition);
				

				String approvalLineActivityTT = request.getParameter("approvalLineActivityTT");
				ApprovalLineActivity approvalLineActivity = (ApprovalLineActivity)processDefinitionObject.getActivity(approvalLineActivityTT);

				String[] approvalLineInStr = request.getParameterValues("approvalLine");
				ApprovalActivity draftActivity = approvalLineActivity.getDraftActivity();
				for(int i=0; i<approvalLineInStr.length; i++){
					String approvalInfo = approvalLineInStr[i];
					String[] approvalInfos = approvalInfo.split(";");
					String userName = approvalInfos[0];
					String endpoint = approvalInfos[1];

					ApprovalActivity approvalActivity = (ApprovalActivity)approvalLineActivity.getDraftActivity().clone();
					approvalActivity.setName(draftActivity.getName() + "(Approve" + (i+1) + ")");
					approvalActivity.setTracingTag(null);  //let it auto-generated
					approvalActivity.setRole(null);
					
					for(int j=0; j<approvalActivity.getParameters().length; j++){
						approvalActivity.getParameters()[j].setDirection(ParameterContext.DIRECTION_IN);
					}
					//approvalActivity.setParameters(approvalLineActivity.getDraftActivity().getParameters());
					

					RoleMapping approver = RoleMapping.create();
					approver.setEndpoint(endpoint);
					approver.setResourceName(userName);

					approvalActivity.setApprover(approver);

					approvalLineActivity.addChildActivity(approvalActivity);
				}

				pm.changeProcessDefinition(processInstance, processDefinitionObject);

//	 approval
				
				pm.executeProcessByWorkitem(processInstance, resultPayload);
			}else{
//				 approval
				ProcessDefinition processDefinitionObject = pm.getProcessDefinition(processDefinition);

				String approvalLineActivityTT = request.getParameter("approvalLineActivityTT");
				ApprovalLineActivity approvalLineActivity = (ApprovalLineActivity)processDefinitionObject.getActivity(approvalLineActivityTT);
				String apprStat = request.getParameter("apprStat");
				if( "draft".equals(apprStat) ){
					String[] approvalLineInStr = request.getParameterValues("approvalLine");
					ApprovalActivity draftActivity = approvalLineActivity.getDraftActivity();
					approvalLineActivity.getChildActivities().clear();
					approvalLineActivity.addChildActivity(draftActivity);
					for(int i=0; i<approvalLineInStr.length; i++){
						String approvalInfo = approvalLineInStr[i];
						String[] approvalInfos = approvalInfo.split(";");
						String userName = approvalInfos[0];
						String endpoint = approvalInfos[1];
	
						ApprovalActivity approvalActivity = (ApprovalActivity)approvalLineActivity.getDraftActivity().clone();
						approvalActivity.setName(draftActivity.getName() + "(Approve" + (i+1) + ")");
						approvalActivity.setTracingTag(null);  //let it auto-generated
						approvalActivity.setRole(null);
						for(int j=0; j<approvalActivity.getParameters().length; j++){
							approvalActivity.getParameters()[j].setDirection(ParameterContext.DIRECTION_IN);
						}
						
	
						RoleMapping approver = RoleMapping.create();
						approver.setEndpoint(endpoint);
						approver.setResourceName(userName);
	
						approvalActivity.setApprover(approver);
	
						approvalLineActivity.addChildActivity(approvalActivity);
					}
	
					pm.changeProcessDefinition(processInstance, processDefinitionObject);
					
					pm.completeWorkitem(processInstance, tracingTag, taskId, resultPayload);
				}else if( "approve".equals(apprStat) ){
					((ApprovalActivity)processDefinitionObject.getActivity(tracingTag)).setApprovalStatus(pm.getProcessInstance(processInstance),ApprovalActivity.SIGN_APPROVED);
					pm.completeWorkitem(processInstance, tracingTag, taskId, resultPayload);
				}else if( "arbitraryApprove".equals(apprStat) ){
					((ApprovalActivity)processDefinitionObject.getActivity(tracingTag)).arbitraryApprove(pm.getProcessInstance(processInstance));
				}else if( "reject".equals(apprStat) ){
					((ApprovalActivity)processDefinitionObject.getActivity(tracingTag)).rejectApprove(pm.getProcessInstance(processInstance));
				}
//	 approval				
				//pm.completeWorkitem(processInstance, tracingTag, taskId, resultPayload);
			}

			String nextWorkerInfo = "";
			instance = pm.getProcessInstance(processInstance);
			List executedActivityCtxs = instance.getProcessTransactionContext().getExecutedActivityInstanceContextsInTransaction();
			if(executedActivityCtxs!=null && executedActivityCtxs.size() > 0){
				for(int i=executedActivityCtxs.size()-1; i>0; i--){
					ActivityInstanceContext lastActCtx = (ActivityInstanceContext)executedActivityCtxs.get(i);
					Activity lastAct = lastActCtx.getActivity();
					if(lastAct instanceof HumanActivity){
						RoleMapping lastWorkerRM = ((HumanActivity)lastAct).getRole().getMapping(instance);
						if(lastWorkerRM!=null){
							nextWorkerInfo = "<br>The next step is '<b>" + lastAct + "</b>' and the worker is <b>"+lastWorkerRM+"</b>.";
						}
					}
				}
				
			}





			pm.applyChanges();
			pm.remove();	
		


%>
<h1><font color=green>		Workitem has been successfully completed. </font></h1><%=nextWorkerInfo%>
<%	}else{%>
		Oops!, Some invalid values! go back and submit again.
<%	}

	if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
		tx.commit();
	
%>
	
<% 
	
}catch(Exception e){
	e.printStackTrace();
	
	if(tx!=null && tx.getStatus() != Status.STATUS_NO_TRANSACTION )
		tx.rollback();
	throw e;
}
%>		