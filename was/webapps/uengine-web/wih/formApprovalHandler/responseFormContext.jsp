
	<%@page import="org.uengine.contexts.HtmlFormContext" %>
	<%@page import="org.uengine.contexts.MappingContext" %>
	<%@page import="org.uengine.formmanager.FormUtil" %>
	<%@page import="org.uengine.util.*" %> 
	
	<%@include file="../../common/header.jsp"%>
	<%@include file="../../common/getLoggedUser.jsp"%>
	<%@include file="../wihDefaultTemplate/definition.jsp"%>
	<%@include file="../wihDefaultTemplate/initialize.jsp"%>
	
	<div align="center">
<%
try {
	isMine = initiate || "yes".equals(request.getParameter("isMine"));
	ProcessInstance instance = piRemote;
	FormActivity formActivity = (FormActivity)initiationActivity;

	HtmlFormContext formContext = initiate ? (HtmlFormContext)(formActivity.getVariableForHtmlFormContext().getDefaultValue()) : (HtmlFormContext)(formActivity.getVariableForHtmlFormContext().get(instance, ""));
	String formDefId = formContext.getFormDefId();
	
	if(instance != null)
		request.setAttribute("instance", instance);
	if(pm != null)
		request.setAttribute("pm", pm);
	if(formActivity != null)
		request.setAttribute("formActivity", formActivity);
	if(loggedRoleMapping != null)
		request.setAttribute("loggedRoleMapping", loggedRoleMapping);
		
	String improve_process_defverid = decode(request.getParameter("improve_process_defverid"));
	String improve_process_name = "";
	if(UEngineUtil.isNotEmpty(improve_process_defverid)){
		request.setAttribute("improve_process_defverid", improve_process_defverid);
		ProcessDefinitionRemote processDefinitionRemote = pm.getProcessDefinitionRemote(improve_process_defverid);
		improve_process_name = processDefinitionRemote.getName().getText(loggedUserLocale);
		request.setAttribute("improve_process_name" , improve_process_name);
	}	
			
	final Map mappedResult = formActivity.getMappedResult(instance);
	request.setAttribute("mappingResult", mappedResult);
	
	String[] defIdAndVersionId = formDefId.split("@");
	String currProductionFormDefId = pm.getProcessDefinitionProductionVersion(defIdAndVersionId[0]);// + "_write.jsp"; 
	String formFileName = currProductionFormDefId; 
%>

	<!-- ....Form Dispatch Part.... -->
	<%@include file="../wihDefaultTemplate/returnIfNotRunning.jsp"%>
	<table width="100%" border="0" cellspacing="0" cellpadding="4">
	<% if (isRacing) { %>
		<tr height="1">
			<td align="center" bgcolor='yellow'>
				<strong>
				<%=GlobalContext.getLocalizedMessageForWeb("accept_desc", loggedUserLocale, "You need to accept this workitem since users are racing to handle this workitem.") %>
				</strong>
			</td>
		</tr>
	<% } %>
		<tr><td>
	<%
		out.flush();
	
		boolean wasIsJBoss = "JBOSS".equals(GlobalContext.getPropertyString("was.type", "TOMCAT"));
	
		//System.out.println("-------#------------" + GlobalContext.WEB_CONTEXT_ROOT.substring(GlobalContext.WEB_CONTEXT_ROOT.substring(1).indexOf("/")+1));
		
		//String cachedFormRoot = (wasIsJBoss ? GlobalContext.WEB_CONTEXT_ROOT : "") + "/wih/formHandler/cachedForms/";
		String cachedFormRoot = "/wih/formHandler/cachedForms/";
		
		File contextDir = new File(request.getRealPath(cachedFormRoot));
		
		
		FormUtil.copyToContext(contextDir, formFileName);
	
		RequestDispatcher rdIncludeAction = request.getRequestDispatcher(cachedFormRoot + formFileName + (isViewMode ? "_formview.jsp" : "_write.jsp"));
		request.setAttribute("isViewMode", isViewMode);
		rdIncludeAction.include(request, response);
		out.flush();
	
	%>
		</td></tr>
	</table>
	
	<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		try{pm.cancelChanges();}catch(Exception ex){}
		try{pm.remove();}catch(Exception ex){}
	}
	%>
	
	</div>
<br /><br />
