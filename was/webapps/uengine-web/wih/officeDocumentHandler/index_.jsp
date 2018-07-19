<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-cache");
%>

<%@page import="org.uengine.contexts.OfficeDocumentInstance" %>
<%@page import="org.uengine.contexts.MappingContext" %>
<%@page import="org.uengine.contexts.OfficeDocumentDefinition" %>
<%@page import="org.uengine.util.*" %>

<%@include file="../wihDefaultTemplate/header.jsp"%>
<%@include file="../wihDefaultTemplate/definition.jsp"%>
<%@include file="../wihDefaultTemplate/initialize.jsp"%>
<%@include file="../wihDefaultTemplate/findBackableActivities.jsp"%>
<html>
<head>
<LINK rel="stylesheet" href="../../style/calendar-win2k-cold-1.css" type="text/css"/>
<LINK rel="stylesheet" href="../../style/form.css" type="text/css"/>
<script type="text/javascript" src="../../scripts/calendar.js"></script>
<script type="text/javascript" src="../../scripts/calendar-setup.js"></script>
<script type="text/javascript" src="../../scripts/calendar-en.js"></script>

<style TYPE="TEXT/CSS">
BODY {background:url(../../processmanager/images/empty.gif) #ffffff }
</style>

<script type="text/javascript">
	function openJCalc(path){
		var obj = window.open(path, "_blank");
		obj.close();
	}
</script>
</head>

<body onload="enableTooltips();drawLoopLines(); try{eval('onLoadForm()');}catch(e){}" onunload="try{opener.refresh()}catch(e){}">

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
 
<%@include file="../wihDefaultTemplate/showTabs.jsp"%> 

<form name="mainForm" action=../wihDefaultTemplate/submit.jsp method=POST>


<%
//------------- declaration & initialize -------------------//

try{
	
%>

<%
	
	isMine = initiate || "yes".equals(request.getParameter("isMine"));
	ProcessInstance instance = piRemote;

	ProcessDefinition procDef = (ProcessDefinition)pm.getProcessDefinition(initiationProcessDefinition);
	OfficeDocumentActivity activity = (OfficeDocumentActivity)procDef.getActivity(tracingTag);

	OfficeDocumentInstance odi = initiate ? (OfficeDocumentInstance)(activity.getVariableForOfficeDocumentInstance().getDefaultValue()) : (OfficeDocumentInstance)(activity.getVariableForOfficeDocumentInstance().get(instance, ""));
	String documentDefId = odi.getDocumentDefId();
	
	String[] defIdAndVersionId = documentDefId.split("@");
	String currProductionFormDefId = pm.getProcessDefinitionProductionVersion(defIdAndVersionId[0]);// + "_write.jsp"; 
	String documentDefinitionInXml = pm.getResource(currProductionFormDefId);
	OfficeDocumentDefinition odd = (OfficeDocumentDefinition)GlobalContext.deserialize(documentDefinitionInXml, OfficeDocumentDefinition.class);
	
%>

<div id="showFlowChart" style="display : '';overflow-y:hidden;white-space:nowrap">
	<%@include file="../wihDefaultTemplate/showFlowChart.jsp"%>
	<%@include file="../wihDefaultTemplate/showMonitoring.jsp"%>
</div>


<%if(isRacing){	%>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
	<tr height="1">
		<td align="center" bgcolor=yellow><b><%=GlobalContext.getLocalizedMessageForWeb("accept_desc", loggedUserLocale, "You need to accept this workitem since users are racing to handle this workitem.") %></b></td>
	</tr>
</table>
		
<%
  }
%>


<div id="showInputForm" style="display : 'NONE'">	
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

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr height="20" >
		<td width="120" align=left bgcolor="f4f4f4">
			&nbsp;<div nowrap><b><%=GlobalContext.getLocalizedMessageForWeb("to_do", loggedUserLocale, "To-Do") %>:</b> </div>
		</td>
		<td width="10"></td>
		<td width="*" align=left>
	<a href="../../processmanager/JCalc.jnlp?openSpot=executeOfficeInstance&documentDefId=<%=currProductionFormDefId%>&instanceId=<%=instanceId%>&tracingTag=<%=tracingTag%>"><img src="../../processmanager/images/openJCalc.gif" border=0></a>

		</td>		
	</tr>
	
	<tr height="1">
		<td align="center" colspan="3" height="1" class="bgcolor_head_underline"></td>
	</tr>
	<tr height="1">
		<td align="center" colspan="3" height="1" class="bgcolor_head_underline"></td>
	</tr>
</table>


</div>

<div id="showRelatedKnowledges" style="display : 'NONE'">
<%@include file="../wihDefaultTemplate/showRelatedKnowledges.jsp"%>
</div>	


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

<br>

<%@include file="../wihDefaultTemplate/passValues.jsp"%>

<%
	if(!initiate){
		String status = pm.getActivityStatus(instanceId, tracingTag);
		
		if(status!=null && !status.equals("Running") && !status.equals("Timeout")){%>
			
			<table width="100%" border="0" cellspacing="0" cellpadding="4">
				<tr>
					<td style="padding: 0px 0px 0px 20px;" >
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr height="20" >
								<td>
									The workitem has been closed (<%=status%>)<p>									
									<!-- You can see the data you've submitted by this <a href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/wih/formHandler/viewFormInstances.jsp?instanceId=<%=instanceId%>&tracingTag=<%=tracingTag%>&processDefinition=<%=processDefinition%>&taskId=<%=request.getParameter("taskId")%>" >Link</a> -->
								</td>
							</tr>	
						</table>
					</td>
				</tr>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="10"></td>
				</tr>
			</table>
			<%
			return;
		}
	}
%>

<div id="showActions" style="display : 'NONE'">
<% if(true) {%>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
	<tr>
		<td style="padding: 0px 0px 0px 20px;" >
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr height="20" >
					<td align=right>
					  <%if(isRacing){%>
			              <input type=button value=<%=GlobalContext.getLocalizedMessageForWeb("accept", loggedUserLocale, "Accept") %> onclick="acceptWorkitem()">
					  <%}else{%>
						  <input type=submit class="btn" value="Complete">
						  <input type=submit class="btn" value="Save" onclick="saveWorkitem()">
					  <%}%>
					</td>		
				</tr>	
			</table>
		</td>
	</tr>
</table>
<% }else{ 

%>

<input type=submit class="btn" value="Complete">
<input type=submit class="btn" value="Validate" onclick="validateWorkitem()">

<table width="100%" border="0" cellspacing="0" cellpadding="4">
	<tr>
		<td style="padding: 0px 0px 0px 20px;" >
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr height="20" >
					<td>
						
					</td>		
				</tr>	
			</table>
		</td>
	</tr>
</table>
</div>


<% }
}finally{
	try{pm.cancelChanges();}catch(Exception ex){}
	try{pm.remove();}catch(Exception ex){}
}
%>
<script>
function saveWorkitem(){
	document.forms[0].saveOnly.value="yes";
	document.forms[0].submit();
}
function validateWorkitem(){
	document.forms[0].action = "validate.jsp";
	document.forms[0].submit();
}
function acceptWorkitem(){
	document.forms[0].action='../wihDefaultTemplate/accept.jsp';
	document.forms[0].submit();
}
</script>
<input type=hidden name="saveOnly">
</form>

<form name=hiddenForm method=POST>
	<input type=hidden name="value">
</form>

</body>