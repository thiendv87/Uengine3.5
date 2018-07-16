<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="../wihDefaultTemplate/header.jsp"%>

<%
    request.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-cache");
%>

<%@page import="org.uengine.contexts.HtmlFormContext" %>
<%@page import="org.uengine.contexts.MappingContext" %>
<%@page import="org.uengine.formmanager.FormUtil" %>
<%@page import="org.uengine.util.*" %>

<%@page import="au.id.jericho.lib.html.FormFields"%>
<%@page import="au.id.jericho.lib.html.FormField"%>
<%@page import="au.id.jericho.lib.html.OutputDocument"%>
<%@page import="au.id.jericho.lib.html.Source"%>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" leftmargin="5" topmargin="0" marginwidth="0" marginheight="0" onload="drawLoopLines()">

<table border="0" cellpadding="0" cellspacing="0" width="100%" xmlns>
	<tr>
		<td height="28" valign="bottom">
			<p><img src="../../images/icon_root.gif" align="middle" width="10" height="11" border="0"> 
			<%=decode(request.getParameter("definitionName"))%> > <b> <%=decode(request.getParameter(KeyedParameter.TITLE))%> </b>
		</td>
	</tr>
	<tr>
		<td height="1" class="path_underline"></td>
	</tr>
</table>
 

<script type="text/javascript" src="../../scripts/formActivity.js"></script>
<body>
<form action=submit.jsp method=POST>

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />

<%
//------------- declaration & initialize -------------------//

	
	ProcessManagerRemote pm = processManagerFactory.getProcessManagerForReadOnly();

	String instanceId = decode(request.getParameter("instanceId"));
	
	String tracingTag = request.getParameter("tracingTag");


try{
	ProcessInstance instance = null;

	instance = pm.getProcessInstance(instanceId);


	ProcessDefinition procDef = instance.getProcessDefinition();
	FormActivity formActivity = (FormActivity)procDef.getActivity(tracingTag);

	HtmlFormContext formContext = (HtmlFormContext)formActivity.getVariableForHtmlFormContext().get(instance, "");
	String formDefId = formContext.getFormDefId();
	
	if(instance!=null)
		request.setAttribute("instance", instance);
	if(pm!=null)
		request.setAttribute("pm", pm);
	if(formActivity!=null)
		request.setAttribute("formActivity", formActivity);
	
	final Map mappedResult = formActivity.getMappedResult(instance);
/*	ForLoop loopForSettingAttributeValue = new ForLoop(){
		public void logic(Object value){
			String key = (String)value;
			request.setAttribute(key, mappedResult.get(key));
		}
	}.run(mappedResult.keySet());
	*/
	request.setAttribute("mappingResult", mappedResult);
	
	String[] defIdAndVersionId = formDefId.split("@");
	String formFileName = pm.getProcessDefinitionProductionVersion(defIdAndVersionId[0]);// + "_write.jsp"; 
%>
	
<table width="100%" border="0" cellspacing="0" cellpadding="4">
	<tr height="1">
		<td align="center" height="1" class="bgcolor_head_upperline"></td>
	</tr>
	<tr height="5">
		<td align="center" height="5" class="bgcolor_head"></td>
	</tr>
	<tr height="1">
		<td align="center" height="1" class="bgcolor_head_underline"></td>
	</tr>
</table>

<p>
<table width="98%" border="0" cellspacing="0" cellpadding="4">
	<tr>
		<td style="padding: 0px 0px 0px 20px;" bgcolor="white">
	<!-- ....Form Dispatch Part.... -->
<%

	out.flush();
	
	String cachedFormRoot = GlobalContext.WEB_CONTEXT_ROOT + "/wih/formHandler/cachedForms/";
	File contextDir = new File(request.getRealPath(cachedFormRoot));
	FormUtil.copyToContext(contextDir, formFileName);
	
	RequestDispatcher rdIncludeAction = request.getRequestDispatcher(cachedFormRoot+formFileName+"_formview.jsp");
	rdIncludeAction.include(request, response);
	out.flush();

/*	FileInputStream htmlFIS = null;
	Reader HtmlReader = null;
	Source source =  null;
	try {
		String formDefVerId = formActivity.getFormDefinitionVersionId(null, pm);
		String html = pm.getResource(formDefVerId);
		source = new Source(html);
		out.println(source.toString());
		out.flush();
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		if(HtmlReader != null) HtmlReader.close();
		if(htmlFIS != null) htmlFIS.close();
	}*/
%>


		</td>
	</tr>
</table>
<br>

<table border="0" cellpadding="0" cellspacing="0" width="100%" xmlns>
	<tr>
		<td height="1" class="path_underline"></td>
	</tr>
</table>



<% 
}finally{
	if(pm!=null) pm.remove();
}
%>

</form>
</body>