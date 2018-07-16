<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="../wihDefaultTemplate/header.jsp"%>
<%@page import="org.uengine.contexts.HtmlFormContext" %>
<%@page import="org.uengine.contexts.MappingContext" %>
<%@page import="com.brainnet.bpm.XONEConstants" %>
<%@page import="com.brainnet.bpm.form.wih.FormUtil" %>

<form>

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
try{
	instanceId = decode(request.getParameter("instanceId"));
	//processDefinition = decode(request.getParameter("processDefinition"));
	tracingTag = request.getParameter("tracingTag");
	//initiate = "yes".equals(request.getParameter("initiate")) || "yes".equals(request.getParameter("isEventHandler"));
	
	ProcessInstance instance = pm.getProcessInstance(instanceId);
	ProcessDefinition procDef = (ProcessDefinition)pm.getProcessDefinitionWithInstanceId(instanceId);
	processDefinition = procDef.getId();
	FormActivity formActivity = (FormActivity)procDef.getActivity(tracingTag);
	
	HtmlFormContext formContext = (HtmlFormContext)(formActivity.getVariableForHtmlFormContext().get(instance, ""));
	String formDefId = formContext.getFormDefId();
	String formInstanceFilePath = formContext.getFilePath();
	
//------------- pass values to submit.jsp -------------------//

%>	
	<input type=hidden value='<%=decode(request.getParameter("instanceId"))%>' name=instanceId>
	<input type=hidden value='<% //request.getParameter("message")%>' name=message>
	<input type=hidden value='<%=decode(request.getParameter("processDefinition"))%>' name=processDefinition>
	<input type=hidden value='<%=request.getParameter("tracingTag")%>' name=tracingTag>
	<input type=hidden value='<%=request.getParameter("taskId")%>' name=taskId>
	<input type=hidden value='<% //request.getParameter("initiate")%>' name=initiate>
<%
//------------- show flow chart -------------------//


	Hashtable options = new Hashtable();
	options.put("decorated", "yes");
	options.put("nowrap", "yes");
	options.put("locale", loggedUserLocale);
	options.put("imagePathRoot", "../../processmanager/");
	
	String chart;

//	if(initiate)
//		chart = pm.viewProcessDefinitionFlowChart(processDefinition, options);	
//	else
		chart = pm.viewProcessInstanceFlowChart(instanceId, options);	
%>

<%=chart %>
<p>
	<!-- ....Form Dispatch Part.... -->
<%
	String[] defIdAndVersionId = formDefId.split("@");
	String formPath = defIdAndVersionId[1] + ".html";
	out.flush();
	System.out.println("formPath : " + formPath);
	String formJSP = XONEConstants.FORM_CONTEXT_PATH+"/"+ formPath;
	
	File contextDir = new File(request.getRealPath(XONEConstants.FORM_CONTEXT_PATH));
	FormUtil.copyToContext(contextDir, formPath);
	
	RequestDispatcher rdIncludeAction = request.getRequestDispatcher(formJSP);
	rdIncludeAction.include(request, response);
	out.flush();
%>
<!-- .... Binding with ProcessVariable to FormField Part.... -->
<%
	System.out.println(">>>>>>>>>>>formInstanceFilePath : " + formInstanceFilePath);
	HashMap valueMap = new HashMap();
	if(formInstanceFilePath != null){
		FileInputStream fis = new FileInputStream(formInstanceFilePath);
		valueMap = (HashMap)GlobalContext.deserialize(fis, HashMap.class);
	}
	
	MappingContext mappingContext = (MappingContext)pm.getActivityProperty(processDefinition, tracingTag, "mappingContext");
	ParameterContext[] params = mappingContext.getMappingElements();//getVariableBindings();
	if(params!=null){
		out.println("<script>");
		out.println("function init(){");
		for (int i = 0; i < params.length; i++) {
			ParameterContext param = params[i];

			String sourceProcessVariable = param.getVariable().getName();
			String targetFormField = param.getArgument().getText();
			
			targetFormField = targetFormField.replace('.','@');
			String [] targetFormFieldName = targetFormField.split("@");
			
			if(formInstanceFilePath != null){
				out.println("	document.all."+targetFormFieldName[1]+".value = '"+(String)valueMap.get(targetFormFieldName[1])+"';");
			}else{
				out.println("	document.all."+targetFormFieldName[1]+".value = '"+pm.getProcessVariable(instanceId,"",sourceProcessVariable)+"';");
			}
		}
		out.println("}");
		out.println("init();");
		out.println("</script>");
	}
	
	
	pm.applyChanges();
}catch(Exception e){
	pm.cancelChanges();
	throw e;
}
%>
</form>