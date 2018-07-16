<%@page import="org.uengine.util.dao.*"%>
<%@page import="org.uengine.contexts.*"%>
<%@page import="org.uengine.persistence.processinstance.*"%>
<%@page import="org.uengine.ui.list.util.*"%>
<%@page import="org.uengine.persistence.dao.WorkListDAO"%>
<%@page import="org.uengine.ui.list.datamodel.DataMap"%>
<%@page import="org.uengine.ui.list.datamodel.QueryCondition"%>
<%@page import="org.uengine.ui.list.datamodel.DataList"%>
<%@page import="org.uengine.kernel.viewer.ViewerOptions"%>
<%@page import="org.uengine.ui.list.util.HttpUtils"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="org.uengine.web.chart.ProcessFlowChart"%>

<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>
<%@taglib uri="http://www.uengine.org/taglibs/bpm" prefix="bpm"%>
<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />
<html>
<head>
<%@include file="../processmanager/flowchart/flowchartHeader.jsp" %>
<%
String strategyId = reqMap.getString("strategyId", "");
DateFormat dfModifyDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:SS");

ProcessManagerRemote pm = processManagerFactory.getProcessManagerForReadOnly();

ProcessFlowChart chart = new ProcessFlowChart();
ProcessDefinitionRemote pdr = chart.view(pm, reqMap, lastInstance);

String strVersion = "";
if (UEngineUtil.isNotEmpty(chart.getProcessInstId())) {
	strVersion = "Instance ID: " + chart.getProcessInstId();
} else {
    strVersion = "Definition Version ID: " + chart.getProcessVersionId();
}
%>
<style>
body {
	padding: 0px;
	overflow:auto;
	margin: 0px;
}
</style>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT %>/scripts/tabs.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	init();
});

function viewTaskInfo(taskid, instanceId, tracingTag) {
	var screenWidth = screen.width;
	var screenHeight = screen.Height;
	var windowWidth = 950;
	var windowHeight = 650;
	var window_left = (screenWidth - windowWidth) / 2;
	var window_top = (screenHeight - windowHeight) / 2;	

	var option = "left=" + window_left + ", top=" + window_top + ", width=" + windowWidth + ", height=" + windowHeight + " ,scrollbars=yes,resizable=yes";
	var url = "worklist/workitemHandler.jsp?taskId="+taskid+"&instanceId="+instanceId+"&tracingTag="+tracingTag+"&isViewMode=true";
	var openedWih = window.open(url, "processView", option);
}

function showActivityDetails(instanceID, tracingTag) {
	window.open('viewActivityDetails.jsp?instanceID=' + instanceID + '&tracingTag=' + tracingTag,'activitydetails','width=500,height=400,scrollbars=yes,resizable=yes');
}

function changeDisplayDraw(booleanValue) {
	if (booleanValue) {
		drawAll();
	} else {
		cleanAll();
	}
}

// tab menu
var tmp = [
		{ title : '<%=GlobalContext.getMessageForWeb("Flowchart", loggedUserLocale) %>', onclick : 'changeDisplayDraw(true)' },
		//{ title : '<%=GlobalContext.getMessageForWeb("Instance Performance", loggedUserLocale) %>', onclick : 'changeDisplayDraw(false)' },
		{ title : '<%=GlobalContext.getMessageForWeb("Possible Actions", loggedUserLocale) %>', onclick : 'changeDisplayDraw(false)' },
		{ title : '<%=GlobalContext.getMessageForWeb("Roles", loggedUserLocale) %>', onclick : 'changeDisplayDraw(false)' },
		{ title : '<%=GlobalContext.getMessageForWeb("Work History", loggedUserLocale) %>', onclick : 'changeDisplayDraw(false)' },
		{ title : '<%=GlobalContext.getMessageForWeb("Variables", loggedUserLocale) %>', onclick : 'changeDisplayDraw(false)' }
		//{ title : '<%=GlobalContext.getLocalizedMessageForWeb("definition_improve", loggedUserLocale, "Improve") %>', onclick : 'changeDisplayDraw(false)' }
];

function onEventButtonClicked(eventName){
	document.eventHandlingForm.eventName.value = eventName;
	document.eventHandlingForm.submit();
}

