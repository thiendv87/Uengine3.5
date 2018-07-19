<form action=submit.jsp method=POST>

<input type=hidden value='<%=request.getParameter("instanceId")%>' name=instanceId>
<input type=hidden value='<%=request.getParameter("message")%>' name=message>
<input type=hidden value='<%=request.getParameter("processDefinition")%>' name=processDefinition>
<input type=hidden value='<%=request.getParameter("tracingTag")%>' name=tracingTag>

<%
//----------------------------------------------------------------------
// view current status of the workitem
//----------------------------------------------------------------------

	//use attribute 
	/*
	String instanceId = request.getAttribute("instanceId");
	String processDefinition = request.getAttribute("processDefinition");
	String tracingTag = request.getAttribute("tracingTag");*/

	String instanceId = request.getParameter("instanceId");
	String processDefinition = request.getParameter("processDefinition");
	String tracingTag = request.getParameter("tracingTag");

	InitialContext context = new InitialContext();
	ProcessManagerHomeRemote pmh = (ProcessManagerHomeRemote)context.lookup("ProcessManagerHomeRemote");
	ProcessManagerRemote pm = pmh.create();

	String status = pm.getActivityStatus(instanceId, tracingTag);
	
	if(status.equals("Running")){
//======================================================================
%>

<h1>Process:</h1>
<%
	Hashtable options = new Hashtable();
	String chart = pm.viewProcessInstanceFlowChart(instanceId, options);
	chart = chart.replaceAll("images/", "../../processmanager/images/");
%>
<ul>

<table cellpadding=1 cellspacing=0 border=0><tr><td bgcolor=d0d0d0><table cellpadding=0 border=0 cellspacing=0><tr><td bgcolor=fcfcfc>

<%=chart%>

<%
	ProcessDefinitionRemote pdr;	
	pdr = pm.getProcessDefinitionRemoteWithInstanceId(instanceId);
	if(pdr.isAdhoc()){
		%><input value="Edit" type=button onclick="location='/html/uengine-web/processmanager/ProcessDesigner_JNLP.jsp?processInstance=<%=instanceId%>&processDefinition=<%=pdr.getName()%>'"><i>(beta)</i><%
	}
%>

<%}else{%>

	The workitem has been closed (<%=status%>)

<%}%>

</td><td width=1></td></tr><tr><td colspan=2 height=1></td></tr></table></td></tr></table>


</ul>

<h1>TO DO:</h1>
<ul>
<table cellpadding=1 cellspacing=0 border=0><tr><td bgcolor=d0d0d0>
<table cellpadding=0 border=0 cellspacing=0>

<%
	String instruction = request.getParameter(KeyedParameter.INSTRUCTION);
	if(instruction!=null){
		instruction = new String(instruction.getBytes("8859_1"), "KSC5601");
%>
	<tr><td bgcolor=fcfcfc><%=instruction%></td></tr>
<%	}%>

<tr><td bgcolor=fcfcfc>

<table><tr><td bgcolor=black>
<table cellspacing=1>
<%
	
	ParameterContext[] parameterContexts = (ParameterContext[])pm.getActivityProperty(processDefinition, tracingTag, "parameters");
	
	for(int j=0; j<parameterContexts.length; j++){
	
		ParameterContext parameterContext = parameterContexts[j];

        %>	<tr><td bgcolor=#aaaaaa colspan=2> <%=(parameterContext.getArgument()!=null ? parameterContext.getArgument().getText(loggedUserLocale):parameterContext.getVariable().getDisplayName().getText())%> </td></tr><%
	
		Object existingValue = pm.getProcessVariable(instanceId, "", parameterContext.getVariable().getName());	
		
		WebInputter defaultInputter = (WebInputter)parameterContext.getVariable().getInputter();
		if(defaultInputter==null){
			ObjectType outputClsTable = new ObjectType(parameterContext.getVariable().getType());
			FieldDescriptor[] arrayFieldDescriptors = outputClsTable.getFieldDescriptors();
				
			String[] columns = new String[arrayFieldDescriptors.length];	
			for(int i=0; i<arrayFieldDescriptors.length; i++){
				columns[i] = arrayFieldDescriptors[i].getName();
			}
			
			for(int i=0; i<columns.length; i++){
		    	FieldDescriptor fieldDescriptor = outputClsTable.getFieldDescriptor(columns[i]);
		        %>	<tr><td bgcolor=#aaaaff> <%=fieldDescriptor.getDisplayName()%> </td> <%
		    	
		    	WebInputter inputter = fieldDescriptor.getWebInputter();
		    	
		   		%>  <td bgcolor=white><%=inputter.getInputterHTML(parameterContext.getVariable().getName(), fieldDescriptor, existingValue, null)%></td>
		   		</tr><%
		    }
		 }else{		    	
	 		FieldDescriptor fieldDescriptor = new FieldDescriptor("value","value");
	        %>	<tr><td bgcolor=white colspan=2> 
	    	<%=defaultInputter.getInputterHTML(parameterContext.getVariable().getName(), fieldDescriptor, existingValue, null)%></td>
	   		</tr><%
		 }
	}
%>
</table>
</td></tr></table>

<input type=submit value="Complete">
</form>
</td><td width=1></td></tr><tr><td colspan=2 height=1></td></tr></table></td></tr></table>

</ul>


<%	
	String keyword = request.getParameter(KeyedParameter.KEYWORD);
/*	String actName = (String)pm.getActivityProperty(processDefinition, tracingTag, "name");
	keyword = keyword + " " + actName;*/
	if(keyword!=null && keyword.trim().length()>0){	
		keyword = keyword.replace(' ', '+');	
		keyword = new String(keyword.getBytes("8859_1"), "KSC5601");
		keyword = URLEncoder.encode(keyword);
%>
<h1>Related Knowledges:</h1>
<ul>
<table cellpadding=1 cellspacing=0 border=0 width=80%><tr><td bgcolor=d0d0d0><table cellpadding=0 border=0 cellspacing=0 width=100%><tr><td bgcolor=fcfcfc>
			<iframe frameborder=0 width=100% height=500 src="http://www.google.co.kr/search?hl=ko&q=<%=keyword%>&frm=t1"></iframe>
</td><td width=1></td></tr><tr><td colspan=2 height=1></td></tr></table></td></tr></table>
</ul>
<%	}%>
