<%@include file="../../wihDefaultTemplate/header.jsp"%>	

<form action=submit.jsp method=POST>
<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%

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

	Hashtable options = new Hashtable();
	options.put("decorated", "yes");
	options.put("nowrap", "yes");
	options.put("locale", loggedUserLocale);
	options.put("imagePathRoot", "../../../processmanager/");
	//options.put("vertical", new Boolean(true));

	
	String issueClass = (String)pm.getProcessVariable(instanceId, "", "issueClass");
	String issueContent = (String)pm.getProcessVariable(instanceId, "", "issueContent");		

	String chart;

	if(initiate)
		chart = pm.viewProcessDefinitionFlowChart(processDefinition, options);	
	else
		chart = pm.viewProcessInstanceFlowChart(instanceId, options);	
%>	
	<input type=hidden value='<%=decode(request.getParameter("instanceId"))%>' name=instanceId>
	<input type=hidden value='<%=request.getParameter("message")%>' name=message>
	<input type=hidden value='<%=decode(request.getParameter("processDefinition"))%>' name=processDefinition>
	<input type=hidden value='<%=request.getParameter("tracingTag")%>' name=tracingTag>
	<input type=hidden value='<%=request.getParameter("taskId")%>' name=taskId>
	<input type=hidden value='<%=request.getParameter("initiate")%>' name=initiate>
<%=chart %><br>

Issue Class <input type=text name=issueClass value='<%=issueClass%>'> <br>
Issue Content <input type=text name=issueContent value='<%=issueContent%>'> <br>

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
	
	document.forms[0].all[inputName+'_display'].value = userNames;
	document.forms[0].all[inputName+'_gender'].value = genders;
	document.forms[0].all[inputName+'_birthday'].value = birthdays;
	document.forms[0].all[inputName].value = userEndpoints;
	}
	
	function searchPeople(inputName){
		var orgPicker = window.open('/uengine-web/common/organizationChartPicker.jsp','_new','width=430,height=560,resizable=true,scrollbars=yes');
		orgPicker.onOk = onUserSelected;
		orgPicker.inputName = inputName;
	}
</script>

<script>function changeEncType(){document.forms[0].encoding = 'multipart/form-data'}</script>


	Right Person:<input readonly name='_rightPerson_rightPerson_display' value=''>
								<input type=hidden name='_rightPerson_rightPerson_gender' value=''>
								<input type=hidden name='_rightPerson_rightPerson_birthday' value=''>
								<input type=text editable=false name='_rightPerson_rightPerson' value=''>
								<input type=button onclick="searchPeople('_rightPerson_rightPerson')" value='...'>

<input type=submit value="Complete">

</form>