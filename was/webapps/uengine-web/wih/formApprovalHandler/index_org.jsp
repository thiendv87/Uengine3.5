<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    //request.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-cache");
%>

<%@page import="org.uengine.contexts.HtmlFormContext" %>
<%@page import="org.uengine.contexts.MappingContext" %>
<%@page import="org.uengine.formmanager.FormUtil" %>
<%@page import="org.uengine.util.*" %>

<%@include file="../wihDefaultTemplate/header.jsp"%>
<%@include file="../wihDefaultTemplate/initialize.jsp"%>

<script language="javascript">
<%@include file="../../scripts/formActivity.js.jsp"%>
</script>

<LINK rel="stylesheet" href="../../style/form.css" type="text/css"/>
<script type="text/javascript" src="../../scripts/calendar.js"></script>
<script type="text/javascript" src="../../scripts/calendar-setup.js"></script>
<script type="text/javascript" src="../../scripts/calendar-en.js"></script>

<!--body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" leftmargin="5" topmargin="0" marginwidth="0" marginheight="0" onload="drawLoopLines();"-->
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<table border="0" cellpadding="0" cellspacing="0" width="100%" xmlns>
	<tr>
		<td height="28" valign="bottom">
			<p><img src="../../images/icon_root.gif" align="middle" width="10" height="11" border="0"> 
			<%=decode(request.getParameter("definitionName"))%> > <b> 
			<%=decode(request.getParameter(KeyedParameter.TITLE))%> </b>
		</td>
	</tr>
	<tr>
		<td height="1" class="path_underline"></td>
	</tr>
</table>
 


<!--body onload="opener.refresh()"-->
<form name="mainForm" action=submit.jsp method=POST>

<%
//------------- declaration & initialize -------------------//

	try{
	isMine = initiate || "yes".equals(request.getParameter("isMine"));
	ProcessInstance instance = piRemote;

	System.out.println("initiationProcessDefinition:"+initiationProcessDefinition);
	
	ProcessDefinition procDef = null;
	if(initiate) procDef = (ProcessDefinition)pm.getProcessDefinition(initiationProcessDefinition);
	else procDef = piRemote.getProcessDefinition();
	
	FormActivity formActivity = (FormActivity)procDef.getActivity(tracingTag);

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
	
//------------- pass values to submit.jsp -------------------//

%>	
<%@include file="../wihDefaultTemplate/passValues.jsp"%>

<!-- BODY START -->
<TABLE width="100%" cellpadding="0" cellspacing="0" border="0">
<TR>
	<TD width="826" align="center" valign="top">
	
	<!--INFO START-->			
	<TABLE width="95%" cellpadding="0" cellspacing="0" border="0">
	<TR>
		<TD width="5"><img src="../../images/body/box01_01.gif"></TD>
		<TD width="5" background="../../images/body/box01_02.gif"></TD>
		<TD width="5"><img src="../../images/body/box01_03.gif"></TD>								
	</TR>
	</TABLE>
	
	</TD>
</TR>
</TABLE>
<%
//------------- showFlowChart.jsp --------------------------//
%>
<!--%@include file="../wihDefaultTemplate/showFlowChart.jsp"%-->

	<%@include file="inc_approvalLine.jsp"%>


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
	
	boolean wasIsJBoss = "JBOSS".equals(GlobalContext.getPropertyString("was.type", "TOMCAT"));

	String cachedFormRoot = (wasIsJBoss ? GlobalContext.WEB_CONTEXT_ROOT : "") + "/wih/formHandler/cachedForms/";
	File contextDir = new File(request.getRealPath(cachedFormRoot));
	
	FormUtil.copyToContext(contextDir, formFileName);
	
	RequestDispatcher rdIncludeAction = request.getRequestDispatcher(cachedFormRoot+formFileName+"_write.jsp");
	rdIncludeAction.include(request, response);
	out.flush();
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

<% if(!initiate) {%>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
	<tr>
		<td style="padding: 0px 0px 0px 20px;" >
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr height="20" >
					<td align=right>
						<input type=submit class="btn" value="Complete">
						<input type=submit class="btn" value="Save" onclick="saveWorkitem()">
					</td>		
				</tr>	
			</table>
		</td>
	</tr>
</table>
<% }else{ 

%>

<input type=submit class="btn" value="Complete">
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
<!------------ pass submit --------------------------------->
<input type=hidden name=userCode>
<input type=hidden name=userName>
<input type=hidden name=loadApprovealActivities>
<input type=hidden name=approveType>
<input type=hidden name=preConfirm>

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
</script>
<input type=hidden name="saveOnly">
</form>

<form name=hiddenForm method=POST>
	<input type=hidden name="value">
</form>

</body>