<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.uengine.ui.worklist.filter.WorkListFilterList"%>
<%@page import="org.uengine.ui.worklist.filter.WorkListFilter"%>
<%
	WorkListFilterList wfl = WorkListFilterList.load();
	WorkListFilter[] workitemFilters = wfl.getWorkItemFilters();
%>

<%@page import="org.uengine.util.UEngineUtil"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
</style>
<script type="text/javascript">
	function addFilter(type){
		var url = "../commonfilter/dlgAddFilter.jsp?type="+type;
		window.open(url,'','top=100,left=100,width=600,height=300,resizable=true,scrollbars=yes');
	}
	
	function deleteFilter(UID){
		result = confirm("Are you sure to delete this filter?");
		if(result==true){
			var url = "../commonfilter/deleteFilter.jsp?filterUID="+UID;
			window.open(url,'','top=100,left=100,width=600,height=300,resizable=true,scrollbars=yes');
		}
	}
</script>
</head>
<body class="tundra">
<div dojoType="dijit.layout.AccordionContainer" style="width: 100%; height:100%; overflow: hidden; border:none; margin:0px; padding:0px;">
    <div dojoType="dijit.layout.AccordionPane" title="<%=GlobalContext.getMessageForWeb("Workitem View", loggedUserLocale)%>" class="menuList">
        
        <ul id="dojoList" >
            <li><a href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/wl2_workList.jsp?filtering=0&currentPage=1" target="innerworkarea"><%=GlobalContext.getMessageForWeb("New Work", loggedUserLocale)%></a></li>
        </ul>
        <ul id="dojoList" >
            <li><a href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/wl2_workList.jsp?filtering=1&currentPage=1" target="innerworkarea"><%=GlobalContext.getMessageForWeb("Completed Work", loggedUserLocale)%></a></li>
        </ul>
        <ul id="dojoList" >
            <li><a href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/wl2_workList.jsp?filtering=2&currentPage=1" target="innerworkarea"><%=GlobalContext.getMessageForWeb("Cancelled Work", loggedUserLocale)%></a></li>
        </ul>
        <ul id="dojoList" >
            <li><a href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/wl2_workList.jsp?filtering=3&currentPage=1" target="innerworkarea"><%=GlobalContext.getMessageForWeb("Reserved Work", loggedUserLocale)%></a></li>
        </ul>
		<ul id="dojoList" >
            <li><a href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/wl2_workList.jsp?filtering=4&currentPage=1" target="innerworkarea"><%=GlobalContext.getMessageForWeb("Delayed Work", loggedUserLocale)%></a></li>
        </ul>
		<%	for (int i=0; i<workitemFilters.length; i++) {
        		if ("workitem".equals(workitemFilters[i].getType())) {	
        			String workItemDefId = workitemFilters[i].getDefinition();
        			String workItemInfo = workitemFilters[i].getInformation();
        			String workItemFilterStatus = workitemFilters[i].getStatus();
        			String workItemEndpointType = workitemFilters[i].getEndpointType();
        			String workItemFiltering = "";
        			if ("Open".equals(workItemFilterStatus)) {
        				workItemFiltering = "0";
        			} else if ("Completed".equals(workItemFilterStatus)) {
        				workItemFiltering = "1";
        			} else if ("Cancelled".equals(workItemFilterStatus)) {
        				workItemFiltering = "2";
        			} else if ("Reserved".equals(workItemFilterStatus)) {
        				workItemFiltering = "3";
        			}
        			
        			String workItemInfoParameter = "";
        			if (UEngineUtil.isNotEmpty(workItemInfo)) {
        				workItemInfoParameter = "&instanceInfo="+workItemInfo;
        			}
        %>
		<ul id="dojoList" >
            <li>
				<a href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/wl2_workList.jsp?filtering=<%=workItemFiltering%>&currentPage=1&processDefId=<%=workItemDefId%>&endpointType=<%=workItemEndpointType%><%=workItemInfoParameter%>" target="innerworkarea"><%=workitemFilters[i].getFilterName()%></a>&nbsp;&nbsp;
		<%			if (loggedUserIsAdmin) {	%>
            	<img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/b_smalldel.gif" width="29" height="11" onClick="javascript:deleteFilter('<%=workitemFilters[i].getFilterUId()%>')" style="cursor:pointer; right:15px; position:absolute; ">
		<%			}	%>
            </li>
        </ul>
		<%	}	}
        	if(loggedUserIsAdmin){	%>
        <ul style=" border-bottom:1px dotted #CCCCCC; background:#FFF none; ">
            <li style=" background:#FFF none; border:none; padding:2px; cursor:pointer; text-align:center;" onClick="javascript:addFilter('workitem');">
            <img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/addfilter.gif" width="97" height="19">
            </li>
        </ul>
        <%	}	%>
    </div>
    <div dojoType="dijit.layout.AccordionPane" title="<%=GlobalContext.getMessageForWeb("Process View", loggedUserLocale)%>" class="menuList">
        <ul id="dojoList" >
            <li><a href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/wl2_instanceList.jsp?filtering=0&currentPage=1" target="innerworkarea"><%=GlobalContext.getMessageForWeb("Running Process", loggedUserLocale)%></a></li>
        </ul>
        <ul id="dojoList" >
            <li><a href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/wl2_instanceList.jsp?filtering=1&currentPage=1" target="innerworkarea"><%=GlobalContext.getMessageForWeb("Completed Process", loggedUserLocale)%></a></li>
        </ul>
        <ul id="dojoList" >
            <li><a href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/wl2_instanceList.jsp?filtering=2&currentPage=1" target="innerworkarea"><%=GlobalContext.getMessageForWeb("Stopped Process", loggedUserLocale)%></a></li>
        </ul>
        <%	for (int i=0; i<workitemFilters.length; i++) {
        		if ("instance".equals(workitemFilters[i].getType())) {	
        			String instanceDefId = workitemFilters[i].getDefinition();
        			String instanceInfo = workitemFilters[i].getInformation();
        			String instanceFilterStatus = workitemFilters[i].getStatus();
        			String instanceEndpointType = workitemFilters[i].getEndpointType();
        			String instanceFiltering = "";
        			if ("Running".equals(instanceFilterStatus)) {
        				instanceFiltering = "0";
        			} else if ("Completed".equals(instanceFilterStatus)) {
        				instanceFiltering = "1";
        			} else if ("Stopped".equals(instanceFilterStatus)) {
        				instanceFiltering = "2";
        			}
        			
        			String instanceInfoParameter = "";
        			if (UEngineUtil.isNotEmpty(instanceInfo)) {
        				instanceInfoParameter = "&instanceInfo="+instanceInfo;
        			}
        %>
		<ul id="dojoList" >
            <li>
				<a href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/wl2_instanceList.jsp?filtering=<%=instanceFiltering%>&currentPage=1&processDefId=<%=instanceDefId%>&endpointType=<%=instanceEndpointType%><%=instanceInfoParameter%>" target="innerworkarea"><%=workitemFilters[i].getFilterName()%></a>&nbsp;&nbsp;
		<%			if (loggedUserIsAdmin) {	%>
            	<img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/b_smalldel.gif" width="29" height="11" onClick="javascript:deleteFilter('<%=workitemFilters[i].getFilterUId()%>')" style="cursor:pointer; right:15px; position:absolute; ">
		<%			}	%>
            </li>
        </ul>
		<%	}	}
        	if(loggedUserIsAdmin){	%>
        <ul style=" border-bottom:1px dotted #CCCCCC; background:#FFF none; ">
            <li style=" background:#FFF none; border:none; padding:2px; cursor:pointer; text-align:center;" onClick="javascript:addFilter('instance');">
            <img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/addfilter.gif" width="97" height="19">
            </li>
        </ul>
        <%	}	%>
    </div>
</div>

</body>
</html>
