<%@ page language="java" contentType="text/html; charset=UTF-8"%>


<%@page import="org.uengine.ui.worklist.filter.*"%>

<link rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/en_US.css">
<link rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/bbs.css">
<link rel="stylesheet" type="text/css" href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/style/uengine.css">

<%
  WorkListFilterList wfl = WorkListFilterList.load();
  WorkListFilter[] workitemFilters= wfl.getWorkItemFilters();
  //WorkListFilter[] instanceFilters= wfl.getInstanceFilters();
  
  
  
  int linkNo = Integer.parseInt(reqMap.getString("linkNo", "0"));
  if("instance_view".equals(pageType)){
  	linkNo +=4;
  	linkNo +=workitemFilters.length  ;
  }  
%>
<table border="0" cellspacing="0" cellpadding="0">


<tr>
	<td nowrap ><img align="middle"  src="../../style/classic/images/trees/minus.png" >
	    <!--img align="middle"  src="../../style/classic/images/trees/page.png" -->
	    <a href="wl2_workList.jsp?filtering=0&currentPage=1">
	        <b><%=GlobalContext.getLocalizedMessageForWeb("workitem_view", loggedUserLocale, "WorkItem View") %>
	    </a>
	</td>
</tr>
<tr>
	<td nowrap>&nbsp;&nbsp;&nbsp;&nbsp;
	    <img align="middle"  src="../../style/classic/images/trees/page.png" >
	    <a href="wl2_workList.jsp?linkNo=0&filtering=0&currentPage=1">
	        <%=(linkNo==0) ? "<b>":""%><%=GlobalContext.getLocalizedMessageForWeb("new_work", loggedUserLocale, "Open") %>
	    </a>
	</td>
</tr>
<tr>
	<td nowrap>&nbsp;&nbsp;&nbsp;&nbsp;
	    <img align="middle"  src="../../style/classic/images/trees/page.png" >
	    <a href="wl2_workList.jsp?linkNo=1&filtering=1&currentPage=1">
	        <%=(linkNo==1) ? "<b>":""%><%=GlobalContext.getLocalizedMessageForWeb("completed_work", loggedUserLocale, "Completed") %>
	    </a>
	</td>
</tr>
<tr>
	<td nowrap>&nbsp;&nbsp;&nbsp;&nbsp;
	    <img align="middle"  src="../../style/classic/images/trees/page.png" >
	    <a href="wl2_workList.jsp?linkNo=2&filtering=2&currentPage=1">
		  <%=(linkNo==2) ? "<b>":""%><%=GlobalContext.getLocalizedMessageForWeb("cancelled_work", loggedUserLocale, "Cancelled") %>
		</a>
	</td>
</tr>
<tr>
	<td nowrap>&nbsp;&nbsp;&nbsp;&nbsp;
	    <img align="middle"  src="../../style/classic/images/trees/page.png" >
	    <a href="wl2_workList.jsp?linkNo=3&filtering=3&currentPage=1">
	       <%=(linkNo==3) ? "<b>":""%><%=GlobalContext.getLocalizedMessageForWeb("reserved_work", loggedUserLocale, "Reserved") %>
	    </a>
	 </td>
