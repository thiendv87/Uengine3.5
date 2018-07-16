<html>
<head>

<%@include file="../../common/header.jsp"%>
<%@page import="org.uengine.persistence.dao.*"%>
<%@page import="org.uengine.util.dao.*"%>
<%@page import="org.uengine.webservices.worklist.*"%>
<%@include file="../../common/getLoggedUser.jsp"%>

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />
<%

	ProcessManagerRemote pm = processManagerFactory.getProcessManagerForReadOnly();
try{
	Map parameterMap = null;
	String tool;

	String eventName = request.getParameter("eventName");
	String instanceId = request.getParameter("instanceId");
	String triggerActivityTracingTag = request.getParameter("tracingTag");

	EventHandler[] ehs = pm.getEventHandlersInAction(instanceId);
	EventHandler theEventHandler = null;
	for(int i=0; i<ehs.length; i++){
		if(ehs[i].getName().equals(eventName)){
			theEventHandler = ehs[i];
			break;
		}
	}
	
	ProcessInstance instance = pm.getProcessInstance(instanceId);
	Activity handlerActivity = theEventHandler.getHandlerActivity();
	HumanActivity humanActivity = null;
	String absoluteTracingTag = null;
	String processDefinitionId = null;

	if(handlerActivity instanceof SubProcessActivity){
			
		SubProcessActivity subProcessActivity = (SubProcessActivity)theEventHandler.getHandlerActivity();
		String subProcessDefinitionVersionId = subProcessActivity.getDefinitionVersionId(instance);
		
		System.out.println("==========================================================================");
		System.out.println("subProcessActivity Name: " + subProcessActivity.getName().getText());
		System.out.println("==========================================================================");		
		
		ProcessDefinition subProcessDefinition = pm.getProcessDefinition(subProcessDefinitionVersionId);
		ActivityReference initiatorHumanActivityReference = subProcessDefinition.getInitiatorHumanActivityReference(instance.getProcessTransactionContext());
		
		humanActivity = (HumanActivity)initiatorHumanActivityReference.getActivity();
		
		absoluteTracingTag = initiatorHumanActivityReference.getAbsoluteTracingTag();
		processDefinitionId = subProcessDefinitionVersionId;
		
	}else if(handlerActivity instanceof HumanActivity){
		humanActivity = (HumanActivity)handlerActivity;
		absoluteTracingTag = humanActivity.getTracingTag();
		processDefinitionId = instance.getProcessDefinition().getId();
		
	}else if(handlerActivity instanceof ComplexActivity){
		ComplexActivity complexActivity = ((ComplexActivity)handlerActivity);
		ActivityReference initiatorHumanActivityReference = complexActivity.getInitiatorHumanActivityReference(instance.getProcessTransactionContext());
		
		humanActivity = (HumanActivity)initiatorHumanActivityReference.getActivity();
		absoluteTracingTag = humanActivity.getTracingTag();
		processDefinitionId = instance.getProcessDefinition().getId();
	}

	parameterMap = humanActivity.createParameter(null);
	tool = humanActivity.getTool();
%>
</head>
<body onload="document.forms[0].submit()">
<form action="../../wih/<%=tool%>/showFormContext.jsp" method="POST" target="iframeWihContent">

<%
	for(Iterator iter = parameterMap.keySet().iterator(); iter.hasNext();) {
		String key = (String)iter.next();
		String value = (String)parameterMap.get(key);
		
		//overrides the tracingtag value to absolute one
		if(KeyedParameter.TRACINGTAG.equals(key)){
			value = absoluteTracingTag;
		}
		
		value=value.replace('\"','\'');
		
				%>
				<input type="hidden" name="<%=key%>" value="<%=value%>" />
				<%
	}	
%>

Loading workitem handler...<br>
click <input type="submit" value="here"> if the handler is not located.
<input type="hidden" name="isEventHandler" value="yes" />	
<input type="hidden" name="instanceId" value="<%=instanceId%>" />	
<input type="hidden" name="triggerActivityTracingTag" value="<%=triggerActivityTracingTag%>" />	
<input type="hidden" name="eventName" value="<%=eventName %>" />	
<input type="hidden" name="processDefinition" value="<%=processDefinitionId %>" />	

</form>
</body>
<%
}catch(Exception e){
	if(pm != null) try{pm.remove();}catch(Exception ex){}
	throw e;
}finally{
	if(pm != null) try{pm.remove();}catch(Exception ex){}
}
%>
</html>