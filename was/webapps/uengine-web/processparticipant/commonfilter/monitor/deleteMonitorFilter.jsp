<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../../common/header.jsp"%>
<%@include file="../../../common/getLoggedUser.jsp"%>
<%@page import="org.uengine.ui.monitor.filter.*"%>

<%
String  filterUID = request.getParameter("filterUID");
String  fileterType = request.getParameter("fileterType");

MonitorFilterList mfl = MonitorFilterList.load(loggedUserId);
mfl.deleteFilter(filterUID, loggedUserId);
%>
<html>
<head>
<title>Delete Filter</title>
<%@include file="../../../common/styleHeader.jsp"%>
<style TYPE="TEXT/CSS">
BODY {background:url(../../../processmanager/images/empty.gif) #ffffff }
</style>
</head>
<body>
<table width=100% height=100%>
	<tr>
		<td>
			<div class="portlet-msg-success">
				This filter has been successfully deleted
			</div>
		</td>
	<tr>
</table>	
</body>
</html>

<script>

	sendRedirectPage();
	
	function sendRedirectPage() {
		setTimeout("windowClose()", 1500);
	}

	function windowClose(){
		opener.location.reload();
		window.close();
	}
</script>