function viewFormDefinition(formDefinitionId){
	if( formDefinitionId != "" ){
		window.open('../processmanager/viewFormDefinition.jsp?objectDefinitionId=' + formDefinitionId,'viewFormDefinition','width=1000,height=700,scrollbars=yes,resizable=yes');
	}
}

function viewProcInfo( instanceid ){
	var option = "width=500,height=400,scrollbars=yes,resizable=yes";
	var url = "viewProcessInformation.jsp?omitHeader=yes&instanceId="+instanceid;
	location=url;
}

var strategyId = "<%=strategyId%>";
function initateProcess(defverid){
	var url = "initiateForm.jsp?processDefinition=" + defverid + "&strategyId=" + strategyId;
	location.href = url;
	//window.open(url,'initiateProcess','top=100,left=500,width=1014,height=700,resizable=true,scrollbars=yes');
}
</script>
<title></title>
</head>
<body>
<%
try {
%>
<div id="canvasForLoopLines" style="position:absolute;left:0px;top:0px;z-index: -1"></div>
<%
if (UEngineUtil.isNotEmpty(chart.getProcessInstId())) {
%>
<script type="text/javascript">
	createTabs(tmp);
</script>
<%
}
%>

<div id="topbtnline" style="padding:10px; font-weight:bold;"><%=pdr.getName().getText(loggedUserLocale)%> (<%=strVersion%>)</div>

<!-- flow chart area start -->
<div id="divTabItem_<%=GlobalContext.getMessageForWeb("Flowchart", loggedUserLocale) %>">
	<br />
	<div align="center" id="divFlowchartArea"></div>
</div>
<!-- flow chart area end -->

<%
if (UEngineUtil.isNotEmpty(chart.getProcessInstId())) {
%>
<form action="worklist/eventHandler.jsp" name="eventHandlingForm">
	<input type="hidden" name="eventName" /> 
	<input type="hidden" name="instanceId" value="<%=chart.getProcessInstId()%>" />
</form>

<div id="divTabItem_<%=GlobalContext.getMessageForWeb("Possible Actions", loggedUserLocale) %>" style="display: none;">
<%
	EventHandler[] eventHandlersInAction = pm.getEventHandlersInAction(chart.getProcessInstId());

	if (eventHandlersInAction.length > 0) {
		for (int i = 0; i < eventHandlersInAction.length; i++) {
			EventHandler theEventHandler = eventHandlersInAction[i];
			if (theEventHandler.getTriggeringMethod() == org.uengine.kernel.EventHandler.TRIGGERING_BY_EVENTBUTTON) {
				if (theEventHandler.getOpenRoles() != null && !theEventHandler.getOpenRoles().containsMapping(chart.getInstance(), loggedRoleMapping)) continue;
%> 
	<input type="button" onClick="onEventButtonClicked('<%=theEventHandler.getName()%>')" value="<%=theEventHandler.getDisplayName().getText(loggedUserLocale)%>" />
<%
			}
		}
	} else {
%>
	There's no actions currently activated.
<%
	}
%>
</div>

<div id="divTabItem_<%=GlobalContext.getMessageForWeb("Roles", loggedUserLocale) %>" style="display: none;">
	<table border="0" cellpadding="5" cellspacing="5" width="95%">
<%
	org.uengine.kernel.Role[] roles = pdr.getRoles();
 
	int nCountRole = 0;
	int trCnt = 0;
	RoleMapping roleMapping = null;
	org.uengine.kernel.Role role = null;
	if (roles != null) {
		for (int i = 0; i < roles.length; i++) {
			role = roles[i];
			nCountRole = i;
			trCnt = i;
			//if (UEngineUtil.isNotEmpty(chart.getProcessInstId())) {
			    roleMapping = pm.getRoleMappingObject(chart.getProcessInstId(), role.getName());
				if (roleMapping == null || !UEngineUtil.isNotEmpty(roleMapping.getEndpoint())) {
					continue;
				}
				
				do {
					String endpoint = roleMapping.getEndpoint();
					if (!UEngineUtil.isNotEmpty(roleMapping.getUserPortrait())) {
					    roleMapping.fill(chart.getInstance());
					}
%>
	<%=trCnt % 2 == 0 ? "<tr>" : ""%>
		<td width="50%">
			<fieldset class="block-labels"><legend><%=role.getName()%></legend>
			<table width="100%" border="0" cellspacing="5" cellpadding="0"  class="tableborder">
				<tr>
					<td width="70" align="center" valign="top">
					<%
						String imgPath = "images/portrait/"+endpoint+".gif";
			        	
						java.io.File imgFile = new java.io.File(request.getRealPath(imgPath));
						if (!imgFile.exists()) imgPath = "images/main/NoIMG.gif";
					%>
						<img border="0" width="70" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/<%=imgPath%>" /> 
						<br><span style="font-weight:bold; color:#29384A;"><%=roleMapping.getResourceName()%></span>
					</td>
					<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
		                    <tr>
		                        <td width="70" class="formtitle" style="height:18px"><%=GlobalContext.getMessageForWeb("ROLE", loggedUserLocale) %></td>
		                        <td class="formcon"><%=role.getName()%></td>
		                    </tr>
		                    <tr><td colspan="2" bgcolor="#E0E0E0"></td></tr>
		                    <tr>
		                        <td width="70" class="formtitle" style="height:18px"><%=GlobalContext.getMessageForWeb("USER ID", loggedUserLocale) %></td>
		                        <td class="formcon"><%=endpoint%></td>
		                    </tr>
		                    <tr><td colspan="2" bgcolor="#E0E0E0"></td></tr>
		                    <tr>
		                        <td class="formtitle" style="height:18px"><%=GlobalContext.getMessageForWeb("GENDER", loggedUserLocale) %></td>
		                        <td class="formcon"><%=(roleMapping.isMale() ? "Male" : "Female")%></td>
		                    </tr>
		                    <tr><td colspan="2" bgcolor="#E0E0E0"></td></tr>
		                    <tr>
		                        <td class="formtitle" style="height:18px"><%=GlobalContext.getMessageForWeb("BIRTH", loggedUserLocale) %></td>
		                        <td class="formcon"><%=((roleMapping.getBirthday()==null)? "-" : roleMapping.getBirthday())%></td>
		                    </tr>
		                    <tr><td colspan="2" bgcolor="#E0E0E0"></td></tr>
		                    <tr>
		                        <td class="formtitle" style="height:18px"><%=GlobalContext.getMessageForWeb("LOCALE", loggedUserLocale) %></td>
		                        <td class="formcon"><%=((roleMapping.getLocale()==null)? "-" : roleMapping.getLocale())%></td>
		                    </tr>
		                    <tr><td colspan="2" bgcolor="#E0E0E0"></td></tr>
		                    <tr>
		                        <td class="formtitle" style="height:18px"><%=GlobalContext.getMessageForWeb("EMAIL", loggedUserLocale) %></td>
		                        <td class="formcon"><%=((roleMapping.getEmailAddress()==null)? "-" : roleMapping.getEmailAddress())%></td>
		                    </tr>
		                    <tr><td colspan="2" bgcolor="#E0E0E0"></td></tr>
		                </table>
		
					</td>
					
				</tr>
			</table>
			</fieldset>
		</td>
	<%=trCnt % 2 == 1 ? "</tr>" : ""%>
	<%
			//}
				trCnt ++;
			} while (roleMapping.next());
		}
	}
	%>
	<%=nCountRole % 2 == 0 ? "<td>&nbsp;</td></tr>" : ""%>
	</table>
</div>
<%if("true".equals(org.uengine.kernel.GlobalContext.getPropertyString("wih.display.thread"))){ %>
<div id="divTabItem_<%=GlobalContext.getMessageForWeb("Work History", loggedUserLocale) %>" style="display: none;">
	<div align="center">
		<div style="width:98%;">
			<script type="text/javascript">
				var loggedUserId = "<%=loggedUserId%>";
				var loggedUserName = "<%=loggedUserFullName%>";
				var loggedUserPartCode = "<%=loggedUserPartCode%>";
			
				function showHistoryContent(tag) {
					$("#btnShowHistory_" + tag).hide();
					$("#btnHideHistory_" + tag).show();
					$('#tableHidtoryContent_' + tag).show('normal');
				}
			
				function hideHistoryContent(tag) {
					$("#btnShowHistory_" + tag).show();
					$("#btnHideHistory_" + tag).hide();
					$('#tableHidtoryContent_' + tag).hide('normal');
				}
				
				function resizeFrame(size, tag){
					if (size > 0) {				
						document.getElementById("historyContentArea_"+tag).height = size;
					}
				}
				
				function getFormContext(tag,src){
					$("#btnGetHistory_" + tag).hide();
					$("#historyContentArea_"+tag).attr({
						"src":src
					});
					showHistoryContent(tag);
				}
				
				$(document).ready(function() {
					try { 
						if (window.top.opener.document.refreshForm != null && window.top.opener.document.refreshForm != undefined) {
							window.top.opener.document.refreshForm.submit();
						} else {
							window.top.opener.location.reload(true);
						}
					} catch (e) {}
				});
			</script>
<%
/*********************************************************************************

*********************************************************************************/
int activityCount = 1;
ProcessInstance currInstance = chart.getInstance();
ProcessInstance rootInstance = pm.getProcessInstance(currInstance.getRootProcessInstanceId());

String roleName = "";
String startTime = "";
String endTime = "";
String workTime = "";
String workTitle = "";
String resourceName = "";
String taskId = null;
String rootInstId = null;
String iframeUrl = null;
String statusMsg = "";
ProcessInstance historyRootInstance = null;
int year = 0;

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

StringBuffer sql = new StringBuffer()
.append(" SELECT wl.* ")
.append("   FROM bpm_worklist wl LEFT JOIN bpm_procinst pi ON wl.instid = pi.instid ")
.append("  WHERE pi.rootinstid = " + currInstance.getRootProcessInstanceId())
.append("   AND wl.status NOT IN  ('NEW' , 'CONFIRMED', 'DRAFT')")
.append(" ORDER BY wl.startdate, wl.taskid ");

org.uengine.processmanager.ProcessTransactionContext ptc = currInstance.getProcessTransactionContext();
org.uengine.util.dao.IDAO idao = org.uengine.util.dao.ConnectiveDAO.createDAOImpl(ptc, sql.toString(), org.uengine.util.dao.IDAO.class);
idao.select();

while(idao.next()){
	statusMsg = "";
	taskId = idao.getString("taskid");
	rootInstId = idao.getString("rootinstid");
	workTitle = idao.getString("title");
	resourceName = idao.getString("resname");
	
	if ("DELEGATED".equals(idao.getString("status"))) {
		statusMsg = "[" + GlobalContext.getMessageForWeb("Delegate", loggedUserLocale) + "] ";
	} 
	
	if (UEngineUtil.isNotEmpty(idao.getString("rolename"))) {
		roleName = idao.getString("rolename");
	}
	
	if(idao.get("enddate") != null){
		endTime = sdf.format(idao.getDate("enddate"));	
	}
	
	startTime = sdf.format(idao.getDate("startdate"));
	workTime = startTime + " ~ " + endTime; 
	
	historyRootInstance = pm.getProcessInstance(rootInstId);
	year = rootInstance.getProcessDefinition().getStartedTime(rootInstance).get(Calendar.YEAR);
	
	iframeUrl = GlobalContext.WEB_CONTEXT_ROOT + "/wih/defaultHandler/historyWorkItem.jsp?tag="+activityCount+"&htmlPath=" 
				+ URLEncoder.encode(year + "/" + rootInstance.getInstanceId() + "/" + taskId + ".html", GlobalContext.ENCODING);
	
%> 
        <div class="formcontextwrap">
            <div class="formcontexticon"><%=(activityCount < 10) ? "0" + activityCount : activityCount%></div>
            <div class="formcontexttitle"><%=statusMsg + workTitle %> (<%=roleName %> : <%=resourceName %>)</div>
            <div class="formcontext">
                <div id="btnGetHistory_<%=activityCount %>" onclick="getFormContext('<%=activityCount %>','<%=iframeUrl %>');" class="formcontextshowpane"><div class="endtime"><%=workTime %></div></div>
                <div id="btnShowHistory_<%=activityCount %>" onclick="showHistoryContent('<%=activityCount %>');" class="formcontexthidepane"><div class="endtime"><%=workTime %></div></div>
                <div id="btnHideHistory_<%=activityCount %>" onclick="hideHistoryContent('<%=activityCount %>');" class="formcontextshowpanedisnone" ><div class="endtime" ><!-- style="float:right; padding:8px 90px 0 0;" --><%=workTime %></div></div>
            </div>
        </div>
        <table id="tableHidtoryContent_<%=activityCount %>" align="center" width="100%" border="0" cellspacing="0" cellpadding="0" style="display: none; margin-bottom:35px;">
            <tr>
                <td width="26" height="14"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxMo01.gif" /></td>
				<td width="4" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxLineT.gif"></td>
                <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxLineT.gif"></td>
                <td width="30"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxMo02.gif" /></td>
            </tr>
			<tr>
                <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxLineL.gif"></td>
                <td></td>
                <td align="left" >
                <iframe frameborder="0" id="historyContentArea_<%=activityCount %>" src="" width="100%"></iframe>
                </td>
                <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxLineR.gif"></td>
            </tr>
			<tr>
                <td height="4"><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxMo04.gif"  /></td>
				<td width="4" background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxLineB.gif"></td>
                <td background="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxLineB.gif"></td>
                <td><img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/formContextConBoxMo03.gif"  /></td>
            </tr>
        </table>
<%
		//if(i==(n-1)){
		%>
		<script>
			getFormContext('<%=activityCount %>','<%=iframeUrl %>');
		</script>
		<%
		//}
		activityCount ++;
}
%>
		</div>
	</div>
</div>
<%} %>
<div id="divTabItem_<%=GlobalContext.getMessageForWeb("Variables", loggedUserLocale) %>" style="display: none;">
<%
	Vector<Serializable> formVariable = new Vector<Serializable>();
	if (chart.getInstance().isParticipant(loggedRoleMapping)) {
%>
<table width="95%" border=0 cellspacing=0 class="tableborder" style="margin:15px; ">
	<tr class="tabletitle" style="text-align:center;">
		<td width="13%">Name</td>
		<td>Value</td>
	</tr>
<%
		ProcessVariable[] pvdrs = pdr.getProcessVariableDescriptors();
		ProcessVariable pvd = null;
		Serializable data = null;
		if (pvdrs != null) {
			for (int i = 0; i < pvdrs.length; i++) {
				pvd = pvdrs[i];
				data = pm.getProcessVariable(chart.getProcessInstId(), "", pvd.getName());
				if (data instanceof Calendar && data != null) {
					data = ((Calendar) data).getTime();
				}
				if (data instanceof HtmlFormContext) {
					formVariable.add(data);
				}
				if (data == null) {
					data = ".";
				}
%>
	<tr>
		<td  class="formtitle" height="24"><%=pvd.getDisplayName().getText(loggedUserLocale)%></td>
		<td  class="formcon" align="left"><%=notNull(data)%></td>
	</tr>
    <tr><td colspan="2" height="1" bgcolor="#CCCCCC"></td></tr>
<%
			}
		}
%>
</table>
<%
	}
%>
</div>

<div id="divTabItem_<%=GlobalContext.getLocalizedMessageForWeb("definition_improve", loggedUserLocale, "Improve") %>" style="display: none;  padding:15px;">
<div> <span class="sectiontitle"><%=GlobalContext.getLocalizedMessageForWeb("improve_rule", loggedUserLocale, "Your changes would not be reflected until the administrator approve them(setting prodection).")%></span>
</div>
<div style="width:100%;">
<table border="0" cellpadding="5" cellspacing="5" width="100%"  style="border:solid 5px #e7e7e7;" align="center">
	<tr>
		<td>
		<fieldset class="block-labels"><legend><%=GlobalContext.getMessageForWeb("Process Definition", loggedUserLocale)%></legend>
		<table width="100%" border="0" cellpadding="5" cellspacing="5">
			<tr>
				<td align="center"><!-- a href='/html/uengine-web/processparticipant/initiateForm.jsp?alias=proc_process_improve&improve_process_defverid=<%=pdr.getId()%>'-->
				<a href="../processmanager/ProcessDesigner.jnlp?defVerId=<%=pdr.getId()%>">
				<img src="../processmanager/images/processReadyToBeEdited.gif" width="100" /><br>
				<%=pdr.getName().getText(loggedUserLocale)%></a></td>

				<td align="center">&nbsp;&nbsp;</td>
<%
	ProcessDefinition pdTemp = pm.getProcessDefinitionWithInstanceId(chart.getProcessInstId());

	String authorEmailAddress = "";
	String authorCompany = "";
	String changeDescription = "";
	Calendar changeTime = null;
	String modifydateString = "";
	int version = 0;
	RevisionInfo ri = null;
	ArrayList<RevisionInfo> al = pdTemp.getRevisionInfoList();
	
	if (al != null && al.size() > 0) {
		ri = al.get(0);

		authorEmailAddress = ri.getAuthorEmailAddress();
		authorCompany = ri.getAuthorCompany();
		changeDescription = ri.getChangeDescription();
		changeTime = ri.getChangeTime();

		if (changeTime != null) {
			modifydateString = dfModifyDate.format(changeTime.getTime());
			if (modifydateString.length() > 19) {
				modifydateString = modifydateString.substring(0, 19);
			}
		}
		
		version = ri.getVersion();
		RoleMapping rm = RoleMapping.create();
		rm.setEndpoint(ri.getAuthorId());
		rm.fill(chart.getInstance());
		
		String imgPath="images/portrait/"+rm.getEndpoint()+".gif";
		java.io.File imgFile = new java.io.File(request.getRealPath(imgPath));
		
		if (!imgFile.exists()) {
		    imgPath = "images/main/NoIMG.gif";
		}
%>
			<td width="45%" align="left">
				<fieldset class="block-labels"><legend><%=GlobalContext.getLocalizedMessageForWeb("first_author", loggedUserLocale, "First Author")%></legend>
				    <table width="100%" border="0" cellspacing="5" cellpadding="0" class="tableborder">
				        <tr>
				            <td width="70" align="center" valign="top"><img border="0" width="70" src="<%=GlobalContext.WEB_CONTEXT_ROOT+"/"+imgPath%>" /> <br>
				                <span style="font-weight:bold; color:#29384A;"><%=rm.getResourceName()%></span></td>
				            <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
				                <tr>
				                    <td width="70" class="formtitle" style="height:18px">Version</td>
				                    <td class="formcon"><%=version%></td>
				                    </tr>
				                <tr>
				                    <td colspan="2" bgcolor="#E0E0E0"></td>
				                    </tr>
				                <tr>
				                    <td class="formtitle" style="height:18px">Company</td>
				                    <td class="formcon"><%=UEngineUtil.isNotEmpty(authorCompany) ? authorCompany : ""%></td>
				                    </tr>
				                <tr>
				                    <td colspan="2" bgcolor="#E0E0E0"></td>
				                    </tr>
				                <tr>
				                    <td class="formtitle" style="height:18px">EmailAddress</td>
				                    <td class="formcon"><%=UEngineUtil.isNotEmpty(authorEmailAddress) ? authorEmailAddress : ""%></td>
				                    </tr>
				                <tr>
				                    <td colspan="2" bgcolor="#E0E0E0"></td>
				                    </tr>
				                <tr>
				                    <td class="formtitle" style="height:18px">Modify-Time </td>
				                    <td class="formcon"><%=modifydateString%></td>
				                    </tr>
				                <tr>
				                    <td colspan="2" bgcolor="#E0E0E0"></td>
				                    </tr>
				                <tr>
				                    <td class="formtitle" style="height:18px">Description</td>
				                    <td class="formcon"><%=UEngineUtil.isNotEmpty(changeDescription) ? changeDescription : ""%></td>
				                </tr>
				            </table></td>
				            </tr>
				        </table>
				</fieldset>
				</td>
				<td align="center">&nbsp;&nbsp;</td>
				<td width="45%" align="left">
<%
		ri = (RevisionInfo) al.get(al.size() - 1);

		authorEmailAddress = ri.getAuthorEmailAddress();
		authorCompany = ri.getAuthorCompany();
		changeDescription = ri.getChangeDescription();
		changeTime = ri.getChangeTime();
		
		if (changeTime != null) {
			modifydateString = dfModifyDate.format(changeTime.getTime());
			if (modifydateString.length() > 19) {
				modifydateString = modifydateString.substring(0, 19);
			}
		}
		
		version = ri.getVersion();
		rm.setEndpoint(ri.getAuthorId());
		rm.fill(chart.getInstance());
		
		imgPath = "images/portrait/"+rm.getEndpoint()+".gif";
		imgFile = new java.io.File(request.getRealPath(imgPath));
		
		if (!imgFile.exists()) { 
		    imgPath="images/main/NoIMG.gif";
		}
%>
				<fieldset class="block-labels"><legend><%=GlobalContext.getLocalizedMessageForWeb(
										"final_author", loggedUserLocale,
										"Final Author")%></legend>
				<table width="100%" border="0" cellspacing="5" cellpadding="0" class="tableborder">
				        <tr>
				            <td width="70" align="center" valign="top"><img border="0" width="70" src="<%=GlobalContext.WEB_CONTEXT_ROOT+"/"+imgPath%>" /> <br>
				                <span style="font-weight:bold; color:#29384A;"><%=rm.getResourceName()%></span></td>
				            <td  valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
				                <tr>
				                    <td width="70" class="formtitle" style="height:18px">Version</td>
				                    <td class="formcon"><%=version%></td>
				                    </tr>
				                <tr>
				                    <td colspan="2" bgcolor="#E0E0E0"></td>
				                    </tr>
				                <tr>
				                    <td class="formtitle" style="height:18px">Company</td>
				                    <td class="formcon"><%=UEngineUtil.isNotEmpty(authorCompany) ? authorCompany : ""%></td>
				                    </tr>
				                <tr>
				                    <td colspan="2" bgcolor="#E0E0E0"></td>
				                    </tr>
				                <tr>
				                    <td class="formtitle" style="height:18px">EmailAddress</td>
				                    <td class="formcon"><%=UEngineUtil.isNotEmpty(authorEmailAddress) ? authorEmailAddress : ""%></td>
				                    </tr>
				                <tr>
				                    <td colspan="2" bgcolor="#E0E0E0"></td>
				                    </tr>
				                <tr>
				                    <td class="formtitle" style="height:18px">Modify-Time </td>
				                    <td class="formcon"><%=modifydateString%></td>
				                    </tr>
				                <tr>
				                    <td colspan="2" bgcolor="#E0E0E0"></td>
				                    </tr>
				                <tr>
				                    <td class="formtitle" style="height:18px">Description</td>
				                    <td class="formcon"><%=UEngineUtil.isNotEmpty(changeDescription) ? changeDescription : ""%></td>
				                    </tr>
				                </table></td>
				            </tr>
				        </table>
				</fieldset>
			</td>
<%
	}
%>
			</tr>
		</table>
		</fieldset>
		</td>

<%
	if (formVariable.size() > 0) {
%>
	</tr>
    </table><br>
    <table border="0" cellpadding="5" cellspacing="5" width="100%"  style="border:solid 5px #e7e7e7;" align="center">
	<tr>
		<td>
		<fieldset class="block-labels"><legend><%=GlobalContext.getLocalizedMessageForWeb("formdefinition", loggedUserLocale, "Form Definition")%></legend>
		<table border="0" cellpadding="5" cellspacing="5">
			<tr>

<%
		HtmlFormContext htmlFormContext = null;
		ProcessDefinitionRemote processDefinitionRemote = null;
		String formName = null;
		for (int i = 0; i < formVariable.size(); i++) {
			htmlFormContext = (HtmlFormContext) formVariable.get(i);
			processDefinitionRemote = pm.getProcessDefinitionRemote(htmlFormContext.getFormDefId().split("@")[1]);
			formName = processDefinitionRemote.getName().getText(loggedUserLocale);
%>
				<td align="center"><a href="javascript:viewFormDefinition('<%=processDefinitionRemote.getBelongingDefinitionId()%>')">
				<img src="../processmanager/images/formReadyToBeEdited.gif" width="100"><br>
				<%=formName%> </a>
				</td>
				<td align="center">&nbsp;&nbsp;&nbsp;</td>
<%
		}
%>
			</tr>
		</table>
		</fieldset>
		</td>
	</tr>
<%
	}
}
%>

</table>
</div>
</div>

<%
} finally {
	try { pm.remove(); } catch (Exception e) { }
}
%>
</body>
</html>