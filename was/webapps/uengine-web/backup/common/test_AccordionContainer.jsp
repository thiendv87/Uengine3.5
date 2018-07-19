<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp" %>
<%@include file="../common/getLoggedUser.jsp"%>
<%@page import="org.uengine.kernel.GlobalContext;"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>

</style>
</head>
<body class="tundra">
<div dojoType="dijit.layout.AccordionContainer" style="width: 100%; height:100%; overflow: hidden; border:none; margin:0px; padding:0px;">
    <div dojoType="dijit.layout.AccordionPane" title="개인업무함" class="menuList">
        <ul id="dojoList" >
            <li class="ico1"><a href="<%=GlobalContext.WEB_CONTEXT_ROOT %>/processparticipant/worklist/wl2_workList.jsp?linkNo=1&filtering=0&currentPage=1" target="innerworkarea">새로운 업무</a></li>
        </ul>
        <ul id="dojoList" >
            <li class="ico1"><a href="<%=GlobalContext.WEB_CONTEXT_ROOT %>/processparticipant/worklist/wl2_workList.jsp?linkNo=1&filtering=1&currentPage=1" target="innerworkarea">완료된 업무</a></li>
        </ul>
        <ul id="dojoList" >
            <li class="ico1"><a href="<%=GlobalContext.WEB_CONTEXT_ROOT %>/processparticipant/worklist/wl2_workList.jsp?linkNo=1&filtering=2&currentPage=1" target="innerworkarea">취소된 업무</a></li>
        </ul>
        <ul id="dojoList" >
            <li class="ico1"><a href="<%=GlobalContext.WEB_CONTEXT_ROOT %>/processparticipant/worklist/wl2_workList.jsp?linkNo=1&filtering=3&currentPage=1" target="innerworkarea">예약된 업무</a></li>
        </ul>
    </div>
    <div dojoType="dijit.layout.AccordionPane" title="참여 프로세스 " class="menuList">
        <ul id="dojoList" >
            <li class="ico1"><a href="<%=GlobalContext.WEB_CONTEXT_ROOT %>/processparticipant/worklist/wl2_instanceList.jsp?filtering=0&currentPage=1" target="innerworkarea">실행중인 프로세스</a></li>
        </ul>
        <ul id="dojoList" >
            <li class="ico1"><a href="<%=GlobalContext.WEB_CONTEXT_ROOT %>/processparticipant/worklist/wl2_instanceList.jsp?filtering=1&currentPage=1" target="innerworkarea">완료된 프로세스</a></li>
        </ul>
        <ul id="dojoList" >
            <li class="ico1"><a href="<%=GlobalContext.WEB_CONTEXT_ROOT %>/processparticipant/worklist/wl2_instanceList.jsp?filtering=1&currentPage=1" target="innerworkarea">중지된 프로세스</a></li>
        </ul>
    </div>
</div>

</body>
</html>
