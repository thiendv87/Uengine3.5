<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="org.uengine.contexts.HtmlFormContext" %>
<%@page import="org.uengine.contexts.MappingContext" %>
<%@page import="org.uengine.formmanager.FormUtil" %>
<%@page import="org.uengine.util.*" %> 
<html>
<head>
	<%@include file="../../common/header.jsp"%>
	<%@include file="../../common/getLoggedUser.jsp"%>
	<%@include file="../../common/styleHeader.jsp"%>
	<%//@include file="../wihDefaultTemplate/header.jsp"%>
	<%@include file="../wihDefaultTemplate/definition.jsp"%>
	<%@include file="../wihDefaultTemplate/initialize.jsp"%>
	<%@include file="../../scripts/importCommonScripts.jsp" %>
	
	<script type="text/javascript" src="../../scripts/formValidation.js"></script>
	
	<jsp:include page="../../scripts/formActivity.js.jsp" flush="false">
		<jsp:param name="rmClsName" value="<%=rmClsName%>" />
	</jsp:include>
	
	
	
	<script type="text/javascript" src="../../scripts/showFormContext.js"></script>
	<script type="text/javascript">
	<% if (!piRemote.isNew()) { %>
		$("#spanInstanceName", top.document).html("(<%=piRemote.getName()%>)");
	<% } %>
		$(document).ready(function(){
			setDefaultValue();
			setMainFormTarget();
			setCalender(LOGGED_USER_LOCALE);
			try {
				<% if (!isViewMode && isRacing) { %>
				$("#disableLayer").dialog({
					autoOpen : false,
					modal : true,
					resizable : true,
					width : '600px',
					//height : '200px',
					closeOnEscape : false,
					buttons : {
						'Accept' : function() { acceptWorkitem(); },
						'Cancel' : function() { window.parent.close(); }
					}
				});
				
				$("#disableLayer").dialog("open");
				$(".ui-dialog-titlebar-close").bind('click', function(){
					window.parent.close();
				});
				<% } %>
				onLoadForm();
			} catch(e) {}
		});
	</script>
</head>
<body style="overflow:auto; text-align: center;">
	<% 
		String width = GlobalContext.getPropertyString("wih.content.width");
		String divWidth = UEngineUtil.isNotEmpty(width) ? (Integer.parseInt(width) + 60) + "px" : "98%"; 
	%>
	<div align="center"><div style="width: <%=divWidth %>;">
	
	<iframe name="messageFrameName" id="messageFrame" width="100%" height="0" border="0" 
		frameborder="0" scrolling="auto" marginheight="0" marginwidth="0"  src="about:blank">
	</iframe>
	<%@include file="../wihDefaultTemplate/showFormContextHeader.jsp"%>
	<form name="mainForm" action="submit.jsp" method="post" onsubmit="checkTitles(this);"  target="messageFrameName">
	
	
