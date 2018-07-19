<%@page import="org.uengine.util.*,org.uengine.kernel.*, org.uengine.processmanager.*, org.uengine.contexts.*, java.io.*, java.util.*"%>
<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" /><%

	response.setContentType("text/xml; charset=UTF-8");
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server

	ProcessManagerRemote pm = null;
	
	try{
	
		pm = processManagerFactory.getProcessManagerForReadOnly();
		String instanceId = request.getParameter("instanceId");
		if(UEngineUtil.isNotEmpty(instanceId)) {
			String tracingTag = request.getParameter("tracingTag");
			ProcessInstance pi = pm.getProcessInstance(instanceId);
			ProcessDefinition pd = pi.getProcessDefinition();
			OfficeDocumentActivity activity = (OfficeDocumentActivity)pd.getActivity(tracingTag);
			Map mappedResult = activity.getMappedResult(pi);
			
			GlobalContext.serialize(mappedResult, response.getOutputStream(), Map.class);
		} else {
			Map mappedResult = new HashMap();
			
			GlobalContext.serialize(mappedResult, response.getOutputStream(), Map.class);
		}
	}finally{
		pm.remove();
	}
%>