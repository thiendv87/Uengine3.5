<%@page contentType="text/xml; charset=UTF-8" import="javax.naming.Context,javax.naming.InitialContext,javax.naming.NamingException,javax.rmi.PortableRemoteObject,org.uengine.kernel.*,org.uengine.processmanager.*"%><%
	response.setContentType("text/xml; charset=UTF-8");
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server

%><jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" /><%

	ProcessManagerRemote pm = null;
	String def = null;
	
	try{
		pm = processManagerFactory.getProcessManagerForReadOnly();
		
		String pd = request.getParameter("processDefinition");
		String versionId = request.getParameter("versionId");
		String language = request.getParameter("language");
		String instanceId = request.getParameter("instanceId");
		
		//case that find by definition id
		if(versionId==null && pd!=null){
			
		}
		
		if(instanceId!=null){
			def = pm.getProcessDefinitionWithInstanceId(instanceId, language);
		}else if(versionId==null && pd!=null){
			versionId = pm.getProcessDefinitionProductionVersion(pd);
			def = pm.getProcessDefinition(versionId, language);
		}else{
			def = pm.getProcessDefinition(versionId, language);
		}	
	}finally{
		if(pm != null) try{ pm.remove(); } catch(Exception e){}
	}

%><%=def%>