<%@ page pageEncoding="UTF-8" language="java" contentType="text/html; charset=UTF-8"%>

<%   
	request.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-cache");
    boolean isAutoComplete = false;
%>

<html>  
<head> 
	<style type="text/css">
		body { 
			scrollbar-3dlight-color:#989898; 
			scrollbar-arrow-color:#FFFFFF;
			scrollbar-base-color:#CFCFCF;
			scrollbar-darkshadow-color:#FFFFFF;
			scrollbar-face-color:#CFCFCF;
			scrollbar-highlight-color:#FFFFFF;
			scrollbar-shadow-color:#989898;
			background:url(../../processmanager/images/empty.gif) #ffffff;
		}
	</style>
	<%@page import="org.uengine.contexts.HtmlFormContext" %>
	<%@page import="org.uengine.contexts.MappingContext" %>
	<%@page import="org.uengine.formmanager.FormUtil" %>
	<%@page import="org.uengine.util.*" %> 
	
	<%@include file="../wihDefaultTemplate/header.jsp"%>   
	<%@include file="../wihDefaultTemplate/definition.jsp"%>
	
	<link rel="stylesheet" type="text/css" href="../../style/showFormContext.css" />
	
	<script type="text/javascript" src="../../scripts/calendar.js"></script>
	<script type="text/javascript" src="../../scripts/calendar-setup.js"></script>
	<script type="text/javascript" src="../../scripts/calendar-ko-utf8.js"></script>
	<script type="text/javascript" src="../../scripts/commonScript.js"></script>
	<script type="text/javascript" src="../../scripts/formValidation.js"></script>
	
	
	<jsp:include page="../../scripts/formActivity.js.jsp" flush="false">
		<jsp:param name="rmClsName" value="<%=rmClsName%>" />
	</jsp:include>
	<script src="../../scripts/showFormContext.js" type="text/javascript" ></script> 

</HEAD>
<BODY onload="setDefaultValue();rememberRows();setMainFormTarget();try{eval('onLoadForm()');}catch(e){}" style="overflow:auto;"> 

	<form name="mainForm" action="submit.jsp" method="POST" onsubmit="return confirm('전송 하시겠습니까?');" target="messageFrameName">
	<iframe name="messageFrameName" id="messageFrame" width="100%" height="0" border="0" 
		frameborder="0" scrolling="auto" marginheight="0" marginwidth="0" >
	</iframe>
	<%@include file="../wihDefaultTemplate/showFormContextHeader.jsp"%>
	<table align="center" width="730px"><tr><td align="center">
	<%
	try {
	%>
	<%@include file="../wihDefaultTemplate/initialize.jsp"%>
	<%
		isMine = initiate || "yes".equals(request.getParameter("isMine"));
		ProcessInstance instance = piRemote;
	
	//	ProcessDefinition procDef = (ProcessDefinition)pm.getProcessDefinition(initiationProcessDefinition);
		ConfirmActivity formActivity = (ConfirmActivity)initiationActivity;
		isAutoComplete = formActivity.isAutoComplete();
		boolean isCompleted = "Completed".equals(formActivity.getStatus(instance)); 
		isViewMode = isViewMode || ((ConfirmActivity)formActivity).isViewMode() || isCompleted;
	
		HtmlFormContext formContext = initiate ? (HtmlFormContext)(formActivity.getVariableForHtmlFormContext().getDefaultValue()) : (HtmlFormContext)(formActivity.getVariableForHtmlFormContext().get(instance, ""));
		String formDefId = formContext.getFormDefId();
		 
		if(instance!=null)
			request.setAttribute("instance", instance);
		if(pm!=null)
			request.setAttribute("pm", pm);  
		if(formActivity!=null)  
			request.setAttribute("formActivity", formActivity);
		if(loggedRoleMapping!=null)
			request.setAttribute("loggedRoleMapping", loggedRoleMapping);
				
		final Map mappedResult = formActivity.getMappedResult(instance);
		
		request.setAttribute("mappingResult", mappedResult);
		
		String[] defIdAndVersionId = formDefId.split("@");
		String currProductionFormDefId = pm.getProcessDefinitionProductionVersion(defIdAndVersionId[0]);// + "_write.jsp"; 
		String formFileName = currProductionFormDefId; 
		if(!isAutoComplete) {
	%>
	
	<table width="100%" border="0" cellspacing="0" cellpadding="4">
		<tr><td style="padding: 0px 0px 0px 20px;" bgcolor="white">
				<!-- ....Form Dispatch Part.... -->
				<% if (isRacing) {	%>
				<table width="100%" border="0" cellspacing="0" cellpadding="4" align="center">
					<tr height="1">
						<td align="center" bgcolor="yellow">
							<b><%=GlobalContext.getLocalizedMessageForWeb("accept_desc", loggedUserLocale, "You need to accept this workitem since users are racing to handle this workitem.") %></b>
						</td>
					</tr>
				</table>
		</td></tr>
	</table>
			
	<%}%>
	<div align="center">
	<%
		out.flush();
	
		boolean wasIsJBoss = "JBOSS".equals(GlobalContext.getPropertyString("was.type", "TOMCAT"));
	
		//System.out.println("-------#------------" + GlobalContext.WEB_CONTEXT_ROOT.substring(GlobalContext.WEB_CONTEXT_ROOT.substring(1).indexOf("/")+1));
		
	//	String cachedFormRoot = (wasIsJBoss ? GlobalContext.WEB_CONTEXT_ROOT : "") + "/wih/formHandler/cachedForms/";
		String cachedFormRoot = "/wih/formHandler/cachedForms/";
		File contextDir = new File(request.getRealPath(cachedFormRoot));
		
		
		FormUtil.copyToContext(contextDir, formFileName);
	
		RequestDispatcher rdIncludeAction = request.getRequestDispatcher(
				cachedFormRoot + formFileName + (isViewMode? "_formview.jsp": "_write.jsp")
		);
		
		rdIncludeAction.include(request, response);
		out.flush();
	
	%>
	</div><br /><br />
	<%@include file="showAction.jsp"%><br />
	<%@include file="../wihDefaultTemplate/passValues.jsp"%>

	<%
		}
	%>
	<%@include file="../wihDefaultTemplate/passValues.jsp"%>
	<input type="hidden" name="approvalbtn">
	<input type="hidden" name="isAutoComplete" value="false">
	
	<%
		}finally{
			try{pm.cancelChanges();}catch(Exception ex){}
			try{pm.remove();}catch(Exception ex){}
		}
	%>
	</td></tr>	</table>
	<input type="hidden" name="saveOnly">
	</form>
		
	<form name="hiddenForm" method="POST">
		<input type="hidden" name="value">
	</form>

<%
	if(isAutoComplete){
%>
		<script>
			document.forms[0].isAutoComplete.value='<%=isAutoComplete%>';
			setMainFormTarget();
			document.forms[0].submit();
		</script>
<%
	}
	
%>

</body>
</html>
