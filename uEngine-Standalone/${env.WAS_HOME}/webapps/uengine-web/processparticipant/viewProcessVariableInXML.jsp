<%@include file="../common/header.jsp"%>
<%
response.setHeader("Cache-Control", "public");
response.setHeader("Expires", "0");

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />
<%

	ProcessManagerRemote pm = processManagerFactory.getProcessManager();

	String pi = decode(request.getParameter("instanceId"));
	String variableName = decode(request.getParameter("variableName"));
	
	String value = pm.getProcessVariableInXML(pi, "", variableName);
%>		        

<%=value%>