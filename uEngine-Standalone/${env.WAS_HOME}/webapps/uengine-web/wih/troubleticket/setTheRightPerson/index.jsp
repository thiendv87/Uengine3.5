<%@include file="../../wihDefaultTemplate/header.jsp"%>		
<%@page import="javax.transaction.*"%>

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

<%
	String troubleClass = (String)pm.getProcessVariable(instanceId, "", "trouble_class");
	String troubleDesc = (String)pm.getProcessVariable(instanceId, "", "trouble_desc");		
%>
<script>
	function onUserSelected(selectedPeople, inputName){
		var userEndpoints = '';
		var userNames = '';
		var genders = '';
		var birthdays = '';
		var sep = '';
		for(i=0; i<selectedPeople.length; i++){
		userEndpoints += (sep + selectedPeople[i].id);		userNames += (sep + selectedPeople[i].name);		genders += (sep + selectedPeople[i].isMale);		birthdays += (sep + selectedPeople[i].birthday);		sep = ';';
		}
	document.forms[0].all['_rightPerson_rightPerson_display'].value = userNames;
	document.forms[0].all['_rightPerson_rightPerson'].value = userEndpoints;
	}
</script>

<script>function changeEncType(){document.forms[0].encoding = 'multipart/form-data'}</script>

<script>
	function searchPeople(inputName){
		var orgPicker = window.open('/uengine-web/common/organizationChartPicker.jsp?fncName=onUserSelected','_new','width=430,height=560,resizable=true,scrollbars=yes');
		//orgPicker.onOk = onUserSelected;
		orgPicker.inputName = inputName;
	}
</script>
	<table>
	<tr>
	<td>Class of Trouble :</td><td><%=troubleClass %></td>
	</tr><tr>
	<td>Description :</td><td><%=troubleDesc %></td>
	</tr><tr>
	<td>Right Person:</td><td><input readonly name='_rightPerson_rightPerson_display' value=''>
				<input type=hidden editable=false name='_rightPerson_rightPerson' value=''>
				<input type=button onclick="searchPeople('_rightPerson_rightPerson')" value='...'></td>
	</tr>
	</table>	
	
<p>	

	<input type=submit value="Complete">

</form>