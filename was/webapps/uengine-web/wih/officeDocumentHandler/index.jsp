<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-cache");
%>
<%@page import="org.uengine.contexts.OfficeDocumentInstance" %>
<%@page import="org.uengine.contexts.MappingContext" %>
<%@page import="org.uengine.contexts.OfficeDocumentDefinition" %>

<%@page import="org.uengine.contexts.HtmlFormContext" %>
<%@page import="org.uengine.contexts.MappingContext" %>
<%@page import="org.uengine.formmanager.FormUtil" %>
<%@page import="org.uengine.util.*" %>

<%@include file="../wihDefaultTemplate/header.jsp"%>
<%@include file="../wihDefaultTemplate/definition.jsp"%>

<script>
<%@include file="../../scripts/formActivity.js.jsp"%>
</script>
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

<body onload="enableTooltips();drawLoopLines(); try{eval('onLoadForm()');}catch(e){}" onunload="try{opener.refresh()}catch(e){}">

<table border="0" cellpadding="0" cellspacing="0" width="100%" xmlns>
	<tr>
		<td height="28" valign="bottom">
			<p><img src="../../images/icon_root.gif" align="middle" width="10" height="11" border="0"> 
			<%=decode(request.getParameter("definitionName"))%> > <b> <%=decode(request.getParameter(KeyedParameter.TITLE))%> </b>
		</td>
	</tr>
</table>

<%@include file="../wihDefaultTemplate/showTabs.jsp"%> 

<form name="mainForm" action=../wihDefaultTemplate/submit.jsp method=POST>

<%
try{
	
%>
<%@include file="../wihDefaultTemplate/initialize.jsp"%>
<%@include file="../wihDefaultTemplate/checkLogin.jsp"%>
<%@include file="../wihDefaultTemplate/findBackableActivities.jsp"%>

<%
	
isMine = initiate || "yes".equals(request.getParameter("isMine"));
ProcessInstance instance = piRemote;

ProcessDefinition procDef = (ProcessDefinition)pm.getProcessDefinition(initiationProcessDefinition);
OfficeDocumentActivity activity = (OfficeDocumentActivity)procDef.getActivity(tracingTag);

OfficeDocumentInstance odi = initiate ? (OfficeDocumentInstance)(activity.getVariableForOfficeDocumentInstance().getDefaultValue()) : (OfficeDocumentInstance)(activity.getVariableForOfficeDocumentInstance().get(instance, ""));
String documentDefId = odi.getDocumentDefId();

String[] defIdAndVersionId = documentDefId.split("@");
String currProductionOfficeDocDefId = pm.getProcessDefinitionProductionVersion(defIdAndVersionId[0]);// + "_write.jsp"; 
String documentDefinitionInXml = pm.getResource(currProductionOfficeDocDefId);
OfficeDocumentDefinition odd = (OfficeDocumentDefinition)GlobalContext.deserialize(documentDefinitionInXml, OfficeDocumentDefinition.class);

%>	

<div id="showActions" style="display : 'NONE'">
<%@include file="../wihDefaultTemplate/showActions.jsp"%>

</div>

<div id="showFlowChart" style="display : '';overflow-y:hidden;white-space:nowrap">
<%@include file="../wihDefaultTemplate/showFlowChart.jsp"%>
<%@include file="../wihDefaultTemplate/showMonitoring.jsp"%>
</div>

<div id="showInputForm" style="display : 'NONE'">
<%@include file="../wihDefaultTemplate/returnIfNotRunning.jsp"%>
<%@include file="showFormContext.jsp"%>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr height="1">
		<td align="center" height="1" class="bgcolor_head_underline"></td>
	</tr>
</table>
</div>

<div id="showRelatedKnowledges" style="display : 'NONE'">
<%@include file="../wihDefaultTemplate/showRelatedKnowledges.jsp"%>
</div>

<%@include file="../wihDefaultTemplate/passValues.jsp"%>

<% 
}finally{
	try{pm.cancelChanges();}catch(Exception ex){}
	try{pm.remove();}catch(Exception ex){}
}
%>
</form>

<form name=hiddenForm method=POST>
	<input type=hidden name="value">
</form>

</body>

<script>

function validateWorkitem(){
	document.forms[0].action = "validate.jsp";
	document.forms[0].submit();
}
	function delegateSearchPeople(){
		
		var inputName = "delegate"; 
		var orgPicker = window.open('<%=GlobalContext.WEB_CONTEXT_ROOT%>/common/organizationChartPicker.jsp','_new','width=430,height=700,resizable=true,scrollbars=no');
	
		orgPicker.onOk = onDelegateSelected;
		orgPicker.inputName = inputName;
	}
	
	function onDelegateSelected(selectedPeople,inputName){
	    var ids='';
		for(i=0; i<selectedPeople.length; i++){
			ids+=selectedPeople[i].id+";";	
		}			
		document.forms[0].all['delegateEndpoint'].value =ids;
		
		document.forms[0].action='../wihDefaultTemplate/delegateWorkItem.jsp';
		document.forms[0].submit();
	}

	function delegateWorkitem(){
		delegateSearchPeople();
	}
	
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
function back(tracingTag){
		document.forms[0].action='../wihDefaultTemplate/back.jsp?backTracingTag='+tracingTag;
		document.forms[0].submit();
	}
</script>