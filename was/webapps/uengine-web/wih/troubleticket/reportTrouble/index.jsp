<%@include file="../../wihDefaultTemplate/header.jsp"%>		

<form action=submit.jsp method=POST>

<LINK type="text/css" rel="stylesheet" href="<%=GlobalContext.WEB_CONTEXT_ROOT %>/style/flowchart.css">

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%
//------------- declaration & initialize -------------------//
	ProcessManagerRemote pm;
	String instanceId;
	String processDefinition;
	String tracingTag;
	boolean initiate;
	ProcessDefinitionRemote pdr = null;

	pm = processManagerFactory.getProcessManager();

	instanceId = decode(request.getParameter("instanceId"));
	processDefinition = decode(request.getParameter("processDefinition"));
	tracingTag = request.getParameter("tracingTag");
	initiate = "yes".equals(request.getParameter("initiate")) || "yes".equals(request.getParameter("isEventHandler"));

//------------- pass values to submit.jsp -------------------//

%>	
	<input type=hidden value='<%=decode(request.getParameter("instanceId"))%>' name=instanceId>
	<input type=hidden value='<%=request.getParameter("message")%>' name=message>
	<input type=hidden value='<%=decode(request.getParameter("processDefinition"))%>' name=processDefinition>
	<input type=hidden value='<%=request.getParameter("tracingTag")%>' name=tracingTag>
	<input type=hidden value='<%=request.getParameter("taskId")%>' name=taskId>
	<input type=hidden value='<%=request.getParameter("initiate")%>' name=initiate>
	
<%
//------------- show flow chart -------------------//

	Hashtable options = new Hashtable();
	options.put("decorated", "yes");
	options.put("nowrap", "yes");
	options.put("locale", loggedUserLocale);
	options.put("imagePathRoot", "../../../processmanager/");
	
	String chart;

	if(initiate)
		chart = pm.viewProcessDefinitionFlowChart(processDefinition, options);	
	else
		chart = pm.viewProcessInstanceFlowChart(instanceId, options);	
%>

<%=chart %>
<p>
	<table>
	<tr>
	<td>Class of Trouble :</td><td><input name="trouble_class" type="text" value="" size="50"></td>
	</tr><tr>
	<td>Description :</td><td><input name="trouble_desc" type="text" value="" size="50"></td>
	</tr>
	</table>
	
<p>
	<input type=submit value="Complete">

</form>