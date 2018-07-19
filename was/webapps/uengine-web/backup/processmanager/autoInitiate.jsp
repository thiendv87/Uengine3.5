<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%
	ProcessManagerRemote pm = processManagerFactory.getProcessManager();

	String procDefAlias = decode(request.getParameter("alias"));
	String req_cd = decode(request.getParameter("req_cd"));
	String endpoint = decode(request.getParameter("endpoint"));

    String processDefinition="";
	if(org.uengine.util.UEngineUtil.isNotEmpty(procDefAlias)){
		processDefinition = pm.getProcessDefinitionProductionVersionByAlias(procDefAlias);
	}

	try{
			String instId = pm.initializeProcess(processDefinition);

			RoleMapping intiator = RoleMapping.create();
			intiator.setEndpoint(endpoint);
			Map genericContext = new HashMap();
			genericContext.put(HumanActivity.GENERICCONTEXT_CURR_LOGGED_ROLEMAPPING, intiator);
			genericContext.put("request", request);
			
			pm.setGenericContext(genericContext);

			pm.executeProcess(instId);
			
			if(org.uengine.util.UEngineUtil.isNotEmpty(req_cd)){
				pm.setProcessVariable(instId,"","req_cd",req_cd);
			}
			

			pm.applyChanges();
			
			%>Process has been intialized with instance id [<%=instId%>]<%
		
	
		
	}catch(Exception e){
		try{
			pm.cancelChanges();
		}catch(Exception ex){
		}
		
		throw e;
	}finally{
		try{
			pm.remove();
		}catch(Exception ex){
		}
	}
%>
