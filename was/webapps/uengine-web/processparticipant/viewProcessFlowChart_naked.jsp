<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />
<LINK href="../style/uengine.css" type=text/css rel=stylesheet>
<link rel="stylesheet" type="text/css" href="/html/skin/color/01/en_US.css">

<%
ProcessManagerRemote pm = null;
try{
	pm = processManagerFactory.getProcessManagerForReadOnly();
	
	String pdver = request.getParameter("definitionVersionId");
	String pi = request.getParameter("instanceId");
	String pipedLabels = request.getParameter("labels");
	String segment = request.getParameter("segment");
	String currnetActTracingTag = request.getParameter("currnetActTracingTag");
	if(pipedLabels!=null) 
		pipedLabels = new String(request.getParameter("labels").getBytes("8859_1"), "UTF-8");
	//String pipedLabels = decode(request.getParameter("labels"));
	String parentTracingTag = request.getParameter("parentTracingTag");

	Hashtable options = new Hashtable();
	if(parentTracingTag !=null && currnetActTracingTag !=null){
		options.put("viewOnlyScopeTracingTag",parentTracingTag);
	}
	if(currnetActTracingTag !=null){
		options.put("highlight",currnetActTracingTag);
	}
	
	
	options.put("decorated", new Boolean(true));
	options.put("nowrap", new Boolean(true));
	options.put("imagePathRoot", GlobalContext.WEB_CONTEXT_ROOT + "/processmanager/");
	options.put("locale", loggedUserLocale);
	options.put("subProcessDrillingDown_By_PopingUp", new Boolean(true));
	
	if(segment!=null)
		options.put("viewOnlyScopeIndex", segment);

	ArrayList parentTracingTags = new ArrayList();
	if(parentTracingTag!=null){
		
		String [] tracingTags = parentTracingTag.split("_");
		
		for(int i=0; i<tracingTags.length; i++)
			parentTracingTags.add(tracingTags[i]);
		
		options.put("parentTracingTag", parentTracingTags);
	}
	
	String chart ="no chart is available";

	if(pi!=null){
		String[] instanceIds = pi.split(";");
		String[] labels = (pipedLabels!=null  ? pipedLabels.split(";") : new String[]{""});

		for(int i=0; i<instanceIds.length; i++){
			if(i>0){
				%><table width=100 cellpadding=20 cellspacing=0><td bgcolor=gray height=1></td></table><%
				List anotherParentTracingTag = ((List)(parentTracingTags.clone()));
				anotherParentTracingTag.add(""+i);
				options.put("parentTracingTag", anotherParentTracingTag);//separates by providing another tracingtag space
			}
			String label = labels[i];
			String instanceId = instanceIds[i];
System.out.println("    instanceId[i] = " + instanceId);
			chart = pm.viewProcessInstanceFlowChart(instanceId, options);
			%><b><%=label%></b><br><%=chart%><%
		}
	}else{
		chart = pm.viewProcessDefinitionFlowChart(pdver, options);
		System.out.println(chart);
		%><%=chart%><%
	}
}finally{
	try{pm.remove();}catch(Exception e){}
}
%>