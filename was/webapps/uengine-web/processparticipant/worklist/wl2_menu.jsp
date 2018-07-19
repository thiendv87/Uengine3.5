<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.uengine.ui.worklist.filter.WorkListFilterList"%>
<%@page import="org.uengine.ui.worklist.filter.WorkListFilter"%>
<%
	//WorkListFilterList wfl = WorkListFilterList.load();
	//WorkListFilter[] workitemFilters = wfl.getWorkItemFilters();
%>
<%@page import="org.uengine.util.UEngineUtil"%>
<script type="text/javascript">
/*remove Add filter*/
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
	<!-- accordion title 제거
	<h3><a href="#"><%=GlobalContext.getMessageForWeb("msg.work_items", loggedUserLocale)%></a></h3>
	-->
		<div>
			<ul>
		    	<li><a href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/wl2_workList.jsp?filtering=0&currentPage=1" target="innerworkarea"><%=GlobalContext.getMessageForWeb("msg.open", loggedUserLocale)%></a></li>
			</ul>
			<ul>
		    	<li><a href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/wl2_workList.jsp?filtering=5&currentPage=1" target="innerworkarea"><%=GlobalContext.getMessageForWeb("msg.save", loggedUserLocale)%></a></li>
			</ul>
			<ul>
		    	<li><a href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/wl2_workList.jsp?filtering=1&currentPage=1" target="innerworkarea"><%=GlobalContext.getMessageForWeb("msg.Closed", loggedUserLocale)%></a></li>
			</ul>
			<ul>
		    	<li><a href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/wl2_workList.jsp?filtering=2&currentPage=1" target="innerworkarea"><%=GlobalContext.getMessageForWeb("msg.Cancelled", loggedUserLocale)%></a></li>
			</ul>
			<ul>
		    	<li><a href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/wl2_workList.jsp?filtering=3&currentPage=1" target="innerworkarea"><%=GlobalContext.getMessageForWeb("msg.Reserved", loggedUserLocale)%></a></li>
			</ul>
			<ul>
		    	<li><a href="<%=GlobalContext.WEB_CONTEXT_ROOT%>/processparticipant/worklist/wl2_workList.jsp?filtering=4&currentPage=1" target="innerworkarea"><%=GlobalContext.getMessageForWeb("msg.Time Over", loggedUserLocale)%></a></li>
			</ul>
		</div>
	</div>
</div>