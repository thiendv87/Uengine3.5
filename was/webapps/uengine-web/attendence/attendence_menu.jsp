<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.uengine.ui.worklist.filter.WorkListFilterList"%>
<%@page import="org.uengine.ui.worklist.filter.WorkListFilter"%>
<%@page import="com.defaultcompany.web.acl.*"%>
<%
	WorkListFilterList wfl = WorkListFilterList.load();
	WorkListFilter[] workitemFilters = wfl.getWorkItemFilters();
%>

<%@page import="org.uengine.util.UEngineUtil"%>
<script type="text/javascript">
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
            <li><a href="attendenceList.jsp" target="innerworkarea"><%=GlobalContext.getMessageForWeb("subject_attendence", loggedUserLocale)%></a></li>
        </ul>
        <%if(sUserLevel.equals("companymanager")){ %>
        <ul>
            <li><a href="workPerfList.jsp" target="innerworkarea"><%=GlobalContext.getMessageForWeb("subject_workedrate", loggedUserLocale)%></a></li>
        </ul>
        <%} %>
		</div>
    </div>
</div>