</tr>
<%
	for(int i=0 ; i<workitemFilters.length;i++){
	
		int filteringTmp=0;
		for(int j=0; j <filters.length;j++){
			if("Open".equals(workitemFilters[i].getStatus()))filteringTmp=0;
			if("Completed".equals(workitemFilters[i].getStatus()))filteringTmp=1;
			if("Cancelled".equals(workitemFilters[i].getStatus()))filteringTmp=2;
			if("Reserved".equals(workitemFilters[i].getStatus()))filteringTmp=3;
		}
%>
<tr>
	<td nowrap>&nbsp;&nbsp;&nbsp;&nbsp;
	    <img align="middle"  src="../../style/classic/images/trees/page.png" >
	    <a href="wl2_workList.jsp?processDefinition=<%=workitemFilters[i].getDefinition()%>&linkNo=<%=4+i%>&filtering=<%=filteringTmp%>&currentPage=1">
	       <%=(linkNo==4+i) ? "<b>":""%><%=workitemFilters[i].getFilterName() %>
	    </a> 
<%
	    if(loggedUserIsAdmin){
%>	    
	    <a href="javascript:deleteFilter('<%=workitemFilters[i].getFilterUId()%>')">
	       <img src="../../style/classic/images/portlet/close.png" width=10>
	    </a> 
<%
	    }
%>
	 </td>
</tr>
<%	
	}
	if(loggedUserIsAdmin){
%>
<tr>
	<td nowrap>&nbsp;&nbsp;&nbsp;&nbsp;
	    <img align="middle"  src="../../style/classic/images/trees/page.png" >
	    <a href="javascript:addFilter('workitem');">
	    	<b>Add Filter</b>
	    </a>
	 </td>
</tr>
<%
	}
%>
<tr>
	<td>&nbsp;</td>
</tr>
<tr>
	<td nowrap><img align="middle"  src="../../style/classic/images/trees/minus.png" >
	    <!--img align="middle"  src="../../style/classic/images/trees/page.png" -->
	    <a href="wl2_instanceList.jsp?filtering=0&currentPage=1">
	      <b><%=GlobalContext.getLocalizedMessageForWeb("process_view", loggedUserLocale, "Process View") %>
	    </a>
	</td>
</tr>
<tr>
	<td nowrap>&nbsp;&nbsp;&nbsp;&nbsp;
	    <img align="middle"  src="../../style/classic/images/trees/page.png" >
	    <a href="wl2_instanceList.jsp?filtering=0&currentPage=1">
	        <%=(linkNo==4+workitemFilters.length ) ? "<b>":""%><%=GlobalContext.getLocalizedMessageForWeb("in_progress", loggedUserLocale, "In Progress") %>
	    </a>
	</td>
</tr>
<tr>
	<td nowrap>&nbsp;&nbsp;&nbsp;&nbsp;
	    <img align="middle"  src="../../style/classic/images/trees/page.png" >
	    <a href="wl2_instanceList.jsp?filtering=1&currentPage=1">
	       <%=(linkNo==5+workitemFilters.length) ? "<b>":""%><%=GlobalContext.getLocalizedMessageForWeb("completed", loggedUserLocale, "Completed") %>
	    </a>
	</td>
</tr>
<tr>
	<td nowrap>&nbsp;&nbsp;&nbsp;&nbsp;
	    <img align="middle"  src="../../style/classic/images/trees/page.png" >
	    <a href="wl2_instanceList.jsp?filtering=2&currentPage=1"> 
	      <%=(linkNo==6+workitemFilters.length) ? "<b>":""%> <%=GlobalContext.getLocalizedMessageForWeb("stopped", loggedUserLocale, "Stopped") %>
	    </a>
	</td>
</tr>
<%
	if(loggedUserIsAdmin){
%>
<tr>
	<td nowrap>&nbsp;&nbsp;&nbsp;&nbsp;
	    <img align="middle"  src="../../style/classic/images/trees/page.png" >
	    <a href="javascript:addFilter('instance');">
	    	<b>Add Filter</b>
	    </a>
	 </td>
</tr>
<%
	}
%>
</table>

<script>
function addFilter(type){
	var url = "dlgAddFilter.jsp?type="+type;
	window.open(url,'','top=100,left=100,width=600,height=300,resizable=true,scrollbars=yes');
}

function deleteFilter(UID){
	result = confirm("Are you sure to delete this filter?");
	if(result==true){
		var url = "deleteFilter.jsp?filterUID="+UID;
		window.open(url,'','top=100,left=100,width=600,height=300,resizable=true,scrollbars=yes');
	}
}
</script>


