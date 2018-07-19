<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%
	String executionScope = request.getParameter("executionScope");
	String eventName = request.getParameter("eventName");
	String mainInstanceId = request.getParameter("instanceId");
	String strIsNew = request.getParameter("isNew");
	String initiatorHumanActivityTracingTag = request.getParameter("initiatorHumanActivityTracingTag");

	pm = processManagerFactory.getProcessManager();//ForReadOnly();

	instanceId = (request.getParameter("instanceId"));

	processDefinition = (request.getParameter("processDefinition"));
	initiationProcessDefinition = processDefinition;
	
	if(!UEngineUtil.isNotEmpty(instanceId) && !UEngineUtil.isNotEmpty(processDefinition)) return;

	tracingTag = request.getParameter("tracingTag");
	
	boolean isEventHandler = UEngineUtil.isTrue(request.getParameter("isEventHandler"));
	initiate = UEngineUtil.isTrue(request.getParameter("initiate")) || isEventHandler;
	isViewMode = UEngineUtil.isTrue(request.getParameter("isViewMode"));
	boolean isCustomizing = UEngineUtil.isTrue(request.getParameter("isCustomizing"));
	boolean isMine = isCustomizing || initiate || UEngineUtil.isTrue(request.getParameter("isMine"));
	
	String workitemHandler = request.getParameter("workitemHandler");
	
	dispatchingOption = request.getParameter(KeyedParameter.DISPATCHINGOPTION);
	
	isRacing = (""+org.uengine.kernel.Role.DISPATCHINGOPTION_RACING).equals(dispatchingOption);
	
	if(!isEventHandler && !initiate && UEngineUtil.isNotEmpty(instanceId)){
		piRemote = pm.getProcessInstance(instanceId);
		if(UEngineUtil.isNotEmpty(executionScope)){
			piRemote.setExecutionScope(executionScope);
		}
		
		initiationActivity = (HumanActivity)piRemote.getProcessDefinition().getActivity(tracingTag);
	}else
		piRemote = null;
		
	boolean isAllowAnonymous = true;
	boolean isFantomInstance = false;
	
	if(piRemote==null && !isViewMode){
		Map genericContext = new HashMap();
		genericContext.put(HumanActivity.GENERICCONTEXT_CURR_LOGGED_ROLEMAPPING, loggedRoleMapping);
		genericContext.put("request", request);
		genericContext.put("response", response);
		genericContext.put("servlet", this);
		pm.setGenericContext(genericContext);
		
					
		Vector vector=new Vector();
		
		if(isEventHandler){

			ProcessInstance mainInstance = pm.getProcessInstance(mainInstanceId);

			ProcessDefinition mainProcessDefinition = mainInstance.getProcessDefinition();
			EventMessagePayload eventMessagePayload = new EventMessagePayload();
			eventMessagePayload.setEventName(eventName);
			mainProcessDefinition.fireMessage("event", mainInstance, eventMessagePayload);
			
			//get the initiated sub process instance
			EventHandler[] ehs = pm.getEventHandlersInAction(mainInstanceId);
			EventHandler theEventHandler = null;

			if(ehs!=null)
			for(int i=0; i<ehs.length; i++){
				if(ehs[i].getName().equals(eventName)){
					theEventHandler = ehs[i];
					break;
				}
			}
			
			Activity handlerActivity = theEventHandler.getHandlerActivity();
			
			if(handlerActivity instanceof SubProcessActivity){
				SubProcessActivity subProcessActivity = (SubProcessActivity)theEventHandler.getHandlerActivity();
				ArrayList escList = mainInstance.getExecutionScopeContexts();
				ExecutionScopeContext esc = null;
				if(escList != null){
					for(int i=0; i<escList.size();i++){
						esc = (ExecutionScopeContext)escList.get(i);
						if(eventName.equals(esc.getName())) break;
					}
				}
				mainInstance.setExecutionScopeContext(esc);
				Vector idVt = subProcessActivity.getSubprocessIds(mainInstance);
				String subInstanceId = (String)idVt.get(0);
		 		piRemote = pm.getProcessInstance(subInstanceId);
				
				isFantomInstance = true;
			}
			
			vector= piRemote.getCurrentRunningActivitiesDeeply();

	}else if(UEngineUtil.isNotEmpty(instanceId) && !"true".equals(strIsNew)){
			piRemote = pm.getProcessInstance(instanceId);	
			vector= piRemote.getCurrentRunningActivitiesDeeply();
	}else{

		    ActivityReference initiatorHumanActivityReference = pm.getInitiatorHumanActivityReference(processDefinition);
		    String initiatorDefVerId = initiatorHumanActivityReference.getActivity().getProcessDefinition().getId();
			String fantomInstanceId = pm.initialize(processDefinition, instanceId, loggedRoleMapping);
	 		piRemote = pm.getProcessInstance(fantomInstanceId);
			isFantomInstance = true;
			pm.executeProcess(fantomInstanceId);
		
			vector= piRemote.getCurrentRunningActivitiesDeeply();
		}

		ActivityInstanceContext aic = (ActivityInstanceContext)vector.get(vector.size()-1);
		
		initiationActivity = (HumanActivity)aic.getActivity();
		
		initiationProcessDefinition = aic.getActivity().getProcessDefinition().getId();
		
		
		//System.out.println("initiationProcessDefinition=" + initiationProcessDefinition);
		
		
		
		//tracingTag = aic.getActivity().getTracingTag();
		piRemote = aic.getInstance();
				
		isAllowAnonymous = initiationActivity.isAllowAnonymous();
	}
	
	if(piRemote!=null){
		pdr = pm.getProcessDefinitionRemoteWithInstanceId(piRemote.getInstanceId());
		pdver = pdr.getId();
	}
	
	/* ========================================================================================== */
	if (initiate)
		currentProcessDefinition = (ProcessDefinition) pm.getProcessDefinition(initiationProcessDefinition);
	else
		currentProcessDefinition = piRemote.getProcessDefinition();
	
	currentActivity = currentProcessDefinition.getActivity(tracingTag);
	/* ========================================================================================== */

%>