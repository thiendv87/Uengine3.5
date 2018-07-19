<%@page import="org.uengine.kernel.viewer.ViewerOptions"%>
<%@page import="java.text.SimpleDateFormat"%>

<html>
<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@include file="../common/styleHeader.jsp"%>

<script type="text/javascript">
<!--
var WEB_CONTEXT_ROOT = "<%=GlobalContext.WEB_CONTEXT_ROOT%>";
function changeDisplayDraw(booleanValue) {
	if (booleanValue) {
		drawAll();
	} else {
		cleanAll();
	}
}
//-->
</script>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/lib/raphael/raphael-min.js"></script>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/loopDraw.js"></script>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/popupTooltip.js"></script>
<script type="text/javascript" src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/scripts/flowchart/flowchartUtil.js"></script>
<LINK type="text/css" rel="stylesheet" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/popupTooltip.css">
<%@include file="../lib//jquery/importJquery.jsp" %>

<link rel="stylesheet" type="text/css" href="../style/portlet.css" />
<link rel="stylesheet" type="text/css" href="../style/portal.css" />
<link rel="stylesheet" type="text/css" href="../style/groupware.css" />
<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />
<%
ProcessManagerRemote pm = null;
try{
	pm = processManagerFactory.getProcessManagerForReadOnly();

	String pd = (request.getParameter("processDefinition"));
	String pdVer = (request.getParameter("processDefinitionVersionID"));
	String folder = (request.getParameter("folder"));
	//	String pi = (request.getParameter("instanceId"));
	String pi = null;	//	SubProcess ? ??.
	String instanceIds = (request.getParameter("instanceId"));
	String selectedInstanceId = (request.getParameter("selectedInstanceId"));
	String[] arrInstanceIds = null;
	if (instanceIds != null && instanceIds.indexOf(";") > -1) {
		arrInstanceIds = instanceIds.split(";");
		if (selectedInstanceId != null && !"".equals(selectedInstanceId)) {
			pi = selectedInstanceId;
		} else {
			pi = arrInstanceIds[0];
		}
	} else {
		pi = instanceIds;
	}

	String locale = (request.getParameter("locale"));
	if (!UEngineUtil.isNotEmpty(pi)) pi = null;
	if (!UEngineUtil.isNotEmpty(locale)) locale = loggedUserLocale;
	String chart ="no chart is available";
	
	/***********************************************************************/
	/*                            Get version list                         */
	/***********************************************************************/

	ProcessDefinitionRemote[] arrPdr = null;
	if (pi == null) {
		if (pd == null) {
			return;
		}
		
		arrPdr = pm.findAllVersions(pd);
		
		if (arrPdr != null) {
			String versionID = null;
			int version = -1;
			for (int i=0; i<arrPdr.length; i++) {
				versionID = arrPdr[i].getId();
				version = arrPdr[i].getVersion();
				if (arrPdr[i].isProduction()) {
					if (pdVer == null || "".equals(pdVer) || "null".equals(pdVer)) {
						pdVer = versionID;
					}
				}
			}
			if (pdVer == null || "".equals(pdVer) || "null".equals(pdVer)) {
				pdVer = versionID;
			}
		}
	}
	
	ProcessDefinitionRemote pdr;	
	if (pi != null) {
		pdr = pm.getProcessDefinitionRemoteWithInstanceId(pi);
	} else {
		pdr = pm.getProcessDefinitionRemote(pdVer);
	}
	
	ProcessInstance instance = null;
	if (pi != null) {
		instance = pm.getProcessInstance(pi);
	}
	
	String title = pdr.getName().getText(locale);
	
	ViewerOptions options = new ViewerOptions();
	
	options.setViewType(options.VERTICAL);
	options.put("flowControl", new Boolean(true));
//	options.put("dontCollapseScopes", new Boolean(true));
	options.put("decorated", new Boolean(true));
	options.put("show hidden activity", new Boolean(true));
	options.put("ShowAllComplexActivities", new Boolean(true));
//	options.put("enableEvent_onActivityClicked", new Boolean(true));
	options.put("align", "center");
	options.put("locale", loggedUserLocale);
	
	if (pi != null) {
		options.put("enableUserEvent_compensateTo", "Back to here");
		options.put("enableUserEvent_refreshMultipleInstances_org.uengine.kernel.SubProcessActivity", "Refresh Multiple Instances");
		options.put("enableUserEvent_showLog", "See Execution Log");
		//options.put("enableUserEvent_locateWorkItem", "Work Item Handler");
		options.put("enableUserEvent_locateWorkItem_org.uengine.kernel.ReceiveActivity", "Work Item Handler");
	}
	
	options.put("enableUserEvent_viewFormDefinition_org.uengine.kernel.FormActivity", "View Form Definition");
	options.put("enableUserEvent_drillInto_org.uengine.kernel.SubProcessActivity", "Drill Into");
	if (locale != null)
		options.put("locale", locale);
	
	if (pi != null) {
		chart = pm.viewProcessInstanceFlowChart(pi, options);
	} else {
		if (pdVer != null) {
			chart = pm.viewProcessDefinitionFlowChart(pdVer, options);
		}
	}

	String pin = request.getParameter("pin"); //process instance name
	String belongingDefId = pdr.getBelongingDefinitionId();
	String srAlias = pdr.getAlias();
%>

<style> body{ overflow:auto;}</style>
<title><%=GlobalContext.getMessageForWeb("Process Definition", loggedUserLocale) %>-<%=pdr.getName().getText()%>(<%=GlobalContext.getMessageForWeb("Version", loggedUserLocale) %>:<%=pdr.getVersion()%>/<%=GlobalContext.getMessageForWeb("Modified Date", loggedUserLocale) %>:<%=pdr.getStrModifiedDate() %>)</title>
</head>

<body onload="drawAll();" onresize="drawAll();" >
<div id="canvasForLoopLines" style="position:absolute;left:0px;top:0px;z-index: -1"></div>
<div style=" padding:15px;  width:98%">
	<div id="divTabItem_<%=GlobalContext.getMessageForWeb("Flowchart", loggedUserLocale) %>" style="overflow: hidden;">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
					<%=chart%>
					<script type="text/javascript">
						drawAll();
					</script>
				</td>
			</tr>
	    </table>
	</div>
</div>

<%
} finally {
	if(pm!=null){
		try{
			pm.remove();
		}catch(Exception e){}
	}
}
%>
</body>
</html>