<%
try {
	
	isMine = initiate || "yes".equals(request.getParameter("isMine"));
	ProcessInstance instance = piRemote;

//	ProcessDefinition procDef = (ProcessDefinition)pm.getProcessDefinition(initiationProcessDefinition);
	FormActivity formActivity = (FormActivity)initiationActivity;
	
	if(Activity.STATUS_RUNNING.equals(formActivity.getStatus(instance)) || Activity.STATUS_TIMEOUT.equals(formActivity.getStatus(instance))){
	
		HtmlFormContext formContext = 
				initiate 
				? (HtmlFormContext)(formActivity.getVariableForHtmlFormContext().getDefaultValue()) 
				: (HtmlFormContext)(formActivity.getVariableForHtmlFormContext().get(instance, ""))
		;
		String formDefId = formContext.getFormDefId();
		
		if (instance != null)
			request.setAttribute("instance", instance);
		if (pm != null)
			request.setAttribute("pm", pm);
		if (formActivity != null)
			request.setAttribute("formActivity", formActivity);
		if (loggedRoleMapping != null)
			request.setAttribute("loggedRoleMapping", loggedRoleMapping);
			
		String improve_process_defverid = request.getParameter("improve_process_defverid");
		String improve_process_name = "";
		if(UEngineUtil.isNotEmpty(improve_process_defverid)){
			request.setAttribute("improve_process_defverid", improve_process_defverid);
			ProcessDefinitionRemote processDefinitionRemote = pm.getProcessDefinitionRemote(improve_process_defverid);
			improve_process_name = processDefinitionRemote.getName().getText(loggedUserLocale);
			request.setAttribute("improve_process_name" , improve_process_name);
		}	
		
		//strategy
		String strategyId = request.getParameter("strategyId");
		if(UEngineUtil.isNotEmpty(strategyId)){
			request.setAttribute("strategyId", strategyId);
		}	
		
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
		String currProductionFormDefId = pm.getProcessDefinitionProductionVersion(defIdAndVersionId[0]);// + "_write.jsp"; 
		String formFileName = currProductionFormDefId; 
	%>
	
		<!-- ....Form Dispatch Part.... -->
		
		<%--@include file="../wihDefaultTemplate/returnIfNotRunning.jsp"--%>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
			<tr>
				<td width="26" height="14"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/formContextConBoxMo01.gif"  /></td>
				<td width="4" background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/formContextConBoxLineT.gif"></td>
				<td background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/formContextConBoxLineT.gif"></td>
				<td width="30"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/formContextConBoxMo02.gif"  /></td>
			</tr>
			<tr>
				<td background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/formContextConBoxLineL.gif"></td>
				<td></td>
				<td align="center" style="padding:20px 0 ;">
		<% 
			divWidth = UEngineUtil.isNotEmpty(width) ? (Integer.parseInt(width)) + "px" : "98%"; 
		%>
					<div id="inputLayer" style="text-align: left;width: <%=divWidth %>;">
		<% if (!isViewMode && isRacing) { %>
				<div id="disableLayer" align="center">
					<strong>
					<%=GlobalContext.getLocalizedMessageForWeb("accept_desc", loggedUserLocale, "You need to accept this workitem since users are racing to handle this workitem.") %>
					</strong>
				</div>
		<% } %>
		
		<%
			out.flush();
			String cachedFormRoot = "/wih/formHandler/cachedForms/";
			File contextDir = new File(request.getRealPath(cachedFormRoot));
			
			FormUtil.copyToContext(contextDir, formFileName);
		
			RequestDispatcher rdIncludeAction = request.getRequestDispatcher(cachedFormRoot + formFileName + (isViewMode ? "_formview.jsp" : "_write.jsp"));
			request.setAttribute("isViewMode", isViewMode);
			rdIncludeAction.include(request, response);
			out.flush();
			
		%>
					</div>
				</td>
				<td background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/formContextConBoxLineR.gif"></td>
			</tr>
			<tr>
				<td height="4"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/formContextConBoxMo04.gif"  /></td>
				<td width="4" background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/formContextConBoxLineB.gif"></td>
				<td background="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/formContextConBoxLineB.gif"></td>
				<td><img src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/images/Common/formContextConBoxMo03.gif"  /></td>
			</tr>
		</table>
		
	    <%@include file="../wihDefaultTemplate/showTags.jsp"%>
		<%@include file="../wihDefaultTemplate/showActions.jsp"%><br />
		<%@include file="../wihDefaultTemplate/passValues.jsp"%>
		<input type="hidden" value='<%=loggedUserId%>' name='userId'/>
		
		<%
	
	}
	
}catch(Exception e){
	
/*	out.print("<b>Error Form, Modify the form.</b><br/><br/>");
	java.util.regex.Pattern pattern = java.util.regex.Pattern.compile("\\d\\:");
    for ( String splittedString : e.getMessage().split(pattern.pattern()) ) {
        out.print(splittedString + "<br />");
    }*/
    Exception exception = e;
%><%@include file="../wihDefaultTemplate/errorpage.jsp"%><%
   	//e.printStackTrace(response.getWriter());
} finally {
	try { pm.cancelChanges(); } catch(Exception ex) {}
	try { pm.remove(); } catch(Exception ex) {}
}
	%>
		<input type="hidden" name="saveOnly">
	</form>
	
	<form name='hiddenForm' id="hiddenForm" method="post">
		<input type="hidden" name="value">
	</form>
</div></div>
</body>
</html>