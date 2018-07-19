<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.uengine.ui.worklist.filter.WorkListFilterList"%>
<%@page import="org.uengine.ui.worklist.filter.WorkListFilter"%>
<%
	WorkListFilterList wfl = WorkListFilterList.load();
	WorkListFilter[] workitemFilters = wfl.getWorkItemFilters();
%>

<%@page import="org.uengine.util.UEngineUtil"%>
<script type="text/javascript">
/*remove add filter function*/
 /* 
	function addFilter(type){
		var url = "../commonfilter/dlgAddFilter.jsp?type="+type;
		window.open(url,'','top=100,left=100,width=600,height=300,resizable=true,scrollbars=yes');
	}
 */
	
	function deleteFilter(UID){
		result = confirm("Are you sure to delete this filter?");
		if(result==true){
			var url = "../commonfilter/deleteFilter.jsp?filterUID="+UID;
			window.open(url,'','top=100,left=100,width=600,height=300,resizable=true,scrollbars=yes');
		}
	}
 
 $(function() {	
	    $("#accordion").accordion({
	    	fillSpace: true
	    });
	});
</script>

<div style="width: 100%; height:100%; overflow: hidden; border:none; margin:0px; padding:0px;">
    <div class="menuList">
    <!--
		<h3><a href="#"><%=GlobalContext.getMessageForWeb("msg.Processes", loggedUserLocale)%></a></h3>
    -->
		<div>
        <ul>
            <li><a href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/wl2_instanceList.jsp?filtering=0&currentPage=1" target="innerworkarea"><%=GlobalContext.getMessageForWeb("Running Process", loggedUserLocale)%></a></li>
        </ul>
        <ul>
            <li><a href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/wl2_instanceList.jsp?filtering=1&currentPage=1" target="innerworkarea"><%=GlobalContext.getMessageForWeb("Completed Process", loggedUserLocale)%></a></li>
        </ul>
        <ul>
            <li><a href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/wl2_instanceList.jsp?filtering=2&currentPage=1" target="innerworkarea"><%=GlobalContext.getMessageForWeb("Stopped Process", loggedUserLocale)%></a></li>
        </ul>
        <ul>
            <li><a href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/wl2_instanceList.jsp?filtering=0&currentPage=1&p_initep=<%=loggedUserId%>" target="innerworkarea"><%=GlobalContext.getMessageForWeb("instlist.my_req_proc", loggedUserLocale)%></a></li>
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
		<ul>
            <li>
				<a href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/wl2_instanceList.jsp?filtering=<%=instanceFiltering%>&currentPage=1&processDefinition=<%=instanceDefId%>&endpointType=<%=instanceEndpointType%><%=instanceInfoParameter%>" target="innerworkarea"><%=workitemFilters[i].getFilterName()%></a>&nbsp;&nbsp;
		<%			if (loggedUserIsAdmin) {	%>
            	<img src="<%=GlobalContext.WEB_CONTEXT_ROOT%>/images/Common/b_smalldel.gif" width="29" height="11" onClick="javascript:deleteFilter('<%=workitemFilters[i].getFilterUId()%>')" style="cursor:pointer; right:15px; position:absolute; ">
		<%			}	%>
            </li>
        </ul>
		<%	}	}%>
		</div>
    </div>
</div>
