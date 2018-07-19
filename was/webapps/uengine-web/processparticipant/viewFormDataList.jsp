<%@include file="../common/header.jsp"%>

<%@page import="org.uengine.contexts.HtmlFormContext" %>
<%@page import="org.uengine.formmanager.FormUtil" %>

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%
	ProcessManagerRemote pm = processManagerFactory.getProcessManagerForReadOnly();

	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server

	String pd = decode(request.getParameter("processDefinition"));
	
	System.out.println("processDefinition:"+pd);
	//replace with production version
	String pdver = null;
	if(!"".equals(pd)){
		pdver = pm.getProcessDefinitionProductionVersion(pd);
	}
	String formFileName = pdver; 
//	out.flush();
	
	boolean wasIsJBoss = "JBOSS".equals(GlobalContext.getPropertyString("was.type", "TOMCAT"));

	String cachedFormRoot = (wasIsJBoss ? GlobalContext.WEB_CONTEXT_ROOT : "") + "/wih/formHandler/cachedForms/";
	File contextDir = new File(request.getRealPath(cachedFormRoot));
	
	FormUtil.copyToContext(contextDir, formFileName);
	
//	RequestDispatcher rdIncludeAction = request.getRequestDispatcher(cachedFormRoot+formFileName+".form.jsp");
//	rdIncludeAction.include(request, response);
//	out.flush();
	String url=cachedFormRoot+formFileName+".form.jsp";
%>

<body onload="document.forms[0].submit()">
<form action="<%=url%>" method="POST">

</form>