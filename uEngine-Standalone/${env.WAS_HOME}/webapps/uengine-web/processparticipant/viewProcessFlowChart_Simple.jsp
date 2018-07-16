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
<%@page import="org.uengine.security.util.DefaultAclUtil"%>

<%@include file="../common/header.jsp"%>
<%@include file="../common/getLoggedUser.jsp"%>
<html>
<head>
<%@include file="../processmanager/flowchart/flowchartHeader.jsp" %>
<%@taglib uri="http://www.uengine.org/taglibs/bpm" prefix="bpm"%>
<style>
body {
	padding: 0px;
	overflow:auto;
	margin: 0px;
}
</style>

<jsp:useBean id="processManagerFactory" scope="application" class="org.uengine.processmanager.ProcessManagerFactoryBean" />
<%
	ProcessManagerRemote pm = processManagerFactory.getProcessManagerForReadOnly();

	try {
		DefaultConnectionFactory defaultConnectionFactory = DefaultConnectionFactory.create();

		response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
		response.setHeader("Pragma", "no-cache"); //HTTP 1.0
		response.setDateHeader("Expires", 0); //prevents caching at the proxy server

		/***********************************************************************/
		/*                            Define                                   */
		/***********************************************************************/

		QueryCondition condition = new QueryCondition();
		DataList dl = null;

		int intPageCnt = 10;
		int nPagesetSize = 10;
		int currentPage = reqMap.getInt("CURRENTPAGE", 1);
		int totalCount = 0;
		int totalPageCount = 0;
		
		String strategyId = request.getParameter("strategyId");

		String strTarget = reqMap.getString("TARGETCOND", "procins.instancename");
		String strKeyword = reqMap.getString("KEYWORDCOND", "");
		String strDateKeyStart = reqMap.getString("INIT_START_DATE", "");
		String strDateKeyEnd = reqMap.getString("INIT_END_DATE", "");
		String strDefCategoryId = reqMap.getString("DEFCATEGORYID", "");
		String strDefTypeId = reqMap.getString("DEFTYPEID", "");

		String strSortColumn = reqMap.getString("SORT_COLUMN", "");
		String strSortCond = reqMap.getString("SORT_COND", "");
		String menuItemId = reqMap.getString("MENU_ITEMID", "item_bpm");

		/***********************************************************************/
		/*                            Check & Set Parameter                    */
		/***********************************************************************/
		condition.setMap(reqMap);
		condition.setOnePageCount(intPageCnt);
		condition.setPageNo(currentPage);

		String pd = reqMap.getString("processDefinition", "");
		String pdver = reqMap.getString("definitionVersionId", "");
		String pi = reqMap.getString("instanceId", "");

		String belongingPd = pd;

		//replace with production version
		if (UEngineUtil.isNotEmpty(pi)) {
			ProcessInstance instance = pm.getProcessInstance(pi);
			pdver = instance.getProcessDefinition().getId();
		} else if (!UEngineUtil.isNotEmpty(pdver) && UEngineUtil.isNotEmpty(pd)) {
			pdver = pm.getProcessDefinitionProductionVersion(pd);
		}

		//	if(!UEngineUtil.isNotEmpty(pi)) pi = null;
		boolean isInstance = false;
		
		if (UEngineUtil.isNotEmpty(pi)) {
			isInstance = true;
		} else if (UEngineUtil.isNotEmpty(lastInstance)) {
			isInstance = false;
			pi = lastInstance;
		}
		
		
		ProcessDefinitionRemote pdr;
		if (!"".equals(pi)) {
			pdr = pm.getProcessDefinitionRemoteWithInstanceId(pi);
			pd = pm.getProcessInstance(pi).getProcessDefinition().getBelongingDefinitionId();
		} else {
			if (pdver == null)
				return;
			pdr = pm.getProcessDefinitionRemote(pdver);
		}
%>

<script type="text/javascript">
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
</script>
<title></title>
</head>
<body onload="init();">
<div id="canvasForLoopLines" style="position:absolute;left:0px;top:0px;z-index: -1"></div>
<%
	String strVersion = null;
	if (!"".equals(pi)) {
			ProcessInstance instance = pm.getProcessInstance(pi);
			strVersion = "Instance ID: " + pi;
%>
	<script type="text/javascript">
		var WEB_CONTEXT_ROOT = "<%=GlobalContext.WEB_CONTEXT_ROOT%>";
		
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
		
	</script>

<%
	} else if (pdver != null) {
		strVersion = "Definition Version ID: " + pdver;
%>
		<!-- <ul><%=(pdr.getDescription() == null ? "[no description]" : notNull(pdr.getDescription().getText(loggedUserLocale)))%></ul> -->
<%
	}
%>
<div  id="topbtnline" style="padding:10px; font-weight:bold;"><%=pdr.getName().getText(loggedUserLocale)%> (<%=strVersion%>)</div>

<div id="divTabItem_<%=GlobalContext.getMessageForWeb("Flowchart", loggedUserLocale) %>">
	<br>
	<div align="center" id="divFlowchartArea"></div>
</div>

<script>
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
	
	function viewTaskInfo( taskid, instanceId, tracingTag ){
		var screenWidth = screen.width;
		var screenHeight = screen.Height;
		var windowWidth = 950;
		var windowHeight = 650;			
		var window_left = (screenWidth-windowWidth)/2; 
 		var window_top = (screenHeight-windowHeight)/2;	
		var option = "left=" + window_left + ", top=" + window_top + ", width=" + windowWidth + ", height=" + windowHeight + " ,scrollbars=yes,resizable=yes";
    	var url = "./worklist/workitemHandler.jsp?taskId="+taskid+"&instanceId="+instanceId+"&tracingTag="+tracingTag+"&isViewMode=yes"+"&isMine=no";
		var openedWih = window.open(url, "processView", option);
		
	}
	
	var strategyId = "<%=strategyId%>";
	function initateProcess(defverid){
		var url = "initiateForm.jsp?processDefinition=" + defverid + "&strategyId=" + strategyId;
		location.href = url;
		//window.open(url,'initiateProcess','top=100,left=500,width=1014,height=700,resizable=true,scrollbars=yes');
	}
</script>

<%
	} finally {
		try {
			pm.remove();
		} catch (Exception e) { }
	}
%>
</body>
</html>