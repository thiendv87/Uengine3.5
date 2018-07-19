<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../../common/header.jsp"%>
<%@include file="../../../common/getLoggedUser.jsp"%>
<%@page import="org.uengine.ui.monitor.filter.*"%>
<%
    String  filterName = decode(request.getParameter("filterName"));
    String  definition = request.getParameter("processDefinition");
    String  definitionName = request.getParameter("processDefName");
    String  status = request.getParameter("status");
    String  tagText = request.getParameter("tagText");
    String  partCode = request.getParameter("selectPartCode");
    String  roleCode = request.getParameter("roleCode");
    
    MonitorFilter mf = new MonitorFilter(filterName);
    mf.setStatus(status);
    mf.setDefinition(definition);
    mf.setDefinitionName(definitionName);
    mf.setTag(tagText);
    mf.setPartCode(partCode);
    mf.setRoleCode(roleCode);

    MonitorFilterList mfl = MonitorFilterList.load(loggedUserId);
    mfl.setMonitorFilters(mf);
    MonitorFilterList.save(mfl, loggedUserId);   

    
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Save Filter</title>
<%@include file="../../../common/styleHeader.jsp"%>
<style type="text/css">
    body {background:url(../../../processmanager/images/empty.gif) #ffffff }
</style>
</head>
<body>
<table width=100% height=100%>
    <tr>
        <td>
        <div class="portlet-msg-success">
            This filter has been successfully saved
        </div>
        </td>
    <tr>
</table>
<script type="text/javascript">
<!--
sendRedirectPage();

function sendRedirectPage() {
    setTimeout("windowClose()", 1500);
}

function windowClose(){
    opener.location.reload();
    window.close();
}
//-->
</script>
</body>
</html>